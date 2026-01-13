Return-Path: <linux-fsdevel+bounces-73397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780AD17967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB672304A92E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1538A721;
	Tue, 13 Jan 2026 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAo2cDnY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985631D72D;
	Tue, 13 Jan 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296020; cv=none; b=Le2s3KYHVPp2sPgETQ4W9Dvk3MhlbqW5S3tNa5+NTg3kwUIXisFL1DcuH26zgdYmSrgk1UDwgIIcui2UfMG48NLMSiESMkXcPiRhcawCJHBqjY7BlRbv0Yl9O9DWEHg9AcooU177UihTgtvX4ZNWuIWRvCPnHmce61weS93dE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296020; c=relaxed/simple;
	bh=q8A4bDhi22pwhQ+jihqXhH+oXB2ePdZdau55pPBPme0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYe6hCyz802xDgvnyMltmrJjFRe+fceTUtaJbpBV+ciq78hXr1TEVY7IzS2FVhkxVzZ4wUaA++ijQ0r0pNdM63N5Hzb6aMGpoIyJJ2QCqn2jxhTVpKc9mkS6FlW8oZgpSaSZLyruo6WmwZwwfR7nBYpPB/ffjH8O94Hp8CX86ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAo2cDnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0261C116C6;
	Tue, 13 Jan 2026 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296019;
	bh=q8A4bDhi22pwhQ+jihqXhH+oXB2ePdZdau55pPBPme0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAo2cDnY7o9wrg0sR1RKux8ykUxvt3AbOqbL/AyoEL+mcoC/90rdHEFPZ+gfyjssr
	 7Drx8K3zUrVkGguOPi78TzCZeitUp+JMjOrlequGdkRj//IXQhWHz/aX02qix/c5AM
	 cJ397YmrRYh+mNozHtQvHW6mzHcYBXARy4mO8jYKdNZ47NrTQUW1NEyNuJfiPVm6Iw
	 tABmfY07cydoqT2g9nmyCmxmpywX0cqO5A9cuAxc3DXndgOjoi++f39lNSygCtYIxM
	 lJ/k5jnuNsUxsONycZYaT6ARlz44k8E2wnn3bd8wgDoIz6z3RLQGzCIEJwQ1FQDjrQ
	 JobbYacTT1Vhg==
Date: Tue, 13 Jan 2026 10:20:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Zhiyu Zhang <zhiyuzhang999@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
Message-ID: <20260113-rammen-unsinn-d9d5929ca2a0@brauner>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
 <87secph8yi.fsf@mail.parknet.co.jp>
 <87ms2idcph.fsf@mail.parknet.co.jp>
 <CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
 <20260112095230.167359094e9c48577b387e18@linux-foundation.org>
 <87cy3ed7c9.fsf@mail.parknet.co.jp>
 <20260112103959.e5e956cd0d8b6f904e21827a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112103959.e5e956cd0d8b6f904e21827a@linux-foundation.org>

On Mon, Jan 12, 2026 at 10:39:59AM -0800, Andrew Morton wrote:
> On Tue, 13 Jan 2026 03:16:54 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> 
> > Andrew Morton <akpm@linux-foundation.org> writes:
> > 
> > > On Tue, 13 Jan 2026 01:45:18 +0800 Zhiyu Zhang <zhiyuzhang999@gmail.com> wrote:
> > >
> > >> Hi OGAWA,
> > >> 
> > >> Sorry, I thought the further merge request would be done by the maintainers.
> > >> 
> > >> What should I do then?
> > >
> > > That's OK - I have now taken a copy of the patch mainly to keep track
> > > of it.  It won't get lost.
> > >
> > > I thought Christian was handling fat patches now, but perhaps that's a
> > > miscommunication?
> > 
> > Hm, I was thinking Andrew is still handling the fat specific patch, and
> > Christian is only handling patches when vfs related.
> > 
> > Let me know if I need to do something.
> 
> OK, thanks, seems I misremembered.

I prefer to take anything that touches fs/ - apart from reasonable
exceptions - to go through vfs tree. So I would prefer to take this
patch.

