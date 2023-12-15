Return-Path: <linux-fsdevel+bounces-6197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B44814D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512301F2290A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3693DBA9;
	Fri, 15 Dec 2023 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJeQ4fGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22F3C497;
	Fri, 15 Dec 2023 16:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1E4C433C7;
	Fri, 15 Dec 2023 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702658184;
	bh=YMOXXnLxn6sbQn55Rdo7JBmG2686wYvsbtwz9L8Lb3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJeQ4fGBxL8DXy59I2jT4FOmLEe4K5vEvfUaNw9xSiRkF77sm50PKQXCqRJxI71aU
	 o/z5yXQGsAeJ1HboLFjOeHCdQVM0zrbWv04VPPLzyXEdNpO5Ml3cu+GsWeueEMotdh
	 bIe8VP0bWuUXh66DFmccDFG4GzmfqV7U5hs2XsHsRREO2v7bn5LgfbbYj3I8vvtJH9
	 1vxUt6Dj2AjzRNwhBKjarri0fhXuNp+72eqtHXUjmldDokdRr4bNn+mg2NZSD2N7wl
	 bEBTNBGvuSzTB5VGmORgwdVauNVf0+hrOHE/GMKwpJY131Zl5Mpks2lj4DkeDeUxiw
	 O0nPTRn8ciCQw==
Date: Fri, 15 Dec 2023 17:36:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-ID: <20231215-eiern-drucken-69cf4780d942@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>

On Fri, Dec 15, 2023 at 03:15:33PM +0100, Christian Brauner wrote:
> On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Weiß wrote:
> > On 15.12.23 13:31, Christian Brauner wrote:
> > > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Weiß wrote:
> > >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> > >> namespace in cooperation of an attached cgroup device program. We
> > >> just need to implement the security_inode_mknod() hook for this.
> > >> In the hook, we check if the current task is guarded by a device
> > >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> > >> helper. If so, we strip out SB_I_NODEV from the super block.
> > >>
> > >> Access decisions to those device nodes are then guarded by existing
> > >> device cgroups mechanism.
> > >>
> > >> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> > >> ---
> > > 
> > > I think you misunderstood me... My point was that I believe you don't
> > > need an additional LSM at all and no additional LSM hook. But I might be
> > > wrong. Only a POC would show.
> > 
> > Yeah sorry, I got your point now.
> 
> I think I might have had a misconception about how this works.
> A bpf LSM program can't easily alter a kernel object such as struct
> super_block I've been told.

Which is why you need that new hook in there. I get it now. In any case,
I think we can do this slightly nicer (for some definition of nice)...

So the thing below moves the capability check for mknod into the
security_inode_mknod() hook (This should be a separate patch.).

It moves raising SB_I_NODEV into security_sb_device_access() and the old
semantics are retained if no LSM claims device management. If an LSM
claims device management we raise the new flag and don't even raise
SB_I_NODEV. The capability check is namespace aware if device management
is claimed by an LSM. That's backward compatible. And we don't need any
sysctl.

What's missing is that all devcgroup_*() calls should be moved into a
new, unified security_device_access() hook that's called consistently in
all places where that matters such as blkdev_get_by_dev() and so on. Let
the bpf lsm implement that new hook.

Then write a sample BPF LSM as POC that this works. This would also
all other LSMs to do device management if they wanted to.

Thoughts?

From 7f4177e4f87e0b0182022f114c0287a0f0985752 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 15 Dec 2023 17:22:26 +0100
Subject: [PATCH] UNTESTED, UNCOMPILED, PROBABLY BUGGY

Signed-off-and-definitely-neither-compiled-nor-tested-by: Christian Brauner <brauner@kernel.org>
---
 fs/namei.c                    |  5 -----
 fs/namespace.c                | 11 +++++++----
 fs/super.c                    |  6 ++++--
 include/linux/fs.h            |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      | 15 ++++++++++++---
 security/commoncap.c          | 19 +++++++++++++++++++
 security/security.c           | 22 ++++++++++++++++++++++
 8 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..da481e6a696c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3959,16 +3959,11 @@ EXPORT_SYMBOL(user_path_create);
 int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	      struct dentry *dentry, umode_t mode, dev_t dev)
 {
-	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
 
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
-	    !capable(CAP_MKNOD))
-		return -EPERM;
-
 	if (!dir->i_op->mknod)
 		return -EPERM;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index fbf0e596fcd3..e87cc0320091 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4887,7 +4887,6 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
-	const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	unsigned long s_iflags;
 
@@ -4899,9 +4898,13 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 	if (!(s_iflags & SB_I_USERNS_VISIBLE))
 		return false;
 
