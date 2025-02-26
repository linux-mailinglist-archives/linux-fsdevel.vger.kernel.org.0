Return-Path: <linux-fsdevel+bounces-42707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B49A4666D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63653A5251
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24743220694;
	Wed, 26 Feb 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yuy4eTAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5919C553;
	Wed, 26 Feb 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586787; cv=none; b=cMQyp86G6mHZmpSqYG7XDEyJCtBvxYDuUKB5u1ZnEoY4R1xEJevFLxZsiix7i4klqUvKvu1rfd/yy2U6h1yCXf12RNHVx5vEBlrTqOSLntaHZOdPC4fxherzyEtWSMByJjoOKEh8rbFNEaKpVYXmZI1uexPBsYBXJx13SzYOwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586787; c=relaxed/simple;
	bh=lRn0AHOsMFoqWupx1FVSc1w9l9wR7DHwkuByfl239KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLVptS1Z8xGcXhoFs/0ybiskQ2QIJxt/VwBi7/mAsprvQLNCiRJpJXL0hdfMdirhMUfztjhL0INYQTYevtFkiHLmfuF7+wG05NKuXbZw2G88B5ETsHvJSfEy3W19Vhc71vNSQzdKMSHG0RErsqIEnhz2vEFbXLyJWY46TaNIWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yuy4eTAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F091EC4CED6;
	Wed, 26 Feb 2025 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740586787;
	bh=lRn0AHOsMFoqWupx1FVSc1w9l9wR7DHwkuByfl239KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yuy4eTAOVMDqVHDGvlovhGK7FUE4cbUvGC5oNLtD61UuT14HkROBt6g3qlszvLdoW
	 7LbTvI19XBCfKDa+iZ0Vbyc8PvYU9dVx9y+o5j6R+9E6DyztAz/X848sXZkhsAvAWr
	 VMol5F2Sb92kQmbFIV1C5XRnMdq7m0zfvqr5l+UI=
Date: Wed, 26 Feb 2025 08:18:37 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
Message-ID: <2025022627-portable-malt-41c1@gregkh>
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
 <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
 <87h64g4wr1.wl-tiwai@suse.de>
 <7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
 <2025022657-credit-undrilled-81f1@gregkh>
 <ed3bb539-df59-40a2-bbd9-0d2efd36ba07@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3bb539-df59-40a2-bbd9-0d2efd36ba07@oracle.com>

On Wed, Feb 26, 2025 at 10:56:46AM -0500, Chuck Lever wrote:
> On 2/26/25 9:26 AM, Greg KH wrote:
> > On Wed, Feb 26, 2025 at 09:20:20AM -0500, Chuck Lever wrote:
> >> On 2/26/25 9:16 AM, Takashi Iwai wrote:
> >>> On Wed, 26 Feb 2025 15:11:04 +0100,
> >>> Chuck Lever wrote:
> >>>>
> >>>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
> >>>>> On Sun, 23 Feb 2025 16:18:41 +0100,
> >>>>> Chuck Lever wrote:
> >>>>>>
> >>>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
> >>>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> we received a bug report showing the regression on 6.13.1 kernel
> >>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> >>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> >>>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>>>
> >>>>>>> Quoting from there:
> >>>>>>> """
> >>>>>>> I use the latest TW on Gnome with a 4K display and 150%
> >>>>>>> scaling. Everything has been working fine, but recently both Chrome
> >>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
> >>>>>>> working with Scaling.
> >>>>>>> ....
> >>>>>>> I am using VSCode with:
> >>>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> >>>>>>> """
> >>>>>>>
> >>>>>>> Surprisingly, the bisection pointed to the backport of the commit
> >>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> >>>>>>> to iterate simple_offset directories").
> >>>>>>>
> >>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> >>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> >>>>>>> release is still affected, too.
> >>>>>>>
> >>>>>>> For now I have no concrete idea how the patch could break the behavior
> >>>>>>> of a graphical application like the above.  Let us know if you need
> >>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
> >>>>>>> and ask there; or open another bug report at whatever you like.)
> >>>>>>>
> >>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> >>>>>>>
> >>>>>>>
> >>>>>>> thanks,
> >>>>>>>
> >>>>>>> Takashi
> >>>>>>>
> >>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> >>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>>
> >>>>>> We received a similar report a few days ago, and are likewise puzzled at
> >>>>>> the commit result. Please report this issue to the Chrome development
> >>>>>> team and have them come up with a simple reproducer that I can try in my
> >>>>>> own lab. I'm sure they can quickly get to the bottom of the application
> >>>>>> stack to identify the misbehaving interaction between OS and app.
> >>>>>
> >>>>> Do you know where to report to?
> >>>>
> >>>> You'll need to drive this, since you currently have a working
> >>>> reproducer.
> >>>
> >>> No, I don't have, I'm merely a messenger.
> >>
> >> Whoever was the original reporter has the ability to reproduce this and
> >> answer any questions the Chrome team might have. Please have them drive
> >> this. I'm already two steps removed, so it doesn't make sense for me to
> >> report a problem for which I have no standing.
> > 
> > Ugh, no.  The bug was explictly bisected to the offending commit.  We
> > should just revert that commit for now and it can come back in the
> > future if the root-cause is found.
> > 
> > As the revert seems to be simple, and builds here for me, I guess I'll
> > have to send it in. {sigh}
> 
> Note that reverting also reintroduces a CVE.

That's fine, regressions are more important :)

