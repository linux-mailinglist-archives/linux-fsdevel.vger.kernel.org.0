Return-Path: <linux-fsdevel+bounces-8154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72764830626
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 13:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE113B23A2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 12:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB181EB29;
	Wed, 17 Jan 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7cFgmL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1311EA78;
	Wed, 17 Jan 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496006; cv=none; b=ETJQNbr3iDwYT5VY7QyVbbfLhOquXIY2RjPD2YCRLo0Hotn9q87LGKp6OlFivOv0FHJJFFK6rNL7eCTkGjT7wyqtE48vUeVw8fDRVjMEzq9jPEH2IuRTrVKY6ZoPaeWg/pEEHTQ+Htg/D3C38R47irosb7s5pvXFWhoj96TcV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496006; c=relaxed/simple;
	bh=hWAj3YQZH9p33cTAw36cmAlNwzzD/NP4yLUNIW0Rh8k=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=aDcrDJF9CqB2fZvrZ/wJ1CN/Yav0txbFdl4J4dfWjoKT19iKK6fIDoH1EPjJieQDvbjAUqpqT1za3LL+teyJ3iW+94YOaJsEDqzd5CNYs5K2wkWFKJ/BBidQX++co6qMz1EZ6HNrghmgrlF8FO8o7pQ27gfKupQ1FweI/TCpOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7cFgmL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B42C433F1;
	Wed, 17 Jan 2024 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705496005;
	bh=hWAj3YQZH9p33cTAw36cmAlNwzzD/NP4yLUNIW0Rh8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7cFgmL/Wat6jQr1sryT918dhwArrwTVsHZTTpB6gowV80fyko3TIJkRMK4U9lEtG
	 qRjg0U8ICgd2FGleVLcrEF1vp4EpYWMFgoLZgRc9Uyqmjyk3rEflh6A2zX1EEuCo4Y
	 adxPAUWA5BsKyc4fmQ1XaU+Ordr0IPkMcp4z1do+FiqG2l6Ecx83v7b20pJMWfgrwS
	 xp5zMAhdDlLYXw2EGbyD4rXWm2DrNPXf1jdr58NeI3loGrFLZ/EGwOuFHU45V1b+Fo
	 wh3l6QxCoqx0RKcxEMLCAR0Uhr/SoRrD9CkIHnDcOYBJevlfE5+5Zdop1qH1OC2o6a
	 9kOAlXToAngog==
Date: Wed, 17 Jan 2024 13:53:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240116114519.jcktectmk2thgagw@quack3>

On Tue, Jan 16, 2024 at 12:45:19PM +0100, Jan Kara wrote:
> On Tue 16-01-24 11:50:32, Christian Brauner wrote:
> 
> <snip the usecase details>
> 
> > My initial reaction is to give userspace an API to drop the page cache
> > of a specific filesystem which may have additional uses. I initially had
> > started drafting an ioctl() and then got swayed towards a
> > posix_fadvise() flag. I found out that this was already proposed a few
> > years ago but got rejected as it was suspected this might just be
> > someone toying around without a real world use-case. I think this here
> > might qualify as a real-world use-case.
> > 
> > This may at least help securing users with a regular dm-crypt setup
> > where dm-crypt is the top layer. Users that stack additional layers on
> > top of dm-crypt may still leak plaintext of course if they introduce
> > additional caching. But that's on them.
> 
> Well, your usecase has one substantial difference from drop_caches. You
> actually *require* pages to be evicted from the page cache for security
> purposes. And giving any kind of guarantees is going to be tough. Think for
> example when someone grabs page cache folio reference through vmsplice(2),
> then you initiate your dmSuspend and want to evict page cache. What are you
> going to do? You cannot free the folio while the refcount is elevated, you
> could possibly detach it from the page cache so it isn't at least visible
> but that has side effects too - after you resume the folio would remain
> detached so it will not see changes happening to the file anymore. So IMHO
> the only thing you could do without problematic side-effects is report
> error. Which would be user unfriendly and could be actually surprisingly
> frequent due to trasient folio references taken by various code paths.

I wonder though, if you start suspending userspace and the filesystem
how likely are you to encounter these transient errors?

> 
> Sure we could report error only if the page has pincount elevated, not only
> refcount, but it needs some serious thinking how this would interact.
> 
> Also what is going to be the interaction with mlock(2)?
> 
> Overall this doesn't seem like "just tweak drop_caches a bit" kind of
> work...

So when I talked to the Gnome people they were interested in an optimal
or a best-effort solution. So returning an error might actually be useful.

I'm specifically put this here because my knowledge of the page cache
isn't sufficient to make a judgement what guarantees are and aren't
feasible. So I'm grateful for any insight here.

