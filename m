Return-Path: <linux-fsdevel+bounces-26872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A595C534
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5388F1F22C8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB374BE1;
	Fri, 23 Aug 2024 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2cg4pVeJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A555C3E;
	Fri, 23 Aug 2024 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393575; cv=none; b=SVHekzoHjXOseAEkFBovaqeCc9GsyEnZ7aDYZ+sCFTr9hvE8oUSyf+X/aCRZEAwzz7AXooJysy6FLQ/Y8O9zSIK819CsN/7lnMJDgP/YJdh2y46IPKAfkBWzOAd2uHWbqqJ3+aSXUASOAPjgjF/OSoN0gDJHk5CHIoGZ701AG0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393575; c=relaxed/simple;
	bh=VuaMXq/ic8X2m9kV83mf6YFYaszIuxekeGJm8Pfrrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8wYm/TplyQcHaOZ/hFC5CeC8gB18imQ0wv59Juxykcjjufj01tqZ1vbLpRDBO4hGPPCjIuxcEz0b125va5sEaQEBns8+M/4u+tsK/+DG5msPWCo0qWqIOhOaXq9PdR2uW3JPcr9odojUPomL4FXk2PfaImz+XDRqCswnCD2rNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2cg4pVeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED127C32786;
	Fri, 23 Aug 2024 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724393574;
	bh=VuaMXq/ic8X2m9kV83mf6YFYaszIuxekeGJm8Pfrrqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2cg4pVeJFoWhnJgcePmo6lZ4QBf+Lldz1O2gqcR/cj3fMPRDY1/5S+lSIdzQoJtx3
	 liKnuqDEGtLZZVcWJrNXb4M6jpnSXRiNfXo2zpbMigL6yzFNkrUPrSmEbyKRfzi/op
	 kuCgxH38zblAdnNsML67kVhuBCYId0ei/JDy9xO8=
Date: Fri, 23 Aug 2024 14:12:51 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <2024082313-throttle-snuggle-6238@gregkh>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240818035818.GA1929@sol.localdomain>
 <20240819-staudamm-rederei-cb7092f54e76@brauner>
 <93296f30-1a3c-44b6-91d1-61408e1d9270@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93296f30-1a3c-44b6-91d1-61408e1d9270@leemhuis.info>

On Fri, Aug 23, 2024 at 07:23:12AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 19.08.24 10:41, Christian Brauner wrote:
> > On Sat, Aug 17, 2024 at 08:58:18PM GMT, Eric Biggers wrote:
> >> On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
> >>> It's currently possible to create pidfds for kthreads but it is unclear
> >>> what that is supposed to mean. Until we have use-cases for it and we
> >>> figured out what behavior we want block the creation of pidfds for
> >>> kthreads.
> >>>
> >>> Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Christian Brauner <brauner@kernel.org>
> >>> ---
> >>>  kernel/fork.c | 25 ++++++++++++++++++++++---
> >>>  1 file changed, 22 insertions(+), 3 deletions(-)
> >>
> >> Unfortunately this commit broke systemd-shutdown's ability to kill processes,
> >> which makes some filesystems no longer get unmounted at shutdown.
> >>
> >> It looks like systemd-shutdown relies on being able to create a pidfd for any
> >> process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
> >> fatal error and stops looking for more processes...
> > 
> > Thanks for the report!
> > I talked to Daan De Meyer who made that change and he said that this
> > must a systemd version that hasn't gotten his fixes yet. In any case, if
> > this causes regression then I'll revert it right now. See the appended
> > revert.
> 
> Greg, Sasha, JFYI in case you are not already aware of it: I by
> chance[1] noticed that the patch Christian plans to revert is still in
> the 6.10-queue. You might want to drop it (or apply the revert as well,
> which is in -next, but not yet in mainline afaics).

I was hoping it would get into Linus's tree "soon" so I could take the
revert too.  As it's in -next, I'll grab it from there when I get a
chance.

thanks,

greg k-h

