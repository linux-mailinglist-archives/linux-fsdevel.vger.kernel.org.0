Return-Path: <linux-fsdevel+bounces-45521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB58A790C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 16:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E02188D3C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE723C8C9;
	Wed,  2 Apr 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuLZivfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504923AE8D;
	Wed,  2 Apr 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602911; cv=none; b=Qp//4sE11nMCWF8KYZSoL9mGx+OjBdrncGeGbHqZvAFEdwL4Hbiao1MFBOJ8AyreXF+Lr0gLzZXRSOqaZ++0gs+iXlZoEn0EJJPGeKGPFD5/0rLVopshQTrC88lUrK4xdHahg0hqGUkaSHdaje+YW3DbaRKjFgepwwZtHreM5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602911; c=relaxed/simple;
	bh=gyW+5E4PcQrUZ/xuv6WYhpt81G/Ut0nCyzaUkCL5UOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nimm15PwuVXfbia3xovwa8zuC8gu1buDdvuqrsXxUhMmOz9OP1q2zoYiApwArGNVzQSQUL0OR/WCZV6UGTmNZyzkwQCIw5/rIN5oEtKOTyauFj3KEQ1B031mzaq2Yomyhw5XyrVtIXTtyjv+w+CxMh6j2QNTgCmKyIeZfObJV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuLZivfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAA8C4CEDD;
	Wed,  2 Apr 2025 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602910;
	bh=gyW+5E4PcQrUZ/xuv6WYhpt81G/Ut0nCyzaUkCL5UOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuLZivfi5ufnwpl2KQHzAgEoAc+KzbLb9WNOROUjJVoHLLVbyqiDs6sJdwA1kw/0I
	 dovzjy9JYf1XlGJ1KX3kJrA0E0O1NEwMSiZcHgUtojMQ81oVbsyM32k2ZUFyfmSgpD
	 o0KtyiHzMXhh6CUvpODHGUDo56wIc/nEe9GqocxZBjHj1UV1ijOcnGpm5Pda70H7vi
	 YE+y6BTr7HF+h68aruyR1ntt6OomYSZflbbqr11KVxvuZ3aP3WzGjPD/dEy8UThnBo
	 tY/fiTW+qg/6CKP0zEG1EkwsNqUkYeOMD3k86RbWM/6CBLLBJONungYlui68HaQMmM
	 HpbudpPKbPhWg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH v2 3/4] power: freeze filesystems during suspend/resume
Date: Wed,  2 Apr 2025 16:07:33 +0200
Message-ID: <20250402-work-freeze-v2-3-6719a97b52ac@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=8276; i=brauner@kernel.org; h=from:subject:message-id; bh=gyW+5E4PcQrUZ/xuv6WYhpt81G/Ut0nCyzaUkCL5UOs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/dVl1X1aoLXkvt2j0Ps+9LyIqBVMSr094c1Gn9uaCa xldyv/ZOkpYGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiEczwPVF72awt115NODdX QcCObfW+p9x8/3Z/niShq/s76tecZEaGnXpV54Rqp6r+dWd5Pd3+1WrXdL6fDUnTtx+4OOcxa9g VXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now all the pieces are in place to actually allow the power subsystem
to freeze/thaw filesystems during suspend/resume. Filesystems are only
frozen and thawed if the power subsystem does actually own the freeze.

We could bubble up errors and fail suspend/resume if the error isn't
EBUSY (aka it's already frozen) but I don't think that this is worth it.
Filesystem freezing during suspend/resume is best-effort. If the user
has 500 ext4 filesystems mounted and 4 fail to freeze for whatever
reason then we simply skip them.

What we have now is already a big improvement and let's see how we fare
with it before making our lives even harder (and uglier) than we have
to.

We add a new sysctl know /sys/power/freeze_filesystems that will allow
userspace to freeze filesystems during suspend/hibernate. For now it
defaults to off. The thaw logic doesn't require checking whether
freezing is enabled because the power subsystem exclusively owns frozen
filesystems for the duration of suspend/hibernate and is able to skip
filesystems it doesn't need to freeze.

Also it is technically possible that filesystem
filesystem_freeze_enabled is true and power freezes the filesystems but
before freezing all processes another process disables
filesystem_freeze_enabled. If power were to place the filesystems_thaw()
call under filesystems_freeze_enabled it would fail to thaw the
fileystems it frozw. The exclusive holder mechanism makes it possible to
iterate through the list without any concern making sure that no
filesystems are left frozen.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c               | 14 ++++++++++----
 kernel/power/hibernate.c | 16 +++++++++++++++-
 kernel/power/main.c      | 31 +++++++++++++++++++++++++++++++
 kernel/power/power.h     |  4 ++++
 kernel/power/suspend.c   |  7 +++++++
 5 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3ddded4360c6..b4bdbc509dba 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1187,6 +1187,8 @@ static inline bool get_active_super(struct super_block *sb)
 	return active;
 }
 
