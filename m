Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8517A6C99C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjC0C7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 22:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjC0C7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:59:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F04ED3;
        Sun, 26 Mar 2023 19:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE004B80DA2;
        Mon, 27 Mar 2023 02:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDB3C433D2;
        Mon, 27 Mar 2023 02:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679885981;
        bh=5S7u0jK4Dbj2Eo7S2Z4cqy8/yEBYQg8xQ9tGJVPFsvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGQ9IpqIfupa+SKZCWKVXPAWDrCUVInBtEwUiBbICx76GN3ossHNVkBZf5k2k+veS
         AlwoogEONeefoNaX6qBrVI79RQEZo29nil0psleDfQPQ8YXoPLZTdUAfZTeE68QSQ0
         GSYr4eDGc87Aw/m+rLL5vHBNrJF++HwFXBVGcD95UFNMzmormrpRBKC7EBWExahFz3
         252h9ATQJF7Y+JJT0OrFAcSqbfmY1iDQN8LM4iHoHa9gUMmO5bEp6L2lAiZVAk4KCW
         FuDrx8oLwx8zs5JvD8opSvtRXKytdPFI8mICkK8mQiA1dShZQtovAS2Ayup2s/xoQZ
         z7SZPtju4SUmg==
Date:   Mon, 27 Mar 2023 02:59:37 +0000
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com
Subject: [PATCH v5] fs/9p: remove writeback fid and fix per-file modes
Message-ID: <ZCEGmS4FBRFClQjS@7e9e31583646>
References: <20230218003323.2322580-11-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-11-ericvh@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch removes the creating of an additional writeback_fid
for opened files.  The patch addresses problems when files
were opened write-only or getattr on files with dirty caches.

This patch also incorporates information about cache behavior
in the fid for every file.  This allows us to reflect cache
behavior from mount flags, open mode, and information from
the server to inform readahead and writeback behavior.

This includes adding support for a 9p semantic that qid.version==0
is used to mark a file as non-cachable which is important for
synthetic files.  This may have a side-effect of not supporting
caching on certain legacy file servers that do not properly set
qid.version.  There is also now a mount flag which can disable
the qid.version behavior.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.c            | 48 +++++++++-------------
 fs/9p/fid.h            | 33 ++++++++++++++-
 fs/9p/v9fs.h           |  1 -
 fs/9p/vfs_addr.c       | 22 +++++-----
 fs/9p/vfs_file.c       | 91 ++++++++++++++----------------------------
 fs/9p/vfs_inode.c      | 45 +++++++--------------
 fs/9p/vfs_inode_dotl.c | 48 +++++++++-------------
 fs/9p/vfs_super.c      | 33 ++++-----------
 8 files changed, 135 insertions(+), 186 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 805151114e96..de009a33e0e2 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -41,14 +41,24 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
 	*pfid = NULL;
 }
 
+static bool v9fs_is_writeable(int mode)
+{
+	if (mode & (P9_OWRITE|P9_ORDWR))
+		return true;
+	else
+		return false;
+}
+
 /**
  * v9fs_fid_find_inode - search for an open fid off of the inode list
  * @inode: return a fid pointing to a specific inode
+ * @want_writeable: only consider fids which are writeable
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
@@ -58,7 +68,12 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
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
@@ -118,7 +133,7 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		spin_unlock(&dentry->d_lock);
 	} else {
 		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, uid);
+			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 	}
 
 	return ret;
@@ -299,28 +314,3 @@ struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
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
index 12401f1be5d6..999cdbcbfed9 100644
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
index cd1f3f4079d7..9f1d464bc1b5 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -43,7 +43,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 	int err;
 	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid, *writeback_fid;
+	struct p9_fid *fid;
 	int omode;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
@@ -60,7 +60,19 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
 
-		err = p9_client_open(fid, omode);
+		if ((v9ses->cache >= CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
+			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
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
@@ -72,36 +84,14 @@ int v9fs_file_open(struct inode *inode, struct file *file)
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
@@ -367,14 +357,14 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -397,14 +387,17 @@ static ssize_t
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
@@ -488,36 +481,18 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
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
@@ -528,7 +503,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	struct v9fs_inode *v9inode;
 	struct folio *folio = page_folio(vmf->page);
 	struct file *filp = vmf->vma->vm_file;
 	struct inode *inode = file_inode(filp);
@@ -537,8 +511,6 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	p9_debug(P9_DEBUG_VFS, "folio %p fid %lx\n",
 		 folio, (unsigned long)filp->private_data);
 
-	v9inode = V9FS_I(inode);
-
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
@@ -551,7 +523,6 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* Update file times before taking page lock */
 	file_update_time(filp);
 
