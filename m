Return-Path: <linux-fsdevel+bounces-24932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A862946B93
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 02:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 910D5B21778
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30A138C;
	Sun,  4 Aug 2024 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wZoUX6dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586C18E
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722731650; cv=none; b=qPQy5JpO11xHGjVyzjbf93xvpbGnnlBgmEymWYyOGuaRMvKrwLIqogKBCahlL+/JdF2gZ1UrtMY/kQFSOIlgdcU+xZDxSTyR5mz+n6vszkrjZ+SwrdG0F3yRgd3YNYe7rWK4qtnFsx9hzyyjXwYY+swmSl5oW4yx8gp2Dkms9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722731650; c=relaxed/simple;
	bh=RcF6sE06Z5nfTJQvjT+tMZBGydQeZAE0rDC7OwHWdtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T159NUKd7OzdS1BT/bMpmNdniPB6sCkb4dI5xdshbx7FvS3H8RQ/XrEZfQpPFBYpS53UfBoLvPXPLkUjdozvLe3AokZ/LiF86GGml+7wVzB+A9TWHiO8ldW+/fCwC+kPoUMugFsRZEGm1jsrgcC3ODEIcfx4/JVld9wkqboMHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wZoUX6dh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e4xq3EJn0Xy07wmcbFknE+jif/WWiW5YIYBMfjIcQ0Q=; b=wZoUX6dhqaU8zfKYPnoE86GRns
	a4MxK25Ko947Dwh/ffqjQ7loP9C2Cb74GLKla+uLnCkxYFqvsn+pUZMvre6H+31SNv1TaO/c3H8l9
	zQXJcvbNdDCSQsemiwvXEllJkIlcmZIygJcRWC3nTbvlH+nkOP0c6U4GSOlx0QlhGm0hf+aTpqJF+
	zqJH5SuXjZ09dIp+AANQfOaTwfmKAozi2mZuYw6MF3jge0eKLqVF6JQXTSZi5qYvGzy8AcInnCSU7
	PaeNQtf3YBpo1mIUWqSIRUR2IpT20XL2lLsc5iaxb6I+/xM8V1xAFiuNM4SgOsrok0E0Ezi0MOVVz
	KmJxTG0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saPCH-00000001RDO-1i2h;
	Sun, 04 Aug 2024 00:34:05 +0000
Date: Sun, 4 Aug 2024 01:34:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240804003405.GA5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 03, 2024 at 04:51:44PM -0700, Linus Torvalds wrote:

> I think the code could (and should) do just
> 
>         cpy = count / BITS_PER_LONG;
>         max = nfdt->max_fds / BITS_PER_LONG;
> 
>         bitmap_copy(nfdt->full_fds_bits, ofdt->full_fds_bits, cpy);
>         bitmap_clear(nfdt->full_fds_bits, count, max - cpy);
> 
> or something like that.
> 
> Doesn't that seem more straightforward?

Considered that; unfortunately, bitmap_clear() is... suboptimal,
to put it mildly.  And on the expand_fdtable() pathway (as well
as normal fork()) we might have to clear quite a bit.

> Of course, it's also entirely possible that I have just confused
> myself, and the above is buggy garbage. I tried to think this through,
> but I really tried to think more along the lines of "how can we make
> this legible so that the code is actually understandable". Because I
> think your patch almost certainly fixes the bug, but it sure isn't
> easy to understand.

Bitmap handling in there certainly needs to be cleaned up; no arguments
here.  If anything, we might want something like

bitmap_copy_and_extend(unsigned long *to, const unsigned long *from,
			unsigned int count, unsigned int size)
{
	unsigned int copy = BITS_TO_LONGS(count);

	memcpy(to, from, copy * sizeof(long));
	if (count % BITS_PER_LONG)
		to[copy - 1] &= BITMAP_LAST_WORD_MASK(count);
	memset(to + copy, 0, bitmap_size(size) - copy * sizeof(long));
}

and use it for all of three bitmaps.  Compiler should be able to spot
CSEs here - let it decide if keeping them is cheaper than reevaluating...
Would you hate
static void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
                            unsigned int count, unsigned int size)
{
	bitmap_copy_and_extend(nfdt->open_fds, ofdt->open_fds,
				count, size);
	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
				count, size);
	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
				count / BITS_PER_LONG, size / BITS_PER_LONG);
}
with callers passing nfdt->size as the 4th argument?

Said that, the posted variant might be better wrt backporting - it has
no overhead on the common codepaths; something like the variant above
(and I think that use of bitmap_clear() will be worse) would need
profiling.  So it might make sense to use that for backports, with
cleanups done on top of it.  Up to you...

FWIW, I'm crawling through fs/file.c at the moment (in part - to replace
Documentation/filesystems/files.rst with something that wouldn't be
years out of date), and there's a growing patch series around that
area.  This thing got caught while trying to document copy_fd_bitmaps()
and convince myself that it works correctly...

