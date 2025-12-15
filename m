Return-Path: <linux-fsdevel+bounces-71356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66777CBF0EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D36FD3001835
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C713A3321C5;
	Mon, 15 Dec 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Abzo8vkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D870332EDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817202; cv=none; b=nkWbkI6BsFvFPE5CzXBmBsNdOl+bzi8KNOyXqt8SmrHojGn8l85Kc1GRROtYx8d0lax/beNhJL5Kgv+aJuh4/C6uKRlGhGyb/TYn4aC0dnYIyci96quElTIFdJsB1/LSEQUlGy3PNczNEc695P5nn/pZf+K/qpbVlFRQ+InxYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817202; c=relaxed/simple;
	bh=0qPtXJRp3OJPSd/o8yFmg/Io2rTT/KEiiswkpXq8Qi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZHYaVv2XVXlDBroIF5Hcapupy9ZQ7OrXmfqJ+IXQs1xRUQEhAPsEMuk54SuliNlBJmhTwIwp0i/oRgH3h4URk4G/tlgv+KB7TgaeRwzHxnO1wwJLtzkMAo7uE/Oz4uHrB4VFGBYI1UAA1SSGtIzip+MBvMnRoEVaw00lC1mnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Abzo8vkD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c75dd36b1bso3049015a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 08:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1765817198; x=1766421998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SoCDHDPheLIuvfNyBhqCR3ZYhOapE4jht+oC8y0apU=;
        b=Abzo8vkDPDMFXRvv6OOYItSdBJm0AnGzItqRF7L4tw1QT/K7SfH4L6rbN0K5YdapPW
         rZdRzAz61ymiUnz7WDKLNraevaiWJFxQqMMcZt9kIk8N5pfMpQVm+M6esCZx2J6P75Zi
         9etGmW2i62hQzraZwZEi8O1KuBLaTMdAtUApvpjmK9Fu7tb9l9dG/alxagiNUEEP8hnZ
         G+ODmliANYD46QUNQzfBMogRaBaKFz6ok9gDpgs6hBYQnM3KG9Zyyj8oHlyn7PxuQR2O
         u+73C2a7dWv+/B7ADVG7t7XHjWjtwShPSOpwqCitqB0edVp1uZ1m7/s8SPriLx6Vt60j
         s6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765817198; x=1766421998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SoCDHDPheLIuvfNyBhqCR3ZYhOapE4jht+oC8y0apU=;
        b=PgV2zIxOHa92horNgenlUJe6ZEQuhvBtyjpTEjMpx8uLG7fctiYwwuGUgT9uaH0tU4
         6PpQuqIh6gzWDq1VHsh2fcP1pMyswjiVsoDfqQIHFsWxUfAhD8uGV8twgqfuIEhUdQj8
         nGiIjOtg8bjoL2log0F70x+S0RtoQ5MYwimihnuemqWWXa12oSBVagTkA4mIXhXQbPM9
         bRivZhADEdn1yM/3i00V0dvL3uQ0PxbE6klLiHo0ac+rj0ARQeY7R2HAckq2vbpFSiwq
         EuB35o8Dn2qfniSN0MkcjcQczxoAEf7/GGvOOnnirT5y67/IgmaBWy33OyRc8FGe9HKq
         WWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN3RP6465Kjv/NzuFpKN8PrgszGxSyC8O1IkyhZg/X+rbcHgMQofADVmEnRQJ4kfcQxWoVhQFLVUXcwj+v@vger.kernel.org
X-Gm-Message-State: AOJu0YywhecXWJE1xh7/A8rf/FZQLqG12gEH8A9ok0H9s/xNr7jE7m3I
	NOz3pYkqSCGFfciT5fLoJpx5Q0quz50KYcact5OJsRJBs6XubuD1eqfxJWTRWLEnU04z/dK+ftF
	lwcceJn4qkQ==
