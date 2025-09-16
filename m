Return-Path: <linux-fsdevel+bounces-61820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DAB5A0CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645AD3205A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100512D6E67;
	Tue, 16 Sep 2025 18:52:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B2219E8D;
	Tue, 16 Sep 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048726; cv=none; b=IW42zApvcNZtRYJbBQRPCg9oeLmkcB0b/RghqqemGF0b/w9/FoOJETgntDApv96QhREk4nJnV3GjSlCKsqh7iATPfOGDw7gK0R6BoeremeGDsWqPIuz8uYSFDVKYL+OxhCFJzWJF2eSvG4klHIomycn97eZE4C1PTflCQMgLjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048726; c=relaxed/simple;
	bh=uVMWKXu8FITctmOe18YNYkwXE2KLr8lvqARqp7ItpNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXVPwBVg1Nu3K/Pt3p6Vg7h8ZWitR0UkPvnjZoBQ9NDxwM8IEMuio6t0LLHg0v1UiSYlFKWEZ5A1FdLfV7/XXHgzMYlpxav+uccLmv6uB5sP0qe+lNWCkZzsDxoe1rzf9YhjdJ1Q/YF5Y6tJEdDgmHB1U0pe1eN9tnt984YQtiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 41DBCB6F0C;
	Tue, 16 Sep 2025 18:51:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 76DAA8000F;
	Tue, 16 Sep 2025 18:51:47 +0000 (UTC)
Date: Tue, 16 Sep 2025 14:51:46 -0400
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
Message-ID: <20250916145146.046f56a8@batman.local.home>
In-Reply-To: <CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-8-kaleshsingh@google.com>
	<20250915194158.472edea5@gandalf.local.home>
	<CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
	<20250916115220.4a90c745@batman.local.home>
	<CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
	<20250916134833.281e7f8b@gandalf.local.home>
	<CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
	<20250916140245.5894a2aa@gandalf.local.home>
	<CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yhko68sfdee7rmpk5n31f1agewjzkxx1
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 76DAA8000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18AaF19e3B9PdxiVyBsClWhsh9I/89dalw=
X-HE-Tag: 1758048707-555230
X-HE-Meta: U2FsdGVkX185Jk6EEAUV8t4XubC8/kXNROIjXRupcelR+hH3LPjbVvHzsC//ioq5oS07dWS2t7cQckl27RISrjNCA88UBb0WAorl7tjjsLJmAKwUX70maRG2rX9HPTBirBDH4VHEimIgl8f+sKXSAQQAFna9voNks/f8vy1zMr+7hWy7EAKlbbNCjd3jVgdRV30jSqdSv4iERGG1Z8w+dpwGGctTjQ9PNTMFD/16TifGmYPPyAk/4HUaqXfRy6P5otXkNPqkDkKMf59MRJxuHUt4InKNbMuwnay4dXCncAd6/+5o9+JNFiLY2MaD0GVL7y7Xz7aYj1A/e4MnaFiiQ0W5uB2CRAwb

On Tue, 16 Sep 2025 11:23:03 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> > When it comes to tracing, you already lost. If it goes into the ring buffer
> > it's a raw pointer. BPF doesn't use the output of the trace event, so you
> > are exposing nothing from that. It uses the proto directly.  
> 
> My understanding is that the BPF tracepoint type uses the trace event
> fields from TP_STRUCT__entry(); whereas the raw tracepoint type has
> access to the proto arguments. Please CMIW: Isn't what we'd be adding
> to the trace buffer is the hashed mm_id value?

Ah, right. Can't the BPF infrastructure protect against it?

> 
> >
> > Heck, if you enable function tracing, you are exposing every function
> > address it traces via the raw data output.  
> 
> Right, security doesn't allow compiling CONFIG_FUNCTION_TRACER  in
> Android production kernels.

Does it block all the other trace events that share pointers?

Like nmi handler tracepoints, x86_fpu tracepoints, page_fault kernel
tracepoint, tasklet tracepoints, cpu hot plug tracepoints, timer
tracepoints, work queue tracepoints, ipi tracepoints, scheduling
tracepoints, locking tracepoints, rcu tracepoints, dma tracepoints,
module tracepoints, xdp tracepoints, filemap tracepoints, page map
tracepoints, vmscan tracepoints, percpu tracepoints, kmem_cache
tracepoints, mmap lock tracepoints, file lock tracepoints, and many
more! (I got tired of looking them up).

Again, are you really protecting anything if this one trace point
hashes the pointer? Most other tracepoints expose this. If BPF can
access a tracepoint entry struct, it can access the raw address and
break KASLR.

-- Steve

