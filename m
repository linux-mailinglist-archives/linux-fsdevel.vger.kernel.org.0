Return-Path: <linux-fsdevel+bounces-45810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56606A7C841
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 10:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DA91889202
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031781D6DA3;
	Sat,  5 Apr 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="htrM3Mm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47356224D6;
	Sat,  5 Apr 2025 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743841276; cv=none; b=sGggmVF8gKDyQ2WMy3bhgO+c7xmSpPjYeLUzdXEWUoo3KSJ85L12hqRL/Dhl9FNOXpF2jDP9Xwnjc/5Uth7yiUshrWXhwtBZIyXsar1YXt1E1NQ54tUZP2x5skwE7McpcaztOyAACSWeHN5Z2HY1Pog7uKwQ22isE+Qp6oIX9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743841276; c=relaxed/simple;
	bh=oMO0fL9foer9GMMjANGwGCaDwsdD9vGWhqo6fnKcQ4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edYBnBxkOqHoH9YORUrd9a9lohwaZnbRc6dBG4a19HlU3vi1t3PSEL9CQB5BS5Gt6xCTDOgz616sj8GCMG5WBds/of2vOIAW9zdFakH7JnuIOjraWq8Frs4aM1Zaic0SiLbbhlujs1haOra0X+w/vWgM836DwsRt8xVqEegaJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=htrM3Mm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45538C4CEE4;
	Sat,  5 Apr 2025 08:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743841274;
	bh=oMO0fL9foer9GMMjANGwGCaDwsdD9vGWhqo6fnKcQ4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htrM3Mm4jwsF2J5sTuWUbekANCl9juzKVsVNhaXVHAev9H1Nm5Fdzg2YmwhHCJbi8
	 1EOj+JCZlmx36ipLD0MKw7BTCkjpI7NZTn2EZvYw4bPMEeoT4R3GSB4oEi19KbeouU
	 8yx8QkvgY4fL8Ml3CW/EZt8YF26zCN7PD9VE0K44=
Date: Sat, 5 Apr 2025 09:19:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Takashi Iwai <tiwai@suse.de>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
Message-ID: <2025040534-anymore-mango-d9fb@gregkh>
References: <874j0lvy89.wl-tiwai@suse.de>
 <87wmc83uaf.wl-tiwai@suse.de>
 <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
 <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>
 <2025040551-catatonic-reflex-2ebf@gregkh>
 <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>

On Sat, Apr 05, 2025 at 09:43:29AM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> Thank you for replying on a Saturday.
> 
> Am 05.04.25 um 09:29 schrieb Greg KH:
> > On Sat, Apr 05, 2025 at 08:32:13AM +0200, Paul Menzel wrote:
> 
> > > Am 29.03.25 um 15:57 schrieb Chuck Lever:
> > > > On 3/29/25 8:17 AM, Takashi Iwai wrote:
> > > > > On Sun, 23 Feb 2025 09:53:10 +0100, Takashi Iwai wrote:
> > > 
> > > > > > we received a bug report showing the regression on 6.13.1 kernel
> > > > > > against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> > > > > > with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> > > > > >     https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > > > > > 
> > > > > > Quoting from there:
> > > > > > """
> > > > > > I use the latest TW on Gnome with a 4K display and 150%
> > > > > > scaling. Everything has been working fine, but recently both Chrome
> > > > > > and VSCode (installed from official non-openSUSE channels) stopped
> > > > > > working with Scaling.
> > > > > > ....
> > > > > > I am using VSCode with:
> > > > > > `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> > > > > > """
> > > > > > 
> > > > > > Surprisingly, the bisection pointed to the backport of the commit
> > > > > > b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> > > > > > to iterate simple_offset directories").
> > > > > > 
> > > > > > Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> > > > > > fix the issue.  Also, the reporter verified that the latest 6.14-rc
> > > > > > release is still affected, too.
> > > > > > 
> > > > > > For now I have no concrete idea how the patch could break the behavior
> > > > > > of a graphical application like the above.  Let us know if you need
> > > > > > something for debugging.  (Or at easiest, join to the bugzilla entry
> > > > > > and ask there; or open another bug report at whatever you like.)
> > > > > > 
> > > > > > BTW, I'll be traveling tomorrow, so my reply will be delayed.
> > > 
> > > > > > #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> > > > > > #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> > > > > 
> > > > > After all, this seems to be a bug in Chrome and its variant, which was
> > > > > surfaced by the kernel commit above: as the commit changes the
> > > > > directory enumeration, it also changed the list order returned from
> > > > > libdrm drmGetDevices2(), and it screwed up the application that worked
> > > > > casually beforehand.  That said, the bug itself has been already
> > > > > present.  The Chrome upstream tracker:
> > > > >     https://issuetracker.google.com/issues/396434686
> > > > > 
> > > > > #regzbot invalid: problem has always existed on Chrome and related code
> > > 
> > > > Thank you very much for your report and for chasing this to conclusion.
> > > Doesn’t marking this an invalid contradict Linux’ no regression policy to
> > > never break user space, so users can always update the Linux kernel?
> > > Shouldn’t this commit still be reverted, and another way be found keeping
> > > the old ordering?
> > > 
> > > Greg, Sasha, in stable/linux-6.13.y the two commits below would need to be
> > > reverted:
> > > 
> > > 180c7e44a18bbd7db89dfd7e7b58d920c44db0ca
> > > d9da7a68a24518e93686d7ae48937187a80944ea
> > > 
> > > For stable/linux-6.12.y:
> > > 
> > > 176d0333aae43bd0b6d116b1ff4b91e9a15f88ef
> > > 639b40424d17d9eb1d826d047ab871fe37897e76
> > 
> > Unless the changes are also reverted in Linus's tree, we'll be keeping
> > these in.  Please work with the maintainers to resolve this in mainline
> > and we will be glad to mirror that in the stable trees as well.
> 
> Commit b9b588f22a0c (libfs: Use d_children list to iterate simple_offset
> directories) does not have a Fixes: tag or Cc: stable@vger.kernel.org. I do
> not understand, why it was applied to the stable series at all [1], and
> cannot be reverted when it breaks userspace?

The maintainers asked for it to be applied as it fixed reported
problems, please see the mailing list archives for details.

Note, I have submitted a revert for this already, see:
	https://lore.kernel.org/r/2025022644-blinked-broadness-c810@gregkh
as I too think this should be fixed as it caused problems, but the
maintainers involved decided otherwise, please see that thread for
details.

thanks,

greg k-h