X-Gm-Gg: AY/fxX7kBc/3vgjQJhvDQwNuOB8ijZJP8solx7P11sAGVrcUAxSBJLWlB91CBNSuAUT
	mV3GEgN724hNa5QoEq/N3GIXEcQv/P2Jg7pBniGejM4wyHcjksErg8sda3LWbh7lDj10oe41ER0
	yfDKhqa7pD27FpO8t6Tdg3XXNTP0WjQ+k4LEHbLFDcb3DWJpMDh6OkLIk8//uV9zJ4WLVS7eJrn
	pSLUpGkXGveSCiUbiPrcXamzdaAnqMhUuhgY0A11Tja6BxsaSy0uxmIRah0obGuc1pJUWX0mzCf
	X5U0oKE6YVRiisV7WscN9s/xnn5k4SKeyeH1HQJChOwkG9YJ34DZ7te64z+RPCaLRHG9pEFaSMN
	w+cdX++OeWJlNf/U+u6u76bjYYysz8HEBS5zwC5Ga6b05IsfR2T6oLlvfkUMHqbPvoIcEiQ==
X-Google-Smtp-Source: AGHT+IGn7h1f7+juW0DPeV9odWZu2HhRoumaEqzK4HN3WAhofgYoYohcZLYH8XSf9AQ4dU/zTy93pg==
X-Received: by 2002:a05:6830:4493:b0:74a:6ea5:a0ed with SMTP id 46e09a7af769-7cae83836e5mr6964283a34.33.1765817197817;
        Mon, 15 Dec 2025 08:46:37 -0800 (PST)
Received: from 861G6M3 ([2a09:bac1:76a0:540::2d4:95])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb2fcc39sm9701624a34.19.2025.12.15.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:46:36 -0800 (PST)
Date: Mon, 15 Dec 2025 10:46:34 -0600
From: Chris Arges <carges@cloudflare.com>
To: asmadeus@codewreck.org
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2] 9p/virtio: convert to extract_iter_to_sg()
Message-ID: <aUA7aqpEBWIN1lKQ@861G6M3>
References: <20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org>
 <22933653.EfDdHjke4D@weasel>
 <aT4PZUtvirfq3Lov@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT4PZUtvirfq3Lov@codewreck.org>

On 2025-12-14 10:14:13, asmadeus@codewreck.org wrote:
> 
> (Chris, sorry, I had dropped you from Ccs as you were Cc'd from the
> patch itself and not the header... See [1] for start of thread if you're
> interested)
> [1] https://lore.kernel.org/r/20251214-virtio_trans_iter-v2-1-f7f7072e8c15@codewreck.org
> 
>
No problem. Would it help if I tested this v2 patch? I still can easily
reproduce the problem.
 
> Christian Schoenebeck wrote on Sat, Dec 13, 2025 at 07:02:00PM +0100:
> > On Saturday, 13 December 2025 16:07:40 CET Dominique Martinet via B4 Relay wrote:
> > > This simplifies the code quite a bit and should fix issues with
> > > blowing up when iov_iter points at kmalloc data
> > > 
> > > RFC - Not really tested yet!!
> > 
> > TBH, that bothers me.
> 
> Well, that just means "don't bother spending time testing much (or
> debugging if you do test and run into bugs)" and it likely won't be
> merged as is -- this is enough to start discussions without wasting more
> time if this gets refused.
> 
> > Also considering the huge amount of changes; again, what
> > was actually wrong with the previously suggested simple patch v1 [1]? All I
> > can see is a discussion about the term "folio" being misused in the commit log
> > message, but nothing about the patch being wrong per se.
> > [1] https://lore.kernel.org/all/20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org/
> 
> I agree we're close to a "perfect is the enemy of good" case here, but
> while it didn't show up in discussions I did bring it up in the patch
> comments themselves.
> My main problem is I'm pretty sure this will break any non-user non-kvec
> iov_iter; at the very least if we go that route we should guard the else
> with is_kvec(), figure out what type of iov Chris gets and handle that
> properly -- likely bvec? I still couldn't figure how to reproduce :/ --
> and error out cleanly in other cases.
> 

If it helps I can work on a more isolated reproducer. Essentially I found
this when running some of our internal testing tools which spin up qemu VMs
and run kernel tests. I may be able to whittle that down to something
externally consumable.

