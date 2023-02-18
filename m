Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21CA69B6F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjBRAkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBRAkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:40:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71442F776;
        Fri, 17 Feb 2023 16:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F07DB82ED6;
        Sat, 18 Feb 2023 00:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACFFC4339C;
        Sat, 18 Feb 2023 00:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680444;
        bh=KJ9deFMojFpl3u+l/cyL8DHjpFaJjqmrjoujoFfiocQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0BKipAaAwkd0Ow0bFmI5SmgYkvSBEEodiVCJMTDYkQ1uODcitDAer3LnfXinRp9a
         PO58nt7Dl3nmIvsEB+jQua+FFHlOdItBQQZjh68JnrP16SBEkv6A0W6QkLQHKbI5cO
         ZFwPguvCRAIHpHn2BJXScdsmaGplb83KjPLGPJjXpxqE1qhAiCa6PHT1tEPuCHUBVh
         8650e8r52KDmKC27JnLnEXHLaTW4r/o1P6e3fLg2Qs/tVJ/tIzFFnpqS3b1my5rS4J
         pFQ+uBl1d+Qkvl9dQi4cOp33euL06l8u0Dw6Db1Hw1TbhuKPvIzcRpo5D2OQ6wQD+G
         WqPuYOHvrwkvA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 10/11] fs/9p: writeback mode fixes
Date:   Sat, 18 Feb 2023 00:33:22 +0000
Message-Id: <20230218003323.2322580-11-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fixes several detected problems from preivous
patches when running with writeback mode.  In
particular this fixes issues with files which are opened
as write only and getattr on files which dirty caches.

This patch makes sure that cache behavior for an open file is stored in
the client copy of fid->mode.  This allows us to reflect cache behavior
from mount flags, open mode, and information from the server to
inform readahead and writeback behavior.

This includes adding support for a 9p semantic that qid.version==0
is used to mark a file as non-cachable which is important for
synthetic files.  This may have a side-effect of not supporting
caching on certain legacy file servers that do not properly set
qid.version.  There is also now a mount flag which can disable
the qid.version behavior.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 Documentation/filesystems/9p.rst | 24 ++++-----
 fs/9p/fid.c                      | 49 +++++++----------
 fs/9p/fid.h                      | 33 +++++++++++-
 fs/9p/v9fs.h                     |  1 -
 fs/9p/vfs_addr.c                 | 22 ++++----
 fs/9p/vfs_file.c                 | 91 +++++++++++---------------------
 fs/9p/vfs_inode.c                | 45 ++++++----------
 fs/9p/vfs_inode_dotl.c           | 50 +++++++-----------
 fs/9p/vfs_super.c                | 21 +++++---
 9 files changed, 153 insertions(+), 183 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 0e800b8f73cc..0c2c7a181d85 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -79,18 +79,14 @@ Options
 
   cache=mode	specifies a caching policy.  By default, no caches are used.
 
-                        none
-				default no cache policy, metadata and data
-                                alike are synchronous.
-			loose
-				no attempts are made at consistency,
-                                intended for exclusive, read-only mounts
-                        fscache
-				use FS-Cache for a persistent, read-only
-				cache backend.
-                        mmap
-				minimal cache that is only used for read-write
-                                mmap.  Northing else is cached, like cache=none
+			=========	=============================================
+			none		no cache of file or metadata
+			readahead	readahead caching of files
+			writeback	delayed writeback of files
+			mmap		support mmap operations read/write with cache
+			loose		meta-data and file cache with no coherency
+			fscache		use FS-Cache for a persistent cache backend
+			=========	=============================================
 
   debug=n	specifies debug level.  The debug level is a bitmask.
 
@@ -137,6 +133,10 @@ Options
   		This can be used to share devices/named pipes/sockets between
 		hosts.  This functionality will be expanded in later versions.
 
+  directio	bypass page cache on all read/write operations
+
+  ignoreqv	ignore qid.version==0 as a marker to ignore cache
+
   noxattr	do not offer xattr functions on this mount.
 
   access	there are four access modes.
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 805151114e96..8c1697619f3d 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -23,7 +23,6 @@ static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
 	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
 }
 
