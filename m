Return-Path: <linux-fsdevel+bounces-15543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BE8903C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B04B246CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC113664E;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKPD2wS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AE131196;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640658; cv=none; b=ndUoJKcSEJokfXulbLSRTqnv07K2gP+A8efoowq4yvpGSmVd7EQV+ZXtHLtHzJB43K7MpfpgWPMveSd6sRd72eMEVvzCmJ3fVKvvMq7esOQ440SdIfMlzIQs3itvA6qLn91xj26wYKEVwmePrrO5I4lLNxtXabEt//stQRUx37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640658; c=relaxed/simple;
	bh=MHDLw01aV7Y2y8q4FVOlVqqv1r/NUfwe173AEwvrpiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHR2dbKUbXV6N46pxQ10qkeZ29wNxut0Kdg5uB1ZB+5U+AdakjwpbRg7lNpiQcbcM8pITUYXqiT1r//ra0axPYYfSJE+KfUQgd0o7QEHD3/qJBLkjh9OBcxuyk1D+ydqORZ7gYvndoeayrviOSjcNRE/OBwdsAFTO3hPLYqH/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKPD2wS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06321C4E66A;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640658;
	bh=MHDLw01aV7Y2y8q4FVOlVqqv1r/NUfwe173AEwvrpiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dKPD2wS418NUIbqJZhZ08bU1j9gcAOSF+5V8WUweINfFYLrG796kBAdHGPno8ouFE
	 cfg24Z9mXJ4mMIMNgO8ptj6Bs31eL4WdrAlLq79VvMQkyDbGokebYEivh6+U7hgz+O
	 lIgOraJK97jRcAkwbE0TQg2/DZ5tmtDQIYiutkDEgAGumoSAunQQsm0kNazW6mIHCu
	 Qyn78HeyB3+aN6GcZbukSEEdRLmtZnjTx82OpkUxA0Bnzf+amJOOL7QEeZX23WU0dK
	 llOxfI/qQ3r3tmo4wOcYVa2SqwdBtA4BPLXM5Jm2hxMKM0AI85vAEBwc6teCx4TZR3
	 9goN7McNdwdsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1065CD1284;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:11 +0100
Subject: [PATCH v3 10/10] bpf: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-10-285d273912fe@samsung.com>
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, 
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
 Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
 Daniel Bristot de Oliveira <bristot@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=EHedMAAx8mJbivlU9QHUO7qJGc32TBFT3ByM4xDoG9I=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE408xMhw90vhF81FOWcLfCE8LWhQfflT
 61/EIF6yCrZ3okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBOAAoJELqXzVK3
 lkFPfZQL/3zdbAgEIU2dcwe2erodBotsa3e1HOBR1lR9Kv1mef/Eai0SkALWcSc5dDfORlh8Bpq
 PH8ootjUW/DunAVLKXTQn4VMu6CLt820UZOwAAUShG8wiPlD4fPaiCI3bJT2Gmei+/UblaMVCdT
 7zSXlcmiXsNQpLq8wzHqy1pX7aghk8yJqVPHjwRh/RQdcVvFeabeB6ftt/HC5jB4xRGKOC2oRuT
 t1YyA9E3vlnRld0l3Uz4poLLs6b+/Hl1CYRdcR90Vamvfh2vrhHNkhSZalYTcUe6Zt35Kda6JmY
 h+Bn9Q93xvC9r8Ehl48JR/4OnKrelkTK5nibpYdaTr+qdGNmJMIlGTaIfwjxFPnT9wQwxHgSore
 qY5gbsjMkHcpBf/cSrodl7fYS+2m8r1N6uxoFO+qx6jK8BEHEkPUSly2nhgOStdKvBxcMqJo15Y
 /UHtNHyB50pyHMxZlSDGfg/qGcL5XYwLqrGyHpObIk+F5IXwU2yUuRmWXIZcFjiMMdWAeEM4C85
 rE=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel element from bpf_syscall_table.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ae2ff73bde7e..c7e805087b06 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5979,7 +5979,6 @@ static struct ctl_table bpf_syscall_table[] = {
 		.mode		= 0644,
 		.proc_handler	= bpf_stats_handler,
 	},
-	{ }
 };
 
 static int __init bpf_syscall_sysctl_init(void)

-- 
2.43.0



