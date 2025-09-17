Return-Path: <linux-fsdevel+bounces-62051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20378B824D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657AC720F97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D0329509;
	Wed, 17 Sep 2025 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aJLsOO20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245222264CB;
	Wed, 17 Sep 2025 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151954; cv=none; b=iU61USWjEzKkv9/mDkj/F5xHgFX80knjOKyn1GaBUOUoLtbKzkEk8xfv4wwFugpKRsSi2WAtgoqmpObSNb0DFbfMP0cVq4214gUU8HBkMj3lS73IXATdGAaktWwE68WsAhYEjnf0/1A4HN8BeANtZ2PQxXqy+d29D91NPbDT4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151954; c=relaxed/simple;
	bh=Q1LlePHFW6OFmWWxXRZb1NAOVgqhCDoNI3SVEIRy3Zo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EreQGKLcwfwBQb2vdlzfjspNMZBPTPKjvN9CWLl0CPATJBgE6SmpJ4c9BcdzErcKje6olgGzU2fs8hM+J400x7KcSqOeB60tzMpJooFBGGhe0fnfL/N0zSpuvoKkb8/DSPjpeerJJtrSeBkbiR8IaaaQwzHCKHbi+GLIYV7Q1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aJLsOO20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CD8C4CEE7;
	Wed, 17 Sep 2025 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758151953;
	bh=Q1LlePHFW6OFmWWxXRZb1NAOVgqhCDoNI3SVEIRy3Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aJLsOO20NeMd3MhLkP7ZWhd6G7WGkxoKAeAR9nQUOYFW2HD6DA8oxRfYjz1SPlkO3
	 hMrOaaIo+facT/wqvl8beH17JYZskJHqEMifp0FxNhHxzFUULQFiujGBFm+OU9WEm9
	 yhwfXEw95u6rhoXY+PCJJkHHQ/dlshEmTqngiFhM=
Date: Wed, 17 Sep 2025 16:32:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, minchan@kernel.org,
 david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 pfalcato@suse.de, kernel-team@android.com, android-mm@google.com, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
Message-Id: <20250917163231.b5f7b8012367f033a91e6f9b@linux-foundation.org>
In-Reply-To: <e85d0b14-28dd-418f-872e-57c0127ad572@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
	<aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
	<20250916191645.15aae276992acafe7f7e723e@linux-foundation.org>
	<e85d0b14-28dd-418f-872e-57c0127ad572@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 06:36:34 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> >
> > > Perhaps being less accepting of patches during merge window is one aspect,
> > > as the merge window leading up to this cycle was almost the same review
> > > load as when the cycle started.
> >
> > I'm having trouble understanding what you said here?
> 
> Sorry, what I mean to say is that in mm we're pretty open to taking stuff in the
> merge window, esp. now we have mm-new.
> 
> And last merge window my review load felt similar to during a cycle, which
> was kind of crazy.
> 
> So I wonder if we should be less accommodating and simply say 'sorry it's
> the merge window, no submissions accepted'?

hm, I always have a lot of emails piled up by the time mm-stable gets
merged upstream.  That ~1 week between "we merged" and "-rc1" is a nice
time to go through that material and add it to mm-new.  I think it
smooths things out.  I mean, this is peak time for people to be
considering the new material?

(ot, that backlog is always >400 emails and a lot of that gets tossed
out anyway - either it's just too old so I request a refresh or there
was a new version, or review was unpromising, etc).


