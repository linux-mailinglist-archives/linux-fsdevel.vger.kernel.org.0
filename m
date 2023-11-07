Return-Path: <linux-fsdevel+bounces-2262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0767E421B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F49281111
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D23158D;
	Tue,  7 Nov 2023 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDp1g+zK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D22FE02;
	Tue,  7 Nov 2023 14:50:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4D10CF;
	Tue,  7 Nov 2023 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aUPKeGDPANiKH2z7X9OP/b73LHeCDXnx5PDCsJAh+M4=; b=gDp1g+zKei5Pp+ErPuqJGvyIYg
	xGzHGyM11dG9jI9jae1Aj9AR57XGf62CEXNahL6Witq3vqXbFBnNnn2w0zuJChY94qURrK+HiBImH
	pWESyPMcD4dOmnpU5lllX9UAYbdxJMpr5Ln6txhpke+KZA2YAyh0sLInwJyzX7Hix9TdvwjCT5etA
	vV6IZ4jD173+OaWlbqxnaiHufqRf8DGIwc2RwgkWBfYb0+SZiO3M6Nu99qQsiypQ/2N2ILlgk4WL0
	4RjUb2cNWqjRKD2DPUeQnVEwPsssD2ETwgrhPYUPT3iMCDtuN/5uoJjMr6+nHbbvyIaLpUvpxIbX0
	rO+83T8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r0NOA-00C4Bw-2I;
	Tue, 07 Nov 2023 14:49:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BAC530049D; Tue,  7 Nov 2023 15:49:10 +0100 (CET)
Date: Tue, 7 Nov 2023 15:49:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20231107144910.GY8262@noisy.programming.kicks-ass.net>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-6-e4ce1388dfa0@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-6-e4ce1388dfa0@samsung.com>

On Tue, Nov 07, 2023 at 02:45:06PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> rm sentinel element from ctl_table arrays
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/sched/autogroup.c | 1 -
>  kernel/sched/core.c      | 1 -
>  kernel/sched/deadline.c  | 1 -
>  kernel/sched/fair.c      | 1 -
>  kernel/sched/rt.c        | 1 -
>  kernel/sched/topology.c  | 1 -
>  6 files changed, 6 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

