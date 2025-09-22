Return-Path: <linux-fsdevel+bounces-62362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B075B8EF13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6DB3BC992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB61E9B3A;
	Mon, 22 Sep 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="qv6SKEC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CemvuxaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656F29A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515624; cv=none; b=Y7BVkD1AHPHoHzWvl8kAQ1E5r788ubV0njEWO1VW+hbHacWbFXJJOhLZ1ff6QbYn9mkdJePD93Ejf1UnJ6Z+NSlwtbi9KoroBaWIoFxg7nC7aZDvGMJtn67cMZSKp4NCs1BgBefVPuyOA9G2x6qtfaFzMPkwqpnxkwPQ+KBOD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515624; c=relaxed/simple;
	bh=TIsj6/Mq0fwi6Xj2eZJkyMvJUgMAmA9wEzhORLNPesw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL+w/uTa16wJO2klK/QgAxkKPfGqQfyCJR/w2iaZ+ryI9hfbC1ywlKR+ZvDm9XYKVogDLSCoEdzKta4o2gk3jTRnSRhF/k6zXtdYnEIF4tSGVPvUaoAbuxgslUqAeJVfP34gsY2I2P5HzEUC8n0n8u4bEVjOnLPt2IG1beaeUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=qv6SKEC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CemvuxaV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3258B140009D;
	Mon, 22 Sep 2025 00:33:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 00:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758515621;
	 x=1758602021; bh=Ir1pfD5bkV/URucj0uhGCRDDqWf24soKfeZ7iW0dT6w=; b=
	qv6SKEC3P6eHSLuYbZxPl5D8z+BUC5/spPnelMRQPKCPnz18QdBEZLjKwVJuEDMV
	vixHcV1E57y7WMLqbwXEVY1WAbn1EPtpY6aU3jLWIxF2qIv4PVYZixs0x/eDrzCc
	HcQDnCWCVpAdCg6Yt5MRX5jK1n8EV66BdvgDplaaQi37KZNtx8NzY7K8DwBXYIIm
	n/c9pvL+focCwDlcP6Z2ZpD4fFoI5cQjelGam0hN72M5LkVuqk8lm2VpeqfykVW3
	dz9xvNdXUIeFyc3ZMJaeItP9JBI0GqVhBg+DrLARPYgK989ZNAEKwWLm+O5aqtuH
	p5aWFRPNTlMYED/SEBOrOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758515621; x=1758602021; bh=I
	r1pfD5bkV/URucj0uhGCRDDqWf24soKfeZ7iW0dT6w=; b=CemvuxaVxhFuPULbN
	5N9ApOB3lFQqpZ2GV4EV0JeGgTrhkh9V2FcdbHLvNsc1UlpPFm83rCmCuthWRNvc
	AyEs6r87/CqVyvSderxT08NlTdCvdGqxed1RccIIuXGx283pX/Pv74Ijdjs77zHs
	zSfu3mcLq0/r7jFYbyuqStHA0/872uG779mgiACBVAsKCJMpvFX/RL7JexkJZdUu
	1G03k1enW0XOxQFRgqSjjBB4p4l46rPP+VFszaAsmbAHp62VdBEfiFxW9m2SoIPT
	QrY3Y46l/u+PJDvTw32pF4SGQbYJiUibV87/mjPgmNJgo/pRkDxj0QH7M1VB/7jC
	ET2JA==
X-ME-Sender: <xms:pdHQaDrmfXnE602J-8H6N9oS_sVlacFzjotELztzBLhkRBGc06a49g>
    <xme:pdHQaFCZ824H9xreRMyxuq7hYWPOYDCnlQ_E-8DYI4Q5q0RbcHLHSDfiLVu_txZGj
    mP69jaljh8Iqw>
X-ME-Received: <xmr:pdHQaFwrBM7WVb6H0RkTqkbbeNt85YfYZsgRc2vTJShxlXl2yCXOmDomT_nZmFwMkbd6j3ATvpc_vBDsSlD4qea5mNy27DYp1WpR_XfBoDN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pdHQaC36ziJlNTtGJzogCz9Mad59QJ3yJncnvKuUxMtvSmpOblcEqQ>
    <xmx:pdHQaFxhEP1oNdfc0v8EHSicdrXCy3GBn071rEEe7oTQZ8Uxlo3Itg>
    <xmx:pdHQaJHw9kcOqzry5o7j91NME96Qr-67wuL-FXvjKoV0rjH95Fvnkg>
    <xmx:pdHQaIYTQFYeDXbGmr9ZlFgK84cMtcur3cdtpIDPod99eh45Gq4a_Q>
    <xmx:pdHQaEa835baKGjIH31v46ypJvyY0hrHQJk-2yF02FvY20pIG2sac-Du>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:33:38 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 5/6] VFS: rename kern_path_locked() and related functions.
