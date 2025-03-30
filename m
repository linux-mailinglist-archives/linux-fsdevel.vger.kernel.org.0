Return-Path: <linux-fsdevel+bounces-45294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFFA759D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBBF3AB3AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC81C173F;
	Sun, 30 Mar 2025 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkG3+aOd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C011991CD;
	Sun, 30 Mar 2025 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743335625; cv=none; b=dsYF+dv902Y9tpJKfabeHuvOcyR/TtIBT4xtXjzNBDzz1nPo2aC/Z2XSx1WqrSVLEhLNUKcWtNvCvGvH6q8yOfBUaw7vu1qcnWW+vHOht0AOxYGPgeG9/mOHgtv994hBdkA3BA5+v84QZE+YQvOIrQtAH2AgNNfgxFGe6cKjb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743335625; c=relaxed/simple;
	bh=1lrb21tzJ84nytKxIOFaauJ/gE8C+3BPbGjDhW0NlgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH1vW/6y7dLvggj72J/xenGZBXd/FTwzU5XW63Ccx0pfNnOoRdTSER2cGFqWw1DU2Hgm2dgJZjGrusnO05fAoajlZhKaugm450Zfcnf5Gqv/QXHc1+2Vpx+G81lxTXN0RfHYU0JmWKZ9Ftc6UfreIUmHZXwAm0VQe5tB0cGmsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkG3+aOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4226C4CEDD;
	Sun, 30 Mar 2025 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743335625;
	bh=1lrb21tzJ84nytKxIOFaauJ/gE8C+3BPbGjDhW0NlgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkG3+aOd0NW9XZoi/T+x+mVcGzTU5I5qDCNiuaNS82tNsIOrDiE6n7qhgaZtxUxtr
	 ZY1NqV7JxOMnDz7W5nf5CZ/OFnCTkyp4dbP+6cCpoEGxaTsvaUxfGiNB7IukU6loUs
	 rd2H3nnmv2ibuxtCS9chlGn2tyLtq69drNknDJDy74tpYRmZhJQjo6uxF/+TeuX9kf
	 7yWIigsUBPkHFsWy6KHo41mDiLPq/puXn7G97ZGABH3/7a9lxJNXD/GX9bvLyxy/kj
	 Dzow8Ec/j0HzRV2NImUDglIXyBneJdW/+wrjIVR29RaUubbONaHI/MpFWtwHP8PwhJ
	 r4PNYMR0jD5WA==
Date: Sun, 30 Mar 2025 13:53:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 0/6] Extend freeze support to suspend and hibernate
Message-ID: <20250330-akupunktur-weshalb-c90594b6ad01@brauner>
References: <20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org>
 <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <12ce8c18f4e16b1de591cbdfb8f6e7844e42807b.camel@HansenPartnership.com>
 <9c0a24cd8b03539fd6b8ecd5a186a5cf98b5d526.camel@HansenPartnership.com>
 <20250330-heimweg-packen-b73908210f79@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5p4k2tvj74tkuxrm"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250330-heimweg-packen-b73908210f79@brauner>


--5p4k2tvj74tkuxrm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 30, 2025 at 10:33:53AM +0200, Christian Brauner wrote:
> On Sat, Mar 29, 2025 at 01:02:32PM -0400, James Bottomley wrote:
> > On Sat, 2025-03-29 at 10:04 -0400, James Bottomley wrote:
> > > On Sat, 2025-03-29 at 09:42 +0100, Christian Brauner wrote:
> > > > Add the necessary infrastructure changes to support freezing for
> > > > suspend and hibernate.
> > > > 
> > > > Just got back from LSFMM. So still jetlagged and likelihood of bugs
> > > > increased. This should all that's needed to wire up power.
> > > > 
> > > > This will be in vfs-6.16.super shortly.
> > > > 
> > > > ---
> > > > Changes in v2:
> > > > - Don't grab reference in the iterator make that a requirement for
> > > > the callers that need custom behavior.
> > > > - Link to v1:
> > > > https://lore.kernel.org/r/20250328-work-freeze-v1-0-a2c3a6b0e7a6@kernel.org
> > > 
> > > Given I've been a bit quiet on this, I thought I'd better explain
> > > what's going on: I do have these built, but I made the mistake of
> > > doing a dist-upgrade on my testing VM master image and it pulled in a
> > > version of systemd (257.4-3) that has a broken hibernate.  Since I
> > > upgraded in place I don't have the old image so I'm spending my time
> > > currently debugging systemd ... normal service will hopefully resume
> > > shortly.
> > 
> > I found the systemd bug
> > 
> > https://github.com/systemd/systemd/issues/36888
> 
> I don't think that's a systemd bug.
> 
> > And hacked around it, so I can confirm a simple hibernate/resume works
> > provided the sd_start_write() patches are applied (and the hooks are
> > plumbed in to pm).
> > 
> > There is an oddity: the systemd-journald process that would usually
> > hang hibernate in D wait goes into R but seems to be hung and can't be
> > killed by the watchdog even with a -9.  It's stack trace says it's
> > still stuck in sb_start_write:
> > 
> > [<0>] percpu_rwsem_wait.constprop.10+0xd1/0x140
> > [<0>] ext4_page_mkwrite+0x3c1/0x560 [ext4]
> > [<0>] do_page_mkwrite+0x38/0xa0
> > [<0>] do_wp_page+0xd5/0xba0
> > [<0>] __handle_mm_fault+0xa29/0xca0
> > [<0>] handle_mm_fault+0x16a/0x2d0
> > [<0>] do_user_addr_fault+0x3ab/0x810
> > [<0>] exc_page_fault+0x68/0x150
> > [<0>] asm_exc_page_fault+0x22/0x30
> > 
> > So I think there's something funny going on in thaw.
> 
> My uneducated guess is that it's probably an issue with ext4 freezing
> and unfreezing. xfs stops workqueues after all writes and pagefault
> writers have stopped. This is done in ->sync_fs() when it's called from
> freeze_super(). They are restarted when ->unfreeze_fs is called.
> 
> But for ext4 in ->sync_fs() the rsv_conversion_wq is flushed. I think
> that should be safe to do but I'm not sure if there can't be other work
> coming in on it before the actual freeze call. Jan will be able to
> explain this a lot better. I don't have time today to figure out what
> this does.

