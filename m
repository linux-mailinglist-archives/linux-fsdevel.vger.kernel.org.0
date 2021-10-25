Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2F43977C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 15:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhJYN1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 09:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhJYN1R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9698E60F9D;
        Mon, 25 Oct 2021 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635168295;
        bh=Db/zYhpdYgyd45R5dDGEc9iPBHq0aZVSoZ2qUFduJoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJtjOsKHNZkh8TpfMtr5yktFVipcNyFsjHe19Z3FTDxlrWUK9ee//EKcNjUCRlZbv
         k5KT8HrOToH2lil3zIacxmneT+hkjXWDjWSrdZOqtHynZxBMCVKFR2LiIkkF6hYInU
         hN7YFScB6bOsGnAIWVMPZNo1m4GueKcC5TJtgVnkkvR34KKrr937x+JhjRGQcxUt5k
         CYN7ieb1eysT8qprgljSvH9cJs7WeUyQ3j3c4REsvnMsBXdO9n7rATIotHI7k378Sh
         RDIuH5g9v1Ufh2jtV8xlH4N8OOCWvvUBS9RDutSWOazZZ1BXGSpj51b7/hdhhVqLqo
         F54MkYpIujXnQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ceph: conversion to new fscache API
Date:   Mon, 25 Oct 2021 09:24:51 -0400
Message-Id: <20211025132452.101591-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025132452.101591-1-jlayton@kernel.org>
References: <20211025132452.101591-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the fscache API has been reworked and simplified, change ceph
over to use it.

With the old API, we would only instantiate a cookie when the file was
open for reads. Change it to instantiate the cookie when the inode is
instantiated and call use/unuse when the file is opened/closed.

Also, ensure we resize the cached data on truncates, and invalidate the
cache in response to the appropriate events. This will allow us to
plumb in write support later.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Kconfig |   2 +-
 fs/ceph/addr.c  |  32 ++++----
 fs/ceph/cache.c | 196 +++++++++++++++++++++---------------------------
 fs/ceph/cache.h |  96 +++++++++++++++++-------
 fs/ceph/caps.c  |   3 +-
 fs/ceph/file.c  |  13 +++-
 fs/ceph/inode.c |  22 ++++--
 fs/ceph/super.c |  10 +--
 fs/ceph/super.h |   4 +-
 9 files changed, 204 insertions(+), 174 deletions(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 77ad452337ee..94df854147d3 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -21,7 +21,7 @@ config CEPH_FS
 if CEPH_FS
 config CEPH_FSCACHE
 	bool "Enable Ceph client caching support"
-	depends on CEPH_FS=m && FSCACHE_OLD || CEPH_FS=y && FSCACHE_OLD=y
+	depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
 	help
 	  Choose Y here to enable persistent, read-only local
 	  caching support for Ceph clients using FS-Cache
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b39aebc2ed95..09ba8a53c035 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -126,7 +126,7 @@ static int ceph_set_page_dirty(struct page *page)
 	BUG_ON(PagePrivate(page));
 	attach_page_private(page, snapc);
 
-	return __set_page_dirty_nobuffers(page);
+	return ceph_fscache_set_page_dirty(page);
 }
 
 /*
@@ -141,8 +141,6 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
 
-	wait_on_page_fscache(page);
-
 	inode = page->mapping->host;
 	ci = ceph_inode(inode);
 
@@ -153,28 +151,36 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	WARN_ON(!PageLocked(page));
-	if (!PagePrivate(page))
-		return;
+	if (PagePrivate(page)) {
+		dout("%p invalidatepage %p idx %lu full dirty page\n",
+		     inode, page, page->index);
 
-	dout("%p invalidatepage %p idx %lu full dirty page\n",
-	     inode, page, page->index);
+		snapc = detach_page_private(page);
+		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
+		ceph_put_snap_context(snapc);
+	}
 
-	snapc = detach_page_private(page);
-	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
-	ceph_put_snap_context(snapc);
+	wait_on_page_fscache(page);
 }
 
 static int ceph_releasepage(struct page *page, gfp_t gfp)
 {
-	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
-	     page, page->index, PageDirty(page) ? "" : "not ");
+	struct inode *inode = page->mapping->host;
+
+	dout("%llx:%llx releasepage %p idx %lu (%sdirty)\n",
+	     ceph_vinop(inode), page,
+	     page->index, PageDirty(page) ? "" : "not ");
+
+	if (PagePrivate(page))
+		return 0;
 
 	if (PageFsCache(page)) {
 		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
 			return 0;
 		wait_on_page_fscache(page);
 	}
-	return !PagePrivate(page);
+	ceph_fscache_note_page_release(inode);
+	return 1;
 }
 
 static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 457afda5498a..a0b26dacfd5f 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -12,36 +12,93 @@
 #include "super.h"
 #include "cache.h"
 
-struct fscache_netfs ceph_cache_netfs = {
-	.name		= "ceph",
-	.version	= 0,
-};
-
 static DEFINE_MUTEX(ceph_fscache_lock);
 static LIST_HEAD(ceph_fscache_list);
 
 struct ceph_fscache_entry {
 	struct list_head list;
-	struct fscache_cookie *fscache;
+	struct fscache_volume *fscache;
 	size_t uniq_len;
 	/* The following members must be last */
 	struct ceph_fsid fsid;
 	char uniquifier[];
 };
 
