Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B45151D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379521AbiD2R3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378319AbiD2R3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986E98F6B
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XGk4D40/83Mk2b0xnEMti2TPyZ0SXFmKONNwBKO+QXQ=; b=RbMRdyntGiYhSBvJF0sn5L4M1s
        bQJTtWuh7pocQ24MIRgCiUEvkC9c90vXjVoIivP4OxI4h6y9MisVH3tTX3e30dF7cTjty+yK67XIm
        PtCvwVQsn2BgsyauWLvYt1wp7Jx6FvYRC1+udI+/EReQECvq7a9gFD47pMFMj3C5HTWuRnTsFAd+/
        AbPuhnrWeLiT7iwC2CXVG/J/k3aqlHAY53UiJ94HMAjJpVMHGqPZCd4VbLDO7tGBLAzb55wUC5xX/
        /7zv1XAVvxymEv0RV/QhCY4JdVo4KxCduuNTpwtTmi7WomI1Lau9t/0iS0pZe14JOFvV+IU5abVb3
        f/ykBLHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNX-00CdXi-4F; Fri, 29 Apr 2022 17:26:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/69] fs: Remove aop_flags parameter from netfs_write_begin()
Date:   Fri, 29 Apr 2022 18:24:58 +0100
Message-Id: <20220429172556.3011843-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

