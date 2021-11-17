Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5258A453E09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 02:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhKQCBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 21:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhKQCBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:01:31 -0500
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF5C061767
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 17:58:33 -0800 (PST)
Received: by mail-vk1-xa49.google.com with SMTP id y15-20020a1f7d0f000000b002f244d4c479so569894vkc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Nov 2021 17:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=QIjKXLTRjvfWUxFUWwuhm7GQFs9wHbpNZr/P8Fm90e4=;
        b=lF1VG1awJjmK9HHEojHUaUnv8Hu0VRNS68XMx+KkMY0JmJGBOw+HqFimP9wdbKAZmd
         zogMLNYpt4WmM/FCRSVIhrHDlHkW9IRh1tB3RrEsDqBvwMyXGytSn8ZkWApNkfV3Yim4
         rciF2VPTcd5z+lgeWXpG9u8ZIPurEelK1/9WkARovQNIlvqJi/p1uSpFa382SMc9wLzE
         Pcwu28QzRHyQjNGRt0HW2T1PmtckNao7p450Xs5Je4erW/6TS8sLciZCp/PnvP9unAh6
         v+ySxDg4AqygQCHw5i/JOKHVV6REpoukn7pXG0JWRZ9neFn3BqfbdWqD7MeIR+r9CUFA
         0lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=QIjKXLTRjvfWUxFUWwuhm7GQFs9wHbpNZr/P8Fm90e4=;
        b=MYKk1GtpNLQ4/7xTEJfIN0Xdrr3AQJZDm7KZCd5AaAilExSiN1PC9wPsevh6LaCSCH
         /hBkv13KVWSVsW5LleyGHClNibc/5MiQPNAf5o1MRbKtYPATFiJb+kmWEtI6GOPLJTb9
         olWa5iuT4HRq1ykKclwGH2DLlbTYRcJTmYaGddR9IUlPC7HL8wCrlGd8XUJqjoCziUby
         m0aQTCRy1cSokDJCbemQZkWmPoy6SNcU7GnPETA8kup1nLRx5wKmfJxr86pmWaY73HdT
         t9bdW5bkVG1k2rTVO1XRkQ4PJAkmCfpNwH7bosWxJ2l/q805LFHIvsN+wF7x7fnCOBI+
         EW/g==
X-Gm-Message-State: AOAM532BL9Qw47fLOjFIvHao+9JfyFgYhG2xzoHf2Mu3bZAW7Qh8haKK
        WVuj8YrhT2bAMajS1Dcwol2c3Hq2dO+d
X-Google-Smtp-Source: ABdhPJyi7pTakD9nPX3PByWnb98KtPu3ExwhWdw3fC4z7533pQ8vjSVfTAgIcCgh9hIKlp1RbVWJPNTYeVpE
X-Received: from dvandertop.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:a05:6122:894:: with SMTP id
 20mr26286532vkf.23.1637114312772; Tue, 16 Nov 2021 17:58:32 -0800 (PST)
Date:   Wed, 17 Nov 2021 01:58:05 +0000
In-Reply-To: <20211117015806.2192263-1-dvander@google.com>
Message-Id: <20211117015806.2192263-4-dvander@google.com>
Mime-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v19 3/4] overlayfs: override_creds=off option bypass creator_cred
From:   David Anderson <dvander@google.com>
Cc:     David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        selinux@vger.kernel.org, paulmoore@microsoft.com,
        Luca.Boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied, the mounter's
credentials might not overlap the credentials of the caller's when
accessing the overlayfs filesystem.  For example, a file that a lower
DAC privileged caller can execute, is MAC denied to the generally
higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/override_creds.

