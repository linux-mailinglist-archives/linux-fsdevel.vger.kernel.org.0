Return-Path: <linux-fsdevel+bounces-15538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64598903B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4727C1F25419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C613131BD3;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blI9ymBL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449012FF88;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640657; cv=none; b=iuaYlaTkKXIgm9KxbwoDjTdxXS9krzTpTi0alnhRET9r8EO2BE30ASoToeA17oieCoOeOo57YRSWX8J7Xx7ls0NzI/xG1rk797iBMUH6TbuW8FYAE6Pj17iX0oR7jH/glP2bj0GYcypWCyfrodOVzqT63PwDeRvCa1Kk/qy5FT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640657; c=relaxed/simple;
	bh=m54DIObMwh/oz5+MbWMsGWkY8mPKrW5ppEQGy+WuUHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuXRyhtecUSoPckY/CWN3oZew14d9WgwGSwZu8gRO1mWaA7r9rRbqtZFIDZqdTwGLwUjxsUZ33SW3DGFQCUdo5mSovuSDxETGSlqnkqntmtbRIkv5vlQ0ZC3tVD5YdZYrF7PC+YW+DVwqvpBfrA6JVts28DV5p/QB7cLWc1iTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blI9ymBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 570A2C4167E;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=m54DIObMwh/oz5+MbWMsGWkY8mPKrW5ppEQGy+WuUHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=blI9ymBLAdeCz65Zk6FER0mdzRf4BJX5XXCfQm+xq0oDX0Kles1Tm7BO2x0eLXc6E
	 z4WuXotOFLuPpzxm/EuKtkcq1sf4l66nOd86iQ1qLEwLo52/Hc3WHIvF9tXtiRuyp7
	 G4i19vbIOJQ+jyVwJlKqc/RO1Md83z0HjDJ7tUl9pr/pBTVMAE4TgEEjzimybB19N4
	 gHypPOB5fkcKfdZszZIBjD3OBf2+ALf0ZP/cZRQ8EbcIFG+7LxDp7N/+sJoR5MK7+O
	 e58AioddtRH0bcp6vOJ6wnT7zKVAmmb5R3vnMFMaWVsmDIRLI31K6qRhzBHNZg4+tL
	 nAVEZkfaeHUsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45913CD1288;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:05 +0100
Subject: [PATCH v3 04/10] timekeeping: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-4-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=lyDve8Ip2KotGee+CC44snEs+zn3osht1uA6DiUuFwM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEvKQgW+speYF787yYEHJDVSSH0tynerp
 0z73pdqmzw2W4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBLAAoJELqXzVK3
 lkFPUf0L/2YxDsRniEfrTN5jngDVulSOxiSB4qlNJo3EzgiFbMwGXq7qj0iTqrS6bzM/zQHQelM
 z6gGiMM/+yQqVBtt6i2wdHtGwRnjt/nOKL92syZf1XmUfb+DsmS3DsDC7HkhkySpWOEQLXPlh/Y
 vUKou/EVCej3uXWn3Sl9vZCixhu8HctQUpDljEkp3s/xydB+H6sl4c2TLRxDTAPYYbNP9MxMRxK
 LkPyLkmy7JCPkBw7vwDDId4ex2xU1aj5niZoIT3wH1FjULTg62tRugiLtaGtuoiqklfXBw7gc7q
 53t3OF7HpFn26CSo5aJ3mgJZ97lfhYYtS2ji1qpRV9QdPw8k1cgbwYjnMeZvLRecFt7EabhMVOg
 +mi6NtJgoTt0zZjsuM8IeSGvTk96fszBpJuSQMJeUv+k0PnWx3KTP0gZl6nQNSt0eTxRFAYy67P
 5Ugy64D77ah5RGxSUFzdEH9ayB60lVGT8bjRQn/Ix3kzI07osOgMD3M7f6SBTzAbLj7ghOBbLo6
 Ww=
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

Remove sentinel element from time_sysctl

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/time/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dee29f1f5b75..9d107f4b506c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -312,7 +312,6 @@ static struct ctl_table timer_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init timer_sysctl_init(void)

-- 
2.43.0



