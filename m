Return-Path: <linux-fsdevel+bounces-45859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA58A7DBBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A479A188BA2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB34A23AE83;
	Mon,  7 Apr 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOwKMHFx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71334CF5;
	Mon,  7 Apr 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023679; cv=none; b=Ae9PM6jCmD+bMN4GztJK8l19GTvRg2zVToZemyptiCh6T4felys54/c+r4wQTIB17mGu9ePE53ZWsph22swGdPLLwklvSKm9ShKBqX692iEYnDPrJMlvPSyqdtdi+alucPbGtwd1sknWid4XcfAYqDKNzN1E9kUD5J5vYXvv7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023679; c=relaxed/simple;
	bh=V7ona84w4jSuNFXXibo8D2BeRebQZTbFHfPOFhk3dc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1prTg0Gwo21CUIwAkT5t12x+VmbzSPMuLk2e7PnOM7rMvE3+Zwo/Z4OxlVU7ksph+Ock84/RhLogpdyOTXvtR4RvnGVzstSKYgUi1kKPIBjJw9owR1PMxPCNuSVgDe9dq6ToES593rPlPnRDA9lMhDd+WR/LasDf0KFfTLV8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOwKMHFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FA9C4CEDD;
	Mon,  7 Apr 2025 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744023678;
	bh=V7ona84w4jSuNFXXibo8D2BeRebQZTbFHfPOFhk3dc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOwKMHFxVKuAwBdIguoFqgkI1kcfx3gSWZljnkiDHwa3njNxkfvhVWttdkZtXkrE+
	 eOYIyoUF5zTYRHdAJwPsn4yVSbyCssBE4wCX61Ub0OcdoMDFvOITdGakVm8+y1dTew
	 VhLnOaFtabVcbrUnbK99xIRtOCkDQCSOyvBRISP5vAzoowO21U+Z0IrsD3v7r6N291
	 Ocellf1RmlnfzoyhO37Fwi2PLX+AcogNDXAMd+RfHH75sULbkliaZIW9UUL6l7Zo3O
	 ZqAQBHewJ40z6b6nZKiS555sK9LNkZG8IX5RJnzq5MKqNg/A68v0EyiHeSiNlWYO8/
	 YeVic5cvvbLFw==
Date: Mon, 7 Apr 2025 13:01:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Takashi Iwai <tiwai@suse.de>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
Message-ID: <20250407-irrwitzig-seilschaft-9eaa7d0b1f09@brauner>
References: <874j0lvy89.wl-tiwai@suse.de>
 <87wmc83uaf.wl-tiwai@suse.de>
 <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
 <16e0466d-1f16-4e9a-9799-4c01bd2bb005@molgen.mpg.de>
 <2025040551-catatonic-reflex-2ebf@gregkh>
 <417f41b3-b343-46ca-9efe-fa815e85bdd3@molgen.mpg.de>
 <57eec58a-6aae-4958-996d-2785da985f04@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57eec58a-6aae-4958-996d-2785da985f04@oracle.com>

