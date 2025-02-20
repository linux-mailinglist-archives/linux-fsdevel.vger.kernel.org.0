Return-Path: <linux-fsdevel+bounces-42195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA76A3E8C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C106C19C05EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0743C267F4E;
	Thu, 20 Feb 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="05vxOIDT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PWzECCuq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="05vxOIDT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PWzECCuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CB1DAC97
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095230; cv=none; b=W2iDQd+5V4S1HmLOKBX0N0lJHgQt1AFpd2NPvdcL/vHRl7EHDX7H986ssxl6EO80KKizRIbQnu30gVv2r5TT+cMT/EZaLvr7Erd7bqvGn8c09dOTYC6MwrYHbwgAONwNhd7dVgDTJPNvUlOMl0vr9TPjvM+yvyID0YFlOiOhu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095230; c=relaxed/simple;
	bh=SLeAsLukxJCvYRbfaC3H6OMKSvowh8uf0lczYpOF0ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJNa4ICLha0lcXfLztG3wU5/LBxtN7I52Xr2W5xj65gX8Spm59YqCO4aks9u7vTnwWVRHeT0b8zWltZDdMyl5LQV9p8m3ndP1i987ZUIWXDtRljLLqz5sWNUWfkH/btSLrvjTzjFvxP9nnjnuURzfldFF8HTHSRGV9FoH+Dmpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=05vxOIDT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PWzECCuq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=05vxOIDT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PWzECCuq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 876C321190;
	Thu, 20 Feb 2025 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSqT/nUdZ3A5kev1vZxGg+mogThgAnc8EtCHgWKMVII=;
	b=05vxOIDTpMClX3RhpKVDxP4qWfPe87Ynjq+GtGRYGo7OF1vbJ12D0NJb2n2B8ONNaXDMhD
	ilLQqFsqPgZ0HJ2vxKzvD1WozD5zpcfV67IaxhY8EtmINqzthJwvlwU2YGyhwYuaDZSTKg
	hGgw/ZQTorjAKPNVnnTxoJmM8f0KYOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSqT/nUdZ3A5kev1vZxGg+mogThgAnc8EtCHgWKMVII=;
	b=PWzECCuqrhFfPOd30u3X4qwRbQI9TAS5XtXfZYeuGne70ETUZGNj+R17PIVNf9mh8i6cdH
	WIzQteCTObLT+CBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=05vxOIDT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PWzECCuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSqT/nUdZ3A5kev1vZxGg+mogThgAnc8EtCHgWKMVII=;
	b=05vxOIDTpMClX3RhpKVDxP4qWfPe87Ynjq+GtGRYGo7OF1vbJ12D0NJb2n2B8ONNaXDMhD
	ilLQqFsqPgZ0HJ2vxKzvD1WozD5zpcfV67IaxhY8EtmINqzthJwvlwU2YGyhwYuaDZSTKg
	hGgw/ZQTorjAKPNVnnTxoJmM8f0KYOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSqT/nUdZ3A5kev1vZxGg+mogThgAnc8EtCHgWKMVII=;
	b=PWzECCuqrhFfPOd30u3X4qwRbQI9TAS5XtXfZYeuGne70ETUZGNj+R17PIVNf9mh8i6cdH
	WIzQteCTObLT+CBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D53313301;
	Thu, 20 Feb 2025 23:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BffeEPC+t2cOAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:46:56 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
Date: Fri, 21 Feb 2025 10:36:30 +1100
Message-ID: <20250220234630.983190-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220234630.983190-1-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 876C321190
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL41gfrsx5ox46amq79i8sk6fy)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Some filesystems, such as NFS, cifs, ceph, and fuse, do not have
complete control of sequencing on the actual filesystem (e.g.  on a
different server) and may find that the inode created for a mkdir
request already exists in the icache and dcache by the time the mkdir
request returns.  For example, if the filesystem is mounted twice the
directory could be visible on the other mount before it is on the
original mount, and a pair of name_to_handle_at(), open_by_handle_at()
calls could instantiate the directory inode with an IS_ROOT() dentry
before the first mkdir returns.

This means that the dentry passed to ->mkdir() may not be the one that
is associated with the inode after the ->mkdir() completes.  Some
callers need to interact with the inode after the ->mkdir completes and
they currently need to perform a lookup in the (rare) case that the
dentry is no longer hashed.

This lookup-after-mkdir requires that the directory remains locked to
avoid races.  Planned future patches to lock the dentry rather than the
directory will mean that this lookup cannot be performed atomically with
the mkdir.

To remove this barrier, this patch changes ->mkdir to return the
resulting dentry if it is different from the one passed in.
Possible returns are:
  NULL - the directory was created and no other dentry was used
  ERR_PTR() - an error occurred
  non-NULL - this other dentry was spliced in

This patch only changes file-systems to return "ERR_PTR(err)" instead of
"err" or equivalent transformations.  Subsequent patches will make
further changes to some file-systems to return a correct dentry.

Not all filesystems reliably result in a positive hashed dentry:

- NFS, cifs, hostfs will sometimes need to perform a lookup of
  the name to get inode information.  Races could result in this
  returning something different. Note that this lookup is
  non-atomic which is what we are trying to avoid.  Placing the
  lookup in filesystem code means it only happens when the filesystem
  has no other option.
- kernfs and tracefs leave the dentry negative and the ->revalidate
  operation ensures that lookup will be called to correctly populate
  the dentry.  This could be fixed but I don't think it is important
  to any of the users of vfs_mkdir() which look at the dentry.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz> (VFS, ext2, ext4, ocfs2, udf)
