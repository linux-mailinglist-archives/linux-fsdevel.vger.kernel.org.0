Return-Path: <linux-fsdevel+bounces-73129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A83D0D070
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 07:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2692930034B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 06:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBA3385B1;
	Sat, 10 Jan 2026 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Op07DxHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B696BB5B;
	Sat, 10 Jan 2026 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768025687; cv=none; b=AwLFwCWNp0G6sA0nCwViA/vLBBGw6GX4fO640NWSETvJUJienJ7Xfrs3ynmkOIOH6RZuN0+01kvpPEfpaVGrr4fqau2vuoXCCqySu41ov3eWm4GxBMDkKh0O4BMV6BbQjYldPFsVcJ/G4lke0iDmAieOuyvxqREg+LfSbcUeEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768025687; c=relaxed/simple;
	bh=3dFbSxt6kYFEmTEY/5EHq7dOLGvKjzFeCmSuXv1fF/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETH+X/H6LOu72ViNNZgq4Al0gahH5piRi4kf4DKrUdMj4KkesozD3zJQxYqzhhdoBkIIysZ/1WZm+UWB7QZuJNQZeOa8TlITvnL3wqIXKpn6dSlDhsJLERxav0RSH0/Gs5fz4AFsbv6Z5yUbt6IQbBhlouwt0zqD8SZlYookzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Op07DxHr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FOhqKXHOHZ1Z6TQIHPMQELoPwFKMupQNtk/UZRAYy4E=; b=Op07DxHryHEQHOQfCxhuLT0fY9
	WNaAXKfd9891rqZM+6MEvtsS+Fe/U+xGzEbYU7ODsh6NPEIyQDzwsNG0fvwrPa5u68baOnLZM0aiY
	I6LdC/gHGicIJOigkt7R6CeVn+VYPBdQFoMXcBbssAwPQ8FSDCVbxB1RwgJLyP3LZQOvh2mWVh0Jz
	6v4DIx4k6FLMGlnfC/sHajw1Fuju9A+8YgrHhmKSW2OmKXiHxSK0mugHRudzUtZ5sY0BoSC4gtbHi
	XI29GLxeUyHBe5/Og/FaWixZO7HQS1O50EDNt7TaBZvvYCpaIvH5na5lrZKk5P61QllGPOA58pXMu
	OrsqIdIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veSGW-000000099BJ-3qur;
	Sat, 10 Jan 2026 06:16:01 +0000
Date: Sat, 10 Jan 2026 06:16:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage
 duration
Message-ID: <20260110061600.GB3634291@ZenIV>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <CAHk-=wiibHkNcsvsVpQLCMNJOh-dxEXNqXUxfQ63CTqX5w04Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiibHkNcsvsVpQLCMNJOh-dxEXNqXUxfQ63CTqX5w04Pg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 09, 2026 at 07:33:41PM -1000, Linus Torvalds wrote:
> On Fri, 9 Jan 2026 at 18:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         There's an alternative approach applicable at least to the caches
> > that are never destroyed, which covers a lot of them.  No matter what,
> > runtime_const for pointers is not going to be faster than plain &,
> > so if we had struct kmem_cache instances with static storage duration, we
> > would be at least no worse off than we are with runtime_const variants.
> 
> I like it. Much better than runtime_const for these things.
> 
> That said, I don't love the commit messages. "turn xyzzy
> static-duration" reads very oddly to me, and because I saw the emails
> out of order originally it just made me go "whaa?"
> 
> So can we please explain this some more obvious way. Maybe just "Make
> xyz be statically allocated". Yes, I'm nitpicking, but I feel like
> explaining core patches is worth the effort.

Point, but TBH the tail of the series is basically a demo for conversions
as well as "this is what I'd been testing, FSVO".  In non-RFC form these
would be folded into fewer commits, if nothing else...

I'd really like to hear comments on the first two commits from SLAB
maintainers - for example, if slab_flags_t bits are considered a scarce
resource, the second commit would need to be modified.  Still doable, but
representation would be more convoluted...

Another question is whether it's worth checking for accidental call
of e.g. kmem_cache_setup() on an already initialized cache, statically
or dynamically allocated.  Again, up to maintainers - their subsystem,
their preferences.

