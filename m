Return-Path: <linux-fsdevel+bounces-37901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D869F8A64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C921895375
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14537DA7F;
	Fri, 20 Dec 2024 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hMES+Jfe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ipjP52BZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hMES+Jfe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ipjP52BZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6F770FE;
	Fri, 20 Dec 2024 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664138; cv=none; b=c7aHbIRS8ZaBMHl8jixE5aC720XqN1zrJjfQAEkx1ckPEin9IrsTaFyCVtno+0B36UHI1ORfpvZ/AUfvJA0zHgnAASEWmmBeveZ6mgyDfign6kSdJOsna2s0JzQj+JdQXATw9haD8nrN/wFPFKj/VtCk36AnvcDQzz+e3XqowZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664138; c=relaxed/simple;
	bh=9kXhkW1Nz1QGe6JFCSFEY1rZocMiPCC8K+r44xnRFSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TU10rXh0A4Fc2QyOLJ1ve0g2tWpftgcQtm+Juk8ZxSHyhLbb8jP2Z0Mkcz+LynTBg9Ts/8Z701qRe3Sr5yTDBNRGecI5IgRPR8ckCRd7rlW4T2SNeCxFT7uqnN/31FvwMwv5mw2vAw3eO64ey1KnqB94u5Zbe2NABeq85PIR9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hMES+Jfe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ipjP52BZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hMES+Jfe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ipjP52BZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ADA9210F2;
	Fri, 20 Dec 2024 03:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlkY4ecDeSzlsChYigcLlSQTmsnD+T9Y53OFWkyAFS8=;
	b=hMES+JfeNz5wSv6EUDLVRz3zHTkH8FtW8iygriNnglbPW17K8uxUG05H9jXwKCqC2WG4rc
	mD17YB2IXDXSij+p/0kWayy4X+ltprfmg5geUL7G6pxbvtZapozrNDNXC1PJ3qgudrwX80
	HJGXzDRZkD4ypHKmDZ1lwL/6Vf5Rc1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlkY4ecDeSzlsChYigcLlSQTmsnD+T9Y53OFWkyAFS8=;
	b=ipjP52BZuFHerrKq/bYGRe9PJborYLKFxyA9bat0uctgQNBvHAS6BSXFY0jpSpKy8vRY2C
	I9I0vlDFbIpT+uCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hMES+Jfe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ipjP52BZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlkY4ecDeSzlsChYigcLlSQTmsnD+T9Y53OFWkyAFS8=;
	b=hMES+JfeNz5wSv6EUDLVRz3zHTkH8FtW8iygriNnglbPW17K8uxUG05H9jXwKCqC2WG4rc
	mD17YB2IXDXSij+p/0kWayy4X+ltprfmg5geUL7G6pxbvtZapozrNDNXC1PJ3qgudrwX80
	HJGXzDRZkD4ypHKmDZ1lwL/6Vf5Rc1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlkY4ecDeSzlsChYigcLlSQTmsnD+T9Y53OFWkyAFS8=;
	b=ipjP52BZuFHerrKq/bYGRe9PJborYLKFxyA9bat0uctgQNBvHAS6BSXFY0jpSpKy8vRY2C
	I9I0vlDFbIpT+uCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E4BE13A32;
	Fri, 20 Dec 2024 03:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7AQFFcPfZGc+GAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:08:51 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] VFS: add _shared versions of the various directory modifying inode_operations
Date: Fri, 20 Dec 2024 13:54:20 +1100
Message-ID: <20241220030830.272429-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0ADA9210F2
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

These "_shared" versions of various inode operations are not guaranteed
an exclusive lock on the directory but are guaranteed an exclusive lock
on the dentry within the directory.

i_rwsem *may* be held exclusively or *may* be held shared, in which case
an exclusive lock will be held on the dentry - provided by a later
patch.

This will allow a graceful transition from exclusive to shared locking
for directory updates.