Signed-off-by: NeilBrown <neilb@suse.de>
---
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/porting.rst | 19 +++++++++++++++++++
 Documentation/filesystems/vfs.rst     | 23 +++++++++++++++++++++--
 fs/9p/vfs_inode.c                     |  7 +++----
 fs/9p/vfs_inode_dotl.c                |  8 ++++----
 fs/affs/affs.h                        |  2 +-
 fs/affs/namei.c                       |  8 ++++----
 fs/afs/dir.c                          | 12 ++++++------
 fs/autofs/root.c                      | 14 +++++++-------
 fs/bad_inode.c                        |  6 +++---
 fs/bcachefs/fs.c                      |  6 +++---
 fs/btrfs/inode.c                      |  8 ++++----
 fs/ceph/dir.c                         |  8 ++++----
 fs/coda/dir.c                         | 14 +++++++-------
 fs/configfs/dir.c                     |  6 +++---
 fs/ecryptfs/inode.c                   |  6 +++---
 fs/exfat/namei.c                      |  8 ++++----
 fs/ext2/namei.c                       |  9 +++++----
 fs/ext4/namei.c                       | 10 +++++-----
 fs/f2fs/namei.c                       | 14 +++++++-------
 fs/fat/namei_msdos.c                  |  8 ++++----
 fs/fat/namei_vfat.c                   |  8 ++++----
 fs/fuse/dir.c                         |  6 +++---
 fs/gfs2/inode.c                       |  9 +++++----
 fs/hfs/dir.c                          | 10 +++++-----
 fs/hfsplus/dir.c                      |  6 +++---
 fs/hostfs/hostfs_kern.c               |  8 ++++----
 fs/hpfs/namei.c                       | 10 +++++-----
 fs/hugetlbfs/inode.c                  |  6 +++---
 fs/jffs2/dir.c                        | 18 +++++++++---------
 fs/jfs/namei.c                        |  8 ++++----
 fs/kernfs/dir.c                       | 12 ++++++------
 fs/minix/namei.c                      |  8 ++++----
 fs/namei.c                            | 15 ++++++++++++---
 fs/nfs/dir.c                          |  8 ++++----
 fs/nfs/internal.h                     |  4 ++--
 fs/nilfs2/namei.c                     |  8 ++++----
 fs/ntfs3/namei.c                      |  8 ++++----
 fs/ocfs2/dlmfs/dlmfs.c                | 10 +++++-----
 fs/ocfs2/namei.c                      | 10 +++++-----
 fs/omfs/dir.c                         |  6 +++---
 fs/orangefs/namei.c                   |  8 ++++----
 fs/overlayfs/dir.c                    |  9 +++++----
 fs/ramfs/inode.c                      |  6 +++---
 fs/smb/client/cifsfs.h                |  4 ++--
 fs/smb/client/inode.c                 | 10 +++++-----
 fs/sysv/namei.c                       |  8 ++++----
 fs/tracefs/inode.c                    | 10 +++++-----
 fs/ubifs/dir.c                        | 10 +++++-----
 fs/udf/namei.c                        | 12 ++++++------
 fs/ufs/namei.c                        |  8 ++++----
 fs/vboxsf/dir.c                       |  8 ++++----
 fs/xfs/xfs_iops.c                     |  4 ++--
 include/linux/fs.h                    |  4 ++--
 kernel/bpf/inode.c                    |  8 ++++----
 mm/shmem.c                            |  8 ++++----
 security/apparmor/apparmorfs.c        |  8 ++++----
 57 files changed, 275 insertions(+), 226 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d20a32b77b60..0ec0bb6eb0fb 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -66,7 +66,7 @@ prototypes::
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
+	struct dentry *(*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
 	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3ed3f39ecf71..d7171057aa3d 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1178,3 +1178,22 @@ these conditions don't require explicit checks:
 
 LOOKUP_EXCL now means "target must not exist".  It can be combined with
 LOOK_CREATE or LOOKUP_RENAME_TARGET.
+
+---
+
+** mandatory**
+
+->mkdir() now returns a 'struct dentry *'.  If the created inode is
+found to already be in cache and have a dentry (often IS_ROOT), it will
+need to be spliced into the given name in place of the given dentry.
+That dentry now needs to be returned.  If the original dentry is used,
+NULL should be returned.  Any error should be returned with
+ERR_PTR().
+
+In general, filesystems which use d_instantiate_new() to install the new
+inode can safely return NULL.  Filesystems which may not have an I_NEW inode
+should use d_drop();d_splice_alias() and return the result of the latter.
+
+If a positive dentry cannot be returned for some reason, in-kernel
+clients such as cachefiles, nfsd, smb/server may not perform ideally but
+will fail-safe.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 31eea688609a..ae79c30b6c0c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -495,7 +495,7 @@ As of kernel 2.6.22, the following members are defined:
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
 		int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,const char *);
-		int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
+		struct dentry *(*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
 		int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t,dev_t);
 		int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
@@ -562,7 +562,26 @@ otherwise noted.
 ``mkdir``
 	called by the mkdir(2) system call.  Only required if you want
 	to support creating subdirectories.  You will probably need to
-	call d_instantiate() just as you would in the create() method
+	call d_instantiate_new() just as you would in the create() method.
+
+	If d_instantiate_new() is not used and if the fh_to_dentry()
+	export operation is provided, or if the storage might be
+	accessible by another path (e.g. with a network filesystem)
+	then more care may be needed.  Importantly d_instantate()
+	should not be used with an inode that is no longer I_NEW if there
+	any chance that the inode could already be attached to a dentry.
+	This is because of a hard rule in the VFS that a directory must
+	only ever have one dentry.
+
+	For example, if an NFS filesystem is mounted twice the new directory
+	could be visible on the other mount before it is on the original
+	mount, and a pair of name_to_handle_at(), open_by_handle_at()
+	calls could instantiate the directory inode with an IS_ROOT()
+	dentry before the first mkdir returns.
+
+	If there is any chance this could happen, then the new inode
+	should be d_drop()ed and attached with d_splice_alias().  The
+	returned dentry (if any) should be returned by ->mkdir().
 
 ``rmdir``
 	called by the rmdir(2) system call.  Only required if you want
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3e68521f4e2f..399d455d50d6 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -669,8 +669,8 @@ v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
  *
  */
 