-static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
-	.name		= "CEPH.fsid",
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
+void ceph_fscache_register_inode_cookie(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+
+	/* No caching for filesystem? */
+	if (!fsc->fscache)
+		return;
+
+	/* Regular files only */
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	/* Only new inodes! */
+	if (!(inode->i_state & I_NEW))
+		return;
+
+	WARN_ON_ONCE(ci->fscache);
+
+	ci->fscache = fscache_acquire_cookie(fsc->fscache, 0,
+					     &ci->i_vino, sizeof(ci->i_vino),
+					     &ci->i_version, sizeof(ci->i_version),
+					     i_size_read(inode));
+}
 
-int __init ceph_fscache_register(void)
+void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
 {
-	return fscache_register_netfs(&ceph_cache_netfs);
+	struct fscache_cookie* cookie = xchg(&ci->fscache, NULL);
+
+	if (cookie)
+		fscache_relinquish_cookie(cookie, false);
 }
 
-void ceph_fscache_unregister(void)
+void ceph_fscache_use_cookie(struct inode *inode, bool will_modify)
 {
-	fscache_unregister_netfs(&ceph_cache_netfs);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (ci->fscache)
+		fscache_use_cookie(ci->fscache, will_modify);
+}
+
+void ceph_fscache_unuse_cookie(struct inode *inode, bool update)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (!ci->fscache)
+		return;
+
+	if (update) {
+		loff_t i_size = i_size_read(inode);
+
+		fscache_unuse_cookie(ci->fscache, &ci->i_version, &i_size);
+	} else {
+		fscache_unuse_cookie(ci->fscache, NULL, NULL);
+	}
+}
+
+void ceph_fscache_update(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	loff_t i_size = i_size_read(inode);
+
+	if (!ci->fscache)
+		return;
+
+	fscache_update_cookie(ci->fscache, &ci->i_version, &i_size);
+}
+
+void ceph_fscache_invalidate(struct inode *inode, bool dio_write)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	fscache_invalidate(ceph_inode(inode)->fscache,
+			   &ci->i_version, i_size_read(inode),
+			   dio_write ? FSCACHE_INVAL_DIO_WRITE : 0);
 }
 
 int ceph_fscache_register_fs(struct ceph_fs_client* fsc, struct fs_context *fc)
@@ -50,6 +107,7 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc, struct fs_context *fc)
 	const char *fscache_uniq = fsc->mount_options->fscache_uniq;
 	size_t uniq_len = fscache_uniq ? strlen(fscache_uniq) : 0;
 	struct ceph_fscache_entry *ent;
+	char *name;
 	int err = 0;
 
 	mutex_lock(&ceph_fscache_lock);
@@ -79,116 +137,32 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc, struct fs_context *fc)
 		ent->uniq_len = uniq_len;
 	}
 
