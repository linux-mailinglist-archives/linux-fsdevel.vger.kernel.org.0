Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6A4DD6F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 10:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiCRJUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiCRJUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64F211EC7A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647595129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Hj6lp9cb+j/tPgdExJZow6f3VrKM4A02J6ZV/TYS3U=;
        b=RD2E0uJA+evTXgeJBn2djBsd/5WDy9Lw1uQI/+xYPE8LXRrtAifMwqYvPnxCgqPwLnfOcA
        Ls7BfyUHUZ+8Uc/dIEH81AbeDarE7neKduS/seJX1VGVzojeaHJyuitCioCUHWPDaU/1AH
        /3gu/wbYS4hVS4OVbNl+UTsXUPRH/vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-gamC1ELSObafAry468Xllw-1; Fri, 18 Mar 2022 05:18:48 -0400
X-MC-Unique: gamC1ELSObafAry468Xllw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66F3C180075C;
        Fri, 18 Mar 2022 09:18:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D4EC50943;
        Fri, 18 Mar 2022 09:18:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164692909854.2099075.9535537286264248057.stgit@warthog.procyon.org.uk>
References: <164692909854.2099075.9535537286264248057.stgit@warthog.procyon.org.uk> <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/20] netfs: Add a netfs inode context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <306387.1647595110.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 18 Mar 2022 09:18:30 +0000
Message-ID: <306388.1647595110@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a netfs_i_context struct that should be included in the network
filesystem's own inode struct wrapper, directly after the VFS's inode
struct, e.g.:

        struct my_inode {
                struct {
                        /* These must be contiguous */
                        struct inode            vfs_inode;
                        struct netfs_i_context  netfs_ctx;
                };
        };

The netfs_i_context struct so far contains a single field for the network
filesystem to use - the cache cookie:

        struct netfs_i_context {
                ...
                struct fscache_cookie   *cache;
        };

Three functions are provided to help with this:

 (1) void netfs_i_context_init(struct inode *inode,
                               const struct netfs_request_ops *ops);

     Initialise the netfs context and set the operations.

 (2) struct netfs_i_context *netfs_i_context(struct inode *inode);

     Find the netfs context from the VFS inode.

 (3) struct inode *netfs_inode(struct netfs_i_context *ctx);

     Find the VFS inode from the netfs context.

Changes
=3D=3D=3D=3D=3D=3D=3D
ver #4)
 - Fix netfs_is_cache_enabled() to check cookie->cache_priv to see if a
   cache is present[3].
 - Fix netfs_skip_folio_read() to zero out all of the page, not just some
   of it[3].

ver #3)
 - Split out the bit to move ceph cap-getting on readahead into
   ceph_init_request()[1].
 - Stick in a comment to the netfs inode structs indicating the contiguity
   requirements[2].

ver #2)
 - Adjust documentation to match.
 - Use "#if IS_ENABLED()" in netfs_i_cookie(), not "#ifdef".
 - Move the cap check from ceph_readahead() to ceph_init_request() to be
   called from netfslib.
 - Remove ceph_readahead() and use  netfs_readahead() directly instead.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/8af0d47f17d89c06bbf602496dd845f2b0bf25b3.c=
amel@kernel.org/ [1]
Link: https://lore.kernel.org/r/beaf4f6a6c2575ed489adb14b257253c868f9a5c.c=
amel@kernel.org/ [2]
Link: https://lore.kernel.org/r/3536452.1647421585@warthog.procyon.org.uk/=
 [3]
Link: https://lore.kernel.org/r/164622984545.3564931.15691742939278418580.=
stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678213320.1200972.16807551936267647470.=
stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/164692909854.2099075.9535537286264248057.s=
tgit@warthog.procyon.org.uk/ # v3
---
 Documentation/filesystems/netfs_library.rst |  101 +++++++++++++++++++---=
------
 fs/9p/cache.c                               |   10 +-
 fs/9p/v9fs.c                                |    4 -
 fs/9p/v9fs.h                                |   13 ++-
 fs/9p/vfs_addr.c                            |   43 +----------
 fs/9p/vfs_inode.c                           |   13 ++-
 fs/afs/dynroot.c                            |    1 =

 fs/afs/file.c                               |   26 -------
 fs/afs/inode.c                              |   31 +++++---
 fs/afs/internal.h                           |   19 +++--
 fs/afs/super.c                              |    4 -
 fs/afs/write.c                              |    3 =

 fs/ceph/addr.c                              |   31 +-------
 fs/ceph/cache.c                             |   28 +++----
 fs/ceph/cache.h                             |   11 ---
 fs/ceph/inode.c                             |    6 -
 fs/ceph/super.h                             |   17 ++--
 fs/cifs/cifsglob.h                          |   10 +-
 fs/cifs/fscache.c                           |   11 +--
 fs/cifs/fscache.h                           |    2 =

 fs/netfs/internal.h                         |   18 ++++
 fs/netfs/objects.c                          |   12 +--
 fs/netfs/read_helper.c                      |  100 ++++++++++++----------=
-----
 fs/netfs/stats.c                            |    1 =

 include/linux/netfs.h                       |   81 +++++++++++++++++++---
 25 files changed, 318 insertions(+), 278 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/f=
ilesystems/netfs_library.rst
index 4eb7e7b7b0fc..9c8bc5666b46 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -7,6 +7,8 @@ Network Filesystem Helper Library
 .. Contents:
 =

  - Overview.
+ - Per-inode context.
+   - Inode context helper functions.
  - Buffered read helpers.
    - Read helper functions.
    - Read helper structures.
@@ -28,6 +30,69 @@ Note that the library module doesn't link against local=
 caching directly, so
 access must be provided by the netfs.
 =

 =

+Per-Inode Context
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The network filesystem helper library needs a place to store a bit of sta=
te for
+its use on each netfs inode it is helping to manage.  To this end, a cont=
ext
+structure is defined::
+
+	struct netfs_i_context {
+		const struct netfs_request_ops *ops;
+		struct fscache_cookie	*cache;
+	};
+
+A network filesystem that wants to use netfs lib must place one of these
+directly after the VFS ``struct inode`` it allocates, usually as part of =
its
+own struct.  This can be done in a way similar to the following::
+
+	struct my_inode {
+		struct {
+			/* These must be contiguous */
+			struct inode		vfs_inode;
+			struct netfs_i_context  netfs_ctx;
+		};
+		...
+	};
+
+This allows netfslib to find its state by simple offset from the inode po=
inter,
+thereby allowing the netfslib helper functions to be pointed to directly =
by the
+VFS/VM operation tables.
+
+The structure contains the following fields:
+
+ * ``ops``
+
+   The set of operations provided by the network filesystem to netfslib.
+
+ * ``cache``
+
+   Local caching cookie, or NULL if no caching is enabled.  This field do=
es not
+   exist if fscache is disabled.
+
+
+Inode Context Helper Functions
+------------------------------
+
+To help deal with the per-inode context, a number helper functions are
+provided.  Firstly, a function to perform basic initialisation on a conte=
xt and
+set the operations table pointer::
+
+	void netfs_i_context_init(struct inode *inode,
+				  const struct netfs_request_ops *ops);
+
+then two functions to cast between the VFS inode structure and the netfs
+context::
+
+	struct netfs_i_context *netfs_i_context(struct inode *inode);
+	struct inode *netfs_inode(struct netfs_i_context *ctx);
+
+and finally, a function to get the cache cookie pointer from the context
+attached to an inode (or NULL if fscache is disabled)::
+
+	struct fscache_cookie *netfs_i_cookie(struct inode *inode);
+
+
 Buffered Read Helpers
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

