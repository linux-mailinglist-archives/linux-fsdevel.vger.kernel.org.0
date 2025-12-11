Return-Path: <linux-fsdevel+bounces-71101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1617CB5C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F2A430028BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87A2F39B0;
	Thu, 11 Dec 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgGalBfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925C2D949F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455500; cv=none; b=jGpzpKXlwmh4ZWgBkLZ/qhMveSjdpY0U53yaCyhd4QUQD1B+0/7JYXwDJ2EqybKdtArpUZ54DJO9ehxxGSGn3SwwDK8iiNQ1HYuVWGh/bsz5dufoOtVu6WenTmO6xUCT3VExMWTmHb2tmTd6JJvP6gTaiNbid9diedVpVwRysRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455500; c=relaxed/simple;
	bh=0ijP/xejHpLuaOUCYTJNPLJzUy+MQtjorZuawJ0Gr80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ1lYVmDiQpl/z61VA0DY52IRCmHgb91BOHP8ziaoa7huznmfnSFSQ4uK81Ukw8pmeYNOxTfTrPDNmLm6I2CiztRdYxnOFo9R15EeDvTLkdfkNx/ZUxY0QoMsIqmxPzXDTs4zh4w/daqHAXw+p+pCeDL2VFI7oP0Gk9SJRtRMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgGalBfc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765455497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZ+y5YOn1a6/5fJow6XPiKpeXvFN/R4NS+wzW5n64nc=;
	b=BgGalBfc+Uf8yT9VvBi1k0QBm4/MVWMhyhEFdfQcbiXU874D1TA//iMVGC1xABECZHEfc7
	Jubvlue6jZeRKE4irkX4uRJdPmCq6Oa6nIahPBjdlTkjhC7kICAdUo72pRXs7hPIXBkGqx
	ob9n6ER1mGScdfi7pJsDh/Y6hHNWSNE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-8g8NDiZ7ND-9PiXou5JD9A-1; Thu,
 11 Dec 2025 07:18:15 -0500
X-MC-Unique: 8g8NDiZ7ND-9PiXou5JD9A-1
X-Mimecast-MFC-AGG-ID: 8g8NDiZ7ND-9PiXou5JD9A_1765455494
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35654195609E;
	Thu, 11 Dec 2025 12:18:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74C181800357;
	Thu, 11 Dec 2025 12:18:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] cifs: Scripted clean up fs/smb/client/cifsfs.h
Date: Thu, 11 Dec 2025 12:17:00 +0000
Message-ID: <20251211121715.759074-8-dhowells@redhat.com>
In-Reply-To: <20251211121715.759074-2-dhowells@redhat.com>
References: <20251211121715.759074-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove externs, correct argument names and reformat declarations.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsfs.h | 114 +++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 56 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index e9534258d1ef..e9d160375e86 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -43,40 +43,41 @@ extern const struct address_space_operations cifs_addr_ops;
 extern const struct address_space_operations cifs_addr_ops_smallbuf;
 
 /* Functions related to super block operations */
-extern void cifs_sb_active(struct super_block *sb);
-extern void cifs_sb_deactive(struct super_block *sb);
+void cifs_sb_active(struct super_block *sb);
+void cifs_sb_deactive(struct super_block *sb);
 
 /* Functions related to inodes */
 extern const struct inode_operations cifs_dir_inode_ops;
-extern struct inode *cifs_root_iget(struct super_block *);
-extern int cifs_create(struct mnt_idmap *, struct inode *,
-		       struct dentry *, umode_t, bool excl);
-extern int cifs_atomic_open(struct inode *, struct dentry *,
-			    struct file *, unsigned, umode_t);
-extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
-				  unsigned int);
-extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
-extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
-extern int cifs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
-		      umode_t, dev_t);
-extern struct dentry *cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
-				 umode_t);
-extern int cifs_rmdir(struct inode *, struct dentry *);
-extern int cifs_rename2(struct mnt_idmap *, struct inode *,
-			struct dentry *, struct inode *, struct dentry *,
-			unsigned int);
-extern int cifs_revalidate_file_attr(struct file *filp);
-extern int cifs_revalidate_dentry_attr(struct dentry *);
-extern int cifs_revalidate_file(struct file *filp);
-extern int cifs_revalidate_dentry(struct dentry *);
-extern int cifs_revalidate_mapping(struct inode *inode);
-extern int cifs_zap_mapping(struct inode *inode);
-extern int cifs_getattr(struct mnt_idmap *, const struct path *,
-			struct kstat *, u32, unsigned int);
-extern int cifs_setattr(struct mnt_idmap *, struct dentry *,
-			struct iattr *);
-extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 start,
-		       u64 len);
+struct inode *cifs_root_iget(struct super_block *sb);
+int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
+		struct dentry *direntry, umode_t mode, bool excl);
+int cifs_atomic_open(struct inode *inode, struct dentry *direntry,
+		     struct file *file, unsigned int oflags, umode_t mode);
+struct dentry *cifs_lookup(struct inode *parent_dir_inode,
+			   struct dentry *direntry, unsigned int flags);
+int cifs_unlink(struct inode *dir, struct dentry *dentry);
+int cifs_hardlink(struct dentry *old_file, struct inode *inode,
+		  struct dentry *direntry);
+int cifs_mknod(struct mnt_idmap *idmap, struct inode *inode,
+	       struct dentry *direntry, umode_t mode, dev_t device_number);
+struct dentry *cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
+			  struct dentry *direntry, umode_t mode);
+int cifs_rmdir(struct inode *inode, struct dentry *direntry);
+int cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
+		 struct dentry *source_dentry, struct inode *target_dir,
+		 struct dentry *target_dentry, unsigned int flags);
+int cifs_revalidate_file_attr(struct file *filp);
+int cifs_revalidate_dentry_attr(struct dentry *dentry);
+int cifs_revalidate_file(struct file *filp);
+int cifs_revalidate_dentry(struct dentry *dentry);
+int cifs_revalidate_mapping(struct inode *inode);
+int cifs_zap_mapping(struct inode *inode);
+int cifs_getattr(struct mnt_idmap *idmap, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags);
+int cifs_setattr(struct mnt_idmap *idmap, struct dentry *direntry,
+		 struct iattr *attrs);
+int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
+		u64 len);
 
 extern const struct inode_operations cifs_file_inode_ops;
 extern const struct inode_operations cifs_symlink_inode_ops;
