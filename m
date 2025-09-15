Return-Path: <linux-fsdevel+bounces-61468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE58B5885E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F801AA6C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0852DAFB9;
	Mon, 15 Sep 2025 23:41:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157C2D73A2;
	Mon, 15 Sep 2025 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757979675; cv=none; b=c7tHck1jTcOIyR2XU4JyfRdPzErIQwCrHML91wGnLmEDDSDShQPAWWZvcb2doSBeShBh+YKBSFoeNIKzZ40cB9qTcu3huZH1mNI8RdVF2XKcwXayVadlqN+1eYcddnjtiIMfIAYNH0QM/Zi4fxgKikyX7gvUiaSgzdSLY5DJ2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757979675; c=relaxed/simple;
	bh=JuEMNNtyXAo945noq2fgyIyulS4lCT2taizRXolw8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBs6ElFTzzrEvDwa2rGYL+8Isp/0ws0KNXnNnl2685DGCUBgtwT4PZMXbmhRFgffTDEV5lh0I3IBOtq6KVnEGv5PTraExsAmvsHNjPbPMcs24PfmGBnYGUxYBMsQPnBkkbq8yW5a7/G6TBWa8hapmBWuA8ztXjUlIvCRw051P6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0F89CC07CE;
	Mon, 15 Sep 2025 23:41:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id E2C4D20026;
	Mon, 15 Sep 2025 23:40:55 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:41:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org,
 lorenzo.stoakes@oracle.com, david@redhat.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
 android-mm@google.com, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook
 <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded
 trace event
Message-ID: <20250915194158.472edea5@gandalf.local.home>
In-Reply-To: <20250915163838.631445-8-kaleshsingh@google.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-8-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xeh53t51osude5snikt49ygtg765jjcj
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E2C4D20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX182V87XcZg9olTniRrbK41HEticcPkYuYw=
X-HE-Tag: 1757979655-928162
X-HE-Meta: U2FsdGVkX19Zx1if+NNOzNVMgDMyEiQRf5KCrWoxEDdLlNyy025itEj2zjYJBMkNwUQkqjVFWdtFRA5Ynf4Yz52t7Y1DGnQ2OrwsGDN+DfgeyZ/AjYltT/l+Fuc8hpc2wOnrMa4yD4BId/vidyDiRLVZf5kH/cEGKQMrhL9USmC5wPTmd/XZBCPSslcwAPZSJYKJrh1jOkhQdQrzGMZhwDuGvOx64jO6Sdz5jN+n3mxHtNycmWq2UKphdEubae/8110tkn8jyhlLd+mre6+YjdQCeFduvdoPDJUesJYNt8Y1VSJVf19uZJ2Wze55wXrfVIdxUSD+IxDLITtQ30dzIQMUtN1rlpTd

On Mon, 15 Sep 2025 09:36:38 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> Needed observability on in field devices can be collected with minimal
> overhead and can be toggled on and off. Event driven telemetry can be
> done with tracepoint BPF programs.
> 
> The process comm is provided for aggregation across devices and tgid is
> to enable per-process aggregation per device.

What do you mean about comm being used to aggregation across devices?
What's special about this trace event that will make it used across devices?

Note, if BPF is being used, can't the BPF program just add the current
comm? Why waste space in the ring buffer for it?



> +
> +TRACE_EVENT(max_vma_count_exceeded,
> +
> +	TP_PROTO(struct task_struct *task),

Why pass in the task if it's always going to be current?

> +
> +	TP_ARGS(task),
> +
> +	TP_STRUCT__entry(
> +		__string(comm,	task->comm)

This could be:

		__string(comm, current)

But I still want to know what makes this trace event special over other
trace events to store this, and can't it be retrieved another way,
especially if BPF is being used to hook to it?

-- Steve


> +		__field(pid_t,	tgid)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(comm);
> +		__entry->tgid = task->tgid;
> +	),
> +
> +	TP_printk("comm=%s tgid=%d", __get_str(comm), __entry->tgid)
> +);
> +

