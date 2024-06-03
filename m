Return-Path: <linux-fsdevel+bounces-20839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552BF8D851F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691421C214C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7712F596;
	Mon,  3 Jun 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJhzz29v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099F57C9A;
	Mon,  3 Jun 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425207; cv=none; b=Z5AXEJlB8MmO42Uu1UGQr6ULVidXxxvaSH34UTBChNydlt2sVDHFxfnLv/31uK46OP4VKw7fHLBlBDXcP52lAGHYbiWkK4DwkC6RK9pLLQ7hWNWZVaVwPXOPNPpmAgQgWc3Uj2NIowa6rI1KvC4HIKJPGupxCxDeH+V9INp12ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425207; c=relaxed/simple;
	bh=7Ze13k74YYFAGZMWLGKT63zEhS3FmZYEIvaL8zuzG4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWPLu1qd38TBRWKw2QqlBHuJz/Ip4vd82+KqUbrHZ17+j+kqNm6IvZ/kMOfhIxjXcIVsKJpbAB10RBKFgdykb70O2wUL6ZD7vt/rqsHxO2oXSnmhZPCncs+ysB0XufIDGVRcvNKjUVbLt3kwxf+QX83ZPCHfe0pOToDpRThrBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJhzz29v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FA7C32781;
	Mon,  3 Jun 2024 14:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717425206;
	bh=7Ze13k74YYFAGZMWLGKT63zEhS3FmZYEIvaL8zuzG4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJhzz29vE4W9Y3EUb1HfKsOE1Ft4wF+rMuC/UjgrbQFtoM9yTaTd/9uAkG2SVcLyu
	 1hDeQs3k3e8+/DJV6RJGye+WWpE8Vvme8qwNc5rCKYtBPLfJSNWgTWaoi2tknDsIy5
	 dLsGWhqNABHJ2OAnzMdilTyrxUMZAgi4oIZYo4Nx2KlGGnLgRxpFbNZq99sWosiMhS
	 B7ZJL9oCnfwefGzHyTy7lYUoz8mSdwGK+XKpR474goULG7s+01Z1L+UO5eZqVWIBL+
	 NP4BuQJAJ2bd/M6HZZzyngITyAGs5Z+pl4++GzOSAFlRCcAwFdLMrpc2EGCDbPCvNZ
	 KQJnpCjMaM2yw==
Date: Mon, 3 Jun 2024 16:33:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <20240603-turnen-wagen-685f86730633@brauner>
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
 <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
 <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
 <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>

On Mon, Jun 03, 2024 at 09:17:10AM -0500, Eric Sandeen wrote:
> On 6/3/24 8:31 AM, Christian Brauner wrote:
> > On Mon, Jun 03, 2024 at 09:24:50AM +0200, Wolfram Sang wrote:
> >>
> >>>>> Does that fix it for you?
> >>>>
> >>>> Yes, it does, thank you.
> >>>>
> >>>> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>
> >>> Thanks, applied. Should be fixed by end of the week.
> >>
> >> It is in -next but not in rc2. rc3 then?
> > 
> > Yes, it wasn't ready when I sent the fixes for -rc2 as I just put it in
> > that day.
> > 
> 
> See my other reply, are you sure we should make this change? From a
> "keep the old behavior" POV maybe so, but this looks to me like a
> bug in busybox, passing fstab hint "options" like "auto" as actual mount
> options being the root cause of the problem. debugfs isn't uniquely
> affected by this behavior.
> 
> I'm not dead set against the change, just wanted to point this out.

Hm, it seems I forgot your other mail, sorry.
So the issue is that we're breaking existing userspace and it doesn't
seem like a situation where we can just ignore broken userspace. If
busybox has been doing that for a long time we might just have to
accommodate their brokenness. Thoughts?

