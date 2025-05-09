Return-Path: <linux-fsdevel+bounces-48592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9237FAB1402
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063FF5234EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5352A2920B3;
	Fri,  9 May 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOk/J+va"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7D290DBE;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=YhailvoZIkhfP/KLess+Y/hQMf5qvH7/iZT1f+PpBus5NQvxthUt8l5ipixPYCLJgh6rM1lf0z41WJHkA+TDTZVfnLcI7K1axsJLer4Mn7ez7AIaKqq+3jOpwqzLb09hGhm3kLlXFj+gzlb9cvdAzVzoB3Ybj/3adqnJ8BTtrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=BpmzDMZbudMRxYnWKdn7By3e4oIcbEz4h214VtRxk9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vz0NZFhwsLqlg5f5jCRh8hvSwNUfJ7l2wCN3I5mvAmgA9VxY6xgbQcGtobN8C4GTkpiay0HrwMQvfyp/RaSb5F7i+2I4F5Cuf8fqWWMx28006V3/qAjXxnC6b5GgsBwWy0+PMaBEsPRKfD1WXyZOAEpwflH58O6jnnMUk9M0Qy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOk/J+va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD55CC4CEEF;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795305;
	bh=BpmzDMZbudMRxYnWKdn7By3e4oIcbEz4h214VtRxk9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oOk/J+vaXcCK+KIoAHGzkTE6SF1jxzmX9CvUYcBR+nY+HuSCBjmFriMTsBAAz/W4b
	 07h7jWzhlKlcjHwLg0p26MQ23p0yUS+5xgty/9MCfu9V7oFN3MXsA39qQyWvh7W3fl
	 Iq5AgI9VOLFne6dwxGr0dDSl7S1GdCliiuUxzK479K1e6qQtwWgtDX1QtGAEv+mq4c
	 Hs7ShgRff+NXpp8P6VAJW4xlkiZC5jtQC+MnmliVVuImATzNBgwr08H8s6jJUL4YyT
	 GOVC4ltAY08YmmX8Y+wSal1CAuiN87dLWgau8HpMQl2CXOPvWV/HeuVnZIhNPL9XGH
	 gv3BZhiSiwGZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD60C3ABC3;
	Fri,  9 May 2025 12:55:05 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:05 +0200
Subject: [PATCH 01/12] module: Move modprobe_path and modules_disabled
 ctl_tables into the module subsys
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BpmzDMZbudMRxYnWKdn7By3e4oIcbEz4h214VtRxk9I=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+yERlHWpCzKql69kqBrlIddBBHXw3ii2o
 uiBdL8PsdBJNokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfshAAoJELqXzVK3
 lkFPiYAL/jcKTOT3jHcbWnBmzVITRoAGWzzbqeMhLRmW02xJEovcpCPY557YgiP0MDw733croZF
 E0B+rCl82lMougLjMo2ERjTkG5jEIC1YMnEdSHENOsBYDKsGjQc78C+gjzKuRex2SijKeNi9iQ1
 uyVHT+J023ir1ZOBlut49P1x2aMYq/ijeE0GaEf0fKwCon+h4r4tDZl28rRqr3i54D2Ceg0jR/U
 DdK3iItzrHNAohjw6kT8VcgV38sk6Vqn1GIBtGRXmwT2Hzt8UpXR8Z2UTrHoYw1UoUsT1tjt75K
 knCtPI1vnOkhFgERft4V4NEq2+JM4D7Q4mnWCQWPXogsEFVdIss6C6E/JXzfQqTXfeMbXuSw/aB
 FtYyvMGEbh1FldKAR3MrNrWwkFnOFNfVxGhHR7YLyRfsXpeuVWIzTAwTHK3FG2vEvcogCTywjTA
 QH0H+x43FnFzxiYTQ2JKcV2Nn8mPVyUwTV/FYApI7fa8tKnApPVwY3R+ZcCXgtJy3gd0HxiIcE2
 os=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move module sysctl (modprobe_path and modules_disabled) out of sysctl.c
and into the modules subsystem. Make the modprobe_path variable static
as it no longer needs to be exported. Remove module.h from the includes
in sysctl as it no longer uses any module exported variables.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/kmod.h |  1 -
 kernel/module/kmod.c | 32 +++++++++++++++++++++++++++++++-
 kernel/sysctl.c      | 20 --------------------
 3 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 68f69362d427caaaefc2565127a7a4158433e5f5..cc32e56dae44896f74a9faf0e97f432f133869b9 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -17,7 +17,6 @@
 #define KMOD_PATH_LEN 256
 
 #ifdef CONFIG_MODULES
-extern char modprobe_path[]; /* for sysctl */
 /* modprobe exit status on success, -ve on error.  Return value
  * usually useless though. */
 extern __printf(2, 3)
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index 25f25381251281a390b273cd8a734c92b960113a..5701629adc27b4bb5080db75f0e69f9f55e9d2ad 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -60,7 +60,7 @@ static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD_CONCURRENT);
 /*
 	modprobe_path is set via /proc/sys.
 */
-char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
+static char modprobe_path[KMOD_PATH_LEN] = CONFIG_MODPROBE_PATH;
 
 static void free_modprobe_argv(struct subprocess_info *info)
 {
@@ -177,3 +177,33 @@ int __request_module(bool wait, const char *fmt, ...)
 	return ret;
 }
 EXPORT_SYMBOL(__request_module);
+
+#ifdef CONFIG_MODULES
+static const struct ctl_table kmod_sysctl_table[] = {
+	{
+		.procname	= "modprobe",
+		.data		= &modprobe_path,
+		.maxlen		= KMOD_PATH_LEN,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
+	{
+		.procname	= "modules_disabled",
+		.data		= &modules_disabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
+static int __init init_kmod_sysctl(void)
+{
+	register_sysctl_init("kernel", kmod_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_kmod_sysctl);
+#endif
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9b4f0cff76eaddc823065ea587760156576a8686..473133d9651eac4ef44b8b63a44b77189818ac08 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -19,7 +19,6 @@
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
  */
 
-#include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
 #include <linux/printk.h>
@@ -1616,25 +1615,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_MODULES
-	{
-		.procname	= "modprobe",
-		.data		= &modprobe_path,
-		.maxlen		= KMOD_PATH_LEN,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
-	{
-		.procname	= "modules_disabled",
-		.data		= &modules_disabled,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		/* only handle a transition from default "0" to "1" */
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_UEVENT_HELPER
 	{
 		.procname	= "hotplug",

-- 
2.47.2