Date: Mon, 22 Sep 2025 14:29:52 +1000
Message-ID: <20250922043121.193821-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250922043121.193821-1-neilb@ownmail.net>
References: <20250922043121.193821-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

kern_path_locked() is now only used to prepare for removing an object
from the filesystem (and that is the only credible reason for wanting a
positive locked dentry).  Thus it corresponds to kern_path_create() and
so should have a corresponding name.

Unfortunately the name "kern_path_create" is somewhat misleading as it
doesn't actually create anything.  The recently added
simple_start_creating() provides a better pattern I believe.  The
"start" can be matched with "end" to bracket the creating or removing.

So this patch changes names:

 kern_path_locked -> start_removing_path
 kern_path_create -> start_creating_path
 user_path_create -> start_creating_user_path
 user_path_locked_at -> start_removing_user_path_at
 done_path_create -> end_creating_path

and also introduces end_removing_path() which is identical to
end_creating_path().

__start_removing_path (which was __kern_path_locked) is enhanced to
call mnt_want_write() for consistency with the start_creating_path().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst        | 12 ++++
 arch/powerpc/platforms/cell/spufs/syscalls.c |  4 +-
 drivers/base/devtmpfs.c                      | 22 +++-----
 fs/bcachefs/fs-ioctl.c                       | 10 ++--
 fs/init.c                                    | 17 +++---
 fs/namei.c                                   | 59 ++++++++++++--------
 fs/ocfs2/refcounttree.c                      |  4 +-
 fs/smb/server/vfs.c                          |  8 +--
 include/linux/namei.h                        | 14 +++--
 kernel/bpf/inode.c                           |  4 +-
 net/unix/af_unix.c                           |  6 +-
 11 files changed, 93 insertions(+), 67 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..e0494860be6b 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,15 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+---
+
+**mandatory**
+
+Several functions are renamed:
+
+-  kern_path_locked -> start_removing_path
+-  kern_path_create -> start_creating_path
+-  user_path_create -> start_creating_user_path
+-  user_path_locked_at -> start_removing_user_path_at
+-  done_path_create -> end_creating_path
diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index 157e046e6e93..ea4ba1b6ce6a 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -67,11 +67,11 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
 	struct dentry *dentry;
 	int ret;
 
-	dentry = user_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
+	dentry = start_creating_user_path(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
 	ret = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		ret = spufs_create(&path, dentry, flags, mode, neighbor);
-		done_path_create(&path, dentry);
+		end_creating_path(&path, dentry);
 	}
 
 	return ret;
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 31bfb3194b4c..9d4e46ad8352 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -176,7 +176,7 @@ static int dev_mkdir(const char *name, umode_t mode)
 	struct dentry *dentry;
 	struct path path;
 
-	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
+	dentry = start_creating_path(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -184,7 +184,7 @@ static int dev_mkdir(const char *name, umode_t mode)
 	if (!IS_ERR(dentry))
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
@@ -222,10 +222,10 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 	struct path path;
 	int err;
 
-	dentry = kern_path_create(AT_FDCWD, nodename, &path, 0);
+	dentry = start_creating_path(AT_FDCWD, nodename, &path, 0);
 	if (dentry == ERR_PTR(-ENOENT)) {
 		create_path(nodename);
-		dentry = kern_path_create(AT_FDCWD, nodename, &path, 0);
+		dentry = start_creating_path(AT_FDCWD, nodename, &path, 0);
 	}
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
@@ -246,7 +246,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 		/* mark as kernel-created inode */
 		d_inode(dentry)->i_private = &thread;
 	}
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return err;
 }
 
@@ -256,7 +256,7 @@ static int dev_rmdir(const char *name)
 	struct dentry *dentry;
 	int err;
 