-
 /**
  * v9fs_fid_add - add a fid to a dentry
  * @dentry: dentry that the fid is being added to
@@ -41,14 +40,24 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
 	*pfid = NULL;
 }
 
+static bool v9fs_is_writeable(int mode)
+{
+	if ((mode & P9_OWRITE) || (mode & P9_ORDWR))
+		return true;
+	else
+		return false;
+}
+
 /**
  * v9fs_fid_find_inode - search for an open fid off of the inode list
  * @inode: return a fid pointing to a specific inode
+ * @writeable: only consider fids which are writeable
  * @uid: return a fid belonging to the specified user
+ * @any: ignore uid as a selection criteria
  *
  */
-
-static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
+struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
+	kuid_t uid, bool any)
 {
 	struct hlist_head *h;
 	struct p9_fid *fid, *ret = NULL;
@@ -58,7 +67,12 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 	spin_lock(&inode->i_lock);
 	h = (struct hlist_head *)&inode->i_private;
 	hlist_for_each_entry(fid, h, ilist) {
-		if (uid_eq(fid->uid, uid)) {
+		if (any || uid_eq(fid->uid, uid)) {
+			if (want_writeable && !v9fs_is_writeable(fid->mode)) {
+				p9_debug(P9_DEBUG_VFS, " mode: %x not writeable?\n",
+							fid->mode);
+				continue;
+			}
 			p9_fid_get(fid);
 			ret = fid;
 			break;
@@ -118,7 +132,7 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		spin_unlock(&dentry->d_lock);
 	} else {
 		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, uid);
+			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 	}
 
 	return ret;
@@ -299,28 +313,3 @@ struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
 	return v9fs_fid_lookup_with_uid(dentry, uid, any);
 }
 
-struct p9_fid *v9fs_writeback_fid(struct dentry *dentry)
-{
-	int err;
-	struct p9_fid *fid, *ofid;
-
-	ofid = v9fs_fid_lookup_with_uid(dentry, GLOBAL_ROOT_UID, 0);
-	fid = clone_fid(ofid);
-	if (IS_ERR(fid))
-		goto error_out;
-	p9_fid_put(ofid);
-	/*
-	 * writeback fid will only be used to write back the
-	 * dirty pages. We always request for the open fid in read-write
-	 * mode so that a partial page write which result in page
-	 * read can work.
-	 */
-	err = p9_client_open(fid, O_RDWR);
-	if (err < 0) {
-		p9_fid_put(fid);
-		fid = ERR_PTR(err);
-		goto error_out;
-	}
-error_out:
-	return fid;
-}
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 8a4e8cd12ca2..11576e1364bf 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -7,14 +7,16 @@
 #ifndef FS_9P_FID_H
 #define FS_9P_FID_H
 #include <linux/list.h>
+#include "v9fs.h"
 
+struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
+	kuid_t uid, bool any);
 struct p9_fid *v9fs_fid_lookup(struct dentry *dentry);
 static inline struct p9_fid *v9fs_parent_fid(struct dentry *dentry)
 {
 	return v9fs_fid_lookup(dentry->d_parent);
 }
 void v9fs_fid_add(struct dentry *dentry, struct p9_fid **fid);
-struct p9_fid *v9fs_writeback_fid(struct dentry *dentry);
 void v9fs_open_fid_add(struct inode *inode, struct p9_fid **fid);
 static inline struct p9_fid *clone_fid(struct p9_fid *fid)
 {
@@ -32,4 +34,33 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
 	p9_fid_put(fid);
 	return nfid;
 }
+/**
+ * v9fs_fid_addmodes - add cache flags to fid mode (for client use only)
+ * @fid: fid to augment
+ * @s_flags: session info mount flags
+ * @s_cache: session info cache flags
+ * @f_flags: unix open flags
+ *
+ * make sure mode reflects flags of underlying mounts
+ * also qid.version == 0 reflects a synthetic or legacy file system
+ * NOTE: these are set after open so only reflect 9p client not
+ * underlying file system on server.
+ */
+static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
+	int s_cache, unsigned int f_flags)
+{
+	if (fid->qid.type != P9_QTFILE)
+		return;
+
+	if ((!s_cache) ||
+	   ((fid->qid.version == 0) && !(s_flags & V9FS_IGNORE_QV)) ||
+	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
+		fid->mode |= P9L_DIRECT; /* no read or write cache */
+	} else if ((s_cache < CACHE_WRITEBACK) ||
+				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
+		fid->mode |= P9L_NOWRITECACHE;
+	} else if (s_cache == CACHE_LOOSE) {
+		fid->mode |= P9L_LOOSE; /* noncoherent cache */
+	}
+}
 #endif
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 48c7614c9333..8be9c0f59679 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -118,7 +118,6 @@ struct v9fs_inode {
 	struct netfs_inode netfs; /* Netfslib context and vfs inode */
 	struct p9_qid qid;
 	unsigned int cache_validity;
-	struct p9_fid *writeback_fid;
 	struct mutex v_mutex;
 };
 
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 6f46d7e4c750..211165430a8a 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -57,8 +57,6 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
  */
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
-	struct inode *inode = file_inode(file);
-	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct p9_fid *fid = file->private_data;
 
 	BUG_ON(!fid);
