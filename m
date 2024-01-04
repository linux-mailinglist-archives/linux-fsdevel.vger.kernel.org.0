Return-Path: <linux-fsdevel+bounces-7375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 177BB824465
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17278B24964
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA6249FD;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIsXFBB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A62376C;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78ED9C433BC;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=76OiXqny0I5FAtIEkgtQeFpTLfwhsiR4xIiHIe8GjjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LIsXFBB97dNIR6T+s1NkUbkQvnDWu7qABrhOgeDu4bURrQDFmDdugT/qe4EalTSXu
	 foMcISTUIzWUV2FsxqWR1/HcpEplm7HfB+jUds0jiUTauTvG5IYtPr118enbkNy//L
	 LFf6v5RD0cdCDG0ufbeqK6gWoIeRVvS6QyOrGCw4R2mCGoy47FNkMz6gYhS/b5Y0+m
	 ot3EoYiVFIL2qudYErJyOEgzNfmRAlUAf56EQItn48xgKhPwmtpZMwfJqoM5DKXJVz
	 IscBJDMf7i7nUO0yXPINQmK3xz6AsF9cQGM42mn9cyRbQcJDA5xeoloOVlLR8npHNG
	 jTTgU6jxW/t6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F230C47073;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:25 +0100
Subject: [PATCH v2 04/10] timekeeping: Remove the now superfluous sentinel
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
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-4-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=rOgjyk+y2sTTf7UpdfCg7T7N07f0Drf2bm8cuUCjmf0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQeefs10L9U9C6E9ObjWbvyDIljOI9DQ+SH
 mJVo12IrSyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 T7OtDACWjrpqcR5DbGc48ai3Fu0II5BMzsCkwdkvgpsLPPoXZJd8Skx95KGSKIeQnsNc11MPKkq
 L1YS1lrX1fMo+5Vs8mHNUwYne2u3EDkcY+jaVW68W6LhkpYNrhlh/9+3S/5Q1T7y7v4o4PQqUHS
 4h4ybQ/0wIK3nsbGeZWFsccqSN66LDB/3YFHZraXHOEugCtIz8c4L1GnRaVfg8qKTPaGGmzbPxi
 jXEE1jiI4BgsFViTAbgHKntquCgG19U5eFsXfIoKre11wGggdq8JT9UidiPajbH6E2FI/JIUQxv
 6EfjtOoF8+BTsnLuSPSN2Og7sGF+M5WFX0rRKGautby6LT9Kf2f2x03U4Sdiou6vV7fyVniWVVe
 Va8vDlewMZo+ksIJl1jrxvBc9dTEJwaNpIh4KLjFAQkQBb2fIW/YkUSXRo6ZuRSgFBEzYVgVM41
 pcpVje8m1dgYFE0mTmV5L0MChWeCvmR89eUA8+W82cRb5gFlFO3QmHkXVUPdbPI70btPI=
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

Remove sentinel element from time_sysctl

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/time/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..475826ad78df 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -260,7 +260,6 @@ static struct ctl_table timer_sysctl[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init timer_sysctl_init(void)

-- 
2.30.2


