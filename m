Return-Path: <linux-fsdevel+bounces-29342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8897852C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D81F219FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216557347E;
	Fri, 13 Sep 2024 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onxuXcui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8A55898;
	Fri, 13 Sep 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242709; cv=none; b=hz0gHuSMmiGEjMqIUW5ltG/aR12wCYeK2P4W+mY8PissC/ErQLEWvkjW2D6hvxU9c+LngTe+AfgkZHazbdCynl2v4lnFf391dbLJ0c4s0A48iJvvF58eCeMOv71qqzIXle3CjfN3CV4ry1uLCz5kAIUJ9GYk/YpGHi1Bzo03TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242709; c=relaxed/simple;
	bh=DbKdUFxvl0YljeqPV9VUG4Dgd2JUR0xiij/qkMUoEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEUIm9ZFe2YpQQ2hH7n7UmGM8A20iW7Icgsqmgp2Y8DrTjKA7NqhKAHdiT85AObYhbWvx1g1+y+QZyl5zRXxBJuVgBhqriHcfAZq8Dg1p80CSF8YaUHk2AZktZpPdJlU73wknoyZUkGGCf76z/xZCxrhNNVl3rB3vxeygd3xvy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=onxuXcui; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GeAnsuP8aeMkI3YdnhdkdYt/fm3JMpOCpvH3j/+kM8o=; b=onxuXcui/ywqsVP8qdl3qOka6P
	+/qucTGwlgBgjjB4pksKLZDtxPZPYkS7GutVyb6OLmyESTUiJzbj6i7SsCXqYvmQLl3fQSfLsaOht
	FOszvAJkqNp1rEJXnouqSUQ0F1EpI0pK4MzWb7b5CBJ3aKLY7L+LldZnjWP1CUwpAQ2kn/lP52UEz
	qI3kw3VisV28jPeHYZDFAW5DUdEy4u4erPytpG+ic1WQAw9QQLbsodh4fUj8U4edFwPNF1WcWmVp+
	gg/uPT4uvqSZ/PXcE+L4yBNGuksMGWJERGN4Yv6NNJoiay6VUSU1KwywdW0NVmowue1iB/1vLN6sa
	IxsiuHsg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sp8aC-0000000Gk78-2M7t;
	Fri, 13 Sep 2024 15:51:40 +0000
Date: Fri, 13 Sep 2024 16:51:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Christian Theune <ct@flyingcircus.io>,
	linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>,
	Dave Chinner <david@fromorbit.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuRfjGhAtXizA7Hu@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com>

On Fri, Sep 13, 2024 at 11:30:41AM -0400, Chris Mason wrote:
> I've mentioned this in the past to both Willy and Dave Chinner, but so
> far all of my attempts to reproduce it on purpose have failed.  It's
> awkward because I don't like to send bug reports that I haven't
> reproduced on a non-facebook kernel, but I'm pretty confident this bug
> isn't specific to us.

I don't think the bug is specific to you either.  It's been hit by
several people ... but it's really hard to hit ;-(  

> I'll double down on repros again during plumbers and hopefully come up
> with a recipe for explosions.  On other important datapoint is that we

I appreciate the effort!

> The issue looked similar to Christian Theune's rcu stalls, but since it
> was just one CPU spinning away, I was able to perf probe and drgn my way
> to some details.  The xarray for the file had a series of large folios:
> 
> [ index 0 large folio from the correct file ]
> [ index 1: large folio from the correct file ]
> ...
> [ index N: large folio from a completely different file ]
> [ index N+1: large folio from the correct file ]
> 
> I'm being sloppy with index numbers, but the important part is that
> we've got a large folio from the wrong file in the middle of the bunch.

If you could get the precise index numbers, that would be an important
clue.  It would be interesting to know the index number in the xarray
where the folio was found rather than folio->index (as I suspect that
folio->index is completely bogus because folio->mapping is wrong).
But gathering that info is going to be hard.

Maybe something like this?

+++ b/mm/filemap.c
@@ -2317,6 +2317,12 @@ static void filemap_get_read_batch(struct address_space *mapping,
                if (unlikely(folio != xas_reload(&xas)))
                        goto put_folio;

+{
+       struct address_space *fmapping = READ_ONCE(folio->mapping);
+       if (fmapping != NULL && fmapping != mapping)
+               printk("bad folio at %lx\n", xas.xa_index);
+}
+
                if (!folio_batch_add(fbatch, folio))
                        break;
                if (!folio_test_uptodate(folio))

(could use VM_BUG_ON_FOLIO() too, but i'm not sure that the identity of
the bad folio we've found is as interesting as where we found it)


