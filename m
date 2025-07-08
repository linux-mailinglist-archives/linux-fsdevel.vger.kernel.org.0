Return-Path: <linux-fsdevel+bounces-54315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A834BAFDB7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143601AA1480
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9F230997;
	Tue,  8 Jul 2025 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1xg1zE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B541990A7;
	Tue,  8 Jul 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015911; cv=none; b=nTeeWQkoly0GH0kameyIk5p8QcW8txgU9efthfxM/+pK68Y7SPgDFPrLra75Ps7kIgUGSh3YjVVv5eXNsUfCf7YqtirSHZLupqA1pdbyptysF2Vjkmewi+jXZaajXFDuKGrOVc+ydjB6ljK7kkuB819zX1slikotXxBEQa1HGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015911; c=relaxed/simple;
	bh=s/2TvBfFW7akbeV8wFDmbvAI8NV9fd/gt7t98kwlfYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgRTb9ya178+qlVRe1xiqPsWQoHhQ3fiU/kZey8fu0Hm8/Mie4JnWqFVkSdsWPDki5dPcitQsP7b2d7fEB7kUAX3ZTRr22HvOClc2lsRl4GwQ/Kg7FLQVpufOTELXt3ENsYZBLOlJrp72Ql2+YppsSMPe5xeMPjDh8djD8HyAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1xg1zE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A10BC4CEED;
	Tue,  8 Jul 2025 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752015910;
	bh=s/2TvBfFW7akbeV8wFDmbvAI8NV9fd/gt7t98kwlfYE=;
	h=From:To:Cc:Subject:Date:From;
	b=L1xg1zE5PTTAC9S8hebeXMGHtdx5zubuGIZ5LjKzyuMnP5TlOSPNhOiR9OPoBEXQd
	 Gxd7tqrs+Sul6J/8m6FugrjyGACKfUPG/dr2X6MSYawop9BXlguu30bfnukacbAiEJ
	 U8SIalMPZ3Lw5hK0ciJTyKZwbHD+ovMR+IWF4EDF9tfleuAHrfrqbMd/ExpviGgAtQ
	 EtlRETivdDI0ihWx9PP/ymlqsUNvYmiPt67vgbzL29VcJzqrDFgf2Axeo0LZRCX7yn
	 P5j9uQPufRIqpgNWtwXVGVh+eS9R9rEuLTMZUVthHwJUeGmon1IDzoobzA0tLpthtT
	 j9ZLn3ZL9Vsyw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org,
	tomoyo-users_en@lists.sourceforge.net,
	tomoyo-users_ja@lists.sourceforge.net
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	m@maowtm.org,
	john.johansen@canonical.com,
	john@apparmor.net,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	enlightened@chromium.org,
	Song Liu <song@kernel.org>
Subject: [RFC] vfs: security: Parse dev_name before calling security_sb_mount
Date: Tue,  8 Jul 2025 16:05:04 -0700
Message-ID: <20250708230504.3994335-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

security_sb_mount handles multiple types of mounts: new mount, bind
mount, etc. When parameter dev_name is a path, it need to be parsed
with kern_path.

Move the parsing of dev_name to path_mount, and pass the result to
security_sb_mount, so that:
1. The LSMs do not need to call kern_path again;
2. For BPF LSM, we can use struct path dev_path, which is much easier to
   use than a string.
3. We can now remove do_move_mount_old.

Also, move may_mount check to before security_sb_mount and potential
kern_path, so that requests without proper capability will be rejected
sooner.

Signed-off-by: Song Liu <song@kernel.org>

---
The primary motivation of this change is to monitor bind mount and move
mount in BPF LSM. There are a few options for this to work:
1. Introduce bpf_kern_path kfunc.
2. Add new hook(s), such as [1].
3. Something like this patch.

At this moment, I think this patch is the best solution.

New mount for filesystems with FS_REQUIRES_DEV also need kern_path for
dev_name. apparmor and tomoyo still call kern_path in such cases.
However, it is a bit tricky to move this kern_path call to path_mount,
so new mount path is not changed in this version.

[1] https://lore.kernel.org/linux-security-module/20250110021008.2704246-1-enlightened@chromium.org/
---
 fs/namespace.c                    | 142 ++++++++++++++++++------------
 include/linux/lsm_hook_defs.h     |   3 +-
 include/linux/security.h          |   7 +-
 security/apparmor/include/mount.h |   5 +-
 security/apparmor/lsm.c           |   8 +-
 security/apparmor/mount.c         |  31 +------
 security/landlock/fs.c            |   2 +-
 security/security.c               |   6 +-
 security/selinux/hooks.c          |   1 +
 security/tomoyo/common.h          |   3 +-
 security/tomoyo/mount.c           |  36 +++++---
 security/tomoyo/tomoyo.c          |   6 +-
 12 files changed, 136 insertions(+), 114 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e13d9ab4f564..89f7fcd23b6c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3056,37 +3056,28 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 /*
  * do loopback mount.
  */