-static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			  struct dentry *dentry, umode_t mode)
+static struct dentry *v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				     struct dentry *dentry, umode_t mode)
 {
 	int err;
 	u32 perm;
@@ -692,8 +692,7 @@ static int v9fs_vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	if (fid)
 		p9_fid_put(fid);
-
-	return err;
+	return ERR_PTR(err);
 }
 
 /**
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 143ac03b7425..cc2007be2173 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -350,9 +350,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
  *
  */
 
-static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
-			       struct inode *dir, struct dentry *dentry,
-			       umode_t omode)
+static struct dentry *v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
+					  struct inode *dir, struct dentry *dentry,
+					  umode_t omode)
 {
 	int err;
 	struct v9fs_session_info *v9ses;
@@ -417,7 +417,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	p9_fid_put(fid);
 	v9fs_put_acl(dacl, pacl);
 	p9_fid_put(dfid);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index e8c2c4535cb3..ac4e9a02910b 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -168,7 +168,7 @@ extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, unsi
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
 extern int	affs_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool);
-extern int	affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+extern struct dentry *affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
 extern int	affs_link(struct dentry *olddentry, struct inode *dir,
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 8c154490a2d6..f883be50db12 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -273,7 +273,7 @@ affs_create(struct mnt_idmap *idmap, struct inode *dir,
 	return 0;
 }
 
-int
+struct dentry *
 affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	   struct dentry *dentry, umode_t mode)
 {
@@ -285,7 +285,7 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode = affs_new_inode(dir);
 	if (!inode)
-		return -ENOSPC;
+		return ERR_PTR(-ENOSPC);
 
 	inode->i_mode = S_IFDIR | mode;
 	affs_mode_to_prot(inode);
@@ -298,9 +298,9 @@ affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		clear_nlink(inode);
 		mark_inode_dirty(inode);
 		iput(inode);
-		return error;
+		return ERR_PTR(error);
 	}
-	return 0;
+	return NULL;
 }
 
 int
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 02cbf38e1a77..5bddcc20786e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -33,8 +33,8 @@ static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nl
 			      loff_t fpos, u64 ino, unsigned dtype);
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, bool excl);
-static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t mode);
+static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
 static int afs_unlink(struct inode *dir, struct dentry *dentry);
 static int afs_link(struct dentry *from, struct inode *dir,
@@ -1315,8 +1315,8 @@ static const struct afs_operation_ops afs_mkdir_operation = {
 /*
  * create a directory on an AFS filesystem
  */
-static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t mode)
+static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				struct dentry *dentry, umode_t mode)
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
@@ -1328,7 +1328,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	op = afs_alloc_operation(NULL, dvnode->volume);
 	if (IS_ERR(op)) {
 		d_drop(dentry);
-		return PTR_ERR(op);
+		return ERR_CAST(op);
 	}
 
 	fscache_use_cookie(afs_vnode_cache(dvnode), true);
@@ -1344,7 +1344,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	op->ops		= &afs_mkdir_operation;
 	ret = afs_do_sync_operation(op);
 	afs_dir_unuse_cookie(dvnode, ret);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 530d18827e35..174c7205fee4 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -15,8 +15,8 @@ static int autofs_dir_symlink(struct mnt_idmap *, struct inode *,
 			      struct dentry *, const char *);
 static int autofs_dir_unlink(struct inode *, struct dentry *);
 static int autofs_dir_rmdir(struct inode *, struct dentry *);
-static int autofs_dir_mkdir(struct mnt_idmap *, struct inode *,
-			    struct dentry *, umode_t);
+static struct dentry *autofs_dir_mkdir(struct mnt_idmap *, struct inode *,
+				       struct dentry *, umode_t);
 static long autofs_root_ioctl(struct file *, unsigned int, unsigned long);
 #ifdef CONFIG_COMPAT
 static long autofs_root_compat_ioctl(struct file *,
@@ -720,9 +720,9 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	return 0;
 }
 
-static int autofs_dir_mkdir(struct mnt_idmap *idmap,
-			    struct inode *dir, struct dentry *dentry,
-			    umode_t mode)
+static struct dentry *autofs_dir_mkdir(struct mnt_idmap *idmap,
+				       struct inode *dir, struct dentry *dentry,
+				       umode_t mode)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
@@ -739,7 +739,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 
 	inode = autofs_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	d_add(dentry, inode);
 
 	if (sbi->version < 5)
@@ -751,7 +751,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 	inc_nlink(dir);
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
-	return 0;
+	return NULL;
 }
 
 /* Get/set timeout ioctl() operation */
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 316d88da2ce1..0ef9bcb744dd 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -58,10 +58,10 @@ static int bad_inode_symlink(struct mnt_idmap *idmap,
 	return -EIO;
 }
 
-static int bad_inode_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			   struct dentry *dentry, umode_t mode)
+static struct dentry *bad_inode_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				      struct dentry *dentry, umode_t mode)
 {
-	return -EIO;
+	return ERR_PTR(-EIO);
 }
 
 static int bad_inode_rmdir (struct inode *dir, struct dentry *dentry)
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 90ade8f648d9..1c94a680fcce 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -858,10 +858,10 @@ static int bch2_symlink(struct mnt_idmap *idmap,
 	return bch2_err_class(ret);
 }
 
-static int bch2_mkdir(struct mnt_idmap *idmap,
-		      struct inode *vdir, struct dentry *dentry, umode_t mode)
+static struct dentry *bch2_mkdir(struct mnt_idmap *idmap,
+				 struct inode *vdir, struct dentry *dentry, umode_t mode)
 {
-	return bch2_mknod(idmap, vdir, dentry, mode|S_IFDIR, 0);
+	return ERR_PTR(bch2_mknod(idmap, vdir, dentry, mode|S_IFDIR, 0));
 }
 
 static int bch2_rename2(struct mnt_idmap *idmap,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a9322601ab5c..851d3e8a06a7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6739,18 +6739,18 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	return err;
 }
 
