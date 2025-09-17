Return-Path: <linux-fsdevel+bounces-61861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E3B800B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A02B7B4E0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C42F60A1;
	Wed, 17 Sep 2025 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u5BIwCmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D131BC58;
	Wed, 17 Sep 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075407; cv=none; b=r+64dN4NcRFD+v4J11Xs8ManyHOONGTYqseK9lNSXatwuZcd7bRUzD+3DFCeBAU+OAZMU6/P4NCsiGAawrdhiE5jIHTQvf/2vwGRfZGPBsHgYfQT5s41qvCa6AYms9yFQP/8GbuPl9dICl8HZdOtFvgqcbGXAd23ujK8eVinVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075407; c=relaxed/simple;
	bh=Y7E9FgWFmiluyPV1OTAKxPaUN0ogdOZyX5+tdyu3XVE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q/vkwECJXugbp/pZmCk+tTj91vG+A7cj9WSryLsJxNx05QBdrRJ0HxrcRPsQd9r99B43fbZL6OJeMkMULo/JYq7Gaz/jsTgLeeKn34JqE38tCVF0O09Ee+Ni8ZoBIzarmoPK+wUMg+PTBprrWmce8hUnGe32nCAblruinuBJBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u5BIwCmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84ACC4CEFB;
	Wed, 17 Sep 2025 02:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758075406;
	bh=Y7E9FgWFmiluyPV1OTAKxPaUN0ogdOZyX5+tdyu3XVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u5BIwCmk8zcWTJgkEDHluvpFKUJ+aQvEoMt5i7SU0M0JsqTjpt2DrYWLAnJKdQH6Z
	 7dP4yqdgfiai+hLAEJW9o2X9KCuqnM3sRjwqylWH6wHaT1WnL3QPARHGYvjYGMeV2H
	 7yZBaedhoZWKOqr6xIHnVhSligT+feIMD27ILX+s=
Date: Tue, 16 Sep 2025 19:16:45 -0700
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
Message-Id: <20250916191645.15aae276992acafe7f7e723e@linux-foundation.org>
In-Reply-To: <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
	<20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
	<aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 11:12:03 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Sep 15, 2025 at 03:34:01PM -0700, Andrew Morton wrote:
> > Anyhow, this -rc cycle has been quite the firehose in MM and I'm
> > feeling a need to slow things down for additional stabilization and so
> > people hopefully get additional bandwidth to digest the material we've
> > added this far.  So I think I'll just cherrypick [1/7] for now.  A
> > great flood of positive review activity would probably make me revisit
> > that ;)
> >
> 
> Kalesh - I do intend to look at this series when I have a chance. My review
> workload has been insane so it's hard to keep up at the moment.
> 
> Andrew - This cycle has been crazy, speaking from point of view of somebody
> doing a lot of review, it's been very very exhausting from this side too,
> and this kind of work can feel a little... thankless... sometimes :)

I hear you.  I'm shedding most everything now, to give us a couple of
weeks to digest.

> I feel like we maybe need a way to ask people to slow down, sometimes at
> least.

Yup, I'm sending submitters private emails explaining the situation.

Maybe they should be public emails, I find it a hard call.

> Perhaps being less accepting of patches during merge window is one aspect,
> as the merge window leading up to this cycle was almost the same review
> load as when the cycle started.

I'm having trouble understanding what you said here?

> Anyway, TL;DR: I think we need to be mindful of reviewer sanity as a factor
> in all this too :)
> 
> (I am spekaing at Kernel Recipes then going on a very-badly-needed 2.5 week
> vacataion afterwards over the merge window so I hope to stave off burnout
> that way. Be good if I could keep mails upon return to 3 digits, but I have
> my doubts :P)

I'd blow that in three days ;)

