Return-Path: <linux-fsdevel+bounces-69333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596BC76A52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 00:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54B3D4E2C92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3D30AAC7;
	Thu, 20 Nov 2025 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA3MslyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E725BEE7;
	Thu, 20 Nov 2025 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682325; cv=none; b=aVfAo/midjlK2CdKXiLTvnyI4Ueb/aU7/uIXKe9Xw3itgPgzXTCcV5yqHWf3YT48vQwTEd9uLEHFbXVHoj4iRyrwtxSgbZNcw0i/fVvujvbr9jvCVjbGGghGdOThI2OGGcX3Aa7wclwkkCFH4Q6BMQPnjvV5rp5nvaWN8wCxGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682325; c=relaxed/simple;
	bh=ImWWYk0PHw9JXlz/xZx3LovRWAEU+wr54LjbITQLl9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akV2N6aXgtSr8ZISt6eaJhJ/b+ft77QeRypbKd+nFCRRXagz3hG6+znJB+OCy8j6+J6SQ3SN7GTGa+344k5wsX9jaEkzLPPp5K5Bwj9H9sJoUETjc280RiyTV9WYGTBBiMTLTcOjH9HV/oYb1nr16ofwutS40nzxiincAftzZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA3MslyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD5FC4CEF1;
	Thu, 20 Nov 2025 23:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763682324;
	bh=ImWWYk0PHw9JXlz/xZx3LovRWAEU+wr54LjbITQLl9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VA3MslyZbpymm5vh31u8bCqtScgQxq4YNX0wHTLCgY63ZlebhUUN80u3xqFbgqQd1
	 nnhj5YbTfs90XwPPcqscoR71rFf7aoeqUpH2z++tBO48mwXSPFG2WJ8f1m+K320Cgq
	 sGp8yejP7ZyZXMTlKceOeoC7SKYySm1jtWCBqxvRsIy8J2CjdcYMMVXxmRq9UbGVGj
	 dAOUZtNBzLs8bOb+9oy1/apHdyUY8+QdOeQBjoINr+Hx41VdQXwVUoEgUQOusFNvcg
	 YXVuItlrs9IWMIvdlLjt5G6gfg60xoJhG5AjvMZQ33LCgGrbQg17iLNP8JCCjEPB+x
	 GBAArzxJNaIbg==
Date: Thu, 20 Nov 2025 23:45:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <20251120234522.GB3532564@google.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-40-david.laight.linux@gmail.com>
 <7430fd6f-ead2-4ff8-8329-0c0875a39611@kernel.org>
 <20251120095946.2da34be9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120095946.2da34be9@pumpkin>

On Thu, Nov 20, 2025 at 09:59:46AM +0000, David Laight wrote:
> On Thu, 20 Nov 2025 10:20:41 +0100
> "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> 
> > On 11/19/25 23:41, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > > and so cannot discard significant bits.  
> > 
> > I thought using min() was frowned upon and we were supposed to use 
> > min_t() instead to make it clear which type we want to use.
> 
> I'm not sure that was ever true.
> min_t() is just an accident waiting to happen.
> (and I found a few of them, the worst are in sched/fair.c)
> 
> Most of the min_t() are there because of the rather overzealous type
> check that used to be in min().
> But even then it would really be better to explicitly cast one of the
> parameters to min(), so min_t(T, a, b) => min(a, (T)b).
> Then it becomes rather more obvious that min_t(u8, x->m_u8, expr)
> is going mask off the high bits of 'expr'.
> 
> > Do I misremember or have things changed?
> > 
> > Wasn't there a checkpatch warning that states exactly that?
> 
> There is one that suggests min_t() - it ought to be nuked.
> The real fix is to backtrack the types so there isn't an error.
> min_t() ought to be a 'last resort' and a single cast is better.
> 
> With the relaxed checks in min() most of the min_t() can just
> be replaced by min(), even this is ok:
> 	int len = fun();
> 	if (len < 0)
> 		return;
> 	count = min(len, sizeof(T));
> 
> I did look at the history of min() and min_t().
> IIRC some of the networking code had a real function min() with
> 'unsigned int' arguments.
> This was moved to a common header, changed to a #define and had
> a type added - so min(T, a, b).
> Pretty much immediately that was renamed min_t() and min() added
> that accepted any type - but checked the types of 'a' and 'b'
> exactly matched.
> Code was then changed (over the years) to use min(), but in many
> cases the types didn't quite match - so min_t() was used a lot.
> 
> I keep spotting new commits that pass too small a type to min_t().
> So this is the start of a '5 year' campaign to nuke min_t() (et al).

Yes, checkpatch suggests min_t() or max_t() if you cast an argument to
min() or max().  Grep for "typecasts on min/max could be min_t/max_t" in
scripts/checkpatch.pl.

And historically you could not pass different types to min() and max(),
which is why people use min_t() and max_t().  It looks like you fixed
that a couple years ago in
https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/,
which is great!  It just takes some time for the whole community to get
the message.  Also, it seems that checkpatch is in need of an update.

Doing these conversions looks good to me, but unfortunately this is
probably the type of thing that shouldn't be a single kernel-wide patch
series.  They should be sent out per-subsystem.

I suggest also putting a sentence in the commit message that mentions
that min() and max() have been updated to accept arguments with
different types.  (Seeing as historically that wasn't true.)  I suggest
also being extra clear about when each change is a cleanup vs a fix. 

- Eric

