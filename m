Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03D51F137
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiEHUeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiEHUdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65579E006
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XGk4D40/83Mk2b0xnEMti2TPyZ0SXFmKONNwBKO+QXQ=; b=A00SirJtJgZ0jj239+Q4w/FbcR
        N0/dPQCkBJDhe+UMCBpcFMDsFLgZTJ4YebFgfjqfak3g7LD13Vs0NyTSrwhUwheSOlSCb2+VkWZ9E
        YgnetXUHUgCU5BRvnwH66a8L9wP381toIOsvGD73tLNOqWJSX92yEnHlPKXDw3UFeBbLpvPQ6LxB4
        HOcNve69z0DmvDwA9Zlv2JyRxeNmbqGnpjakhDC+gY/w7gHSVQ/nOyQmYw7NFqEn23ODEaHcU7/hF
        cxFxWfyQJdVey3+iZuT4c3kLXhyAQKf5+Dc/Qc7Ko5JsulDCJzydIGZspZBH0nYN/vuie2mApkr+9
        RsK/Xeng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXS-002nYM-KS; Sun, 08 May 2022 20:29:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/25] fs: Remove aop_flags parameter from netfs_write_begin()
Date:   Sun,  8 May 2022 21:29:26 +0100
Message-Id: <20220508202941.667024-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no more aop flags left, so remove the parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/netfs_library.rst | 1 -
 fs/9p/vfs_addr.c                            | 2 +-
 fs/afs/write.c                              | 2 +-
 fs/ceph/addr.c                              | 2 +-
 fs/netfs/buffered_read.c                    | 4 ++--
 include/linux/netfs.h                       | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 69f00179fdfe..d51c2a5ccf57 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -142,7 +142,6 @@ Three read helpers are provided::
 			      struct address_space *mapping,
 			      loff_t pos,
 			      unsigned int len,
-			      unsigned int flags,
 			      struct folio **_folio,
 			      void **_fsdata);
 
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 501128188343..d311e68e21fd 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -275,7 +275,7 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	retval = netfs_write_begin(filp, mapping, pos, len, flags, &folio, fsdata);
+	retval = netfs_write_begin(filp, mapping, pos, len, &folio, fsdata);
 	if (retval < 0)
 		return retval;
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 4763132ca57e..af496c98d394 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -60,7 +60,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	ret = netfs_write_begin(file, mapping, pos, len, flags, &folio, fsdata);
+	ret = netfs_write_begin(file, mapping, pos, len, &folio, fsdata);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index aa25bffd4823..415f0886bc25 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1318,7 +1318,7 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 	struct folio *folio = NULL;
 	int r;
 
-	r = netfs_write_begin(file, inode->i_mapping, pos, len, 0, &folio, NULL);
+	r = netfs_write_begin(file, inode->i_mapping, pos, len, &folio, NULL);
 	if (r == 0)
 		folio_wait_fscache(folio);
 	if (r < 0) {
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 65c17c5a5567..1d44509455a5 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -328,8 +328,8 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
  * This is usable whether or not caching is enabled.
  */
 int netfs_write_begin(struct file *file, struct address_space *mapping,
-		      loff_t pos, unsigned int len, unsigned int aop_flags,
-		      struct folio **_folio, void **_fsdata)
+		      loff_t pos, unsigned int len, struct folio **_folio,
+		      void **_fsdata)
 {
 	struct netfs_io_request *rreq;
 	struct netfs_i_context *ctx = netfs_i_context(file_inode(file ));
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c7bf1eaf51d5..1c29f317d907 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -276,7 +276,7 @@ struct readahead_control;
 extern void netfs_readahead(struct readahead_control *);
 extern int netfs_readpage(struct file *, struct page *);
 extern int netfs_write_begin(struct file *, struct address_space *,
-			     loff_t, unsigned int, unsigned int, struct folio **,
+			     loff_t, unsigned int, struct folio **,
 			     void **);
 
 extern void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
-- 
2.34.1

