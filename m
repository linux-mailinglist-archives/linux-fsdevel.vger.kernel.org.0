Return-Path: <linux-fsdevel+bounces-71258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F3CBB5A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 02:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C90300D487
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 01:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD552E06EF;
	Sun, 14 Dec 2025 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jIlG8Icg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D45264A97;
	Sun, 14 Dec 2025 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765674878; cv=none; b=rPrMDceCjJpDkGyCwCyroarjUeCU7Lah/u/ET0Nalh0XYuRtwq8YK8erm7Y88B/gz3+7dUV48WtEc9X+Swq2OzRSqLHtlwUVXfPH8WL51Wq0efZDtWQNuoAlDpCokNhiIHZkKTvwQ4arHVCKGAAkT035jAujT0vH9lL2m/qbafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765674878; c=relaxed/simple;
	bh=FQcS4J4dNZzBqz5XWq4usTitnTFPPMZl5NKYbnQ5yXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9dMcjvYeY9FdBq7b2A1N5L5NjW2K1Iy+OXD1WaNXDg9C8RrezFhywPS3D5R3UgoOjReH54KmCI3dsQ4L2pNuk6Z+xElc/a1u298xnASxZR0uS1cguCt2rG2LAPZyeK6TImzVikgN6juXlv0FQLOODbW+V32mYT6loQh+Q1xwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jIlG8Icg; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D148214C2D6;
	Sun, 14 Dec 2025 02:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1765674872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8QvLd662/2lp2A9Uky7HUACPwUKzxunR+RQJ0SbyY0=;
	b=jIlG8IcgU+ZnaVw7gfsBY8rjdXn0XYwCy7bLPJEQvMHqGw9TUWE8AqXf0InFsFuk+umZM4
	xoxpYrfaii3GQCq8BpjqPuvgPLoozZrUF/6ptrbJCHxzNqnblSLSuFY8otEiYRPGVmj1o3
	hsFMcha5TeGynfH82ywIeCCMZ1kl4tFjxCXwtfyfs5pNIejwcgVfe0D2Mv4L/fb8EBrHr8
	hnfozA0VUQrhssWeGx1srZdDObpCY2LOw1qbwxALWhBpQs4lqrQSvCUm5jmZ2Ni5eMr7TB
	T8HB385TgwF5N6Ly4ZdBGWfwGCRxdsAngzEB7rDSW/MtRHXsilyuCiJzcDoFIg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c47a14b8;
	Sun, 14 Dec 2025 01:14:28 +0000 (UTC)
Date: Sun, 14 Dec 2025 10:14:13 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH RFC v2] 9p/virtio: convert to extract_iter_to_sg()
Message-ID: <aT4PZUtvirfq3Lov@codewreck.org>
References: <20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org>
 <22933653.EfDdHjke4D@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22933653.EfDdHjke4D@weasel>


(Chris, sorry, I had dropped you from Ccs as you were Cc'd from the
patch itself and not the header... See [1] for start of thread if you're
interested)
[1] https://lore.kernel.org/r/20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org


Christian Schoenebeck wrote on Sat, Dec 13, 2025 at 07:02:00PM +0100:
> On Saturday, 13 December 2025 16:07:40 CET Dominique Martinet via B4 Relay wrote:
> > This simplifies the code quite a bit and should fix issues with
> > blowing up when iov_iter points at kmalloc data
> > 
> > RFC - Not really tested yet!!
> 
> TBH, that bothers me.

Well, that just means "don't bother spending time testing much (or
debugging if you do test and run into bugs)" and it likely won't be
merged as is -- this is enough to start discussions without wasting more
time if this gets refused.

> Also considering the huge amount of changes; again, what
> was actually wrong with the previously suggested simple patch v1 [1]? All I
> can see is a discussion about the term "folio" being misused in the commit log
> message, but nothing about the patch being wrong per se.
> [1] https://lore.kernel.org/all/20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org/

