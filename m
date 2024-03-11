Return-Path: <linux-fsdevel+bounces-14091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE88779C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 03:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF921F21A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399772919;
	Mon, 11 Mar 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aDY1vM1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039F138E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710123171; cv=none; b=GrkZGHO2/hMHwrLmg3hFZ8E2stG6uSQ8ZyO3YeYGy5dYg5aB9zQ1yujl7TmJhRnTME7EA35AjWspoiM3v1IvjdqEI0sDN0Z9d6lx7ZbU08mwRvPizt0dCzIKHdl6h9uoVPlW4u/dGNGvQFGJTbzedHWCwj8sw4WecA/9SpaLFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710123171; c=relaxed/simple;
	bh=ut92GWDbkVL4s/+Tc5gm+lbY9BAwJJQ/aiUMQfIxDn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMmmgi+q2DbdxHEuE0jlnaDO+Wr5NW0tAlEatPGkmLHf1jJx0yk84L1SxZen/9uIklkY++r/p4bXg6xGnCvUaMfSAj/3Jrx2jzT3jnkOyb4fASVcOv9PE7nQacQvcoeLfxgYgb3OQqdZiOdIpgx5mFE5vbNdIbT70jMNcIjlJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aDY1vM1H; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2218da9620cso2128865fac.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710123169; x=1710727969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5X/JUyfTxQT9RfC2ug9/o+GQees7fe0KS52UCEy/Y4=;
        b=aDY1vM1HL3xHTq7vTtzAUapvSntjg9ITXTzVJ9jg79pTl3KaNtmjFcjR4Wf12B6pkj
         Gp3nix7fplYebJoGbQAtd16JL/WMZxc8FV+3tNCYnKXxZxPyy1X4xiTzaOI7NNLkhi+m
         19hQH5SWGwop1lHteDnf1UZ3kFTS1m4WKVUWjTomYU4OkqSlga7/oec++lBE/kQ9Twpa
         3MmhpPnEKBV4i9TLKZFNYjRNALBrCuiXaDywznRdv9gcn0D0ZBHnK7SVl0I8rn845vBI
         lM/gsUPS8KG4IlUO0+Ry9l+ftOoeUxAZK7XUlJsk5/K+Zz9ljL4n3MplCSNd9Q7XGss0
         /gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710123169; x=1710727969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5X/JUyfTxQT9RfC2ug9/o+GQees7fe0KS52UCEy/Y4=;
        b=vrZ+V5YMVETgOlZCy/HFRfyRGiB6hdzx9I6vYByogaM7Q7aL+l52XPhyaIqd9nHZAD
         oM1skWOYMDB0B/fgix9QuuS3D3hpikbdgmLGr2vZXA8OgLuRHjMP5rrBRXKFwwPTr+UJ
         aOMwlzGoOf6Gz4C4igL1fQr5/sj9eC77erVNxKLbZ8NeqNdzchZoFK6HtbsBPyjHO+MP
         WX8KEUHidVmGqM3ITaBlL6KbP+KDFXKpBIkYIXMZ2xxHS+VyGAJFq8In+z/PCvdYBYM4
         hIljUeOT6haoUw+QPXm4bYseaW7A+9tnUHMKnX01buAX7X+D7ZRsrzBXxd6wPz9LLyHv
         Ekaw==
X-Forwarded-Encrypted: i=1; AJvYcCU08jrEG5k2PRmI0lsrhWiOTPIjm/AvRJuXAbtY4TbvNASNt9LCe0Zz7RKaG0axnIpSEtkp1XYUAFuP29S4A/DuQEywZg9d/bTJZfHmWw==
X-Gm-Message-State: AOJu0Yz8u97weumxVA0vFV7ONXXnnei0bfilKgF6+hLMK+f+oR97M1Hi
	hQ3Qh2ONBAkMbZNssLs1E1lwcSf9JxUSPDDuTYFWhWo5uFmWYZpIBlAVxIeDNa7oI0+71yjJcFy
	o
X-Google-Smtp-Source: AGHT+IG4+A1cVfYNN4zWw1iLg4uYer2MBhOZ4XSCvr2zHDKMkHOO0oaFFVTsgoKhh5AZRadLaRhaQg==
X-Received: by 2002:a05:6870:b688:b0:221:95d6:c3d1 with SMTP id cy8-20020a056870b68800b0022195d6c3d1mr6138583oab.37.1710123168605;
        Sun, 10 Mar 2024 19:12:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00038c00b006e57247f4e5sm3160809pfs.8.2024.03.10.19.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:12:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjV9h-000G8X-1P;
	Mon, 11 Mar 2024 13:12:45 +1100
