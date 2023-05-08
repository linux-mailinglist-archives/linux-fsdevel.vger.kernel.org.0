Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08E06F9D43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEHBRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 21:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEHBRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 21:17:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98A4223;
        Sun,  7 May 2023 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zV/X3tLmwQ3vkrJuBRI3Kmx6RRpx7xIxXORk1HlgcdM=; b=OWwZjPzlHo7TEPfwlAaYTUf9aj
        38zu8BjZimyFpCYPssUK3/EJ9zhGMoUCwZ6O0HXh/YjLS7QDkpCrpiv2+9o9Nc+oBCLedZveIcoyZ
        4uyb2EGJSSOa0Zxeb+ntcrjUOFT6ISS5zP6XaMmVXFnYRH6DwHVYt22Vb5adkXERJLzqBiMyIANUO
        iI1gpDLHZOKkvjMraKixrB4bGVw4Jl6YpaeGIQuaNRrPuhYxjvu+sD+o4l6It+EF+7BQH2H26JtVn
        6OjvgRm7WDUD5zFp4bSe0LP/BuT7dQqgo4TLhPBEYRJfEEachilWpDb6xScWuWR6NVwx8Y6p9zNNR
        6+n77wvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pvpV8-00GvZ8-04;
        Mon, 08 May 2023 01:17:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        da.gomez@samsung.com, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6/6] fs: add automatic kernel fs freeze / thaw and remove kthread freezing
Date:   Sun,  7 May 2023 18:17:17 -0700
Message-Id: <20230508011717.4034511-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508011717.4034511-1-mcgrof@kernel.org>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to automatically handle freezing and thawing filesystems
during the kernel's suspend/resume cycle.

This is needed so that we properly really stop IO in flight without
races after userspace has been frozen. Without this we rely on
kthread freezing and its semantics are loose and error prone.
For instance, even though a kthread may use try_to_freeze() and end
up being frozen we have no way of being sure that everything that
has been spawned asynchronously from it (such as timers) have also
been stopped as well.

A long term advantage of also adding filesystem freeze / thawing
supporting during suspend / hibernation is that long term we may
be able to eventually drop the kernel's thread freezing completely
as it was originally added to stop disk IO in flight as we hibernate
or suspend.

This does not remove the superfluous freezer calls on all filesystems.
Each filesystem must remove all the kthread freezer stuff and peg
the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
flag.

Subsequent patches remove the kthread freezer usage from each
filesystem, one at a time to make all this work bisectable.
Once all filesystems remove the usage of the kthread freezer we
can remove the FS_AUTOFREEZE flag.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c             | 50 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h     | 14 ++++++++++++
 kernel/power/process.c | 15 ++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index d5eab6b38b03..148674429ab8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1910,3 +1910,53 @@ int sb_init_dio_done_wq(struct super_block *sb)
 		destroy_workqueue(wq);
 	return 0;
 }
+
+#ifdef CONFIG_PM_SLEEP
+static bool super_should_freeze(struct super_block *sb)
+{
+	if (!(sb->s_type->fs_flags & FS_AUTOFREEZE))
+		return false;
+	/*
+	 * We don't freeze virtual filesystems, we skip those filesystems with
+	 * no backing device.
+	 */
+	if (sb->s_bdi == &noop_backing_dev_info)
+		return false;
+
+	return true;
+}
+
+int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
+{
+	int error = 0;
+
+	if (!super_should_freeze(sb))
+		goto out;
+
+	pr_info("%s (%s): freezing\n", sb->s_type->name, sb->s_id);
+
+	error = freeze_super(sb, false);
+	if (error && error != -EBUSY)
+		pr_notice("%s (%s): Unable to freeze, error=%d",
+			  sb->s_type->name, sb->s_id, error);
+out:
+	return error;
+}
+
+int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
+{
+	int error = 0;
+
+	if (!super_should_freeze(sb))
+		goto out;
+
+	pr_info("%s (%s): thawing\n", sb->s_type->name, sb->s_id);
+
+	error = thaw_super(sb, false);
+	if (error && error != -EBUSY)
+		pr_notice("%s (%s): Unable to unfreeze, error=%d",
+			  sb->s_type->name, sb->s_id, error);
+out:
+	return error;
+}
+#endif /* CONFIG_PM_SLEEP */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 22dd697ab703..92c85c8ec1ed 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2247,6 +2247,7 @@ struct file_system_type {
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+#define FS_AUTOFREEZE           (1<<16)	/*  temporary as we phase kthread freezer out */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
@@ -2322,6 +2323,19 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super, bool usercall);
 extern int thaw_super(struct super_block *super, bool usercall);
+#ifdef CONFIG_PM_SLEEP
+int fs_suspend_freeze_sb(struct super_block *sb, void *priv);
+int fs_suspend_thaw_sb(struct super_block *sb, void *priv);
+#else
+static inline int fs_suspend_freeze_sb(struct super_block *sb, void *priv)
+{
+	return 0;
+}
+static inline int fs_suspend_thaw_sb(struct super_block *sb, void *priv)
+{
+	return 0;
+}
+#endif
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index cae81a87cc91..7ca7688f0b5d 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -140,6 +140,16 @@ int freeze_processes(void)
 
 	BUG_ON(in_atomic());
 
+	pr_info("Freezing filesystems ... ");
+	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
+	if (error) {
+		pr_cont("failed\n");
+		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
+		thaw_processes();
+		return error;
+	}
+	pr_cont("done.\n");
+
 	/*
 	 * Now that the whole userspace is frozen we need to disable
 	 * the OOM killer to disallow any further interference with
@@ -149,8 +159,10 @@ int freeze_processes(void)
 	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
 		error = -EBUSY;
 
-	if (error)
+	if (error) {
+		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
 		thaw_processes();
+	}
 	return error;
 }
 
@@ -188,6 +200,7 @@ void thaw_processes(void)
 	pm_nosig_freezing = false;
 
 	oom_killer_enable();
+	iterate_supers_excl(fs_suspend_thaw_sb, NULL);
 
 	pr_info("Restarting tasks ... ");
 
-- 
2.39.2