> That's enough work that I figured switching boat wouldn't be much
> different, and if nothing else I've learned -a lot- about the kernel
> scatterlist, iov_iter and virtio APIs, so we can always say that time
> wasn't wasted even if this patch ends up dropped.
> 
> The second problem that I'm reading between the lines of the replies is
> that iov_iter_get_pages_alloc2() is more or less broken/not supported
> for what we're trying to use it for, and the faster we stop using it the
> less bugs we'll get.
> 
> 
> (It's also really not such a huge patch, the bulk of the change is
> removed stuff we no longer use and massaging the cleanup path, but
> extract_iter_to_sg() is doing exactly what we were doing (lookup pages
> and sg_set_page() from the iov_iter) in better (for some reason when I
> added traces iov_iter_get_pages_alloc2() always stopped at one page for
> me?! I thought it was a cache thing but also happens with cache=none, I
> didn't spend time looking as this code will likely go away one way or
> another)
> 
> 
> > > This brings two major changes to how we've always done things with
> > > virtio 9p though:
> > > - We no longer fill in "chan->sg" with user data, but instead allocate a
> > >   scatterlist; this should not be a problem nor a slowdown as previous
> > >   code would allocate a page list instead, the main difference is that
> > >   this might eventually lead to lifting the 512KB msize limit if
> > >   compatible with virtio?
> > 
> > Remember that I already had a patch set for lifting the msize limit [2], which
> > was *heavily* tested and will of course break with these changes BTW, and the
> > reason why I used a custom struct virtqueue_sg instead of the shared sg_table
> > API was that the latter could not be resized (see commit log of patch 3).
> > 
> > [2] https://lore.kernel.org/all/cover.1657920926.git.linux_oss@crudebyte.com/
> 
> Ugh, I'm sorry, it had completely slipped out of my mind...
> And it was waiting for me to debug the RDMA issues wasn't it :/
> 
> FWIW I never heard back from former employer, and my lack of hardware
> situation hasn't changed, so we can probably mark RDMA as deprecated and
> see who complains and get them to look into it if they care...
> (I'm really sorry about having forgotten, but while I never have much
> time for 9p at any given moment if you don't hear back from me on some
> subject you want to push please do send a reminder after a month or
> so... It doesn't excuse my behavior and if we had any other maintainer
> active that might improve the situation, but at least it might prevent
> such useful patches from being forgotten while waiting on me)
> 
> (... actually now I'm done re-reading the patches we've already applied
> patch 10/11 that could impact RDMA, and the rest is specific to virtio,
> so there's nothing else that could go wrong with it as far as this is
> concerned?...)
> 
> 
> 
> OTOH I've learnt a lot about the scatterlist API meanwhile,
> and I don't necessarily agree about why you've had to basically
> reimplement sg_table just to chain them (what you described in
> patchset 3:
> > A custom struct virtqueue_sg is defined instead of using
> > shared API struct sg_table, because the latter would not
> > allow to resize the table after allocation. sg_append_table
> > API OTOH would not fit either, because it requires a list
> > of pages beforehand upon allocation. And both APIs only
> > support all-or-nothing allocation.
> )
> Having looked at sg_append_table I agree it doesn't look appropriate,
> but I think sg_table would work just fine -- you can call sg_chain on
> the last element of the table.
> It'll still require some of the helpers you introduced, but the
> virtqueue_sg type can go away, and we'd just need to loop over
> extract_iter_to_sg() for each of the sg_table "segment".
> 
> If I'm not mistaken here, then the patches aren't that incompatible, and
> it's something worth doing in one order or the other.
> 
> 
> 
> Anyway, what now?
> I'm happy to delay the switch to extract_iter_to_sg() to after your
> virtio msize rework if you want to send it again, but I don't think it's
> as simple as picking up the v1.
> 
> I've honestly spent too long on this for this weekend already, so
> I'll log off for now but if you have any suggestion I'm all ears.
> 
> Thanks,
> -- 
> Dominique Martinet | Asmadeus

