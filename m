Return-Path: <linux-fsdevel+bounces-61809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE8B59FB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D7F2A623D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DC6287506;
	Tue, 16 Sep 2025 17:47:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F7D27E04F;
	Tue, 16 Sep 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044868; cv=none; b=h373A98JkU+2yup64zykIUCjVXYCxUj+ikCzjwPKXtzgOkwV8S8xs6Q2KZD2f5gZhM71/T6d+bqcZYVE/TqTBoU0WLD9czAsBj2fC61YObW3+UpVXHPq9x+Ck/4Wv7UpOkMSleaT8Ug9kVco5YnQk1vwiLzWMKMyEKgCOAAlUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044868; c=relaxed/simple;
	bh=YqjelYCPt3ItQZeVSwG5EOEY2H7o04PZ4x8dk0USZ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn6+iEkQYb8RPvLrnIghqZ0BgVJRo/HvfbiKeiTdJzDm6hLcGvjLY7lWTBvFlI8Y251wOMLs9PzSUgZMQZYZAH0TRx3+d2v2AoZF1rJchKa4iVvcvnmnynzUFGxXGJtPxfXLOxD7dhGktDZvK3V2J7yqV9geenn9RCAS/z8xRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2F291160281;
	Tue, 16 Sep 2025 17:47:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id EA69C1B;
	Tue, 16 Sep 2025 17:47:29 +0000 (UTC)
Date: Tue, 16 Sep 2025 13:48:33 -0400
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
Message-ID: <20250916134833.281e7f8b@gandalf.local.home>
In-Reply-To: <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915163838.631445-8-kaleshsingh@google.com>
	<20250915194158.472edea5@gandalf.local.home>
	<CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
	<20250916115220.4a90c745@batman.local.home>
	<CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5uqotgt5cqbtb693tzenck8fsp784zbq
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EA69C1B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fYVEo+TQfqoFVoPY0drWwFJ5ox6HfaHo=
X-HE-Tag: 1758044849-648048
X-HE-Meta: U2FsdGVkX18pAhXbWHugGNFQkb4HsbkpHA3LSK9XLE+vsmwTM7qPsZjE2Q1AkokCaSSM3kECB5AtJoNuafNVa4c24DllJqRZBRvH3Zmhy5wNh7TxTIkWD37LWX+bmFtCcebRBnxRuw3/k7vvz39wmpkcHu/7IwevVpAu7R0GogngimDsXGbeq53gsFUSv11MEKrEXvPbk4fw2Y+CyjjJq7TcrXucdUHUeHf7eiqw5uLSPBWimQmNj30QjsGtyMec/D0hb09wfSYgY56Wz5pEFnLq6GYNKSiHSG5mPzJ0+9udgkbbXo4zTaOyLKWUXBfDcE7VEMWXx80P+tQi6apDTcgD1TYy32eR2VKzLPG+ZszbApg+pHDZug==

On Tue, 16 Sep 2025 10:36:57 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> I completely agree with the principle that static tracepoints
> shouldn't be used as markers if a dynamic probe will suffice. The
> intent here is to avoid introducing overhead in the common case to
> avoid regressing mmap, munmap, and other syscall latencies; while
> still providing observability for the max vma_count exceeded failure
> condition.
> 
> The original centralized check (before previous review rounds) was
> indeed in a dedicated function, exceeds_max_map_count(), where a
> kprobe/fprobe could have been easily attached without impacting the
> common path. This was changed due to previous review feedback to the
> capacity based vma_count_remaining() which necessitated the check to
> be done externally by the callers:
> 
> https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.com/
> 
> Would you be ok with something like:
> 
> trace_max_vma_count_exceeded(mm);
> 
> TP_STRUCT__entry(
> __field(unsigned int, mm_id)
> __field(unsigned int vma_count)
> )
> 
> mm_id would be the hash of the mm_struct ptr similar to rss_stat and
> the vma_count is the current vma count (some syscalls have different
> requirements on the capacity remaining: mremap requires 6 available
> slots, other syscalls require 1).
> 

BTW, why the hash of the mm pointer and not the pointer itself? We save
pointers in lots of places, and if it is the pointer, you could use an
eprobe to attache to the trace event to dereference its fields.

-- Steve