Date: Mon, 11 Mar 2024 13:12:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: On the optimum size of a batch
Message-ID: <Ze5onaXsI+LT1+Be@dread.disaster.area>
References: <Zeoble0xJQYEAriE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zeoble0xJQYEAriE@casper.infradead.org>

On Thu, Mar 07, 2024 at 07:55:01PM +0000, Matthew Wilcox wrote:
> I've had a few conversations recently about how many objects should be
> in a batch in some disparate contextx, so I thought I'd write down my
> opinion so I can refer to it in future.  TLDR: Start your batch size
> around 10, adjust the batch size when measurements tell you to change it.
> 
> In this model, let's look at the cost of allocating N objects from an
> allocator.  Assume there's a fixed cost, say 4 (units are not relevant
> here) for going into the allocator and then there's a 1 unit cost per
> object (eg we're taking a spinlock, pulling N objects out of the data
> structure and releasing the spinlock again).
> 
> Allocating 100 * 1 objects would cost 500 units.  Our best case is that
> we could save 396 units by allocating a batch of 100.  But we probably
> don't know how many objects we're going to need to allocate, so we pull
> objects from the allocator in smaller batches.  Here's a table showing
> the costs for different batch sizes:
> 
> Batch size      Cost of allocating 100          thousand        million
> 1               500 (5 * 100)                   5000            5M
> 2               300 (6 * 50)                    3000            3M
> 4               200 (8 * 25)                    2000            2M
> 8               156 (12 * 13)                   1500            1.5M
> 16              140 (20 * 7)                    1260            1.25M
> 32              144 (36 * 4)                    1152            1.13M
> 64              136 (68 * 2)                    1088            1.06M
> 128             132 (132 * 1)                   1056            1.03M

Isn't this just repeating the fundamental observation that SLUB is
based on?  i.e. it can use high-order pages so that it can
pre-allocate optimally sized batches of objects regardless of their
size? i.e.  it tries to size the backing page order to allocate in
chunks of 30-40 objects at a time?

> You can see the knee of this curve is around 8.  It fluctuates a bit after
> that depending on how many "left over" objects we have after allocating
> the 100 it turned out that we needed.  Even if we think we're going to
> be dealing with a _lot_ of objects (the thousand and million column),
> we've got most of the advantage by the time we get to 8 (eg a reduction
> of 3.5M from a total possible reduction of 4M), and while I wouldn't
> sneeze at getting a few more percentage points of overhead reduction,
> we're scrabbling at the margins now, not getting big wins.

Except for SLUB we're actually allocating in the hundreds of
millions to billions of objects on machines with TBs of RAM. IOWs we
really want to be much further down the curve than 8 - batches of at
least 32-64 have significantly lower cost and that matters when
scaling to (and beyond) hundreds of millions of objects....

> This is a simple model for only one situation.  If we have a locking
> contention breakdown, the overhead cost might be much higher than 4 units,
> and that would lead us to a larger batch size.
> 
> Another consideration is how much of each object we have to touch.
> put_pages_list() is frequently called with batches of 500 pages.  In order
> to free a folio, we have to manipulate its contents, so touching at least
> one cacheline per object.

Right, that's simply the cost of the batch cache footprint issue
rather than a "fixed cost mitigation" described for allocation.

So I'm not sure what you're trying to say here? We've known about
these batch optimisation considerations for a long, long time and
that batch size optimisation is always algorithm and access pattern
dependent, so.... ???

> And we make multiple passes over the batch,
> first decrementing the refcount, removing it from the lru list; second
> uncharging the folios from the memcg (writes to folio->memcg_data);
> third calling free_pages_prepare which, eg, sets ->mapping to NULL;
> fourth putting the folio on the pcp list (writing to the list_head).

Sounds like "batch cache footprint" would be reduced by inverting
that algorithm and doing all the work on a single object in a single
pass, rahter than doing it in multiple passes.  That way the cache
footprint of the batch is determined entirely by the size of the
data structures accessed to process each object in the batch.

i.e. if you are going to take an L1 cache miss accessing every
object in the batch anyway, then reducing batch size doesn't improve
overall per-object processing efficiency. All it does is keep the
processing cost down to a single L1 cache miss per object in the
batch. The tradeoff for this is more frequent batch refills, so this
only works is the additional fixed cost for obtaining each batch is
lower than the cost of multiple L1 cache misses per object....

All this says to me is that sometimes the batch size is not actually
the problem that needs fixing - changing the algorithm
and/or processing pipeline to remove the possiblity of repeated
accesses to individual objects in the batch reduces selecting the
batch size down to the same "fixed cost mitigation" case you started
with....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

