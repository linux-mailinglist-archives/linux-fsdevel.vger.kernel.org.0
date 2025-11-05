Return-Path: <linux-fsdevel+bounces-67229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2664C3846D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 00:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B803B4875
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FCA2E973A;
	Wed,  5 Nov 2025 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNvEhAIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25221E097;
	Wed,  5 Nov 2025 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383536; cv=none; b=YXAbG5Nj2SlEet6fxYVfUcjxPcI7iIjezcHCWAeQrXu3qbtK6IhJMSDuYG6SjAnOtKsinblwEZOQVbyAyij/aB3ujVfe0++rqWTDBAUYZrmsRu7M6Meh/d9/+Pcvfcg412/XOBCLpRRW9gw/fkgxkNCbZRNiL2Q4i/MgbZhcMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383536; c=relaxed/simple;
	bh=onJHOiyRK4hFxFEwH1SEwaVtaoqqcrCxRjUW5zIdKas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxz2nbo4ZLObFnrVVTbQqzsLHMocFVcZiomS5EmXiNXpX63OFGNaYSDX74iaS6ZJ0JYK/JzpiygNeYoj44d7oxQFNIA1b/EvT596XXfl6odSvG5AoS/Y9YVknPaVE+5SykvHFcgkzaWjSEWBW2+QdizkSY+luGqSDf+20ReQQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNvEhAIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35027C4CEF5;
	Wed,  5 Nov 2025 22:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383536;
	bh=onJHOiyRK4hFxFEwH1SEwaVtaoqqcrCxRjUW5zIdKas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNvEhAIQRPz93Wq0RYjBT0NOeBgiRj7uhHqn47efkJegtniXqIo+OE6nRBRT498jx
	 noI+P5juTzsNV0koidDPHrrafpGVQq4Tg0OzC3pqCRY1Ylm9iQG0Dexx3HHowoqSMq
	 meYpJCTPNxEGifVAjeirTaWvvxEthuazH29Lve/gDPQCxLzh1pKoqwq0r3XCxT6/6g
	 o1MpKCBCFBRPgHH9KEkZTlH3FFa/SIoc8oimij7AEUwdyHVClXAw/Ozl9W6iKAJKih
	 EkpROn5hPOSxy2R5uB/0VhASUsVWW9hs7aFYk2tOksA2BHU9g8+5QxZmfhQEScK3Rv
	 2U6BvOxb3gavg==
Date: Wed, 5 Nov 2025 14:58:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCH 23/33] generic/{409,410,411,589}: check for stacking
 mount support
Message-ID: <20251105225855.GE196358@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169820405.1433624.15490165287670348975.stgit@frogsfrogsfrogs>
 <CAOQ4uxgQe5thjp_Pfmbwf-P+o9n7a93a7dzS4S0_Rnw--ULBfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgQe5thjp_Pfmbwf-P+o9n7a93a7dzS4S0_Rnw--ULBfA@mail.gmail.com>

On Thu, Oct 30, 2025 at 11:25:12AM +0100, Amir Goldstein wrote:
> On Wed, Oct 29, 2025 at 2:29 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > _get_mount depends on the ability for commands such as "mount /dev/sda
> > /a/second/mountpoint -o per_mount_opts" to succeed when /dev/sda is
> > already mounted elsewhere.
> >
> > The kernel isn't going to notice that /dev/sda is already mounted, so
> > the mount(8) call won't do the right thing even if per_mount_opts match
> > the existing mount options.
> >
> > If per_mount_opts doesn't match, we'd have to convey the new per-mount
> > options to the kernel.  In theory we could make the fuse2fs argument
> > parsing even more complex to support this use case, but for now fuse2fs
> > doesn't know how to do that.
> >
> > Until that happens, let's _notrun these tests.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  common/rc         |   24 ++++++++++++++++++++++++
> >  tests/generic/409 |    1 +
> >  tests/generic/410 |    1 +
> >  tests/generic/411 |    1 +
> >  tests/generic/589 |    1 +
> >  5 files changed, 28 insertions(+)
> >
> >
> > diff --git a/common/rc b/common/rc
> > index f5b10a280adec9..b6e76c03a12445 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -364,6 +364,30 @@ _clear_mount_stack()
> >         MOUNTED_POINT_STACK=""
> >  }
> >
> > +# Check that this filesystem supports stack mounts
> > +_require_mount_stack()
> > +{
> > +       case "$FSTYP" in
> > +       fuse.ext[234])
> > +               # _get_mount depends on the ability for commands such as
> > +               # "mount /dev/sda /a/second/mountpoint -o per_mount_opts" to
> > +               # succeed when /dev/sda is already mounted elsewhere.
> > +               #
> > +               # The kernel isn't going to notice that /dev/sda is already
> > +               # mounted, so the mount(8) call won't do the right thing even
> > +               # if per_mount_opts match the existing mount options.
> > +               #
> > +               # If per_mount_opts doesn't match, we'd have to convey the new
> > +               # per-mount options to the kernel.  In theory we could make the
> > +               # fuse2fs argument parsing even more complex to support this
> > +               # use case, but for now fuse2fs doesn't know how to do that.
> > +               _notrun "fuse2fs servers do not support stacking mounts"
> > +               ;;
> 
> I believe this is true for fuse* in general. no?

I think it's actually true any time mount shells out to a mount helper
because you gave it a -t FOO and there happens to be a mount.FOO in
$PATH.  Though I wonder if I could/should just bloat up fuse4fs to
detect when the device is already open to the same mountpoint, and just
call mount(8) back with --internal?

--D

> Thanks,
> Amir.
> 