-static int do_loopback(struct path *path, const char *old_name,
+static int do_loopback(struct path *path, struct path *old_path,
 				int recurse)
 {
-	struct path old_path;
 	struct mount *mnt = NULL, *parent;
 	struct mountpoint *mp;
-	int err;
-	if (!old_name || !*old_name)
-		return -EINVAL;
-	err = kern_path(old_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
-	if (err)
-		return err;
+	int err = -EINVAL;
 
-	err = -EINVAL;
-	if (mnt_ns_loop(old_path.dentry))
-		goto out;
+	if (mnt_ns_loop(old_path->dentry))
+		return -EINVAL;
 
 	mp = lock_mount(path);
-	if (IS_ERR(mp)) {
-		err = PTR_ERR(mp);
-		goto out;
-	}
+	if (IS_ERR(mp))
+		return PTR_ERR(mp);
 
 	parent = real_mount(path->mnt);
 	if (!check_mnt(parent))
-		goto out2;
+		goto out;
 
-	mnt = __do_loopback(&old_path, recurse);
+	mnt = __do_loopback(old_path, recurse);
 	if (IS_ERR(mnt)) {
 		err = PTR_ERR(mnt);
-		goto out2;
+		goto out;
 	}
 
 	err = graft_tree(mnt, parent, mp);
@@ -3095,10 +3086,8 @@ static int do_loopback(struct path *path, const char *old_name,
 		umount_tree(mnt, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
-out2:
-	unlock_mount(mp);
 out:
-	path_put(&old_path);
+	unlock_mount(mp);
 	return err;
 }
 
@@ -3741,23 +3730,6 @@ static int do_move_mount(struct path *old_path,
 	return err;
 }
 
-static int do_move_mount_old(struct path *path, const char *old_name)
-{
-	struct path old_path;
-	int err;
-
-	if (!old_name || !*old_name)
-		return -EINVAL;
-
-	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
-	if (err)
-		return err;
-
-	err = do_move_mount(&old_path, path, 0);
-	path_put(&old_path);
-	return err;
-}
-
 /*
  * add a mount into a namespace's mount tree
  */
@@ -4117,6 +4089,31 @@ static char *copy_mount_string(const void __user *data)
 	return data ? strndup_user(data, PATH_MAX) : NULL;
 }
 
+enum mount_operation {
+	MOUNT_OP_RECONFIGURE,
+	MOUNT_OP_REMOUNT,
+	MOUNT_OP_BIND,
+	MOUNT_OP_CHANGE_TYPE,
+	MOUNT_OP_MOVE,
+	MOUNT_OP_NEW,
+};
+
+static enum mount_operation get_mount_op(unsigned long flags)
+{
+	if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
+		return MOUNT_OP_RECONFIGURE;
+	if (flags & MS_REMOUNT)
+		return MOUNT_OP_REMOUNT;
+	if (flags & MS_BIND)
+		return MOUNT_OP_BIND;
+	if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
+		return MOUNT_OP_CHANGE_TYPE;
+	if (flags & MS_MOVE)
+		return MOUNT_OP_MOVE;
+
+	return MOUNT_OP_NEW;
+}
+
 /*
  * Flags is a 32-bit value that allows up to 31 non-fs dependent flags to
  * be given to the mount() call (ie: read-only, no-dev, no-suid etc).
@@ -4135,6 +4132,8 @@ int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
+	enum mount_operation op;
+	struct path dev_path = {};
 	int ret;
 
 	/* Discard magic */
@@ -4148,11 +4147,29 @@ int path_mount(const char *dev_name, struct path *path,
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
-	ret = security_sb_mount(dev_name, path, type_page, flags, data_page);
+	if (!may_mount()) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	op = get_mount_op(flags);
+
+	if (op == MOUNT_OP_BIND || op == MOUNT_OP_MOVE) {
+		unsigned int lookup_flags = LOOKUP_FOLLOW;
+
+		if (!dev_name || !*dev_name)
+			return -EINVAL;
+
+		if (op == MOUNT_OP_BIND)
+			lookup_flags |= LOOKUP_AUTOMOUNT;
+		ret = kern_path(dev_name, lookup_flags, &dev_path);
+		if (ret)
+			return ret;
+	}
+
+	ret = security_sb_mount(dev_name, &dev_path, path, type_page, flags, data_page);
 	if (ret)
-		return ret;
-	if (!may_mount())
-		return -EPERM;
+		goto out;
 	if (flags & SB_MANDLOCK)
 		warn_mandlock();
 
@@ -4195,19 +4212,34 @@ int path_mount(const char *dev_name, struct path *path,
 			    SB_LAZYTIME |
 			    SB_I_VERSION);
 
-	if ((flags & (MS_REMOUNT | MS_BIND)) == (MS_REMOUNT | MS_BIND))
-		return do_reconfigure_mnt(path, mnt_flags);
-	if (flags & MS_REMOUNT)
-		return do_remount(path, flags, sb_flags, mnt_flags, data_page);
-	if (flags & MS_BIND)
-		return do_loopback(path, dev_name, flags & MS_REC);
-	if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
-		return do_change_type(path, flags);
-	if (flags & MS_MOVE)
-		return do_move_mount_old(path, dev_name);
-
-	return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
-			    data_page);
+	switch (op) {
+	case MOUNT_OP_RECONFIGURE:
+		ret = do_reconfigure_mnt(path, mnt_flags);
+		break;
+	case MOUNT_OP_REMOUNT:
+		ret = do_remount(path, flags, sb_flags, mnt_flags, data_page);
+		break;
+	case MOUNT_OP_BIND:
+		ret = do_loopback(path, &dev_path, flags & MS_REC);
+		break;
+	case MOUNT_OP_CHANGE_TYPE:
+		ret = do_change_type(path, flags);
+		break;
+	case MOUNT_OP_MOVE:
+		ret = do_move_mount(&dev_path, path, 0);
+		break;
+	case MOUNT_OP_NEW:
+		ret = do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
+				   data_page);
+		break;
+	default:
+		/* unknown op? */
+		WARN_ON_ONCE(1);
+		break;
+	}
+out:
+	path_put(&dev_path);
+	return ret;
 }
 
 int do_mount(const char *dev_name, const char __user *dir_name,
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..b5b9f6fc78e2 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -69,7 +69,8 @@ LSM_HOOK(int, 0, sb_remount, struct super_block *sb, void *mnt_opts)
 LSM_HOOK(int, 0, sb_kern_mount, const struct super_block *sb)
 LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
 LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
-LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
+LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *dev_path,
+	 const struct path *path,
 	 const char *type, unsigned long flags, void *data)
 LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
 LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
diff --git a/include/linux/security.h b/include/linux/security.h
index e8d9f6069f0c..af3f38c33ba0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -373,7 +373,8 @@ int security_sb_remount(struct super_block *sb, void *mnt_opts);
 int security_sb_kern_mount(const struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
-int security_sb_mount(const char *dev_name, const struct path *path,
+int security_sb_mount(const char *dev_name, const struct path *dev_path,
+		      const struct path *path,
 		      const char *type, unsigned long flags, void *data);
 int security_sb_umount(struct vfsmount *mnt, int flags);
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
@@ -803,7 +804,9 @@ static inline int security_sb_statfs(struct dentry *dentry)
 	return 0;
 }
 
-static inline int security_sb_mount(const char *dev_name, const struct path *path,
+static inline int security_sb_mount(const char *dev_name,
+				    const struct path *dev_path,
+				    const struct path *path,
 				    const char *type, unsigned long flags,
 				    void *data)
 {
diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
index 46834f828179..0beb626f1e8b 100644
--- a/security/apparmor/include/mount.h
+++ b/security/apparmor/include/mount.h
@@ -31,16 +31,13 @@ int aa_remount(const struct cred *subj_cred,
 
 int aa_bind_mount(const struct cred *subj_cred,
 		  struct aa_label *label, const struct path *path,
-		  const char *old_name, unsigned long flags);
+		  const struct path *old_path, unsigned long flags);
 
 
 int aa_mount_change_type(const struct cred *subj_cred,
 			 struct aa_label *label, const struct path *path,
 			 unsigned long flags);
 
-int aa_move_mount_old(const struct cred *subj_cred,
-		      struct aa_label *label, const struct path *path,
-		      const char *old_name);
 int aa_move_mount(const struct cred *subj_cred,
 		  struct aa_label *label, const struct path *from_path,
 		  const struct path *to_path);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 9b6c2f157f83..b9f2bd8e9d3a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -701,7 +701,8 @@ static int apparmor_uring_sqpoll(void)
 }
 #endif /* CONFIG_IO_URING */
 
-static int apparmor_sb_mount(const char *dev_name, const struct path *path,
+static int apparmor_sb_mount(const char *dev_name, const struct path *dev_path,
+			     const struct path *path,
 			     const char *type, unsigned long flags, void *data)
 {
 	struct aa_label *label;
@@ -720,14 +721,13 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 					   data);
 		else if (flags & MS_BIND)
 			error = aa_bind_mount(current_cred(), label, path,
-					      dev_name, flags);
+					      dev_path, flags);
 		else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE |
 				  MS_UNBINDABLE))
 			error = aa_mount_change_type(current_cred(), label,
 						     path, flags);
 		else if (flags & MS_MOVE)
-			error = aa_move_mount_old(current_cred(), label, path,
-						  dev_name);
+			error = aa_move_mount(current_cred(), label, dev_path, path);
 		else
 			error = aa_new_mount(current_cred(), label, dev_name,
 					     path, type, flags, data);
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index bf8863253e07..00c8acf9d8f9 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -421,25 +421,17 @@ int aa_remount(const struct cred *subj_cred,
 
 int aa_bind_mount(const struct cred *subj_cred,
 		  struct aa_label *label, const struct path *path,
-		  const char *dev_name, unsigned long flags)
+		  const struct path *old_path, unsigned long flags)
 {
 	struct aa_profile *profile;
 	char *buffer = NULL, *old_buffer = NULL;
-	struct path old_path;
 	int error;
 
 	AA_BUG(!label);
 	AA_BUG(!path);
 
-	if (!dev_name || !*dev_name)
-		return -EINVAL;
-
 	flags &= MS_REC | MS_BIND;
 
-	error = kern_path(dev_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
-	if (error)
-		return error;
-
 	buffer = aa_get_buffer(false);
 	old_buffer = aa_get_buffer(false);
 	error = -ENOMEM;
@@ -447,12 +439,11 @@ int aa_bind_mount(const struct cred *subj_cred,
 		goto out;
 
 	error = fn_for_each_confined(label, profile,
-			match_mnt(subj_cred, profile, path, buffer, &old_path,
+			match_mnt(subj_cred, profile, path, buffer, old_path,
 				  old_buffer, NULL, flags, NULL, false));
 out:
 	aa_put_buffer(buffer);
 	aa_put_buffer(old_buffer);
-	path_put(&old_path);
 
 	return error;
 }
@@ -516,24 +507,6 @@ int aa_move_mount(const struct cred *subj_cred,
 	return error;
 }
 
-int aa_move_mount_old(const struct cred *subj_cred, struct aa_label *label,
-		      const struct path *path, const char *orig_name)
-{
-	struct path old_path;
-	int error;
-
-	if (!orig_name || !*orig_name)
-		return -EINVAL;
-	error = kern_path(orig_name, LOOKUP_FOLLOW, &old_path);
-	if (error)
-		return error;
-
-	error = aa_move_mount(subj_cred, label, &old_path, path);
-	path_put(&old_path);
-
-	return error;
-}
-
 int aa_new_mount(const struct cred *subj_cred, struct aa_label *label,
 		 const char *dev_name, const struct path *path,
 		 const char *type, unsigned long flags, void *data)
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..508ec65f3297 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1418,7 +1418,7 @@ static void log_fs_change_topology_dentry(
  * inherit these new constraints.  Anyway, for backward compatibility reasons,
  * a dedicated user space option would be required (e.g. as a ruleset flag).
  */
-static int hook_sb_mount(const char *const dev_name,
+static int hook_sb_mount(const char *const dev_name, const struct path *dev_path,
 			 const struct path *const path, const char *const type,
 			 const unsigned long flags, void *const data)
 {
diff --git a/security/security.c b/security/security.c
index fc8405928cc7..e52a1195e91e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1550,6 +1550,7 @@ int security_sb_statfs(struct dentry *dentry)
 /**
  * security_sb_mount() - Check permission for mounting a filesystem
  * @dev_name: filesystem backing device
+ * @dev_path: path of filesystem backing device
  * @path: mount point
  * @type: filesystem type
  * @flags: mount flags
@@ -1564,10 +1565,11 @@ int security_sb_statfs(struct dentry *dentry)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_mount(const char *dev_name, const struct path *path,
+int security_sb_mount(const char *dev_name, const struct path *dev_path,
+		      const struct path *path,
 		      const char *type, unsigned long flags, void *data)
 {
-	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
+	return call_int_hook(sb_mount, dev_name, dev_path, path, type, flags, data);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..a2c240ffd1e1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2764,6 +2764,7 @@ static int selinux_sb_statfs(struct dentry *dentry)
 }
 
 static int selinux_mount(const char *dev_name,
+			 const struct path *dev_path,
 			 const struct path *path,
 			 const char *type,
 			 unsigned long flags,
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..9b7d190f573e 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -980,7 +980,8 @@ int tomoyo_init_request_info(struct tomoyo_request_info *r,
 			     const u8 index);
 int tomoyo_mkdev_perm(const u8 operation, const struct path *path,
 		      const unsigned int mode, unsigned int dev);
-int tomoyo_mount_permission(const char *dev_name, const struct path *path,
+int tomoyo_mount_permission(const char *dev_name, const struct path *dev_path,
+			    const struct path *path,
 			    const char *type, unsigned long flags,
 			    void *data_page);
 int tomoyo_open_control(const u8 type, struct file *file);
diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
index 2755971f50df..ee10cbfbf798 100644
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -76,11 +76,12 @@ static bool tomoyo_check_mount_acl(struct tomoyo_request_info *r,
  */
 static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 			    const char *dev_name,
+			    const struct path *dev_path,
 			    const struct path *dir, const char *type,
 			    unsigned long flags)
 {
 	struct tomoyo_obj_info obj = { };
-	struct path path;
+	struct path path = { };
 	struct file_system_type *fstype = NULL;
 	const char *requested_type = NULL;
 	const char *requested_dir_name = NULL;
@@ -132,17 +133,25 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 			need_dev = 1;
 	}
 	if (need_dev) {
-		/* Get mount point or device file. */
-		if (!dev_name || kern_path(dev_name, LOOKUP_FOLLOW, &path)) {
-			error = -ENOENT;
+		error = -ENOENT;
+		if (!dev_name)
 			goto out;
+
+		if (need_dev == -1) {
+			/* bind mount or move mount */
+			if (!dev_path->dentry)
+				goto out;
+
+			obj.path1 = *dev_path;
+		} else {
+			/* new mount */
+			if (kern_path(dev_name, LOOKUP_FOLLOW, &path))
+				goto out;
+			obj.path1 = path;
 		}
-		obj.path1 = path;
-		requested_dev_name = tomoyo_realpath_from_path(&path);
-		if (!requested_dev_name) {
-			error = -ENOENT;
+		requested_dev_name = tomoyo_realpath_from_path(&obj.path1);
+		if (!requested_dev_name)
 			goto out;
-		}
 	} else {
 		/* Map dev_name to "<NULL>" if no dev_name given. */
 		if (!dev_name)
@@ -172,8 +181,8 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 		put_filesystem(fstype);
 	kfree(requested_type);
 	/* Drop refcount obtained by kern_path(). */
-	if (obj.path1.dentry)
-		path_put(&obj.path1);
+	if (path.dentry)
+		path_put(&path);
 	return error;
 }
 
@@ -188,7 +197,8 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
  *
  * Returns 0 on success, negative value otherwise.
  */
-int tomoyo_mount_permission(const char *dev_name, const struct path *path,
+int tomoyo_mount_permission(const char *dev_name, const struct path *dev_path,
+			    const struct path *path,
 			    const char *type, unsigned long flags,
 			    void *data_page)
 {
@@ -234,7 +244,7 @@ int tomoyo_mount_permission(const char *dev_name, const struct path *path,
 	if (!type)
 		type = "<NULL>";
 	idx = tomoyo_read_lock();
-	error = tomoyo_mount_acl(&r, dev_name, path, type, flags);
+	error = tomoyo_mount_acl(&r, dev_name, dev_path, path, type, flags);
 	tomoyo_read_unlock(idx);
 	return error;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index d6ebcd9db80a..58e7a295f9b9 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -402,6 +402,7 @@ static int tomoyo_path_chroot(const struct path *path)
  * tomoyo_sb_mount - Target for security_sb_mount().
  *
  * @dev_name: Name of device file. Maybe NULL.
+ * @dev_path: Path to of device file. Maybe zero'ed.
  * @path:     Pointer to "struct path".
  * @type:     Name of filesystem type. Maybe NULL.
  * @flags:    Mount options.
@@ -409,10 +410,11 @@ static int tomoyo_path_chroot(const struct path *path)
  *
  * Returns 0 on success, negative value otherwise.
  */
-static int tomoyo_sb_mount(const char *dev_name, const struct path *path,
+static int tomoyo_sb_mount(const char *dev_name, const struct path *dev_path,
+			   const struct path *path,
 			   const char *type, unsigned long flags, void *data)
 {
-	return tomoyo_mount_permission(dev_name, path, type, flags, data);
+	return tomoyo_mount_permission(dev_name, dev_path, path, type, flags, data);
 }
 
 /**
-- 
2.47.1


