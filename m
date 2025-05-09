Return-Path: <linux-fsdevel+bounces-48597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBBAB1429
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D9B9E7AD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43E29347F;
	Fri,  9 May 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRKl3dU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E422918CE;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795306; cv=none; b=DiT4ETivU8j4n8HyxS12+vfhNZsXo8ipepxyt1SkNkreX+Zxx5QljT9Z+LIJzKh2N6Abclg58QCn1gaTkjRz3MbDBmT/zaUaDrPJVvLGfK3BGucbBm2P9gw2i5vkurF6DISeBzzib8E9sX4f0Ms5a/YvJWNnm1cYhQr6N9uHEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795306; c=relaxed/simple;
	bh=P7vQ+Tbjp/K5t8P7w4RO0B3Yk38DBPiFR2QdU7/KqCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGHV4s7KWZsC5l45/o49blBIZTYg8PorZRx1hkOavzZX9P5uX0f49uwVB+1eeBqs6XQ9sfLDd7hzVISBBWwI543WiJ5Igi3cc7PU8BDg3NzF67lP/Mx05AnhBPjNjdw7G9Kix3hA/0RyVNPZo1Mq2K6TwFo8/xMzjxEXYr/D8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRKl3dU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A7DBC16AAE;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795306;
	bh=P7vQ+Tbjp/K5t8P7w4RO0B3Yk38DBPiFR2QdU7/KqCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TRKl3dU8E4j3qi3UUIM0MKpI/5kJ/jlA1ev2GjKCGCfQHqLwLyqQDTdgCPB3aFh7l
	 hC/JjbWPSu5+MMz/1wxZai5N5qzRr25eTv9ZCWiEaO5ocpFBmzqq19W/cPxGgEm3KK
	 +KNVkbVfR1Dhv6gyuWhb4jJTBgA8huIrDRQTWj0QPZ35UchczKQC52ur+FngEMdxm/
	 wV/dhFBVzl3lQ/L5essicf116ufeSBmnM9I8oFcZzGZjvm9lqsXxSK8HdHFabu+6ya
	 A8hqgTjqqoElObHwJVrQKTqJ1hBbiweZzK+fwdx3fbxasbvgGpAVX/Y2H0OH4OutWQ
	 IPugJiowoiQLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BCC3ABCD;
	Fri,  9 May 2025 12:55:06 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 09 May 2025 14:54:11 +0200
Subject: [PATCH 07/12] Input: sysrq: mv sysrq into drivers/tty/sysrq.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-jag-mv_ctltables_iter2-v1-7-d0ad83f5f4c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3323;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=P7vQ+Tbjp/K5t8P7w4RO0B3Yk38DBPiFR2QdU7/KqCY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGgd+ySeocfEnB6M/redE7f06E8yJNij/bs4P
 Rn9SWPKQMpjjIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoHfskAAoJELqXzVK3
 lkFP+aoL/0WNslAOaswPGE5r9au3d1aOofO6PbnFn0JoryOXftHrBATNDqzcfPhWQTSSk3KcENt
 l2U9RK8OuosgPWWDQQQLsj6dS2MAwN05l65/fMWikpZqyo/v1X4hnCATduh0RNJ/wEUMIiJcXaQ
 kiDpwosoj1mz1uSqSNnnl3d2VyVXLpYlcdAGVd2aX2PFeY9f0Iwe9eiCOy9gZ3iBoPfrabixgAM
 PZMJB0WSDMI39Xqi8sPvisswxkpUcNnU+L7wWOPXB8F0ebq2UlR5vneGEZVbuRhkkxWpbxOubSJ
 OnUhCPMT6TWkOlPwQqPYhkNK/+rEHHj4hlkuPC3LeEDDO4gf3mFROpz7TeQgx1V+7LqDISlevnU
 5k6X+ntypxbBCYvuz9BTBL+Xj/tionGXzm6FNmHQ88PwsZTHPePdH+euWB38xxpR+J/7Ckda28a
 Mh/Zjusu6Dy6uenAJDr51bG9S/UkB6VEUeHTpw7luFEHmw3EmabRyGgoj2lko9Dk2tG3/7IjHp7
 m8=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move both sysrq ctl_table and supported sysrq_sysctl_handler helper
function into drivers/tty/sysrq.c. Replaced the __do_proc_dointvec in
helper function with do_proc_dointvec as the former is local to
kernel/sysctl.c.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/tty/sysrq.c | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c     | 30 ------------------------------
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6853c4660e7c2586487fea83c12f0b7780db1ee1..8a304189749f3e33af48141a1aba5e456616c7de 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -1119,6 +1119,44 @@ int sysrq_toggle_support(int enable_mask)
 }
 EXPORT_SYMBOL_GPL(sysrq_toggle_support);
 
+static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int tmp, ret;
+	struct ctl_table t = *table;
+
+	tmp = sysrq_mask();
+	t.data = &tmp;
+
+	ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+
+	if (ret || !write)
+		return ret;
+
+	if (write)
+		sysrq_toggle_support(tmp);
+
+	return 0;
+}
+
+static const struct ctl_table sysrq_sysctl_table[] = {
+	{
+		.procname	= "sysrq",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= sysrq_sysctl_handler,
+	},
+};
+
+static int __init init_sysrq_sysctl(void)
+{
+	register_sysctl_init("kernel", sysrq_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_sysrq_sysctl);
+
 static int __sysrq_swap_key_ops(u8 key, const struct sysrq_key_op *insert_op_p,
 				const struct sysrq_key_op *remove_op_p)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index febf328054aa5a7b2462a256598f86f5ded87c90..ebcc7d75acd9fecbf3c10f31480c3cb6960cb53e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -31,7 +31,6 @@
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/net.h>
-#include <linux/sysrq.h>
 #include <linux/highuid.h>
 #include <linux/writeback.h>
 #include <linux/ratelimit.h>
@@ -964,26 +963,6 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 }
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
-#ifdef CONFIG_MAGIC_SYSRQ
-static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int tmp, ret;
-
-	tmp = sysrq_mask();
-
-	ret = __do_proc_dointvec(&tmp, table, write, buffer,
-			       lenp, ppos, NULL, NULL);
-	if (ret || !write)
-		return ret;
-
-	if (write)
-		sysrq_toggle_support(tmp);
-
-	return 0;
-}
-#endif
-
 static int __do_proc_doulongvec_minmax(void *data,
 		const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos,
@@ -1612,15 +1591,6 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dostring,
 	},
 #endif
-#ifdef CONFIG_MAGIC_SYSRQ
-	{
-		.procname	= "sysrq",
-		.data		= NULL,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= sysrq_sysctl_handler,
-	},
-#endif
 #ifdef CONFIG_PROC_SYSCTL
 	{
 		.procname	= "cad_pid",

-- 
2.47.2