Though I'm just looking at the patch snippet you posted for how you
hooked up efivarfs in https://lore.kernel.org/r/a7e6dee45ac11519c33a297797990fce6bb32bff.camel@HansenPartnership.com
and that looks pretty broken and is probably the root cause. You have:

+static int efivarfs_thaw(struct super_block *sb, enum freeze_holder who);
 static const struct super_operations efivarfs_ops = {
        .statfs = efivarfs_statfs,
        .drop_inode = generic_delete_inode,
        .alloc_inode = efivarfs_alloc_inode,
        .free_inode = efivarfs_free_inode,
        .show_options = efivarfs_show_options,
+       .thaw_super = efivarfs_thaw,
 };

Which adds ->thaw_super() without ->freeze_super() which means that
->thaw_super() is never called for efivarfs.

But also it's broken in other ways. You're not waiting for writers to
finish. Which is most often fine because efivarfs shouldn't be written
to that heavily but still this won't work and you need to call the
generic VFS helpers.

I'm appending a draft for how to do this with efivarfs. Note, I don't
have the means/time to test this right now. Would you please plumb in
your recursive removal into my patch and test it? I'm pushing it to
vfs-6.16.super for now (It likely will fail due to unused helpers right
now because I gutted the recursive removal.).

--5p4k2tvj74tkuxrm
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-DRAFT-efivarfs-support-freeze-thaw-for-suspend-hiber.patch"

From 4cb24e33a63a8f9dd5a2ab56b1b183c1ef26c4d0 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 30 Mar 2025 13:24:18 +0200
Subject: [PATCH] [DRAFT] efivarfs: support freeze/thaw for suspend/hibernate

The efivarfs subsystem wants to partake in system hibernation and
suspend. To this end it needs to gain freeze/thaw support.

- Don't expose efivarfs freeze/thaw to userspace. It's not just
  pointless it also would complicate the implementation because we would
  need to handle userspace initiated freezed in combination with
  hibernation initiated freezes. IOW, userspace could freeze efivarfs
  and we get a notification about an imminent freeze request from the
  power subsystem but since we're already frozen by userspace we never
  actually sync variables. So this is useful on two fronts.

- Unregister the notifier before we call kill_litter_super() because
  by that time the filesystems is already dead so no need bothering with
  reacting to hibernation. We wont't resurrect it anyway.

- Let the notifier set a global variable to indicate that hibernation is
  ongoing and resync variable state when efivars is actually going to be
  unfrozen via efivarfs_thaw_super()'s call to efivarfs_unfreeze_fs().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/efivarfs/super.c | 141 ++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 90 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 0486e9b68bc6..ce0f7ebeed1d 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -119,12 +119,20 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return 0;
 }
+
+static int efivarfs_freeze_super(struct super_block *sb, enum freeze_holder who);
+static int efivarfs_thaw_super(struct super_block *sb, enum freeze_holder who);
+static int efivarfs_unfreeze_fs(struct super_block *sb);
+
 static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.alloc_inode = efivarfs_alloc_inode,
 	.free_inode = efivarfs_free_inode,
 	.show_options = efivarfs_show_options,
+	.freeze_super = efivarfs_freeze_super,
+	.thaw_super = efivarfs_thaw_super,
+	.unfreeze_fs = efivarfs_unfreeze_fs,
 };
 
 /*
@@ -368,7 +376,6 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	register_pm_notifier(&sfi->pm_nb);
-
 	return efivar_init(efivarfs_callback, sb, true);
 }
 
@@ -474,111 +481,61 @@ static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
 	return err;
 }
 
-static void efivarfs_deactivate_super_work(struct work_struct *work)
-{
-	struct super_block *s = container_of(work, struct super_block,
-					     destroy_work);
-	/*
-	 * note: here s->destroy_work is free for reuse (which
-	 * will happen in deactivate_super)
-	 */
-	deactivate_super(s);
-}
-
 static struct file_system_type efivarfs_type;
 
