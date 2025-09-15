Return-Path: <linux-fsdevel+bounces-61459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C9B5878D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9252208075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538762D5436;
	Mon, 15 Sep 2025 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rh6tW0PI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082426AF3;
	Mon, 15 Sep 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975644; cv=none; b=fQ7GmxGCPb95qiGxCsaD9+I1JBdq30tAy90GozVDYhXoRqvSiOlyOdNiUUBpNUUHlJNY8RmVXB730WqW798UO24x2xVq85cRqnUjJXt3D0kgf8086f5OLTjSe6iurqfPo8DFYmAvmI40s8ePt3Y5m1XfQc9Gu+zO9fssmyZEfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975644; c=relaxed/simple;
	bh=Stv7c8b21tAoRvHnLcswUUt7FKb98hyMbg/pjdBteec=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fN+Cv5dfp9hqEI43PwHM34nmBwfu93/LLnSrUeMQP+bB5tQHxBcKt7zpMOdjuraRsFtniMuSz1uX6Zi3PgqwQOUyKV9iXFh8u26dijAFuFkerj/vgtx6G6xnFs8ywC+UE9gLCjC5Lw7jbOBMCnFAIzvelnAgRQTIRjb0HhB2WaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rh6tW0PI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95992C4CEF1;
	Mon, 15 Sep 2025 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757975644;
	bh=Stv7c8b21tAoRvHnLcswUUt7FKb98hyMbg/pjdBteec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rh6tW0PI2bUr3YphPyaqLZMRahxrmrHJA4vmKG+cCDGnzQ5wdpxsjt30Ofyx7EOra
	 XgccpGxXANJbzL3iUnHWy/wFP9bY80F8jPHHo3GMadzGP1bbBbS17S2C0iXHWDfbIC
	 q+8BTw/8ahYs5HQFL/4BC19smyPMw5+optpIBBE8=
Date: Mon, 15 Sep 2025 15:34:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
 kernel-team@android.com, android-mm@google.com, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Kees Cook <kees@kernel.org>, Vlastimil Babka
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
Message-Id: <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 09:36:31 -0700 Kalesh Singh <kaleshsingh@google.com> wrote:

> Hi all,
> 
> This is v2 to the VMA count patch I previously posted at:
> 
> https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.com/
> 
> 
> I've split it into multiple patches to address the feedback.
> 
> The main changes in v2 are:
> 
> - Use a capacity-based check for VMA count limit, per Lorenzo.
> - Rename map_count to vma_count, per David.
> - Add assertions for exceeding the limit, per Pedro.
> - Add tests for max_vma_count, per Liam.
> - Emit a trace event for failure due to insufficient capacity for
>   observability
> 
> Tested on x86_64 and arm64:
> 
> - Build test:
>     - allyesconfig for rename
> 
> - Selftests:
>       cd tools/testing/selftests/mm && \
>           make && \
>           ./run_vmtests.sh -t max_vma_count
> 
>        (With trace_max_vma_count_exceeded enabled)
> 
> - vma tests:
>       cd tools/testing/vma && \
>           make && \
> 	  ./vma

fwiw, there's nothing in the above which is usable in a [0/N] overview.

While useful, the "what changed since the previous version" info isn't
a suitable thing to carry in the permanent kernel record - it's
short-term treansient stuff, not helpful to someone who is looking at
the patchset in 2029.  

Similarly, the "how it was tested" material is also useful, but it
becomes irrelevant as soon as the code hits linux-next and mainline.


Anyhow, this -rc cycle has been quite the firehose in MM and I'm
feeling a need to slow things down for additional stabilization and so
people hopefully get additional bandwidth to digest the material we've
added this far.  So I think I'll just cherrypick [1/7] for now.  A
great flood of positive review activity would probably make me revisit
that ;)


