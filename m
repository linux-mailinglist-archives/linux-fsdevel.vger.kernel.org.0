Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D374AE9F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 07:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiBIGFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 01:05:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiBIGBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:52 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B78C05CBA7;
        Tue,  8 Feb 2022 22:01:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3zeEdM_1644386488;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V3zeEdM_1644386488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 14:01:29 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/22] erofs: implement fscache-based data read for non-inline layout
Date:   Wed,  9 Feb 2022 14:01:01 +0800
Message-Id: <20220209060108.43051-16-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements the data plane of reading data from bootstrap blob
file over fscache for non-inline layout.

Be noted that compressed layout is not supported yet.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 94 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  6 ++-
 fs/erofs/internal.h |  1 +
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index a29d2ecff58b..82fdde054b0b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -4,6 +4,12 @@
  */
 #include "internal.h"
 
+struct erofs_fscache_map {
+	struct erofs_fscache_context *m_ctx;
+	erofs_off_t m_pa, m_la, o_la;
+	u64 m_llen;
+};
+
 static struct fscache_volume *volume;
 
 static int erofs_fscache_read_page(struct fscache_cookie *cookie,
@@ -58,10 +64,98 @@ static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
 	return ret;
 }
 
+static inline int erofs_fscache_get_map(struct erofs_fscache_map *fsmap,
+					struct erofs_map_blocks *map,
+					struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	fsmap->m_ctx  = sbi->bootstrap;
+	fsmap->m_la   = map->m_la;
+	fsmap->m_pa   = map->m_pa;
+	fsmap->m_llen = map->m_llen;
+
+	return 0;
+}
+
+static int erofs_fscache_readpage_noinline(struct page *page,
+					   struct erofs_fscache_map *fsmap)
+{
+	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
+	/*
+	 * 1) For FLAT_PLAIN layout, the output map.m_la shall be equal to o_la,
+	 * and the output map.m_pa is exactly the physical address of o_la.
+	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
+	 * nearest chunk boundary, and the output map.m_pa is actually the
+	 * physical address of this chunk boundary. So we need to recalculate
+	 * the actual physical address of o_la.
+	 */
+	loff_t start = fsmap->m_pa + fsmap->o_la - fsmap->m_la;
+
+	return erofs_fscache_read_page(cookie, page, start);
+}
+
+static int erofs_fscache_do_readpage(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct erofs_map_blocks map;
+	struct erofs_fscache_map fsmap;
+	int ret;
+
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		erofs_info(sb, "compressed layout not supported yet");
+		return -EOPNOTSUPP;
+	}
+
+	map.m_la = fsmap.o_la = page_offset(page);
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		return ret;
+
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		zero_user(page, 0, PAGE_SIZE);
+		return 0;
+	}
+
+	ret = erofs_fscache_get_map(&fsmap, &map, sb);
+	if (ret)
+		return ret;
+
+	switch (vi->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
+		return erofs_fscache_readpage_noinline(page, &fsmap);
+	default:
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+}
+
+static int erofs_fscache_readpage(struct file *file, struct page *page)
+{
+	int ret;
+
+	ret = erofs_fscache_do_readpage(page);
+	if (ret)
+		SetPageError(page);
+	else
+		SetPageUptodate(page);
+
+	unlock_page(page);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 	.readpage = erofs_fscache_readpage_blob,
 };
 
+const struct address_space_operations erofs_fscache_access_aops = {
+	.readpage = erofs_fscache_readpage,
+};
+
 struct page *erofs_fscache_read_cache_page(struct erofs_fscache_context *ctx,
 					   pgoff_t index)
 {
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ff62f84f47d3..2f450cb3a7b9 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -296,7 +296,11 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 		err = z_erofs_fill_inode(inode);
 		goto out_unlock;
 	}
-	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+
+	if (erofs_bdev_mode(inode->i_sb))
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	else
+		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 
 out_unlock:
 	erofs_put_metabuf(&buf);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index fca706cfaf72..548f928b0ded 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -393,6 +393,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
+extern const struct address_space_operations erofs_fscache_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
 /*
-- 
2.27.0