-	fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
-					      &ceph_fscache_fsid_object_def,
-					      &ent->fsid, sizeof(ent->fsid) + uniq_len,
-					      NULL, 0,
-					      fsc, 0, true);
+	name = kasprintf(GFP_KERNEL, "ceph,%pU%s%s", fsid, uniq_len ? "," : "",
+			 uniq_len ? fscache_uniq : "");
+	if (!name) {
+		err = -ENOMEM;
+		kfree(ent);
+		goto out_unlock;
+	}
+
+	fsc->fscache = fscache_acquire_volume(name, NULL, 0);
 
 	if (fsc->fscache) {
 		ent->fscache = fsc->fscache;
 		list_add_tail(&ent->list, &ceph_fscache_list);
 	} else {
 		kfree(ent);
-		errorfc(fc, "unable to register fscache cookie for fsid %pU",
-		       fsid);
-		/* all other fs ignore this error */
+		errorfc(fc, "Unable to register fscache cookie for %s", name);
 	}
+	kfree(name);
 out_unlock:
 	mutex_unlock(&ceph_fscache_lock);
 	return err;
 }
 
-static enum fscache_checkaux ceph_fscache_inode_check_aux(
-	void *cookie_netfs_data, const void *data, uint16_t dlen,
-	loff_t object_size)
-{
-	struct ceph_inode_info* ci = cookie_netfs_data;
-	struct inode* inode = &ci->vfs_inode;
-
-	if (dlen != sizeof(ci->i_version) ||
-	    i_size_read(inode) != object_size)
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	if (*(u64 *)data != ci->i_version)
-		return FSCACHE_CHECKAUX_OBSOLETE;
-
-	dout("ceph inode 0x%p cached okay\n", ci);
-	return FSCACHE_CHECKAUX_OKAY;
-}
-
-static const struct fscache_cookie_def ceph_fscache_inode_object_def = {
-	.name		= "CEPH.inode",
-	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= ceph_fscache_inode_check_aux,
-};
-
-void ceph_fscache_register_inode_cookie(struct inode *inode)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
-
-	/* No caching for filesystem */
-	if (!fsc->fscache)
-		return;
-
-	/* Only cache for regular files that are read only */
-	if (!S_ISREG(inode->i_mode))
-		return;
-
-	inode_lock_nested(inode, I_MUTEX_CHILD);
-	if (!ci->fscache) {
-		ci->fscache = fscache_acquire_cookie(fsc->fscache,
-						     &ceph_fscache_inode_object_def,
-						     &ci->i_vino, sizeof(ci->i_vino),
-						     &ci->i_version, sizeof(ci->i_version),
-						     ci, i_size_read(inode), false);
-	}
-	inode_unlock(inode);
-}
-
-void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
-{
-	struct fscache_cookie* cookie;
-
-	if ((cookie = ci->fscache) == NULL)
-		return;
-
-	ci->fscache = NULL;
-
-	fscache_relinquish_cookie(cookie, &ci->i_vino, false);
-}
-
-static bool ceph_fscache_can_enable(void *data)
-{
-	struct inode *inode = data;
-	return !inode_is_open_for_write(inode);
-}
-
-void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-
-	if (!fscache_cookie_valid(ci->fscache))
-		return;
-
-	if (inode_is_open_for_write(inode)) {
-		dout("fscache_file_set_cookie %p %p disabling cache\n",
-		     inode, filp);
-		fscache_disable_cookie(ci->fscache, &ci->i_vino, false);
-	} else {
-		fscache_enable_cookie(ci->fscache, &ci->i_vino, i_size_read(inode),
-				      ceph_fscache_can_enable, inode);
-		if (fscache_cookie_enabled(ci->fscache)) {
-			dout("fscache_file_set_cookie %p %p enabling cache\n",
-			     inode, filp);
-		}
-	}
-}
-
 void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
 {
-	if (fscache_cookie_valid(fsc->fscache)) {
+	if (fscache_volume_valid(fsc->fscache)) {
 		struct ceph_fscache_entry *ent;
 		bool found = false;
 
@@ -204,7 +178,7 @@ void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
 		WARN_ON_ONCE(!found);
 		mutex_unlock(&ceph_fscache_lock);
 
-		__fscache_relinquish_cookie(fsc->fscache, NULL, false);
+		__fscache_relinquish_volume(fsc->fscache, 0, false);
 	}
 	fsc->fscache = NULL;
 }
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index b94d3f38fb25..50e91d094276 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -12,19 +12,20 @@
 #include <linux/netfs.h>
 
 #ifdef CONFIG_CEPH_FSCACHE
-
-extern struct fscache_netfs ceph_cache_netfs;
-
-int ceph_fscache_register(void);
-void ceph_fscache_unregister(void);
+#define FSCACHE_USE_NEW_IO_API
+#include <linux/fscache.h>
 
 int ceph_fscache_register_fs(struct ceph_fs_client* fsc, struct fs_context *fc);
 void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
 
 void ceph_fscache_register_inode_cookie(struct inode *inode);
 void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci);