I agree we're close to a "perfect is the enemy of good" case here, but
while it didn't show up in discussions I did bring it up in the patch
comments themselves.
My main problem is I'm pretty sure this will break any non-user non-kvec
iov_iter; at the very least if we go that route we should guard the else
with is_kvec(), figure out what type of iov Chris gets and handle that
properly -- likely bvec? I still couldn't figure how to reproduce :/ --
and error out cleanly in other cases.

That's enough work that I figured switching boat wouldn't be much
different, and if nothing else I've learned -a lot- about the kernel
scatterlist, iov_iter and virtio APIs, so we can always say that time
wasn't wasted even if this patch ends up dropped.

The second problem that I'm reading between the lines of the replies is
that iov_iter_get_pages_alloc2() is more or less broken/not supported
for what we're trying to use it for, and the faster we stop using it the
less bugs we'll get.


(It's also really not such a huge patch, the bulk of the change is
removed stuff we no longer use and massaging the cleanup path, but
extract_iter_to_sg() is doing exactly what we were doing (lookup pages
and sg_set_page() from the iov_iter) in better (for some reason when I
added traces iov_iter_get_pages_alloc2() always stopped at one page for
me?! I thought it was a cache thing but also happens with cache=none, I
didn't spend time looking as this code will likely go away one way or
another)


> > This brings two major changes to how we've always done things with
> > virtio 9p though:
> > - We no longer fill in "chan->sg" with user data, but instead allocate a
> >   scatterlist; this should not be a problem nor a slowdown as previous
> >   code would allocate a page list instead, the main difference is that
> >   this might eventually lead to lifting the 512KB msize limit if
> >   compatible with virtio?
> 
> Remember that I already had a patch set for lifting the msize limit [2], which
> was *heavily* tested and will of course break with these changes BTW, and the
> reason why I used a custom struct virtqueue_sg instead of the shared sg_table
> API was that the latter could not be resized (see commit log of patch 3).
> 
> [2] https://lore.kernel.org/all/cover.1657920926.git.linux_oss@crudebyte.com/

Ugh, I'm sorry, it had completely slipped out of my mind...
And it was waiting for me to debug the RDMA issues wasn't it :/

FWIW I never heard back from former employer, and my lack of hardware
situation hasn't changed, so we can probably mark RDMA as deprecated and
see who complains and get them to look into it if they care...
(I'm really sorry about having forgotten, but while I never have much
time for 9p at any given moment if you don't hear back from me on some
subject you want to push please do send a reminder after a month or
so... It doesn't excuse my behavior and if we had any other maintainer
active that might improve the situation, but at least it might prevent
such useful patches from being forgotten while waiting on me)

(... actually now I'm done re-reading the patches we've already applied
patch 10/11 that could impact RDMA, and the rest is specific to virtio,
so there's nothing else that could go wrong with it as far as this is
concerned?...)



OTOH I've learnt a lot about the scatterlist API meanwhile,
and I don't necessarily agree about why you've had to basically
reimplement sg_table just to chain them (what you described in
patchset 3:
> A custom struct virtqueue_sg is defined instead of using
> shared API struct sg_table, because the latter would not
> allow to resize the table after allocation. sg_append_table
> API OTOH would not fit either, because it requires a list
> of pages beforehand upon allocation. And both APIs only
> support all-or-nothing allocation.
)
Having looked at sg_append_table I agree it doesn't look appropriate,
but I think sg_table would work just fine -- you can call sg_chain on
the last element of the table.
It'll still require some of the helpers you introduced, but the
virtqueue_sg type can go away, and we'd just need to loop over
extract_iter_to_sg() for each of the sg_table "segment".

If I'm not mistaken here, then the patches aren't that incompatible, and
it's something worth doing in one order or the other.



Anyway, what now?
I'm happy to delay the switch to extract_iter_to_sg() to after your
virtio msize rework if you want to send it again, but I don't think it's
as simple as picking up the v1.

I've honestly spent too long on this for this weekend already, so
I'll log off for now but if you have any suggestion I'm all ears.

Thanks,
-- 
Dominique Martinet | Asmadeus

