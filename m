Return-Path: <linux-fsdevel+bounces-6330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EBF815CC4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 01:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82361B226F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657121FCA;
	Sun, 17 Dec 2023 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpDqV4f9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60F1FAD;
	Sun, 17 Dec 2023 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Dec 2023 19:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702772334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GHhOxXFtGpDl4qK2SBVIKyrWsCibjLmY7kB9hT6fac4=;
	b=lpDqV4f96Yla/WX6tu2uOH466Isjo3Sw82OP0xo72YHAmSn557tvbngf7sa5iU/L/qnqWJ
	H+frcO/hJ1WvIaEBFuvq6rTogC9Xt2Mb7JCnXw1C2VdEHnwm5qCAA7c9JpzM62puGQ9o4K
	3C638NdjC4CKVp6xIuAW75RSWwe8PJQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de, x86@kernel.org, tj@kernel.org,
	peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Message-ID: <20231217001849.hmilfx63q44tv3vj@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
 <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
 <20231216223522.s4skrclervsskx32@moria.home.lan>
 <82ed43c2-2a9d-4c5e-8ccd-8078397b7953@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ed43c2-2a9d-4c5e-8ccd-8078397b7953@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 16, 2023 at 04:04:43PM -0800, Randy Dunlap wrote:
> 
> 
> On 12/16/23 14:35, Kent Overstreet wrote:
> > On Sat, Dec 16, 2023 at 06:13:41AM +0000, Matthew Wilcox wrote:
> >> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
> >>> -	INIT_HLIST_NODE(&notifier->link);
> >>> +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
> >>> +	notifier->link.next = NULL;
> >>> +	notifier->link.pprev = NULL;
> >>
> >> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
> >> RCUREF_INIT() and ATOMIC_INIT() in there.
> > 
> > I think I'd prefer to keep types.h as minimal as possible - as soon as
> > we start putting non type stuff in there people won't know what the
> > distinction is and it'll grow.
> > 
> > preempt.h is a bit unusual too, normally we'd just split out a _types.h
> > header there but it's not so easy to split up usefully.
> > 
> 
> I don't feel like I have NAK power, but if I did, I would NAK
> open coding of INIT_HLIST_HEAD() or anything like it.
> I would expect some $maintainer to do likewise, but I could be
> surprised.

It's INIT_HLIST_HEAD(), there's approximately zero chance of the
implementation changing, and there's a comment.