-void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp);
-void ceph_fscache_revalidate_cookie(struct ceph_inode_info *ci);
+
+void ceph_fscache_use_cookie(struct inode *inode, bool will_modify);
+void ceph_fscache_unuse_cookie(struct inode *inode, bool update);
+
+void ceph_fscache_update(struct inode *inode);
+void ceph_fscache_invalidate(struct inode *inode, bool dio_write);
 
 static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
 {
@@ -36,18 +37,30 @@ static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_inode_info
 	return ci->fscache;
 }
 
-static inline void ceph_fscache_invalidate(struct inode *inode)
+static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
 {
-	fscache_invalidate(ceph_inode(inode)->fscache);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
+
+	if (cookie) {
+		ceph_fscache_use_cookie(inode, true);
+		fscache_resize_cookie(cookie, to);
+		ceph_fscache_unuse_cookie(inode, true);
+	}
 }
 
-static inline bool ceph_is_cache_enabled(struct inode *inode)
+static inline void ceph_fscache_unpin_writeback(struct inode *inode,
+						struct writeback_control *wbc)
 {
-	struct fscache_cookie *cookie = ceph_fscache_cookie(ceph_inode(inode));
+	fscache_unpin_writeback(wbc, ceph_fscache_cookie(ceph_inode(inode)));
+}
+
+static inline int ceph_fscache_set_page_dirty(struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	struct ceph_inode_info *ci = ceph_inode(inode);
 
-	if (!cookie)
-		return false;
-	return fscache_cookie_enabled(cookie);
+	return fscache_set_page_dirty(page, ceph_fscache_cookie(ci));
 }
 
 static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
@@ -56,17 +69,19 @@ static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
 
 	return fscache_begin_read_operation(&rreq->cache_resources, cookie);
 }
-#else
 
-static inline int ceph_fscache_register(void)
+static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
-	return 0;
+	return fscache_cookie_enabled(ceph_fscache_cookie(ceph_inode(inode)));
 }
 
-static inline void ceph_fscache_unregister(void)
+static inline void ceph_fscache_note_page_release(struct inode *inode)
 {
-}
+	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	fscache_note_page_release(ceph_fscache_cookie(ci));
+}
+#else /* CONFIG_CEPH_FSCACHE */
 static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc,
 					   struct fs_context *fc)
 {
@@ -81,28 +96,49 @@ static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
 {
 }
 
-static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_inode_info *ci)
+static inline void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
-	return NULL;
 }
 
-static inline void ceph_fscache_register_inode_cookie(struct inode *inode)
+static inline void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
 {
 }
 
-static inline void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
+static inline void ceph_fscache_use_cookie(struct inode *inode, bool will_modify)
 {
 }
 
-static inline void ceph_fscache_file_set_cookie(struct inode *inode,
-						struct file *filp)
+static inline void ceph_fscache_unuse_cookie(struct inode *inode, bool update)
 {
 }
 
-static inline void ceph_fscache_invalidate(struct inode *inode)
+static inline void ceph_fscache_update(struct inode *inode)
 {
 }
 