-static int btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 
 	inode = new_inode(dir->i_sb);
 	if (!inode)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	inode_init_owner(idmap, inode, dir, S_IFDIR | mode);
 	inode->i_op = &btrfs_dir_inode_operations;
 	inode->i_fop = &btrfs_dir_file_operations;
-	return btrfs_create_common(dir, dentry, inode);
+	return ERR_PTR(btrfs_create_common(dir, dentry, inode));
 }
 
 static noinline int uncompress_inline(struct btrfs_path *path,
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 62e99e65250d..39e0f240de06 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1092,8 +1092,8 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_client *cl = mdsc->fsc->client;
@@ -1104,7 +1104,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = ceph_wait_on_conflict_unlink(dentry);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* mkdir .snap/foo is a MKSNAP */
@@ -1173,7 +1173,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	else
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int ceph_link(struct dentry *old_dentry, struct inode *dir,
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index a3e2dfeedfbf..ab69d8f0cec2 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -166,8 +166,8 @@ static int coda_create(struct mnt_idmap *idmap, struct inode *dir,
 	return error;
 }
 
-static int coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *de, umode_t mode)
+static struct dentry *coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *de, umode_t mode)
 {
 	struct inode *inode;
 	struct coda_vattr attrs;
@@ -177,14 +177,14 @@ static int coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct CodaFid newfid;
 
 	if (is_root_inode(dir) && coda_iscontrol(name, len))
-		return -EPERM;
+		return ERR_PTR(-EPERM);
 
 	attrs.va_mode = mode;
-	error = venus_mkdir(dir->i_sb, coda_i2f(dir), 
+	error = venus_mkdir(dir->i_sb, coda_i2f(dir),
 			       name, len, &newfid, &attrs);
 	if (error)
 		goto err_out;
-         
+
 	inode = coda_iget(dir->i_sb, &newfid, &attrs);
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
@@ -195,10 +195,10 @@ static int coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	coda_dir_inc_nlink(dir);
 	coda_dir_update_mtime(dir);
 	d_instantiate(de, inode);
-	return 0;
+	return NULL;
 err_out:
 	d_drop(de);
-	return error;
+	return ERR_PTR(error);
 }
 
 /* try to make de an entry in dir_inodde linked to source_de */ 
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 7d10278db30d..5568cb74b322 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1280,8 +1280,8 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 }
 EXPORT_SYMBOL(configfs_depend_item_unlocked);
 
-static int configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			  struct dentry *dentry, umode_t mode)
+static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				     struct dentry *dentry, umode_t mode)
 {
 	int ret = 0;
 	int module_got = 0;
@@ -1461,7 +1461,7 @@ static int configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	put_fragment(frag);
 
 out:
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index a9819ddb1ab8..6315dd194228 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -503,8 +503,8 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	return rc;
 }
 
-static int ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			  struct dentry *dentry, umode_t mode)
+static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				     struct dentry *dentry, umode_t mode)
 {
 	int rc;
 	struct dentry *lower_dentry;
@@ -526,7 +526,7 @@ static int ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	inode_unlock(lower_dir);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
-	return rc;
+	return ERR_PTR(rc);
 }
 
 static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 691dd77b6ab5..1660c9bbcfa9 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -835,8 +835,8 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
@@ -846,7 +846,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	loff_t size = i_size_read(dir);
 
 	if (unlikely(exfat_forced_shutdown(sb)))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_set_volume_dirty(sb);
@@ -877,7 +877,7 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int exfat_check_dir_empty(struct super_block *sb,
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 8346ab9534c1..bde617a66cec 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -225,15 +225,16 @@ static int ext2_link (struct dentry * old_dentry, struct inode * dir,
 	return err;
 }
 
-static int ext2_mkdir(struct mnt_idmap * idmap,
-	struct inode * dir, struct dentry * dentry, umode_t mode)
+static struct dentry *ext2_mkdir(struct mnt_idmap * idmap,
+				 struct inode * dir, struct dentry * dentry,
+				 umode_t mode)
 {
 	struct inode * inode;
 	int err;
 
 	err = dquot_initialize(dir);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	inode_inc_link_count(dir);
 
@@ -258,7 +259,7 @@ static int ext2_mkdir(struct mnt_idmap * idmap,
 
 	d_instantiate_new(dentry, inode);
 out:
-	return err;
+	return ERR_PTR(err);
 
 out_fail:
 	inode_dec_link_count(inode);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 536d56d15072..716cc6096870 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3004,19 +3004,19 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	return err;
 }
 
-static int ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
 	int err, err2 = 0, credits, retries = 0;
 
 	if (EXT4_DIR_LINK_MAX(dir))
-		return -EMLINK;
+		return ERR_PTR(-EMLINK);
 
 	err = dquot_initialize(dir);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
@@ -3066,7 +3066,7 @@ static int ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 out_retry:
 	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
 		goto retry;
-	return err;
+	return ERR_PTR(err);
 }
 
 /*
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a278c7da8177..24dca4dc85a9 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -684,23 +684,23 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	err = f2fs_dquot_initialize(dir);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	inode = f2fs_new_inode(idmap, dir, S_IFDIR | mode, NULL);
 	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+		return ERR_CAST(inode);
 
 	inode->i_op = &f2fs_dir_inode_operations;
 	inode->i_fop = &f2fs_dir_operations;
@@ -722,12 +722,12 @@ static int f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
-	return 0;
+	return NULL;
 
 out_fail:
 	clear_inode_flag(inode, FI_INC_LINK);
 	f2fs_handle_failed_inode(inode);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index f06f6ba643cc..23e9b9371ec3 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -339,8 +339,8 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 /***** Make a directory */
-static int msdos_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *msdos_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct fat_slot_info sinfo;
@@ -389,13 +389,13 @@ static int msdos_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	mutex_unlock(&MSDOS_SB(sb)->s_lock);
 	fat_flush_inodes(sb, dir, inode);
-	return 0;
+	return NULL;
 
 out_free:
 	fat_free_clusters(dir, cluster);
 out:
 	mutex_unlock(&MSDOS_SB(sb)->s_lock);
-	return err;
+	return ERR_PTR(err);
 }
 
 /***** Unlink a file */
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 926c26e90ef8..dd910edd2404 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -841,8 +841,8 @@ static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int vfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *vfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
@@ -877,13 +877,13 @@ static int vfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	mutex_unlock(&MSDOS_SB(sb)->s_lock);
-	return 0;
+	return NULL;
 
 out_free:
 	fat_free_clusters(dir, cluster);
 out:
 	mutex_unlock(&MSDOS_SB(sb)->s_lock);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int vfat_get_dotdot_de(struct inode *inode, struct buffer_head **bh,
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b086ff..5bb65f38bfb8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -898,8 +898,8 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *entry, umode_t mode)
+static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *entry, umode_t mode)
 {
 	struct fuse_mkdir_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
@@ -917,7 +917,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
+	return ERR_PTR(create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR));
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6fbbaaad1cd0..198a8cbaf5e5 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1248,14 +1248,15 @@ static int gfs2_symlink(struct mnt_idmap *idmap, struct inode *dir,
  * @dentry: The dentry of the new directory
  * @mode: The mode of the new directory
  *
- * Returns: errno
+ * Returns: the dentry, or ERR_PTR(errno)
  */
 
-static int gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *gfs2_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
-	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0);
+
+	return ERR_PTR(gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0));
 }
 
 /**
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index b75c26045df4..86a6b317b474 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -219,26 +219,26 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
  * in a directory, given the inode for the parent directory and the
  * name (and its length) of the new directory.
  */
