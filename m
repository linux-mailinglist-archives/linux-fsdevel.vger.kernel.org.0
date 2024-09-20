Return-Path: <linux-fsdevel+bounces-29759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9C97D739
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0B0283ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E817C22E;
	Fri, 20 Sep 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/f4vPCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914701E521;
	Fri, 20 Sep 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844534; cv=none; b=XRvIKypyysr+lMHQQxjARqfoQQEy/a+mLjksbmzihfeps6GKVGy5CHuoVuFnGsY9H9uXn/gPOSBItA/GRI+u1Xq7AhkKWjlitZsNW5tVtsENFBjToCKe9JK0sKLVm4CtHL9ynVqg7LueRMwDGJS08X6SU3P6HzFPWDSXIzN/pfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844534; c=relaxed/simple;
	bh=0md31GigCXaS8ynROwtkzrwr5E1Pi/su5nrUsXz5+IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFYfpLwmILcgyXTB1jmzNsMVVZQCr8CSe0BiImGdpATyot5FNRkA/2aIk+Y3xUVxXDBPAmR5HBKGLPrUHy/zQHOV7qBoCZZOb49uEpLsQZ+Bp3zwn5+hXB3pI9AIiw29CiOnEpH3IpO9KSPfcEegWZBlQAMSmd9tb/6zUGWKSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/f4vPCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA85C4CEC3;
	Fri, 20 Sep 2024 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726844534;
	bh=0md31GigCXaS8ynROwtkzrwr5E1Pi/su5nrUsXz5+IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/f4vPCzxaTTFNwzrxQB/0R9GcljwehOegFu+CexwbvYTICY+mw5wi5tBZ3bMfdqV
	 19pRbvADHygVQwnfhEhO2ncQaWrR/D6ExOhfRWwxdmIC1exy296cqQTyxW6NYjlKMl
	 V9L/69nXCB4xLcXAuHX+dmxZuz/iR0CbE2mjDzssfgJ/pIY+E/idg/OQGS6wzVbKkr
	 B4O8QAvi9f3b/mAs3OYdKnDtimqVSUnTu5tysnTZ+qehLcHuim5NWKY4ATsOLBeAVV
	 baEH1CTr+HPiojjbiuRHFYrzyYOAuZCEglTesgi5hbB5MuNC9BAq7PsecQtvWcDelJ
	 b8GkSf2mHQafw==
Date: Fri, 20 Sep 2024 08:02:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Julian Sun <sunjunchao2870@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks()
 when overflow check fails
Message-ID: <20240920150213.GD21853@frogsfrogsfrogs>
References: <20240920123022.215863-1-sunjunchao2870@gmail.com>
 <Zu2EcEnlW1KJfzzR@infradead.org>
 <20240920143727.GB21853@frogsfrogsfrogs>
 <Zu2NeawWugiaWxKA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu2NeawWugiaWxKA@infradead.org>

On Fri, Sep 20, 2024 at 07:58:01AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 20, 2024 at 07:37:27AM -0700, Darrick J. Wong wrote:
> > On Fri, Sep 20, 2024 at 07:19:28AM -0700, Christoph Hellwig wrote:
> > > On Fri, Sep 20, 2024 at 08:30:22PM +0800, Julian Sun wrote:
> > > > Keep it consistent with the handling of the same check within
> > > > generic_copy_file_checks().
> > > > Also, returning -EOVERFLOW in this case is more appropriate.
> > > 
> > > Maybe:
> > > 
> > > Keep the errno value consistent with the equivalent check in
> > > generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
> > > more appropriate value to return compared to the overly generic -EINVAL.
> > 
> > The manpage for clone/dedupe/exchange don't say anything about
> > EOVERFLOW, but they do have this to say about EINVAL:
> > 
> > EINVAL
> > The  filesystem  does  not  support  reflinking the ranges of the given
> > files.
> 
> Which isn't exactly the integer overflow case described here :)

Hm?  This patch is touching the error code you get for failing alignment
checks, not the one you get for failing check_add_overflow.  EOVERFLOW
seems like an odd return code for unaligned arguments.  Though you're
right that EINVAL is verrry vague.

> > Does this errno code change cause any regressions in fstests?
> 
> Given our rather sparse test coverage of it I doubt it, but it
> would be great to have that confirmed by the submitter.

Yes. :)

> While we're talking about that - a simple exerciser for the overflow
> condition for xfstests would be very useful to have.

Yes, there's <cough> supposed to be one that does that.

$ git grep -ci CLONE.*invalid.argument
common/filter.btrfs:1
tests/btrfs/035.out:1
tests/btrfs/052.out:12
tests/btrfs/096.out:1
tests/btrfs/112.out:16
tests/btrfs/113.out:1
tests/btrfs/229:1
tests/generic/157.out:6
tests/generic/303.out:4
tests/generic/518.out:1


--D

