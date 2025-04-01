Return-Path: <linux-fsdevel+bounces-45403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8BA771F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DED16450A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52611C8630;
	Tue,  1 Apr 2025 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMY+ijcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5213B2A0;
	Tue,  1 Apr 2025 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467632; cv=none; b=Z+/oJYO0ihm9NxwpUTUquADeobKSInDW0saw41fI2de7VnyQg5Uuc3P6FfoE6D0KagUuzXtg/44Uphz8Kv7ybizKse0Z4vfJU6iSV8Db8rw5NyitANS1dRfGJHVJNQKXX0jRNyL2bWurguDk8sp1kG77eRgN0lEo6GsmtVdzl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467632; c=relaxed/simple;
	bh=E6uWVHHjoPhRtgz4oW7o0triLrpRj/wcC1z2auGXS0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxPlW3k+Rm+ddP1BAoT+K9R3rvTce9+TG//f8U875xzJ0fURlYRYL4FxkoV0jjo5NaYUnSKQ9zWat3zsX50HCkGukgM+it1yoOsLY3kYLC/F83uoeQNHGP4azXK7t7kzb2WdPAbW2lnYDt2it+mVM8db9WQeGwnF9Kbyw4zIlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMY+ijcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949EAC4CEEB;
	Tue,  1 Apr 2025 00:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743467631;
	bh=E6uWVHHjoPhRtgz4oW7o0triLrpRj/wcC1z2auGXS0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMY+ijcAI7yJeb3c2qVB4U/X3FzVcvqBCOGQLKKQV7m26dzqMtW8Gp7b4tNikTo/G
	 6h9wydXvkgrtPzqItacfLtD2I2uMUsg05Juigl86a4/8OrImYLPVf6I/TqbTlhFdy9
	 t5utlaStPLY7dQ2cAgqp5E0nADwx/ZEI3Rc40H9sUTDJD9oiAc0v2BM3l3JHnvqat4
	 NFpneF43NtP16WRGCDu7BUIc3A/xeavmb1xGp5/cfelw38N2ng19IwGfPtBSCZgZ5Y
	 9rBSWNPRW6verGErN85+OCku2Ug0Rsg9o+GsKT5Wx2s49yPdY0/L1bTxFMhVEtQgqm
	 8tnw0XU61XX+A==
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
Subject: [PATCH 6/6] power: freeze filesystems during suspend/resume
Date: Tue,  1 Apr 2025 02:32:51 +0200
Message-ID: <20250401-work-freeze-v1-6-d000611d4ab0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5971; i=brauner@kernel.org; h=from:subject:message-id; bh=E6uWVHHjoPhRtgz4oW7o0triLrpRj/wcC1z2auGXS0M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/NrHVrnxZbjJVjeXVhehQe53H83N8Fpw+qHfdp7Gvy 1fpZO6yjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMa2Bk2LXaaWmP/8On4jlT 1xbK7ua2ti88/GypceBnFffe5xvevmFkWM6QeoB5rrpYN0fI8oN8oWY2/Eq9f15psWTrz3M9OHE CLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now all the pieces are in place to actually allow the power subsystem
to freeze/thaw filesystems during suspend/resume. Filesystems are only
frozen and thawed if the power subsystem does actually own the freeze.

Othwerwise it risks thawing filesystems it didn't own. This could be
done differently be e.g., keepin the filesystems that were actually
frozen on a list and then unfreezing them from that list. This is
disgustingly unclean though and reeks of an ugly hack.

If the filesystem is already frozen by the time we've frozen all
userspace processes we don't care to freeze it again. That's userspace's
job once the process resumes. We only actually freeze filesystems if we
absolutely have to and we ignore other failures to freeze for now.

We could bubble up errors and fail suspend/resume if the error isn't
EBUSY (aka it's already frozen) but I don't think that this is worth it.
Filesystem freezing during suspend/resume is best-effort. If the user
has 500 ext4 filesystems mounted and 4 fail to freeze for whatever
reason then we simply skip them.

What we have now is already a big improvement and let's see how we fare
with it before making our lives even harder (and uglier) than we have
to.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c               | 14 ++++++++++----
 kernel/power/hibernate.c | 13 ++++++++++++-
 kernel/power/suspend.c   |  8 ++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 606072a3fab9..dd0d6def4a55 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1187,6 +1187,8 @@ static inline bool get_active_super(struct super_block *sb)
 	return active;
 }
 
+static const void *filesystems_freeze_ptr;
+
 static void filesystems_freeze_callback(struct super_block *sb, void *unused)
 {
 	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
@@ -1196,9 +1198,11 @@ static void filesystems_freeze_callback(struct super_block *sb, void *unused)
 		return;
 
 	if (sb->s_op->freeze_super)
-		sb->s_op->freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+				       filesystems_freeze_ptr);
 	else
-		freeze_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+			     filesystems_freeze_ptr);
 
 	deactivate_super(sb);
 }
@@ -1218,9 +1222,11 @@ static void filesystems_thaw_callback(struct super_block *sb, void *unused)
 		return;
 
 	if (sb->s_op->thaw_super)
-		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		sb->s_op->thaw_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+				     filesystems_freeze_ptr);
 	else
-		thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL);
+		thaw_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
+			   filesystems_freeze_ptr);
 
 	deactivate_super(sb);
 }
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 50ec26ea696b..1803b7d24757 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -777,6 +777,7 @@ int hibernate(void)
 		goto Restore;
 
 	ksys_sync_helper();
+	filesystems_freeze();
 
 	error = freeze_processes();
 	if (error)
@@ -841,6 +842,7 @@ int hibernate(void)
 			error = load_image_and_restore();
 	}
 	thaw_processes();
+	filesystems_thaw();
 
 	/* Don't bother checking whether freezer_test_done is true */
 	freezer_test_done = false;
@@ -881,6 +883,8 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 	if (error)
 		goto restore;
 
+	filesystems_freeze();
+
 	error = freeze_processes();
 	if (error)
 		goto exit;
@@ -940,6 +944,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 	thaw_processes();
 
 exit:
+	filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
 
 restore:
@@ -1028,19 +1033,25 @@ static int software_resume(void)
 	if (error)
 		goto Restore;
 
+	filesystems_freeze();
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
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8eaec4ab121d..4c476271f7f2 100644
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
 
+	if (sync_on_suspend_enabled)
+		filesystems_freeze();
 	trace_suspend_resume(TPS("freeze_processes"), 0, true);
 	error = suspend_freeze_processes();
 	trace_suspend_resume(TPS("freeze_processes"), 0, false);
@@ -550,6 +553,8 @@ int suspend_devices_and_enter(suspend_state_t state)
 static void suspend_finish(void)
 {
 	suspend_thaw_processes();
+	if (sync_on_suspend_enabled)
+		filesystems_thaw();
 	pm_notifier_call_chain(PM_POST_SUSPEND);
 	pm_restore_console();
 }
@@ -587,6 +592,7 @@ static int enter_state(suspend_state_t state)
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 		ksys_sync_helper();
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+		filesystems_freeze();
 	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
@@ -609,6 +615,8 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
+	if (sync_on_suspend_enabled)
+		filesystems_thaw();
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }

-- 
2.47.2


