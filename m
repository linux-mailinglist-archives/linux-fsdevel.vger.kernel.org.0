Return-Path: <linux-fsdevel+bounces-15537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB88903B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832F51C2E2EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E788131753;
	Thu, 28 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuJ3G6+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBD12F360;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640657; cv=none; b=n6ZRGIRXQ2t5qLRbrUvdkOX6EBtTWlVxxtyBA3aFO/ZDc00/al99KM3SRfhkHUw/sfJkrgNeaBgqh4f7bvw8jtvohHcEJ9HRmPdZL9hpsXCnM2GeUZrnb07jFddaTro0+20WFG80jNi7Gxjq7SvaljLGcZhJpSTOkcsqv53dMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640657; c=relaxed/simple;
	bh=b4/dj6SehevGFMXDVnAFfclsIoj8TxLZ3oIJqymWnsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTgyZU4LHBesijwFmu3NGSW8V1PKi8bH9UJ0gPZ+ud+gi/Cs9V0W7kfJalcFN/nwWA8QEN90iwWbdBawUhiYTajLv3/cxNGIal4heky6jWftIjBuOjNU8SzeEVtKrk1A1rTUplRcO0U/YnuH1XFb8EmfhVCue7mYcfSpDYGX8Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuJ3G6+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 323F1C43390;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640657;
	bh=b4/dj6SehevGFMXDVnAFfclsIoj8TxLZ3oIJqymWnsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fuJ3G6+oLkrT+l9nrSjFcpYUg/kDqfa2cFXvmbfSHDXZf9E7Adrk6HFRgV3XcR/M+
	 eNDCw7OSJI5AjnfJX5kt8EQev8Ikj14zHQRaRWc54CD3JQsdcmKXVj51nOlIYXnLRU
	 l3EDWjZTVFnEOA2vLjFhGX3cOrqQj+lkZ9VYwmVy4Gwi+bAVvRyyWnWFrP8yQqF+nl
	 iw9v68QEsS4zwpif5Qd679ElBRqIs8LHPa8CACnVouk6qf0YaQt+e+EpEMcq0tm2eS
	 dirMaphuDGRLsK1gXJN1h9NAAZwNJ3ar7bqXgvEhC1xUp6LJP5ydXPVeD61QsFvEph
	 ME46HcDI8o1pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26ACD1284;
	Thu, 28 Mar 2024 15:44:17 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:44:03 +0100
Subject: [PATCH v3 02/10] umh: Remove the now superfluous sentinel elements
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-2-285d273912fe@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Us+pauVKvQYKYTVROgr9cx41Gi3l/GyUdGrp/t6hxLg=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFkEo0dt9WmTAEh/wL1ITZW04WdbDyjokxC
 /hAdi1zrFkFlYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBZBKAAoJELqXzVK3
 lkFP2wIL/AjBsBaPYsbMjtmBVzxSkZWgD9fmjt+7K/jC87ZalaRJ0c3/FNzw5+SffsVLuX3Umam
 qKZ2njDL6pcTXXADXT5KEOxekjS+VwD7aR6CJh4cHUg5O6GyMAIETih91ek5+2/9mWQCVDry7kH
 kxcCeiGmcFIVWBXiHZ/HkD2Qp55C6O2o5NhW7nAORb1gKInoZLg2k5A0BBvWCC/2mU7ikg5WAXL
 YuvDzOUjNHNeCpU7+wJkuwEBCYoT7Xo6hdaf0o1eagGogaqyMysQMr5D8EDnXT2PFeI0Hu/9PSQ
 Cxt4kXwJrO2c4tNcUXHBR2pFGXdGVcUsdiwbsmjSNKzKwl9bQawr/Fhjq+0KeqC6Y3Eiyp4t3Dn
 u1VvIKLTGvrLixdIraVdZaIyMDH6GbhfbdXQ7B3FdTm1m3+pOYvPIod+FuhsP1OYlFjlbKksK3Y
 fbHNyShkqi5Eok7GgWo8ptBSsCWGjC962+XAMX9rnbtFs+1sECVQMEMVVNxt1y2KGGDYgldIqC5
 RQ=
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

Remove sentinel element from usermodehelper_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/umh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 1b13c5d34624..598b3ffe1522 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -560,7 +560,6 @@ static struct ctl_table usermodehelper_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_cap_handler,
 	},
-	{ }
 };
 
 static int __init init_umh_sysctls(void)

-- 
2.43.0