@@ -66,11 +64,8 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 	/* we might need to read from a fid that was opened write-only
 	 * for read-modify-write of page cache, use the writeback fid
 	 * for that */
-	if (rreq->origin == NETFS_READ_FOR_WRITE &&
-			(fid->mode & O_ACCMODE) == O_WRONLY) {
-		fid = v9inode->writeback_fid;
-		BUG_ON(!fid);
-	}
+	WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE &&
+			!(fid->mode & P9_ORDWR));
 
 	p9_fid_get(fid);
 	rreq->netfs_priv = fid;
@@ -164,6 +159,7 @@ static int v9fs_vfs_write_folio_locked(struct folio *folio)
 	loff_t i_size = i_size_read(inode);
 	struct iov_iter from;
 	size_t len = folio_size(folio);
+	struct p9_fid *writeback_fid;
 	int err;
 
 	if (start >= i_size)
@@ -173,13 +169,17 @@ static int v9fs_vfs_write_folio_locked(struct folio *folio)
 
 	iov_iter_xarray(&from, ITER_SOURCE, &folio_mapping(folio)->i_pages, start, len);
 
-	/* We should have writeback_fid always set */
-	BUG_ON(!v9inode->writeback_fid);
+	writeback_fid = v9fs_fid_find_inode(inode, true, INVALID_UID, true);
+	if (!writeback_fid) {
+		WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
+			inode->i_private);
+		return -EINVAL;
+	}
 
 	folio_wait_fscache(folio);
 	folio_start_writeback(folio);
 
-	p9_client_write(v9inode->writeback_fid, start, &from, &err);
+	p9_client_write(writeback_fid, start, &from, &err);
 
 	if (err == 0 &&
 	    fscache_cookie_enabled(cookie) &&
@@ -192,6 +192,8 @@ static int v9fs_vfs_write_folio_locked(struct folio *folio)
 	}
 
 	folio_end_writeback(folio);
+	p9_fid_put(writeback_fid);
+
 	return err;
 }
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 20e4bd299fc2..936daff9f948 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -42,7 +42,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	int err;
 	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid, *writeback_fid;
+	struct p9_fid *fid;
 	int omode;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
@@ -59,7 +59,19 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
 