-static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
-			      void *ptr)
+static int efivarfs_freeze_super(struct super_block *sb, enum freeze_holder who)
 {
-	struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
-						    pm_nb);
-	struct path path;
-	struct efivarfs_ctx ectx = {
-		.ctx = {
-			.actor	= efivarfs_actor,
-		},
-		.sb = sfi->sb,
-	};
-	struct file *file;
-	struct super_block *s = sfi->sb;
-	static bool rescan_done = true;
-
-	if (action == PM_HIBERNATION_PREPARE) {
-		rescan_done = false;
-		return NOTIFY_OK;
-	} else if (action != PM_POST_HIBERNATION) {
-		return NOTIFY_DONE;
-	}
+	/* We only support freezing from the kernel. */
+	if (!(who & FREEZE_HOLDER_KERNEL))
+		return -EOPNOTSUPP;
 
-	if (rescan_done)
-		return NOTIFY_DONE;
+	return freeze_super(sb, who);
+}
 
-	/* ensure single superblock is alive and pin it */
-	if (!atomic_inc_not_zero(&s->s_active))
-		return NOTIFY_DONE;
+static int efivarfs_thaw_super(struct super_block *sb, enum freeze_holder who)
+{
+	/* We only support freezing from the kernel. */
+	if (!(who & FREEZE_HOLDER_KERNEL))
+		return -EOPNOTSUPP;
 
-	pr_info("efivarfs: resyncing variable state\n");
+	return thaw_super(sb, who);
+}
 
-	path.dentry = sfi->sb->s_root;
+/*
+ * Only accessed by the power management notifier before ->unfreeze_fs()
+ * is ever called so this is serialized through the power management
+ * system.
+ */
+static bool need_unfreeze_fs = false;
 
-	/*
-	 * do not add SB_KERNMOUNT which a single superblock could
-	 * expose to userspace and which also causes MNT_INTERNAL, see
-	 * below
-	 */
-	path.mnt = vfs_kern_mount(&efivarfs_type, 0,
-				  efivarfs_type.name, NULL);
-	if (IS_ERR(path.mnt)) {
-		pr_err("efivarfs: internal mount failed\n");
-		/*
-		 * We may be the last pinner of the superblock but
-		 * calling efivarfs_kill_sb from within the notifier
-		 * here would deadlock trying to unregister it
-		 */
-		INIT_WORK(&s->destroy_work, efivarfs_deactivate_super_work);
-		schedule_work(&s->destroy_work);
-		return PTR_ERR(path.mnt);
+static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action, void *ptr)
+{
+	if (action == PM_HIBERNATION_PREPARE) {
+		need_unfreeze_fs = true;
+		return NOTIFY_OK;
+	} else if (action == PM_POST_HIBERNATION) {
+		need_unfreeze_fs = false;
+		return NOTIFY_OK;
 	}
 
-	/* path.mnt now has pin on superblock, so this must be above one */
-	atomic_dec(&s->s_active);
+	return NOTIFY_DONE;
+}
 
-	file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
-				current_cred());
-	/*
-	 * safe even if last put because no MNT_INTERNAL means this
-	 * will do delayed deactivate_super and not deadlock
-	 */
-	mntput(path.mnt);
-	if (IS_ERR(file))
-		return NOTIFY_DONE;
+static int efivarfs_unfreeze_fs(struct super_block *sb)
+{
+	/* This isn't a hibernation call so there's nothing for us to do. */
+	if (!need_unfreeze_fs)
+		return 0;
 
-	rescan_done = true;
+	pr_info("efivarfs: resyncing variable state\n");
 
 	/*
-	 * First loop over the directory and verify each entry exists,
-	 * removing it if it doesn't
+	 * TODO: Now do the variable resyncing thing. vfs_kern_mount()
+	 * won't work because we'd deadlock with ->thaw_super() fwiw.
 	 */
-	file->f_pos = 2;	/* skip . and .. */
-	do {
-		ectx.dentry = NULL;
-		iterate_dir(file, &ectx.ctx);
-		if (ectx.dentry) {
-			pr_info("efivarfs: removing variable %pd\n",
-				ectx.dentry);
-			simple_recursive_removal(ectx.dentry, NULL);
-			dput(ectx.dentry);
-		}
-	} while (ectx.dentry);
-	fput(file);
 
-	/*
-	 * then loop over variables, creating them if there's no matching
-	 * dentry
-	 */
-	efivar_init(efivarfs_check_missing, sfi->sb, false);
+	return 0;
 
-	return NOTIFY_OK;
 }
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
@@ -609,8 +566,12 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	struct efivarfs_fs_info *sfi = sb->s_fs_info;
 
 	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
-	kill_litter_super(sb);
+	/*
+	 * Unregister the pm notifier right now as that superblock is
+	 * already dead.
+	 */
 	unregister_pm_notifier(&sfi->pm_nb);
+	kill_litter_super(sb);
 
 	kfree(sfi);
 }
-- 
2.47.2


--5p4k2tvj74tkuxrm--

