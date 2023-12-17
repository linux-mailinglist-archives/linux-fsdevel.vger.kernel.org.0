Return-Path: <linux-fsdevel+bounces-6331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF5815CC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 01:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E33E1F224C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6480653;
	Sun, 17 Dec 2023 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rBxTo1zm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDD36E
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Dec 2023 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Dec 2023 19:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702772432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GwR937qpDoZqrlCJRYeBs8v4+5rmEpvwdjbzX+VHs9A=;
	b=rBxTo1zmPfHj3/6AVJZywQWcFReUJaxEC22ptYEKo/K/hf+g+YVJIHgDvHbTEweZ86kAKh
	gAIBEb/5TWtiu2pd3VF4HiEc60ZhPfa2HNJfnXAZGJZRwgX17s8aZMb+0qkmprB5IUuxdV
	rcgv+auqQORTEcZg+YG1cyyB5OAZXv0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de, x86@kernel.org, tj@kernel.org,
	peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Message-ID: <20231217002028.shjg6p7wa2cmtkq2@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
 <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
 <20231216223522.s4skrclervsskx32@moria.home.lan>
 <82ed43c2-2a9d-4c5e-8ccd-8078397b7953@infradead.org>
 <ZX4+STzh5MFhVHrw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX4+STzh5MFhVHrw@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Dec 17, 2023 at 12:18:17AM +0000, Matthew Wilcox wrote:
> On Sat, Dec 16, 2023 at 04:04:43PM -0800, Randy Dunlap wrote:
> > 
> > 
> > On 12/16/23 14:35, Kent Overstreet wrote:
> > > On Sat, Dec 16, 2023 at 06:13:41AM +0000, Matthew Wilcox wrote:
> > >> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
> > >>> -	INIT_HLIST_NODE(&notifier->link);
> > >>> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
> > >>> +	notifier->link.next = NULL;
> > >>> +	notifier->link.pprev = NULL;
> > >>
> > >> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
> > >> RCUREF_INIT() and ATOMIC_INIT() in there.
> > > 
> > > I think I'd prefer to keep types.h as minimal as possible - as soon as
> > > we start putting non type stuff in there people won't know what the
> > > distinction is and it'll grow.
> > > 
> > > preempt.h is a bit unusual too, normally we'd just split out a _types.h
> > > header there but it's not so easy to split up usefully.
> > > 
> > 
> > I don't feel like I have NAK power, but if I did, I would NAK
> > open coding of INIT_HLIST_HEAD() or anything like it.
> > I would expect some $maintainer to do likewise, but I could be
> > surprised.
> 
> There is another solution here (although I prefer moving INIT_HLIST_HEAD
> into types.h).  The preprocessor allows redefinitions as long as the two
> definitions match exactly.  So you can copy INIT_HLIST_HEAD into
> preempt.h and if the definition ever changes, we'll notice.

I like it.

