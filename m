Return-Path: <linux-fsdevel+bounces-7380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6682447A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D193FB23B84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7598325547;
	Thu,  4 Jan 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5dFM2GT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72E2420C;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6A70C433CC;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=DvcxIFzA2XKWMKETjpH2TO0c5m9+WASjBlILvRYUVnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R5dFM2GTj0y/e0TfLXbOFis9tsZ8LdQf2psrDfsPoG3V0DKb4X/g0IWVNUcSwDUX6
	 gaFDoNqkdzd3GYjsponjmJ/d02IbSvnpnzmdvtPwXK37bmkHgSK4LX6ka7APrOJLlj
	 TPXIXaTE1YLT6Vaopl+3aWysNwm8mmBtCyXRnIY0Bb/VrSDGAKc4MbqvfIUkyDcm81
	 Mmre/vwyV7z1t76I2rbnRJSdMoZEk2fLnAu+ZT//0gb3OPplDUz+2P3IA0lwzGOfEr
	 bQGFEaZ7IQLgn9YpxRadyyVEF3uU+auA5WkMqKsL7h1HYxchQo6r9A2P5AZRrb1tP1
	 YEB8J2IWNyb7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A1C47074;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:27 +0100
Subject: [PATCH v2 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-6-836cc04e00ec@samsung.com>
References:
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
In-Reply-To:
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, 
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, 
 Eric Biederman <ebiederm@xmission.com>, Iurii Zaikin <yzaikin@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
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
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3002;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Xa7JcmuwlJTq/SA5ehycdcY7bcWSGAbQacdTyMWnUTk=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQbIczHWbA4zQWXlEme0igfFkoWIsxmXPBc
 CUCAXAJAquJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 T+sFC/4z8OHS2Jhpxg/muIoqFJFCx92BwSioQWQgxJqUOKKdgfweslcLr/dIkxHa1s1yhWlu79H
 FrbQZs7tWs4EeLTuz/0ucBuBUEL03XSk1slxTJzlU6Yxf5Wt6SnErVBEGmRMzqDz9HFfqizNRhm
 rKnkOIsjlFq5NmsVoISr4mL98mhBW3bTKRN/WwjS3esxVfzIjegH928NqKvvo6gyYsL+OLuas/J
 EK551LdSTfSpr7PdtnCxVUpvyLOJb94MJKLr9DzZhPlVRU3mO0LQLoBmJmyUkTWZAEQ1HEETxQx
 UzT+ncJf5C9wWRGEGhaRgXksWdblHKqBn7K+mufKwYWfB039x02ctFPeZY8Zc8E1HQxdrCsdKIc
 w+GFYqcrdOkoJwkm1waSCdCnHjc232iIKWr088ReNk4aSRknHtzf8v5K3yWaoyDMur8u8CZ/vuU
 K3OxAL4Yy0KSBRglb1nKHWv7LdlJZzQioOTDk8JpXzATWG6xbI4Y9g3UmcVRewIIsEgjc=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

rm sentinel element from ctl_table arrays

Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/sched/autogroup.c | 1 -
 kernel/sched/core.c      | 1 -
 kernel/sched/deadline.c  | 1 -
 kernel/sched/fair.c      | 1 -
 kernel/sched/rt.c        | 1 -
 kernel/sched/topology.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 991fc9002535..db68a964e34e 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -19,7 +19,6 @@ static struct ctl_table sched_autogroup_sysctls[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{}
 };
 
 static void __init sched_autogroup_sysctl_init(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..5631d0ec161b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4708,7 +4708,6 @@ static struct ctl_table sched_core_sysctls[] = {
 		.extra2		= SYSCTL_FOUR,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-	{}
 };
 static int __init sched_core_sysctl_init(void)
 {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..58cf9defc3b9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -43,7 +43,6 @@ static struct ctl_table sched_dl_sysctls[] = {
 		.proc_handler   = proc_douintvec_minmax,
 		.extra2         = (void *)&sysctl_sched_dl_period_max,
 	},
-	{}
 };
 
 static int __init sched_dl_sysctl_init(void)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..8f5f016ebc46 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -157,7 +157,6 @@ static struct ctl_table sched_fair_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-	{}
 };
 
 static int __init sched_fair_sysctl_init(void)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..350f4e8b3b2f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -56,7 +56,6 @@ static struct ctl_table sched_rt_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = sched_rr_handler,
 	},
-	{}
 };
 
 static int __init sched_rt_sysctl_init(void)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..e3a354173005 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -322,7 +322,6 @@ static struct ctl_table sched_energy_aware_sysctls[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init sched_energy_aware_sysctl_init(void)

-- 
2.30.2