mkdir_shared is a bit different as it optionally returns a new dentry
for cases when the filesystem is not able to use the original dentry.
This allows vfs_mkdir_return() to avoid the need for an extra lookup.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/filesystems/locking.rst |  28 ++++++-
 Documentation/filesystems/porting.rst |  10 +++
 Documentation/filesystems/vfs.rst     |  24 ++++++
 fs/namei.c                            | 108 +++++++++++++++++++-------
 include/linux/fs.h                    |  16 ++++
 5 files changed, 158 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index f5e3676db954..7cacff59356f 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -57,15 +57,24 @@ inode_operations
 prototypes::
 
 	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, bool);
+	int (*create_shared) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, bool);
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
+	int (*link_shared) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
+	int (*unlink_shared) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
+	int (*symlink_shared) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
 	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
+	struct dentry * (*mkdir_shared) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
+	int (*rmdir_shared) (struct inode *,struct dentry *);
 	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
+	int (*mknod_shared) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
 	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
+	int (*rename_shared) (struct mnt_idmap *, struct inode *, struct dentry *,
+			struct inode *, struct dentry *, unsigned int);
 	int (*readlink) (struct dentry *, char __user *,int);
 	const char *(*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	void (*truncate) (struct inode *);
@@ -79,6 +88,9 @@ prototypes::
 	int (*atomic_open)(struct inode *, struct dentry *,
 				struct file *, unsigned open_flag,
 				umode_t create_mode);
+	int (*atomic_open_shared)(struct inode *, struct dentry *,
+				struct file *, unsigned open_flag,
+				umode_t create_mode);
 	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
 	int (*fileattr_set)(struct mnt_idmap *idmap,
@@ -90,18 +102,29 @@ prototypes::
 locking rules:
 	all may block
 
+A "mixed" lock means that either that i_rwsem on the directory is held
+exclusively, or it is held as a shared lock, and an exclusive lock is held
+on the dentry in that directory.
 ==============	==================================================
 ops		i_rwsem(inode)
 ==============	==================================================
 lookup:		shared
 create:		exclusive
+create_shared:	mixed
 link:		exclusive (both)
+link_shared:	exclusive on source, mixed on target
 mknod:		exclusive
+mknod_shared:	mixed
 symlink:	exclusive
+symlink_shared:	mixed
 mkdir:		exclusive
+mkdir_shared:	mixed
 unlink:		exclusive (both)
+unlink_shared:	exclusive on object, mixed on directory/name
 rmdir:		exclusive (both)(see below)
+rmdir_shared:	exclusive on object, mixed on directory/name (see below)
 rename:		exclusive (both parents, some children)	(see below)
+rename_shared:	mixed (both parents) exclusive (some children)	(see below)
 readlink:	no
 get_link:	no
 setattr:	exclusive
@@ -113,6 +136,7 @@ listxattr:	no
 fiemap:		no
 update_time:	no
 atomic_open:	shared (exclusive if O_CREAT is set in open flags)
+atomic_open_shared:	mixed (if O_CREAT is not set, then may not have exclusive lock on name)
 tmpfile:	no
 fileattr_get:	no or exclusive
 fileattr_set:	exclusive
@@ -120,8 +144,8 @@ get_offset_ctx  no
 ==============	==================================================
 
 
-	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
-	exclusive on victim.
+	Additionally, ->rmdir(), ->unlink() and ->rename(), as well as _shared
+	versions, have ->i_rwsem exclusive on victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
 	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directories
 	involved.
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 9ab2a3d6f2b4..c7f3825f280c 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1141,3 +1141,13 @@ pointer are gone.
 
 set_blocksize() takes opened struct file instead of struct block_device now
 and it *must* be opened exclusive.
+
+---
+
+**recommended**
+
+create_shared, link_shared, unlink_shared, rmdir_shared, mknod_shared,
+rename_shared, atomic_open_shared can be provided instead of the
+corresponding inode_operations with the "_shared" suffix.  Multiple
+_shared operations can be performed in a given directory concurrently,
+but never on the same name.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0b18af3f954e..c4860597975a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -491,15 +491,24 @@ As of kernel 2.6.22, the following members are defined:
 
 	struct inode_operations {
 		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t, bool);
+		int (*create_shared) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t, bool);
 		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
+		int (*link_shared) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
+		int (*unlink_shared) (struct inode *,struct dentry *);
 		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
+		int (*symlink_shared) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
 		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
+		struct dentry * (*mkdir_shared) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
+		int (*rmdir_shared) (struct inode *,struct dentry *);
 		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
+		int (*mknod_shared) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
 		int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			       struct inode *, struct dentry *, unsigned int);
