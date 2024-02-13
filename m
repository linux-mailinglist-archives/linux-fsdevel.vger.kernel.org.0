Return-Path: <linux-fsdevel+bounces-11506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190385406E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57CC1F24202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5B634E5;
	Tue, 13 Feb 2024 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukudvr1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F919633F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868523; cv=none; b=Ei6FBx/6gatjsUfiyuLq90iahR6Nj5L3+51lJk7IXRFyt5jMsu+sjjUhFfOLg4kyTEIWRWUmeVyGKClgoQL2JXsohIYxjElQpxxmK6Yxjs8ynRyuSawFD16N27FIb8cWgbmkIt/M9vJz/B+lZ96TkP65AnvG7HxrTLVJ1DUE9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868523; c=relaxed/simple;
	bh=fZOGOODKc95B6ZKSflVqgO2m77JMf3lLtqu8+Vn6yXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggxMonLe3sO0rxgAr/NjTBp16mZctUaiHdikyIRPvXB/FUIIoyly1O4TsfcK8pXhLo4XiluxQXT716R0nsmRwnJv5N8OKnay2BN7QdweGO0tNTtRKE9JAu3vFkRv9TkiPkgMdBJRBsRUb0O8Gx6PwquWd9TK0lFwY23Lyo1M5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukudvr1a; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 18:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707868518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lYndZ54iAip9ue1kfzMMJiei98FQfeXzYAkwe/hBTc=;
	b=ukudvr1aCEFWsRD5Qc+t69T82wSLiWNggDNNSaihs/+5HsdVi3IiDww/W4Hjipu7Ldjze6
	fAlCdelItrMUUTcWWDaTYUW6HpXNtgsbiiEPWXxlSH+7ReEIr0ot/QCNg/6qEL8BJBc7Zy
	DmTXmD+wnOiL++TyCVx4b0U5F/8chrk=
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
Message-ID: <qjuicq6spjc7lwnsmcqthgcrwckgrbceombsxtcycol42smlzq@ufdlxckvfi6t>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-2-surenb@google.com>
 <CAHp75Vek3DEYLHnpUDBo_bYSd-ksN_66=LQ5s0Z+EhnNvhybpw@mail.gmail.com>
 <CAHp75VcftSPtAjOH-96wdyVhAYWAbOzZtfgm6J2Vwt1=-QTb=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcftSPtAjOH-96wdyVhAYWAbOzZtfgm6J2Vwt1=-QTb=Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 10:29:34AM +0200, Andy Shevchenko wrote:
> On Tue, Feb 13, 2024 at 10:26 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 11:39 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > From: Kent Overstreet <kent.overstreet@linux.dev>
> > >
> > > The new flags parameter allows controlling
> > >  - Whether or not the units suffix is separated by a space, for
> > >    compatibility with sort -h
> > >  - Whether or not to append a B suffix - we're not always printing
> > >    bytes.
> 
> And you effectively missed to _add_ the test cases for the modified code.
> Formal NAK for this, the rest is discussable, the absence of tests is not.

Eh?

The core algorihtm for printing out a number in human readable units;
that's definitely worth a test, and I assume there already is one - I
didn't touch that.

But whether or not the units suffix has a space, or a B suffix? That's
not going to break in subtle ways; that either works or it doesn't.

