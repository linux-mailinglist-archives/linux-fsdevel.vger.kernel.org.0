Return-Path: <linux-fsdevel+bounces-2576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB47E6DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5242816CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8B32C97;
	Thu,  9 Nov 2023 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFnRpdE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182432C86
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D2B3A94
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87N1O4mmEZt2VWiYkzNYqJKz6VpEGry0GJuAeDLDOEY=;
	b=HFnRpdE7RaUYdNh7k1LOxSZnonn2EvtIk8lmDzJzubMS+8Gn6o7b6f8Onsr+joE8+5GZnW
	oDhYAIFM+vfJO4/E0e4PjMigUJ3kz40B3rUULWGjnSdN51oXf58CsXvWFC/UTJhyfSa0iB
	MTbU5tK8T6eldZy6IdJQcDWAI45EwXs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-dASB8OOsO5iMEoaRcdmF_w-1; Thu,
 09 Nov 2023 10:41:11 -0500
X-MC-Unique: dASB8OOsO5iMEoaRcdmF_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E1072801A49;
	Thu,  9 Nov 2023 15:41:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC15119E93;
	Thu,  9 Nov 2023 15:41:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 36/41] afs: Move the vnode/volume validity checking code into its own file
Date: Thu,  9 Nov 2023 15:39:59 +0000
Message-ID: <20231109154004.3317227-37-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Move the code that does validity checking of vnodes and volumes with
respect to third-party changes into its own file.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/Makefile     |   1 +
 fs/afs/inode.c      | 174 -----------------------------------------
 fs/afs/internal.h   |  10 ++-
 fs/afs/validation.c | 185 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+), 177 deletions(-)
 create mode 100644 fs/afs/validation.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index b3849bea0553..dcdc0f1bb76f 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -28,6 +28,7 @@ kafs-y := \
 	server.o \
 	server_list.o \
 	super.o \
+	validation.o \
 	vlclient.o \
 	vl_alias.o \
 	vl_list.o \
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index b3d76faa83c0..8dbb09a79c4d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -572,180 +572,6 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	return ERR_PTR(ret);
 }
 
