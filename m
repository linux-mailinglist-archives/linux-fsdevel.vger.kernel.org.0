Return-Path: <linux-fsdevel+bounces-43906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029BDA5FA73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 16:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEAF189CECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCE268FF0;
	Thu, 13 Mar 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlR0uuZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF15523A;
	Thu, 13 Mar 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881131; cv=none; b=gtvGtlSaT/B9HexqJf+9rpyZQtggPCWf2DLnEpXPqXWEfGEUIJ3R5zAdrRvQoA/CgSc/mcSmkeG8/S1tE0SBp3XfxScJWwXukcA0fgTa6QjytuRAkM7GzTowM6Wq5Ruw2iJg9X3c2T/m7RDDkTdg2z1fucWSHYMhAJR3HwXGnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881131; c=relaxed/simple;
	bh=DZtz8/3fa+WFrihLsc4sh46ZOpu6MY1qmLDNbK59iUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC4NGlKokXxJSsDYgBdcaAoJyKfK34TPlv6IYjMjvgvcJBw9ATxrfKuhTYHXvA2dxVKkrD9oAoJ2ECvqhy0yG14Pz364v1Ri+908JorGFQsqJnVqHwd/bmI1OOvMU/7hHk5n50AW3ULYCRTSyWL4wc1RQCxBhoErL6FGFe2SG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlR0uuZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328F6C4CEE9;
	Thu, 13 Mar 2025 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741881130;
	bh=DZtz8/3fa+WFrihLsc4sh46ZOpu6MY1qmLDNbK59iUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlR0uuZWUOhyc0abfXi0pJd4hzfsPInN2i+kewAX6nuCKSrY+fZFWeGicoJfgL8ef
	 ApQ2Plhiq+sAx39Kl9VvwO0eMtQzsDGF5BM5WbWEpQ9LaymP3pvcETcsWczzwkstEK
	 YOM8wKq9zgoERqs3u91PuT6Tm8tQvEVKQEnqPJr3Bve3cpWUV5ApIIxxZchKAKIh+I
	 qz5YzhyA4jzZOOJclEFa91wDLEkSLro/6OWzhsXvxSH3QuO3BjWA3Y9q+8l/DyP7nf
	 Vwg+Y05Ck9qRQldGn4tABwYzjjZW4iRWeOTDb0WZmodQLYIrMtb4Zs9KyUKXQ67U7F
	 mwhCCDB7D2mbw==
Date: Thu, 13 Mar 2025 16:52:05 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Ruiwu Chen <rwchen404@gmail.com>, corbet@lwn.net, 
	keescook@chromium.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <db2zm4c5p5octh6garrnvlg3qzhvaqxtoz33f5ksegwupcbegk@jidbmdepvn57>
References: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
 <20250308080549.14464-1-rwchen404@gmail.com>
 <zaiqpjvkekhgipcs7smqhbb7hqt5dcneyoyndycofjepitxznf@q22hsykugpme>
 <Z9IQ2jam9hkXnPhg@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9IQ2jam9hkXnPhg@bombadil.infradead.org>

On Wed, Mar 12, 2025 at 03:55:22PM -0700, Luis Chamberlain wrote:
> On Mon, Mar 10, 2025 at 02:51:11PM +0100, Joel Granados wrote:
> > On Sat, Mar 08, 2025 at 04:05:49PM +0800, Ruiwu Chen wrote:
> > > >> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> > > >> but there is no interface to enable the message, only by restarting
> > > >> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> > > >> enabled the message again.
> > > >> 
> > > >> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> > > >
> > > > You are overcomplicating things, if you just want to re-enable messages
> > > > you can just use:
> > > >
> > > > -		stfu |= sysctl_drop_caches & 4;
> > > > +		stfu = sysctl_drop_caches & 4;
> > > >
> > > > The bool is there as 4 is intended as a bit flag, you can can figure
> > > > out what values you want and just append 4 to it to get the expected
> > > > result.
> > > >
> > > >  Luis
> > > 
> > > Is that what you mean ?
> > > 
> > > -               stfu |= sysctl_drop_caches & 4;
> > > +               stfu ^= sysctl_drop_caches & 4;
> > > 
> > > 'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
> > > This is what I originally thought, but there is uncertainty that when different operators execute the command,
> > > It is not possible to determine whether this time is enabled or turned on unless you operate it twice.
> > 
> > So can you use ^= or not?
> 
> No,  ^= does not work, see a boolean truth table.
> 
> > And what does operate it twice mean?
> 
> I think the reporter meant an "sysadmin", say two folks admining a system.
> Since we this as a flag to enable disabling it easily we can just
> always check for the flag as I suggested:
> 
> stfu = sysctl_drop_caches & 4
I sent out a new version of this patch. Its a bit late to push it though
the next merge window, so it is in sysctl-testing until the next cycle

Thx again

Best

-- 

Joel Granados

