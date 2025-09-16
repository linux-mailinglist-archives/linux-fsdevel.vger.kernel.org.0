Return-Path: <linux-fsdevel+bounces-61776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F9B59C90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1526F1890926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E7371EAF;
	Tue, 16 Sep 2025 15:52:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE3371E82;
	Tue, 16 Sep 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037958; cv=none; b=T9YKYY9NeJIX9aC6rKhyKnz7+dCKCAyB55Ls5Petn4ok1ByONEdxrZ3D4xDgu+25Q1tUlJT7qmNoKjFCJyNVnvrFuPQZXEigev4mlgyqJytLnuBp7tFCnFxgtX7IbWAjLeIUZEv7Mmso94zKcfrp5DLUT94G42PY3IMo6GpcDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037958; c=relaxed/simple;
	bh=7g295xyPMT13qVQTjafA2tbWVbgwbWsHVKCQbKmtgvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1Hz4aAF+Q9DPpQnp1fyDsLRlVej9ppIy02NhBqxt8eaT0oLIDNi4aRSHNBFWEFY9FqGlFZQ68T1sBd5C2xaG2AmkrbmYJ2mAQBKP2FPBOUcQkheyJnkGtd4yc/tQ7KsHVMtGnwg23722Iq0GRL4qvjrLP8dumxGimRDRuDZzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 76C69C012C;
	Tue, 16 Sep 2025 15:52:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id DBCCB20028;
	Tue, 16 Sep 2025 15:52:18 +0000 (UTC)
Date: Tue, 16 Sep 2025 11:52:20 -0400
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
Message-ID: <20250916115220.4a90c745@batman.local.home>
In-Reply-To: <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-8-kaleshsingh@google.com>
	<20250915194158.472edea5@gandalf.local.home>
	<CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ag4g6fppr8s1m9y79t5wuniaqbhtwqgy
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DBCCB20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kM4JL2HuW3j1rMjDU+rkD+Z61vYxnluI=
X-HE-Tag: 1758037938-962884
X-HE-Meta: U2FsdGVkX19km+vx1Nw4MwcIQthEUwC8H0Wt6kTx/baNVVGl8r2XGU4DxKRou7Uph/fciUgP4mcn20MxlcPUwB09x9cscmjabG8HOjm/TLpPLYcCGAle/Iw7MOKi3Lu2GGiJkB3FwL4S+6HhQEW6+LjVqhb5aZ2EPVErSYilPj9pQfOzyDA5+f20FTl3jO+CprUVjkc0a/xVE+9rZMbTtyUE5uZPO/QZ+kRWOthubie3Hz0tF/NThrRH/gfSFkcVdbV8VjAzIHal65+rIFJjzr56ME43hlsU2/lPq1FLyz6Qai8yuprzGJ9qZ3f4wPCHMYK1+ZMKL97QJCHscskViXrNjc9Qpu8t

On Mon, 15 Sep 2025 18:19:53 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:


> Hi Steve,
> 
> Thanks for the comments and suggestion you are right we can use bpf to
> get the comm. There is nothing special about this trace event.  I will
> drop comm in the next revision.
> 
> The reason I did the task_struct parameter (current): I believe there
> is a limitation that we must  specify at least 1 parameter to the
> TRACE_EVENT()  PROTO and ARGS macros.

OK, then this is another issue. We don't want tracepoint "markers".
Each tracepoint can take up to 5K in memory due to the code it
generates and the meta data to control it.

For something like that, we highly recommend dynamic probes (fprobes,
kprobes, etc).

The only purpose of a static tracepoint is to get data within a
function that is too difficult to get via a probe. It should never be
used as a trigger where its purpose is "we hit this path".

-- Steve

