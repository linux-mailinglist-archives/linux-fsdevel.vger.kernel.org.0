Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8533C4C0259
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiBVTtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7A6B91FC
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WN0bUa4fDtMYKLjeS8cQJy/WZFq6Op3TstO0v47kcQY=; b=IhxrO6z/cZNXc3WxW1IK18yfMx
        ooTGj0OUIoNM27GeFM5T6LwOakPIttu+4ldyLKq/yAkhkI506xVSrD+szKW0fFM0ry1t2qjl2MdtQ
        nlJQ6kqDG5xjn9swz2sBC7eUYMtcRfkvNZ44HOV9uMdcPzrYScvJKA3B0p3qLaizBPWV08vilyOAT
        tnoOcuG0TBYnOBymA5lUisOWkeEBWwsucjlwqmPf8Ydqab9qNjJ6QmQAbro+LFa14AYFMzWZVMX6j
        hEO4UvHQzy/5/Bd4m4qwWMkm8BfGYk8GNdxU9GtSjCovetI359l9nAWJPdXoO4jn46+AulLITDhoX
        lIbnuzgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb96-00360Z-NF; Tue, 22 Feb 2022 19:48:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/22] fs: Remove aop_flags parameter from netfs_write_begin()
Date:   Tue, 22 Feb 2022 19:48:13 +0000
Message-Id: <20220222194820.737755-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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
---
 Documentation/filesystems/netfs_library.rst | 1 -
 fs/9p/vfs_addr.c                            | 2 +-
 fs/afs/write.c                              | 2 +-
 fs/ceph/addr.c                              | 2 +-
 fs/netfs/read_helper.c                      | 6 ++----
 include/linux/netfs.h                       | 2 +-
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4f373a8ec47b..9e0390c9e679 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -81,7 +81,6 @@ Three read helpers are provided::
 			      struct address_space *mapping,
 			      loff_t pos,
 			      unsigned int len,
-			      unsigned int flags,
 			      struct folio **_folio,
 			      void **_fsdata,
 			      const struct netfs_read_request_ops *ops,
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 76956c9d2af9..0eece6974a3f 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -308,7 +308,7 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	retval = netfs_write_begin(filp, mapping, pos, len, flags, &folio, fsdata,
+	retval = netfs_write_begin(filp, mapping, pos, len, &folio, fsdata,
 				   &v9fs_req_ops, NULL);
 	if (retval < 0)
 		return retval;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 88861613734e..986e97866e16 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -60,7 +60,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	ret = netfs_write_begin(file, mapping, pos, len, flags, &folio, fsdata,
+	ret = netfs_write_begin(file, mapping, pos, len, &folio, fsdata,
 				&afs_req_ops, NULL);
 	if (ret < 0)
 		return ret;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3a2b98efebf5..09f27d1d7fec 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1311,7 +1311,7 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 		goto out;
 	}
 
-	r = netfs_write_begin(file, inode->i_mapping, pos, len, 0, &folio, NULL,
+	r = netfs_write_begin(file, inode->i_mapping, pos, len, &folio, NULL,
 			      &ceph_netfs_read_ops, NULL);
 out:
 	if (r == 0)
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index de0dfb37746b..439e83dc2a02 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1048,7 +1048,6 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len)
  * @mapping: The mapping to read from
  * @pos: File position at which the write will begin
  * @len: The length of the write (may extend beyond the end of the folio chosen)
- * @aop_flags: AOP_* flags
  * @_folio: Where to put the resultant folio
  * @_fsdata: Place for the netfs to store a cookie
  * @ops: The network filesystem's operations for the helper to use
@@ -1074,9 +1073,8 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len)
  * This is usable whether or not caching is enabled.
  */
 int netfs_write_begin(struct file *file, struct address_space *mapping,
-		      loff_t pos, unsigned int len, unsigned int aop_flags,
-		      struct folio **_folio, void **_fsdata,
-		      const struct netfs_read_request_ops *ops,
+		      loff_t pos, unsigned int len, struct folio **_folio,
+		      void **_fsdata, const struct netfs_read_request_ops *ops,
 		      void *netfs_priv)
 {
 	struct netfs_read_request *rreq;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 614f22213e21..8e10aef2565d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -262,7 +262,7 @@ extern int netfs_readpage(struct file *,
 			  const struct netfs_read_request_ops *,
 			  void *);
 extern int netfs_write_begin(struct file *, struct address_space *,
-			     loff_t, unsigned int, unsigned int, struct folio **,
+			     loff_t, unsigned int, struct folio **,
 			     void **,
 			     const struct netfs_read_request_ops *,
 			     void *);
-- 
2.34.1

