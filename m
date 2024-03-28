Return-Path: <linux-fsdevel+bounces-15535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576DB8903AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDEE1F25433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBED13173E;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th2X6ibv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835B712AAD3;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640657; cv=none; b=qUKV+gdXzS7HH2pePYDFBhx5xskps/wd5fe1dtin65q3ZA6DcxZe1wFBJz6itFA7rXAIB6r9jbVSkepH+zGUWzEmGjTwgBSeIiSzh3OdgQjJIu9dXPVy0nP0skJoB6ELvYu5EqIuN6zv/SVvQ4Hrl/T5zIGOUXR/SDvGHFJX8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640657; c=relaxed/simple;
	bh=V9eApfrx/luUPTr0ui9HIhkRp0aZQ7q1nffr8rRLCu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4hHOU3QGmL3ev0PxQ/w/ZItVei9zeM4LKp2c4tMBndCLQXhx2HtqNim/hCq4nyPiwJrXa6lLLZSE6sIbX/Q1AGg6CiAPtXVPHhMDanrmWyPQlNVPAXbP06yKeRvqy8fYIS+sdEuI9jf1o0vZ+Bpa1Gwo4pSJCB9UB01xbLiWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th2X6ibv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E039C43330;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=V9eApfrx/luUPTr0ui9HIhkRp0aZQ7q1nffr8rRLCu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Th2X6ibvVdQ+kgNVc65KbGnF7WOCx3uMpiu8utEkAUXEGRRyiJ3LbFumLPaz3pwRm
	 hcw4QdtEZZuBdny5UnP4IaNjE7dVBkQCCEdiObTSlwHmPC7kom1wsZymTk2r/jHMak
	 dncXWL3zaqzj7Qbr7PHgWpgppPhXFHvwYxZi1ZDQcjru8Hu65ql3UUvqT77YNsHI/e
	 Iw8CpuIG4z8NiKPFFQ5Bjt7RoAXs54ourHz77o36j2YkJUX5lMkxEX7NfG9IDOkTxm
	 CKkvDgPkYHnfHpKMepZQh9d5AmD8z4/9xbnYX+CBXGKyqJQMfByDIF2BwOcJV20P/+
	 35HeG/vANiIlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34012C54E64;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:04 +0100
Subject: [PATCH v3 03/10] ftrace: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-3-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=1araE0kn/61sWG3kWH8OhE3BK5Hy2HOuryBQQ689H28=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEpW98gjG1D2aFsgWF2O5xiJynGheSz82
 sXxRtohHqsNOIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBKAAoJELqXzVK3
 lkFPCzUL/0SG+3ODZAcC8VOhC+0GoOi4kE7faOWvyEi+zuJjGTMcwSwNf4IntNxUSlKxLruqmu/
 sXS4rISd6LajFHPlALx1lSwYZelfgle5kubkTKxbxuV4A4EpjxsYLKDFRoFS9tmt60X7MzNuPrv
 2ARWH2eTismjVuHNYgaovyHiC3/nZ7Eq0vltmN6f9/mtI49KNhKAy6wgXicwxtfN5J5aRPKDmKF
 +Crd6eRk4VyjwwB2aR2w++kmDsP6Cjnha4ho87e4AWqV/7W9HLnSNaPkAilDaK+ZwdYvCX/6rhb
 nSA1+bIMwy8cuyKK461nhWqG3gxm1jyfzvwyM3bhD6Z4yl22JmRQg2TxIPM6rEulBpeOGoNfhm8
 60+H0uxestVapnhLqg3gSUklk+b5Qv4YsJ9XowjlmPrCMKeLBtb6t8Wxpm+72Jba9Nba9Gyx7wB
 6nHOXmVGMy7L5w1LCv/2Im1SpQ9JngLB+Gni4XCGVVQhaq/cxpd2dV7EQKFfhCDOo17ZGL+oWK6
 +0=
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

Remove sentinel elements from ftrace_sysctls and user_event_sysctls

Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Acked-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/trace/ftrace.c            | 1 -
 kernel/trace/trace_events_user.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..6cec53aa45a6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8270,7 +8270,6 @@ static struct ctl_table ftrace_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = ftrace_enable_sysctl,
 	},
-	{}
 };
 
 static int __init ftrace_sysctl_init(void)
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 70d428c394b6..304ceed9fd7d 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2833,7 +2833,6 @@ static struct ctl_table user_event_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= set_max_user_events_sysctl,
 	},
-	{}
 };
 
 static int __init trace_events_user_init(void)

-- 
2.43.0



