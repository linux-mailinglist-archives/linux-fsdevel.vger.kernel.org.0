Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD76505A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 00:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiLRXZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Dec 2022 18:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLRXYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Dec 2022 18:24:50 -0500
Received: from ms11p00im-qufo17281301.me.com (ms11p00im-qufo17281301.me.com [17.58.38.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185FB7FC
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Dec 2022 15:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671405888;
        bh=UKXPxnOVOmFmz8taPT0O6GjmM2XIDmBokAiQGyxCAWk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=lPHb4MmZoHG0yDUP+wlBFkJltAoQYTHtoRcMewMMsFWzBOkd9tgiEoy286AOm3mqn
         jsQSoIikT4gAKKjkI74VIHN2qc7NtNO7IUA7C0YNKvuYlyNMQHTjJAl85uCrATAn+6
         wMP2xcxA1V817y/oTAQ0kTxB8GC4HqtjqpGNmRxUHmbdAlKirujvNp1RGQ5swj1Owu
         9dOFrKwScxzeboKsJCU8Wb6fVndslanyF/pRKOs2yyN1p+8iRMtYWVQsTZpY/8Rkgk
         xsvoCp2dfjfIJ6mPI6bgJ3CR036fTYIefhzh1gioaqs0Ia+jGfCY+kCifmZmcrcXcV
         b9e4SSkDz3iag==
Received: from thundercleese.localdomain (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-qufo17281301.me.com (Postfix) with ESMTPSA id 97EC2CC02ED;
        Sun, 18 Dec 2022 23:24:47 +0000 (UTC)
From:   Eric Van Hensbergen <evanhensbergen@icloud.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com,
        Eric Van Hensbergen <evanhensbergen@icloud.com>
Subject: [PATCH v2 10/10] writeback mode fixes
Date:   Sun, 18 Dec 2022 23:22:27 +0000
Message-Id: <20221218232217.1713283-11-evanhensbergen@icloud.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221218232217.1713283-1-evanhensbergen@icloud.com>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GKnfkdih05XKypaoSRUIO65gd0hMiUMZ
X-Proofpoint-GUID: GKnfkdih05XKypaoSRUIO65gd0hMiUMZ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212180223
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
---
 Documentation/filesystems/9p.rst | 24 ++++-----
 fs/9p/fid.c                      | 23 +++++++--
 fs/9p/fid.h                      | 32 ++++++++++++
 fs/9p/v9fs.h                     |  1 -
 fs/9p/vfs_addr.c                 | 22 ++++----
 fs/9p/vfs_file.c                 | 88 +++++++++++---------------------
 fs/9p/vfs_inode.c                | 45 ++++++----------
 fs/9p/vfs_inode_dotl.c           | 44 ++++++----------
 fs/9p/vfs_super.c                | 21 +++++---
 9 files changed, 150 insertions(+), 150 deletions(-)

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
index 805151114e96..4f326a7019d3 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -41,14 +41,24 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
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
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 8a4e8cd12ca2..b248221e7906 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -7,7 +7,10 @@
 #ifndef FS_9P_FID_H
 #define FS_9P_FID_H
 #include <linux/list.h>
+#include "v9fs.h"
 
+struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
+	kuid_t uid, bool any);
 struct p9_fid *v9fs_fid_lookup(struct dentry *dentry);
 static inline struct p9_fid *v9fs_parent_fid(struct dentry *dentry)
 {
@@ -32,4 +35,33 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
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
index c80c318ff31c..9c6bc57512bf 100644
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
index 9da47465e568..b9f857f15757 100644
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
 
 	iov_iter_xarray(&from, WRITE, &folio_mapping(folio)->i_pages, start, len);
 
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
index 64158664dcb4..b9873e81215e 100644
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
@@ -551,7 +526,6 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* Update file times before taking page lock */
 	file_update_time(filp);
 
-	BUG_ON(!v9inode->writeback_fid);
 	if (folio_lock_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 	if (folio_mapping(folio) != inode->i_mapping)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index de99f9275a94..c61709d98934 100644
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
@@ -1024,7 +1009,7 @@ v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(&init_user_ns, d_inode(dentry), stat);
+		generic_fillattr(&init_user_ns, inode, stat);
 		return 0;
 	} else if (v9ses->cache >= CACHE_WRITEBACK) {
 		if (S_ISREG(inode->i_mode))
@@ -1119,10 +1104,10 @@ static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
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
index 708cd728cc70..36e7ccdf11df 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -232,12 +232,13 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	int err = 0;
 	kgid_t gid;
 	umode_t mode;
+	int p9_omode = v9fs_open_to_dotl_flags(flags);
 	const unsigned char *name = NULL;
 	struct p9_qid qid;
 	struct inode *inode;
 	struct p9_fid *fid = NULL;
 	struct v9fs_inode *v9inode;
-	struct p9_fid *dfid = NULL, *ofid = NULL, *inode_fid = NULL;
+	struct p9_fid *dfid = NULL, *ofid = NULL;
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 	struct dentry *res = NULL;
@@ -282,14 +283,19 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
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
@@ -315,25 +321,6 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	d_instantiate(dentry, inode);
 
 	v9inode = V9FS_I(inode);
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
@@ -344,6 +331,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
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
 			filemap_write_and_wait(inode->i_mapping);
 	}
@@ -604,10 +592,10 @@ int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns,
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

