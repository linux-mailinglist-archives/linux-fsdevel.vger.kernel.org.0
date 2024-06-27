Return-Path: <linux-fsdevel+bounces-22641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CB791AB64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240941C24C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07651990C8;
	Thu, 27 Jun 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgHDvq+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0F199233;
	Thu, 27 Jun 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502394; cv=none; b=FQ4HEDUyrdg7lPvLcCfpWs1up/Ai0oq5UFERa5y9DzVWaMGuktlDw1NLX5pEVf86cH0m5pf/Y1c0fM4ocxe9Hd4nsA0dNmQNGdB/0HevW2GuanlypILIzfOUjYnibpuXE/crgRMLryqAviUva6AoTsctg46F7Oj1VSeDE4UtXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502394; c=relaxed/simple;
	bh=VuDA6GVm6ZnqWfwRL6Xl9pYd73Bj8ZY3AonKSNGQsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVIeuCf04ruwy7Yvgqv/l0l1oP8KsQCH/KpkFU0D+ya9Nuo/4sUeHy+QQip4KzFg/COxGe5Fma1ghBGeL6RfcvOhzV6HjlIbJ4r3cGwIF2R3u5EkuLm4utCG0gf0xODCC1mpDeyq2FtMgHmApLC3mKzD92pznc9TxXC/wHF/bS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgHDvq+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4B4C2BBFC;
	Thu, 27 Jun 2024 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719502393;
	bh=VuDA6GVm6ZnqWfwRL6Xl9pYd73Bj8ZY3AonKSNGQsAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgHDvq+1NSlAHfMDDmXVM/hKZIRWxLeKMv1gQFnZVYyOpAT/dqtNzIVMZ7zKdK4I6
	 Pk1hsuFMoAx5aMDci/JLTvkwP0fcLNu7/ShigKZUOr/oB4kpX5Lvn8QWjt4oC9Zks3
	 HYA/RIxJ05wESANO1p6vtl1W3TAbNTGrVHYSwTA/R/biQGn7AfdksZTWcybUmjh1nu
	 Rte0kakjfnqw5OOboYB4VJb+GCVQ8o3fRNQYvGrJMJ9/E9jrQjhDaU67gce+WQsWDo
	 V+CZ4U3EjGxSYWOByIo9JE22N4QnmUaSNEdyEUYc/dVviIx25FTRNZ6UiljeTEPc4+
	 icGJ+UiDrYmEA==
Date: Thu, 27 Jun 2024 17:33:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, "Ma, Yu" <yu.ma@intel.com>, 
	viro@zeniv.linux.org.uk, edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240627-laufschuhe-hergibt-8158b7b6b206@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>

On Wed, Jun 26, 2024 at 09:13:07PM GMT, Mateusz Guzik wrote:
> On Wed, Jun 26, 2024 at 1:54 PM Jan Kara <jack@suse.cz> wrote:
> > So maybe I'm wrong but I think the biggest benefit of your code compared to
> > plain find_next_fd() is exactly in that we don't have to load full_fds_bits
> > into cache. So I'm afraid that using full_fds_bits in the condition would
> > destroy your performance gains. Thinking about this with a fresh head how
> > about putting implementing your optimization like:
> >
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
> >         unsigned int maxbit = maxfd / BITS_PER_LONG;
> >         unsigned int bitbit = start / BITS_PER_LONG;
> >
> > +       /*
> > +        * Optimistically search the first long of the open_fds bitmap. It
> > +        * saves us from loading full_fds_bits into cache in the common case
> > +        * and because BITS_PER_LONG > start >= files->next_fd, we have quite
> > +        * a good chance there's a bit free in there.
> > +        */
> > +       if (start < BITS_PER_LONG) {
> > +               unsigned int bit;
> > +
> > +               bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> > +               if (bit < BITS_PER_LONG)
> > +                       return bit;
> > +       }
> > +
> >         bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> >         if (bitbit >= maxfd)
> >                 return maxfd;
> >
> > Plus your optimizations with likely / unlikely. This way the code flow in
> > alloc_fd() stays more readable, we avoid loading the first open_fds long
> > into cache if it is full, and we should get all the performance benefits?
> >
> 
> Huh.
> 
> So when I read the patch previously I assumed this is testing the bit
> word for the map containing next_fd (whatever it is), avoiding looking
> at the higher level bitmap and inlining the op (instead of calling the
> fully fledged func for bit scans).
> 
> I did not mentally register this is in fact only checking for the
> beginning of the range of the entire thing. So apologies from my end
> as based on my feedback some work was done and I'm going to ask to
> further redo it.
> 
> blogbench spawns 100 or so workers, say total fd count hovers just
> above 100. say this lines up with about half of more cases in practice
> for that benchmark.
> 
> Even so, that's a benchmark-specific optimization. A busy web server
> can have literally tens of thousands of fds open (and this is a pretty
> mundane case), making the 0-63 range not particularly interesting.
> 
> That aside I think the patchset is in the wrong order -- first patch
> tries to not look at the higher level bitmap, while second reduces
> stores made there. This makes it quite unclear how much is it worth to
> reduce looking there if atomics are conditional.
> 
> So here is what I propose in terms of the patches:
> 1. NULL check removal, sprinkling of likely/unlikely and expand_files
> call avoidance; no measurements done vs stock kernel for some effort
> saving, just denote in the commit message there is less work under the
> lock and treat it as baseline
> 2. conditional higher level bitmap clear as submitted; benchmarked against 1
> 3. open_fds check within the range containing fd, avoiding higher
> level bitmap if a free slot is found. this should not result in any
> func calls if successful; benchmarked against the above
> 
> Optionally the bitmap routines can grow variants which always inline
> and are used here. If so that would probably land between 1 and 2 on
> the list.
> 
> You noted you know about blogbench bugs and have them fixed. Would be
> good to post a link to a pull request or some other spot for a
> reference.
> 
> I'll be best if the vfs folk comment on what they want here.

Optimizing only the < BIT_PER_LONG seems less desirable then making it
work for arbitrary next_fd. Imho, it'll also be easier to follow if
everything follows the same logic.