-static int hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t mode)
+static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
 	if (!inode)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
 		clear_nlink(inode);
 		hfs_delete_inode(inode);
 		iput(inode);
-		return res;
+		return ERR_PTR(res);
 	}
 	d_instantiate(dentry, inode);
 	mark_inode_dirty(inode);
-	return 0;
+	return NULL;
 }
 
 /*
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..876bbb80fb4d 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -523,10 +523,10 @@ static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
 	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
 
-static int hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+static struct dentry *hfsplus_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				    struct dentry *dentry, umode_t mode)
 {
-	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
+	return ERR_PTR(hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0));
 }
 
 static int hfsplus_rename(struct mnt_idmap *idmap,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index e0741e468956..ccbb48fe830d 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -679,17 +679,17 @@ static int hostfs_symlink(struct mnt_idmap *idmap, struct inode *ino,
 	return err;
 }
 
-static int hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
-			struct dentry *dentry, umode_t mode)
+static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
+				   struct dentry *dentry, umode_t mode)
 {
 	char *file;
 	int err;
 
 	if ((file = dentry_name(dentry)) == NULL)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	err = do_mkdir(file, mode);
 	__putname(file);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index d0edf9ed33b6..e3cdc421dfba 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -19,8 +19,8 @@ static void hpfs_update_directory_times(struct inode *dir)
 	hpfs_write_inode_nolock(dir);
 }
 
-static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	const unsigned char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
@@ -35,7 +35,7 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int r;
 	struct hpfs_dirent dee;
 	int err;
-	if ((err = hpfs_chk_name(name, &len))) return err==-ENOENT ? -EINVAL : err;
+	if ((err = hpfs_chk_name(name, &len))) return ERR_PTR(err==-ENOENT ? -EINVAL : err);
 	hpfs_lock(dir->i_sb);
 	err = -ENOSPC;
 	fnode = hpfs_alloc_fnode(dir->i_sb, hpfs_i(dir)->i_dno, &fno, &bh);
@@ -112,7 +112,7 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	hpfs_update_directory_times(dir);
 	d_instantiate(dentry, result);
 	hpfs_unlock(dir->i_sb);
-	return 0;
+	return NULL;
 bail3:
 	iput(result);
 bail2:
@@ -123,7 +123,7 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	hpfs_free_sectors(dir->i_sb, fno, 1);
 bail:
 	hpfs_unlock(dir->i_sb);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc179a59830..d98caedbb723 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -991,14 +991,14 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return 0;
 }
 
-static int hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			   struct dentry *dentry, umode_t mode)
+static struct dentry *hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				      struct dentry *dentry, umode_t mode)
 {
 	int retval = hugetlbfs_mknod(idmap, dir, dentry,
 				     mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
-	return retval;
+	return ERR_PTR(retval);
 }
 
 static int hugetlbfs_create(struct mnt_idmap *idmap,
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 2b2938970da3..dd91f725ded6 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -32,8 +32,8 @@ static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
 static int jffs2_symlink (struct mnt_idmap *, struct inode *,
 			  struct dentry *, const char *);
-static int jffs2_mkdir (struct mnt_idmap *, struct inode *,struct dentry *,
-			umode_t);
+static struct dentry *jffs2_mkdir (struct mnt_idmap *, struct inode *,struct dentry *,
+				   umode_t);
 static int jffs2_rmdir (struct inode *,struct dentry *);
 static int jffs2_mknod (struct mnt_idmap *, struct inode *,struct dentry *,
 			umode_t,dev_t);
@@ -446,8 +446,8 @@ static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 }
 
 
-static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
-		        struct dentry *dentry, umode_t mode)
+static struct dentry *jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
+				   struct dentry *dentry, umode_t mode)
 {
 	struct jffs2_inode_info *f, *dir_f;
 	struct jffs2_sb_info *c;
@@ -464,7 +464,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 
 	ri = jffs2_alloc_raw_inode();
 	if (!ri)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	c = JFFS2_SB_INFO(dir_i->i_sb);
 
@@ -477,7 +477,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 
 	if (ret) {
 		jffs2_free_raw_inode(ri);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	inode = jffs2_new_inode(dir_i, mode, ri);
@@ -485,7 +485,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 	if (IS_ERR(inode)) {
 		jffs2_free_raw_inode(ri);
 		jffs2_complete_reservation(c);
-		return PTR_ERR(inode);
+		return ERR_CAST(inode);
 	}
 
 	inode->i_op = &jffs2_dir_inode_operations;
@@ -584,11 +584,11 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
-	return 0;
+	return NULL;
 
  fail:
 	iget_failed(inode);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index fc8ede43afde..65a218eba8fa 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -187,13 +187,13 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
  *		dentry	- dentry of child directory
  *		mode	- create mode (rwxrwxrwx).
  *
- * RETURN:	Errors from subroutines
+ * RETURN:	ERR_PTR() of errors from subroutines.
  *
  * note:
  * EACCES: user needs search+write permission on the parent directory
  */
