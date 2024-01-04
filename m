Return-Path: <linux-fsdevel+bounces-7378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC54F824474
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5440F287C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B4250FF;
	Thu,  4 Jan 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAp4wTIS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19624204;
	Thu,  4 Jan 2024 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E38F5C4339A;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704380566;
	bh=hlpr7Rh+WCSWMT4vZxE5w8t1/XHYkmxcty9BVrgA5A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UAp4wTISxqEeHyNEIjRiawNX/l+jcpNqpcCxfYCi/uyU6IpNgqfxDEPdXp8jQAPTE
	 rXiYkApR4Ein2T0t660Tdj94d+UCiO2acXlwYbybyM6K3TllUro6YsWElcBkP/xWV3
	 pkCrArgmNm6HKQR839uwOOY/10AOmGfdLpUlAfxZocE6kAqaits9ONytq+bV1rAvaS
	 Gr4DhA6wptyBsiklIax2dzI2lTyfNPQ7zNZOw64eMKy3GwGrorYldRSVwUrutAwy8i
	 ITR6FKGdNa67spj3UFTuMbRbp3CFHszYot/VKygldUe4+2kPFb7fZ1D54re89YcsiZ
	 t0kJYZsqtPEMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB0C47074;
	Thu,  4 Jan 2024 15:02:45 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 04 Jan 2024 16:02:29 +0100
Subject: [PATCH v2 08/10] kprobes: Remove the now superfluous sentinel
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
 <20240104-jag-sysctl_remove_empty_elem_kernel-v2-8-836cc04e00ec@samsung.com>
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
 h=from:subject:message-id; bh=FiYzuIbbWeXBQHZeA3GrFUV/zI9p1hTad6YxElqrdyM=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBllsiRzlHx++7qX5DJLAjyT9FV57SLtpIJfK542
 Gd/fl1eMi2JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZZbIkQAKCRC6l81St5ZB
 T2v5C/9aZCwJBbBJFZCxSxXP12RwuKG4iNRsSt+9zCv6OMNW2X4kB43sueFjA4qzWwZnSovZeGg
 wQOvlrexE2JP73SoWmkYIAwxcbZaeHKZ9APA5fFKcA+C9pHJHuXxUy3CyCn4mcNyHNwAuMGmX02
 OAJ0EJhIPn/wnL2DziGAJxmUnEofZIElsAUyyb1UP3OmA1DkABVq4o24Ns6M1pZzk6EZMijmhiW
 AqCbdpycbAnHN6p8d2C9hdzknOznMMq0g3SKI3VcbGgWDIpXsFKeJujblUsj+sHhsFKDxx+41Ls
 pIgXKhdZWSxsHu84PjQ9xRBF+pgxfgHK7mRJmLRt1jctCQ6rs+FmqVT4QdVfNzbD8JvbdZnWv3k
 4clJTrKL/x5kAgVSbrsBWMD5TNk383518cCzwncVCZ9MAp20BaTLB5kSM4jw3NbR5RB8Wgb/Bh3
 b4MUj7eKVgRiW464WC5sJkDVqZh9v4b8JwcX50ez3xZdpcNbAyFCH8nz4Zs/a6X1N0QOE=
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

Remove sentinel element from kprobe_sysclts

Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a0ee40bf66..1e0ea688cf7f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -968,7 +968,6 @@ static struct ctl_table kprobe_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static void __init kprobe_sysctls_init(void)

-- 
2.30.2