@@ -70,38 +135,22 @@ Read Helper Functions
 =

 Three read helpers are provided::
 =

-	void netfs_readahead(struct readahead_control *ractl,
-			     const struct netfs_request_ops *ops,
-			     void *netfs_priv);
+	void netfs_readahead(struct readahead_control *ractl);
 	int netfs_readpage(struct file *file,
-			   struct folio *folio,
-			   const struct netfs_request_ops *ops,
-			   void *netfs_priv);
+			   struct page *page);
 	int netfs_write_begin(struct file *file,
 			      struct address_space *mapping,
 			      loff_t pos,
 			      unsigned int len,
 			      unsigned int flags,
 			      struct folio **_folio,
-			      void **_fsdata,
-			      const struct netfs_request_ops *ops,
-			      void *netfs_priv);
-
-Each corresponds to a VM operation, with the addition of a couple of para=
meters
-for the use of the read helpers:
+			      void **_fsdata);
 =

- * ``ops``
-
-   A table of operations through which the helpers can talk to the filesy=
stem.
-
- * ``netfs_priv``
+Each corresponds to a VM address space operation.  These operations use t=
he
+state in the per-inode context.
 =

-   Filesystem private data (can be NULL).
-
-Both of these values will be stored into the read request structure.
-
-For ->readahead() and ->readpage(), the network filesystem should just ju=
mp
-into the corresponding read helper; whereas for ->write_begin(), it may b=
e a
+For ->readahead() and ->readpage(), the network filesystem just point dir=
ectly
+at the corresponding read helper; whereas for ->write_begin(), it may be =
a
 little more complicated as the network filesystem might want to flush
 conflicting writes or track dirty data and needs to put the acquired foli=
o if
 an error occurs after calling the helper.
@@ -246,7 +295,6 @@ through which it can issue requests and negotiate::
 =

 	struct netfs_request_ops {
 		void (*init_request)(struct netfs_io_request *rreq, struct file *file);
-		bool (*is_cache_enabled)(struct inode *inode);
 		int (*begin_cache_operation)(struct netfs_io_request *rreq);
 		void (*expand_readahead)(struct netfs_io_request *rreq);
 		bool (*clamp_length)(struct netfs_io_subrequest *subreq);
@@ -265,11 +313,6 @@ The operations are as follows:
    [Optional] This is called to initialise the request structure.  It is =
given
    the file for reference and can modify the ->netfs_priv value.
 =

- * ``is_cache_enabled()``
-
-   [Required] This is called by netfs_write_begin() to ask if the file is=
 being
-   cached.  It should return true if it is being cached and false otherwi=
se.
-
  * ``begin_cache_operation()``
 =

    [Optional] This is called to ask the network filesystem to call into t=
he
diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 55e108e5e133..1c8dc696d516 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -49,22 +49,20 @@ int v9fs_cache_session_get_cookie(struct v9fs_session_=
info *v9ses,
 =

 void v9fs_cache_inode_get_cookie(struct inode *inode)
 {
-	struct v9fs_inode *v9inode;
+	struct v9fs_inode *v9inode =3D V9FS_I(inode);
 	struct v9fs_session_info *v9ses;
 	__le32 version;
 	__le64 path;
 =

 	if (!S_ISREG(inode->i_mode))
 		return;
-
-	v9inode =3D V9FS_I(inode);
-	if (WARN_ON(v9inode->fscache))
+	if (WARN_ON(v9fs_inode_cookie(v9inode)))
 		return;
 =

 	version =3D cpu_to_le32(v9inode->qid.version);
 	path =3D cpu_to_le64(v9inode->qid.path);
 	v9ses =3D v9fs_inode2v9ses(inode);
-	v9inode->fscache =3D
+	v9inode->netfs_ctx.cache =3D
 		fscache_acquire_cookie(v9fs_session_cache(v9ses),
 				       0,
 				       &path, sizeof(path),
@@ -72,5 +70,5 @@ void v9fs_cache_inode_get_cookie(struct inode *inode)
 				       i_size_read(&v9inode->vfs_inode));
 =

 	p9_debug(P9_DEBUG_FSC, "inode %p get cookie %p\n",
-		 inode, v9inode->fscache);
+		 inode, v9fs_inode_cookie(v9inode));
 }
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 08f65c40af4f..e28ddf763b3b 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -623,9 +623,7 @@ static void v9fs_sysfs_cleanup(void)
 static void v9fs_inode_init_once(void *foo)
 {
 	struct v9fs_inode *v9inode =3D (struct v9fs_inode *)foo;
-#ifdef CONFIG_9P_FSCACHE
-	v9inode->fscache =3D NULL;
-#endif
+
 	memset(&v9inode->qid, 0, sizeof(v9inode->qid));
 	inode_init_once(&v9inode->vfs_inode);
 }
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index bc8b30205d36..ec0e8df3b2eb 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -9,6 +9,7 @@
 #define FS_9P_V9FS_H
 =

 #include <linux/backing-dev.h>
+#include <linux/netfs.h>
 =

 /**
  * enum p9_session_flags - option flags for each 9P session
@@ -108,14 +109,15 @@ struct v9fs_session_info {
 #define V9FS_INO_INVALID_ATTR 0x01
 =

 struct v9fs_inode {
-#ifdef CONFIG_9P_FSCACHE
-	struct fscache_cookie *fscache;
-#endif
+	struct {
+		/* These must be contiguous */
+		struct inode	vfs_inode;	/* the VFS's inode record */
+		struct netfs_i_context netfs_ctx; /* Netfslib context */
+	};
 	struct p9_qid qid;
 	unsigned int cache_validity;
 	struct p9_fid *writeback_fid;
 	struct mutex v_mutex;
-	struct inode vfs_inode;
 };
 =

 static inline struct v9fs_inode *V9FS_I(const struct inode *inode)
@@ -126,7 +128,7 @@ static inline struct v9fs_inode *V9FS_I(const struct i=
node *inode)
 static inline struct fscache_cookie *v9fs_inode_cookie(struct v9fs_inode =
*v9inode)
 {
 #ifdef CONFIG_9P_FSCACHE
-	return v9inode->fscache;
+	return netfs_i_cookie(&v9inode->vfs_inode);
 #else
 	return NULL;
 #endif
@@ -163,6 +165,7 @@ extern struct inode *v9fs_inode_from_fid(struct v9fs_s=
ession_info *v9ses,
 extern const struct inode_operations v9fs_dir_inode_operations_dotl;
 extern const struct inode_operations v9fs_file_inode_operations_dotl;
 extern const struct inode_operations v9fs_symlink_inode_operations_dotl;
+extern const struct netfs_request_ops v9fs_req_ops;
 extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v=
9ses,
 					      struct p9_fid *fid,
 					      struct super_block *sb, int new);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 91d3926c9559..ed06f3c34e98 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -77,17 +77,6 @@ static void v9fs_req_cleanup(struct address_space *mapp=
ing, void *priv)
 	p9_client_clunk(fid);
 }
 =

