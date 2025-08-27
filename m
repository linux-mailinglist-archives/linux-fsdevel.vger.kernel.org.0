Return-Path: <linux-fsdevel+bounces-59432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0813FB38A13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7F7B55D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5E2D4B44;
	Wed, 27 Aug 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGc9VjcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C29EEBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321959; cv=none; b=qsWCdoOxQoFGd8DiTc+Gq9H6JMNP75gLqRAx9fYyGir5EmRX51fHCiDXTk9qVp78Nllx1i3nd31I/gt4UCD27SKI4gUvCN+k4FXiNlYNvtypUbxcytBhCEzRGtkKUgfCxqzEF6yghhjQB2FOkutxYvJgrwVdLqk9u1+FreGHHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321959; c=relaxed/simple;
	bh=cB9BoECno/efDst8JKAS8kjMap9W8hI73EcEJKmr5QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orgI7RW6zXumezECgAH6mV/XapsRju1GaUBCrK0ZVFQYvoYNOJzSwQ/Y3274MkDxk7v65z4Sfh5wWoWChfsJxiJEIR7aULKICbVg61Ps0PTQ34OikNBZPvoo1hiSfuVfECP9IXbU1zu/y5/xFxnALWijIg1x7SRB9eKH94NO07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGc9VjcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF6CC4CEF0;
	Wed, 27 Aug 2025 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321958;
	bh=cB9BoECno/efDst8JKAS8kjMap9W8hI73EcEJKmr5QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGc9VjcYEKIML1RNzkjD3dPGu6x31FV9KSQV/UYWFr6W6pPBWzDn+vnscZBhNlJtN
	 dmdVaxRkRXxT4i9NNn7q3NKoz2/AAzDu+LOAZvcR+u69Q9hZkUb3wLT6iXp1opTw2p
	 cIPcrBpC++qAr5U4sl4bGXdKDt2X1roJwbqXb4ranJlis1AXUT8SLzQ2T6E8sV/5gP
	 Ti8266BNZkPCKrPITuqKN8ECtqLbeIE2DzpYm5Z+MgwxCs9O1MnVL7TLCwPSKYF8Ys
	 Z2jwCQ9gPQjERP0aNyEqQJcL5zf0StqlQd0veWNRpgUlcISHT84GIaCslozLdRQnkM
	 vI3s24GP+wt8w==
Date: Wed, 27 Aug 2025 12:12:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, synarete@gmail.com,
	Bernd Schubert <bernd@bsbernd.com>, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
Message-ID: <20250827191238.GC8117@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs>
 <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
 <20250826193154.GE19809@frogsfrogsfrogs>
 <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
 <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com>

On Wed, Aug 27, 2025 at 05:18:23PM +0200, Miklos Szeredi wrote:
> On Wed, 27 Aug 2025 at 00:07, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
> > Isn't the sync() in fuse right now gated by fc->sync_fs (which is only
> > set to true for virtiofsd)? I don't see where FUSE_SETATTR or
> > FUSE_FSYNC get sent in the sync() path to untrusted servers.
> 
> Hmm, it's through sync_inodes_one_sb() that fuse_write_inode() could
> get called, which then would trigger a FUSE_SETATTR.

<nod> So SETATTR is a theoretical DoS vector, but that's already a
property of most filesystems that write to an off-cpu device such as a
disk or another computer. ;)

> Does anyone know how useful sync() is in practice?   I guess most
> applications have switched to syncfs() which is more specific.

Well old greybeards such as myself reboot busted systems with

$ sync
$ sync
$ sync
<sysrq-b>

because that's what you'd type after "startx &" fscked up the display.
It's 2025 and ... that still happens. :(

Debian codesearch shows a few thousand hits for sync(), some of which
are in things like LibreOffice.

> In any case, I don't remember a complaint about sync(2) ignoring fuse
> filesystems.

Well sync() will poke all the fuse filesystems, right?

--D

> Thanks,
> Miklos

