Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1384E7337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354835AbiCYMZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359097AbiCYMYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:50 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA06BE6;
        Fri, 25 Mar 2022 05:23:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89zY52_1648210976;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89zY52_1648210976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:57 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v6 21/22] erofs: implement fscache-based data readahead
Date:   Fri, 25 Mar 2022 20:22:22 +0800
Message-Id: <20220325122223.102958-22-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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

Implements fscache-based data readahead. Also registers an individual
bdi for each erofs instance to enable readahead.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c   |   4 ++
 2 files changed, 118 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index cbb39657615e..589d1e7c2b1b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -191,12 +191,126 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+static inline size_t erofs_fscache_calc_len(struct erofs_map_blocks *map,
+					    size_t len, size_t done)
+{
+	/*
+	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
+	 * nearest chunk boundary, and the output m_llen actually starts from
+	 * the start of the containing chunk.
+	 * 2) For other cases, the output m_la is equal to o_la.
+	 */
+	size_t length = map->m_llen - (map->o_la - map->m_la);
+
+	return min_t(size_t, length, len - done);
+}
+
+static inline void erofs_fscache_unlock_folios(struct readahead_control *rac,
+					       size_t len)
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
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	size_t len, done = 0;
+	loff_t start;
+	int ret;
+
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		erofs_info(sb, "compressed layout not supported yet");
+		return;
+	}
+
+	if (!readahead_count(rac))
+		return;
+
+	start = readahead_pos(rac);
+	len = readahead_length(rac);
+
+	do {
+		struct erofs_map_blocks map;
+
+		map.m_la = map.o_la = start + done;
+
+		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+		if (ret)
+			return;
+
+		/* Read-ahead Hole
+		 * Two cases will hit this:
+		 * 1) EOF. Imposibble in readahead routine;
+		 * 2) hole. Only CHUNK_BASED layout supports hole.
+		 */
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			struct iov_iter iter;
+			loff_t offset = start + done;
+			size_t count = erofs_fscache_calc_len(&map, len, done);
+
+			iov_iter_xarray(&iter, READ, &rac->mapping->i_pages, offset, count);
+			iov_iter_zero(count, &iter);
+
+			erofs_fscache_unlock_folios(rac, count);
+			ret = count;
+			continue;
+		}
+
+		ret = erofs_fscache_get_map(&map, sb);
+		if (ret)
+			return;
+
+		/* Read-ahead Inline */
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
+		/* Read-ahead No-inline */
+		if (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
+		    vi->datalayout == EROFS_INODE_FLAT_INLINE ||
+		    vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+			struct fscache_cookie *cookie = map.m_fscache->cookie;
+			loff_t offset = start + done;
+			size_t count = erofs_fscache_calc_len(&map, len, done);
+			loff_t pstart = map.m_pa + (map.o_la - map.m_la);
+
+			ret = erofs_fscache_read_folios(cookie, rac->mapping,
+					offset, count, pstart);
+			if (!ret) {
+				erofs_fscache_unlock_folios(rac, count);
+				ret = count;
+			}
+		} else {
+			DBG_BUGON(1);
+			return;
+		}
+	} while (ret > 0 && ((done += ret) < len));
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 	.readpage = erofs_fscache_readpage_blob,
 };
 
 const struct address_space_operations erofs_fscache_access_aops = {
 	.readpage = erofs_fscache_readpage,
+	.readahead = erofs_fscache_readahead,
 };
 
 /*
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9a6f35e0c22b..8ac400581784 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -619,6 +619,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return PTR_ERR(bootstrap);
 
 		sbi->bootstrap = bootstrap;
+
+		err = super_setup_bdi(sb);
+		if (err)
+			return err;
 	}
 
 	err = erofs_read_superblock(sb);
-- 
2.27.0

