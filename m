Return-Path: <linux-fsdevel+bounces-6329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB34815CC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 01:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B39CB2270D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C23643;
	Sun, 17 Dec 2023 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fY+v1Yom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35A366;
	Sun, 17 Dec 2023 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C1EyQtZrrzPsJdauHkagM7iwgSK3ui+7wFcf1Ql90yw=; b=fY+v1YomSygsPdBd8Jdm4EwZ4/
	Lo4ivfpOIdBieru9I2UKeMqgnxit8adT9+svb5ezPg/AkiCap0GNLwwnbbjx+lR6eXu++pYnmje2q
	OD5ac1zLfstFh58JX4h8u+wEjtz0VhEFXwKkfLgF7kaPPrCLQz2/hysUdcgP+EIn8YzJBW86rF9fM
	BXxJirnSvV4In+xhJcoomQQp1QRx4W97rs/jiH4UW2z0yY35d2/XrAz2a47f7a11iSs+ppnRiqE1f
	Km/XvzJZ01AWHw06hze7HJHb94HCR+nW60P+B57YKqkI2lcmwQfDeOkccQGxJGAacO5fMA+uzefNc
	OgkuZJjw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEerJ-00BIOX-Vj; Sun, 17 Dec 2023 00:18:18 +0000
Date: Sun, 17 Dec 2023 00:18:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, keescook@chromium.org,
	dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 46/50] preempt.h: Kill dependency on list.h
Message-ID: <ZX4+STzh5MFhVHrw@casper.infradead.org>
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

There is another solution here (although I prefer moving INIT_HLIST_HEAD
into types.h).  The preprocessor allows redefinitions as long as the two
definitions match exactly.  So you can copy INIT_HLIST_HEAD into
preempt.h and if the definition ever changes, we'll notice.