+static inline void ceph_fscache_invalidate(struct inode *inode, bool dio_write)
+{
+}
+
+static inline struct fscache_cookie *ceph_fscache_cookie(struct ceph_inode_info *ci)
+{
+	return NULL;
+}
+
+static inline void ceph_fscache_resize(struct inode *inode, loff_t to)
+{
+}
+
+static inline void ceph_fscache_unpin_writeback(struct inode *inode,
+						struct writeback_control *wbc)
+{
+}
+
+static inline int ceph_fscache_set_page_dirty(struct page *page)
+{
+	return __set_page_dirty_nobuffers(page);
+}
+
 static inline bool ceph_is_cache_enabled(struct inode *inode)
 {
 	return false;
@@ -112,6 +148,10 @@ static inline int ceph_begin_cache_operation(struct netfs_read_request *rreq)
 {
 	return -ENOBUFS;
 }
-#endif
 
-#endif /* _CEPH_CACHE_H */
+static inline void ceph_fscache_note_page_release(struct inode *inode)
+{
+}
+#endif /* CONFIG_CEPH_FSCACHE */
+
+#endif
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 21268d2c6e56..10dabedd1c11 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1857,7 +1857,7 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	u32 invalidating_gen = ci->i_rdcache_gen;
 
 	spin_unlock(&ci->i_ceph_lock);
-	ceph_fscache_invalidate(inode);
+	ceph_fscache_invalidate(inode, false);
 	invalidate_mapping_pages(&inode->i_data, 0, -1);
 	spin_lock(&ci->i_ceph_lock);
 
@@ -2388,6 +2388,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
 
 	dout("write_inode %p wait=%d\n", inode, wait);
+	ceph_fscache_unpin_writeback(inode, wbc);
 	if (wait) {
 		dirty = try_flush_caps(inode, &flush_tid);
 		if (dirty)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 91173d3aa161..ffd815d006f6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -248,8 +248,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
-		ceph_fscache_register_inode_cookie(inode);
-		ceph_fscache_file_set_cookie(inode, file);
+		ceph_fscache_use_cookie(inode, file->f_mode & FMODE_WRITE);
 		fallthrough;
 	case S_IFDIR:
 		ret = ceph_init_file_info(inode, file, fmode,
@@ -810,6 +809,7 @@ int ceph_release(struct inode *inode, struct file *file)
 		dout("release inode %p regular file %p\n", inode, file);
 		WARN_ON(!list_empty(&fi->rw_contexts));
 
+		ceph_fscache_unuse_cookie(inode, file->f_mode & FMODE_WRITE);
 		ceph_put_fmode(ci, fi->fmode, 1);
 
 		kmem_cache_free(ceph_file_cachep, fi);
@@ -1203,7 +1203,11 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	     snapc, snapc ? snapc->seq : 0);
 
 	if (write) {
-		int ret2 = invalidate_inode_pages2_range(inode->i_mapping,
+		int ret2;
+
+		ceph_fscache_invalidate(inode, true);
+
+		ret2 = invalidate_inode_pages2_range(inode->i_mapping,
 					pos >> PAGE_SHIFT,
 					(pos + count - 1) >> PAGE_SHIFT);
 		if (ret2 < 0)
@@ -1414,6 +1418,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	if (ret < 0)
 		return ret;
 
+	ceph_fscache_invalidate(inode, false);
 	ret = invalidate_inode_pages2_range(inode->i_mapping,
 					    pos >> PAGE_SHIFT,
 					    (pos + count - 1) >> PAGE_SHIFT);
@@ -2098,6 +2103,7 @@ static long ceph_fallocate(struct file *file, int mode,
 		goto unlock;
 
 	filemap_invalidate_lock(inode->i_mapping);
+	ceph_fscache_invalidate(inode, false);
 	ceph_zero_pagecache_range(inode, offset, length);
 	ret = ceph_zero_objects(inode, offset, length);
 
@@ -2366,6 +2372,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		goto out_caps;
 
 	/* Drop dst file cached pages */
+	ceph_fscache_invalidate(dst_inode, false);
 	ret = invalidate_inode_pages2_range(dst_inode->i_mapping,
 					    dst_off >> PAGE_SHIFT,
 					    (dst_off + len) >> PAGE_SHIFT);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9e2fbc799eb1..29768003e0bf 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -565,6 +565,8 @@ void ceph_evict_inode(struct inode *inode)
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
 	truncate_inode_pages_final(&inode->i_data);
+	if (inode->i_state & I_PINNING_FSCACHE_WB)
+		ceph_fscache_unuse_cookie(inode, true);
 	clear_inode(inode);
 
 	ceph_fscache_unregister_inode_cookie(ci);
@@ -635,6 +637,12 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 		}
 		i_size_write(inode, size);
 		inode->i_blocks = calc_inode_blocks(size);
+		/*
+		 * If we're truncating up, then we should be able to just update
+		 * the existing cookie.
+		 */
+		if (size > isize)
+			ceph_fscache_update(inode);
 		ci->i_reported_size = size;
 		if (truncate_seq != ci->i_truncate_seq) {
 			dout("truncate_seq %u -> %u\n",
@@ -667,10 +675,6 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 		     truncate_size);
 		ci->i_truncate_size = truncate_size;
 	}
-
-	if (queue_trunc)
-		ceph_fscache_invalidate(inode);
-
 	return queue_trunc;
 }
 
@@ -1054,6 +1058,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 
 	spin_unlock(&ci->i_ceph_lock);
 
+	ceph_fscache_register_inode_cookie(inode);
+
 	if (fill_inline)
 		ceph_fill_inline_data(inode, locked_page,
 				      iinfo->inline_data, iinfo->inline_len);
@@ -1815,11 +1821,13 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 	spin_lock(&ci->i_ceph_lock);
 	dout("set_size %p %llu -> %llu\n", inode, i_size_read(inode), size);
 	i_size_write(inode, size);
+	ceph_fscache_update(inode);
 	inode->i_blocks = calc_inode_blocks(size);
 
 	ret = __ceph_should_report_size(ci);
 
 	spin_unlock(&ci->i_ceph_lock);
+
 	return ret;
 }
 
@@ -1845,6 +1853,8 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	u32 orig_gen;
 	int check = 0;
 
+	ceph_fscache_invalidate(inode, false);
+
 	mutex_lock(&ci->i_truncate_mutex);
 
 	if (ceph_inode_is_shutdown(inode)) {
@@ -1869,7 +1879,7 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	orig_gen = ci->i_rdcache_gen;
 	spin_unlock(&ci->i_ceph_lock);
 
-	ceph_fscache_invalidate(inode);
+	ceph_fscache_invalidate(inode, false);
 	if (invalidate_inode_pages2(inode->i_mapping) < 0) {
 		pr_err("invalidate_pages %llx:%llx failed\n", ceph_vinop(inode));
 	}
@@ -1937,6 +1947,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	     ci->i_truncate_pending, to);
 	spin_unlock(&ci->i_ceph_lock);
 
+	ceph_fscache_resize(inode, to);
 	truncate_pagecache(inode, to);
 
 	spin_lock(&ci->i_ceph_lock);
@@ -2184,7 +2195,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (inode_dirty_flags)
 		__mark_inode_dirty(inode, inode_dirty_flags);
 
-
 	if (mask) {
 		req->r_inode = inode;
 		ihold(inode);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 59038dd0cf97..587d7d8b4f8e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -913,16 +913,10 @@ static int __init init_caches(void)
 	if (!ceph_wb_pagevec_pool)
 		goto bad_pagevec_pool;
 
-	error = ceph_fscache_register();
-	if (error)
-		goto bad_fscache;
-
 	return 0;
 
-bad_fscache:
-	kmem_cache_destroy(ceph_mds_request_cachep);
 bad_pagevec_pool:
-	mempool_destroy(ceph_wb_pagevec_pool);
+	kmem_cache_destroy(ceph_mds_request_cachep);
 bad_mds_req:
 	kmem_cache_destroy(ceph_dir_file_cachep);
 bad_dir_file:
@@ -954,8 +948,6 @@ static void destroy_caches(void)
 	kmem_cache_destroy(ceph_dir_file_cachep);
 	kmem_cache_destroy(ceph_mds_request_cachep);
 	mempool_destroy(ceph_wb_pagevec_pool);
-
-	ceph_fscache_unregister();
 }
 
 static void __ceph_umount_begin(struct ceph_fs_client *fsc)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1dc7dabe73d5..e41cad2979fd 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_CEPH_FSCACHE
 #define FSCACHE_USE_NEW_IO_API
-#include <linux/fscache_old.h>
+#include <linux/fscache.h>
 #endif
 
 /* f_type in struct statfs */
@@ -139,7 +139,7 @@ struct ceph_fs_client {
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
-	struct fscache_cookie *fscache;
+	struct fscache_volume *fscache;
 #endif
 };
 
-- 
2.31.1

