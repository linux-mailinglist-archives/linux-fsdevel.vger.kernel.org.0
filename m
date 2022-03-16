Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4844DB132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356263AbiCPNUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356343AbiCPNTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:19:45 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D82A267;
        Wed, 16 Mar 2022 06:17:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V7NDHDT_1647436674;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V7NDHDT_1647436674)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 21:17:55 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: [PATCH v5 21/22] erofs: implement fscache-based data readahead
Date:   Wed, 16 Mar 2022 21:17:22 +0800
Message-Id: <20220316131723.111553-22-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements fscache-based data readahead. Also registers an
individual bdi for each erofs instance to enable readahead.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/super.c   |   4 ++
 2 files changed, 157 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 82c52b6e077e..913ca891deb9 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -10,6 +10,13 @@ struct erofs_fscache_map {
 	u64 m_llen;
 };
 
+struct erofs_fscahce_ra_ctx {
+	struct readahead_control *rac;
+	struct address_space *mapping;
+	loff_t start;
+	size_t len, done;
+};
+
 static struct fscache_volume *volume;
 
 /*
@@ -199,12 +206,158 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+static inline size_t erofs_fscache_calc_len(struct erofs_fscahce_ra_ctx *ractx,
+					    struct erofs_fscache_map *fsmap)
+{
+	/*
+	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
+	 * nearest chunk boundary, and the output m_llen actually starts from
+	 * the start of the containing chunk.
+	 * 2) For other cases, the output m_la is equal to o_la.
+	 */
+	size_t len = fsmap->m_llen - (fsmap->o_la - fsmap->m_la);
+
+	return min_t(size_t, len, ractx->len - ractx->done);
+}
+
+static inline void erofs_fscache_unlock_pages(struct readahead_control *rac,
+					      size_t len)
+{
+	while (len) {
+		struct page *page = readahead_page(rac);
+
+		SetPageUptodate(page);
+		unlock_page(page);
+		put_page(page);
+
+		len -= PAGE_SIZE;
+	}
+}
+
+static int erofs_fscache_ra_hole(struct erofs_fscahce_ra_ctx *ractx,
+				 struct erofs_fscache_map *fsmap)
+{
+	struct iov_iter iter;
+	loff_t start = ractx->start + ractx->done;
+	size_t length = erofs_fscache_calc_len(ractx, fsmap);
+
+	iov_iter_xarray(&iter, READ, &ractx->mapping->i_pages, start, length);
+	iov_iter_zero(length, &iter);
+
+	erofs_fscache_unlock_pages(ractx->rac, length);
+	return length;
+}
+
+static int erofs_fscache_ra_noinline(struct erofs_fscahce_ra_ctx *ractx,
+				     struct erofs_fscache_map *fsmap)
+{
+	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
+	loff_t start = ractx->start + ractx->done;
+	size_t length = erofs_fscache_calc_len(ractx, fsmap);
+	loff_t pstart = fsmap->m_pa + (fsmap->o_la - fsmap->m_la);
+	int ret;
+
+	ret = erofs_fscache_read_pages(cookie, ractx->mapping,
+				       start, length, pstart);
+	if (!ret) {
+		erofs_fscache_unlock_pages(ractx->rac, length);
+		ret = length;
+	}
+
+	return ret;
+}
+
+static int erofs_fscache_ra_inline(struct erofs_fscahce_ra_ctx *ractx,
+				   struct erofs_fscache_map *fsmap)
+{
+	struct page *page = readahead_page(ractx->rac);
+	int ret;
+
+	ret = erofs_fscache_readpage_inline(page, fsmap);
+	if (!ret) {
+		SetPageUptodate(page);
+		ret = PAGE_SIZE;
+	}
+
+	unlock_page(page);
+	put_page(page);
+	return ret;
+}
+
+static void erofs_fscache_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct erofs_fscahce_ra_ctx ractx;
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
+	ractx = (struct erofs_fscahce_ra_ctx) {
+		.rac = rac,
+		.mapping = rac->mapping,
+		.start = readahead_pos(rac),
+		.len = readahead_length(rac),
+	};
+
+	do {
+		struct erofs_map_blocks map;
+		struct erofs_fscache_map fsmap;
+
+		map.m_la = fsmap.o_la = ractx.start + ractx.done;
+
+		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+		if (ret)
+			return;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			/*
+			 * Two cases will hit this:
+			 * 1) EOF. Imposibble in readahead routine;
+			 * 2) hole. Only CHUNK_BASED layout supports hole.
+			 */
+			fsmap.m_la   = map.m_la;
+			fsmap.m_llen = map.m_llen;
+			ret = erofs_fscache_ra_hole(&ractx, &fsmap);
+			continue;
+		}
+
+		ret = erofs_fscache_get_map(&fsmap, &map, sb);
+		if (ret)
+			return;
+
+		if (map.m_flags & EROFS_MAP_META) {
+			ret = erofs_fscache_ra_inline(&ractx, &fsmap);
+			continue;
+		}
+
+		switch (vi->datalayout) {
+		case EROFS_INODE_FLAT_PLAIN:
+		case EROFS_INODE_FLAT_INLINE:
+		case EROFS_INODE_CHUNK_BASED:
+			ret = erofs_fscache_ra_noinline(&ractx, &fsmap);
+			break;
+		default:
+			DBG_BUGON(1);
+			return;
+		}
+	} while (ret > 0 && ((ractx.done += ret) < ractx.len));
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 	.readpage = erofs_fscache_readpage_blob,
 };
 
 const struct address_space_operations erofs_fscache_access_aops = {
 	.readpage = erofs_fscache_readpage,
+	.readahead = erofs_fscache_readahead,
 };
 
 struct page *erofs_fscache_read_cache_page(struct erofs_fscache_context *ctx,
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f058a04a00c7..2942029a7049 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -616,6 +616,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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

