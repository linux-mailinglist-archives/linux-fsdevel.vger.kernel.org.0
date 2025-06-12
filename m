Return-Path: <linux-fsdevel+bounces-51522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0EAD7C90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CAA7B1804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B363A2D8762;
	Thu, 12 Jun 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4svedbu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1B27C179;
	Thu, 12 Jun 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760644; cv=none; b=uCYiqReN9tYrDCyv/aJ5hpI8uOOd44Phz10t5z0s5ObF3sbc8Zl2TloEh1IzuyizhafCyOJMp3BQ24UqCONoVDabJlHf5UujPAogNEJGTVDs7/VpCP934MxwwPWCygi2CKIk0ZceVNg/ADjt1CN5BLfRJ2ePRozHtMdYezzkHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760644; c=relaxed/simple;
	bh=JNuRqevYgAO3YFr9wUMcd3s2kkWKF2nSoOhvyhEwTsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvHfPTKfL8SXbcMsv3azBCpfF3hy8S5rYtl66NiUZN9HYkPVQlZS+/UzfeaHJu5e50Qd3CbVaJsoALjzsGYuv1pQ8fUYuz1RoFgS7lvYfncydJC+C2aSrYKoX9g3axb9hWP+LwNdkL541qpx72kGDkWXbcEUufxXDmgcY8+NM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4svedbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0A2C4CEEA;
	Thu, 12 Jun 2025 20:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749760643;
	bh=JNuRqevYgAO3YFr9wUMcd3s2kkWKF2nSoOhvyhEwTsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4svedbupMPBVUZyWIddZUcq9dick7dofGuZUr7tCiG5Gy02C1LzYZhEbyWewT4bf
	 UsMqYPDvVOhi66e3AFcsDzafmL9CJNo5UkU55URstk01KY82LSZoAfU6RItszuyTVo
	 T/KOAwiB3CCX+3odkJV/FmNI1ZkHJXH9o6VXzek//P+n/zu/7/hjxSMn6ublEMU9hE
	 T30vvEiJdhy0Rgg6cA7zPVQSRyGnLfeEX/5MH1NteROD/nSftx74C1+KNfGxYhlCdo
	 wB3xRjqYM50R8krww3T4r73LYjQ6pA8eHkOCbkvhNldwviAs0lqP67fgzaZ4KD4ccg
	 WRQQxRS4kK1nw==
Date: Thu, 12 Jun 2025 16:37:22 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 0/6] NFSD: add enable-dontcache and initially use it to
 add DIO support
Message-ID: <aEs6gmTXzhzuDZOI@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <54acf3548634f5a46fa261fc2ab3fdbf86938c1c.camel@kernel.org>
 <aEqEQLumUp8Y7JR5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqEQLumUp8Y7JR5@infradead.org>

On Thu, Jun 12, 2025 at 12:39:44AM -0700, Christoph Hellwig wrote:
> 
> Another thing is that using the page cache for reads is probably
> rather pointless.  I've been wondering if we should just change
> the direct I/O read code to read from the page cache if there are
> cached pages and otherwise go direct to the device.  That would make
> a setup using buffered writes (without or without the dontcache
> flag) and direct I/O reads safe.

Yes, that sounds like a good idea.  Just an idea at this point or have
you tried to implement it?

I'll start looking at associated code, but may slip until next week.

FYI, I mentioned this earlier at one point in this thread but I was
thinking the IOR "hard" benchmark would offer a solid test for
invalidating page cache vs O_DIRECT read when ran against NFS/NFSD
with this NFSD O_DIRECT series applied: which causes NFSD's misaligned
IO to use buffered IO for writes and O_DIRECT for reads.  NFSD issuing
the misaligned write to XFS will force RMW when writing, creating
pages that must be invalidated for any subsequent NFSD read.

Turns out IOR "hard" does in fact fail spectacularly with:
  WARNING: Incorrect data on read (6640830 errors found).

It doesn't fail if the 6th patch in this series isn't used:
https://lore.kernel.org/linux-nfs/20250610205737.63343-7-snitzer@kernel.org/

Could be a bug in that patch but I think it more likely IOR-hard is
teasing out the invalidation race you mentioned at the start.

We're retesting with RWF_SYNC set for the buffered write IO (which
Jeff suggested earlier in this thread).

But your idea seems important to pursue.

I won't be posting a v2 for this series until I can find/fix this
IOR-hard testcase.

Mike