+		int (*rename_shared) (struct mnt_idmap *, struct inode *, struct dentry *,
+			       struct inode *, struct dentry *, unsigned int);
 		int (*readlink) (struct dentry *, char __user *,int);
 		const char *(*get_link) (struct dentry *, struct inode *,
 					 struct delayed_call *);
@@ -511,6 +520,8 @@ As of kernel 2.6.22, the following members are defined:
 		void (*update_time)(struct inode *, struct timespec *, int);
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
+		int (*atomic_open_shared)(struct inode *, struct dentry *, struct file *,
+				   unsigned open_flag, umode_t create_mode);
 		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
 		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posix_acl *, int);
@@ -524,6 +535,7 @@ Again, all methods are called without any locks being held, unless
 otherwise noted.
 
 ``create``
+``create_shared``
 	called by the open(2) and creat(2) system calls.  Only required
 	if you want to support regular files.  The dentry you get should
 	not have an inode (i.e. it should be a negative dentry).  Here
@@ -546,29 +558,39 @@ otherwise noted.
 	directory inode semaphore held
 
 ``link``
+``link_shared``
 	called by the link(2) system call.  Only required if you want to
 	support hard links.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
 ``unlink``
+``unlink_shared``
 	called by the unlink(2) system call.  Only required if you want
 	to support deleting inodes
 
 ``symlink``
+``symlink_shared``
 	called by the symlink(2) system call.  Only required if you want
 	to support symlinks.  You will probably need to call
 	d_instantiate() just as you would in the create() method
 
 ``mkdir``
+``mkdir_shared``
 	called by the mkdir(2) system call.  Only required if you want
 	to support creating subdirectories.  You will probably need to
 	call d_instantiate() just as you would in the create() method
 
+	mkdir_shared can return an alternate dentry, much like lookup.
+	In this case the original dentry will still be negative and will
+	be unhashed.
+
 ``rmdir``
+``rmdir_shared``
 	called by the rmdir(2) system call.  Only required if you want
 	to support deleting subdirectories
 
 ``mknod``
+``mknod_shared``
 	called by the mknod(2) system call to create a device (char,
 	block) inode or a named pipe (FIFO) or socket.  Only required if
 	you want to support creating these types of inodes.  You will
@@ -576,6 +598,7 @@ otherwise noted.
 	create() method
 
 ``rename``
+``rename_shared``
 	called by the rename(2) system call to rename the object to have
 	the parent and name given by the second inode and dentry.
 
@@ -647,6 +670,7 @@ otherwise noted.
 	itself and call mark_inode_dirty_sync.
 
 ``atomic_open``
+``atomic_open_shared``
 	called on the last component of an open.  Using this optional
 	method the filesystem can look up, possibly create and open the
 	file in one atomic operation.  If it wants to leave actual
diff --git a/fs/namei.c b/fs/namei.c
index cdd1fc9d56a0..65082378dc60 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3338,14 +3338,17 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (!dir->i_op->create)
+	if (!dir->i_op->create && !dir->i_op->create_shared)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
+	if (dir->i_op->create_shared)
+		error = dir->i_op->create_shared(idmap, dir, dentry, mode, want_excl);
+	else
+		error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -3506,8 +3509,12 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
 
 	file->f_path.dentry = DENTRY_NOT_SET;
 	file->f_path.mnt = nd->path.mnt;
