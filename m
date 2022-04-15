Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0E0502A30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353733AbiDOMj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353674AbiDOMjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:39:31 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7D3C90C1;
        Fri, 15 Apr 2022 05:36:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VA7VPV2_1650026207;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VA7VPV2_1650026207)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 20:36:48 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: [PATCH v9 20/21] erofs: implement fscache-based data readahead
Date:   Fri, 15 Apr 2022 20:36:13 +0800
Message-Id: <20220415123614.54024-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement fscache-based data readahead. Also registers an individual
bdi for each erofs instance to enable readahead.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c   |  4 +++
 2 files changed, 90 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 08849c15500f..eaa50692ddba 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -163,12 +163,98 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+static void erofs_fscache_unlock_folios(struct readahead_control *rac,
+					size_t len)
+{
+	while (len) {
+		struct folio *folio = readahead_folio(rac);
+
+		len -= folio_size(folio);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+	}
+}
+
+static void erofs_fscache_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	struct super_block *sb = inode->i_sb;
+	size_t len, count, done = 0;
+	erofs_off_t pos;
+	loff_t start, offset;
+	int ret;
+
+	if (!readahead_count(rac))
+		return;
+
+	start = readahead_pos(rac);
+	len = readahead_length(rac);
+
+	do {
+		struct erofs_map_blocks map;
+		struct erofs_map_dev mdev;
+
+		pos = start + done;
+		map.m_la = pos;
+
+		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+		if (ret)
+			return;
+
+		offset = start + done;
+		count = min_t(size_t, map.m_llen - (pos - map.m_la),
+			      len - done);
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			struct iov_iter iter;
+
+			iov_iter_xarray(&iter, READ, &rac->mapping->i_pages,
+					offset, count);
+			iov_iter_zero(count, &iter);
+
+			erofs_fscache_unlock_folios(rac, count);
+			ret = count;
+			continue;
+		}
+
+		if (map.m_flags & EROFS_MAP_META) {
+			struct folio *folio = readahead_folio(rac);
+
+			ret = erofs_fscache_readpage_inline(folio, &map);
+			if (!ret) {
+				folio_mark_uptodate(folio);
+				ret = folio_size(folio);
+			}
+
+			folio_unlock(folio);
+			continue;
+		}
+
+		mdev = (struct erofs_map_dev) {
+			.m_deviceid = map.m_deviceid,
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(sb, &mdev);
+		if (ret)
+			return;
+
+		ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
+				rac->mapping, offset, count,
+				mdev.m_pa + (pos - map.m_la));
+		if (!ret) {
+			erofs_fscache_unlock_folios(rac, count);
+			ret = count;
+		}
+	} while (ret > 0 && ((done += ret) < len));
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
 	.readpage = erofs_fscache_meta_readpage,
 };
 
 const struct address_space_operations erofs_fscache_access_aops = {
 	.readpage = erofs_fscache_readpage,
+	.readahead = erofs_fscache_readahead,
 };
 
 /*
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c6755bcae4a6..f68ba929100d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -619,6 +619,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 						    sbi->opt.fsid, true);
 		if (err)
 			return err;
+
+		err = super_setup_bdi(sb);
+		if (err)
+			return err;
 	} else {
 		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 			erofs_err(sb, "failed to set erofs blksize");
-- 
2.27.0

