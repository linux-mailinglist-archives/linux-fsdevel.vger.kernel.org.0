Return-Path: <linux-fsdevel+bounces-13178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F186C5F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499D82842F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0596662164;
	Thu, 29 Feb 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB68wjE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E96168B;
	Thu, 29 Feb 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200014; cv=none; b=DdKbMf7Q5rYMI+epl4+6SXafn9FouRRUzeSP1Gdqyymz7k9stFiirFfmc0YyUK6ZParRFg1NQ0Nv3ADjK//R/rzmQe7qJ532/XjI2f4hFOQTr08WQ04dtlVHG2kvF9H/H6l1Isc4UKcfbZLV60nmSshRnc0LNuf5aP/zo4g4SBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200014; c=relaxed/simple;
	bh=cXB+1KQBDiO549Ym19+tDwi+Lf7+X4p0nhnrCu5uIBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9YkplkDXFRp3YF4KOK1B5nG1q3VfxG1ob77z05vguz7z9Vd7spI01lNGNI1V+8qvFXk9UGo/0fZ1D5tc9Jchi6bg7mFf+2Crb9IQVQPbOO3Bt8lxnMZvSx3Ow6dkgodIDQRIKBa1LFGHELEKFEPTuV/A3INgAiOnMApdLBF/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB68wjE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA60C433F1;
	Thu, 29 Feb 2024 09:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200013;
	bh=cXB+1KQBDiO549Ym19+tDwi+Lf7+X4p0nhnrCu5uIBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HB68wjE3jve/pX4a+Wxrr9yrEohPUGdi+5baHx3HHSaFNPT+F9vm/qG+hw/s0jqUh
	 61eJyVKjHdKybq3MBkiHFVmsf5XfgBZdXTLqsQDCECtvR0Hd5zo+LkWdeHJJ9hkmMX
	 br+WZKW2ZeG2BT67ygZT/3uWjk1MMhShZX1UqyGhg+Ob5RSIJrU5UhK5Y7cAUdDzPe
	 m6HpemhTW30eB5Rf5kfsxft25I8Zw3C17hR8UjX8YC0VoefFxUjGuyyDOC0TXJoHrF
	 RtJQ42G0/jVhms//d90jr9t84R1bfcz3UG8xDBr9lvBXBnhYtA3DL5pGBwmH3fUctR
	 aGy6sOs6+LbAA==
Date: Thu, 29 Feb 2024 10:46:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, david@fromorbit.com, 
	mcgrof@kernel.org, hch@lst.de, willy@infradead.org
Subject: Re: [PATCH 2/2] bcachefs: Buffered write path now can avoid the
 inode lock
Message-ID: <20240229-gestrafft-waage-157c1c4ee225@brauner>
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
 <20240229063010.68754-3-kent.overstreet@linux.dev>
 <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
 <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg96Rt-SuUeRb-xev1KdwqX0GLFjf2=qnRsyLimx6-xzw@mail.gmail.com>

On Wed, Feb 28, 2024 at 11:27:05PM -0800, Linus Torvalds wrote:
> On Wed, 28 Feb 2024 at 23:20, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> >  - take the lock exclusively if O_APPEND or if it *looks* like you
> > might extend the file size.
> >
> >  - otherwise, take the shared lock, and THEN RE-CHECK. The file size
> > might have changed, so now you need to double-check that you're really
> > not going to extend the size of the file, and if you are, you need to
> > go back and take the inode lock exclusively after all.
> 
> Same goes for the suid/sgid checks. You need to take the inode lock
> shared to even have the i_mode be stable, and at that point you might
> decide "oh, I need to clear suid/sgid after all" and have to go drop
> the lock and retake it for exclusive access after all.

I agree. And this is how we've done it in xfs as well. The inode lock is
taken shared, then check for IS_NOSEC(inode) and if that's true keep the
shared lock, otherwise upgrade to an exclusive lock. Note that this
whole check also checks filesystem capability xattrs.

I think you'd also get potential security issues or at least very subtle
behavior. Someone could make a binary setuid and a concurrent write
happens. chmod is taking the exclusive lock and there's a concurrent
write going on changing the contents to something unsafe without being
forced to remove the set*id bits.

Similar for {g,u}id changes. Someone starts a chown() taking inode lock
while someone issues a concurrent write. The chown changes the group
ownership so that a writer would be forced to drop the sgid bit. But the
writer proceeds keeping that bit.

So that's all potentially pretty subtle side-effects we'd allow. And
I've removed so many bugs in that area the last couple of years as well.
So let's please use the shared lock.