-	dentry = kern_path_locked(name, &parent);
+	dentry = start_removing_path(name, &parent);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	if (d_inode(dentry)->i_private == &thread)
@@ -265,9 +265,7 @@ static int dev_rmdir(const char *name)
 	else
 		err = -EPERM;
 
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
-	path_put(&parent);
+	end_removing_path(&parent, dentry);
 	return err;
 }
 
@@ -325,7 +323,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 	int deleted = 0;
 	int err = 0;
 
-	dentry = kern_path_locked(nodename, &parent);
+	dentry = start_removing_path(nodename, &parent);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -349,10 +347,8 @@ static int handle_remove(const char *nodename, struct device *dev)
 		if (!err || err == -ENOENT)
 			deleted = 1;
 	}
-	dput(dentry);
-	inode_unlock(d_inode(parent.dentry));
+	end_removing_path(&parent, dentry);
 
-	path_put(&parent);
 	if (deleted && strchr(nodename, '/'))
 		delete_path(nodename);
 	return err;
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 4e72e654da96..43510da5e734 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -255,7 +255,7 @@ static long bch2_ioctl_subvolume_create(struct bch_fs *c, struct file *filp,
 		snapshot_src = inode_inum(to_bch_ei(src_path.dentry->d_inode));
 	}
 
-	dst_dentry = user_path_create(arg.dirfd,
+	dst_dentry = start_creating_user_path(arg.dirfd,
 			(const char __user *)(unsigned long)arg.dst_ptr,
 			&dst_path, lookup_flags);
 	error = PTR_ERR_OR_ZERO(dst_dentry);
@@ -314,7 +314,7 @@ static long bch2_ioctl_subvolume_create(struct bch_fs *c, struct file *filp,
 	d_instantiate(dst_dentry, &inode->v);
 	fsnotify_mkdir(dir, dst_dentry);
 err3:
-	done_path_create(&dst_path, dst_dentry);
+	end_creating_path(&dst_path, dst_dentry);
 err2:
 	if (arg.src_ptr)
 		path_put(&src_path);
@@ -334,7 +334,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 	if (arg.flags)
 		return -EINVAL;
 
-	victim = user_path_locked_at(arg.dirfd, name, &path);
+	victim = start_removing_user_path_at(arg.dirfd, name, &path);
 	if (IS_ERR(victim))
 		return PTR_ERR(victim);
 
@@ -351,9 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 		d_invalidate(victim);
 	}
 err:
-	inode_unlock(dir);
-	dput(victim);
-	path_put(&path);
+	end_removing_path(&path, victim);
 	return ret;
 }
 
diff --git a/fs/init.c b/fs/init.c
index eef5124885e3..07f592ccdba8 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -149,7 +149,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	else if (!(S_ISBLK(mode) || S_ISCHR(mode)))
 		return -EINVAL;
 
-	dentry = kern_path_create(AT_FDCWD, filename, &path, 0);
+	dentry = start_creating_path(AT_FDCWD, filename, &path, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -158,7 +158,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 	if (!error)
 		error = vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_inode,
 				  dentry, mode, new_decode_dev(dev));
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return error;
 }
 
@@ -173,7 +173,7 @@ int __init init_link(const char *oldname, const char *newname)
 	if (error)
 		return error;
 
-	new_dentry = kern_path_create(AT_FDCWD, newname, &new_path, 0);
+	new_dentry = start_creating_path(AT_FDCWD, newname, &new_path, 0);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto out;
@@ -191,7 +191,7 @@ int __init init_link(const char *oldname, const char *newname)
 	error = vfs_link(old_path.dentry, idmap, new_path.dentry->d_inode,
 			 new_dentry, NULL);
 out_dput:
-	done_path_create(&new_path, new_dentry);
+	end_creating_path(&new_path, new_dentry);
 out:
 	path_put(&old_path);
 	return error;
@@ -203,14 +203,14 @@ int __init init_symlink(const char *oldname, const char *newname)
 	struct path path;
 	int error;
 
-	dentry = kern_path_create(AT_FDCWD, newname, &path, 0);
+	dentry = start_creating_path(AT_FDCWD, newname, &path, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				    dentry, oldname);
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return error;
 }
 
@@ -225,7 +225,8 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 	struct path path;
 	int error;
 
