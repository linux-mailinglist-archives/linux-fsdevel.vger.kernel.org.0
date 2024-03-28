Return-Path: <linux-fsdevel+bounces-15541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59CF8903C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A548B24728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57F136665;
	Thu, 28 Mar 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqIkT9A8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0E130AF5;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640658; cv=none; b=sn6qO61cMjwTH+LHTWQkpMbwN68TaJBeaU7xX2DDPnmmpy2SOJB7yHnqvvgZzV5b4JwFDbhbvsE8QZ8A/jAK2E+F/9Mk83Lh1eDe6ub7wkmJ/HKeCWLTGnDKTlsWKCTe/ho1L0fvy0lY8VHrumfc9oaXLOtPKlZdkIpvmtnMFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640658; c=relaxed/simple;
	bh=QsSLkxrYhUVqWpP8CUeoYlHeoCpNTEWsJfd/CbMZCLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhCR+cmz31rHwq6h/WxcUTfXstxGvB9VejVGIn2WjIq8oGEPs6R1VuVe/O42pu0S6fH67TbizfYFJuTEJIh0Pbe5URGqDIzHWyDbapFoomkKLW7MINiE05ecFvNVnBiF+pokL7/6FjOyTEAThHcHDdORJwySXmZbZTeAKoFqggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqIkT9A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D555BC32796;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=QsSLkxrYhUVqWpP8CUeoYlHeoCpNTEWsJfd/CbMZCLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bqIkT9A8miIjGRIsO5FxO6WM+mLxihwoAA8t78Xpnj9RD0KbfJ9WdYRma13L6ITC/
	 XaoGbHF847ihU1FcmetLZSvSXI02qe9Z0AF/oOUsMqpKBBSJYcZYyAY/71rYgf0JQu
	 EsO12QV5cI8vwYHomFbGv/kh0NuC7m5jaWuoxJVeEy2lObrLGIqVxwJlAqE1Hznb69
	 8a3NbeQjdODnhyuXC9a7KJv/DcFDoWC/BxwKx47EfmAorORXqEfE9QnUQkRRUHlB8J
	 t7ivo/j0FASUakZvLtG2XMITF3f8qD7Hcd1FSQzAH8TfR3zaCp5Jz5F0pGe2BUmdWB
	 DwQhlx/xjNwgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2ACD128A;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:10 +0100
Subject: [PATCH v3 09/10] delayacct: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-9-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=i6rZdV8sO6keniVz/tdr/tgncwQ879+rgbNywApATf4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkE6p4PaxshghascUKUubW96pCKfCYMXWK
 /aBSiIGgBYe9IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBOAAoJELqXzVK3
 lkFPT5QL/jFMK8C8aAUdHmCMTOc9tNhM631bX9/8b8lUvEasqWg0CLuygFHjzAxdGGUi6f2nMno
 kUA+T74QXcgNWEfjN8VdVP/NO4Hz21SVA+aCZP0vFbtKHAWBkHmYwmnWX0fPlkGMJCrUunVQyKT
 /67OzmNJMzHHhjA/5fn7WKriT/aSjVsfwMvG4vmTR6pFuRckh3PfzYN490bT09jtp1LM5eUpmG8
 v+ea5g4zkwWid2odf83OnRVh4vdoUz5SuApM5ocoFDK7fQ6gmTKXpn9+d22D/KNKyXUPTutUE6b
 B+0o078nrfEIiOgvo4renClDzc1apR/G+d1RNpqmV8CYDBGy1C/udE8mtdW8dL14nv07BW4TQ75
 7DrHQJXonF56KDikz3C/7owWHYyRwwWaSoa3lP3hankVdZGw4kpt1l5d4Zc7t/LBDUip5/4gAew
 VC1fPxiZoxYHw1Y5wWleWrZgF2lyeO69C7f9SD9OUdRUvMTemIC3m7QuHy3ZmGO6//TXewH9oV6
 tI=
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

Remove sentinel element from kern_delayacct_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/delayacct.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 6f0c358e73d8..e039b0f99a0b 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -74,7 +74,6 @@ static struct ctl_table kern_delayacct_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{ }
 };
 
 static __init int kernel_delayacct_sysctls_init(void)

-- 
2.43.0