It was not always this way.  Circa 4.6 there was no recorded mounter's
credentials, instead privileged access to upper or work directories
were temporarily increased to perform the operations.  The MAC
(selinux) policies were caller's in all cases.  override_creds=off
partially returns us to this older access model minus the insecure
temporary credential increases.  This is to permit use in a system
with non-overlapping security models for each executable including
the agent that mounts the overlayfs filesystem.  In Android
this is the case since init, which performs the mount operations,
has a minimal MAC set of privileges to reduce any attack surface,
and services that use the content have a different set of MAC
privileges (eg: read, for vendor labelled configuration, execute for
vendor libraries and modules).  The caveats are not a problem in
the Android usage model, however they should be fixed for
completeness and for general use in time.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: David Anderson <dvander@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com
Cc: selinux@vger.kernel.org
Cc: paulmoore@microsoft.com
Cc: Luca.Boccassi@microsoft.com

v19
- rebase

v18
- rebase

v17
- move credential section for override_creds=off as a level 3 heading
  subsection of the permissions section.

v16
- Rebase, cover a few more new ovl_revert_creds callpoints.

v15
- Rebase

v14:
- fix an issue in ovl_create_or_link which leaks credentials.

v12 + v13
- Rebase

v11:
- add sb argument to ovl_revert_creds to match future work in progress
  in other commiter's hands.

v10:
- Rebase (and expand because of increased revert_cred usage)

v9:
- Add to the caveats

v8:
- drop pr_warn message after straw poll to remove it.
- added a use case in the commit message

v7:
- change name of internal parameter to ovl_override_creds_def
- report override_creds only if different than default

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation.
- pr_warn message adjusted to report consequences.

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v4:
- spelling and grammar errors in text

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.
---
 Documentation/filesystems/overlayfs.rst | 26 ++++++++++++++++++++++++-
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/dir.c                      | 17 +++++++++-------
 fs/overlayfs/file.c                     | 22 ++++++++++-----------
 fs/overlayfs/inode.c                    | 24 +++++++++++------------
 fs/overlayfs/namei.c                    |  6 +++---
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  8 ++++----
 fs/overlayfs/super.c                    | 22 ++++++++++++++++++++-
 fs/overlayfs/util.c                     | 13 +++++++++++--
 11 files changed, 100 insertions(+), 42 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 7da6c30ed596..d7cd4032134a 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -195,7 +195,7 @@ handle it in two different ways:
 
 1. return EXDEV error: this error is returned by rename(2) when trying to
    move a file or directory across filesystem boundaries.  Hence
-   applications are usually prepared to hande this error (mv(1) for example
+   applications are usually prepared to handle this error (mv(1) for example
    recursively copies the directory tree).  This is the default behavior.
 
 2. If the "redirect_dir" feature is enabled, then the directory will be
@@ -324,6 +324,30 @@ and
 The resulting access permissions should be the same.  The difference is in
 the time of copy (on-demand vs. up-front).
 
+### Non overlapping credentials
+
+As noted above, all access to the upper, lower and work directories is the
+recorded mounter's MAC and DAC credentials.  The incoming accesses are
+checked against the caller's credentials.
+
+In the case where caller MAC or DAC credentials do not overlap the mounter, a
+use case available in older versions of the driver, the override_creds mount
+flag can be turned off.  For when the use pattern has caller with legitimate
+credentials where the mounter does not.  For example init may have been the
+mounter, but the caller would have execute or read MAC permissions where
+init would not.  override_creds off means all access, incoming, upper, lower
+or working, will be tested against the caller.
+
+Several unintended side effects will occur though.  The caller without certain
+key capabilities or lower privilege will not always be able to delete files or
+directories, create nodes, or search some restricted directories.  The ability
+to search and read a directory entry is spotty as a result of the cache
+mechanism not re-testing the credentials because of the assumption, a
+privileged caller can fill cache, then a lower privilege can read the directory
+cache.  The uneven security model where cache, upperdir and workdir are opened
+at privilege, but accessed without creating a form of privilege escalation,
+should only be used with strict understanding of the side effects and of the
+security policies.
 
 Multiple lower layers
 ---------------------
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b193d08a3dc3..de7fdcb3eb6c 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1032,7 +1032,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f18490813170..7449825b6cbd 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -569,7 +569,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *old_cred;
+	const struct cred *old_cred, *hold_cred = NULL;
 	struct cred *override_cred;
 	struct dentry *parent = dentry->d_parent;
 
@@ -596,14 +596,15 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		override_cred->fsgid = inode->i_gid;
 		if (!attr->hardlink) {
 			err = security_dentry_create_files_as(dentry,
-					attr->mode, &dentry->d_name, old_cred,
+					attr->mode, &dentry->d_name,
+					old_cred ? old_cred : current_cred(),
 					override_cred);
 			if (err) {
 				put_cred(override_cred);
 				goto out_revert_creds;
 			}
 		}
-		put_cred(override_creds(override_cred));
+		hold_cred = override_creds(override_cred);
 		put_cred(override_cred);
 
 		if (!ovl_dentry_is_whiteout(dentry))
@@ -612,7 +613,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred ?: hold_cred);
+	if (old_cred && hold_cred)
+		put_cred(hold_cred);
 	return err;
 }
 
