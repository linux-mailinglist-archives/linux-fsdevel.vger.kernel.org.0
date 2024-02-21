Return-Path: <linux-fsdevel+bounces-12384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36C85EAC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10651C22CE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7188F14A0A6;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7RtPOwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3AD12BF0F;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=pdajl6wYkBzPyiMzyffaAdo2a2g4HoGH4SggB5dArf1PsR5hnZvRwNkMLBMYOV55ZMMSx4C+q3X2qMRMxcT6Ww/32YCpZczYGKDIhjXYl7evJb2IWhlgnaSUuorSzEjvBGlXO2MN2LNTBMk1orMmf7B2gCf48hYsx9qLueksybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=yjTkC6GQSOdkd/yofwHxTRqqG6BMoKBOmSs9mRH3lD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTpGiLNixfm/+/KN9pL+Qc6kLBPkX7Ro9C22ZGcFlN+FuPBr2G6xm7SNzTlu6l6t7BalBmU4Je9ZVnEezJR8QUUyjyKDQdNqAFeOPC8H2V7pDjZOT9zDaYaUP45YrGEkT6lwdm04uHT/W246SLhO/VGgq3PqKyuBOAPWfM8h3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7RtPOwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF4CFC32794;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=yjTkC6GQSOdkd/yofwHxTRqqG6BMoKBOmSs9mRH3lD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P7RtPOwFXQfE4KiawGw7UD+AwPubpqVY0iIJcNPerSUBJL36yOifCmQi+HqGF16Cp
	 A8ZpZ/BFTcBqXIpcRIh7IFE+n9k72v3i2I00Un+TNBvYxin8X7EwdZJogNd0QQqMed
	 WOMMpToeKNHRSt6dAAHWUWllAjzc9dEGVP2P3TzYw+HIps3qPMPCs7VJ6MQ+Fb3Moi
	 OBtqAV/6HFxUjipd3IewCctX792BSLaICcJijN/K3cYuNOSR8rJekeaofXqNh+qrJI
	 B6f8RWwZX+YIXmYzLi0QFAkgzTE44Wji71wP7ulDPF6PXLzGKTTrJkLnWJlQSLwaTn
	 au2a08gbKlnPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD7C5478C;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:47 -0600
Subject: [PATCH v2 16/25] fs: add inode operations to get/set/remove fscaps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-16-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=yjTkC6GQSOdkd/yofwHxTRqqG6BMoKBOmSs9mRH3lD0=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1momcOrJrmhhvfSlvseUc5Zkz?=
 =?utf-8?q?jX47oXe/xbCoMiA_8Fhev46JATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqJgAKCRBTA5mu5fQxyTg8B/_4pdFVXDzplj+s5uQiNwRqie7BpHWe3tIOvD?=
 =?utf-8?q?iVGDv576tfzBZUMOtKIm4/hiistj+rni3+bxxxwy1bZ_h2v2QzDZVJACen4oBtiHh?=
 =?utf-8?q?n0ushKMMxAvjSU7gdjX2S93lwm7Zohpkq/zf/lVpj4tqQyk0Y8m+qcThW_YSWAFw6?=
 =?utf-8?q?66PemdoaOc3QKfeORxCuCimtGEScFebmaQXGK/fwUz6wQxVfIG+BzsMs4ZMK32RRt?=
 =?utf-8?q?T8y+cI_uKeQCrUVe1DzsTGff5EIdRfwgo5m+3LEV/8lmR4ZceA2pKeEJfJ0OuFbvh?=
 =?utf-8?q?f3JV0P3lbi/mcCDdcZdT?= SZkQ1U89qyGJRlXpcGom2dKvclDCVV
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Add inode operations for getting, setting and removing filesystem
capabilities rather than passing around raw xattr data. This provides
better type safety for ids contained within xattrs.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 Documentation/filesystems/locking.rst |  4 ++++
 Documentation/filesystems/vfs.rst     | 17 +++++++++++++++++
 include/linux/fs.h                    |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d5bf4b6b7509..d208dd9f75ae 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -81,6 +81,8 @@ prototypes::
 				umode_t create_mode);
 	int (*tmpfile) (struct mnt_idmap *, struct inode *,
 			struct file *, umode_t);
+	int (*get_fscaps)(struct mnt_idmap *, struct dentry *, struct vfs_caps *);
+	int (*set_fscaps)(struct mnt_idmap *, struct dentry *, const struct vfs_caps *, int setxattr_flags);
 	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
@@ -114,6 +116,8 @@ fiemap:		no
 update_time:	no
 atomic_open:	shared (exclusive if O_CREAT is set in open flags)
 tmpfile:	no
+get_fscaps:     no
+set_fscaps:     exclusive
 fileattr_get:	no or exclusive
 fileattr_set:	exclusive
 get_offset_ctx  no
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index eebcc0f9e2bc..ed1cb03f271e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -514,6 +514,8 @@ As of kernel 2.6.22, the following members are defined:
 		int (*tmpfile) (struct mnt_idmap *, struct inode *, struct file *, umode_t);
 		struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
 	        int (*set_acl)(struct mnt_idmap *, struct dentry *, struct posix_acl *, int);
+		int (*get_fscaps)(struct mnt_idmap *, struct dentry *, struct vfs_caps *);
+		int (*set_fscaps)(struct mnt_idmap *, struct dentry *, const struct vfs_caps *, int setxattr_flags);
 		int (*fileattr_set)(struct mnt_idmap *idmap,
 				    struct dentry *dentry, struct fileattr *fa);
 		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
@@ -667,6 +669,21 @@ otherwise noted.
 	open; this can be done by calling finish_open_simple() right at
 	the end.
 
+``get_fscaps``
+
+        called to get filesystem capabilites of an inode.  If unset,
+        xattr handlers will be used to get the raw xattr data.  Most
+        filesystems can rely on the generic handler.
+
+``set_fscaps``
+
+        called to set filesystem capabilites of an inode.  If unset,
+        xattr handlers will be used to set the raw xattr data.  Most
+        filesystems can rely on the generic handler.
+
+        If the new fscaps value is NULL the filesystem must remove any
+        fscaps from the inode.
+
 ``fileattr_get``
 	called on ioctl(FS_IOC_GETFLAGS) and ioctl(FS_IOC_FSGETXATTR) to
 	retrieve miscellaneous file flags and attributes.  Also called
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..89163e0f7aad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2067,6 +2067,10 @@ struct inode_operations {
 				     int);
 	int (*set_acl)(struct mnt_idmap *, struct dentry *,
 		       struct posix_acl *, int);
+	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
+			  struct vfs_caps *);
+	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
+			  const struct vfs_caps *, int setxattr_flags);
 	int (*fileattr_set)(struct mnt_idmap *idmap,
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);

-- 
2.43.0