-	if ((s_iflags & required_iflags) != required_iflags) {
-		WARN_ONCE(1, "Expected s_iflags to contain 0x%lx\n",
-			  required_iflags);
+	if (!(s_iflags & SB_I_NOEXEC)) {
+		WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC\n");
+		return true;
+	}
+
+	if (!(s_iflags & (SB_I_NODEV | SB_I_MANAGED_DEVICES))) {
+		WARN_ONCE(1, "Expected s_iflags to contain device access mask\n");
 		return true;
 	}
 
diff --git a/fs/super.c b/fs/super.c
index 076392396e72..7b8098db17c9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -362,8 +362,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	}
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
-	if (s->s_user_ns != &init_user_ns)
-		s->s_iflags |= SB_I_NODEV;
+
+	if (security_sb_device_access(s))
+		goto fail;
+
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..6ca0fe922478 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
+#define SB_I_MANAGED_DEVICES		0x00000080
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 3fdd00b452ac..8c8a0d8aa71d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -60,6 +60,7 @@ LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
+LSM_HOOK(int, 0, sb_device_access, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_delete, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_security, struct super_block *sb)
 LSM_HOOK(void, LSM_RET_VOID, sb_free_mnt_opts, void *mnt_opts)
diff --git a/include/linux/security.h b/include/linux/security.h
index 00809d2d5c38..a174f8c09594 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -155,6 +155,8 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
 int cap_inode_setxattr(struct dentry *dentry, const char *name,
 		       const void *value, size_t size, int flags);
+int cap_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
+		    dev_t dev);
 int cap_inode_removexattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, const char *name);
 int cap_inode_need_killpriv(struct dentry *dentry);
@@ -348,6 +350,7 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry);
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev);
+int security_sb_device_access(struct super_block *sb);
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags);
@@ -823,10 +826,16 @@ static inline int security_inode_rmdir(struct inode *dir,
 	return 0;
 }
 
-static inline int security_inode_mknod(struct inode *dir,
-					struct dentry *dentry,
-					int mode, dev_t dev)
+static inline int security_inode_mknod(struct inode *dir, struct dentry *dentry,
+				       int mode, dev_t dev)
+{
+	return cap_inode_mknod(dir, dentry, mode, dev);
+}
+
+static inline int security_sb_device_access(struct super_block *sb)
 {
+	if (s->s_user_ns != &init_user_ns)
+		sb->s_iflags |= SB_I_NODEV;
 	return 0;
 }
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 8e8c630ce204..f4a208fdf939 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1438,6 +1438,24 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 	return 0;
 }
 
+int cap_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
+		    dev_t dev)
+{
+	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
+	struct super_block *sb = dir->i_sb;
+	struct user_namespace *userns;
+
+	if (dir->i_sb->s_iflags & SB_I_MANAGED_DEVICES)
+		userns = sb->s_user_ns;
+	else
+		userns = &init_user_ns;
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !is_whiteout &&
+	    !ns_capable(userns, CAP_MKNOD))
+		return -EPERM;
+
+	return 0;
+}
+
 #ifdef CONFIG_SECURITY
 
 static struct security_hook_list capability_hooks[] __ro_after_init = {
@@ -1448,6 +1466,7 @@ static struct security_hook_list capability_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capget, cap_capget),
 	LSM_HOOK_INIT(capset, cap_capset),
 	LSM_HOOK_INIT(bprm_creds_from_file, cap_bprm_creds_from_file),
+	LSM_HOOK_INIT(inode_mknod, cap_inode_mknod),
 	LSM_HOOK_INIT(inode_need_killpriv, cap_inode_need_killpriv),
 	LSM_HOOK_INIT(inode_killpriv, cap_inode_killpriv),
 	LSM_HOOK_INIT(inode_getsecurity, cap_inode_getsecurity),
diff --git a/security/security.c b/security/security.c
index 088a79c35c26..192b992f1a34 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1221,6 +1221,28 @@ int security_sb_alloc(struct super_block *sb)
 	return rc;
 }
 
+int security_sb_device_access(struct super_block *sb)
+{
+	int rc;
+
+	rc = call_int_hook(sb_device_access, 0, sb);
+	switch (rc) {
+	case 0:
+		/*
+		 * LSM doesn't do device access management and this is an
+		 * untrusted mount so block all device access.
+		 */
+		if (sb->s_user_ns != &init_user_ns)
+			sb->s_iflags |= SB_I_NODEV;
+		return 0;
+	case 1:
+		sb->s_iflags |= SB_I_MANAGED_DEVICES;
+		return 0;
+	}
+
+	return rc;
+}
+
 /**
  * security_sb_delete() - Release super_block LSM associated objects
  * @sb: filesystem superblock
-- 
2.42.0


