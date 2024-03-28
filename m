Return-Path: <linux-fsdevel+bounces-15544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28C8903C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E14296809
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C665135A7E;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHjHtUB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F09130AF7;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640658; cv=none; b=tAHbxDhQoQa6TsjvCMuv28KJlFTrqjX5SFq8udDxDV4o8DAAbrIzZSt77jpUMsBzlCeaTDB3MkrSsXr7kOHyZa7Bf985V8XzLXm9SmZFUfJTqcsG+nR1Ccx3Vcg8xypKKHuC0MW1ZI2AfEicgX5lbCRnCJJPzmP9crqVqnN3IfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640658; c=relaxed/simple;
	bh=OXbTyJl1vxc5TRrI32eYdOeapjZ52ijf4K6v5tuEd7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=doYuGS1XFtYUQi9/AL02FSOsVi8H8HZiXUMMdVSgKmrdEWjB1aEi6vCEWZQ8K6WK/MDAhv1cTbGPEBFUmZYH89VaLU7/rZB9kjgSXKgXmWjnwpiPCfbRmMfnYUjkGO8im7/ZQylRV+Uz5Vx9xIVT7flcOj37EVSgOHZ5E+sIM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHjHtUB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0B07C43399;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=OXbTyJl1vxc5TRrI32eYdOeapjZ52ijf4K6v5tuEd7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PHjHtUB/CL+hgc6AU4LraLMdcpGt7+AWeVSexEK3/rodPd6YNAVXSjAkP+Yh76B0P
	 IacIso8zESjrg3Kdi8KPWUOQSzLQRr6F4vKVzeBuRGIheNyXslnvt3iPl0y55YC4Gm
	 OSDLdS9oazkN8/BcHrDPh1nfTkCFzQ0KFE07Jz4FGC46SaHJ6MvJe/AcmRIog3fAWQ
	 zuVe3SpvIITQN0ARO3msWdaPNLDjWoxDKiQcINA2rMETyEnzBNHi6e1CeBKWV+4p0o
	 fnVV1+na6klELlIxTqAu38AdcdcUZIHfC10oM349nj4lh3rH8MnqN+i2tfXzzVfYM4
	 zNvaFuZBBr3Uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A98CD1288;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:08 +0100
Subject: [PATCH v3 07/10] printk: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-7-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=918;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=dEvSs5Sk09Mr38w6TQjFck2BDsVi8Y4KzQNb8dQHQ2k=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE1nrrtIzi/mbTRBEt4ncdh/MX4YK+/zN
 V1PrbBTKAfDkokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBNAAoJELqXzVK3
 lkFPNWsL/3Vy959WXECEg0VHaMhwRrdeyk3YtyYiGM7YxZsqt43CPCmlwvOEGQSSNRe1pS5OSMs
 as4xeTTv4VMjZ8J2nmraoc0S/8dF5jnJUIt36P+mLuUuANd4o6Vj5TtZACS2XscOBqTR1cAn5fW
 fMOpEQ1Qibjc3TKzJa4nWCI1s2sQZdd5pmM6Z6bTS6xkoEC0M+mOj3xt/S+8Xt4QCjBqSZsXkMR
 7Er9xP7PA6naseg7YghqEaY5h/1ELMr+jA+csTHCkKXTtwzySlij4bwqhgZQz1iLXfik70NXeeQ
 Stj2pa/YCAGbF9OIHb6NTcbeiwGBweGC2BsLkn9+pE0Gh+OmOfGbkApG5e9Ugcf8deJxVCBIPGN
 pJXIl3EVZHAKah/Gw2pcPZJsStYJ23zXwRNG5yc8db2L2ivpaMfUlVk8Hj8MN/nJ47F8MFJVlp0
 VMmcsLlYqBx/9NDO/CcWbF6+c2zvD5PSszPypQOR7kOGo6DboCX7ux3FMIrrDqgjTGoEtK6hqh5
 +4=
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
2.43.0