+static const char *filesystems_freeze_ptr = "filesystems_freeze";
+
 static void filesystems_freeze_callback(struct super_block *sb, void *unused)
 {
 	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
@@ -1196,9 +1198,11 @@ static void filesystems_freeze_callback(struct super_block *sb, void *unused)
 		return;
 
 	if (sb->s_op->freeze_super)
-		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
+		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+				       filesystems_freeze_ptr);
 	else
-		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
+		freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+			     filesystems_freeze_ptr);
 
 	deactivate_super(sb);
 }
@@ -1218,9 +1222,11 @@ static void filesystems_thaw_callback(struct super_block *sb, void *unused)
 		return;
 
 	if (sb->s_op->thaw_super)
-		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
+		sb->s_op->thaw_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+				     filesystems_freeze_ptr);
 	else
-		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL, NULL);
+		thaw_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+			   filesystems_freeze_ptr);
 
 	deactivate_super(sb);
 }
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 50ec26ea696b..37d733945c59 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -777,6 +777,8 @@ int hibernate(void)
 		goto Restore;
 
 	ksys_sync_helper();
+	if (filesystem_freeze_enabled)
+		filesystems_freeze();
 
 	error = freeze_processes();
 	if (error)
@@ -845,6 +847,7 @@ int hibernate(void)
 	/* Don't bother checking whether freezer_test_done is true */
 	freezer_test_done = false;
  Exit:
+	filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
  Restore:
 	pm_restore_console();
@@ -881,6 +884,9 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 	if (error)
 		goto restore;
 
+	if (filesystem_freeze_enabled)
+		filesystems_freeze();
+
 	error = freeze_processes();
 	if (error)
 		goto exit;
@@ -940,6 +946,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 	thaw_processes();
 
 exit:
+	filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
 
 restore:
@@ -1028,19 +1035,26 @@ static int software_resume(void)
 	if (error)
 		goto Restore;
 
+	if (filesystem_freeze_enabled)
+		filesystems_freeze();
+
 	pm_pr_dbg("Preparing processes for hibernation restore.\n");
 	error = freeze_processes();
-	if (error)
+	if (error) {
+		filesystems_thaw();
 		goto Close_Finish;
+	}
 
 	error = freeze_kernel_threads();
 	if (error) {
 		thaw_processes();
+		filesystems_thaw();
 		goto Close_Finish;
 	}
 
 	error = load_image_and_restore();
 	thaw_processes();
+	filesystems_thaw();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
  Restore:
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..0b0e76324c43 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -962,6 +962,34 @@ power_attr(pm_freeze_timeout);
 
 #endif	/* CONFIG_FREEZER*/
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+bool filesystem_freeze_enabled = false;
+
+static ssize_t freeze_filesystems_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", filesystem_freeze_enabled);
+}
+
+static ssize_t freeze_filesystems_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	filesystem_freeze_enabled = !!val;
+	return n;
+}
+
+power_attr(freeze_filesystems);
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATION */
+
 static struct attribute * g[] = {
 	&state_attr.attr,
 #ifdef CONFIG_PM_TRACE
@@ -991,6 +1019,9 @@ static struct attribute * g[] = {
 #endif
 #ifdef CONFIG_FREEZER
 	&pm_freeze_timeout_attr.attr,
+#endif
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+	&freeze_filesystems_attr.attr,
 #endif
 	NULL,
 };
diff --git a/kernel/power/power.h b/kernel/power/power.h
index c352dea2f67b..2eb81662b8fa 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -18,6 +18,10 @@ struct swsusp_info {
 	unsigned long		size;
 } __aligned(PAGE_SIZE);
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
+extern bool filesystem_freeze_enabled;
+#endif
+
 #ifdef CONFIG_HIBERNATION
 /* kernel/power/snapshot.c */
 extern void __init hibernate_reserved_size_init(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab121d..76b141b9aac0 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -30,6 +30,7 @@
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
+#include <linux/fs.h>
 
 #include "power.h"
 
@@ -374,6 +375,8 @@ static int suspend_prepare(suspend_state_t state)
 	if (error)
 		goto Restore;
 
+	if (filesystem_freeze_enabled)
+		filesystems_freeze();
 	trace_suspend_resume(TPS("freeze_processes"), 0, true);
 	error = suspend_freeze_processes();
 	trace_suspend_resume(TPS("freeze_processes"), 0, false);
@@ -550,6 +553,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 static void suspend_finish(void)
 {
 	suspend_thaw_processes();
+	filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
 	pm_restore_console();
 }
@@ -588,6 +592,8 @@ static int enter_state(suspend_state_t state)
 		ksys_sync_helper();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 	}
+	if (filesystem_freeze_enabled)
+		filesystems_freeze();
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
@@ -609,6 +615,7 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
+	filesystems_thaw();
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }

-- 
2.47.2


