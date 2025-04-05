Return-Path: <linux-fsdevel+bounces-45808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5FFA7C7F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 09:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760A8189ABCD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD81C84DA;
	Sat,  5 Apr 2025 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udRGGlm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C81335BA;
	Sat,  5 Apr 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743838270; cv=none; b=XdvCV8xeKWlOVlFZILyY2lPfYZwKGEukuI3czLyrJOWFwW3g1zEdHqx7Q4S+O+copc4nVfSZM2Q4XxBDii3+OWNfLMbKH19cl2wne5Dkxzs1gDQlqavXI4hqg1/bP8hPF+wZi1XxJc3SgU5Oq9FUFTkEDxNqi/vdzrqfSqDsVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743838270; c=relaxed/simple;
	bh=D8FWrHbyWwa85zylCxqq4PubEy+V2LWxGC+T+C7eBas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR7cx0mnSru4E7OOGWwnS3z57PzMtimsNz0GZ6Rp0xS52VMeO7Wd6D2O7hNKqs94GFKwMTCt6DoRjGE8cmd4NuVqvvEzpFk08pMpG47A126hmMEXk1Kg5F4JxkO0/pp6fXp4fgD95nm1PxrLOLsOFX9OZW863AhLMnVUPadHx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=udRGGlm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5ACC4CEE4;
	Sat,  5 Apr 2025 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743838269;
	bh=D8FWrHbyWwa85zylCxqq4PubEy+V2LWxGC+T+C7eBas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udRGGlm+Vy3ElBbf4ucKK5VU0OSvzet5sUKyIRM+3emJJEBLUXL2k1vvMs1itr1l0
	 eSzErJYk+DbLVWaorPZiVXKgjbhx5mr/2C/n+5kZfy7AeFPAqeIiuGhFRi3n8/qswp
	 nlLKfZkA8fx5wUpAqLKFOUTATyD2CzAEYoA00qs8=
Date: Sat, 5 Apr 2025 08:29:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Takashi Iwai <tiwai@suse.de>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
Message-ID: <2025040551-catatonic-reflex-2ebf@gregkh>
References: <874j0lvy89.wl-tiwai@suse.de>
 <87wmc83uaf.wl-tiwai@suse.de>
 <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
 <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>

On Sat, Apr 05, 2025 at 08:32:13AM +0200, Paul Menzel wrote:
> Dear Chuck, dear Takashi, dear Christian,
> 
> 
> I just came across this issue.
> 
> Am 29.03.25 um 15:57 schrieb Chuck Lever:
> > On 3/29/25 8:17 AM, Takashi Iwai wrote:
> > > On Sun, 23 Feb 2025 09:53:10 +0100, Takashi Iwai wrote:
> 
> > > > we received a bug report showing the regression on 6.13.1 kernel
> > > > against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> > > > with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> > > >    https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > > > 
> > > > Quoting from there:
> > > > """
> > > > I use the latest TW on Gnome with a 4K display and 150%
> > > > scaling. Everything has been working fine, but recently both Chrome
> > > > and VSCode (installed from official non-openSUSE channels) stopped
> > > > working with Scaling.
> > > > ....
> > > > I am using VSCode with:
> > > > `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> > > > """
> > > > 
> > > > Surprisingly, the bisection pointed to the backport of the commit
> > > > b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> > > > to iterate simple_offset directories").
> > > > 
> > > > Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> > > > fix the issue.  Also, the reporter verified that the latest 6.14-rc
> > > > release is still affected, too.
> > > > 
> > > > For now I have no concrete idea how the patch could break the behavior
> > > > of a graphical application like the above.  Let us know if you need
> > > > something for debugging.  (Or at easiest, join to the bugzilla entry
> > > > and ask there; or open another bug report at whatever you like.)
> > > > 
> > > > BTW, I'll be traveling tomorrow, so my reply will be delayed.
> 
> > > > #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> > > > #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > > 
> > > After all, this seems to be a bug in Chrome and its variant, which was
> > > surfaced by the kernel commit above: as the commit changes the
> > > directory enumeration, it also changed the list order returned from
> > > libdrm drmGetDevices2(), and it screwed up the application that worked
> > > casually beforehand.  That said, the bug itself has been already
> > > present.  The Chrome upstream tracker:
> > >    https://issuetracker.google.com/issues/396434686
> > > 
> > > #regzbot invalid: problem has always existed on Chrome and related code
> 
> > Thank you very much for your report and for chasing this to conclusion.
> Doesn’t marking this an invalid contradict Linux’ no regression policy to
> never break user space, so users can always update the Linux kernel?
> Shouldn’t this commit still be reverted, and another way be found keeping
> the old ordering?
> 
> Greg, Sasha, in stable/linux-6.13.y the two commits below would need to be
> reverted:
> 
> 180c7e44a18bbd7db89dfd7e7b58d920c44db0ca
> d9da7a68a24518e93686d7ae48937187a80944ea
> 
> For stable/linux-6.12.y:
> 
> 176d0333aae43bd0b6d116b1ff4b91e9a15f88ef
> 639b40424d17d9eb1d826d047ab871fe37897e76

Unless the changes are also reverted in Linus's tree, we'll be keeping
these in.  Please work with the maintainers to resolve this in mainline
and we will be glad to mirror that in the stable trees as well.

thanks,

greg k-h

