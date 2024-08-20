Return-Path: <linux-fsdevel+bounces-26398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDF958EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F786B227D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C6159565;
	Tue, 20 Aug 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufF3CqrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55428E8;
	Tue, 20 Aug 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182457; cv=none; b=aOsi7zlmlLVds2a9mNZwePRKKEExNH9+ww53HgX8lFoRev2r/MrIIhX/sAuxwbYHhY0xa2bpHgMqJO3kLVTqeHfnBbzHotmPWhrFuHMAt3oRFwXbCoCsg9mYpbhex+kMajv/W1urrTeN85akZyiyY8Gk/u1xmQ+x5DCnRDyS8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182457; c=relaxed/simple;
	bh=ztkY1HcRzYZPhdNOGcVyvUZWwCzGOeoC3a5BlTiOty8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmJx1TVYiR6aOG9vI+VhuNpdM14NgMY76zK50OQzmZF7ncIkNVwcR/QLbEuiH3w06BqXaLkdrBxawHGn1/c13ekhDM54WtNEkO2l8GtH7pse9W77Y9ni7HrIztlAVxlIDc963sP7u128F+orDZ+NYLDROaxsNafBSS5tc25iGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufF3CqrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E045C4AF15;
	Tue, 20 Aug 2024 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724182456;
	bh=ztkY1HcRzYZPhdNOGcVyvUZWwCzGOeoC3a5BlTiOty8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufF3CqrKmgREyHzpn6s40n4gwbUKiBn3qYB54yCPjq5LYv4aLjVMy1ChiZalXul//
	 jv1ahPCJhMGX6eEsoKZHeIGw27bmCwNDvJB1muHRgl0C3BDWaEYfp0UFmdfT8GgrcT
	 GF8NBVLrnkXe60xwRXdae6uljlJd2lLFqG7LJYVphrzXxhyswKygIHWVaywdiBq4Df
	 w3B7Hgn/DYMhTwhsgyUmA47XYlJhGhTSUqTjAmJCxgOqFMa3S8mI5zKIKfzLrnwbi5
	 xCPAOofu9jst2h2B/nZ2jgeM6KSSkX73aNChZHh8Ly2k/F6s7jR7zQ95NMfwdRRK6E
	 ldb9rbpIIyf6Q==
Date: Tue, 20 Aug 2024 12:34:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240820193414.GA1178@sol.localdomain>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240818035818.GA1929@sol.localdomain>
 <20240819-staudamm-rederei-cb7092f54e76@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-staudamm-rederei-cb7092f54e76@brauner>

On Mon, Aug 19, 2024 at 10:41:15AM +0200, Christian Brauner wrote:
> On Sat, Aug 17, 2024 at 08:58:18PM GMT, Eric Biggers wrote:
> > Hi Christian,
> > 
> > On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
> > > It's currently possible to create pidfds for kthreads but it is unclear
> > > what that is supposed to mean. Until we have use-cases for it and we
> > > figured out what behavior we want block the creation of pidfds for
> > > kthreads.
> > > 
> > > Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  kernel/fork.c | 25 ++++++++++++++++++++++---
> > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > Unfortunately this commit broke systemd-shutdown's ability to kill processes,
> > which makes some filesystems no longer get unmounted at shutdown.
> > 
> > It looks like systemd-shutdown relies on being able to create a pidfd for any
> > process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
> > fatal error and stops looking for more processes...
> 
> Thanks for the report!
> I talked to Daan De Meyer who made that change and he said that this
> must a systemd version that hasn't gotten his fixes yet. In any case, if
> this causes regression then I'll revert it right now. See the appended
> revert.

Thanks for queueing up a revert.

This was on systemd 256.4 which was released less than a month ago.

I'm not sure what systemd fix you are talking about.  Looking at killall() in
src/shared/killall.c on the latest "main" branch of systemd, it calls
proc_dir_read_pidref() => pidref_set_pid() => pidfd_open(), and EINVAL gets
passed back up to killall() and treated as a fatal error.  ignore_proc() skips
kernel threads but is executed too late.  I didn't test it, so I could be wrong,
but based on the code it does not appear to be fixed.

- Erici