-static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
-		     struct dentry *dentry, umode_t mode)
+static struct dentry *jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
+				struct dentry *dentry, umode_t mode)
 {
 	int rc = 0;
 	tid_t tid;		/* transaction id */
@@ -308,7 +308,7 @@ static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
       out1:
 
 	jfs_info("jfs_mkdir: rc:%d", rc);
-	return rc;
+	return ERR_PTR(rc);
 }
 
 /*
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5f0f8b95f44c..d296aad70800 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1230,24 +1230,24 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	return d_splice_alias(inode, dentry);
 }
 
-static int kernfs_iop_mkdir(struct mnt_idmap *idmap,
-			    struct inode *dir, struct dentry *dentry,
-			    umode_t mode)
+static struct dentry *kernfs_iop_mkdir(struct mnt_idmap *idmap,
+				       struct inode *dir, struct dentry *dentry,
+				       umode_t mode)
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_syscall_ops *scops = kernfs_root(parent)->syscall_ops;
 	int ret;
 
 	if (!scops || !scops->mkdir)
-		return -EPERM;
+		return ERR_PTR(-EPERM);
 
 	if (!kernfs_get_active(parent))
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
 	ret = scops->mkdir(parent, dentry->d_name.name, mode);
 
 	kernfs_put_active(parent);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 5d9c1406fe27..8938536d8d3c 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -104,15 +104,15 @@ static int minix_link(struct dentry * old_dentry, struct inode * dir,
 	return add_nondir(dentry, inode);
 }
 
-static int minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
 
 	inode = minix_new_inode(dir, S_IFDIR | mode);
 	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+		return ERR_CAST(inode);
 
 	inode_inc_link_count(dir);
 	minix_set_inode(inode, 0);
@@ -128,7 +128,7 @@ static int minix_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate(dentry, inode);
 out:
-	return err;
+	return ERR_PTR(err);
 
 out_fail:
 	inode_dec_link_count(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 4677d86f9758..63fe4dc29c23 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4290,6 +4290,7 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
+	struct dentry *de;
 
 	error = may_create(idmap, dir, dentry);
 	if (error)
@@ -4306,10 +4307,18 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		return -EMLINK;
 
-	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
-	if (!error)
+	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	if (IS_ERR(de))
+		return PTR_ERR(de);
+	if (de) {
+		fsnotify_mkdir(dir, de);
+		/* Cannot return de yet */
+		dput(de);
+	} else {
 		fsnotify_mkdir(dir, dentry);
-	return error;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 56cf16a72334..101b1098e87b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2422,8 +2422,8 @@ EXPORT_SYMBOL_GPL(nfs_mknod);
 /*
  * See comments for nfs_proc_create regarding failed operations.
  */
-int nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode)
+struct dentry *nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
 	struct iattr attr;
 	int error;
@@ -2439,10 +2439,10 @@ int nfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	trace_nfs_mkdir_exit(dir, dentry, error);
 	if (error != 0)
 		goto out_err;
-	return 0;
+	return NULL;
 out_err:
 	d_drop(dentry);
-	return error;
+	return ERR_PTR(error);
 }
 EXPORT_SYMBOL_GPL(nfs_mkdir);
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fae2c7ae4acc..1ac1d3eec517 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -400,8 +400,8 @@ struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
 	       umode_t, bool);
-int nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
-	      umode_t);
+struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
+			 umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
 int nfs_unlink(struct inode *, struct dentry *);
 int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 953fbd5f0851..40f4b1a28705 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -218,8 +218,8 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	return err;
 }
 
-static int nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct nilfs_transaction_info ti;
@@ -227,7 +227,7 @@ static int nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	inc_nlink(dir);
 
@@ -258,7 +258,7 @@ static int nilfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	else
 		nilfs_transaction_abort(dir->i_sb);
 
-	return err;
+	return ERR_PTR(err);
 
 out_fail:
 	drop_nlink(inode);
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index abf7e81584a9..652735a0b0c4 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -201,11 +201,11 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 /*
  * ntfs_mkdir- inode_operations::mkdir
  */
-static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
-	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
-				 NULL, 0, NULL);
+	return ERR_PTR(ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
+					 NULL, 0, NULL));
 }
 
 /*
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 2a7f36643895..5130ec44e5e1 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -402,10 +402,10 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
  * File creation. Allocate an inode, and we're done..
  */
 /* SMP-safe */