@@ -689,7 +692,7 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -908,7 +911,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1283,7 +1286,7 @@ static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old->d_sb, old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 out_drop_write:
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index fa125feed0ff..11d8277c94cd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -61,7 +61,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -205,7 +205,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
@@ -334,7 +334,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			ovl_aio_cleanup_handler(aio_req);
 	}
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	ovl_file_accessed(file);
 out_fdput:
 	fdput(real);
@@ -407,7 +407,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 			ovl_aio_cleanup_handler(aio_req);
 	}
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 out_fdput:
 	fdput(real);
 
@@ -453,7 +453,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	file_end_write(real.file);
 	/* Update size */
 	ovl_copyattr(realinode, inode);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 	fdput(real);
 
 out_unlock:
@@ -480,7 +480,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
+		ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	}
 
 	fdput(real);
@@ -504,7 +504,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	ovl_file_accessed(file);
 
 	return ret;
@@ -523,7 +523,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode), inode);
@@ -545,7 +545,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	fdput(real);
 
@@ -595,7 +595,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file_out)->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode_out), inode_out);
@@ -654,7 +654,7 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 	if (real.file->f_op->flush) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		err = real.file->f_op->flush(real.file, id);
-		revert_creds(old_cred);
+		ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	}
 	fdput(real);
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 49bfa33bb682..0123270e295f 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -78,7 +78,7 @@ int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = notify_change(&init_user_ns, upperdentry, attr, NULL);
-		revert_creds(old_cred);
+		ovl_revert_creds(dentry->d_sb, old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -270,7 +270,7 @@ int ovl_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -305,7 +305,7 @@ int ovl_permission(struct user_namespace *mnt_userns,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(&init_user_ns, realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
@@ -322,7 +322,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return p;
 }
 
@@ -353,7 +353,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 	if (!value && !upperdentry) {
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = vfs_getxattr(&init_user_ns, realdentry, name, NULL, 0);
-		revert_creds(old_cred);
+		ovl_revert_creds(dentry->d_sb, old_cred);
 		if (err < 0)
 			goto out_drop_write;
 	}
@@ -374,7 +374,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		WARN_ON(flags != XATTR_REPLACE);
 		err = vfs_removexattr(&init_user_ns, realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	/* copy c/mtime */
 	ovl_copyattr(d_inode(realdentry), inode);
@@ -396,7 +396,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = __vfs_getxattr(&init_user_ns, realdentry, d_inode(realdentry),
 			     name, value, size, flags);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return res;
 }
 
@@ -424,7 +424,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -462,7 +462,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return acl;
 }
@@ -496,7 +496,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
@@ -567,7 +567,7 @@ int ovl_fileattr_set(struct user_namespace *mnt_userns,
 		err = ovl_set_protattr(inode, upperpath.dentry, fa);
 		if (!err)
 			err = ovl_real_fileattr_set(&upperpath, fa);
-		revert_creds(old_cred);
+		ovl_revert_creds(inode->i_sb, old_cred);
 
 		/*
 		 * Merge real inode flags with inode flags read from
@@ -629,7 +629,7 @@ int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 1a9b515fc45d..0ecb6bab0f2a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1106,7 +1106,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	ovl_dentry_update_reval(dentry, upperdentry,
 			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
 
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1133,7 +1133,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1185,7 +1185,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 3fcd62e72aad..16c6280d8201 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -282,6 +282,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(struct super_block *sb, const struct cred *oldcred);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
 bool ovl_index_all(struct super_block *sb);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 63efee554f69..31aebf6d2ea4 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -20,6 +20,7 @@ struct ovl_config {
 	bool metacopy;
 	bool userxattr;
 	bool ovl_volatile;
+	bool override_creds;
 };
 
 struct ovl_sb {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 150fdf3bc68d..c6038e6ad753 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -286,7 +286,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(rdd->dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -789,7 +789,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return err;
 }
 
@@ -841,7 +841,7 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	return res;
 }
@@ -967,7 +967,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 973644af1288..d1c6e883790d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -53,6 +53,11 @@ module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
 MODULE_PARM_DESC(xino_auto,
 		 "Auto enable xino feature");
 
+static bool __read_mostly ovl_override_creds_def = true;
+module_param_named(override_creds, ovl_override_creds_def, bool, 0644);
+MODULE_PARM_DESC(ovl_override_creds_def,
+		 "Use mounter's credentials for accesses");
+
 static void ovl_entry_stack_free(struct ovl_entry *oe)
 {
 	unsigned int i;
@@ -382,6 +387,9 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 		seq_puts(m, ",volatile");
 	if (ofs->config.userxattr)
 		seq_puts(m, ",userxattr");
+	if (ofs->config.override_creds != ovl_override_creds_def)
+		seq_show_option(m, "override_creds",
+				ofs->config.override_creds ? "on" : "off");
 	return 0;
 }
 
@@ -437,6 +445,8 @@ enum {
 	OPT_METACOPY_ON,
 	OPT_METACOPY_OFF,
 	OPT_VOLATILE,
+	OPT_OVERRIDE_CREDS_ON,
+	OPT_OVERRIDE_CREDS_OFF,
 	OPT_ERR,
 };
 
@@ -459,6 +469,8 @@ static const match_table_t ovl_tokens = {
 	{OPT_METACOPY_ON,		"metacopy=on"},
 	{OPT_METACOPY_OFF,		"metacopy=off"},
 	{OPT_VOLATILE,			"volatile"},
+	{OPT_OVERRIDE_CREDS_ON,		"override_creds=on"},
+	{OPT_OVERRIDE_CREDS_OFF,	"override_creds=off"},
 	{OPT_ERR,			NULL}
 };
 
@@ -518,6 +530,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
 		return -ENOMEM;
+	config->override_creds = ovl_override_creds_def;
 
 	while ((p = ovl_next_opt(&opt)) != NULL) {
 		int token;
@@ -619,6 +632,14 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->userxattr = true;
 			break;
 
+		case OPT_OVERRIDE_CREDS_ON:
+			config->override_creds = true;
+			break;
+
+		case OPT_OVERRIDE_CREDS_OFF:
+			config->override_creds = false;
+			break;
+
 		default:
 			pr_err("unrecognized mount option \"%s\" or missing value\n",
 					p);
@@ -2144,7 +2165,6 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	kfree(splitlower);
 
 	sb->s_root = root_dentry;
-
 	return 0;
 
 out_free_oe:
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f48284a2a896..32eceb495202 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -38,9 +38,18 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 
+	if (!ofs->config.override_creds)
+		return NULL;
 	return override_creds(ofs->creator_cred);
 }
 
+void ovl_revert_creds(struct super_block *sb, const struct cred *old_cred)
+{
+	if (old_cred)
+		revert_creds(old_cred);
+}
+
+
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.
@@ -899,7 +908,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 out:
 	if (err)
@@ -917,7 +926,7 @@ void ovl_nlink_end(struct dentry *dentry)
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		ovl_revert_creds(dentry->d_sb, old_cred);
 	}
 
 	ovl_inode_unlock(inode);
-- 
2.34.0.rc1.387.gb447b232ab-goog