On Sat, Apr 05, 2025 at 12:25:00PM -0400, Chuck Lever wrote:
> On 4/5/25 3:43 AM, Paul Menzel wrote:
> > Dear Greg,
> > 
> > 
> > Thank you for replying on a Saturday.
> > 
> > Am 05.04.25 um 09:29 schrieb Greg KH:
> >> On Sat, Apr 05, 2025 at 08:32:13AM +0200, Paul Menzel wrote:
> > 
> >>> Am 29.03.25 um 15:57 schrieb Chuck Lever:
> >>>> On 3/29/25 8:17 AM, Takashi Iwai wrote:
> >>>>> On Sun, 23 Feb 2025 09:53:10 +0100, Takashi Iwai wrote:
> >>>
> >>>>>> we received a bug report showing the regression on 6.13.1 kernel
> >>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped
> >>>>>> working
> >>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
> >>>>>>     https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>>
> >>>>>> Quoting from there:
> >>>>>> """
> >>>>>> I use the latest TW on Gnome with a 4K display and 150%
> >>>>>> scaling. Everything has been working fine, but recently both Chrome
> >>>>>> and VSCode (installed from official non-openSUSE channels) stopped
> >>>>>> working with Scaling.
> >>>>>> ....
> >>>>>> I am using VSCode with:
> >>>>>> `--enable-features=UseOzonePlatform --enable-
> >>>>>> features=WaylandWindowDecorations --ozone-platform-hint=auto` and
> >>>>>> for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> >>>>>> """
> >>>>>>
> >>>>>> Surprisingly, the bisection pointed to the backport of the commit
> >>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> >>>>>> to iterate simple_offset directories").
> >>>>>>
> >>>>>> Indeed, the revert of this patch on the latest 6.13.4 was
> >>>>>> confirmed to
> >>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> >>>>>> release is still affected, too.
> >>>>>>
> >>>>>> For now I have no concrete idea how the patch could break the
> >>>>>> behavior
> >>>>>> of a graphical application like the above.  Let us know if you need
> >>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
> >>>>>> and ask there; or open another bug report at whatever you like.)
> >>>>>>
> >>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> >>>
> >>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> >>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> >>>>>
> >>>>> After all, this seems to be a bug in Chrome and its variant, which was
> >>>>> surfaced by the kernel commit above: as the commit changes the
> >>>>> directory enumeration, it also changed the list order returned from
> >>>>> libdrm drmGetDevices2(), and it screwed up the application that worked
> >>>>> casually beforehand.  That said, the bug itself has been already
> >>>>> present.  The Chrome upstream tracker:
> >>>>>     https://issuetracker.google.com/issues/396434686
> >>>>>
> >>>>> #regzbot invalid: problem has always existed on Chrome and related
> >>>>> code
> >>>
> >>>> Thank you very much for your report and for chasing this to conclusion.
> >>> Doesn’t marking this an invalid contradict Linux’ no regression
> >>> policy to
> >>> never break user space, so users can always update the Linux kernel?
> >>> Shouldn’t this commit still be reverted, and another way be found
> >>> keeping
> >>> the old ordering?
> >>>
> >>> Greg, Sasha, in stable/linux-6.13.y the two commits below would need
> >>> to be
> >>> reverted:
> >>>
> >>> 180c7e44a18bbd7db89dfd7e7b58d920c44db0ca
> >>> d9da7a68a24518e93686d7ae48937187a80944ea
> >>>
> >>> For stable/linux-6.12.y:
> >>>
> >>> 176d0333aae43bd0b6d116b1ff4b91e9a15f88ef
> >>> 639b40424d17d9eb1d826d047ab871fe37897e76
> >>
> >> Unless the changes are also reverted in Linus's tree, we'll be keeping
> >> these in.  Please work with the maintainers to resolve this in mainline
> >> and we will be glad to mirror that in the stable trees as well.
> > 
> > Commit b9b588f22a0c (libfs: Use d_children list to iterate simple_offset
> > directories) does not have a Fixes: tag or Cc: stable@vger.kernel.org. I
> > do not understand, why it was applied to the stable series at all [1],
> > and cannot be reverted when it breaks userspace?
> I NACK'd the upstream revert because I expected an RCA before 6.14
> final (that didn't happen), and the Chrome issue was the only reported
> problem and it was specific to a particular hardware configuration and
> the /latest developer release/ of Chrome. Neither v6.14.0 nor a Chrome
> developer release are going to be put in front of users who do not
> expect to encounter issues.

Exactly.

> 
> Note that the libfs series addresses several issues. Commit b9b588f22a0c
> itself addresses CVE-2024-46701 [1] (in v6.6). I did not add a "Cc:
> stable" for commit b9b588f22a0c because it cannot be cherry picked to
> apply to v6.6, it has to be manually adjusted to apply.
> 
> The final RCA reported in [2] shows that there is nothing incorrect
> about b9b588f22a0c.
> 
> In addition, the next Chrome release will carry a fix for the clearly
> incorrect library behavior -- applications cannot depend on the order
> of directory entry iteration, because that can change arbitrarily, and
> not just because of file system implementation quirks. You will note
> that even after sorting the directory entries, the library still had
> problems discovering the accelerated graphics device.
> 
> Reverting now might follow the letter of the rule about "no regressions"
> but IMHO moving forward from here seems to me to be the more
> constructive approach.

I agree.

