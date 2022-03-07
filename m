Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302154CFED7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbiCGMfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 07:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbiCGMfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:35:02 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2356424B2;
        Mon,  7 Mar 2022 04:33:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V6VlXz9_1646656410;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V6VlXz9_1646656410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:33:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/21] erofs: implement fscache-based data read for inline layout
Date:   Mon,  7 Mar 2022 20:33:01 +0800
Message-Id: <20220307123305.79520-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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

This patch implements the data plane of reading data from bootstrap blob
file over fscache for inline layout.

For the heading non-inline part, the data plane for non-inline layout is
resued, while only the tail packing part needs special handling.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ff69698948ad..4da148cc4484 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -85,8 +85,9 @@ static int erofs_fscache_readpage_noinline(struct page *page,
 {
 	struct fscache_cookie *cookie = fsmap->m_ctx->cookie;
 	/*
-	 * 1) For FLAT_PLAIN layout, the output map.m_la shall be equal to o_la,
-	 * and the output map.m_pa is exactly the physical address of o_la.
+	 * 1) For FLAT_PLAIN and FLAT_INLINE (the heading non tail packing part)
+	 * layout, the output map.m_la shall be equal to o_la, and the output
+	 * map.m_pa is exactly the physical address of o_la.
 	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
 	 * nearest chunk boundary, and the output map.m_pa is actually the
 	 * physical address of this chunk boundary. So we need to recalculate
@@ -97,6 +98,40 @@ static int erofs_fscache_readpage_noinline(struct page *page,
 	return erofs_fscache_read_page(cookie, page, start);
 }
 
+static int erofs_fscache_readpage_inline(struct page *page,
+					 struct erofs_fscache_map *fsmap)
+{
+	struct inode *inode = page->mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	erofs_blk_t blknr;
+	size_t offset, len;
+	void *src, *dst;
+
+	/*
+	 * For inline (tail packing) layout, the offset may be non-zero, which
+	 * can be calculated from corresponding physical address directly.
+	 * Currently only flat layout supports inline (FLAT_INLINE), and the
+	 * output map.m_pa is exactly the physical address of o_la in this case.
+	 */
+	offset = erofs_blkoff(fsmap->m_pa);
+	blknr = erofs_blknr(fsmap->m_pa);
+	len = fsmap->m_llen;
+
+	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
+	if (IS_ERR(src))
+		return PTR_ERR(src);
+
+	dst = kmap(page);
+	memcpy(dst, src + offset, len);
+	memset(dst + len, 0, PAGE_SIZE - len);
+	kunmap(page);
+
+	erofs_put_metabuf(&buf);
+
+	return 0;
+}
+
 static int erofs_fscache_do_readpage(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
@@ -126,8 +161,12 @@ static int erofs_fscache_do_readpage(struct page *page)
 	if (ret)
 		return ret;
 
+	if (map.m_flags & EROFS_MAP_META)
+		return erofs_fscache_readpage_inline(page, &fsmap);
+
 	switch (vi->datalayout) {
 	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
 	case EROFS_INODE_CHUNK_BASED:
 		return erofs_fscache_readpage_noinline(page, &fsmap);
 	default:
-- 
2.27.0

