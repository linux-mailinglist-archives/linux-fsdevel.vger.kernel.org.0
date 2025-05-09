Return-Path: <linux-fsdevel+bounces-48595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1143AB141B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5518552366D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA27293479;
	Fri,  9 May 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn0hOIMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3062918C3;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=KFEydIKGyOvIwen0KdVh7rH27cK+dtpg+NznKVKtW/YO8+aEch9a+CZuHhzWlp6Br0rrx9cEfG6V4J9npNGAoPn3Wf5QvSV/8lL7+h9MWDw50waNCTb28llEZwPWrb2PcDcW6MUtBZR6+7jlHk9FWl/koWAUWjsUX0zQMD+6E3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=gjjnyJtn9rL7qDVpBI4IReueEE8EroNg5ir0HoyLtas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEOWKLTDH5OS2rMpcevydtnS8jdGl11FIrGC7b8aOxaNeVqM9qrIYrtrIIAMZjvadvYCQ5yv9LlwPi6NmotwuTe8cEzrmHPz9Qt2iXMabzH1PAnCZBT+xFRPysjODYRtVBNnrwo3jXm9nwIkR3ESXarrwqvXwd48a6C/PPikDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn0hOIMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C186C4CEF4;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795306;
	bh=gjjnyJtn9rL7qDVpBI4IReueEE8EroNg5ir0HoyLtas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mn0hOIMPYfURLIE/WU5fIJIHiX4VolQjVMoKxIu+HQh+eRbJ0wO6xyFasVQBiGp3V
	 r+G/1tGi48JdnzT7P0hyZ9iRrBHzJNYBIWfFe/GWR8/uyv7jOBFwT3Tx8o1Fjb+4G6
	 OXJ37leqMjgXp2DuhHPwXw/W3aObh5xytEzvoLxqueL0PG5RcOT0QQRa0xA2uc5V4Y
	 pKyCjqYW4O12XCx3YTcRIF9k5/gbftNa8Qfy7PWNxAqdSj1gtr4mXmwwek1oq5Q9im
	 7pcqPpfp4FfwrRpOOzYDG6McKp9VnCOXChrR8TypofBvL1es9qBz3zmo4hvlXqsL6o
	 /xP69WDnQiHvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129FC3ABCE;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:12 +0200
Subject: [PATCH 08/12] sysctl: Move tainted ctl_table into kernel/panic.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-8-d0ad83f5f4c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4205;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=gjjnyJtn9rL7qDVpBI4IReueEE8EroNg5ir0HoyLtas=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+yV+rDKiq8+9lr4zAKfpivTW+aC7pXl3I
 dS7Tq9JQnWA5IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfslAAoJELqXzVK3
 lkFPrtML/3uwnHJ/JqfBMu/TvpbR4B0zarBGmD92mSCnMHyEC7u8Ky4liTEmME4Yom6MK0K76zM
 F5bzJ+uVqLmQV+HJgQcmNDmvMjkm5m6fWZAN5ggfV8CmJjF0ZKVN0dst/maCll9WOoj16rl4a2k
 4IL6xjU9G+kxlwp6wT71cIKOgYEb9MizsBzW0ahDvcAS27PYeac8t6yFlHlXTAt8escrw26mY4A
 JNaiTbS0nnLhMIlBeIyuSChKqYpQdkapyKXTANQ5V8G+BgSDDrpuc1hDwdxKcDcQHafaaf7xiCN
 Syou4Df4mEoRHJ1Ex7TxMo7oTLSG0pK2uG9WpKOsi+was5ZsZeM266Vt+yB1DoKCIV706gib4v/
 cHV/muDGo03g44TLEzvCXRyc86It1dvhL8lLagWQnKf2EDlW4FlsuDOIGdL83Lgqqm0VU6QFVBj
 krHSMOvq/fVRVFS4Xwic4GTsb7c6SmKfeTSza9mr4IkOlHnPjfw/Iv1SKJ8hqMZ67YsPmK2Y4F6
 Mw=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the ctl_table with the "tainted" proc_name into kernel/panic.c.