-	error = dir->i_op->atomic_open(dir, dentry, file,
-				       open_to_namei_flags(open_flag), mode);
+	if (dir->i_op->atomic_open_shared)
+		error = dir->i_op->atomic_open_shared(dir, dentry, file,
+						      open_to_namei_flags(open_flag), mode);
+	else
+		error = dir->i_op->atomic_open(dir, dentry, file,
+					       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
@@ -3616,7 +3623,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-	if (dir_inode->i_op->atomic_open) {
+	if (dir_inode->i_op->atomic_open || dir_inode->i_op->atomic_open_shared) {
 		dentry = atomic_open(nd, dentry, file, open_flag, mode);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
@@ -3641,13 +3648,17 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
-			goto out_dput;
-		}
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+		if (dir_inode->i_op->create_shared)
+			error = dir_inode->i_op->create_shared(idmap, dir_inode,
+							       dentry, mode,
+							       open_flag & O_EXCL);
+		else if (dir_inode->i_op->create)
+			error = dir_inode->i_op->create(idmap, dir_inode,
+							dentry, mode,
+							open_flag & O_EXCL);
+		else
+			error = -EACCES;
 		if (error)
 			goto out_dput;
 	}
@@ -4174,7 +4185,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	    !capable(CAP_MKNOD))
 		return -EPERM;
 
-	if (!dir->i_op->mknod)
+	if (!dir->i_op->mknod && !dir->i_op->mknod_shared)
 		return -EPERM;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
@@ -4186,7 +4197,10 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
+	if (dir->i_op->mknod_shared)
+		error = dir->i_op->mknod_shared(idmap, dir, dentry, mode, dev);
+	else
+		error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4297,7 +4311,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (!dir->i_op->mkdir)
+	if (!dir->i_op->mkdir && !dir->i_op->mkdir_shared)
 		return -EPERM;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
@@ -4308,7 +4322,16 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		return -EMLINK;
 
-	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	if (dir->i_op->mkdir_shared) {
+		struct dentry *de;
+		de = dir->i_op->mkdir_shared(idmap, dir, dentry, mode);
+		if (IS_ERR(de))
+			error = PTR_ERR(de);
+		else if (de)
+			dput(de);
+	} else {
+		error = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	}
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
 	return error;