-static int dlmfs_mkdir(struct mnt_idmap * idmap,
-		       struct inode * dir,
-		       struct dentry * dentry,
-		       umode_t mode)
+static struct dentry *dlmfs_mkdir(struct mnt_idmap * idmap,
+				  struct inode * dir,
+				  struct dentry * dentry,
+				  umode_t mode)
 {
 	int status;
 	struct inode *inode = NULL;
@@ -448,7 +448,7 @@ static int dlmfs_mkdir(struct mnt_idmap * idmap,
 bail:
 	if (status < 0)
 		iput(inode);
-	return status;
+	return ERR_PTR(status);
 }
 
 static int dlmfs_create(struct mnt_idmap *idmap,
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 0ec63a1a94b8..99278c8f0e24 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -644,10 +644,10 @@ static int ocfs2_mknod_locked(struct ocfs2_super *osb,
 				    suballoc_loc, suballoc_bit);
 }
 
-static int ocfs2_mkdir(struct mnt_idmap *idmap,
-		       struct inode *dir,
-		       struct dentry *dentry,
-		       umode_t mode)
+static struct dentry *ocfs2_mkdir(struct mnt_idmap *idmap,
+				  struct inode *dir,
+				  struct dentry *dentry,
+				  umode_t mode)
 {
 	int ret;
 
@@ -657,7 +657,7 @@ static int ocfs2_mkdir(struct mnt_idmap *idmap,
 	if (ret)
 		mlog_errno(ret);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int ocfs2_create(struct mnt_idmap *idmap,
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 6bda275826d6..2ed541fccf33 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -279,10 +279,10 @@ static int omfs_add_node(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
-static int omfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *omfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
-	return omfs_add_node(dir, dentry, mode | S_IFDIR);
+	return ERR_PTR(omfs_add_node(dir, dentry, mode | S_IFDIR));
 }
 
 static int omfs_create(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 200558ec72f0..82395fe2b956 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -300,8 +300,8 @@ static int orangefs_symlink(struct mnt_idmap *idmap,
 	return ret;
 }
 
-static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			  struct dentry *dentry, umode_t mode)
+static struct dentry *orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				     struct dentry *dentry, umode_t mode)
 {
 	struct orangefs_inode_s *parent = ORANGEFS_I(dir);
 	struct orangefs_kernel_op_s *new_op;
@@ -312,7 +312,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_MKDIR);
 	if (!new_op)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	new_op->upcall.req.mkdir.parent_refn = parent->refn;
 
@@ -366,7 +366,7 @@ static int orangefs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	__orangefs_setattr(dir, &iattr);
 out:
 	op_release(new_op);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int orangefs_rename(struct mnt_idmap *idmap,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index c9993ff66fc2..21c3aaf7b274 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -282,7 +282,8 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
 		 * XXX: if we ever use ovl_obtain_alias() to decode directory
 		 * file handles, need to use ovl_get_inode_locked() and
 		 * d_instantiate_new() here to prevent from creating two
-		 * hashed directory inode aliases.
+		 * hashed directory inode aliases.  We then need to return
+		 * the obtained alias to ovl_mkdir().
 		 */
 		inode = ovl_get_inode(dentry->d_sb, &oip);
 		if (IS_ERR(inode))
@@ -687,10 +688,10 @@ static int ovl_create(struct mnt_idmap *idmap, struct inode *dir,
 	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
 }
 
-static int ovl_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t mode)
+static struct dentry *ovl_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				struct dentry *dentry, umode_t mode)
 {
-	return ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL);
+	return ERR_PTR(ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL));
 }
 
 static int ovl_mknod(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 8006faaaf0ec..775fa905fda0 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -119,13 +119,13 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return error;
 }
 
-static int ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	int retval = ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
-	return retval;
+	return ERR_PTR(retval);
 }
 
 static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 831fee962c4d..8dea0cf3a8de 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -59,8 +59,8 @@ extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
 extern int cifs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 		      umode_t, dev_t);
-extern int cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
-		      umode_t);
+extern struct dentry *cifs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
+				 umode_t);
 extern int cifs_rmdir(struct inode *, struct dentry *);
 extern int cifs_rename2(struct mnt_idmap *, struct inode *,
 			struct dentry *, struct inode *, struct dentry *,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 9cc31cf6ebd0..685a176f7f7e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2194,8 +2194,8 @@ cifs_posix_mkdir(struct inode *inode, struct dentry *dentry, umode_t mode,
 }
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
-int cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
-	       struct dentry *direntry, umode_t mode)
+struct dentry *cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
+			  struct dentry *direntry, umode_t mode)
 {
 	int rc = 0;
 	unsigned int xid;
@@ -2211,10 +2211,10 @@ int cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
 
 	cifs_sb = CIFS_SB(inode->i_sb);
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
-		return -EIO;
+		return ERR_PTR(-EIO);
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
-		return PTR_ERR(tlink);
+		return ERR_CAST(tlink);
 	tcon = tlink_tcon(tlink);
 
 	xid = get_xid();
@@ -2270,7 +2270,7 @@ int cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
 	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
-	return rc;
+	return ERR_PTR(rc);
 }
 
 int cifs_rmdir(struct inode *inode, struct dentry *direntry)
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index fb8bd8437872..ba037727c1e6 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -110,8 +110,8 @@ static int sysv_link(struct dentry * old_dentry, struct inode * dir,
 	return add_nondir(dentry, inode);
 }
 
-static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode)
+static struct dentry *sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
@@ -135,9 +135,9 @@ static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-        d_instantiate(dentry, inode);
+	d_instantiate(dentry, inode);
 out:
-	return err;
+	return ERR_PTR(err);
 
 out_fail:
 	inode_dec_link_count(inode);
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 53214499e384..cb1af30b49f5 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -109,9 +109,9 @@ static char *get_dname(struct dentry *dentry)
 	return name;
 }
 
