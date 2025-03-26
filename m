Return-Path: <linux-fsdevel+bounces-45074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3683DA715A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0253AE9C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165B41DF24E;
	Wed, 26 Mar 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h36czRjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66441D8DE0;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988149; cv=none; b=dgk2Ac86Py2RPSZsqnXVbGUmoqcgm2c+1zPR4Eni3kiMP/dNvW8UkbfCPkDhzMerzKNGyNzp507d9ZBO+kyZbJb+Upl62MVDeKq8W6QfDGHEqIamPC56mlnnO+EU1yciIoJu+gn8zxnXiF4HpvIbZ1fq3VJSrSGfFnNijSsKlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988149; c=relaxed/simple;
	bh=cHgdN7gWDB4dt77oGk/eTkwyIMD7VtmKnRK3RgBWl6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TogsOSJA/bwyrFn/WKet1RABytwmtn1v47ma280BFenjS0XxEBoEUG8Yn+t5awUOesY1zB0WIK4wvx1nMHwEsmeEAftgqrFbXnSY4E5/9iD5dX6Q8n8k2CiEX+kp3hjrwk1VP+mHxzaTrf47nJyyPvpMGmGKTpVJ11cx1vJfOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h36czRjN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+MGNjMu3WNO8uPE/bWA2D/wE7wdDKnoflkN5EGzt/Vg=; b=h36czRjNdUVA53MmC5yclcX5qo
	DsUksJKxA9gYvKCw49INTEkXKbTScwesZ6/c4OY70Lr1Mj8Ex64XWCKik7eyUM8JSHI86B0znWwj7
	oQi2CieuSHfUlfdUu4aPV80b8K+57y8vwVg36L2O4X9BNwHNdyTPw9sjgo5mE7VP0+kU50PAbHoQR
	8/eLKNdVFx3H+z9WFEFcHCbY6AaayTjEc8GdrWhrIO4Pcrre62H77f2KC1rTCP2OIEyHeHiOxVdU5
	8mLsVgsFdsldIEtqjMksrAfSYwu4fouAvZagSch4RAEVwgKknRZlV11YXY9KydB5vE/LFETdSo8H6
	+sXp1NXQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LLz-36Vw;
	Wed, 26 Mar 2025 11:22:24 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	James.Bottomley@HansenPartnership.com,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 3/6] fs: add automatic kernel fs freeze / thaw and remove kthread freezing
Date: Wed, 26 Mar 2025 04:22:17 -0700
Message-ID: <20250326112220.1988619-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326112220.1988619-1-mcgrof@kernel.org>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

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
index 9995546cf159..7428f0b2251c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2279,3 +2279,53 @@ int sb_init_dio_done_wq(struct super_block *sb)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
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
index da17fd74961c..e0614c3d376e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2638,6 +2638,7 @@ struct file_system_type {
 #define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_LBS			128	/* FS supports LBS */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+#define FS_AUTOFREEZE           (1<<16)	/*  temporary as we phase kthread freezer out */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
@@ -2729,6 +2730,19 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 int freeze_super(struct super_block *super, enum freeze_holder who);
 int thaw_super(struct super_block *super, enum freeze_holder who);
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
index 66ac067d9ae6..d0f540a89c39 100644
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
2.47.2