With it moves the proc_tainted helper function.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/panic.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c | 49 -------------------------------------------------
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 047ea3215312c439950c6ec4674a91572146234d..213c6c9d6a750ff3d17f3cf530b37c619cd816f4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -84,6 +84,50 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 EXPORT_SYMBOL(panic_notifier_list);
 
 #ifdef CONFIG_SYSCTL
+
+/*
+ * Taint values can only be increased
+ * This means we can safely use a temporary.
+ */
+static int proc_taint(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	unsigned long tmptaint = get_taint();
+	int err;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &tmptaint;
+	err = proc_doulongvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+
+	if (write) {
+		int i;
+
+		/*
+		 * If we are relying on panic_on_taint not producing
+		 * false positives due to userspace input, bail out
+		 * before setting the requested taint flags.
+		 */
+		if (panic_on_taint_nousertaint && (tmptaint & panic_on_taint))
+			return -EINVAL;
+
+		/*
+		 * Poor man's atomic or. Not worth adding a primitive
+		 * to everyone's atomic.h for this
+		 */
+		for (i = 0; i < TAINT_FLAGS_COUNT; i++)
+			if ((1UL << i) & tmptaint)
+				add_taint(i, LOCKDEP_STILL_OK);
+	}
+
+	return err;
+}
+
 static const struct ctl_table kern_panic_table[] = {
 #ifdef CONFIG_SMP
 	{
@@ -96,6 +140,12 @@ static const struct ctl_table kern_panic_table[] = {
 		.extra2         = SYSCTL_ONE,
 	},
 #endif
+	{
+		.procname	= "tainted",
+		.maxlen		= sizeof(long),
+		.mode		= 0644,
+		.proc_handler	= proc_taint,
+	},
 	{
 		.procname	= "panic",
 		.data		= &panic_timeout,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ebcc7d75acd9fecbf3c10f31480c3cb6960cb53e..9d8db9cef11122993d850ab5c753e3da1cbfb5cc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -731,49 +731,6 @@ int proc_douintvec(const struct ctl_table *table, int write, void *buffer,
 				 do_proc_douintvec_conv, NULL);
 }
 
-/*
- * Taint values can only be increased
- * This means we can safely use a temporary.
- */
-static int proc_taint(const struct ctl_table *table, int write,
-			       void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table t;
-	unsigned long tmptaint = get_taint();
-	int err;
-
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	t = *table;
-	t.data = &tmptaint;
-	err = proc_doulongvec_minmax(&t, write, buffer, lenp, ppos);
-	if (err < 0)
-		return err;
-
-	if (write) {
-		int i;
-
-		/*
-		 * If we are relying on panic_on_taint not producing
-		 * false positives due to userspace input, bail out
-		 * before setting the requested taint flags.
-		 */
-		if (panic_on_taint_nousertaint && (tmptaint & panic_on_taint))
-			return -EINVAL;
-
-		/*
-		 * Poor man's atomic or. Not worth adding a primitive
-		 * to everyone's atomic.h for this
-		 */
-		for (i = 0; i < TAINT_FLAGS_COUNT; i++)
-			if ((1UL << i) & tmptaint)
-				add_taint(i, LOCKDEP_STILL_OK);
-	}
-
-	return err;
-}
-
 /**
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
  * @min: pointer to minimum allowable value
@@ -1557,12 +1514,6 @@ int proc_do_static_key(const struct ctl_table *table, int write,
 
 static const struct ctl_table kern_table[] = {
 #ifdef CONFIG_PROC_SYSCTL
-	{
-		.procname	= "tainted",
-		.maxlen 	= sizeof(long),
-		.mode		= 0644,
-		.proc_handler	= proc_taint,
-	},
 	{
 		.procname	= "sysctl_writes_strict",
 		.data		= &sysctl_writes_strict,

-- 
2.47.2