-/**
- * v9fs_is_cache_enabled - Determine if caching is enabled for an inode
- * @inode: The inode to check
- */
-static bool v9fs_is_cache_enabled(struct inode *inode)
-{
-	struct fscache_cookie *cookie =3D v9fs_inode_cookie(V9FS_I(inode));
-
-	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
-}
-
 /**
  * v9fs_begin_cache_operation - Begin a cache operation for a read
  * @rreq: The read request
@@ -103,36 +92,13 @@ static int v9fs_begin_cache_operation(struct netfs_io=
_request *rreq)
 #endif
 }
 =

-static const struct netfs_request_ops v9fs_req_ops =3D {
+const struct netfs_request_ops v9fs_req_ops =3D {
 	.init_request		=3D v9fs_init_request,
-	.is_cache_enabled	=3D v9fs_is_cache_enabled,
 	.begin_cache_operation	=3D v9fs_begin_cache_operation,
 	.issue_read		=3D v9fs_issue_read,
 	.cleanup		=3D v9fs_req_cleanup,
 };
 =

-/**
- * v9fs_vfs_readpage - read an entire page in from 9P
- * @file: file being read
- * @page: structure to page
- *
- */
-static int v9fs_vfs_readpage(struct file *file, struct page *page)
-{
-	struct folio *folio =3D page_folio(page);
-
-	return netfs_readpage(file, folio, &v9fs_req_ops, NULL);
-}
-
-/**
- * v9fs_vfs_readahead - read a set of pages from 9P
- * @ractl: The readahead parameters
- */
-static void v9fs_vfs_readahead(struct readahead_control *ractl)
-{
-	netfs_readahead(ractl, &v9fs_req_ops, NULL);
-}
-
 /**
  * v9fs_release_page - release the private state associated with a page
  * @page: The page to be released
@@ -326,8 +292,7 @@ static int v9fs_write_begin(struct file *filp, struct =
address_space *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	retval =3D netfs_write_begin(filp, mapping, pos, len, flags, &folio, fsd=
ata,
-				   &v9fs_req_ops, NULL);
+	retval =3D netfs_write_begin(filp, mapping, pos, len, flags, &folio, fsd=
ata);
 	if (retval < 0)
 		return retval;
 =

@@ -388,8 +353,8 @@ static int v9fs_set_page_dirty(struct page *page)
 #endif
 =

 const struct address_space_operations v9fs_addr_operations =3D {
-	.readpage =3D v9fs_vfs_readpage,
-	.readahead =3D v9fs_vfs_readahead,
+	.readpage =3D netfs_readpage,
+	.readahead =3D netfs_readahead,
 	.set_page_dirty =3D v9fs_set_page_dirty,
 	.writepage =3D v9fs_vfs_writepage,
 	.write_begin =3D v9fs_write_begin,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 2a10242c79c7..a7dc6781a622 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -231,9 +231,6 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 	v9inode =3D kmem_cache_alloc(v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
-#ifdef CONFIG_9P_FSCACHE
-	v9inode->fscache =3D NULL;
-#endif
 	v9inode->writeback_fid =3D NULL;
 	v9inode->cache_validity =3D 0;
 	mutex_init(&v9inode->v_mutex);
@@ -250,6 +247,14 @@ void v9fs_free_inode(struct inode *inode)
 	kmem_cache_free(v9fs_inode_cache, V9FS_I(inode));
 }
 =

+/*
+ * Set parameters for the netfs library
+ */
+static void v9fs_set_netfs_context(struct inode *inode)
+{
+	netfs_i_context_init(inode, &v9fs_req_ops);
+}
+
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev)
 {
@@ -338,6 +343,8 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		err =3D -EINVAL;
 		goto error;
 	}
+
+	v9fs_set_netfs_context(inode);
 error:
 	return err;
 =

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index db832cc931c8..f120bcb8bf73 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -76,6 +76,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb=
, bool root)
 	/* there shouldn't be an existing inode */
 	BUG_ON(!(inode->i_state & I_NEW));
 =

+	netfs_i_context_init(inode, NULL);
 	inode->i_size		=3D 0;
 	inode->i_mode		=3D S_IFDIR | S_IRUGO | S_IXUGO;
 	if (root) {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6469d7f98ef5..2b68b2070248 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -19,13 +19,11 @@
 #include "internal.h"
 =

 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
-static int afs_readpage(struct file *file, struct page *page);
 static int afs_symlink_readpage(struct file *file, struct page *page);
 static void afs_invalidatepage(struct page *page, unsigned int offset,
 			       unsigned int length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 =

-static void afs_readahead(struct readahead_control *ractl);
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *it=
er);
 static void afs_vm_open(struct vm_area_struct *area);
 static void afs_vm_close(struct vm_area_struct *area);
@@ -52,8 +50,8 @@ const struct inode_operations afs_file_inode_operations =
=3D {
 };
 =

 const struct address_space_operations afs_file_aops =3D {
-	.readpage	=3D afs_readpage,
-	.readahead	=3D afs_readahead,
+	.readpage	=3D netfs_readpage,
+	.readahead	=3D netfs_readahead,
 	.set_page_dirty	=3D afs_set_page_dirty,
 	.launder_page	=3D afs_launder_page,
 	.releasepage	=3D afs_releasepage,
@@ -365,13 +363,6 @@ static int afs_init_request(struct netfs_io_request *=
rreq, struct file *file)
 	return 0;
 }
 =

-static bool afs_is_cache_enabled(struct inode *inode)
-{
-	struct fscache_cookie *cookie =3D afs_vnode_cache(AFS_FS_I(inode));
-
-	return fscache_cookie_enabled(cookie) && cookie->cache_priv;
-}
-
 static int afs_begin_cache_operation(struct netfs_io_request *rreq)
 {
 #ifdef CONFIG_AFS_FSCACHE
@@ -399,25 +390,12 @@ static void afs_priv_cleanup(struct address_space *m=
apping, void *netfs_priv)
 =

 const struct netfs_request_ops afs_req_ops =3D {
 	.init_request		=3D afs_init_request,
-	.is_cache_enabled	=3D afs_is_cache_enabled,
 	.begin_cache_operation	=3D afs_begin_cache_operation,
 	.check_write_begin	=3D afs_check_write_begin,
 	.issue_read		=3D afs_issue_read,
 	.cleanup		=3D afs_priv_cleanup,
 };
 =

-static int afs_readpage(struct file *file, struct page *page)
-{
-	struct folio *folio =3D page_folio(page);
-
-	return netfs_readpage(file, folio, &afs_req_ops, NULL);
-}
-
-static void afs_readahead(struct readahead_control *ractl)
-{
-	netfs_readahead(ractl, &afs_req_ops, NULL);
-}
-
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	fscache_unpin_writeback(wbc, afs_vnode_cache(AFS_FS_I(inode)));
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 5964f8aee090..5b5e40197655 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -53,6 +53,14 @@ static noinline void dump_vnode(struct afs_vnode *vnode=
, struct afs_vnode *paren
 		dump_stack();
 }
 =

+/*
+ * Set parameters for the netfs library
+ */
+static void afs_set_netfs_context(struct afs_vnode *vnode)
+{
+	netfs_i_context_init(&vnode->vfs_inode, &afs_req_ops);
+}
+
 /*
  * Initialise an inode from the vnode status.
  */
@@ -128,6 +136,7 @@ static int afs_inode_init_from_status(struct afs_opera=
tion *op,
 	}
 =

 	afs_set_i_size(vnode, status->size);
+	afs_set_netfs_context(vnode);
 =

 	vnode->invalid_before	=3D status->data_version;
 	inode_set_iversion_raw(&vnode->vfs_inode, status->data_version);
@@ -420,7 +429,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnod=
e)
 	struct afs_vnode_cache_aux aux;
 =

 	if (vnode->status.type !=3D AFS_FTYPE_FILE) {
-		vnode->cache =3D NULL;
+		vnode->netfs_ctx.cache =3D NULL;
 		return;
 	}
 =

@@ -430,12 +439,14 @@ static void afs_get_inode_cache(struct afs_vnode *vn=
ode)
 	key.vnode_id_ext[1]	=3D htonl(vnode->fid.vnode_hi);
 	afs_set_cache_aux(vnode, &aux);
 =

-	vnode->cache =3D fscache_acquire_cookie(
-		vnode->volume->cache,
-		vnode->status.type =3D=3D AFS_FTYPE_FILE ? 0 : FSCACHE_ADV_SINGLE_CHUNK=
,
-		&key, sizeof(key),
-		&aux, sizeof(aux),
-		vnode->status.size);
+	afs_vnode_set_cache(vnode,
+			    fscache_acquire_cookie(
+				    vnode->volume->cache,
+				    vnode->status.type =3D=3D AFS_FTYPE_FILE ?
+				    0 : FSCACHE_ADV_SINGLE_CHUNK,
+				    &key, sizeof(key),
+				    &aux, sizeof(aux),
+				    vnode->status.size));
 #endif
 }
 =

