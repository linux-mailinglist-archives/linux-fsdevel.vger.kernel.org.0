Return-Path: <linux-fsdevel+bounces-7377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9B1824469
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4637CB23A37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC724A1E;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJosMr+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A162377E;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92CFCC4AF5D;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380565;
	bh=rztlto8eEbJ+Snp+e1X4/9BzW9/7AlNu0SuQr3dKr6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rJosMr+ehRG/C2guKa2lmEkTDfQWd5W3U8g4xdyzMBtPGAGdQ7oygvRVw4wbnDsZu
	 JNrnyz6Dj4Gu6JGXLwUspUakqNyqgz9W4Ccv12H6B3OKBRctIO+0f78d3X1j1i3lNw
	 WCr2OvgIh036faAKWZ194es1Mutt698yFao/RVeMwiIxmMGbdf952Fh8w6Evj4KPVO
	 lTuJ9dFErNeMw0BNsU2RTSwEJrCwh6XpmUOuTS2ckb1FFr5SRuwceBkM+5dgxuIc3V
	 I0fOOcrPU/9c14wJHoAkkwvdcYpasKSPKgRwvVDBE7rWPyhe/lPWCee6EcPHfT/ytf
	 VQJg3rP96OqHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F24C47079;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:26 +0100
Subject: [PATCH v2 05/10] seccomp: Remove the now superfluous sentinel
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
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-5-836cc04e00ec@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=z6EeWSeb/wAILeyqvWIX8FMlRbwGB4xwjlfltNsIiys=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiQF0oBNt6LJkb+zVY5GGJCeSKg2G1eOlNY/
 U9hMugX/3qJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkAAKCRC6l81St5ZB
 T7e6DACU+v+qIRdOgR0Vmu/bybMMTZLCFfSEqP2vKHZSh37Ah76SyGQpohwFYIlyBeOBBnPNVyJ
 w8p0UWOfIBTtC+RGTtt2n0ijQHCmzEUBwd2OS+8KyEGACtGvfQ/HTz0ohTLF+dkeSuN36ne0Pc/
 5e7X+WCLZT9/SrcD0xsDhmm1eBnRUVHbBwQVfRVipKlX1xm3KrnZmSfeC5RrFvx0C5HJrJeJ/lA
 /hKTvsd4Lz3IMWylzkkAgqXGSjXjftqgJUEkAHGjptsRIAFAOuOvPq/UN6RctFRocbfHGq4y2is
 jGLLoDYRoLk43HuSXfJlB2y+a4pRp77W8ZH2uzwJkinqJpEMfHIHKB4zlq/sXgYIpyt0m7FMEK+
 diaryq9MeBCXKGs6k1+XLcyj/vWSI1KAYrB2xLVuKd2dsT+dFwovPvTkPayLoVRQusHMPEWXJAg
 /b49Ubys+BjHCNculOLNQoH4Nm+SfvkyVDsf6IrMme51A2DKU3QkWmvfzwebLsO9PnjAE=
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

Remove sentinel element from seccomp_sysctl_table.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/seccomp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 255999ba9190..b727b4351c1b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -2445,7 +2445,6 @@ static struct ctl_table seccomp_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= seccomp_actions_logged_handler,
 	},
-	{ }
 };
 
 static int __init seccomp_sysctl_init(void)

-- 
2.30.2


