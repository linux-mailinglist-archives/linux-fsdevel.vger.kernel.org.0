Return-Path: <linux-fsdevel+bounces-11507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4828540A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 01:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DF01F273B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77042A20;
	Wed, 14 Feb 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k67cy+ui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280A7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869072; cv=none; b=FZnMvQSmedHRyzS7KFb08cM5bJFI2by1reXc4xvgfXDmR+WDPcVDDfpeWy7AZSUBhUENtXcrr9D+eguYTyJMUb1e+pBZeEKw8lM915lIT8wN3+IA49iWyA4+jSo2d+R8im3C39NI+xoiqI+/cFdgltG6+Nbz2aowg2jkK3noARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869072; c=relaxed/simple;
	bh=HBo4/ZnPLdUMua0zJU4NpBUBSGdMyA1d1OPVB+TDxms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIqNA0LBljrijXFDk1rssVmyqv6brmf8obL4G6FARbxteBtMpEk0N9SsUxpTRzOZT4kKJj9KHqs4cj1mtUSLAvA6btzAz4q8QPUHyzuylGQ+5z552QGJQv7TR+G28Cvt5XyZ9/u/D7g2I1TLZVYKc76ApVLKix7JHmjEFFIQsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k67cy+ui; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 19:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707869068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lwr8Vkf8N+L/tCuYvXon7N+M0Ve52ARdPVwI9sTaz1k=;
	b=k67cy+uiY9Mx9j1UIeyoIR1jTVimFbXY0Ah+u9g9EkxXCXSlFErrbk1SmcOpMTNDyAuhJF
	8yT0rOI4rnYhxMMnMPJPO3qnI0CHdh08Glhfbg3KTriY7en7/N6LEcl8lSKS5p117ormdf
	8GPC7Twmy0k/brUYCR299XoutwGexNY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org, 
	paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
Message-ID: <76imoy5prhf2rhtuajlx3whdowfs3swdmufmosqvqrlljj4bye@dofqsd4674ek>
References: <6a0f5d8b-9c67-43f6-b25e-2240171265be@redhat.com>
 <CAJuCfpEtOhzL65eMDk2W5SchcquN9hMCcbfD50a-FgtPgxh4Fw@mail.gmail.com>
 <adbb77ee-1662-4d24-bcbf-d74c29bc5083@redhat.com>
 <r6cmbcmalryodbnlkmuj2fjnausbcysmolikjguqvdwkngeztq@45lbvxjavwb3>
 <CAJuCfpF4g1jeEwHVHjQWwi5kqS-3UqjMt7GnG0Kdz5VJGyhK3Q@mail.gmail.com>
 <a9b0440b-844e-4e45-a546-315d53322aad@redhat.com>
 <xbehqbtjp5wi4z2ppzrbmlj6vfazd2w5flz3tgjbo37tlisexa@caq633gciggt>
 <c842347d-5794-4925-9b95-e9966795b7e1@redhat.com>
 <CAJuCfpFB-WimQoC1s-ZoiAx+t31KRu1Hd9HgH3JTMssnskdvNw@mail.gmail.com>
 <CA+CK2bCvaoSRUjBZXFbyZi-1mPedNL3sZmUA9fHwcBB00eDygw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCvaoSRUjBZXFbyZi-1mPedNL3sZmUA9fHwcBB00eDygw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 06:54:09PM -0500, Pasha Tatashin wrote:
> > > I tried to be helpful, finding ways *not having to* bypass the MM
> > > community to get MM stuff merged.
> > >
> > > The reply I got is mostly negative energy.
> > >
> > > So you don't need my help here, understood.
> > >
> > > But I will fight against any attempts to bypass the MM community.
> >
> > Well, I'm definitely not trying to bypass the MM community, that's why
> > this patchset is posted. Not sure why people can't voice their opinion
> > on the benefit/cost balance of the patchset over the email... But if a
> > meeting would be more productive I'm happy to set it up.
> 
> Discussing these concerns during the next available MM Alignment
> session makes sense. At a minimum, Suren and Kent can present their
> reasons for believing the current approach is superior to the
> previously proposed alternatives.

Hang on though: I believe we did so adequately within this thread. Both
in the cover letter, and I further outlined exactly what the hooks
need to do, and cited the exact code.

Nobody seems to be complaining about the specifics, so I'm not sure what
would be on the agenda?

