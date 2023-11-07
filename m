Return-Path: <linux-fsdevel+bounces-2241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE4C7E40B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE74B2147F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7FD31A77;
	Tue,  7 Nov 2023 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn3M4HvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78E30F83;
	Tue,  7 Nov 2023 13:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4443C433CC;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699364713;
	bh=HyioLOoDvEBlATC3oUAVjYFRl9dq5W388xrlI9Ieu7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dn3M4HvKkjtyOupwzP4sIZWAwCALy859slH0KnCgTN5CdSgpZKxWPkn65BoLsQney
	 tPXqoCp9skDVl9TUhpPRpkjdo5MN/0Xyj53pLAASHA1nC9PQBmOhKQqjxeYu9BYgiA
	 6nUK30sA/pZ3vS7RNg1f4xktLOjs5307/gWTlzX3w7JCsRYO4hK3smycruJy3P7KEg
	 Ce+rBE2YT9BI91Ii/uQIJuckQGFpKtb+xRT8lE7pbAtUJycz03QaBk89DLwsbOrd4n
	 UUqxwXA0WjStS21UQV1JXD8mYnCfATh3SJj7XH9xNpm49TTBO6U3ydmzsGz3/ZxYZI
	 On5wUPzNwdYlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C076FC4167D;
	Tue,  7 Nov 2023 13:45:13 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 07 Nov 2023 14:45:08 +0100
Subject: [PATCH 08/10] kprobes: Remove the now superfluous sentinel
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
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-8-e4ce1388dfa0@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=nWjRp5Vrg+ud1dRdeeTsGHswKVu3speo5CXD0Ie/3Hk=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9mTiQpxRe8y6VA8N5Bbiyy39SasyxFgAphe
 ZwWlNmkRsKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/ZgAKCRC6l81St5ZB
 T62EC/4159LGg/eYZHLJVsZ2/BLea8risszfgK97VlpM7eCImzw4TtFhVxNhEHusGqjuHcBH6RY
 1vZGowqSOZ1o8rEfFB1c/bruJOKWPnOG/M415s6KqNDj5uC+/nAh/HL0j6AfmVFf68tJnJxb2CZ
 JGX3gUezJ8yWN0RptnEkfPzi4Vx8oRsmhlNPTpH0LJDbWxRThzYJ8cqXWwN5r8z46p1HX6cX5sA
 Yj1uIQNEMZB1yP0rGNT5S9XDF2PmGnsYhshb6i3flRvhCk6B7tOxwW3j98FnAdQ5IooNThQBpiS
 rPyJ7dIh88osA++zi3/J/afB5X41ozKSvkWa5Bs3ADPt09HyC35Vo4UYsugNeCdRk9oIfy2CCUW
 1EYCVgoZrQcxKm8I0mFm+IGIhzrVCLUiplB7TW8z56HQNzL14aFqLXU7tZvfqKJDq/NQ7jC7vU7
 7Eur3LqdGoxAYbANkcrwRpIeJK2KdzsIAsyzEKZ1ClSQksjY6HO5BxjSGe5ODuZmNaaA4=
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

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 kernel/kprobes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0c6185aefaef..d049b602dd41 100644
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