-static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
-				 struct inode *inode, struct dentry *dentry,
-				 umode_t mode)
+static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
+					    struct inode *inode, struct dentry *dentry,
+					    umode_t mode)
 {
 	struct tracefs_inode *ti;
 	char *name;
@@ -119,7 +119,7 @@ static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
 
 	name = get_dname(dentry);
 	if (!name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/*
 	 * This is a new directory that does not take the default of
@@ -141,7 +141,7 @@ static int tracefs_syscall_mkdir(struct mnt_idmap *idmap,
 
 	kfree(name);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index fda82f3e16e8..3c3d3ad4fa6c 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1002,8 +1002,8 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
@@ -1023,7 +1023,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	err = ubifs_budget_space(c, &req);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	err = ubifs_prepare_create(dir, dentry, &nm);
 	if (err)
@@ -1060,7 +1060,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	ubifs_release_budget(c, &req);
 	d_instantiate(dentry, inode);
 	fscrypt_free_filename(&nm);
-	return 0;
+	return NULL;
 
 out_cancel:
 	dir->i_size -= sz_change;
@@ -1074,7 +1074,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fscrypt_free_filename(&nm);
 out_budg:
 	ubifs_release_budget(c, &req);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 2cb49b6b0716..5f2e9a892bff 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -419,8 +419,8 @@ static int udf_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	return udf_add_nondir(dentry, inode);
 }
 
-static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t mode)
+static struct dentry *udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct udf_fileident_iter iter;
@@ -430,7 +430,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode = udf_new_inode(dir, S_IFDIR | mode);
 	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+		return ERR_CAST(inode);
 
 	iinfo = UDF_I(inode);
 	inode->i_op = &udf_dir_inode_operations;
@@ -439,7 +439,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (err) {
 		clear_nlink(inode);
 		discard_new_inode(inode);
-		return err;
+		return ERR_PTR(err);
 	}
 	set_nlink(inode, 2);
 	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
@@ -456,7 +456,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (err) {
 		clear_nlink(inode);
 		discard_new_inode(inode);
-		return err;
+		return ERR_PTR(err);
 	}
 	iter.fi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
 	iter.fi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
@@ -471,7 +471,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	mark_inode_dirty(dir);
 	d_instantiate_new(dentry, inode);
 
-	return 0;
+	return NULL;
 }
 
 static int empty_dir(struct inode *dir)
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 38a024c8cccd..5b3c85c93242 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -166,8 +166,8 @@ static int ufs_link (struct dentry * old_dentry, struct inode * dir,
 	return error;
 }
 
-static int ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
-	struct dentry * dentry, umode_t mode)
+static struct dentry *ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
+				struct dentry * dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
@@ -194,7 +194,7 @@ static int ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
 		goto out_fail;
 
 	d_instantiate_new(dentry, inode);
-	return 0;
+	return NULL;
 
 out_fail:
 	inode_dec_link_count(inode);
@@ -202,7 +202,7 @@ static int ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
 	discard_new_inode(inode);
 out_dir:
 	inode_dec_link_count(dir);
-	return err;
+	return ERR_PTR(err);
 }
 
 static int ufs_unlink(struct inode *dir, struct dentry *dentry)
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index a859ac9b74ba..770e29ec3557 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -303,11 +303,11 @@ static int vboxsf_dir_mkfile(struct mnt_idmap *idmap,
 	return vboxsf_dir_create(parent, dentry, mode, false, excl, NULL);
 }
 
-static int vboxsf_dir_mkdir(struct mnt_idmap *idmap,
-			    struct inode *parent, struct dentry *dentry,
-			    umode_t mode)
+static struct dentry *vboxsf_dir_mkdir(struct mnt_idmap *idmap,
+				       struct inode *parent, struct dentry *dentry,
+				       umode_t mode)
 {
-	return vboxsf_dir_create(parent, dentry, mode, true, true, NULL);
+	return ERR_PTR(vboxsf_dir_create(parent, dentry, mode, true, true, NULL));
 }
 
 static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 40289fe6f5b2..a4480098d2bf 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -298,14 +298,14 @@ xfs_vn_create(
 	return xfs_generic_create(idmap, dir, dentry, mode, 0, NULL);
 }
 
-STATIC int
+STATIC struct dentry *
 xfs_vn_mkdir(
 	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
 	umode_t			mode)
 {
-	return xfs_generic_create(idmap, dir, dentry, mode | S_IFDIR, 0, NULL);
+	return ERR_PTR(xfs_generic_create(idmap, dir, dentry, mode | S_IFDIR, 0, NULL));
 }
 
 STATIC struct dentry *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac5d699e3aab..8f4fbecd40fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2201,8 +2201,8 @@ struct inode_operations {
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
 			const char *);
-	int (*mkdir) (struct mnt_idmap *, struct inode *,struct dentry *,
-		      umode_t);
+	struct dentry *(*mkdir) (struct mnt_idmap *, struct inode *,
+				 struct dentry *, umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
 	int (*mknod) (struct mnt_idmap *, struct inode *,struct dentry *,
 		      umode_t,dev_t);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9aaf5124648b..dc3aa91a6ba0 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -150,14 +150,14 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 }
 
-static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t mode)
+static struct dentry *bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 
 	inode = bpf_get_inode(dir->i_sb, dir, mode | S_IFDIR);
 	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+		return ERR_CAST(inode);
 
 	inode->i_op = &bpf_dir_iops;
 	inode->i_fop = &simple_dir_operations;
@@ -166,7 +166,7 @@ static int bpf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	inc_nlink(dir);
 
 	bpf_dentry_finalize(dentry, inode, dir);
-	return 0;
+	return NULL;
 }
 
 struct map_iter {
diff --git a/mm/shmem.c b/mm/shmem.c
index 4ea6109a8043..00ae0146e768 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3889,16 +3889,16 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	return error;
 }
 
-static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	int error;
 
 	error = shmem_mknod(idmap, dir, dentry, mode | S_IFDIR, 0);
 	if (error)
-		return error;
+		return ERR_PTR(error);
 	inc_nlink(dir);
-	return 0;
+	return NULL;
 }
 
 static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index c07d150685d7..6039afae4bfc 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1795,8 +1795,8 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	return error;
 }
 
-static int ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode)
+static struct dentry *ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode)
 {
 	struct aa_ns *ns, *parent;
 	/* TODO: improve permission check */
@@ -1808,7 +1808,7 @@ static int ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
 				     AA_MAY_LOAD_POLICY);
 	end_current_label_crit_section(label);
 	if (error)
-		return error;
+		return ERR_PTR(error);
 
 	parent = aa_get_ns(dir->i_private);
 	AA_BUG(d_inode(ns_subns_dir(parent)) != dir);
@@ -1843,7 +1843,7 @@ static int ns_mkdir_op(struct mnt_idmap *idmap, struct inode *dir,
 	mutex_unlock(&parent->lock);
 	aa_put_ns(parent);
 
-	return error;
+	return ERR_PTR(error);
 }
 
 static int ns_rmdir_op(struct inode *dir, struct dentry *dentry)
-- 
2.47.1


