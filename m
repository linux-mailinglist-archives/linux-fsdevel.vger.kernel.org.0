Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB34294FCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502369AbgJUPUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502327AbgJUPT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:19:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75410C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 08:19:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bf6so1381934plb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wuVAFVOgE1d1zeS41UoYVc059mY7lGXpdpjUSvvGYw=;
        b=t61eBRmXfED3eztHbH4eox+5ViFvb0r2chHm6JByakqLnMN4+b1b1vhi6SA53C80sP
         Pk2LAq/aecFbgfWzN8I0s0RrHeyAl4vwpHhieRf8Y7P1YywmjNf/Iy5cTM1MC7hi6HEV
         ycb8JDp5Bbh9Fd2d68EWoEEabFKG2/8065YuwnLE8QDymgVbcFH1nvUCcWC/mh2GoiPG
         u4WDdYEjqz1N4YSN6pa1T/oFvKDNYmR/sSVXA0ZPilgm6Elwcv3G3yIgp5wrMngIAXvS
         pR0xVpE26h64CFE5NQFKN+4CUviHX0wGGcwuLL7HbwC1babdNbfa+f1vvZlQOPE2QIOB
         /mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wuVAFVOgE1d1zeS41UoYVc059mY7lGXpdpjUSvvGYw=;
        b=S4Tfh1fM4aeoGS3zrTLDRtio0DbngzLv02W0nZtg1LIKYyH8QUU6jeIahJBOjvsJim
         aIad9UpQbSM2NlbhK8x7rkBjIYzlNFHz1mElVRcC9PcGPeU9pi7K3E9jJMrwOCJfVX0S
         bsAM3FDGZNrYHYtRGNV9U0zQvYaK/og+WPhSHO1WUYyw/ldptyyB+Ua4teNb9TfQtn2w
         o6iwh5YX0/6r4IC2nI/E02XJdwstdygnuLXgg+hf/BEvIutHCwn8TaKM0cA6fozYziPQ
         MmA8pGjE22S9N2EbHyIngKhN3w7xl6z4UdfvObXmK+GFd5QyhDVS/dcTpta683NzNTL6
         B4uw==
X-Gm-Message-State: AOAM531/JZDoe4Y+nOpVaI3NliRulcqvNIfm6cVHmCp94hx1UghQo9Xs
        +zRFLCuRCpHp9HGZgNzblKDqKQ==
X-Google-Smtp-Source: ABdhPJy/L7uWJS8IKS4yYX+xHG4FdDidXU1scv2yjqz9yxzxN6ek5SyfGiF6ATY5XZTuNdSjgzk0ug==
X-Received: by 2002:a17:90a:c683:: with SMTP id n3mr3823923pjt.163.1603293596997;
        Wed, 21 Oct 2020 08:19:56 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id s10sm2409646pji.7.2020.10.21.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:19:56 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Mark Salyzyn <salyzyn@android.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [RESEND PATCH v18 3/4] overlayfs: override_creds=off option bypass creator_cred
Date:   Wed, 21 Oct 2020 08:19:02 -0700
Message-Id: <20201021151903.652827-4-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021151903.652827-1-salyzyn@android.com>
References: <20201021151903.652827-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/overlayfs/file.c                     | 24 +++++++++++------------
 fs/overlayfs/inode.c                    | 18 ++++++++---------
 fs/overlayfs/namei.c                    |  6 +++---
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  8 ++++----
 fs/overlayfs/super.c                    | 22 ++++++++++++++++++++-
 fs/overlayfs/util.c                     | 13 +++++++++++--
 11 files changed, 98 insertions(+), 40 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 580ab9a0fe31..dac065f73e37 100644
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
index 955ecd4030f0..b9d97e7efd5c 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -962,7 +962,7 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 28a075b5f5b2..3c6f5f6648b8 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -565,7 +565,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *old_cred;
+	const struct cred *old_cred, *hold_cred = NULL;
 	struct cred *override_cred;
 	struct dentry *parent = dentry->d_parent;
 
@@ -592,14 +592,15 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
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
@@ -608,7 +609,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred ?: hold_cred);
+	if (old_cred && hold_cred)
+		put_cred(hold_cred);
 	return err;
 }
 
@@ -684,7 +687,7 @@ static int ovl_set_link_redirect(struct dentry *dentry)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_set_redirect(dentry, false);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -903,7 +906,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1273,7 +1276,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old->d_sb, old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 out_drop_write:
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..b1357bb067d9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -59,7 +59,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,
@@ -209,7 +209,7 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	ret = vfs_llseek(real.file, offset, whence);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	file->f_pos = real.file->f_pos;
 	ovl_inode_unlock(inode);
@@ -323,7 +323,7 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			ovl_aio_cleanup_handler(aio_req);
 	}
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	ovl_file_accessed(file);
 
 	fdput(real);
@@ -388,7 +388,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 			ovl_aio_cleanup_handler(aio_req);
 	}
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	fdput(real);
 
 out_unlock:
@@ -411,7 +411,7 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 
 	old_cred = ovl_override_creds(file_inode(in)->i_sb);
 	ret = generic_file_splice_read(real.file, ppos, pipe, len, flags);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(in)->i_sb, old_cred);
 
 	ovl_file_accessed(in);
 	fdput(real);
