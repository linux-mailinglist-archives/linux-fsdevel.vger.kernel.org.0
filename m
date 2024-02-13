Return-Path: <linux-fsdevel+bounces-11469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC01853E51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BFB1F2269A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9178690;
	Tue, 13 Feb 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rGEbbs21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A364CD9
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862002; cv=none; b=h2qvLgn3opJ/Nr+LRDZtQr37L9/D4uVs1MB0P21zh6JRHAyTyEjQn6gNj9d5oHJ4VhO4YUp8WoH6U2skdhG7ut9HuarSXwLTJtdSHRIUk281FJnhqfnceXZ/EnAEvtbZhyZ9FWmbDP546k3IKNXF1j7Xvyy5cA829BgaU7XX8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862002; c=relaxed/simple;
	bh=X9gIfYmrq4orF2JlReeyNwz+f8JQg90BSRXVh01Gv98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6uUcSxqa0lnhfXW+fhQVZ/VasRBdrr/1UFljtsYjw1uK+p4mL4kFh7YPDWWnTEzyoHMvX9CPczdD0io8YNLlfEvRZJP3H5tvG6RNcm0kfyKiZRT3PnmZIalqwOZQoku4xsqFJ9JfdCU36+z9Drx/1lDEyQomHOZqsOLxzfhLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rGEbbs21; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 17:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707861997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zK5QLIW85nz1zVFqkUnOGvmwzlA1XAn7Um1knwojFcg=;
	b=rGEbbs21+nZYs0/9vmfeL0lWowbNK/eT6L0AAMRyacfOwuZ1UFFsPh7Fyvq2Xojp6JQO3z
	I7a9ZOt20XcGXtOfMwojqqXm3BemtyWhDrnkPQ04hJB4GRJnSJWu7AdXBizsePAbXyPZtC
	CS546SLxy1lnuwZShsLcF5/EaSRxDxg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, hughd@google.com, 
	andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, 
	cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@samba.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 01/35] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <bicga3cv554ey4lby2twq3jw4tkkzx7mreakicf22sna63ye4x@x5di6km5x7fn>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-2-surenb@google.com>
 <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 10:26:48AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 11:39 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > The new flags parameter allows controlling
> >  - Whether or not the units suffix is separated by a space, for
> >    compatibility with sort -h
> >  - Whether or not to append a B suffix - we're not always printing
> >    bytes.
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> 
> ...
> 
> You can move the below under --- cutter, so it won't pollute the git history.
> 
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: "Noralf Trønnes" <noralf@tronnes.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > ---
> 
> ...
> 
> > --- a/include/linux/string_helpers.h
> > +++ b/include/linux/string_helpers.h
> > @@ -17,14 +17,13 @@ static inline bool string_is_terminated(const char *s, int len)
> 
> ...
> 
> > -/* Descriptions of the types of units to
> > - * print in */
> > -enum string_size_units {
> > -       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> > -       STRING_UNITS_2,         /* use binary powers of 2^10 */
> > +enum string_size_flags {
> > +       STRING_SIZE_BASE2       = (1 << 0),
> > +       STRING_SIZE_NOSPACE     = (1 << 1),
> > +       STRING_SIZE_NOBYTES     = (1 << 2),
> >  };
> 
> Do not kill documentation, I already said that. Or i.o.w. document this.
> Also the _SIZE is ambigous (if you don't want UNITS, use SIZE_FORMAT.
> 
> Also why did you kill BASE10 here? (see below as well)

As you should be able to tell from the name, it's a set of flags.

> > --- a/lib/string_helpers.c
> > +++ b/lib/string_helpers.c
> > @@ -19,11 +19,17 @@
> >  #include <linux/string.h>
> >  #include <linux/string_helpers.h>
> >
> > +enum string_size_units {
> > +       STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> > +       STRING_UNITS_2,         /* use binary powers of 2^10 */
> > +};
> 
> Why do we need this duplication?

Because otherwise a lot more code would have to change.
> 
> It seems most of my points from the previous review were refused...

Look, Andy, this is a pretty tiny part of the patchset, yet it's been
eating up a pretty disproprortionate amount of time and your review
feedback has been pretty unhelpful - asking for things to be broken up
in ways that would not be bisectable, or (as here) re-asking the same
things that I've already answered and that should've been obvious.

The code works. If you wish to complain about anything being broken, or
if you can come up with anything more actionable than what you've got
here, I will absolutely respond to that, but otherwise I'm just going to
leave things where they sit.