@@ -4356,6 +4379,20 @@ int vfs_mkdir_return(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		return -EMLINK;
 
+	if (dir->i_op->mkdir_shared) {
+		struct dentry *de;
+
+		de = dir->i_op->mkdir_shared(idmap, dir, dentry, mode);
+		if (IS_ERR(de))
+			return PTR_ERR(de);
+		if (de) {
+			dput(dentry);
+			*dentryp = de;
+		}
+		fsnotify_mkdir(dir, dentry);
+		return 0;
+	}
+
 	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	if (!error) {
 		fsnotify_mkdir(dir, dentry);
@@ -4439,7 +4476,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (!dir->i_op->rmdir)
+	if (!dir->i_op->rmdir && !dir->i_op->rmdir_shared)
 		return -EPERM;
 
 	dget(dentry);
@@ -4454,7 +4491,10 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto out;
 
-	error = dir->i_op->rmdir(dir, dentry);
+	if (dir->i_op->rmdir_shared)
+		error = dir->i_op->rmdir_shared(dir, dentry);
+	else
+		error = dir->i_op->rmdir(dir, dentry);
 	if (error)
 		goto out;
 
@@ -4569,7 +4609,7 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (!dir->i_op->unlink)
+	if (!dir->i_op->unlink && !dir->i_op->unlink_shared)
 		return -EPERM;
 
 	inode_lock(target);
@@ -4583,7 +4623,10 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 			error = try_break_deleg(target, delegated_inode);
 			if (error)
 				goto out;
-			error = dir->i_op->unlink(dir, dentry);
+			if (dir->i_op->unlink_shared)
+				error = dir->i_op->unlink_shared(dir, dentry);
+			else
+				error = dir->i_op->unlink(dir, dentry);
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
@@ -4722,14 +4765,17 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
-	if (!dir->i_op->symlink)
+	if (!dir->i_op->symlink && !dir->i_op->symlink_shared)
 		return -EPERM;
 
 	error = security_inode_symlink(dir, dentry, oldname);
 	if (error)
 		return error;
 
-	error = dir->i_op->symlink(idmap, dir, dentry, oldname);
+	if (dir->i_op->symlink_shared)
+		error = dir->i_op->symlink_shared(idmap, dir, dentry, oldname);
+	else
+		error = dir->i_op->symlink(idmap, dir, dentry, oldname);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4835,7 +4881,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	 */
 	if (HAS_UNMAPPED_ID(idmap, inode))
 		return -EPERM;
-	if (!dir->i_op->link)
+	if (!dir->i_op->link && !dir->i_op->link_shared)
 		return -EPERM;
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
@@ -4852,7 +4898,11 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 		error = -EMLINK;
 	else {
 		error = try_break_deleg(inode, delegated_inode);
-		if (!error)
+		if (error)
+			;
+		else if (dir->i_op->link_shared)
+			error = dir->i_op->link_shared(old_dentry, dir, new_dentry);
+		else
 			error = dir->i_op->link(old_dentry, dir, new_dentry);
 	}
 
@@ -5044,7 +5094,7 @@ int vfs_rename(struct renamedata *rd)
 	if (error)
 		return error;
 
-	if (!old_dir->i_op->rename)
+	if (!old_dir->i_op->rename && !old_dir->i_op->rename_shared)
 		return -EPERM;
 
 	/*
@@ -5127,8 +5177,14 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
-				      new_dir, new_dentry, flags);
+	if (old_dir->i_op->rename_shared)
+		error = old_dir->i_op->rename_shared(rd->new_mnt_idmap,
+						     old_dir, old_dentry,
+						     new_dir, new_dentry, flags);
+	else
+		error = old_dir->i_op->rename(rd->new_mnt_idmap,
+					      old_dir, old_dentry,
+					      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 406887d0394e..68eba181175b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2147,17 +2147,30 @@ struct inode_operations {
 
 	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,
 		       umode_t, bool);
+	int (*create_shared) (struct mnt_idmap *, struct inode *,struct dentry *,
+		       umode_t, bool);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
+	int (*link_shared) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
+	int (*unlink_shared) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
 			const char *);
+	int (*symlink_shared) (struct mnt_idmap *, struct inode *,struct dentry *,
+			const char *);
 	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t);
+	struct dentry * (*mkdir_shared) (struct mnt_idmap *, struct inode *,struct dentry *,
+		      umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
+	int (*rmdir_shared) (struct inode *,struct dentry *);
 	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t,dev_t);
+	int (*mknod_shared) (struct mnt_idmap *, struct inode *,struct dentry *,
+		      umode_t,dev_t);
 	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
+	int (*rename_shared) (struct mnt_idmap *, struct inode *, struct dentry *,
+			struct inode *, struct dentry *, unsigned int);
 	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
 	int (*getattr) (struct mnt_idmap *, const struct path *,
 			struct kstat *, u32, unsigned int);
@@ -2168,6 +2181,9 @@ struct inode_operations {
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
+	int (*atomic_open_shared)(struct inode *, struct dentry *,
+			   struct file *, unsigned open_flag,
+			   umode_t create_mode);
 	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
 	struct posix_acl *(*get_acl)(struct mnt_idmap *, struct dentry *,
-- 
2.47.0