-	dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
+	dentry = start_creating_path(AT_FDCWD, pathname, &path,
+				     LOOKUP_DIRECTORY);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 	mode = mode_strip_umask(d_inode(path.dentry), mode);
@@ -236,7 +237,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return error;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 4017bc8641d3..92973a7a8091 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2758,7 +2758,8 @@ static int filename_parentat(int dfd, struct filename *name,
 }
 
 /* does lookup, returns the object with parent locked */
-static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct path *path)
+static struct dentry *__start_removing_path(int dfd, struct filename *name,
+					   struct path *path)
 {
 	struct path parent_path __free(path_put) = {};
 	struct dentry *d;
@@ -2770,15 +2771,26 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
+	/* don't fail immediately if it's r/o, at least try to report other errors */
+	error = mnt_want_write(parent_path.mnt);
 	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
 	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
-		return d;
-	}
+	if (IS_ERR(d))
+		goto unlock;
+	if (error)
+		goto fail;
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
+
+fail:
+	dput(d);
+	d = ERR_PTR(error);
+unlock:
+	inode_unlock(parent_path.dentry->d_inode);
+	if (!error)
+		mnt_drop_write(parent_path.mnt);
+	return d;
 }
 
 /**
@@ -2816,24 +2828,26 @@ struct dentry *kern_path_parent(const char *name, struct path *path)
 	return d;
 }
 
-struct dentry *kern_path_locked(const char *name, struct path *path)
+struct dentry *start_removing_path(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
-	struct dentry *res = __kern_path_locked(AT_FDCWD, filename, path);
+	struct dentry *res = __start_removing_path(AT_FDCWD, filename, path);
 
 	putname(filename);
 	return res;
 }
 
-struct dentry *user_path_locked_at(int dfd, const char __user *name, struct path *path)
+struct dentry *start_removing_user_path_at(int dfd,
+					   const char __user *name,
+					   struct path *path)
 {
 	struct filename *filename = getname(name);
-	struct dentry *res = __kern_path_locked(dfd, filename, path);
+	struct dentry *res = __start_removing_path(dfd, filename, path);
 
 	putname(filename);
 	return res;
 }
-EXPORT_SYMBOL(user_path_locked_at);
+EXPORT_SYMBOL(start_removing_user_path_at);
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
@@ -4223,8 +4237,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	return dentry;
 }
 
-struct dentry *kern_path_create(int dfd, const char *pathname,
-				struct path *path, unsigned int lookup_flags)
+struct dentry *start_creating_path(int dfd, const char *pathname,
+				   struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname_kernel(pathname);
 	struct dentry *res = filename_create(dfd, filename, path, lookup_flags);
@@ -4232,9 +4246,9 @@ struct dentry *kern_path_create(int dfd, const char *pathname,
 	putname(filename);
 	return res;
 }
-EXPORT_SYMBOL(kern_path_create);
+EXPORT_SYMBOL(start_creating_path);
 
-void done_path_create(struct path *path, struct dentry *dentry)
+void end_creating_path(struct path *path, struct dentry *dentry)
 {
 	if (!IS_ERR(dentry))
 		dput(dentry);
@@ -4242,10 +4256,11 @@ void done_path_create(struct path *path, struct dentry *dentry)
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
-EXPORT_SYMBOL(done_path_create);
+EXPORT_SYMBOL(end_creating_path);
 
-inline struct dentry *user_path_create(int dfd, const char __user *pathname,
-				struct path *path, unsigned int lookup_flags)
+inline struct dentry *start_creating_user_path(
+	int dfd, const char __user *pathname,
+	struct path *path, unsigned int lookup_flags)
 {
 	struct filename *filename = getname(pathname);
 	struct dentry *res = filename_create(dfd, filename, path, lookup_flags);
@@ -4253,7 +4268,7 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 	putname(filename);
 	return res;
 }
-EXPORT_SYMBOL(user_path_create);
+EXPORT_SYMBOL(start_creating_user_path);
 
 /**
  * vfs_mknod - create device node or file
@@ -4361,7 +4376,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			break;
 	}
 out2:
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4465,7 +4480,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4819,7 +4834,7 @@ int do_symlinkat(struct filename *from, int newdfd, struct filename *to)
 	if (!error)
 		error = vfs_symlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				    dentry, from->name);
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -4988,7 +5003,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	error = vfs_link(old_path.dentry, idmap, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
 out_dput:
-	done_path_create(&new_path, new_dentry);
+	end_creating_path(&new_path, new_dentry);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error) {
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 8f732742b26e..267b50e8e42e 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4418,7 +4418,7 @@ int ocfs2_reflink_ioctl(struct inode *inode,
 		return error;
 	}
 
-	new_dentry = user_path_create(AT_FDCWD, newname, &new_path, 0);
+	new_dentry = start_creating_user_path(AT_FDCWD, newname, &new_path, 0);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry)) {
 		mlog_errno(error);
@@ -4435,7 +4435,7 @@ int ocfs2_reflink_ioctl(struct inode *inode,
 				  d_inode(new_path.dentry),
 				  new_dentry, preserve);
 out_dput:
-	done_path_create(&new_path, new_dentry);
+	end_creating_path(&new_path, new_dentry);
 out:
 	path_put(&old_path);
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 07739055ac9f..1cfa688904b2 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -196,7 +196,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
 
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return err;
 }
 
@@ -237,7 +237,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 	if (!err && dentry != d)
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(dentry));
 
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
 	return err;
@@ -669,7 +669,7 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
 
 out3:
-	done_path_create(&newpath, dentry);
+	end_creating_path(&newpath, dentry);
 out2:
 	path_put(&oldpath);
 out1:
@@ -1325,7 +1325,7 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 	if (!abs_name)
 		return ERR_PTR(-ENOMEM);
 
-	dent = kern_path_create(AT_FDCWD, abs_name, path, flags);
+	dent = start_creating_path(AT_FDCWD, abs_name, path, flags);
 	kfree(abs_name);
 	return dent;
 }
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1d5038c21c20..a7800ef04e76 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -59,11 +59,15 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 extern int kern_path(const char *, unsigned, struct path *);
 struct dentry *kern_path_parent(const char *name, struct path *parent);
 
-extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
-extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
-extern void done_path_create(struct path *, struct dentry *);
-extern struct dentry *kern_path_locked(const char *, struct path *);
-extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
+extern struct dentry *start_creating_path(int, const char *, struct path *, unsigned int);
+extern struct dentry *start_creating_user_path(int, const char __user *, struct path *, unsigned int);
+extern void end_creating_path(struct path *, struct dentry *);
+extern struct dentry *start_removing_path(const char *, struct path *);
+extern struct dentry *start_removing_user_path_at(int , const char __user *, struct path *);
+static inline void end_removing_path(struct path *path , struct dentry *dentry)
+{
+	end_creating_path(path, dentry);
+}
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
 			   const struct path *root);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5c2e96b19392..fadf3817a9c5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -442,7 +442,7 @@ static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void *raw,
 	umode_t mode;
 	int ret;
 
-	dentry = user_path_create(path_fd, pathname, &path, 0);
+	dentry = start_creating_user_path(path_fd, pathname, &path, 0);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
@@ -471,7 +471,7 @@ static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void *raw,
 		ret = -EPERM;
 	}
 out:
-	done_path_create(&path, dentry);
+	end_creating_path(&path, dentry);
 	return ret;
 }
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6d7c110814ff..768098dec231 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1387,7 +1387,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	 * Get the parent directory, calculate the hash for last
 	 * component.
 	 */
-	dentry = kern_path_create(AT_FDCWD, addr->name->sun_path, &parent, 0);
+	dentry = start_creating_path(AT_FDCWD, addr->name->sun_path, &parent, 0);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out;
@@ -1417,7 +1417,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	unix_table_double_unlock(net, old_hash, new_hash);
 	unix_insert_bsd_socket(sk);
 	mutex_unlock(&u->bindlock);
-	done_path_create(&parent, dentry);
+	end_creating_path(&parent, dentry);
 	return 0;
 
 out_unlock:
@@ -1427,7 +1427,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	/* failed after successful mknod?  unlink what we'd created... */
 	vfs_unlink(idmap, d_inode(parent.dentry), dentry, NULL);
 out_path:
-	done_path_create(&parent, dentry);
+	end_creating_path(&parent, dentry);
 out:
 	unix_release_addr(addr);
 	return err == -EEXIST ? -EADDRINUSE : err;
-- 
2.50.0.107.gf914562f5916.dirty


