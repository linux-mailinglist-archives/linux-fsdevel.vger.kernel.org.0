Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DCB1E8AB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgE2WBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:01:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40863 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728608AbgE2WBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuHOrWEG5E46dTq16rxejlZFBRp1qXaHa708A4wj0GA=;
        b=JPRAWvAK3KT1H7QqpuMvkpzMbDHXh7mbq2Qfe9TJwDlA821BiEM7CD6ME5/TIMQ35ECGSG
        flFSHt67Tizz+rcnVYl9AObFX0+MKnEDsWQ82hsUwVBoSYerAPtKCf2yJARJYNdGLnHDQh
        hpFliDiIBs+Giv90BvtQfxC44RscaRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-4Uv-1lIVPSqYlftM-5PmCA-1; Fri, 29 May 2020 18:01:35 -0400
X-MC-Unique: 4Uv-1lIVPSqYlftM-5PmCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48E5E107ACCA;
        Fri, 29 May 2020 22:01:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5C755D9EF;
        Fri, 29 May 2020 22:01:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/27] afs: Rename struct afs_fs_cursor to afs_operation
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:01:32 +0100
Message-ID: <159078969202.679399.9518004488603448625.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a prelude to implementing asynchronous fileserver operations in the afs
filesystem, rename struct afs_fs_cursor to afs_operation.

This struct is going to form the core of the operation management and is
going to acquire more members in later.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c       |   22 ++--
 fs/afs/dir_silly.c |    4 -
 fs/afs/file.c      |    2 
 fs/afs/flock.c     |    6 +
 fs/afs/fsclient.c  |   42 ++++---
 fs/afs/inode.c     |   10 +-
 fs/afs/internal.h  |  112 ++++++++++----------
 fs/afs/rotate.c    |  292 ++++++++++++++++++++++++++--------------------------
 fs/afs/server.c    |    8 +
 fs/afs/super.c     |    4 -
 fs/afs/volume.c    |    4 -
 fs/afs/write.c     |    2 
 fs/afs/xattr.c     |    8 +
 fs/afs/yfsclient.c |   40 ++++---
 14 files changed, 278 insertions(+), 278 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3c486340b220..ff421db40cf2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -643,7 +643,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
 	struct afs_status_cb *scb;
 	struct afs_iget_data iget_data;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_server *server;
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
 	struct inode *inode = NULL, *ti;
@@ -1220,7 +1220,7 @@ void afs_d_release(struct dentry *dentry)
 /*
  * Create a new inode for create/mkdir/symlink
  */
-static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
+static void afs_vnode_new_inode(struct afs_operation *fc,
 				struct dentry *new_dentry,
 				struct afs_iget_data *new_data,
 				struct afs_status_cb *new_scb)
@@ -1248,7 +1248,7 @@ static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
 	d_instantiate(new_dentry, inode);
 }
 