-/*
- * mark the data attached to an inode as obsolete due to a write on the server
- * - might also want to ditch all the outstanding writes and dirty pages
- */
-static void afs_zap_data(struct afs_vnode *vnode)
-{
-	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
-
-	afs_invalidate_cache(vnode, 0);
-
-	/* nuke all the non-dirty pages that aren't locked, mapped or being
-	 * written back in a regular file and completely discard the pages in a
-	 * directory or symlink */
-	if (S_ISREG(vnode->netfs.inode.i_mode))
-		invalidate_remote_inode(&vnode->netfs.inode);
-	else
-		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
-}
-
-/*
- * Check to see if we have a server currently serving this volume and that it
- * hasn't been reinitialised or dropped from the list.
- */
-static bool afs_check_server_good(struct afs_vnode *vnode)
-{
-	struct afs_server_list *slist;
-	struct afs_server *server;
-	bool good;
-	int i;
-
-	if (vnode->cb_fs_s_break == atomic_read(&vnode->volume->cell->fs_s_break))
-		return true;
-
-	rcu_read_lock();
-
-	slist = rcu_dereference(vnode->volume->servers);
-	for (i = 0; i < slist->nr_servers; i++) {
-		server = slist->servers[i].server;
-		if (server == vnode->cb_server) {
-			good = (vnode->cb_s_break == server->cb_s_break);
-			rcu_read_unlock();
-			return good;
-		}
-	}
-
-	rcu_read_unlock();
-	return false;
-}
-
-/*
- * Check the validity of a vnode/inode.
- */
-bool afs_check_validity(struct afs_vnode *vnode)
-{
-	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
-	time64_t now = ktime_get_real_seconds();
-	unsigned int cb_break;
-	int seq = 0;
-
-	do {
-		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
-		cb_break = vnode->cb_break;
-
-		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-			if (vnode->cb_v_break != vnode->volume->cb_v_break)
-				need_clear = afs_cb_break_for_v_break;
-			else if (!afs_check_server_good(vnode))
-				need_clear = afs_cb_break_for_s_reinit;
-			else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
-				need_clear = afs_cb_break_for_zap;
-			else if (vnode->cb_expires_at - 10 <= now)
-				need_clear = afs_cb_break_for_lapsed;
-		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-			;
-		} else {
-			need_clear = afs_cb_break_no_promise;
-		}
-
-	} while (need_seqretry(&vnode->cb_lock, seq));
-
-	done_seqretry(&vnode->cb_lock, seq);
-
-	if (need_clear == afs_cb_break_no_break)
-		return true;
-
-	write_seqlock(&vnode->cb_lock);
-	if (need_clear == afs_cb_break_no_promise)
-		vnode->cb_v_break = vnode->volume->cb_v_break;
-	else if (cb_break == vnode->cb_break)
-		__afs_break_callback(vnode, need_clear);
-	else
-		trace_afs_cb_miss(&vnode->fid, need_clear);
-	write_sequnlock(&vnode->cb_lock);
-	return false;
-}
-
-/*
- * Returns true if the pagecache is still valid.  Does not sleep.
- */
-bool afs_pagecache_valid(struct afs_vnode *vnode)
-{
-	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
-		if (vnode->netfs.inode.i_nlink)
-			clear_nlink(&vnode->netfs.inode);
-		return true;
-	}
-
-	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
-	    afs_check_validity(vnode))
-		return true;
-
-	return false;
-}
-
-/*
- * validate a vnode/inode
- * - there are several things we need to check
- *   - parent dir data changes (rm, rmdir, rename, mkdir, create, link,
- *     symlink)
- *   - parent dir metadata changed (security changes)
- *   - dentry data changed (write, truncate)
- *   - dentry metadata changed (security changes)
- */
-int afs_validate(struct afs_vnode *vnode, struct key *key)
-{
-	int ret;
-
-	_enter("{v={%llx:%llu} fl=%lx},%x",
-	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
-	       key_serial(key));
-
-	if (afs_pagecache_valid(vnode))
-		goto valid;
-
-	down_write(&vnode->validate_lock);
-
-	/* if the promise has expired, we need to check the server again to get
-	 * a new promise - note that if the (parent) directory's metadata was
-	 * changed then the security may be different and we may no longer have
-	 * access */
-	if (!test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-		_debug("not promised");
-		ret = afs_fetch_status(vnode, key, false, NULL);
-		if (ret < 0) {
-			if (ret == -ENOENT) {
-				set_bit(AFS_VNODE_DELETED, &vnode->flags);
-				ret = -ESTALE;
-			}
-			goto error_unlock;
-		}
-		_debug("new promise [fl=%lx]", vnode->flags);
-	}
-
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		_debug("file already deleted");
-		ret = -ESTALE;
-		goto error_unlock;
-	}
-
-	/* if the vnode's data version number changed then its contents are
-	 * different */
-	if (test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
-		afs_zap_data(vnode);
-	up_write(&vnode->validate_lock);
-valid:
-	_leave(" = 0");
-	return 0;
-
-error_unlock:
-	up_write(&vnode->validate_lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * read the attributes of an inode
  */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 22cf782fe924..0a4ecfc250bf 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1234,9 +1234,6 @@ extern int afs_ilookup5_test_by_fid(struct inode *, void *);
 extern struct inode *afs_iget_pseudo_dir(struct super_block *, bool);
 extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
-extern bool afs_check_validity(struct afs_vnode *);
-extern int afs_validate(struct afs_vnode *, struct key *);
-bool afs_pagecache_valid(struct afs_vnode *);
 extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
 		       struct kstat *, u32, unsigned int);
 extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, struct iattr *);
@@ -1546,6 +1543,13 @@ void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server
 extern int __init afs_fs_init(void);
 extern void afs_fs_exit(void);
 