@@ -432,7 +432,7 @@ ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 	old_cred = ovl_override_creds(file_inode(out)->i_sb);
 	ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(out)->i_sb, old_cred);
 
 	ovl_file_accessed(out);
 	fdput(real);
@@ -456,7 +456,7 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
 		ret = vfs_fsync_range(real.file, start, end, datasync);
-		revert_creds(old_cred);
+		ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 	}
 
 	fdput(real);
@@ -480,7 +480,7 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	if (ret) {
 		/* Drop reference count from new vm_file value */
@@ -508,7 +508,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(real.file, mode, offset, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode), inode);
@@ -530,7 +530,7 @@ static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fadvise(real.file, offset, len, advice);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	fdput(real);
 
@@ -552,7 +552,7 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 	ret = security_file_ioctl(real.file, cmd, arg);
 	if (!ret)
 		ret = vfs_ioctl(real.file, cmd, arg);
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	fdput(real);
 
@@ -741,7 +741,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 						flags);
 		break;
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file_out)->i_sb, old_cred);
 
 	/* Update size */
 	ovl_copyattr(ovl_inode_real(inode_out), inode_out);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 2b14291beb86..fb0ec01774e6 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -80,7 +80,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = notify_change(upperdentry, attr, NULL);
-		revert_creds(old_cred);
+		ovl_revert_creds(dentry->d_sb, old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -272,7 +272,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return err;
 }
@@ -306,7 +306,7 @@ int ovl_permission(struct inode *inode, int mask)
 		mask |= MAY_READ;
 	}
 	err = inode_permission(realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
@@ -323,7 +323,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return p;
 }
 
@@ -366,7 +366,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		WARN_ON(flags != XATTR_REPLACE);
 		err = vfs_removexattr(realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	/* copy c/mtime */
 	ovl_copyattr(d_inode(realdentry), inode);
@@ -388,7 +388,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = __vfs_getxattr(realdentry, d_inode(realdentry), name,
 			     value, size, flags);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return res;
 }
 
@@ -416,7 +416,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -451,7 +451,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return acl;
 }
@@ -485,7 +485,7 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	revert_creds(old_cred);
+	ovl_revert_creds(inode->i_sb, old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a6162c4076db..0e6290844c57 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1097,7 +1097,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	ovl_dentry_update_reval(dentry, upperdentry,
 			DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
 
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1124,7 +1124,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1176,7 +1176,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 06db4cf87f55..da4a25ac9b01 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -253,6 +253,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(struct super_block *sb, const struct cred *oldcred);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
 bool ovl_index_all(struct super_block *sb);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..597f00982ade 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -18,6 +18,7 @@ struct ovl_config {
 	int xino;
 	bool metacopy;
 	bool ovl_volatile;
+	bool override_creds;
 };
 
 struct ovl_sb {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 01620ebae1bd..38d5b855c4a4 100644
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
@@ -796,7 +796,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	}
 	err = 0;
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	return err;
 }
 
@@ -848,7 +848,7 @@ static struct file *ovl_dir_open_realfile(const struct file *file,
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	revert_creds(old_cred);
+	ovl_revert_creds(file_inode(file)->i_sb, old_cred);
 
 	return res;
 }
@@ -986,7 +986,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d447958badc2..28c5d291f836 100644
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
@@ -366,6 +371,9 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 			   ofs->config.metacopy ? "on" : "off");
 	if (ofs->config.ovl_volatile)
 		seq_puts(m, ",volatile");
+	if (ofs->config.override_creds != ovl_override_creds_def)
+		seq_show_option(m, "override_creds",
+				ofs->config.override_creds ? "on" : "off");
 	return 0;
 }
 
@@ -418,6 +426,8 @@ enum {
 	OPT_METACOPY_ON,
 	OPT_METACOPY_OFF,
 	OPT_VOLATILE,
+	OPT_OVERRIDE_CREDS_ON,
+	OPT_OVERRIDE_CREDS_OFF,
 	OPT_ERR,
 };
 
@@ -437,6 +447,8 @@ static const match_table_t ovl_tokens = {
 	{OPT_METACOPY_ON,		"metacopy=on"},
 	{OPT_METACOPY_OFF,		"metacopy=off"},
 	{OPT_VOLATILE,			"volatile"},
+	{OPT_OVERRIDE_CREDS_ON,		"override_creds=on"},
+	{OPT_OVERRIDE_CREDS_OFF,	"override_creds=off"},
 	{OPT_ERR,			NULL}
 };
 
@@ -496,6 +508,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
 		return -ENOMEM;
+	config->override_creds = ovl_override_creds_def;
 
 	while ((p = ovl_next_opt(&opt)) != NULL) {
 		int token;
@@ -585,6 +598,14 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->ovl_volatile = true;
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
@@ -2007,7 +2028,6 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	kfree(splitlower);
 
 	sb->s_root = root_dentry;
-
 	return 0;
 
 out_free_oe:
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..8d1e7f0db7bc 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -37,9 +37,18 @@ const struct cred *ovl_override_creds(struct super_block *sb)
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
@@ -823,7 +832,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(dentry->d_sb, old_cred);
 
 out:
 	if (err)
@@ -841,7 +850,7 @@ void ovl_nlink_end(struct dentry *dentry)
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		ovl_revert_creds(dentry->d_sb, old_cred);
 	}
 
 	ovl_inode_unlock(inode);
-- 
2.29.0.rc1.297.gfa9743e501-goog

