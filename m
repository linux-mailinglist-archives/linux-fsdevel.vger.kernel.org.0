Return-Path: <linux-fsdevel+bounces-48594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6FBAB1424
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F78B23A8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23C29345B;
	Fri,  9 May 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZos1YGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D862918CD;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=j3HXn1cSYExo8tchWQWcOCWuVdEsBtd4OSHyL2JFssgRxE+GxFVw6j5lYV4lw11DXt2CZVIOoZbRwmdq+ud6Am2QXWTz5DC1Vg3Vi0Lslid6Az6+qWvLrX3Ar3deEUUh5ZbqzptmSWGvpoiqQ0Mup4gdiW6U8RnEXO+AUf6Ot54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=g7LsXDd+j505V+MKQpG5RDYoahnYOKgJjZC/QSb5FNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uedX5XRsgk8EwMTgYNpkYceUrE8QZ14lgn7uq4l2VT/oIV2ptRhXyudu1zadDDkBzLLGWf+cViSOeyAr9W6O9l1WvOi0Y4AJ82JM10dXAC4VHg7fbD/782+lkqcAilXjjZPZLoRivBADscGAcD5VPhOeRXYhF9ojA2LvKDiaGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZos1YGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B7ABC116C6;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795306;
	bh=g7LsXDd+j505V+MKQpG5RDYoahnYOKgJjZC/QSb5FNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AZos1YGSXt9UXSVIeC+gyN74Etce15A3NaBIuLDesNCwSOo8s0bEHwUU7oROdtf0n
	 9HNQ7vhkC/1gkzBpfxg5tdCsy+6Z0fe9pgo5KGojPunL/cCbQ3ZcQ1EV9IsrZq0xBf
	 SlePsaI7NgcgmhNKzIKwKXu7QrWh9AdvBxtte1MF3wn7WUBxFU8La9kaKH60ytbnuN
	 R42jbaUt8pZVtpywz35pSPIf815RgDJ162w7DwLKl0+kvM2ZXGTLhV0uRRCXEJsajO
	 +OcahojoTwqT7CXL4rpDUKZBhR1lxB/BJSbelppvDVoglsfj1mBey7V0UdaDqXQ1T0
	 AHDQ5F/dS7JKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01925C3ABCC;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:10 +0200
Subject: [PATCH 06/12] fork: mv threads-max into kernel/fork.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-6-d0ad83f5f4c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=g7LsXDd+j505V+MKQpG5RDYoahnYOKgJjZC/QSb5FNw=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+yQ/uWK/HG1C61w82jo0nQJAkZrwNaRTQ
 Kzdwz6TUJcOyIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfskAAoJELqXzVK3
 lkFP5gcMAIFO2d6rVgT6EKcTmTnIIh5UBVX/xKxmcuUTXSbrkCQUFpfo23HIWCeg8lL9+/SmVc/
 wMQuryABzQbKLqJgYFC1QWq55hJcvP+tU2PTyZkeJC/OVtzsTZQ/ekzJOYDMD5OXR7RA7MNpiHw
 DWGtslYalBKnX4v/OZwXHpjwxW7ypE8DnYYz6VIp/aCFYqJydkFGyJZfbvlzKl+mHZoVO2Mrs4i
 SmNFu7CS2gpbq2cBPi1pnre4gHOjRveT+FIx/NZOc1ttqqym6PVJsSQpnUGcTJwXZbwHWsFGhbj
 4u9+eNLUJC4qoDTTYLnroNX83r/N6o5QnbPCBWjuV3fKNVL21qaJnCrONdHewkNLIcIBCc/7Ojb
 k12NIcmQoGPLGzmePG67PgJZq04KQsxm0xdPTiQAyBfhB5up3+XiLPdyLFmALcDrr286yquKuuc
 Rbpu1HJEE6D/X+MWIPZsfT0K9KaTNq1tWG/NTJIcpSunVpPbn0ioZqiTeHwnwZDJdA4QNjcWEC7
 d8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

make sysctl_max_threads static as it no longer needs to be exported into
sysctl.c.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h |  3 ---
 kernel/fork.c          | 20 +++++++++++++++++++-
 kernel/sysctl.c        |  7 -------
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ae762eabb7c9715e973356cadafbaaea3f20c7e9..30bcbc59d12d2f4cec7545e7ee3f5ea5f0eefbd7 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -284,7 +284,4 @@ static inline bool sysctl_is_alias(char *param)
 }
 #endif /* CONFIG_SYSCTL */
 
-int sysctl_max_threads(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
 #endif /* _LINUX_SYSCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b8e7b2b516e0bb0b1d4676ff644dc..ed39064b86c25849c4b21cf99ac68dded05038b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3470,7 +3470,7 @@ int unshare_files(void)
 	return 0;
 }
 
-int sysctl_max_threads(const struct ctl_table *table, int write,
+static int sysctl_max_threads(const struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -3492,3 +3492,21 @@ int sysctl_max_threads(const struct ctl_table *table, int write,
 
 	return 0;
 }
+
+static const struct ctl_table fork_sysctl_table[] = {
+	{
+		.procname	= "threads-max",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_max_threads,
+	},
+};
+
+static int __init init_fork_sysctl(void)
+{
+	register_sysctl_init("kernel", fork_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_fork_sysctl);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 718140251972b797f5aa5a056de40e8856805eed..febf328054aa5a7b2462a256598f86f5ded87c90 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1630,13 +1630,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_do_cad_pid,
 	},
 #endif
-	{
-		.procname	= "threads-max",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_max_threads,
-	},
 	{
 		.procname	= "overflowuid",
 		.data		= &overflowuid,

-- 
2.47.2