-	BUG_ON(!v9inode->writeback_fid);
 	if (folio_lock_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 	if (folio_mapping(folio) != inode->i_mapping)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 63590f55363b..fb5e5c0e41e4 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -230,7 +230,6 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 	v9inode = alloc_inode_sb(sb, v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
-	v9inode->writeback_fid = NULL;
 	v9inode->cache_validity = 0;
 	mutex_init(&v9inode->v_mutex);
 	return &v9inode->netfs.inode;
@@ -383,9 +382,6 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);
 
 	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
-	/* clunk the fid stashed in writeback_fid */
-	p9_fid_put(v9inode->writeback_fid);
-	v9inode->writeback_fid = NULL;
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
@@ -796,9 +792,10 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
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
@@ -817,9 +814,14 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 
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
@@ -828,25 +830,6 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
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
@@ -855,6 +838,8 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
+
+	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
 	v9fs_open_fid_add(inode, &fid);
 
 	file->f_mode |= FMODE_CREATED;
@@ -1024,7 +1009,7 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
+		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		return 0;
 	} else if (v9ses->cache >= CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode)) {
@@ -1128,10 +1113,10 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
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
index a28eb3aeab29..4b9488cb7a56 100644
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
@@ -464,9 +452,9 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
+		generic_fillattr(&nop_mnt_idmap, inode, stat);
 		return 0;
-	} else if (v9ses->cache >= CACHE_WRITEBACK) {
+	} else if (v9ses->cache) {
 		if (S_ISREG(inode->i_mode)) {
 			int retval = filemap_fdatawrite(inode->i_mapping);
 
@@ -613,6 +601,8 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=
 		 i_size_read(inode)) {
 		truncate_setsize(inode, iattr->ia_size);
+		truncate_pagecache(inode, iattr->ia_size);
+
 		if (v9ses->cache == CACHE_FSCACHE)
 			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
 	}
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 5fc6a945bfff..af83b39e340c 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -290,49 +290,30 @@ static int v9fs_drop_inode(struct inode *inode)
 static int v9fs_write_inode(struct inode *inode,
 			    struct writeback_control *wbc)
 {
-	int ret;
-	struct p9_wstat wstat;
 	struct v9fs_inode *v9inode;
+
 	/*
 	 * send an fsync request to server irrespective of
 	 * wbc->sync_mode.
 	 */
 	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
-	v9inode = V9FS_I(inode);
-	if (!v9inode->writeback_fid)
-		return 0;
-	v9fs_blank_wstat(&wstat);
 
-	ret = p9_client_wstat(v9inode->writeback_fid, &wstat);
-	if (ret < 0) {
-		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
-		return ret;
-	}
+	v9inode = V9FS_I(inode);
 	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
+
 	return 0;
 }
 
 static int v9fs_write_inode_dotl(struct inode *inode,
 				 struct writeback_control *wbc)
 {
-	int ret;
 	struct v9fs_inode *v9inode;
-	/*
-	 * send an fsync request to server irrespective of
-	 * wbc->sync_mode.
-	 */
+
 	v9inode = V9FS_I(inode);
-	p9_debug(P9_DEBUG_VFS, "%s: inode %p, writeback_fid %p\n",
-		 __func__, inode, v9inode->writeback_fid);
-	if (!v9inode->writeback_fid)
-		return 0;
-
-	ret = p9_client_fsync(v9inode->writeback_fid, 0);
-	if (ret < 0) {
-		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
-		return ret;
-	}
+	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
+
 	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
+
 	return 0;
 }
 
-- 
2.39.2