+/*
+ * validation.c
+ */
+bool afs_check_validity(struct afs_vnode *vnode);
+bool afs_pagecache_valid(struct afs_vnode *vnode);
+int afs_validate(struct afs_vnode *vnode, struct key *key);
+
 /*
  * vlclient.c
  */
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
new file mode 100644
index 000000000000..188ccc8e0fcf
--- /dev/null
+++ b/fs/afs/validation.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* vnode and volume validity verification.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include "internal.h"
+
+/*
+ * mark the data attached to an inode as obsolete due to a write on the server
+ * - might also want to ditch all the outstanding writes and dirty pages
+ */
+static void afs_zap_data(struct afs_vnode *vnode)
+{
+	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
+
+	afs_invalidate_cache(vnode, 0);
+
+	/* nuke all the non-dirty pages that aren't locked, mapped or being
+	 * written back in a regular file and completely discard the pages in a
+	 * directory or symlink */
+	if (S_ISREG(vnode->netfs.inode.i_mode))
+		invalidate_remote_inode(&vnode->netfs.inode);
+	else
+		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
+}
+
+/*
+ * Check to see if we have a server currently serving this volume and that it
+ * hasn't been reinitialised or dropped from the list.
+ */
+static bool afs_check_server_good(struct afs_vnode *vnode)
+{
+	struct afs_server_list *slist;
+	struct afs_server *server;
+	bool good;
+	int i;
+
+	if (vnode->cb_fs_s_break == atomic_read(&vnode->volume->cell->fs_s_break))
+		return true;
+
+	rcu_read_lock();
+
+	slist = rcu_dereference(vnode->volume->servers);
+	for (i = 0; i < slist->nr_servers; i++) {
+		server = slist->servers[i].server;
+		if (server == vnode->cb_server) {
+			good = (vnode->cb_s_break == server->cb_s_break);
+			rcu_read_unlock();
+			return good;
+		}
+	}
+
+	rcu_read_unlock();
+	return false;
+}
+
+/*
+ * Check the validity of a vnode/inode.
+ */
+bool afs_check_validity(struct afs_vnode *vnode)
+{
+	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
+	time64_t now = ktime_get_real_seconds();
+	unsigned int cb_break;
+	int seq = 0;
+
+	do {
+		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
+		cb_break = vnode->cb_break;
+
+		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+			if (vnode->cb_v_break != vnode->volume->cb_v_break)
+				need_clear = afs_cb_break_for_v_break;
+			else if (!afs_check_server_good(vnode))
+				need_clear = afs_cb_break_for_s_reinit;
+			else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
+				need_clear = afs_cb_break_for_zap;
+			else if (vnode->cb_expires_at - 10 <= now)
+				need_clear = afs_cb_break_for_lapsed;
+		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+			;
+		} else {
+			need_clear = afs_cb_break_no_promise;
+		}
+
+	} while (need_seqretry(&vnode->cb_lock, seq));
+
+	done_seqretry(&vnode->cb_lock, seq);
+
+	if (need_clear == afs_cb_break_no_break)
+		return true;
+
+	write_seqlock(&vnode->cb_lock);
+	if (need_clear == afs_cb_break_no_promise)
+		vnode->cb_v_break = vnode->volume->cb_v_break;
+	else if (cb_break == vnode->cb_break)
+		__afs_break_callback(vnode, need_clear);
+	else
+		trace_afs_cb_miss(&vnode->fid, need_clear);
+	write_sequnlock(&vnode->cb_lock);
+	return false;
+}
+
+/*
+ * Returns true if the pagecache is still valid.  Does not sleep.
+ */
+bool afs_pagecache_valid(struct afs_vnode *vnode)
+{
+	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
+		if (vnode->netfs.inode.i_nlink)
+			clear_nlink(&vnode->netfs.inode);
+		return true;
+	}
+
+	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
+	    afs_check_validity(vnode))
+		return true;
+
+	return false;
+}
+
+/*
+ * validate a vnode/inode
+ * - there are several things we need to check
+ *   - parent dir data changes (rm, rmdir, rename, mkdir, create, link,
+ *     symlink)
+ *   - parent dir metadata changed (security changes)
+ *   - dentry data changed (write, truncate)
+ *   - dentry metadata changed (security changes)
+ */
+int afs_validate(struct afs_vnode *vnode, struct key *key)
+{
+	int ret;
+
+	_enter("{v={%llx:%llu} fl=%lx},%x",
+	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
+	       key_serial(key));
+
+	if (afs_pagecache_valid(vnode))
+		goto valid;
+
+	down_write(&vnode->validate_lock);
+
+	/* if the promise has expired, we need to check the server again to get
+	 * a new promise - note that if the (parent) directory's metadata was
+	 * changed then the security may be different and we may no longer have
+	 * access */
+	if (!test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+		_debug("not promised");
+		ret = afs_fetch_status(vnode, key, false, NULL);
+		if (ret < 0) {
+			if (ret == -ENOENT) {
+				set_bit(AFS_VNODE_DELETED, &vnode->flags);
+				ret = -ESTALE;
+			}
+			goto error_unlock;
+		}
+		_debug("new promise [fl=%lx]", vnode->flags);
+	}
+
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		_debug("file already deleted");
+		ret = -ESTALE;
+		goto error_unlock;
+	}
+
+	/* if the vnode's data version number changed then its contents are
+	 * different */
+	if (test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
+		afs_zap_data(vnode);
+	up_write(&vnode->validate_lock);
+valid:
+	_leave(" = 0");
+	return 0;
+
+error_unlock:
+	up_write(&vnode->validate_lock);
+	_leave(" = %d", ret);
+	return ret;
+}


