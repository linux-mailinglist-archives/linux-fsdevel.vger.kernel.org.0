Return-Path: <linux-fsdevel+bounces-6326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5927815C25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 23:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463EF1F22A43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 22:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6936B1A;
	Sat, 16 Dec 2023 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l7KLHLKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5693358BD
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Dec 2023 17:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702766126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNhwxr//DvDx0kBLO5uKoX7FVv1oXGMRs2iGooscwac=;
	b=l7KLHLKbQ7OlWriopR5AOIiJC0EWGfPpCc4eICxOm2t1SfU3m4EsjUY6/Niuy4yjTJwYAx
	W2m0oenm/WZCN+4doY2TZ2MnPc3fT9C4avDHe4Dp7ztBMrlUsF6SMvWxjMcMeenhbNB0uU
	LRYHKfhYXuSNjZXn6TbW74+3uNX9arM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Message-ID: <20231216223522.s4skrclervsskx32@moria.home.lan>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-3-kent.overstreet@linux.dev>
 <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX1AFVAWXMfbo+Ry@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Dec 16, 2023 at 06:13:41AM +0000, Matthew Wilcox wrote:
> On Fri, Dec 15, 2023 at 10:35:47PM -0500, Kent Overstreet wrote:
> > -	INIT_HLIST_NODE(&notifier->link);
> > +	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
> > +	notifier->link.next = NULL;
> > +	notifier->link.pprev = NULL;
> 
> Arguably INIT_HLIST_NODE() belongs in types.h -- we already have
> RCUREF_INIT() and ATOMIC_INIT() in there.

I think I'd prefer to keep types.h as minimal as possible - as soon as
we start putting non type stuff in there people won't know what the
distinction is and it'll grow.

preempt.h is a bit unusual too, normally we'd just split out a _types.h
header there but it's not so easy to split up usefully.

