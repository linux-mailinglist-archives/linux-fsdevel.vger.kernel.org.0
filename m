Return-Path: <linux-fsdevel+bounces-22027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C2791117B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29101C20F81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295251B47DD;
	Thu, 20 Jun 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y4r8hLSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6431AD48B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909637; cv=none; b=UQyjKoSHCwO5R0OjD9pTvksPH9MM0MF+QOM+lO9Qn6xGxc8m1Xjjz3/zaFNt76dwwTBJHJSmz2CIuRzEjXlj0w6oZASn45/fdTr/M5zPOmP24+1kSPv0l6cKavqvHPnDBJJZjK/kI45xXt9z3Ef81XLBiQWTMWfdxlKexFbC7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909637; c=relaxed/simple;
	bh=tP3M44smT6hPThsdntX6Te5+Dmb1eLfWnWlQN6wRAh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KihI32I8YK0y3KEiITFDcv+KNNw+1yCaKm+0wam+iz0FkmfuIVNjoTXt/OCimP73g2AHHHNmaGgCbGG1aaHZNZOSc4hMlaqCG1RyEIDCAZNL0zR5iAnW4MKTlDDZV6cgpvpGjXjUSa8MepGG4QYf3z3bDw3b0x1yIs2tpaHgumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y4r8hLSB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718909632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sRBiphzu+DEvlRapPGKgRN5h8VZ/w+ozHV4I9S52NI=;
	b=Y4r8hLSBnsTzMBl3+Ue+EOal0znqrEIEaoYO96nJjAYNDVgsd5FsJCOLGU0xgGvKlM6f/p
	vR/3xLmAPs0/Jzvac2tQZ4H2oY3s8XNBIkN+jj3QPULcwknRGHhqXMyhFgkruxiNNKyeYB
	10/jvU8guS9fuUHx7sa6XDcDJigA2yA=
X-Envelope-To: willy@infradead.org
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: x86@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 20 Jun 2024 14:53:48 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FYI: path walking optimizations pending for 6.11
Message-ID: <244rgai7qaxizd5tqbqns5atotjdsoaw2ofw7doi5hrkboegy3@zqch5vluoumn>
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
 <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 19, 2024 at 03:08:47PM -0700, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 13:45, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Funnily, I'm working on rosebush v2 today.  It's in no shape to send out
> > (it's failing ~all of its selftests) but *should* greatly improve the
> > cache friendliness of the hash table.  And it's being written with the
> > dcache as its first customer.
> 
> I'm interested to see if you can come up with something decent, but
> I'm not hugely optimistic.
> 
> From what I saw, you planned on comparing with rhashtable hash chains of 10.
> 
> But that's not what the dentry cache uses at all. rhashtable is way
> too slow. It's been ages since I ran the numbers, but the dcache array
> is just sized to be "large enough".
> 
> In fact, my comment about my workload being better if the hash table
> was smaller was because we really are pretty aggressive with the
> dcache hash table size. I think our scaling factor is 13 - as in "one
> entry per 8kB of memory".
> 
> Which is almost certainly wasting memory, but name lookup really does
> show up as a hot thing on many loads.
> 
> Anyway, what it means is that the dcache hash chain is usually *one*.
> Not ten. And has none of the rhashtable overheads.
> 
> So if your "use linear lookups to make the lookup faster" depends on
> comparing with ten entry chains of rhashtable, you might be in for a
> very nasty surprise.
> 
> In my profiles, the first load of the hash table tends to be the
> expensive one. Not the chain following.
> 
> Of course, my profiles are not only just one random load, they are
> also skewed by the fact that I reboot so much. So maybe my dentry
> cache just doesn't grow sufficiently big during my testing, and thus
> my numbers are skewed even for just my own loads.
> 
> Benchmarking is hard.
> 
> Anyway, that was just a warning that if you're comparing against
> rhashtable, you have almost certainly already lost before you even got
> started.

The main room I see for improvement is that rhashtable requires two
dependent loads to get to the hash slot - i.e. stuffing the table size
in the low bits of the table pointer.

Unfortunately, the hash seed is also in the table.

If only we had a way to read/write 16 bytes atomically...

