Return-Path: <linux-fsdevel+bounces-46867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7ACA95A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BC9189499A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2B18BC1D;
	Tue, 22 Apr 2025 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I77RryVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E55234;
	Tue, 22 Apr 2025 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284750; cv=none; b=rDB4L0r8MRSNTcUYTOy3fPZ004NOcd1KCuxbiS5BJTjXy4xZrDafkBcMQyMYVQAd3ca1moBo4q3S/8Sb8liobvU3VuHcye+DkZ0GFwugK7Mt0IMvmxcwp96Y80hfz2AAjBl8mVXxJVwxHh9VMg3RD2t3ULkEXBJxjwoDZVJKKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284750; c=relaxed/simple;
	bh=eP9ll7giGUWiL/szu57fjosnt0vGjzvon7UdDIRlSyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwL4yqxTu+lBEyqop8yDek+iTQVQqlKHo39x5A4krAohIn301dUtqJU26c59w/f2YRQXmWspa8PFPf0RL5rIz3my48drToS5cJhQX3p+e3k6iTxrEN89MacZyHEaU0vpLoQ5MoJZoOoCCGwmna2YkPgg72SRS58KuUmOPaRA0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I77RryVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC476C4CEE4;
	Tue, 22 Apr 2025 01:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284748;
	bh=eP9ll7giGUWiL/szu57fjosnt0vGjzvon7UdDIRlSyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I77RryVhwIKu8+tKW9NNVt3+RfUNmS3w5F0QEe+CcVq3lY+7Fz5LRkwGYBlpEnU09
	 7/1wDdRtRNrBkt9DPdYSNxjHFzOvSk3/Vc6WuFI118GmNOAqsmlhqHYG6wfqsLHNVZ
	 SZXU2ov+kNxI8DPd/i7IoUHQQLYEDCct+0dCWiDB72Qq2qS3UjTvmzdWh4rxTvRsUY
	 iSttD1+WwC1WJSv9Un0fkfLshs46Xm9a1zVSuVYLyLtpGOmKRAl9w5Tj3x8rS1pQtG
	 oBHV17V5nnYIPDk3zRkmCk2trCS2dDDdq6xdSYXZ0KxEbW4K2F4BuBC3SFypcKiOCk
	 xQSquRSsu5DeA==
Date: Mon, 21 Apr 2025 18:19:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: cem@kernel.org, hch@lst.de, shinichiro.kawasaki@wdc.com,
	linux-mm@kvack.org, mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
Message-ID: <20250422011908.GV25675@frogsfrogsfrogs>
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
 <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
 <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>
 <20250421205116.GF25700@frogsfrogsfrogs>
 <c6bcce15-647c-4de8-aa01-6cd3ec5bf904@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6bcce15-647c-4de8-aa01-6cd3ec5bf904@kernel.dk>

On Mon, Apr 21, 2025 at 02:53:42PM -0600, Jens Axboe wrote:
> On 4/21/25 2:51 PM, Darrick J. Wong wrote:
> > On Mon, Apr 21, 2025 at 02:26:54PM -0600, Jens Axboe wrote:
> >> On 4/21/25 2:24 PM, Jens Axboe wrote:
> >>> On 4/21/25 11:18 AM, Darrick J. Wong wrote:
> >>>> Hi all,
> >>>>
> >>>> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
> >>>> between set_blocksize and block device pagecache manipulation; the rest
> >>>> removes XFS' usage of set_blocksize since it's unnecessary.
> >>>>
> >>>> If you're going to start using this code, I strongly recommend pulling
> >>>> from my git trees, which are linked below.
> >>>>
> >>>> With a bit of luck, this should all go splendidly.
> >>>> Comments and questions are, as always, welcome.
> >>>
> >>> block changes look good to me - I'll tentatively queue those up.
> >>
> >> Hmm looks like it's built on top of other changes in your branch,
> >> doesn't apply cleanly.
> > 
> > Yeah, I'm still waiting for hch (or anyone) to RVB patches 2 and 3.
> 
> Maybe I wasn't 100% clear, but what I mean is that patches 1 and 2 don't
> apply to the upstream kernel, as they are sitting on top of other
> patches that block block/bdev.c in your tree. So even if acked, they
> can't go in as-is. Well they can, I'd just have to hand apply them.
> Which isn't the end of the world, but the dependency wasn't clear (to
> me, at least) in the sent out patches.

Oh!  Silly me, I forgot that there were debug patches.  Will attach
Luis' review tags, rebase, and resend.  Sorry about that. :/

--D

> -- 
> Jens Axboe
> 