-		err = p9_client_open(fid, omode);
+		if ((v9ses->cache >= CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
+			int writeback_omode = (omode & !P9_OWRITE) | P9_ORDWR;
+
+			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
+			err = p9_client_open(fid, writeback_omode);
+			if (err < 0) {
+				p9_debug(P9_DEBUG_CACHE, "could not open O_RDWR, disabling caches\n");
+				err = p9_client_open(fid, omode);
+				fid->mode |= P9L_DIRECT;
+			}
+		} else {
+			err = p9_client_open(fid, omode);
+		}
 		if (err < 0) {
 			p9_fid_put(fid);
 			return err;
@@ -71,36 +83,14 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		file->private_data = fid;
 	}
 
-	mutex_lock(&v9inode->v_mutex);
-	if ((v9ses->cache >= CACHE_WRITEBACK) && !v9inode->writeback_fid &&
-	    ((file->f_flags & O_ACCMODE) != O_RDONLY)) {
-		/*
-		 * clone a fid and add it to writeback_fid
-		 * we do it during open time instead of
-		 * page dirty time via write_begin/page_mkwrite
-		 * because we want write after unlink usecase
-		 * to work.
-		 */
-		writeback_fid = v9fs_writeback_fid(file_dentry(file));
-		if (IS_ERR(writeback_fid)) {
-			err = PTR_ERR(writeback_fid);
-			mutex_unlock(&v9inode->v_mutex);
-			goto out_error;
-		}
-		v9inode->writeback_fid = (void *) writeback_fid;
-	}
-	mutex_unlock(&v9inode->v_mutex);
 #ifdef CONFIG_9P_FSCACHE
 	if (v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
 #endif
+	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
 	v9fs_open_fid_add(inode, &fid);
 	return 0;
-out_error:
-	p9_fid_put(file->private_data);
-	file->private_data = NULL;
-	return err;
 }
 
 /**
@@ -366,14 +356,14 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct p9_fid *fid = iocb->ki_filp->private_data;
 	int ret, err = 0;
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
-	p9_debug(P9_DEBUG_VFS, "count %zu offset %lld\n",
-		 iov_iter_count(to), iocb->ki_pos);
+	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
+		 fid->fid, iov_iter_count(to), iocb->ki_pos);
 
-	if (v9ses->cache > CACHE_MMAP)
+	if (!(fid->mode & P9L_DIRECT)) {
+		p9_debug(P9_DEBUG_VFS, "(cached)\n");
 		return generic_file_read_iter(iocb, to);
+	}
 
 	if (iocb->ki_filp->f_flags & O_NONBLOCK)
 		ret = p9_client_read_once(fid, iocb->ki_pos, to, &err);
@@ -396,14 +386,17 @@ static ssize_t
 v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct p9_fid *fid = file->private_data;
 	ssize_t retval;
 	loff_t origin;
 	int err = 0;
-	struct inode *inode = file_inode(iocb->ki_filp);
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
-	if (v9ses->cache >= CACHE_WRITEBACK)
+	p9_debug(P9_DEBUG_VFS, "fid %d\n", fid->fid);
+
+	if (!(fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))) {
+		p9_debug(P9_DEBUG_CACHE, "(cached)\n");
 		return generic_file_write_iter(iocb, from);
+	}
 
 	retval = generic_write_checks(iocb, from);
 	if (retval <= 0)
@@ -487,36 +480,18 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	int retval;
 	struct inode *inode = file_inode(filp);
-	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
-	struct p9_fid *fid;
+
+	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
 	if (v9ses->cache < CACHE_MMAP) {
+		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
+		if (vma->vm_flags & VM_MAYSHARE)
+			return -ENODEV;
 		invalidate_inode_pages2(filp->f_mapping);
 		return generic_file_readonly_mmap(filp, vma);
 	}
 
-	mutex_lock(&v9inode->v_mutex);
-	if (!v9inode->writeback_fid &&
-	    (vma->vm_flags & VM_SHARED) &&
-	    (vma->vm_flags & VM_WRITE)) {
-		/*
-		 * clone a fid and add it to writeback_fid
-		 * we do it during mmap instead of
-		 * page dirty time via write_begin/page_mkwrite
-		 * because we want write after unlink usecase
-		 * to work.
-		 */
-		fid = v9fs_writeback_fid(file_dentry(filp));
-		if (IS_ERR(fid)) {
-			retval = PTR_ERR(fid);
-			mutex_unlock(&v9inode->v_mutex);
-			return retval;
-		}
-		v9inode->writeback_fid = (void *) fid;
-	}
-	mutex_unlock(&v9inode->v_mutex);
-
 	retval = generic_file_mmap(filp, vma);
 	if (!retval)
 		vma->vm_ops = &v9fs_mmap_file_vm_ops;
@@ -527,7 +502,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	struct v9fs_inode *v9inode;
 	struct folio *folio = page_folio(vmf->page);
 	struct file *filp = vmf->vma->vm_file;
 	struct inode *inode = file_inode(filp);
@@ -536,8 +510,6 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	p9_debug(P9_DEBUG_VFS, "folio %p fid %lx\n",
 		 folio, (unsigned long)filp->private_data);
 
-	v9inode = V9FS_I(inode);
-
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
@@ -550,7 +522,6 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* Update file times before taking page lock */
 	file_update_time(filp);
 