@@ -91,54 +92,55 @@ extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */
 extern const struct file_operations cifs_file_nobrl_ops; /* no brlocks */
 extern const struct file_operations cifs_file_direct_nobrl_ops;
 extern const struct file_operations cifs_file_strict_nobrl_ops;
-extern int cifs_open(struct inode *inode, struct file *file);
-extern int cifs_close(struct inode *inode, struct file *file);
-extern int cifs_closedir(struct inode *inode, struct file *file);
-extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
+int cifs_open(struct inode *inode, struct file *file);
+int cifs_close(struct inode *inode, struct file *file);
+int cifs_closedir(struct inode *inode, struct file *file);
+ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
+ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
 ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
 ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter);
-extern int cifs_flock(struct file *pfile, int cmd, struct file_lock *plock);
-extern int cifs_lock(struct file *, int, struct file_lock *);
-extern int cifs_fsync(struct file *, loff_t, loff_t, int);
-extern int cifs_strict_fsync(struct file *, loff_t, loff_t, int);
-extern int cifs_flush(struct file *, fl_owner_t id);
+int cifs_flock(struct file *file, int cmd, struct file_lock *fl);
+int cifs_lock(struct file *file, int cmd, struct file_lock *flock);
+int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+int cifs_strict_fsync(struct file *file, loff_t start, loff_t end,
+		      int datasync);
+int cifs_flush(struct file *file, fl_owner_t id);
 int cifs_file_mmap_prepare(struct vm_area_desc *desc);
 int cifs_file_strict_mmap_prepare(struct vm_area_desc *desc);
 extern const struct file_operations cifs_dir_ops;
-extern int cifs_readdir(struct file *file, struct dir_context *ctx);
+int cifs_readdir(struct file *file, struct dir_context *ctx);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
 extern const struct dentry_operations cifs_ci_dentry_ops;
 
-extern struct vfsmount *cifs_d_automount(struct path *path);
+struct vfsmount *cifs_d_automount(struct path *path);
 
 /* Functions related to symlinks */
-extern const char *cifs_get_link(struct dentry *, struct inode *,
-			struct delayed_call *);
-extern int cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
-			struct dentry *direntry, const char *symname);
+const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
+			  struct delayed_call *done);
+int cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
+		 struct dentry *direntry, const char *symname);
 
 #ifdef CONFIG_CIFS_XATTR
 extern const struct xattr_handler * const cifs_xattr_handlers[];
-extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
+ssize_t cifs_listxattr(struct dentry *direntry, char *data, size_t buf_size);
 #else
 # define cifs_xattr_handlers NULL
 # define cifs_listxattr NULL
 #endif
 
-extern ssize_t cifs_file_copychunk_range(unsigned int xid,
-					struct file *src_file, loff_t off,
-					struct file *dst_file, loff_t destoff,
-					size_t len, unsigned int flags);
+ssize_t cifs_file_copychunk_range(unsigned int xid, struct file *src_file,
+				  loff_t off, struct file *dst_file,
+				  loff_t destoff, size_t len,
+				  unsigned int flags);
 
-extern long cifs_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
-extern void cifs_setsize(struct inode *inode, loff_t offset);
+long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg);
+void cifs_setsize(struct inode *inode, loff_t offset);
 
 struct smb3_fs_context;
-extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
-					 int flags, struct smb3_fs_context *ctx);
+struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type, int flags,
+				  struct smb3_fs_context *old_ctx);
 
 #ifdef CONFIG_CIFS_NFSD_EXPORT
 extern const struct export_operations cifs_export_ops;


