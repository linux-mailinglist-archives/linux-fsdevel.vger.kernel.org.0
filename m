Return-Path: <linux-fsdevel+bounces-7381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2AF824477
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02FF1F27067
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8F2511F;
	Thu,  4 Jan 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDY6pdYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF92420D;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCC91C116B3;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=2YZbvYyt0a7TBx89a/LXKdhtP/fd+epxuxNolaWdMk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DDY6pdYIRGuy/IqX3neDbTH5fLNvqXdNxzXiXjZI0ESY2XeKYIpyJyRyri9uNHeCZ
	 S9QoGKTTb9cySRS8FvOJMwpEv4t7MHsKcBToHC1Kt1A4M1jX6JJl8Reo5fV36HlAcs
	 Ex5LTPmId7JuXPLrmpmKld8/mFFDteGQVZFIGBb3CWqA4Ev/e3Dw+s7YpyLAsspfze
	 eqQqBzy+C2puiszzKCVHYdJ+VAihA18L6y9/UQiC5ww2XbGPmAWU8Feug/5Cw0mRNb
	 YLY5HoY9sedUmx4VJ0gTBvjYmczjofc2C9Xtg+Z057yjlo5UfoWAkEkaoUFvByjeku
	 aTlpSLQyUpsQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D9CC47073;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:28 +0100
Subject: [PATCH v2 07/10] printk: Remove the now superfluous sentinel
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
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-7-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=0RIXHtz2qk2L/BtCOsMTqHqgTDQk5qxNwP6u/9nvwkg=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiRP58+mgIl1Ljw8f0Tp729I8/loQ4fDbu14
 K2lkSCYZECJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkQAKCRC6l81St5ZB
 TwAeC/9GoHY3KhH9zUZQZJiDaYIXsyY3oxjLSIE8BsKGUZ2BwE82BWnnEF3foe8KPS2FRq1GsXX
 PJgzxRPEa4Tnr6JXWq7bA/T3CcdQz3EeaJdvnP66CS5wr5hQ1F7zl0K098VXOj2ooZUbfM1xyt9
 pi1uM2q/Arm/dH3D4FjNorf+rGPaSCIYbVDdNcKCC2Le9uGj94EWXvpM/YUTRmOLIG1cTPXnY45
 dlRCCSzpsC7sVPhG1Uf/qia7QsQHGDqKJHLYy73JJ9pOg+TgL1xH2EXRVXEPkyl9MRT0woRCgHG
 /SEZ356lVGqKjmG/GK0ox+1rTKYYkPT2KHpRPcvUXZWML/jHY9bimbi754rX5/sNiJMY1S6rJuw
 ebltqt9IFrvbVS9kwrHQfoi2oqS8wTxb1r2HWGwzj9x35MN8cX2ABbJspICnuqHot5tZuFGbnkn
 8kSe7/H2N2fneoP2+DtJGcowYqW2alz+q/q1vg7Ilu7t0eRY81/M9ik0oPwi49Une54ME=
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

rm sentinel element from printk_sysctls

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/printk/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..3e47dedce9e5 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -76,7 +76,6 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-	{}
 };
 
 void __init printk_sysctl_init(void)

-- 
2.30.2


