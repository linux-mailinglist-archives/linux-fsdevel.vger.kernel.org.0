Return-Path: <linux-fsdevel+bounces-67129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F2C35E77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3693BE41B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7C324B30;
	Wed,  5 Nov 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpK+52Q3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A18D321457;
	Wed,  5 Nov 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350222; cv=none; b=d0xQcQZUPz4N6QtkQEAJYYNjhXyi+q151CqEBtAj39oWCyVULCeClJ7bvcHIsPfMmrv2MySMZQGoLlOeHmttbliWUWVCctZ3rHAIJeWBfpPMpWDYeuxSETd7kbw3wCr3lshQE+8MCXpuHGeMTFOWmAwpElBwQL49JTQdbZLnMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350222; c=relaxed/simple;
	bh=Y4z+9e1UwC5T6z0wCgNZeZRbf0AM/5FfB8YJzrR21hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1+Kf1FH1VwlnO4mywQNA0PNaJbZKRex1EUe8oE8O/GUaGyx4uLVBVnMs3z6RARnsgcbhUJsAy52TYNMPfxCfXcGV1+8HXYmZGPpD/X5ygKkJnrjrzPIb4YWzHC1I00BuVMEcd359CdiF9ZuYjVSJGXQk+Zpyg74OaZV7rQ3OuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpK+52Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06F8C116C6;
	Wed,  5 Nov 2025 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762350222;
	bh=Y4z+9e1UwC5T6z0wCgNZeZRbf0AM/5FfB8YJzrR21hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpK+52Q3omkUnkccjIvVZ+YRsgCuvNHfYI3MIjZdom3SQlkvCxWrDKlJ/warJWlfU
	 E2F8IQSoapfPbPkoeT1aoiEswcoh02gGX8oBXwk3gRHNyBeZUHUeUo+b4cr6I294iw
	 tBcxcaaq3YbSyuRjslKl88dOXL+Cy2viJZ7P25mEP2+E9ZcmFOfYi+ATgSngL6gv9n
	 v2XP08JIGf50Xp2be3XMK7gODkPeWhvGs+zC9MmCzInGZQRHdIk2nCtC0hWYBwb9+G
	 qTgu9snAFyspbiug6v3NCj2Qye16mxq7V5yOexSp8bqBCZO8FEinxKzWUVj4KRIRVG
	 zY/fGjNUXwlZA==
Date: Wed, 5 Nov 2025 14:43:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, 
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, borntraeger@linux.ibm.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251105-vorbild-zutreffen-fe00d1dd98db@brauner>
References: <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
 <20251105-sohlen-fenster-e7c5af1204c4@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="buvkja4jscyxhqel"
Content-Disposition: inline
In-Reply-To: <20251105-sohlen-fenster-e7c5af1204c4@brauner>


