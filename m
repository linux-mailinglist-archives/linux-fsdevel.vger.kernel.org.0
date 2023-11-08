Return-Path: <linux-fsdevel+bounces-2405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E27E5B29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 17:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D611C20C68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568331A98;
	Wed,  8 Nov 2023 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB3D51D;
	Wed,  8 Nov 2023 16:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87BC433C8;
	Wed,  8 Nov 2023 16:27:19 +0000 (UTC)
Date: Wed, 8 Nov 2023 11:27:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: <j.granados@samsung.com>, Joel Granados via B4 Relay
 <devnull+j.granados.samsung.com@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, willy@infradead.org, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
 Zaikin <yzaikin@google.com>, Mark Rutland <mark.rutland@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
 <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 03/10] ftrace: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20231108112723.275ae223@gandalf.local.home>
In-Reply-To: <20231108192949.f19832c76d1cf18c5d614e72@kernel.org>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_kernel-v1-3-e4ce1388dfa0@samsung.com>
	<20231108192949.f19832c76d1cf18c5d614e72@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 19:29:49 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 07 Nov 2023 14:45:03 +0100
> Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org> wrote:
> 
> > From: Joel Granados <j.granados@samsung.com>
> > 
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which
> > will reduce the overall build time size of the kernel and run time
> > memory bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> > 
> > Remove sentinel elements from ftrace_sysctls and user_event_sysctls
> >   
> 
> Both looks good to me. (since register_sysctl_init() uses ARRAY_SIZE()
> macro to get the array size.)
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Agreed.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

