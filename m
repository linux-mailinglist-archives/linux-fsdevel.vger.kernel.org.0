Return-Path: <linux-fsdevel+bounces-2236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D07C7E409E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E371C20C8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBBE31583;
	Tue,  7 Nov 2023 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db8UkwCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245630CEF;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EBB0C433BB;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=ObpMazyJAc9ynk+EHag+YrlsvY0hIfWuMvTMCmZzkQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=db8UkwCtxkR0AVCzsfl4QwWzaeRpAHGVpQvU5Hf45+XEMRCFzcLhqOvilLqRxwFMA
	 5R7SnhOf7i6GwLiOys7agJ64LYdSMdqju5l3ROwZKqm+g9X0n/RE1k44rJwEaM298J
	 2hfDSbkTO1tkHZ/6K4md4a3fYyjeC10vxlQtRsjgeImUbdJ7pc67qLvz7IA3a/HuZq
	 5YajAE4SOlewLtSJL5olwX/9nSnxQcLleDxXnlzt6fCBWzAwDSSQB54WhgAo//ji9p
	 nAbH54C+TCexSiZ2xI8HpwtC34d4yIlGhdJTKlqr4o9Nlg5r28SUrMqEIEwS5ob4Yl
	 iIVigfhSlEcMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795BC4332F;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:03 +0100
Subject: [PATCH 03/10] ftrace: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-3-e4ce1388dfa0@samsung.com>
References:
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
In-Reply-To:
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=d6hPZmC0K0IZzUwuA4aA7VK86RM6Vm7GkvrWR105S0E=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9lKwF0fwW5XohsA5vvIrvTl6CihI1Q3EeNJ
 1+nbY0Q/K6JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZQAKCRC6l81St5ZB
 T4lYC/95wZ4kifDVujQZe0FCBvIwJyiKps3QZSfbJ79+rERGzcohQ++TiJw7ZyOi4hRzK3EiPYT
 p+cbzWPvvvihGq/oGOA6EGSIuQg2p3Xrsx5XSvuQnML8O1+wEkgiPWaeI+SWN8l0aDN6IMNZZcb
 txsFxM+IQTvCL9BBs8oOU3y3/8/7X1e/GJ90E/roVtTI4pE3VOQRy4s07Ah8WsFaMvWaCna70kW
 DQxvwXFmfeaC2b3bcM4fh4evrnw0Uf9NIRk2HepfG4qOq/hTywIPExdzlmdkpkoXGETgrkkFJte
 J/WDVMw1D4UcPI/MYKMQc81OCVnJh3AXc1BVRExO8OPH9h+Z5QSwlyXwhSmQoHpldVT21rZTevU
 cFVhJwUOeZ1xQlPvOXycjFtpOw6YTqXqgRGJfdogL25Z3X82bdmsnjSln7B2J013ZounxTYi0Hu
 Rt53vLQUCKnZKYnj1S4BsunkR9corlfOEoO5q/qU+hjvcNxWDIS8SOD/tdD5DS95+9lTQ=
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

Remove sentinel elements from ftrace_sysctls and user_event_sysctls

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/trace/ftrace.c            | 1 -
 kernel/trace/trace_events_user.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..fd40d02a23c7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8264,7 +8264,6 @@ static struct ctl_table ftrace_sysctls[] = {
 		.mode           = 0644,
 		.proc_handler   = ftrace_enable_sysctl,
 	},
-	{}
 };
 
 static int __init ftrace_sysctl_init(void)
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 6f046650e527..bef1bdc62acf 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2694,7 +2694,6 @@ static struct ctl_table user_event_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= set_max_user_events_sysctl,
 	},
-	{}
 };
 
 static int __init trace_events_user_init(void)

-- 
2.30.2


