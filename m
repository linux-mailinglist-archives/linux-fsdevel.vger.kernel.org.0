Return-Path: <linux-fsdevel+bounces-12678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC18626E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BB11F21C20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A94C600;
	Sat, 24 Feb 2024 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib0YXA1Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E41EB34
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802158; cv=none; b=HLMlV/N8Tnsa1erG9HZz+fnRa+pcVIrCfp2q7C5iIzII8CUmI2t/GbHv9eF9sDoNGHSXSulfXhQcDWvLTo/48z/SaKUp84+FpToF+5KcxQNzZFzkMujGKWnWS/qB22leFfgHLtIBDraq3XaFm2nT6gMMdXmGOTxx8EUyQu+esic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802158; c=relaxed/simple;
	bh=otwrZgDVrmAIu3moM3Mkkig6NPvZIBZShJEyTUQgfrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyAugW9wEE6Aah3Z/c4ht/aHJY1vnTZR1DAXO26C6IhpnoB1HPSw0zzSoO3BUCW4U4z4FE5AtYBNgQfrY1Hk8snEGXdpA2ujKbQ/s+jCgxcmZtQYhY5PY/2ZvZG53bqtl0aiJgPXDfY+h8/csoOkEjD6fnWnrgIqUYD6h7VGQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib0YXA1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74889C433F1;
	Sat, 24 Feb 2024 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802158;
	bh=otwrZgDVrmAIu3moM3Mkkig6NPvZIBZShJEyTUQgfrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ib0YXA1QUW3dfD5V1pV1WfHKtR3R6WUyq73ErzZFasd4oKUyWDyOSvuJV1/2mKnxu
	 6+h+F1a/uhMOdOO+nqgQ81ELUUa41YtR7rabes8LPnQ7JY9jzOMU7e8EOxhBYF4M6j
	 Tw6+9QvjPM3cZPnsdOsi851iOGk4FCMsbhhwYLY2A1LE5GDxl7dtdteIDHa0IxbqB3
	 VlpyXxzwKvAQ4f/QpE+e5tpKr80GCEG+65KLpHhqBfggjyhu9yJGyM02s6yqLVZXH4
	 WYy6+a5+fjF0SYzqBnoL+KY/PPj6BsNOnT+Wg/qCohnPVavLhefdYzO5BIEWgOBuek
	 miN/WchrknOgg==
Date: Sat, 24 Feb 2024 20:15:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
 <20240224-westseite-haftzeit-721640a8700b@brauner>
 <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gf7iiupdm46ioigx"
Content-Disposition: inline
In-Reply-To: <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>


--gf7iiupdm46ioigx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Feb 24, 2024 at 10:48:11AM -0800, Linus Torvalds wrote:
> On Fri, 23 Feb 2024 at 21:52, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This is selinux. So I think this is a misunderstanding. This isn't
> > something we can fix in the kernel.
> 
> Sure it is. SELinux just goes by what the kernel tells it anyway.
> 
> Presumably this is purely about the fact that the inode in question
> *used* to be that magical 'anon_inode_inode' that is shared when you
> don't want or need a separate inode allocation. I assume it doesn't
> even look at that, it just looks at the 'anon_inode_fs_type' thing (or
> maybe at the anon_inode_mnt->mnt_sb that is created by kern_mount in
> anon_inode_init?)
> 
> IOW, isn't the *only* difference that selinux can actually see just
> the inode allocation? It used to be that
> 
>        inode = anon_inode_getfile();
> 
> now it is
> 
>         inode = new_inode_pseudo(pidfdfs_sb);
> 
> and instead of sharing one single inode (like anon_inode_getfile()
> does unless you ask for separate inodes), it now shares the dentry
> instead (for the same pid).
> 
> Would selinux be happy if the inode allocation just used the
> anon_inode superblock instead of pidfdfs_sb?

No, unfortunately not. The core issue is that anon_inode_getfile() isn't
subject to any LSM hooks which is what pidfds used. But dentry_open() is
via security_file_open(). LSMs wanted to have a say in pidfd mediation
which is now possible. So the switch to dentry_open() is what is causing
the issue.

But here's a straightforward fix appended. We let pidfs.c use that fix
as and then we introduce a new LSM hook for pidfds that allows mediation
of pidfds and selinux can implement it when they're ready. This is
regression free and future proof. I actually tested this already today.

How does that sounds?

--gf7iiupdm46ioigx
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-FIX.patch"

From f2281c90f9c7f67c5f3d2457268cd9877acc1fa9 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 24 Feb 2024 19:55:46 +0100
Subject: [PATCH] FIX

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c | 4 ++--
 fs/internal.h   | 2 ++
 fs/pidfs.c      | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index b991f90571b4..685198338c4b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -282,8 +282,8 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
  * @flags: O_... flags with which the new file will be opened
  * @fop: the 'struct file_operations' for the new file
  */
-static struct file *alloc_file(const struct path *path, int flags,
-		const struct file_operations *fop)
+struct file *alloc_file(const struct path *path, int flags,
+			const struct file_operations *fop)
 {
 	struct file *file;
 
diff --git a/fs/internal.h b/fs/internal.h
index b0c843c3fa3c..ac0d1fbd6d8d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -315,3 +315,5 @@ int path_from_stashed(struct dentry **stashed, unsigned long ino,
 		      const struct inode_operations *iops, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+struct file *alloc_file(const struct path *path, int flags,
+			const struct file_operations *fop);
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 2e165e6911df..57585de8f973 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -227,8 +227,9 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	pidfd_file = dentry_open(&path, flags, current_cred());
-	path_put(&path);
+	pidfd_file = alloc_file(&path, flags, &pidfs_file_operations);
+	if (IS_ERR(pidfd_file))
+		path_put(&path);
 	return pidfd_file;
 }
 
-- 
2.43.0


--gf7iiupdm46ioigx--