-static void afs_prep_for_new_inode(struct afs_fs_cursor *fc,
+static void afs_prep_for_new_inode(struct afs_operation *fc,
 				   struct afs_iget_data *iget_data)
 {
 	iget_data->volume = fc->vnode->volume;
@@ -1261,7 +1261,7 @@ static void afs_prep_for_new_inode(struct afs_fs_cursor *fc,
  * number derived from the result of the operation.  It doesn't matter if
  * d_fsdata goes backwards as we'll just revalidate.
  */
-static void afs_update_dentry_version(struct afs_fs_cursor *fc,
+static void afs_update_dentry_version(struct afs_operation *fc,
 				      struct dentry *dentry,
 				      struct afs_status_cb *scb)
 {
@@ -1277,7 +1277,7 @@ static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct afs_iget_data iget_data;
 	struct afs_status_cb *scb;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct key *key;
 	afs_dataversion_t data_version;
@@ -1367,7 +1367,7 @@ static void afs_dir_remove_subdir(struct dentry *dentry)
 static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct afs_status_cb *scb;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode = NULL;
 	struct key *key;
 	afs_dataversion_t data_version;
@@ -1483,7 +1483,7 @@ static int afs_dir_remove_link(struct afs_vnode *dvnode, struct dentry *dentry,
  */
 static int afs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
@@ -1588,7 +1588,7 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		      bool excl)
 {
 	struct afs_iget_data iget_data;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct key *key;
@@ -1666,7 +1666,7 @@ static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int afs_link(struct dentry *from, struct inode *dir,
 		    struct dentry *dentry)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(from));
@@ -1755,7 +1755,7 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 		       const char *content)
 {
 	struct afs_iget_data iget_data;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct key *key;
@@ -1837,7 +1837,7 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		      struct inode *new_dir, struct dentry *new_dentry,
 		      unsigned int flags)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *orig_dvnode, *new_dvnode, *vnode;
 	struct dentry *tmp = NULL, *rehash = NULL;
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index d94e2b7cddff..0a82b134aa0d 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -19,7 +19,7 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
 			       struct dentry *old, struct dentry *new,
 			       struct key *key)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	afs_dataversion_t dir_data_version;
 	int ret = -ERESTARTSYS;
@@ -145,7 +145,7 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 static int afs_do_silly_unlink(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 			       struct dentry *dentry, struct key *key)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	int ret = -ERESTARTSYS;
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8415733f7bc1..0c0ccc1412ee 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -225,7 +225,7 @@ static void afs_file_readpage_read_complete(struct page *page,
  */
 int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *req)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	int ret;
 
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 0f2a94ba73cb..682fe745f10e 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -179,7 +179,7 @@ static int afs_set_lock(struct afs_vnode *vnode, struct key *key,
 			afs_lock_type_t type)
 {
 	struct afs_status_cb *scb;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	int ret;
 
 	_enter("%s{%llx:%llu.%u},%x,%u",
@@ -216,7 +216,7 @@ static int afs_set_lock(struct afs_vnode *vnode, struct key *key,
 static int afs_extend_lock(struct afs_vnode *vnode, struct key *key)
 {
 	struct afs_status_cb *scb;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	int ret;
 
 	_enter("%s{%llx:%llu.%u},%x",
@@ -253,7 +253,7 @@ static int afs_extend_lock(struct afs_vnode *vnode, struct key *key)
 static int afs_release_lock(struct afs_vnode *vnode, struct key *key)
 {
 	struct afs_status_cb *scb;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	int ret;
 
 	_enter("%s{%llx:%llu.%u},%x",
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 7d4503174dd1..3e423e9daa24 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -272,7 +272,7 @@ static const struct afs_call_type afs_RXFSFetchStatus_vnode = {
 /*
  * fetch the status information for a file
  */
-int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_status_cb *scb,
+int afs_fs_fetch_file_status(struct afs_operation *fc, struct afs_status_cb *scb,
 			     struct afs_volsync *volsync)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -470,7 +470,7 @@ static const struct afs_call_type afs_RXFSFetchData64 = {
 /*
  * fetch data from a very large file
  */
-static int afs_fs_fetch_data64(struct afs_fs_cursor *fc,
+static int afs_fs_fetch_data64(struct afs_operation *fc,
 			       struct afs_status_cb *scb,
 			       struct afs_read *req)
 {
@@ -511,7 +511,7 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc,
 /*
  * fetch data from a file
  */
-int afs_fs_fetch_data(struct afs_fs_cursor *fc,
+int afs_fs_fetch_data(struct afs_operation *fc,
 		      struct afs_status_cb *scb,
 		      struct afs_read *req)
 {
@@ -599,7 +599,7 @@ static const struct afs_call_type afs_RXFSMakeDir = {
 /*
  * create a file or make a directory
  */
-int afs_fs_create(struct afs_fs_cursor *fc,
+int afs_fs_create(struct afs_operation *fc,
 		  const char *name,
 		  umode_t mode,
 		  struct afs_status_cb *dvnode_scb,
@@ -707,7 +707,7 @@ static const struct afs_call_type afs_RXFSRemoveDir = {
 /*
  * remove a file or directory
  */
-int afs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+int afs_fs_remove(struct afs_operation *fc, struct afs_vnode *vnode,
 		  const char *name, bool isdir, struct afs_status_cb *dvnode_scb)
 {
 	struct afs_vnode *dvnode = fc->vnode;
@@ -792,7 +792,7 @@ static const struct afs_call_type afs_RXFSLink = {
 /*
  * make a hard link
  */
-int afs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+int afs_fs_link(struct afs_operation *fc, struct afs_vnode *vnode,
 		const char *name,
 		struct afs_status_cb *dvnode_scb,
 		struct afs_status_cb *vnode_scb)
@@ -882,7 +882,7 @@ static const struct afs_call_type afs_RXFSSymlink = {
 /*
  * create a symbolic link
  */
-int afs_fs_symlink(struct afs_fs_cursor *fc,
+int afs_fs_symlink(struct afs_operation *fc,
 		   const char *name,
 		   const char *contents,
 		   struct afs_status_cb *dvnode_scb,
@@ -990,7 +990,7 @@ static const struct afs_call_type afs_RXFSRename = {
 /*
  * Rename/move a file or directory.
  */
-int afs_fs_rename(struct afs_fs_cursor *fc,
+int afs_fs_rename(struct afs_operation *fc,
 		  const char *orig_name,
 		  struct afs_vnode *new_dvnode,
 		  const char *new_name,
@@ -1105,7 +1105,7 @@ static const struct afs_call_type afs_RXFSStoreData64 = {
 /*
  * store a set of pages to a very large file
  */
-static int afs_fs_store_data64(struct afs_fs_cursor *fc,
+static int afs_fs_store_data64(struct afs_operation *fc,
 			       struct address_space *mapping,
 			       pgoff_t first, pgoff_t last,
 			       unsigned offset, unsigned to,
@@ -1165,7 +1165,7 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 /*
  * store a set of pages
  */
-int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
+int afs_fs_store_data(struct afs_operation *fc, struct address_space *mapping,
 		      pgoff_t first, pgoff_t last,
 		      unsigned offset, unsigned to,
 		      struct afs_status_cb *scb)
@@ -1291,7 +1291,7 @@ static const struct afs_call_type afs_RXFSStoreData64_as_Status = {
  * set the attributes on a very large file, using FS.StoreData rather than
  * FS.StoreStatus so as to alter the file size also
  */
-static int afs_fs_setattr_size64(struct afs_fs_cursor *fc, struct iattr *attr,
+static int afs_fs_setattr_size64(struct afs_operation *fc, struct iattr *attr,
 				 struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1340,7 +1340,7 @@ static int afs_fs_setattr_size64(struct afs_fs_cursor *fc, struct iattr *attr,
  * set the attributes on a file, using FS.StoreData rather than FS.StoreStatus
  * so as to alter the file size also
  */
-static int afs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr,
+static int afs_fs_setattr_size(struct afs_operation *fc, struct iattr *attr,
 			       struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1388,7 +1388,7 @@ static int afs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr,
  * set the attributes on a file, using FS.StoreData if there's a change in file
  * size, and FS.StoreStatus otherwise
  */
-int afs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr,
+int afs_fs_setattr(struct afs_operation *fc, struct iattr *attr,
 		   struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1569,7 +1569,7 @@ static const struct afs_call_type afs_RXFSGetVolumeStatus = {
 /*
  * fetch the status of a volume
  */
-int afs_fs_get_volume_status(struct afs_fs_cursor *fc,
+int afs_fs_get_volume_status(struct afs_operation *fc,
 			     struct afs_volume_status *vs)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1659,7 +1659,7 @@ static const struct afs_call_type afs_RXFSReleaseLock = {
 /*
  * Set a lock on a file
  */
-int afs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type,
+int afs_fs_set_lock(struct afs_operation *fc, afs_lock_type_t type,
 		    struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1698,7 +1698,7 @@ int afs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type,
 /*
  * extend a lock on a file
  */
-int afs_fs_extend_lock(struct afs_fs_cursor *fc, struct afs_status_cb *scb)
+int afs_fs_extend_lock(struct afs_operation *fc, struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
@@ -1735,7 +1735,7 @@ int afs_fs_extend_lock(struct afs_fs_cursor *fc, struct afs_status_cb *scb)
 /*
  * release a lock on a file
  */
-int afs_fs_release_lock(struct afs_fs_cursor *fc, struct afs_status_cb *scb)
+int afs_fs_release_lock(struct afs_operation *fc, struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
@@ -1941,7 +1941,7 @@ static const struct afs_call_type afs_RXFSFetchStatus = {
 /*
  * Fetch the status information for a fid without needing a vnode handle.
  */
-int afs_fs_fetch_status(struct afs_fs_cursor *fc,
+int afs_fs_fetch_status(struct afs_operation *fc,
 			struct afs_net *net,
 			struct afs_fid *fid,
 			struct afs_status_cb *scb,
@@ -2101,7 +2101,7 @@ static const struct afs_call_type afs_RXFSInlineBulkStatus = {
 /*
  * Fetch the status information for up to 50 files
  */
-int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
+int afs_fs_inline_bulk_status(struct afs_operation *fc,
 			      struct afs_net *net,
 			      struct afs_fid *fids,
 			      struct afs_status_cb *statuses,
@@ -2234,7 +2234,7 @@ static const struct afs_call_type afs_RXFSFetchACL = {
 /*
  * Fetch the ACL for a file.
  */
-struct afs_acl *afs_fs_fetch_acl(struct afs_fs_cursor *fc,
+struct afs_acl *afs_fs_fetch_acl(struct afs_operation *fc,
 				 struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -2303,7 +2303,7 @@ static const struct afs_call_type afs_RXFSStoreACL = {
 /*
  * Fetch the ACL for a file.
  */
-int afs_fs_store_acl(struct afs_fs_cursor *fc, const struct afs_acl *acl,
+int afs_fs_store_acl(struct afs_operation *fc, const struct afs_acl *acl,
 		     struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 07933d106e0e..d2dbb3aef611 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -161,7 +161,7 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key,
 /*
  * Update the core inode struct from a returned status record.
  */
-static void afs_apply_status(struct afs_fs_cursor *fc,
+static void afs_apply_status(struct afs_operation *fc,
 			     struct afs_vnode *vnode,
 			     struct afs_status_cb *scb,
 			     const afs_dataversion_t *expected_version)
@@ -243,7 +243,7 @@ static void afs_apply_status(struct afs_fs_cursor *fc,
 /*
  * Apply a callback to a vnode.
  */
-static void afs_apply_callback(struct afs_fs_cursor *fc,
+static void afs_apply_callback(struct afs_operation *fc,
 			       struct afs_vnode *vnode,
 			       struct afs_status_cb *scb,
 			       unsigned int cb_break)
@@ -267,7 +267,7 @@ static void afs_apply_callback(struct afs_fs_cursor *fc,
  * Apply the received status and callback to an inode all in the same critical
  * section to avoid races with afs_validate().
  */
-void afs_vnode_commit_status(struct afs_fs_cursor *fc,
+void afs_vnode_commit_status(struct afs_operation *fc,
 			     struct afs_vnode *vnode,
 			     unsigned int cb_break,
 			     const afs_dataversion_t *expected_version,
@@ -304,7 +304,7 @@ int afs_fetch_status(struct afs_vnode *vnode, struct key *key, bool is_new,
 		     afs_access_t *_caller_access)
 {
 	struct afs_status_cb *scb;
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	int ret;
 
 	_enter("%s,{%llx:%llu.%u,S=%lx}",
@@ -813,7 +813,7 @@ void afs_evict_inode(struct inode *inode)
  */
 int afs_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
 	struct key *key;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 468bd2b0470d..0551dedb0371 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -766,7 +766,7 @@ struct afs_vl_cursor {
 /*
  * Cursor for iterating over a set of fileservers.
  */
-struct afs_fs_cursor {
+struct afs_operation {
 	const struct afs_call_type *type;	/* Type of call done */
 	struct afs_addr_cursor	ac;
 	struct afs_vnode	*vnode;
@@ -779,13 +779,13 @@ struct afs_fs_cursor {
 	short			index;		/* Current server */
 	short			error;
 	unsigned short		flags;
-#define AFS_FS_CURSOR_STOP	0x0001		/* Set to cease iteration */
-#define AFS_FS_CURSOR_VBUSY	0x0002		/* Set if seen VBUSY */
-#define AFS_FS_CURSOR_VMOVED	0x0004		/* Set if seen VMOVED */
-#define AFS_FS_CURSOR_VNOVOL	0x0008		/* Set if seen VNOVOL */
-#define AFS_FS_CURSOR_CUR_ONLY	0x0010		/* Set if current server only (file lock held) */
-#define AFS_FS_CURSOR_NO_VSLEEP	0x0020		/* Set to prevent sleep on VBUSY, VOFFLINE, ... */
-#define AFS_FS_CURSOR_INTR	0x0040		/* Set if op is interruptible */
+#define AFS_OPERATION_STOP	0x0001		/* Set to cease iteration */
+#define AFS_OPERATION_VBUSY	0x0002		/* Set if seen VBUSY */
+#define AFS_OPERATION_VMOVED	0x0004		/* Set if seen VMOVED */
+#define AFS_OPERATION_VNOVOL	0x0008		/* Set if seen VNOVOL */
+#define AFS_OPERATION_CUR_ONLY	0x0010		/* Set if current server only (file lock held) */
+#define AFS_OPERATION_NO_VSLEEP	0x0020		/* Set to prevent sleep on VBUSY, VOFFLINE, ... */
+#define AFS_OPERATION_INTR	0x0040		/* Set if op is interruptible */
 	unsigned short		nr_iterations;	/* Number of server iterations */
 };
 
@@ -958,35 +958,35 @@ extern int afs_flock(struct file *, int, struct file_lock *);
 /*
  * fsclient.c
  */
-extern int afs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_status_cb *,
+extern int afs_fs_fetch_file_status(struct afs_operation *, struct afs_status_cb *,
 				    struct afs_volsync *);
-extern int afs_fs_fetch_data(struct afs_fs_cursor *, struct afs_status_cb *, struct afs_read *);
-extern int afs_fs_create(struct afs_fs_cursor *, const char *, umode_t,
+extern int afs_fs_fetch_data(struct afs_operation *, struct afs_status_cb *, struct afs_read *);
+extern int afs_fs_create(struct afs_operation *, const char *, umode_t,
 			 struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
-extern int afs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char *, bool,
+extern int afs_fs_remove(struct afs_operation *, struct afs_vnode *, const char *, bool,
 			 struct afs_status_cb *);
-extern int afs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *,
+extern int afs_fs_link(struct afs_operation *, struct afs_vnode *, const char *,
 		       struct afs_status_cb *, struct afs_status_cb *);
-extern int afs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
+extern int afs_fs_symlink(struct afs_operation *, const char *, const char *,
 			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
-extern int afs_fs_rename(struct afs_fs_cursor *, const char *,
+extern int afs_fs_rename(struct afs_operation *, const char *,
 			 struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
-extern int afs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
+extern int afs_fs_store_data(struct afs_operation *, struct address_space *,
 			     pgoff_t, pgoff_t, unsigned, unsigned, struct afs_status_cb *);
-extern int afs_fs_setattr(struct afs_fs_cursor *, struct iattr *, struct afs_status_cb *);
-extern int afs_fs_get_volume_status(struct afs_fs_cursor *, struct afs_volume_status *);
-extern int afs_fs_set_lock(struct afs_fs_cursor *, afs_lock_type_t, struct afs_status_cb *);
-extern int afs_fs_extend_lock(struct afs_fs_cursor *, struct afs_status_cb *);
-extern int afs_fs_release_lock(struct afs_fs_cursor *, struct afs_status_cb *);
+extern int afs_fs_setattr(struct afs_operation *, struct iattr *, struct afs_status_cb *);
+extern int afs_fs_get_volume_status(struct afs_operation *, struct afs_volume_status *);
+extern int afs_fs_set_lock(struct afs_operation *, afs_lock_type_t, struct afs_status_cb *);
+extern int afs_fs_extend_lock(struct afs_operation *, struct afs_status_cb *);
+extern int afs_fs_release_lock(struct afs_operation *, struct afs_status_cb *);
 extern int afs_fs_give_up_all_callbacks(struct afs_net *, struct afs_server *,
 					struct afs_addr_cursor *, struct key *);
 extern bool afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
 				    struct afs_addr_cursor *, struct key *);
-extern int afs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
+extern int afs_fs_inline_bulk_status(struct afs_operation *, struct afs_net *,
 				     struct afs_fid *, struct afs_status_cb *,
 				     unsigned int, struct afs_volsync *);
-extern int afs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
+extern int afs_fs_fetch_status(struct afs_operation *, struct afs_net *,
 			       struct afs_fid *, struct afs_status_cb *,
 			       struct afs_volsync *);
 
@@ -995,8 +995,8 @@ struct afs_acl {
 	u8	data[];
 };
 
-extern struct afs_acl *afs_fs_fetch_acl(struct afs_fs_cursor *, struct afs_status_cb *);
-extern int afs_fs_store_acl(struct afs_fs_cursor *, const struct afs_acl *,
+extern struct afs_acl *afs_fs_fetch_acl(struct afs_operation *, struct afs_status_cb *);
+extern int afs_fs_store_acl(struct afs_operation *, const struct afs_acl *,
 			    struct afs_status_cb *);
 
 /*
@@ -1010,7 +1010,7 @@ extern void afs_fs_probe_dispatcher(struct work_struct *);
 /*
  * inode.c
  */
-extern void afs_vnode_commit_status(struct afs_fs_cursor *,
+extern void afs_vnode_commit_status(struct afs_operation *,
 				    struct afs_vnode *,
 				    unsigned int,
 				    const afs_dataversion_t *,
@@ -1109,11 +1109,11 @@ static inline void afs_put_sysnames(struct afs_sysnames *sysnames) {}
 /*
  * rotate.c
  */
-extern bool afs_begin_vnode_operation(struct afs_fs_cursor *, struct afs_vnode *,
+extern bool afs_begin_vnode_operation(struct afs_operation *, struct afs_vnode *,
 				      struct key *, bool);
-extern bool afs_select_fileserver(struct afs_fs_cursor *);
-extern bool afs_select_current_fileserver(struct afs_fs_cursor *);
-extern int afs_end_vnode_operation(struct afs_fs_cursor *);
+extern bool afs_select_fileserver(struct afs_operation *);
+extern bool afs_select_current_fileserver(struct afs_operation *);
+extern int afs_end_vnode_operation(struct afs_operation *);
 
 /*
  * rxrpc.c
@@ -1135,10 +1135,10 @@ extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 
-static inline void afs_set_fc_call(struct afs_call *call, struct afs_fs_cursor *fc)
+static inline void afs_set_fc_call(struct afs_call *call, struct afs_operation *op)
 {
-	call->intr = fc->flags & AFS_FS_CURSOR_INTR;
-	fc->type = call->type;
+	call->intr = op->flags & AFS_OPERATION_INTR;
+	op->type = call->type;
 }
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
@@ -1256,7 +1256,7 @@ extern void afs_manage_servers(struct work_struct *);
 extern void afs_servers_timer(struct timer_list *);
 extern void afs_fs_probe_timer(struct timer_list *);
 extern void __net_exit afs_purge_servers(struct afs_net *);
-extern bool afs_check_server_record(struct afs_fs_cursor *, struct afs_server *);
+extern bool afs_check_server_record(struct afs_operation *, struct afs_server *);
 
 static inline void afs_inc_servers_outstanding(struct afs_net *net)
 {
@@ -1358,7 +1358,7 @@ extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern void afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
 extern void afs_put_volume(struct afs_cell *, struct afs_volume *);
-extern int afs_check_volume_status(struct afs_volume *, struct afs_fs_cursor *);
+extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 
 /*
  * write.c
@@ -1387,34 +1387,34 @@ extern ssize_t afs_listxattr(struct dentry *, char *, size_t);
 /*
  * yfsclient.c
  */
-extern int yfs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_status_cb *,
+extern int yfs_fs_fetch_file_status(struct afs_operation *, struct afs_status_cb *,
 				    struct afs_volsync *);
-extern int yfs_fs_fetch_data(struct afs_fs_cursor *, struct afs_status_cb *, struct afs_read *);
-extern int yfs_fs_create_file(struct afs_fs_cursor *, const char *, umode_t, struct afs_status_cb *,
+extern int yfs_fs_fetch_data(struct afs_operation *, struct afs_status_cb *, struct afs_read *);
+extern int yfs_fs_create_file(struct afs_operation *, const char *, umode_t, struct afs_status_cb *,
 			      struct afs_fid *, struct afs_status_cb *);
-extern int yfs_fs_make_dir(struct afs_fs_cursor *, const char *, umode_t, struct afs_status_cb *,
+extern int yfs_fs_make_dir(struct afs_operation *, const char *, umode_t, struct afs_status_cb *,
 			   struct afs_fid *, struct afs_status_cb *);
-extern int yfs_fs_remove_file2(struct afs_fs_cursor *, struct afs_vnode *, const char *,
+extern int yfs_fs_remove_file2(struct afs_operation *, struct afs_vnode *, const char *,
 			       struct afs_status_cb *, struct afs_status_cb *);
-extern int yfs_fs_remove(struct afs_fs_cursor *, struct afs_vnode *, const char *, bool,
+extern int yfs_fs_remove(struct afs_operation *, struct afs_vnode *, const char *, bool,
 			 struct afs_status_cb *);
-extern int yfs_fs_link(struct afs_fs_cursor *, struct afs_vnode *, const char *,
+extern int yfs_fs_link(struct afs_operation *, struct afs_vnode *, const char *,
 		       struct afs_status_cb *, struct afs_status_cb *);
-extern int yfs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
+extern int yfs_fs_symlink(struct afs_operation *, const char *, const char *,
 			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
-extern int yfs_fs_rename(struct afs_fs_cursor *, const char *, struct afs_vnode *, const char *,
+extern int yfs_fs_rename(struct afs_operation *, const char *, struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
-extern int yfs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
+extern int yfs_fs_store_data(struct afs_operation *, struct address_space *,
 			     pgoff_t, pgoff_t, unsigned, unsigned, struct afs_status_cb *);
-extern int yfs_fs_setattr(struct afs_fs_cursor *, struct iattr *, struct afs_status_cb *);
-extern int yfs_fs_get_volume_status(struct afs_fs_cursor *, struct afs_volume_status *);
-extern int yfs_fs_set_lock(struct afs_fs_cursor *, afs_lock_type_t, struct afs_status_cb *);
-extern int yfs_fs_extend_lock(struct afs_fs_cursor *, struct afs_status_cb *);
-extern int yfs_fs_release_lock(struct afs_fs_cursor *, struct afs_status_cb *);
-extern int yfs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
+extern int yfs_fs_setattr(struct afs_operation *, struct iattr *, struct afs_status_cb *);
+extern int yfs_fs_get_volume_status(struct afs_operation *, struct afs_volume_status *);
+extern int yfs_fs_set_lock(struct afs_operation *, afs_lock_type_t, struct afs_status_cb *);
+extern int yfs_fs_extend_lock(struct afs_operation *, struct afs_status_cb *);
+extern int yfs_fs_release_lock(struct afs_operation *, struct afs_status_cb *);
+extern int yfs_fs_fetch_status(struct afs_operation *, struct afs_net *,
 			       struct afs_fid *, struct afs_status_cb *,
 			       struct afs_volsync *);
-extern int yfs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
+extern int yfs_fs_inline_bulk_status(struct afs_operation *, struct afs_net *,
 				     struct afs_fid *, struct afs_status_cb *,
 				     unsigned int, struct afs_volsync *);
 
@@ -1429,9 +1429,9 @@ struct yfs_acl {
 };
 
 extern void yfs_free_opaque_acl(struct yfs_acl *);
-extern struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *, struct yfs_acl *,
+extern struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_operation *, struct yfs_acl *,
 					       struct afs_status_cb *);
-extern int yfs_fs_store_opaque_acl2(struct afs_fs_cursor *, const struct afs_acl *,
+extern int yfs_fs_store_opaque_acl2(struct afs_operation *, const struct afs_acl *,
 				    struct afs_status_cb *);
 
 /*
@@ -1447,10 +1447,10 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 	return &vnode->vfs_inode;
 }
 
-static inline void afs_check_for_remote_deletion(struct afs_fs_cursor *fc,
+static inline void afs_check_for_remote_deletion(struct afs_operation *op,
 						 struct afs_vnode *vnode)
 {
-	if (fc->ac.error == -ENOENT) {
+	if (op->ac.error == -ENOENT) {
 		set_bit(AFS_VNODE_DELETED, &vnode->flags);
 		afs_break_callback(vnode, afs_cb_break_for_deleted);
 	}
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 46b68da89faa..c930033473f6 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -20,20 +20,20 @@
  * Fileserver operations are serialised on the server by vnode, so we serialise
  * them here also using the io_lock.
  */
-bool afs_begin_vnode_operation(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+bool afs_begin_vnode_operation(struct afs_operation *op, struct afs_vnode *vnode,
 			       struct key *key, bool intr)
 {
-	memset(fc, 0, sizeof(*fc));
-	fc->vnode = vnode;
-	fc->key = key;
-	fc->ac.error = SHRT_MAX;
-	fc->error = -EDESTADDRREQ;
+	memset(op, 0, sizeof(*op));
+	op->vnode = vnode;
+	op->key = key;
+	op->ac.error = SHRT_MAX;
+	op->error = -EDESTADDRREQ;
 
 	if (intr) {
-		fc->flags |= AFS_FS_CURSOR_INTR;
+		op->flags |= AFS_OPERATION_INTR;
 		if (mutex_lock_interruptible(&vnode->io_lock) < 0) {
-			fc->error = -EINTR;
-			fc->flags |= AFS_FS_CURSOR_STOP;
+			op->error = -EINTR;
+			op->flags |= AFS_OPERATION_STOP;
 			return false;
 		}
 	} else {
@@ -41,7 +41,7 @@ bool afs_begin_vnode_operation(struct afs_fs_cursor *fc, struct afs_vnode *vnode
 	}
 
 	if (vnode->lock_state != AFS_VNODE_LOCK_NONE)
-		fc->flags |= AFS_FS_CURSOR_CUR_ONLY;
+		op->flags |= AFS_OPERATION_CUR_ONLY;
 	return true;
 }
 
@@ -49,26 +49,26 @@ bool afs_begin_vnode_operation(struct afs_fs_cursor *fc, struct afs_vnode *vnode
  * Begin iteration through a server list, starting with the vnode's last used
  * server if possible, or the last recorded good server if not.
  */
-static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
+static bool afs_start_fs_iteration(struct afs_operation *op,
 				   struct afs_vnode *vnode)
 {
 	struct afs_cb_interest *cbi;
 	int i;
 
 	read_lock(&vnode->volume->servers_lock);
-	fc->server_list = afs_get_serverlist(vnode->volume->servers);
+	op->server_list = afs_get_serverlist(vnode->volume->servers);
 	read_unlock(&vnode->volume->servers_lock);
 
-	fc->untried = (1UL << fc->server_list->nr_servers) - 1;
-	fc->index = READ_ONCE(fc->server_list->preferred);
+	op->untried = (1UL << op->server_list->nr_servers) - 1;
+	op->index = READ_ONCE(op->server_list->preferred);
 
 	cbi = rcu_dereference_protected(vnode->cb_interest,
 					lockdep_is_held(&vnode->io_lock));
 	if (cbi) {
 		/* See if the vnode's preferred record is still available */
-		for (i = 0; i < fc->server_list->nr_servers; i++) {
-			if (fc->server_list->servers[i].cb_interest == cbi) {
-				fc->index = i;
+		for (i = 0; i < op->server_list->nr_servers; i++) {
+			if (op->server_list->servers[i].cb_interest == cbi) {
+				op->index = i;
 				goto found_interest;
 			}
 		}
@@ -77,8 +77,8 @@ static bool afs_start_fs_iteration(struct afs_fs_cursor *fc,
 		 * serving this vnode, then we can't switch to another server
 		 * and have to return an error.
 		 */
-		if (fc->flags & AFS_FS_CURSOR_CUR_ONLY) {
-			fc->error = -ESTALE;
+		if (op->flags & AFS_OPERATION_CUR_ONLY) {
+			op->error = -ESTALE;
 			return false;
 		}
 
@@ -118,12 +118,12 @@ static void afs_busy(struct afs_volume *volume, u32 abort_code)
 /*
  * Sleep and retry the operation to the same fileserver.
  */
-static bool afs_sleep_and_retry(struct afs_fs_cursor *fc)
+static bool afs_sleep_and_retry(struct afs_operation *op)
 {
-	if (fc->flags & AFS_FS_CURSOR_INTR) {
+	if (op->flags & AFS_OPERATION_INTR) {
 		msleep_interruptible(1000);
 		if (signal_pending(current)) {
-			fc->error = -ERESTARTSYS;
+			op->error = -ERESTARTSYS;
 			return false;
 		}
 	} else {
@@ -137,26 +137,26 @@ static bool afs_sleep_and_retry(struct afs_fs_cursor *fc)
  * Select the fileserver to use.  May be called multiple times to rotate
  * through the fileservers.
  */
-bool afs_select_fileserver(struct afs_fs_cursor *fc)
+bool afs_select_fileserver(struct afs_operation *op)
 {
 	struct afs_addr_list *alist;
 	struct afs_server *server;
-	struct afs_vnode *vnode = fc->vnode;
+	struct afs_vnode *vnode = op->vnode;
 	struct afs_error e;
 	u32 rtt;
-	int error = fc->ac.error, i;
+	int error = op->ac.error, i;
 
 	_enter("%lx[%d],%lx[%d],%d,%d",
-	       fc->untried, fc->index,
-	       fc->ac.tried, fc->ac.index,
-	       error, fc->ac.abort_code);
+	       op->untried, op->index,
+	       op->ac.tried, op->ac.index,
+	       error, op->ac.abort_code);
 
-	if (fc->flags & AFS_FS_CURSOR_STOP) {
+	if (op->flags & AFS_OPERATION_STOP) {
 		_leave(" = f [stopped]");
 		return false;
 	}
 
-	fc->nr_iterations++;
+	op->nr_iterations++;
 
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (error) {
@@ -166,8 +166,8 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */
-		fc->error = error;
-		fc->flags |= AFS_FS_CURSOR_STOP;
+		op->error = error;
+		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [okay/local %d]", error);
 		return false;
 
@@ -175,42 +175,42 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		/* The far side rejected the operation on some grounds.  This
 		 * might involve the server being busy or the volume having been moved.
 		 */
-		switch (fc->ac.abort_code) {
+		switch (op->ac.abort_code) {
 		case VNOVOL:
 			/* This fileserver doesn't know about the volume.
 			 * - May indicate that the VL is wrong - retry once and compare
 			 *   the results.
 			 * - May indicate that the fileserver couldn't attach to the vol.
 			 */
-			if (fc->flags & AFS_FS_CURSOR_VNOVOL) {
-				fc->error = -EREMOTEIO;
+			if (op->flags & AFS_OPERATION_VNOVOL) {
+				op->error = -EREMOTEIO;
 				goto next_server;
 			}
 
 			write_lock(&vnode->volume->servers_lock);
-			fc->server_list->vnovol_mask |= 1 << fc->index;
+			op->server_list->vnovol_mask |= 1 << op->index;
 			write_unlock(&vnode->volume->servers_lock);
 
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &vnode->volume->flags);
-			error = afs_check_volume_status(vnode->volume, fc);
+			error = afs_check_volume_status(vnode->volume, op);
 			if (error < 0)
 				goto failed_set_error;
 
 			if (test_bit(AFS_VOLUME_DELETED, &vnode->volume->flags)) {
-				fc->error = -ENOMEDIUM;
+				op->error = -ENOMEDIUM;
 				goto failed;
 			}
 
 			/* If the server list didn't change, then assume that
 			 * it's the fileserver having trouble.
 			 */
-			if (vnode->volume->servers == fc->server_list) {
-				fc->error = -EREMOTEIO;
+			if (vnode->volume->servers == op->server_list) {
+				op->error = -EREMOTEIO;
 				goto next_server;
 			}
 
 			/* Try again */
-			fc->flags |= AFS_FS_CURSOR_VNOVOL;
+			op->flags |= AFS_OPERATION_VNOVOL;
 			_leave(" = t [vnovol]");
 			return true;
 
@@ -220,20 +220,20 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		case VONLINE:
 		case VDISKFULL:
 		case VOVERQUOTA:
-			fc->error = afs_abort_to_error(fc->ac.abort_code);
+			op->error = afs_abort_to_error(op->ac.abort_code);
 			goto next_server;
 
 		case VOFFLINE:
 			if (!test_and_set_bit(AFS_VOLUME_OFFLINE, &vnode->volume->flags)) {
-				afs_busy(vnode->volume, fc->ac.abort_code);
+				afs_busy(vnode->volume, op->ac.abort_code);
 				clear_bit(AFS_VOLUME_BUSY, &vnode->volume->flags);
 			}
-			if (fc->flags & AFS_FS_CURSOR_NO_VSLEEP) {
-				fc->error = -EADV;
+			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
+				op->error = -EADV;
 				goto failed;
 			}
-			if (fc->flags & AFS_FS_CURSOR_CUR_ONLY) {
-				fc->error = -ESTALE;
+			if (op->flags & AFS_OPERATION_CUR_ONLY) {
+				op->error = -ESTALE;
 				goto failed;
 			}
 			goto busy;
@@ -244,17 +244,17 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			/* Retry after going round all the servers unless we
 			 * have a file lock we need to maintain.
 			 */
-			if (fc->flags & AFS_FS_CURSOR_NO_VSLEEP) {
-				fc->error = -EBUSY;
+			if (op->flags & AFS_OPERATION_NO_VSLEEP) {
+				op->error = -EBUSY;
 				goto failed;
 			}
 			if (!test_and_set_bit(AFS_VOLUME_BUSY, &vnode->volume->flags)) {
-				afs_busy(vnode->volume, fc->ac.abort_code);
+				afs_busy(vnode->volume, op->ac.abort_code);
 				clear_bit(AFS_VOLUME_OFFLINE, &vnode->volume->flags);
 			}
 		busy:
-			if (fc->flags & AFS_FS_CURSOR_CUR_ONLY) {
-				if (!afs_sleep_and_retry(fc))
+			if (op->flags & AFS_OPERATION_CUR_ONLY) {
+				if (!afs_sleep_and_retry(op))
 					goto failed;
 
 				 /* Retry with same server & address */
@@ -262,7 +262,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 				return true;
 			}
 
-			fc->flags |= AFS_FS_CURSOR_VBUSY;
+			op->flags |= AFS_OPERATION_VBUSY;
 			goto next_server;
 
 		case VMOVED:
@@ -273,15 +273,15 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 * We also limit the number of VMOVED hops we will
 			 * honour, just in case someone sets up a loop.
 			 */
-			if (fc->flags & AFS_FS_CURSOR_VMOVED) {
-				fc->error = -EREMOTEIO;
+			if (op->flags & AFS_OPERATION_VMOVED) {
+				op->error = -EREMOTEIO;
 				goto failed;
 			}
-			fc->flags |= AFS_FS_CURSOR_VMOVED;
+			op->flags |= AFS_OPERATION_VMOVED;
 
 			set_bit(AFS_VOLUME_WAIT, &vnode->volume->flags);
 			set_bit(AFS_VOLUME_NEEDS_UPDATE, &vnode->volume->flags);
-			error = afs_check_volume_status(vnode->volume, fc);
+			error = afs_check_volume_status(vnode->volume, op);
 			if (error < 0)
 				goto failed_set_error;
 
@@ -294,8 +294,8 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 			 *
 			 * TODO: Retry a few times with sleeps.
 			 */
-			if (vnode->volume->servers == fc->server_list) {
-				fc->error = -ENOMEDIUM;
+			if (vnode->volume->servers == op->server_list) {
+				op->error = -ENOMEDIUM;
 				goto failed;
 			}
 
@@ -304,13 +304,13 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		default:
 			clear_bit(AFS_VOLUME_OFFLINE, &vnode->volume->flags);
 			clear_bit(AFS_VOLUME_BUSY, &vnode->volume->flags);
-			fc->error = afs_abort_to_error(fc->ac.abort_code);
+			op->error = afs_abort_to_error(op->ac.abort_code);
 			goto failed;
 		}
 
 	case -ETIMEDOUT:
 	case -ETIME:
-		if (fc->error != -EDESTADDRREQ)
+		if (op->error != -EDESTADDRREQ)
 			goto iterate_address;
 		/* Fall through */
 	case -ERFKILL:
@@ -320,83 +320,83 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	case -EHOSTDOWN:
 	case -ECONNREFUSED:
 		_debug("no conn");
-		fc->error = error;
+		op->error = error;
 		goto iterate_address;
 
 	case -ECONNRESET:
 		_debug("call reset");
-		fc->error = error;
+		op->error = error;
 		goto failed;
 	}
 
 restart_from_beginning:
 	_debug("restart");
-	afs_end_cursor(&fc->ac);
-	afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
-	fc->cbi = NULL;
-	afs_put_serverlist(afs_v2net(vnode), fc->server_list);
-	fc->server_list = NULL;
+	afs_end_cursor(&op->ac);
+	afs_put_cb_interest(afs_v2net(vnode), op->cbi);
+	op->cbi = NULL;
+	afs_put_serverlist(afs_v2net(vnode), op->server_list);
+	op->server_list = NULL;
 start:
 	_debug("start");
 	/* See if we need to do an update of the volume record.  Note that the
 	 * volume may have moved or even have been deleted.
 	 */
-	error = afs_check_volume_status(vnode->volume, fc);
+	error = afs_check_volume_status(vnode->volume, op);
 	if (error < 0)
 		goto failed_set_error;
 
-	if (!afs_start_fs_iteration(fc, vnode))
+	if (!afs_start_fs_iteration(op, vnode))
 		goto failed;
 
 	_debug("__ VOL %llx __", vnode->volume->vid);
 
 pick_server:
-	_debug("pick [%lx]", fc->untried);
+	_debug("pick [%lx]", op->untried);
 
-	error = afs_wait_for_fs_probes(fc->server_list, fc->untried);
+	error = afs_wait_for_fs_probes(op->server_list, op->untried);
 	if (error < 0)
 		goto failed_set_error;
 
 	/* Pick the untried server with the lowest RTT.  If we have outstanding
 	 * callbacks, we stick with the server we're already using if we can.
 	 */
-	if (fc->cbi) {
-		_debug("cbi %u", fc->index);
-		if (test_bit(fc->index, &fc->untried))
+	if (op->cbi) {
+		_debug("cbi %u", op->index);
+		if (test_bit(op->index, &op->untried))
 			goto selected_server;
-		afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
-		fc->cbi = NULL;
+		afs_put_cb_interest(afs_v2net(vnode), op->cbi);
+		op->cbi = NULL;
 		_debug("nocbi");
 	}
 
-	fc->index = -1;
+	op->index = -1;
 	rtt = U32_MAX;
-	for (i = 0; i < fc->server_list->nr_servers; i++) {
-		struct afs_server *s = fc->server_list->servers[i].server;
+	for (i = 0; i < op->server_list->nr_servers; i++) {
+		struct afs_server *s = op->server_list->servers[i].server;
 
-		if (!test_bit(i, &fc->untried) || !s->probe.responded)
+		if (!test_bit(i, &op->untried) || !s->probe.responded)
 			continue;
 		if (s->probe.rtt < rtt) {
-			fc->index = i;
+			op->index = i;
 			rtt = s->probe.rtt;
 		}
 	}
 
-	if (fc->index == -1)
+	if (op->index == -1)
 		goto no_more_servers;
 
 selected_server:
-	_debug("use %d", fc->index);
-	__clear_bit(fc->index, &fc->untried);
+	_debug("use %d", op->index);
+	__clear_bit(op->index, &op->untried);
 
 	/* We're starting on a different fileserver from the list.  We need to
 	 * check it, create a callback intercept, find its address list and
 	 * probe its capabilities before we use it.
 	 */
-	ASSERTCMP(fc->ac.alist, ==, NULL);
-	server = fc->server_list->servers[fc->index].server;
+	ASSERTCMP(op->ac.alist, ==, NULL);
+	server = op->server_list->servers[op->index].server;
 
-	if (!afs_check_server_record(fc, server))
+	if (!afs_check_server_record(op, server))
 		goto failed;
 
 	_debug("USING SERVER: %pU", &server->uuid);
@@ -406,12 +406,12 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	 * break request before we've finished decoding the reply and
 	 * installing the vnode.
 	 */
-	error = afs_register_server_cb_interest(vnode, fc->server_list,
-						fc->index);
+	error = afs_register_server_cb_interest(vnode, op->server_list,
+						op->index);
 	if (error < 0)
 		goto failed_set_error;
 
-	fc->cbi = afs_get_cb_interest(
+	op->cbi = afs_get_cb_interest(
 		rcu_dereference_protected(vnode->cb_interest,
 					  lockdep_is_held(&vnode->io_lock)));
 
@@ -421,44 +421,44 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	afs_get_addrlist(alist);
 	read_unlock(&server->fs_lock);
 
-	memset(&fc->ac, 0, sizeof(fc->ac));
+	memset(&op->ac, 0, sizeof(op->ac));
 
-	if (!fc->ac.alist)
-		fc->ac.alist = alist;
+	if (!op->ac.alist)
+		op->ac.alist = alist;
 	else
 		afs_put_addrlist(alist);
 
-	fc->ac.index = -1;
+	op->ac.index = -1;
 
 iterate_address:
-	ASSERT(fc->ac.alist);
+	ASSERT(op->ac.alist);
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	if (!afs_iterate_addresses(&fc->ac))
+	if (!afs_iterate_addresses(&op->ac))
 		goto next_server;
 
-	_debug("address [%u] %u/%u", fc->index, fc->ac.index, fc->ac.alist->nr_addrs);
+	_debug("address [%u] %u/%u", op->index, op->ac.index, op->ac.alist->nr_addrs);
 
 	_leave(" = t");
 	return true;
 
 next_server:
 	_debug("next");
-	afs_end_cursor(&fc->ac);
+	afs_end_cursor(&op->ac);
 	goto pick_server;
 
 no_more_servers:
 	/* That's all the servers poked to no good effect.  Try again if some
 	 * of them were busy.
 	 */
-	if (fc->flags & AFS_FS_CURSOR_VBUSY)
+	if (op->flags & AFS_OPERATION_VBUSY)
 		goto restart_from_beginning;
 
 	e.error = -EDESTADDRREQ;
 	e.responded = false;
-	for (i = 0; i < fc->server_list->nr_servers; i++) {
-		struct afs_server *s = fc->server_list->servers[i].server;
+	for (i = 0; i < op->server_list->nr_servers; i++) {
+		struct afs_server *s = op->server_list->servers[i].server;
 
 		afs_prioritise_error(&e, READ_ONCE(s->probe.error),
 				     s->probe.abort_code);
@@ -467,11 +467,11 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	error = e.error;
 
 failed_set_error:
-	fc->error = error;
+	op->error = error;
 failed:
-	fc->flags |= AFS_FS_CURSOR_STOP;
-	afs_end_cursor(&fc->ac);
-	_leave(" = f [failed %d]", fc->error);
+	op->flags |= AFS_OPERATION_STOP;
+	afs_end_cursor(&op->ac);
+	_leave(" = f [failed %d]", op->error);
 	return false;
 }
 
@@ -480,12 +480,12 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
  * fileserver.  We use this when we have a lock on that file, which is backed
  * only by the fileserver we obtained it from.
  */
-bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
+bool afs_select_current_fileserver(struct afs_operation *op)
 {
-	struct afs_vnode *vnode = fc->vnode;
+	struct afs_vnode *vnode = op->vnode;
 	struct afs_cb_interest *cbi;
 	struct afs_addr_list *alist;
-	int error = fc->ac.error;
+	int error = op->ac.error;
 
 	_enter("");
 
@@ -495,12 +495,12 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	switch (error) {
 	case SHRT_MAX:
 		if (!cbi) {
-			fc->error = -ESTALE;
-			fc->flags |= AFS_FS_CURSOR_STOP;
+			op->error = -ESTALE;
+			op->flags |= AFS_OPERATION_STOP;
 			return false;
 		}
 
-		fc->cbi = afs_get_cb_interest(cbi);
+		op->cbi = afs_get_cb_interest(cbi);
 
 		read_lock(&cbi->server->fs_lock);
 		alist = rcu_dereference_protected(cbi->server->addresses,
@@ -508,27 +508,27 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 		afs_get_addrlist(alist);
 		read_unlock(&cbi->server->fs_lock);
 		if (!alist) {
-			fc->error = -ESTALE;
-			fc->flags |= AFS_FS_CURSOR_STOP;
+			op->error = -ESTALE;
+			op->flags |= AFS_OPERATION_STOP;
 			return false;
 		}
 
-		memset(&fc->ac, 0, sizeof(fc->ac));
-		fc->ac.alist = alist;
-		fc->ac.index = -1;
+		memset(&op->ac, 0, sizeof(op->ac));
+		op->ac.alist = alist;
+		op->ac.index = -1;
 		goto iterate_address;
 
 	case 0:
 	default:
 		/* Success or local failure.  Stop. */
-		fc->error = error;
-		fc->flags |= AFS_FS_CURSOR_STOP;
+		op->error = error;
+		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [okay/local %d]", error);
 		return false;
 
 	case -ECONNABORTED:
-		fc->error = afs_abort_to_error(fc->ac.abort_code);
-		fc->flags |= AFS_FS_CURSOR_STOP;
+		op->error = afs_abort_to_error(op->ac.abort_code);
+		op->flags |= AFS_OPERATION_STOP;
 		_leave(" = f [abort]");
 		return false;
 
@@ -541,7 +541,7 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	case -ETIMEDOUT:
 	case -ETIME:
 		_debug("no conn");
-		fc->error = error;
+		op->error = error;
 		goto iterate_address;
 	}
 
@@ -549,19 +549,19 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	if (afs_iterate_addresses(&fc->ac)) {
+	if (afs_iterate_addresses(&op->ac)) {
 		_leave(" = t");
 		return true;
 	}
 
-	afs_end_cursor(&fc->ac);
+	afs_end_cursor(&op->ac);
 	return false;
 }
 
 /*
  * Dump cursor state in the case of the error being EDESTADDRREQ.
  */
-static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
+static void afs_dump_edestaddrreq(const struct afs_operation *op)
 {
 	static int count;
 	int i;
@@ -574,12 +574,12 @@ static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
 
 	pr_notice("EDESTADDR occurred\n");
 	pr_notice("FC: cbb=%x cbb2=%x fl=%hx err=%hd\n",
-		  fc->cb_break, fc->cb_break_2, fc->flags, fc->error);
+		  op->cb_break, op->cb_break_2, op->flags, op->error);
 	pr_notice("FC: ut=%lx ix=%d ni=%u\n",
-		  fc->untried, fc->index, fc->nr_iterations);
+		  op->untried, op->index, op->nr_iterations);
 
-	if (fc->server_list) {
-		const struct afs_server_list *sl = fc->server_list;
+	if (op->server_list) {
+		const struct afs_server_list *sl = op->server_list;
 		pr_notice("FC: SL nr=%u pr=%u vnov=%hx\n",
 			  sl->nr_servers, sl->preferred, sl->vnovol_mask);
 		for (i = 0; i < sl->nr_servers; i++) {
@@ -595,39 +595,39 @@ static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
 					  a->preferred);
 				pr_notice("FC:  - R=%lx F=%lx\n",
 					  a->responded, a->failed);
-				if (a == fc->ac.alist)
+				if (a == op->ac.alist)
 					pr_notice("FC:  - current\n");
 			}
 		}
 	}
 
 	pr_notice("AC: t=%lx ax=%u ac=%d er=%d r=%u ni=%u\n",
-		  fc->ac.tried, fc->ac.index, fc->ac.abort_code, fc->ac.error,
-		  fc->ac.responded, fc->ac.nr_iterations);
+		  op->ac.tried, op->ac.index, op->ac.abort_code, op->ac.error,
+		  op->ac.responded, op->ac.nr_iterations);
 	rcu_read_unlock();
 }
 
 /*
  * Tidy up a filesystem cursor and unlock the vnode.
  */
-int afs_end_vnode_operation(struct afs_fs_cursor *fc)
+int afs_end_vnode_operation(struct afs_operation *op)
 {
-	struct afs_net *net = afs_v2net(fc->vnode);
+	struct afs_net *net = afs_v2net(op->vnode);
 
-	if (fc->error == -EDESTADDRREQ ||
-	    fc->error == -EADDRNOTAVAIL ||
-	    fc->error == -ENETUNREACH ||
-	    fc->error == -EHOSTUNREACH)
-		afs_dump_edestaddrreq(fc);
+	if (op->error == -EDESTADDRREQ ||
+	    op->error == -EADDRNOTAVAIL ||
+	    op->error == -ENETUNREACH ||
+	    op->error == -EHOSTUNREACH)
+		afs_dump_edestaddrreq(op);
 
-	mutex_unlock(&fc->vnode->io_lock);
+	mutex_unlock(&op->vnode->io_lock);
 
-	afs_end_cursor(&fc->ac);
-	afs_put_cb_interest(net, fc->cbi);
-	afs_put_serverlist(net, fc->server_list);
+	afs_end_cursor(&op->ac);
+	afs_put_cb_interest(net, op->cbi);
+	afs_put_serverlist(net, op->server_list);
 
-	if (fc->error == -ECONNABORTED)
-		fc->error = afs_abort_to_error(fc->ac.abort_code);
+	if (op->error == -ECONNABORTED)
+		op->error = afs_abort_to_error(op->ac.abort_code);
 
-	return fc->error;
+	return op->error;
 }
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 5ed90f419c54..3008f2ecfeee 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -571,7 +571,7 @@ void afs_purge_servers(struct afs_net *net)
 /*
  * Get an update for a server's address list.
  */
-static noinline bool afs_update_server_record(struct afs_fs_cursor *fc, struct afs_server *server)
+static noinline bool afs_update_server_record(struct afs_operation *fc, struct afs_server *server)
 {
 	struct afs_addr_list *alist, *discard;
 
@@ -585,7 +585,7 @@ static noinline bool afs_update_server_record(struct afs_fs_cursor *fc, struct a
 	if (IS_ERR(alist)) {
 		if ((PTR_ERR(alist) == -ERESTARTSYS ||
 		     PTR_ERR(alist) == -EINTR) &&
-		    !(fc->flags & AFS_FS_CURSOR_INTR) &&
+		    !(fc->flags & AFS_OPERATION_INTR) &&
 		    server->addresses) {
 			_leave(" = t [intr]");
 			return true;
@@ -613,7 +613,7 @@ static noinline bool afs_update_server_record(struct afs_fs_cursor *fc, struct a
 /*
  * See if a server's address list needs updating.
  */
-bool afs_check_server_record(struct afs_fs_cursor *fc, struct afs_server *server)
+bool afs_check_server_record(struct afs_operation *fc, struct afs_server *server)
 {
 	bool success;
 	int ret, retries = 0;
@@ -642,7 +642,7 @@ bool afs_check_server_record(struct afs_fs_cursor *fc, struct afs_server *server
 
 wait:
 	ret = wait_on_bit(&server->flags, AFS_SERVER_FL_UPDATING,
-			  (fc->flags & AFS_FS_CURSOR_INTR) ?
+			  (fc->flags & AFS_OPERATION_INTR) ?
 			  TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 	if (ret == -ERESTARTSYS) {
 		fc->error = ret;
diff --git a/fs/afs/super.c b/fs/afs/super.c
index dda7a9a66848..9f412d7e7edf 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -715,7 +715,7 @@ static void afs_destroy_inode(struct inode *inode)
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct afs_super_info *as = AFS_FS_S(dentry->d_sb);
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_volume_status vs;
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
 	struct key *key;
@@ -738,7 +738,7 @@ static int afs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, vnode, key, true)) {
-		fc.flags |= AFS_FS_CURSOR_NO_VSLEEP;
+		fc.flags |= AFS_OPERATION_NO_VSLEEP;
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = afs_calc_vnode_cb_break(vnode);
 			afs_fs_get_volume_status(&fc, &vs);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 249000195f8a..96351088a578 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -280,7 +280,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 /*
  * Make sure the volume record is up to date.
  */
-int afs_check_volume_status(struct afs_volume *volume, struct afs_fs_cursor *fc)
+int afs_check_volume_status(struct afs_volume *volume, struct afs_operation *fc)
 {
 	int ret, retries = 0;
 
@@ -315,7 +315,7 @@ int afs_check_volume_status(struct afs_volume *volume, struct afs_fs_cursor *fc)
 	}
 
 	ret = wait_on_bit(&volume->flags, AFS_VOLUME_WAIT,
-			  (fc->flags & AFS_FS_CURSOR_INTR) ?
+			  (fc->flags & AFS_OPERATION_INTR) ?
 			  TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 	if (ret == -ERESTARTSYS) {
 		_leave(" = %d", ret);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index cb76566763db..1a8af44ea36b 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -356,7 +356,7 @@ static int afs_store_data(struct address_space *mapping,
 			  unsigned offset, unsigned to)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_wb_key *wbk = NULL;
 	struct list_head *p;
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 7af41fd5f3ee..bf645f1c90b0 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -42,7 +42,7 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
 			     struct inode *inode, const char *name,
 			     void *buffer, size_t size)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_acl *acl = NULL;
@@ -100,7 +100,7 @@ static int afs_xattr_set_acl(const struct xattr_handler *handler,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_acl *acl = NULL;
@@ -165,7 +165,7 @@ static int afs_xattr_get_yfs(const struct xattr_handler *handler,
 			     struct inode *inode, const char *name,
 			     void *buffer, size_t size)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct yfs_acl *yacl = NULL;
@@ -270,7 +270,7 @@ static int afs_xattr_set_yfs(const struct xattr_handler *handler,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
 {
-	struct afs_fs_cursor fc;
+	struct afs_operation fc;
 	struct afs_status_cb *scb;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_acl *acl = NULL;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index bf74c679c02b..360b4a560ba7 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -387,7 +387,7 @@ static const struct afs_call_type yfs_RXYFSFetchStatus_vnode = {
 /*
  * Fetch the status information for a file.
  */
-int yfs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_status_cb *scb,
+int yfs_fs_fetch_file_status(struct afs_operation *fc, struct afs_status_cb *scb,
 			     struct afs_volsync *volsync)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -575,7 +575,7 @@ static const struct afs_call_type yfs_RXYFSFetchData64 = {
 /*
  * Fetch data from a file.
  */
-int yfs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_status_cb *scb,
+int yfs_fs_fetch_data(struct afs_operation *fc, struct afs_status_cb *scb,
 		      struct afs_read *req)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -657,7 +657,7 @@ static const struct afs_call_type afs_RXFSCreateFile = {
 /*
  * Create a file.
  */
-int yfs_fs_create_file(struct afs_fs_cursor *fc,
+int yfs_fs_create_file(struct afs_operation *fc,
 		       const char *name,
 		       umode_t mode,
 		       struct afs_status_cb *dvnode_scb,
@@ -721,7 +721,7 @@ static const struct afs_call_type yfs_RXFSMakeDir = {
 /*
  * Make a directory.
  */
-int yfs_fs_make_dir(struct afs_fs_cursor *fc,
+int yfs_fs_make_dir(struct afs_operation *fc,
 		    const char *name,
 		    umode_t mode,
 		    struct afs_status_cb *dvnode_scb,
@@ -811,7 +811,7 @@ static const struct afs_call_type yfs_RXYFSRemoveFile2 = {
 /*
  * Remove a file and retrieve new file status.
  */
-int yfs_fs_remove_file2(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+int yfs_fs_remove_file2(struct afs_operation *fc, struct afs_vnode *vnode,
 			const char *name, struct afs_status_cb *dvnode_scb,
 			struct afs_status_cb *vnode_scb)
 {
@@ -896,7 +896,7 @@ static const struct afs_call_type yfs_RXYFSRemoveDir = {
 /*
  * remove a file or directory
  */
-int yfs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+int yfs_fs_remove(struct afs_operation *fc, struct afs_vnode *vnode,
 		  const char *name, bool isdir,
 		  struct afs_status_cb *dvnode_scb)
 {
@@ -973,7 +973,7 @@ static const struct afs_call_type yfs_RXYFSLink = {
 /*
  * Make a hard link.
  */
-int yfs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
+int yfs_fs_link(struct afs_operation *fc, struct afs_vnode *vnode,
 		const char *name,
 		struct afs_status_cb *dvnode_scb,
 		struct afs_status_cb *vnode_scb)
@@ -1057,7 +1057,7 @@ static const struct afs_call_type yfs_RXYFSSymlink = {
 /*
  * Create a symbolic link.
  */
-int yfs_fs_symlink(struct afs_fs_cursor *fc,
+int yfs_fs_symlink(struct afs_operation *fc,
 		   const char *name,
 		   const char *contents,
 		   struct afs_status_cb *dvnode_scb,
@@ -1148,7 +1148,7 @@ static const struct afs_call_type yfs_RXYFSRename = {
 /*
  * Rename a file or directory.
  */
-int yfs_fs_rename(struct afs_fs_cursor *fc,
+int yfs_fs_rename(struct afs_operation *fc,
 		  const char *orig_name,
 		  struct afs_vnode *new_dvnode,
 		  const char *new_name,
@@ -1212,7 +1212,7 @@ static const struct afs_call_type yfs_RXYFSStoreData64 = {
 /*
  * Store a set of pages to a large file.
  */
-int yfs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
+int yfs_fs_store_data(struct afs_operation *fc, struct address_space *mapping,
 		      pgoff_t first, pgoff_t last,
 		      unsigned offset, unsigned to,
 		      struct afs_status_cb *scb)
@@ -1299,7 +1299,7 @@ static const struct afs_call_type yfs_RXYFSStoreData64_as_Status = {
  * Set the attributes on a file, using YFS.StoreData64 rather than
  * YFS.StoreStatus so as to alter the file size also.
  */
-static int yfs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr,
+static int yfs_fs_setattr_size(struct afs_operation *fc, struct iattr *attr,
 			       struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1345,7 +1345,7 @@ static int yfs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr,
  * Set the attributes on a file, using YFS.StoreData64 if there's a change in
  * file size, and YFS.StoreStatus otherwise.
  */
-int yfs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr,
+int yfs_fs_setattr(struct afs_operation *fc, struct iattr *attr,
 		   struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1526,7 +1526,7 @@ static const struct afs_call_type yfs_RXYFSGetVolumeStatus = {
 /*
  * fetch the status of a volume
  */
-int yfs_fs_get_volume_status(struct afs_fs_cursor *fc,
+int yfs_fs_get_volume_status(struct afs_operation *fc,
 			     struct afs_volume_status *vs)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1598,7 +1598,7 @@ static const struct afs_call_type yfs_RXYFSReleaseLock = {
 /*
  * Set a lock on a file
  */
-int yfs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type,
+int yfs_fs_set_lock(struct afs_operation *fc, afs_lock_type_t type,
 		    struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1639,7 +1639,7 @@ int yfs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type,
 /*
  * extend a lock on a file
  */
-int yfs_fs_extend_lock(struct afs_fs_cursor *fc, struct afs_status_cb *scb)
+int yfs_fs_extend_lock(struct afs_operation *fc, struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
@@ -1677,7 +1677,7 @@ int yfs_fs_extend_lock(struct afs_fs_cursor *fc, struct afs_status_cb *scb)
 /*
  * release a lock on a file
  */
-int yfs_fs_release_lock(struct afs_fs_cursor *fc, struct afs_status_cb *scb)
+int yfs_fs_release_lock(struct afs_operation *fc, struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
@@ -1725,7 +1725,7 @@ static const struct afs_call_type yfs_RXYFSFetchStatus = {
 /*
  * Fetch the status information for a fid without needing a vnode handle.
  */
-int yfs_fs_fetch_status(struct afs_fs_cursor *fc,
+int yfs_fs_fetch_status(struct afs_operation *fc,
 			struct afs_net *net,
 			struct afs_fid *fid,
 			struct afs_status_cb *scb,
@@ -1888,7 +1888,7 @@ static const struct afs_call_type yfs_RXYFSInlineBulkStatus = {
 /*
  * Fetch the status information for up to 1024 files
  */
-int yfs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
+int yfs_fs_inline_bulk_status(struct afs_operation *fc,
 			      struct afs_net *net,
 			      struct afs_fid *fids,
 			      struct afs_status_cb *statuses,
@@ -2065,7 +2065,7 @@ static const struct afs_call_type yfs_RXYFSFetchOpaqueACL = {
 /*
  * Fetch the YFS advanced ACLs for a file.
  */
-struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_fs_cursor *fc,
+struct yfs_acl *yfs_fs_fetch_opaque_acl(struct afs_operation *fc,
 					struct yfs_acl *yacl,
 					struct afs_status_cb *scb)
 {
@@ -2119,7 +2119,7 @@ static const struct afs_call_type yfs_RXYFSStoreOpaqueACL2 = {
 /*
  * Fetch the YFS ACL for a file.
  */
-int yfs_fs_store_opaque_acl2(struct afs_fs_cursor *fc, const struct afs_acl *acl,
+int yfs_fs_store_opaque_acl2(struct afs_operation *fc, const struct afs_acl *acl,
 			     struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;