@@ -528,6 +539,7 @@ struct inode *afs_root_iget(struct super_block *sb, st=
ruct key *key)
 =

 	vnode =3D AFS_FS_I(inode);
 	vnode->cb_v_break =3D as->volume->cb_v_break,
+	afs_set_netfs_context(vnode);
 =

 	op =3D afs_alloc_operation(key, as->volume);
 	if (IS_ERR(op)) {
@@ -786,11 +798,8 @@ void afs_evict_inode(struct inode *inode)
 		afs_put_wb_key(wbk);
 	}
 =

-#ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(vnode->cache,
+	fscache_relinquish_cookie(afs_vnode_cache(vnode),
 				  test_bit(AFS_VNODE_DELETED, &vnode->flags));
-	vnode->cache =3D NULL;
-#endif
 =

 	afs_prune_wb_keys(vnode);
 	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c56a0e1719ae..75ca3026457e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -619,15 +619,16 @@ enum afs_lock_state {
  * leak from one inode to another.
  */
 struct afs_vnode {
-	struct inode		vfs_inode;	/* the VFS's inode record */
+	struct {
+		/* These must be contiguous */
+		struct inode	vfs_inode;	/* the VFS's inode record */
+		struct netfs_i_context netfs_ctx; /* Netfslib context */
+	};
 =

 	struct afs_volume	*volume;	/* volume on which vnode resides */
 	struct afs_fid		fid;		/* the file identifier for this inode */
 	struct afs_file_status	status;		/* AFS status info for this file */
 	afs_dataversion_t	invalid_before;	/* Child dentries are invalid before t=
his */
-#ifdef CONFIG_AFS_FSCACHE
-	struct fscache_cookie	*cache;		/* caching cookie */
-#endif
 	struct afs_permits __rcu *permit_cache;	/* cache of permits so far obtai=
ned */
 	struct mutex		io_lock;	/* Lock for serialising I/O on this mutex */
 	struct rw_semaphore	validate_lock;	/* lock for validating this vnode */
@@ -674,12 +675,20 @@ struct afs_vnode {
 static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *vn=
ode)
 {
 #ifdef CONFIG_AFS_FSCACHE
-	return vnode->cache;
+	return netfs_i_cookie(&vnode->vfs_inode);
 #else
 	return NULL;
 #endif
 }
 =

+static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
+				       struct fscache_cookie *cookie)
+{
+#ifdef CONFIG_AFS_FSCACHE
+	vnode->netfs_ctx.cache =3D cookie;
+#endif
+}
+
 /*
  * cached security record for one user's attempt to access a vnode
  */
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 5ec9fd97eccc..e66c6f54ac8e 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -688,13 +688,11 @@ static struct inode *afs_alloc_inode(struct super_bl=
ock *sb)
 	/* Reset anything that shouldn't leak from one inode to the next. */
 	memset(&vnode->fid, 0, sizeof(vnode->fid));
 	memset(&vnode->status, 0, sizeof(vnode->status));
+	afs_vnode_set_cache(vnode, NULL);
 =

 	vnode->volume		=3D NULL;
 	vnode->lock_key		=3D NULL;
 	vnode->permit_cache	=3D NULL;
-#ifdef CONFIG_AFS_FSCACHE
-	vnode->cache		=3D NULL;
-#endif
 =

 	vnode->flags		=3D 1 << AFS_VNODE_UNSET;
 	vnode->lock_state	=3D AFS_VNODE_LOCK_NONE;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 5e9157d0da29..e4b47f67a408 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -59,8 +59,7 @@ int afs_write_begin(struct file *file, struct address_sp=
ace *mapping,
 	 * file.  We need to do this before we get a lock on the page in case
 	 * there's more than one writer competing for the same cache block.
 	 */
-	ret =3D netfs_write_begin(file, mapping, pos, len, flags, &folio, fsdata=
,
-				&afs_req_ops, NULL);
+	ret =3D netfs_write_begin(file, mapping, pos, len, flags, &folio, fsdata=
);
 	if (ret < 0)
 		return ret;
 =

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4aeccafa5dda..5512f448f609 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -403,7 +403,7 @@ static void ceph_readahead_cleanup(struct address_spac=
e *mapping, void *priv)
 		ceph_put_cap_refs(ci, got);
 }
 =

-static const struct netfs_request_ops ceph_netfs_read_ops =3D {
+const struct netfs_request_ops ceph_netfs_ops =3D {
 	.init_request		=3D ceph_init_request,
 	.begin_cache_operation	=3D ceph_begin_cache_operation,
 	.issue_read		=3D ceph_netfs_issue_read,
@@ -413,28 +413,6 @@ static const struct netfs_request_ops ceph_netfs_read=
_ops =3D {
 	.cleanup		=3D ceph_readahead_cleanup,
 };
 =

-/* read a single page, without unlocking it. */
-static int ceph_readpage(struct file *file, struct page *subpage)
-{
-	struct folio *folio =3D page_folio(subpage);
-	struct inode *inode =3D file_inode(file);
-	struct ceph_inode_info *ci =3D ceph_inode(inode);
-	struct ceph_vino vino =3D ceph_vino(inode);
-	size_t len =3D folio_size(folio);
-	u64 off =3D folio_file_pos(folio);
-
-	dout("readpage ino %llx.%llx file %p off %llu len %zu folio %p index %lu=
\n inline %d",
-	     vino.ino, vino.snap, file, off, len, folio, folio_index(folio),
-	     ci->i_inline_version !=3D CEPH_INLINE_NONE);
-
-	return netfs_readpage(file, folio, &ceph_netfs_read_ops, NULL);
-}
-
-static void ceph_readahead(struct readahead_control *ractl)
-{
-	netfs_readahead(ractl, &ceph_netfs_read_ops, NULL);
-}
-
 #ifdef CONFIG_CEPH_FSCACHE
 static void ceph_set_page_fscache(struct page *page)
 {
@@ -1333,8 +1311,7 @@ static int ceph_write_begin(struct file *file, struc=
t address_space *mapping,
 	struct folio *folio =3D NULL;
 	int r;
 =

-	r =3D netfs_write_begin(file, inode->i_mapping, pos, len, 0, &folio, NUL=
L,
-			      &ceph_netfs_read_ops, NULL);
+	r =3D netfs_write_begin(file, inode->i_mapping, pos, len, 0, &folio, NUL=
L);
 	if (r =3D=3D 0)
 		folio_wait_fscache(folio);
 	if (r < 0) {
@@ -1388,8 +1365,8 @@ static int ceph_write_end(struct file *file, struct =
address_space *mapping,
 }
 =

 const struct address_space_operations ceph_aops =3D {
-	.readpage =3D ceph_readpage,
-	.readahead =3D ceph_readahead,
+	.readpage =3D netfs_readpage,
+	.readahead =3D netfs_readahead,
 	.writepage =3D ceph_writepage,
 	.writepages =3D ceph_writepages_start,
 	.write_begin =3D ceph_write_begin,
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 7d22850623ef..ddea99922073 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -29,26 +29,25 @@ void ceph_fscache_register_inode_cookie(struct inode *=
inode)
 	if (!(inode->i_state & I_NEW))
 		return;
 =

-	WARN_ON_ONCE(ci->fscache);
+	WARN_ON_ONCE(ci->netfs_ctx.cache);
 =

-	ci->fscache =3D fscache_acquire_cookie(fsc->fscache, 0,
-					     &ci->i_vino, sizeof(ci->i_vino),
-					     &ci->i_version, sizeof(ci->i_version),
-					     i_size_read(inode));
+	ci->netfs_ctx.cache =3D
+		fscache_acquire_cookie(fsc->fscache, 0,
+				       &ci->i_vino, sizeof(ci->i_vino),
+				       &ci->i_version, sizeof(ci->i_version),
+				       i_size_read(inode));
 }
 =

-void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
+void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info *ci)
 {
-	struct fscache_cookie *cookie =3D ci->fscache;
-
-	fscache_relinquish_cookie(cookie, false);
+	fscache_relinquish_cookie(ceph_fscache_cookie(ci), false);
 }
 =

 void ceph_fscache_use_cookie(struct inode *inode, bool will_modify)
 {
 	struct ceph_inode_info *ci =3D ceph_inode(inode);
 =

-	fscache_use_cookie(ci->fscache, will_modify);
+	fscache_use_cookie(ceph_fscache_cookie(ci), will_modify);
 }
 =

 void ceph_fscache_unuse_cookie(struct inode *inode, bool update)
@@ -58,9 +57,10 @@ void ceph_fscache_unuse_cookie(struct inode *inode, boo=
l update)
 	if (update) {
 		loff_t i_size =3D i_size_read(inode);
 =

-		fscache_unuse_cookie(ci->fscache, &ci->i_version, &i_size);
+		fscache_unuse_cookie(ceph_fscache_cookie(ci),
+				     &ci->i_version, &i_size);
 	} else {
-		fscache_unuse_cookie(ci->fscache, NULL, NULL);
+		fscache_unuse_cookie(ceph_fscache_cookie(ci), NULL, NULL);
 	}
 }
 =

@@ -69,14 +69,14 @@ void ceph_fscache_update(struct inode *inode)
 	struct ceph_inode_info *ci =3D ceph_inode(inode);
 	loff_t i_size =3D i_size_read(inode);
 =

-	fscache_update_cookie(ci->fscache, &ci->i_version, &i_size);
+	fscache_update_cookie(ceph_fscache_cookie(ci), &ci->i_version, &i_size);
 }
 =

 void ceph_fscache_invalidate(struct inode *inode, bool dio_write)
 {
 	struct ceph_inode_info *ci =3D ceph_inode(inode);
 =

-	fscache_invalidate(ceph_inode(inode)->fscache,
+	fscache_invalidate(ceph_fscache_cookie(ci),
 			   &ci->i_version, i_size_read(inode),
 			   dio_write ? FSCACHE_INVAL_DIO_WRITE : 0);
 }
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index b8b3b5cb6438..c20e43cade94 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -26,14 +26,9 @@ void ceph_fscache_unuse_cookie(struct inode *inode, boo=
l update);
 void ceph_fscache_update(struct inode *inode);
 void ceph_fscache_invalidate(struct inode *inode, bool dio_write);
 =

-static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
-{
-	ci->fscache =3D NULL;
-}
-
 static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_inod=
e_info *ci)
 {
-	return ci->fscache;
+	return netfs_i_cookie(&ci->vfs_inode);
 }
 =

 static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
@@ -91,10 +86,6 @@ static inline void ceph_fscache_unregister_fs(struct ce=
ph_fs_client* fsc)
 {
 }
 =

-static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
-{
-}
-
 static inline void ceph_fscache_register_inode_cookie(struct inode *inode=
)
 {
 }
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7b1e93c8a0d2..6a176d9d394a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -453,6 +453,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 =

 	dout("alloc_inode %p\n", &ci->vfs_inode);
 =

+	/* Set parameters for the netfs library */
+	netfs_i_context_init(&ci->vfs_inode, &ceph_netfs_ops);
+
 	spin_lock_init(&ci->i_ceph_lock);
 =

 	ci->i_version =3D 0;
@@ -538,9 +541,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ci->i_work, ceph_inode_work);
 	ci->i_work_mask =3D 0;
 	memset(&ci->i_btime, '\0', sizeof(ci->i_btime));
-
-	ceph_fscache_inode_init(ci);
-
 	return &ci->vfs_inode;
 }
 =

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 0b4b519682f1..e1c65aa8d3b6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -17,13 +17,11 @@
 #include <linux/posix_acl.h>
 #include <linux/refcount.h>
 #include <linux/security.h>
+#include <linux/netfs.h>
+#include <linux/fscache.h>
 =

 #include <linux/ceph/libceph.h>
 =

-#ifdef CONFIG_CEPH_FSCACHE
-#include <linux/fscache.h>
-#endif
-
 /* large granularity for statfs utilization stats to facilitate
  * large volume sizes on 32-bit machines. */
 #define CEPH_BLOCK_SHIFT   22  /* 4 MB */
@@ -317,6 +315,11 @@ struct ceph_inode_xattrs_info {
  * Ceph inode.
  */
 struct ceph_inode_info {
+	struct {
+		/* These must be contiguous */
+		struct inode vfs_inode;
+		struct netfs_i_context netfs_ctx; /* Netfslib context */
+	};
 	struct ceph_vino i_vino;   /* ceph ino + snap */
 =

 	spinlock_t i_ceph_lock;
@@ -427,11 +430,6 @@ struct ceph_inode_info {
 =

 	struct work_struct i_work;
 	unsigned long  i_work_mask;
-
-#ifdef CONFIG_CEPH_FSCACHE
-	struct fscache_cookie *fscache;
-#endif
-	struct inode vfs_inode; /* at end */
 };
 =

 static inline struct ceph_inode_info *
@@ -1215,6 +1213,7 @@ extern void __ceph_touch_fmode(struct ceph_inode_inf=
o *ci,
 =

 /* addr.c */
 extern const struct address_space_operations ceph_aops;
+extern const struct netfs_request_ops ceph_netfs_ops;
 extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
 extern int ceph_uninline_data(struct file *file);
 extern int ceph_pool_perm_check(struct inode *inode, int need);
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 48b343d03430..0a4085ced40f 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -16,6 +16,7 @@
 #include <linux/mempool.h>
 #include <linux/workqueue.h>
 #include <linux/utsname.h>
+#include <linux/netfs.h>
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
 #include <crypto/internal/hash.h>
@@ -1402,6 +1403,11 @@ void cifsFileInfo_put(struct cifsFileInfo *cifs_fil=
e);
  */
 =

 struct cifsInodeInfo {
+	struct {
+		/* These must be contiguous */
+		struct inode	vfs_inode;	/* the VFS's inode record */
+		struct netfs_i_context netfs_ctx; /* Netfslib context */
+	};
 	bool can_cache_brlcks;
 	struct list_head llist;	/* locks helb by this inode */
 	/*
@@ -1432,10 +1438,6 @@ struct cifsInodeInfo {
 	u64  uniqueid;			/* server inode number */
 	u64  createtime;		/* creation time on server */
 	__u8 lease_key[SMB2_LEASE_KEY_SIZE];	/* lease key for this inode */
-#ifdef CONFIG_CIFS_FSCACHE
-	struct fscache_cookie *fscache;
-#endif
-	struct inode vfs_inode;
 	struct list_head deferred_closes; /* list of deferred closes */
 	spinlock_t deferred_lock; /* protection on deferred list */
 	bool lease_granted; /* Flag to indicate whether lease or oplock is grant=
ed. */
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index b47c2011ce5b..a638b29e9062 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -103,7 +103,7 @@ void cifs_fscache_get_inode_cookie(struct inode *inode=
)
 =

 	cifs_fscache_fill_coherency(&cifsi->vfs_inode, &cd);
 =

-	cifsi->fscache =3D
+	cifsi->netfs_ctx.cache =3D
 		fscache_acquire_cookie(tcon->fscache, 0,
 				       &cifsi->uniqueid, sizeof(cifsi->uniqueid),
 				       &cd, sizeof(cd),
@@ -126,11 +126,12 @@ void cifs_fscache_unuse_inode_cookie(struct inode *i=
node, bool update)
 void cifs_fscache_release_inode_cookie(struct inode *inode)
 {
 	struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
+	struct fscache_cookie *cookie =3D cifs_inode_cookie(inode);
 =

-	if (cifsi->fscache) {
-		cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cifsi->fscache);
-		fscache_relinquish_cookie(cifsi->fscache, false);
-		cifsi->fscache =3D NULL;
+	if (cookie) {
+		cifs_dbg(FYI, "%s: (0x%p)\n", __func__, cookie);
+		fscache_relinquish_cookie(cookie, false);
+		cifsi->netfs_ctx.cache =3D NULL;
 	}
 }
 =

diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 55129908e2c1..52355c0912ae 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -61,7 +61,7 @@ void cifs_fscache_fill_coherency(struct inode *inode,
 =

 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inod=
e)
 {
-	return CIFS_I(inode)->fscache;
+	return netfs_i_cookie(inode);
 }
 =

 static inline void cifs_invalidate_cache(struct inode *inode, unsigned in=
t flags)
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 89837e904fa7..54c761bcc8e6 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -6,6 +6,7 @@
  */
 =

 #include <linux/netfs.h>
+#include <linux/fscache.h>
 #include <trace/events/netfs.h>
 =

 #ifdef pr_fmt
@@ -19,8 +20,6 @@
  */
 struct netfs_io_request *netfs_alloc_request(struct address_space *mappin=
g,
 					     struct file *file,
-					     const struct netfs_request_ops *ops,
-					     void *netfs_priv,
 					     loff_t start, size_t len,
 					     enum netfs_io_origin origin);
 void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref=
_trace what);
@@ -81,6 +80,21 @@ static inline void netfs_stat_d(atomic_t *stat)
 #define netfs_stat_d(x) do {} while(0)
 #endif
 =

+/*
+ * Miscellaneous functions.
+ */
+static inline bool netfs_is_cache_enabled(struct netfs_i_context *ctx)
+{
+#if IS_ENABLED(CONFIG_FSCACHE)
+	struct fscache_cookie *cookie =3D ctx->cache;
+
+	return fscache_cookie_valid(cookie) && cookie->cache_priv &&
+		fscache_cookie_enabled(cookie);
+#else
+	return false;
+#endif
+}
+
 /************************************************************************=
*****/
 /*
  * debug tracing
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index ae18827e156b..657b19e60118 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -13,12 +13,12 @@
  */
 struct netfs_io_request *netfs_alloc_request(struct address_space *mappin=
g,
 					     struct file *file,
-					     const struct netfs_request_ops *ops,
-					     void *netfs_priv,
 					     loff_t start, size_t len,
 					     enum netfs_io_origin origin)
 {
 	static atomic_t debug_ids;
+	struct inode *inode =3D file ? file_inode(file) : mapping->host;
+	struct netfs_i_context *ctx =3D netfs_i_context(inode);
 	struct netfs_io_request *rreq;
 	int ret;
 =

@@ -29,11 +29,10 @@ struct netfs_io_request *netfs_alloc_request(struct ad=
dress_space *mapping,
 	rreq->start	=3D start;
 	rreq->len	=3D len;
 	rreq->origin	=3D origin;
-	rreq->netfs_ops	=3D ops;
-	rreq->netfs_priv =3D netfs_priv;
+	rreq->netfs_ops	=3D ctx->ops;
 	rreq->mapping	=3D mapping;
-	rreq->inode	=3D file_inode(file);
-	rreq->i_size	=3D i_size_read(rreq->inode);
+	rreq->inode	=3D inode;
+	rreq->i_size	=3D i_size_read(inode);
 	rreq->debug_id	=3D atomic_inc_return(&debug_ids);
 	INIT_LIST_HEAD(&rreq->subrequests);
 	INIT_WORK(&rreq->work, netfs_rreq_work);
@@ -76,6 +75,7 @@ static void netfs_free_request(struct work_struct *work)
 {
 	struct netfs_io_request *rreq =3D
 		container_of(work, struct netfs_io_request, work);
+
 	netfs_clear_subrequests(rreq, false);
 	if (rreq->netfs_priv)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index b5176f4320f4..c048cd328ce5 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -14,7 +14,6 @@
 #include <linux/uio.h>
 #include <linux/sched/mm.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/netfs.h>
 #include "internal.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/netfs.h>
@@ -735,8 +734,6 @@ static void netfs_rreq_expand(struct netfs_io_request =
*rreq,
 /**
  * netfs_readahead - Helper to manage a read request
  * @ractl: The description of the readahead request
- * @ops: The network filesystem's operations for the helper to use
- * @netfs_priv: Private netfs data to be retained in the request
  *
  * Fulfil a readahead request by drawing data from the cache if possible,=
 or
  * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
@@ -744,35 +741,32 @@ static void netfs_rreq_expand(struct netfs_io_reques=
t *rreq,
  * readahead window can be expanded in either direction to a more conveni=
ent
  * alighment for RPC efficiency or to make storage in the cache feasible.
  *
- * The calling netfs must provide a table of operations, only one of whic=
h,
- * issue_op, is mandatory.  It may also be passed a private token, which =
will
- * be retained in rreq->netfs_priv and will be cleaned up by ops->cleanup=
().
+ * The calling netfs must initialise a netfs context contiguous to the vf=
s
+ * inode before calling this.
  *
  * This is usable whether or not caching is enabled.
  */
-void netfs_readahead(struct readahead_control *ractl,
-		     const struct netfs_request_ops *ops,
-		     void *netfs_priv)
+void netfs_readahead(struct readahead_control *ractl)
 {
 	struct netfs_io_request *rreq;
+	struct netfs_i_context *ctx =3D netfs_i_context(ractl->mapping->host);
 	unsigned int debug_index =3D 0;
 	int ret;
 =

 	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
 =

 	if (readahead_count(ractl) =3D=3D 0)
-		goto cleanup;
+		return;
 =

 	rreq =3D netfs_alloc_request(ractl->mapping, ractl->file,
-				   ops, netfs_priv,
 				   readahead_pos(ractl),
 				   readahead_length(ractl),
 				   NETFS_READAHEAD);
 	if (IS_ERR(rreq))
-		goto cleanup;
+		return;
 =

-	if (ops->begin_cache_operation) {
-		ret =3D ops->begin_cache_operation(rreq);
+	if (ctx->ops->begin_cache_operation) {
+		ret =3D ctx->ops->begin_cache_operation(rreq);
 		if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)
 			goto cleanup_free;
 	}
@@ -804,42 +798,35 @@ void netfs_readahead(struct readahead_control *ractl=
,
 cleanup_free:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
 	return;
-cleanup:
-	if (netfs_priv)
-		ops->cleanup(ractl->mapping, netfs_priv);
-	return;
 }
 EXPORT_SYMBOL(netfs_readahead);
 =

 /**
  * netfs_readpage - Helper to manage a readpage request
  * @file: The file to read from
- * @folio: The folio to read
- * @ops: The network filesystem's operations for the helper to use
- * @netfs_priv: Private netfs data to be retained in the request
+ * @subpage: A subpage of the folio to read
  *
  * Fulfil a readpage request by drawing data from the cache if possible, =
or the
  * netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O requ=
ests
  * from different sources will get munged together.
  *
- * The calling netfs must provide a table of operations, only one of whic=
h,
- * issue_op, is mandatory.  It may also be passed a private token, which =
will
- * be retained in rreq->netfs_priv and will be cleaned up by ops->cleanup=
().
+ * The calling netfs must initialise a netfs context contiguous to the vf=
s
+ * inode before calling this.
  *
  * This is usable whether or not caching is enabled.
  */
-int netfs_readpage(struct file *file,
-		   struct folio *folio,
-		   const struct netfs_request_ops *ops,
-		   void *netfs_priv)
+int netfs_readpage(struct file *file, struct page *subpage)
 {
+	struct folio *folio =3D page_folio(subpage);
+	struct address_space *mapping =3D folio->mapping;
 	struct netfs_io_request *rreq;
+	struct netfs_i_context *ctx =3D netfs_i_context(mapping->host);
 	unsigned int debug_index =3D 0;
 	int ret;
 =

 	_enter("%lx", folio_index(folio));
 =

-	rreq =3D netfs_alloc_request(folio->mapping, file, ops, netfs_priv,
+	rreq =3D netfs_alloc_request(mapping, file,
 				   folio_file_pos(folio), folio_size(folio),
 				   NETFS_READPAGE);
 	if (IS_ERR(rreq)) {
@@ -847,8 +834,8 @@ int netfs_readpage(struct file *file,
 		goto alloc_error;
 	}
 =

-	if (ops->begin_cache_operation) {
-		ret =3D ops->begin_cache_operation(rreq);
+	if (ctx->ops->begin_cache_operation) {
+		ret =3D ctx->ops->begin_cache_operation(rreq);
 		if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)=
 {
 			folio_unlock(folio);
 			goto out;
@@ -886,8 +873,6 @@ int netfs_readpage(struct file *file,
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
 	return ret;
 alloc_error:
-	if (netfs_priv)
-		ops->cleanup(folio_file_mapping(folio), netfs_priv);
 	folio_unlock(folio);
 	return ret;
 }
@@ -898,6 +883,7 @@ EXPORT_SYMBOL(netfs_readpage);
  * @folio: The folio being prepared
  * @pos: starting position for the write
  * @len: length of write
+ * @always_fill: T if the folio should always be completely filled/cleare=
d
  *
  * In some cases, write_begin doesn't need to read at all:
  * - full folio write
@@ -907,17 +893,27 @@ EXPORT_SYMBOL(netfs_readpage);
  * If any of these criteria are met, then zero out the unwritten parts
  * of the folio and return true. Otherwise, return false.
  */
-static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t=
 len)
+static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t=
 len,
+				 bool always_fill)
 {
 	struct inode *inode =3D folio_inode(folio);
 	loff_t i_size =3D i_size_read(inode);
 	size_t offset =3D offset_in_folio(folio, pos);
+	size_t plen =3D folio_size(folio);
+
+	if (unlikely(always_fill)) {
+		if (pos - offset + len <=3D i_size)
+			return false; /* Page entirely before EOF */
+		zero_user_segment(&folio->page, 0, plen);
+		folio_mark_uptodate(folio);
+		return true;
+	}
 =

 	/* Full folio write */
-	if (offset =3D=3D 0 && len >=3D folio_size(folio))
+	if (offset =3D=3D 0 && len >=3D plen)
 		return true;
 =

-	/* pos beyond last folio in the file */
+	/* Page entirely beyond the end of the file */
 	if (pos - offset >=3D i_size)
 		goto zero_out;
 =

@@ -927,7 +923,7 @@ static bool netfs_skip_folio_read(struct folio *folio,=
 loff_t pos, size_t len)
 =

 	return false;
 zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, folio_size(fol=
io));
+	zero_user_segments(&folio->page, 0, offset, offset + len, plen);
 	return true;
 }
 =

@@ -940,8 +936,6 @@ static bool netfs_skip_folio_read(struct folio *folio,=
 loff_t pos, size_t len)
  * @aop_flags: AOP_* flags
  * @_folio: Where to put the resultant folio
  * @_fsdata: Place for the netfs to store a cookie
- * @ops: The network filesystem's operations for the helper to use
- * @netfs_priv: Private netfs data to be retained in the request
  *
  * Pre-read data for a write-begin request by drawing data from the cache=
 if
  * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
@@ -960,17 +954,18 @@ static bool netfs_skip_folio_read(struct folio *foli=
o, loff_t pos, size_t len)
  * should go ahead; unlock the folio and return -EAGAIN to cause the foli=
o to
  * be regot; or return an error.
  *
+ * The calling netfs must initialise a netfs context contiguous to the vf=
s
+ * inode before calling this.
+ *
  * This is usable whether or not caching is enabled.
  */
 int netfs_write_begin(struct file *file, struct address_space *mapping,
 		      loff_t pos, unsigned int len, unsigned int aop_flags,
-		      struct folio **_folio, void **_fsdata,
-		      const struct netfs_request_ops *ops,
-		      void *netfs_priv)
+		      struct folio **_folio, void **_fsdata)
 {
 	struct netfs_io_request *rreq;
+	struct netfs_i_context *ctx =3D netfs_i_context(file_inode(file ));
 	struct folio *folio;
-	struct inode *inode =3D file_inode(file);
 	unsigned int debug_index =3D 0, fgp_flags;
 	pgoff_t index =3D pos >> PAGE_SHIFT;
 	int ret;
@@ -986,9 +981,9 @@ int netfs_write_begin(struct file *file, struct addres=
s_space *mapping,
 	if (!folio)
 		return -ENOMEM;
 =

-	if (ops->check_write_begin) {
+	if (ctx->ops->check_write_begin) {
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
-		ret =3D ops->check_write_begin(file, pos, len, folio, _fsdata);
+		ret =3D ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
 		if (ret < 0) {
 			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
 			if (ret =3D=3D -EAGAIN)
@@ -1004,13 +999,13 @@ int netfs_write_begin(struct file *file, struct add=
ress_space *mapping,
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
-	if (!ops->is_cache_enabled(inode) &&
-	    netfs_skip_folio_read(folio, pos, len)) {
+	if (!netfs_is_cache_enabled(ctx) &&
+	    netfs_skip_folio_read(folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_folio_no_wait;
 	}
 =

-	rreq =3D netfs_alloc_request(mapping, file, ops, netfs_priv,
+	rreq =3D netfs_alloc_request(mapping, file,
 				   folio_file_pos(folio), folio_size(folio),
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
@@ -1019,10 +1014,9 @@ int netfs_write_begin(struct file *file, struct add=
ress_space *mapping,
 	}
 	rreq->no_unlock_folio	=3D folio_index(folio);
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
-	netfs_priv =3D NULL;
 =

-	if (ops->begin_cache_operation) {
-		ret =3D ops->begin_cache_operation(rreq);
+	if (ctx->ops->begin_cache_operation) {
+		ret =3D ctx->ops->begin_cache_operation(rreq);
 		if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)
 			goto error_put;
 	}
@@ -1076,8 +1070,6 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 	if (ret < 0)
 		goto error;
 have_folio_no_wait:
-	if (netfs_priv)
-		ops->cleanup(mapping, netfs_priv);
 	*_folio =3D folio;
 	_leave(" =3D 0");
 	return 0;
@@ -1087,8 +1079,6 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 error:
 	folio_unlock(folio);
 	folio_put(folio);
-	if (netfs_priv)
-		ops->cleanup(mapping, netfs_priv);
 	_leave(" =3D %d", ret);
 	return ret;
 }
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 9ae538c85378..5510a7a14a40 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -7,7 +7,6 @@
 =

 #include <linux/export.h>
 #include <linux/seq_file.h>
-#include <linux/netfs.h>
 #include "internal.h"
 =

 atomic_t netfs_n_rh_readahead;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4b99e38f73d9..8458b30172a5 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -118,6 +118,16 @@ enum netfs_io_source {
 typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_=
error,
 				      bool was_async);
 =

+/*
+ * Per-inode description.  This must be directly after the inode struct.
+ */
+struct netfs_i_context {
+	const struct netfs_request_ops *ops;
+#if IS_ENABLED(CONFIG_FSCACHE)
+	struct fscache_cookie	*cache;
+#endif
+};
+
 /*
  * Resources required to do operations on a cache.
  */
@@ -192,7 +202,6 @@ struct netfs_io_request {
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_request_ops {
-	bool (*is_cache_enabled)(struct inode *inode);
 	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
 	int (*begin_cache_operation)(struct netfs_io_request *rreq);
 	void (*expand_readahead)(struct netfs_io_request *rreq);
@@ -263,18 +272,11 @@ struct netfs_cache_ops {
 };
 =

 struct readahead_control;
-extern void netfs_readahead(struct readahead_control *,
-			    const struct netfs_request_ops *,
-			    void *);
-extern int netfs_readpage(struct file *,
-			  struct folio *,
-			  const struct netfs_request_ops *,
-			  void *);
+extern void netfs_readahead(struct readahead_control *);
+extern int netfs_readpage(struct file *, struct page *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct folio **,
-			     void **,
-			     const struct netfs_request_ops *,
-			     void *);
+			     void **);
 =

 extern void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t=
, bool);
 extern void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
@@ -283,4 +285,61 @@ extern void netfs_put_subrequest(struct netfs_io_subr=
equest *subreq,
 				 bool was_async, enum netfs_sreq_ref_trace what);
 extern void netfs_stats_show(struct seq_file *);
 =

+/**
+ * netfs_i_context - Get the netfs inode context from the inode
+ * @inode: The inode to query
+ *
+ * Get the netfs lib inode context from the network filesystem's inode.  =
The
+ * context struct is expected to directly follow on from the VFS inode st=
ruct.
+ */
+static inline struct netfs_i_context *netfs_i_context(struct inode *inode=
)
+{
+	return (struct netfs_i_context *)(inode + 1);
+}
+
+/**
+ * netfs_inode - Get the netfs inode from the inode context
+ * @ctx: The context to query
+ *
+ * Get the netfs inode from the netfs library's inode context.  The VFS i=
node
+ * is expected to directly precede the context struct.
+ */
+static inline struct inode *netfs_inode(struct netfs_i_context *ctx)
+{
+	return ((struct inode *)ctx) - 1;
+}
+
+/**
+ * netfs_i_context_init - Initialise a netfs lib context
+ * @inode: The inode with which the context is associated
+ * @ops: The netfs's operations list
+ *
+ * Initialise the netfs library context struct.  This is expected to foll=
ow on
+ * directly from the VFS inode struct.
+ */
+static inline void netfs_i_context_init(struct inode *inode,
+					const struct netfs_request_ops *ops)
+{
+	struct netfs_i_context *ctx =3D netfs_i_context(inode);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->ops =3D ops;
+}
+
+/**
+ * netfs_i_cookie - Get the cache cookie from the inode
+ * @inode: The inode to query
+ *
+ * Get the caching cookie (if enabled) from the network filesystem's inod=
e.
+ */
+static inline struct fscache_cookie *netfs_i_cookie(struct inode *inode)
+{
+#if IS_ENABLED(CONFIG_FSCACHE)
+	struct netfs_i_context *ctx =3D netfs_i_context(inode);
+	return ctx->cache;
+#else
+	return NULL;
+#endif
+}
+
 #endif /* _LINUX_NETFS_H */

