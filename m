Return-Path: <linux-fsdevel+bounces-55636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D05B0D13E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDCB542AF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 05:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93EB28BA9D;
	Tue, 22 Jul 2025 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Z+fJsQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51D139D;
	Tue, 22 Jul 2025 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162332; cv=none; b=t2NX56yxHNM8k6fvyEiQbEfBvmJwYtAUfVM5d/WW8cdnt5xbG+xiKcjP9Sgxw53Nw2YHNYF32yMruGuPj7oNpV1FPt+AtVUhxZT1heopVpHDORbZ3jtSB9Qvfxqcrx7cTijl2605TtUbFXK5IhUCIfRPQn9XBu5W7HYB3qnRa4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162332; c=relaxed/simple;
	bh=PNkgmpPWJ/bnwyVA0BJh8AsSxjv1T+LdF+uYwnwkQCI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhC7OGyM1/nu1uq49lMNhwqQ1U0oV3l5yI6bACsEvCN32vRz4XEuuFeySoAcBc/2HnOG7IMfGbEYTEjcNbAuz3r3kwrcn3i+FKIuEpj5sS+s0bWqkGG7S4HAxHjghtLBleLmXbBmvjar1yAbbtBWBbCzIs1snueMHJK3G17XdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Z+fJsQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C51DC4CEEB;
	Tue, 22 Jul 2025 05:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753162331;
	bh=PNkgmpPWJ/bnwyVA0BJh8AsSxjv1T+LdF+uYwnwkQCI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=1Z+fJsQ8evQLbrUCFali2bUUDFIuycrf74MPxsHpAtiGZ/5LIj5qynBjP5etKmAvB
	 uthsZTQ+72AdWnkC0mL9CJ0QM8ZXQzG1G4XojevV/ZbsZ56RbShDxv5iw5YvyfPm1o
	 V4EInzekubs7M4KbcC+nWnx6/HDAz8ozQYj8zV6E=
Date: Tue, 22 Jul 2025 07:32:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, kernel@collabora.com,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Excessive page cache occupies DMA32 memory
Message-ID: <2025072238-unplanted-movable-7dfb@gregkh>
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>
 <aH51JnZ8ZAqZ6N5w@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH51JnZ8ZAqZ6N5w@casper.infradead.org>

On Mon, Jul 21, 2025 at 06:13:10PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 21, 2025 at 08:03:12PM +0500, Muhammad Usama Anjum wrote:
> > Hello,
> > 
> > When 10-12GB our of total 16GB RAM is being used as page cache
> > (active_file + inactive_file) at suspend time, the drivers fail to allocate
> > dma memory at resume as dma memory is either occupied by the page cache or
> > fragmented. Example:
> > 
> > kworker/u33:5: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> 
> Just to be clear, this is not a page cache problem.  The driver is asking
> us to do a 512kB allocation without doing I/O!  This is a ridiculous
> request that should be expected to fail.
> 
> The solution, whatever it may be, is not related to the page cache.
> I reject your diagnosis.  Almost all of the page cache is clean and
> could be dropped (as far as I can tell from the output below).
> 
> Now, I'm not too familiar with how the page allocator chooses to fail
> this request.  Maybe it should be trying harder to drop bits of the page
> cache.  Maybe it should be doing some compaction.  I am not inclined to
> go digging on your behalf, because frankly I'm offended by the suggestion
> that the page cache is at fault.
> 
> Perhaps somebody else will help you, or you can dig into this yourself.

I'm with Matthew, this really looks like a driver bug somehow.  If there
is page cache memory that is "clean", the driver should be able to
access it just fine if really required.

What exact driver(s) is having this problem?  What is the exact error,
and on what lines of code?

thanks,

greg k-h

