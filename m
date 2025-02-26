Return-Path: <linux-fsdevel+bounces-42730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D1DA46DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4F516BFAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14725D520;
	Wed, 26 Feb 2025 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXlaftwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4722745E;
	Wed, 26 Feb 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606006; cv=none; b=aWZ8z7fJk0eq2Lfowog7YhOICQ/M2QuN166A+D4Iubk3AV4G5rP4PxH39iGogHJkvYJ22WpqHbTlj25BUkxbltASitZVLm97fDrARulaJRKJnVUbdKOex7Rog3AKzBbkkR9Ap3fjCVXSjTOACgKar/yQ+6rWKhxgYGhj3qtXw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606006; c=relaxed/simple;
	bh=B5Pl0F39NNjaJkCDzCw6Eg5v+4wqR8cVZY9hkGYMii0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTMctj16qiSyctIwlJwOA4ZWg99xwzpqg3j2qvkdCLf1O6inHO3XifWW9ebT71O1gXrwDNvSvozVacwRi8Abvskr8c1tH3mhuN/3fdlytymeRsMo4uxCvTatCD3weXP+BCZumMSu1RVNghYxiiRLLvwV1oH9MzjDU5NGf+fShiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXlaftwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28BCC4CED6;
	Wed, 26 Feb 2025 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606004;
	bh=B5Pl0F39NNjaJkCDzCw6Eg5v+4wqR8cVZY9hkGYMii0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXlaftwNhTvsbSJFi2WuyxKTGJ5z/6LPZOgY88fQ2guL2Ron8SNUAVXUqoWZ88sS1
	 ua0oSDiMc+KZMys6juRTsdjmrTfh7Phdr92ixazCPgCvWe5sFYqoLq4IO3+JD+Mwja
	 FWjIFZzJg4N8rVTUPRY6MQDFvKt1tfOanlUW+wsVM3NFDbqIUWpvK/HMUv5KDLLINF
	 nI/O8dTREtghtWLxz7u+zb9s7QtmcaUl6AScLdss84Uj0tBdodQAhiw/CAD3BG4c+/
	 cnekK6JX5y59jWXSbZmEHCRAS24H/rJ1ddG3lJ+wF0vNGgz5stFFsEicVHPTrupiXm
	 OeKkxit2vkDYg==
Date: Wed, 26 Feb 2025 21:40:03 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, regressions@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
Message-ID: <20250226214003.GE3949421@google.com>
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
 <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
 <20250226204229.GC3949421@google.com>
 <4e1b220d-1737-468d-af0b-6050f8cdaf8b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1b220d-1737-468d-af0b-6050f8cdaf8b@oracle.com>

On Wed, Feb 26, 2025 at 04:01:18PM -0500, Chuck Lever wrote:
> On 2/26/25 3:42 PM, Eric Biggers wrote:
> > On Wed, Feb 26, 2025 at 09:11:04AM -0500, Chuck Lever wrote:
> >> On 2/26/25 3:38 AM, Takashi Iwai wrote:
> >>> On Sun, 23 Feb 2025 16:18:41 +0100,
> >>> Chuck Lever wrote:
> >>>>
> >>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
> >>>>> [ resent due to a wrong address for regression reporting, sorry! ]
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> we received a bug report showing the regression on 6.13.1 kernel
> >>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> >>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> >>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>
> >>>>> Quoting from there:
> >>>>> """
> >>>>> I use the latest TW on Gnome with a 4K display and 150%
> >>>>> scaling. Everything has been working fine, but recently both Chrome
> >>>>> and VSCode (installed from official non-openSUSE channels) stopped
> >>>>> working with Scaling.
> >>>>> ....
> >>>>> I am using VSCode with:
> >>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> >>>>> """
> >>>>>
> >>>>> Surprisingly, the bisection pointed to the backport of the commit
> >>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> >>>>> to iterate simple_offset directories").
> >>>>>
> >>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> >>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> >>>>> release is still affected, too.
> >>>>>
> >>>>> For now I have no concrete idea how the patch could break the behavior
> >>>>> of a graphical application like the above.  Let us know if you need
> >>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
> >>>>> and ask there; or open another bug report at whatever you like.)
> >>>>>
> >>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> >>>>>
> >>>>>
> >>>>> thanks,
> >>>>>
> >>>>> Takashi
> >>>>>
> >>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> >>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>
> >>>> We received a similar report a few days ago, and are likewise puzzled at
> >>>> the commit result. Please report this issue to the Chrome development
> >>>> team and have them come up with a simple reproducer that I can try in my
> >>>> own lab. I'm sure they can quickly get to the bottom of the application
> >>>> stack to identify the misbehaving interaction between OS and app.
> >>>
> >>> Do you know where to report to?
> >>
> >> You'll need to drive this, since you currently have a working
> >> reproducer. You can report the issue here:
> >>
> >> https://support.google.com/chrome/answer/95315?hl=en&co=GENIE.Platform%3DDesktop
> >>
> >>
> > 
> > FYI this was already reported on the Chrome issue tracker 2 weeks ago:
> > https://issuetracker.google.com/issues/396434686
> 
> That appears to be as a response to the first report to us. Thanks for
> finding this.
> 
> I notice that this report indicates the problem is with a developer
> build of Chrome, not a GA build.
> 
> If /dev/dri is a tmpfs file system, then it would indeed be affected by
> b9b588f22a0c. No indication yet of how.

Just to confirm, the commit did change the directory iteration order, right?
The theory at https://issuetracker.google.com/issues/396434686#comment4 seems
promising.  Just the exact code hasn't been identified yet.

- Eric