--buvkja4jscyxhqel
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> > > And suspend/resume works just fine with freeze/thaw. See commit
> > > eacfbf74196f ("power: freeze filesystems during suspend/resume")
> > > which implements exactly that.
> > > 
> > > The reason this didn't work for you is very likely:
> > > 
> > > cat /sys/power/freeze_filesystems
> > > 0
> > > 
> > > which you must set to 1.
> > 
> > Actually, no, that's not correct.  The efivarfs freeze/thaw logic must
> > run unconditionally regardless of this setting to fix the systemd bug,
> > so all the variable resyncing is done in the thaw call, which isn't
> > conditioned on the above (or at least it shouldn't be).
> 
> It is conditioned on the above currently but we can certainly fix it
> easily to not be.

Something like the appended patch would do it.

--buvkja4jscyxhqel
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-power-always-freeze-efivarfs.patch"

From 1f9dc293cebb10b18d9ec8e01b60c014664c98ab Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 5 Nov 2025 14:39:45 +0100
Subject: [PATCH] power: always freeze efivarfs

The efivarfs filesystems must always be frozen and thawed to resync
variable state. Make it so.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/efivarfs/super.c      |  1 +
 fs/super.c               | 14 +++++++++++---
 include/linux/fs.h       |  3 ++-
 kernel/power/hibernate.c |  9 +++------
 kernel/power/suspend.c   |  3 +--
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 1f4d8ce56667..6f9cd18ce6f0 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -512,6 +512,7 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
 
 	fc->s_fs_info = sfi;
+	fc->s_iflags |= SB_I_FREEZE_POWER;
 	fc->ops = &efivarfs_context_ops;
 
 	return 0;
diff --git a/fs/super.c b/fs/super.c
index 5bab94fb7e03..017f0be22c61 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1183,11 +1183,19 @@ static inline bool get_active_super(struct super_block *sb)
 
 static const char *filesystems_freeze_ptr = "filesystems_freeze";
 
-static void filesystems_freeze_callback(struct super_block *sb, void *unused)
+static void filesystems_freeze_callback(struct super_block *sb, void *bool_freeze_all)
 {
+	bool freeze_all = *(bool *)bool_freeze_all;
+
 	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
 		return;
 
+	if (!freeze_all) {
+		if (!(sb->s_iflags & SB_I_FREEZE_POWER))
+			return;
+		pr_info("VFS: Freezing %s filesystems\n", sb->s_type->name);
+	}
+
 	if (!get_active_super(sb))
 		return;
 
@@ -1201,9 +1209,9 @@ static void filesystems_freeze_callback(struct super_block *sb, void *unused)
 	deactivate_super(sb);
 }
 
-void filesystems_freeze(void)
+void filesystems_freeze(bool freeze_all)
 {
-	__iterate_supers(filesystems_freeze_callback, NULL,
+	__iterate_supers(filesystems_freeze_callback, &freeze_all,
 			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..bde4967fdb68 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1419,6 +1419,7 @@ extern int send_sigurg(struct file *file);
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
+#define SB_I_FREEZE_POWER	0x00008000	/* Always freeze on suspend/hibernate */
 
 /* Possible states of 'frozen' field */
 enum {
@@ -3606,7 +3607,7 @@ extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*f)(struct super_block *, void *), void *arg);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
-void filesystems_freeze(void);
+void filesystems_freeze(bool freeze_all);
 void filesystems_thaw(void);
 
 extern int dcache_dir_open(struct inode *, struct file *);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff23551..1f250ce036a0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -825,8 +825,7 @@ int hibernate(void)
 		goto Restore;
 
 	ksys_sync_helper();
-	if (filesystem_freeze_enabled)
-		filesystems_freeze();
+	filesystems_freeze(filesystem_freeze_enabled);
 
 	error = freeze_processes();
 	if (error)
@@ -932,8 +931,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 	if (error)
 		goto restore;
 
-	if (filesystem_freeze_enabled)
-		filesystems_freeze();
+	filesystems_freeze(filesystem_freeze_enabled);
 
 	error = freeze_processes();
 	if (error)
@@ -1083,8 +1081,7 @@ static int software_resume(void)
 	if (error)
 		goto Restore;
 
-	if (filesystem_freeze_enabled)
-		filesystems_freeze();
+	filesystems_freeze(filesystem_freeze_enabled);
 
 	pm_pr_dbg("Preparing processes for hibernation restore.\n");
 	error = freeze_processes();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4bb4686c1c08..c933a63a9718 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -375,8 +375,7 @@ static int suspend_prepare(suspend_state_t state)
 	if (error)
 		goto Restore;
 
-	if (filesystem_freeze_enabled)
-		filesystems_freeze();
+	filesystems_freeze(filesystem_freeze_enabled);
 	trace_suspend_resume(TPS("freeze_processes"), 0, true);
 	error = suspend_freeze_processes();
 	trace_suspend_resume(TPS("freeze_processes"), 0, false);
-- 
2.47.3


--buvkja4jscyxhqel--