-	BUG_ON(!v9inode->writeback_fid);
 	if (folio_lock_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 	if (folio_mapping(folio) != inode->i_mapping)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 8ffa6631b1fd..d53475e1ba27 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -259,7 +259,6 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 	v9inode = alloc_inode_sb(sb, v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
-	v9inode->writeback_fid = NULL;
 	v9inode->cache_validity = 0;
 	mutex_init(&v9inode->v_mutex);
 	return &v9inode->netfs.inode;
@@ -412,9 +411,6 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
-	/* clunk the fid stashed in writeback_fid */
-	p9_fid_put(v9inode->writeback_fid);
-	v9inode->writeback_fid = NULL;
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
@@ -825,9 +821,10 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	u32 perm;
 	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid, *inode_fid;
+	struct p9_fid *fid;
 	struct dentry *res = NULL;
 	struct inode *inode;
+	int p9_omode;
 
 	if (d_in_lookup(dentry)) {
 		res = v9fs_vfs_lookup(dir, dentry, 0);
@@ -846,9 +843,14 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 
 	v9ses = v9fs_inode2v9ses(dir);
 	perm = unixmode2p9mode(v9ses, mode);
-	fid = v9fs_create(v9ses, dir, dentry, NULL, perm,
-				v9fs_uflags2omode(flags,
-						v9fs_proto_dotu(v9ses)));
+	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
+
+	if ((v9ses->cache >= CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
+		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;
+		p9_debug(P9_DEBUG_CACHE,
+			"write-only file with writeback enabled, creating w/ O_RDWR\n");
+	}
+	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
 	if (IS_ERR(fid)) {
 		err = PTR_ERR(fid);
 		goto error;
@@ -857,25 +859,6 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	v9fs_invalidate_inode_attr(dir);
 	inode = d_inode(dentry);
 	v9inode = V9FS_I(inode);
-	mutex_lock(&v9inode->v_mutex);
-	if ((v9ses->cache >= CACHE_WRITEBACK) && !v9inode->writeback_fid &&
-	    ((flags & O_ACCMODE) != O_RDONLY)) {
-		/*
-		 * clone a fid and add it to writeback_fid
-		 * we do it during open time instead of
-		 * page dirty time via write_begin/page_mkwrite
-		 * because we want write after unlink usecase
-		 * to work.
-		 */
-		inode_fid = v9fs_writeback_fid(dentry);
-		if (IS_ERR(inode_fid)) {
-			err = PTR_ERR(inode_fid);
-			mutex_unlock(&v9inode->v_mutex);
-			goto error;
-		}
-		v9inode->writeback_fid = (void *) inode_fid;
-	}
-	mutex_unlock(&v9inode->v_mutex);
 	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto error;
@@ -884,6 +867,8 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
+
+	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
 	v9fs_open_fid_add(inode, &fid);
 
 	file->f_mode |= FMODE_CREATED;
@@ -1053,7 +1038,7 @@ v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+		generic_fillattr(&init_user_ns, inode, stat);
 		return 0;
 	} else if (v9ses->cache >= CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode))
@@ -1148,10 +1133,10 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
 	if ((iattr->ia_valid & ATTR_SIZE) &&
 		 iattr->ia_size != i_size_read(inode)) {
 		truncate_setsize(inode, iattr->ia_size);
+		truncate_pagecache(inode, iattr->ia_size);
+
 		if (v9ses->cache == CACHE_FSCACHE)
 			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
-		else
-			invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 
 	v9fs_invalidate_inode_attr(inode);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 4f01808c3bae..f5f15878cbb7 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -232,12 +232,12 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	int err = 0;
 	kgid_t gid;
 	umode_t mode;
+	int p9_omode = v9fs_open_to_dotl_flags(flags);
 	const unsigned char *name = NULL;
 	struct p9_qid qid;
 	struct inode *inode;
 	struct p9_fid *fid = NULL;
-	struct v9fs_inode *v9inode;
-	struct p9_fid *dfid = NULL, *ofid = NULL, *inode_fid = NULL;
+	struct p9_fid *dfid = NULL, *ofid = NULL;
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 	struct dentry *res = NULL;
@@ -282,14 +282,19 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	/* Update mode based on ACL value */
 	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
 	if (err) {
-		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat %d\n",
+		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in create %d\n",
 			 err);
 		goto out;
 	}
-	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
-				    mode, gid, &qid);
+
+	if ((v9ses->cache >= CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
+		p9_omode = (p9_omode & !P9_OWRITE) | P9_ORDWR;
+		p9_debug(P9_DEBUG_CACHE,
+			"write-only file with writeback enabled, creating w/ O_RDWR\n");
+	}
+	err = p9_client_create_dotl(ofid, name, p9_omode, mode, gid, &qid);
 	if (err < 0) {
-		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
+		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in create %d\n",
 			 err);
 		goto out;
 	}
@@ -314,36 +319,19 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	v9fs_fid_add(dentry, &fid);
 	d_instantiate(dentry, inode);
 
-	v9inode = V9FS_I(inode);
-	mutex_lock(&v9inode->v_mutex);
-	if ((v9ses->cache) && !v9inode->writeback_fid &&
-	    ((flags & O_ACCMODE) != O_RDONLY)) {
-		/*
-		 * clone a fid and add it to writeback_fid
-		 * we do it during open time instead of
-		 * page dirty time via write_begin/page_mkwrite
-		 * because we want write after unlink usecase
-		 * to work.
-		 */
-		inode_fid = v9fs_writeback_fid(dentry);
-		if (IS_ERR(inode_fid)) {
-			err = PTR_ERR(inode_fid);
-			mutex_unlock(&v9inode->v_mutex);
-			goto out;
-		}
-		v9inode->writeback_fid = (void *) inode_fid;
-	}
-	mutex_unlock(&v9inode->v_mutex);
 	/* Since we are opening a file, assign the open fid to the file */
 	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto out;
 	file->private_data = ofid;
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cache == CACHE_FSCACHE)
+	if (v9ses->cache == CACHE_FSCACHE) {
+		struct v9fs_inode *v9inode = V9FS_I(inode);
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
+	}
 #endif
+	v9fs_fid_add_modes(ofid, v9ses->flags, v9ses->cache, flags);
 	v9fs_open_fid_add(inode, &ofid);
 	file->f_mode |= FMODE_CREATED;
 out:
@@ -464,9 +452,9 @@ v9fs_vfs_getattr_dotl(struct user_namespace *mnt_userns,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+		generic_fillattr(&init_user_ns, inode, stat);
 		return 0;
-	} else if (v9ses->cache >= CACHE_WRITEBACK) {
+	} else if (v9ses->cache) {
 		if (S_ISREG(inode->i_mode))
 			v9fs_flush_inode_writeback(inode);
 
@@ -605,10 +593,10 @@ int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
 	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=
 		 i_size_read(inode)) {
 		truncate_setsize(inode, iattr->ia_size);
+		truncate_pagecache(inode, iattr->ia_size);
+
 		if (v9ses->cache == CACHE_FSCACHE)
 			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
-		else
-			invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 
 	v9fs_invalidate_inode_attr(inode);
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 5fc6a945bfff..797f717e1a91 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -292,23 +292,26 @@ static int v9fs_write_inode(struct inode *inode,
 {
 	int ret;
 	struct p9_wstat wstat;
+	struct p9_fid *fid = v9fs_fid_find_inode(inode, false, INVALID_UID, true);
 	struct v9fs_inode *v9inode;
+
 	/*
 	 * send an fsync request to server irrespective of
 	 * wbc->sync_mode.
 	 */
-	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
+	p9_debug(P9_DEBUG_VFS, "%s: inode %p writeback_fid: %p\n", __func__, inode, fid);
 	v9inode = V9FS_I(inode);
-	if (!v9inode->writeback_fid)
-		return 0;
+	if (!fid)
+		return -EINVAL;
 	v9fs_blank_wstat(&wstat);
 
-	ret = p9_client_wstat(v9inode->writeback_fid, &wstat);
+	ret = p9_client_wstat(fid, &wstat);
 	if (ret < 0) {
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 		return ret;
 	}
 	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
+	p9_fid_put(fid);
 	return 0;
 }
 
@@ -316,6 +319,7 @@ static int v9fs_write_inode_dotl(struct inode *inode,
 				 struct writeback_control *wbc)
 {
 	int ret;
+	struct p9_fid *fid = v9fs_fid_find_inode(inode, FMODE_WRITE, INVALID_UID, 1);
 	struct v9fs_inode *v9inode;
 	/*
 	 * send an fsync request to server irrespective of
@@ -323,16 +327,17 @@ static int v9fs_write_inode_dotl(struct inode *inode,
 	 */
 	v9inode = V9FS_I(inode);
 	p9_debug(P9_DEBUG_VFS, "%s: inode %p, writeback_fid %p\n",
-		 __func__, inode, v9inode->writeback_fid);
-	if (!v9inode->writeback_fid)
-		return 0;
+		 __func__, inode, fid);
+	if (!fid)
+		return -EINVAL;
 
-	ret = p9_client_fsync(v9inode->writeback_fid, 0);
+	ret = p9_client_fsync(fid, 0);
 	if (ret < 0) {
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 		return ret;
 	}
 	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
+	p9_fid_put(fid);
 	return 0;
 }
 
-- 
2.37.2

