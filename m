Return-Path: <linux-fsdevel+bounces-41553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E1A31A96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 01:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C8A7A2AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545A1EB2F;
	Wed, 12 Feb 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebeRGoMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5AF1C695;
	Wed, 12 Feb 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320747; cv=none; b=mrdQOC36iCTaEgssoVS9M/w3lLcdCwxB9PC3EEFsnMvXrnqhlNi8huu/2roW/okQ0tqlUAencxo8e4edtuX/98IzFLi4QYIuqw37O1/vFiDehnm1kKjPa6uCkxACQ2uHWkD76xFRU2UY8HQYBg16ShLQoRwPkmco8d/4qKO2oAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320747; c=relaxed/simple;
	bh=4UzwP9mzXKuiCXOs+Y9SzPdYG/HGt/RpUx2drHDa7J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlOxzBUjrPUYYQ8aFxbHlD6+gkBuCTI8y2vwXeGL13VFx2U07OPEAhsPNF58zkknjdVa18dQDGhp++IIY8rkja+URIZm+1cdzQq6tXQJpxWWK6iNuMm99f/ylq3pM6FDrwf+WwYEExpgiDur242pY2qLUraw8VFsXb/u2DAqZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebeRGoMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B854C4CEDD;
	Wed, 12 Feb 2025 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320746;
	bh=4UzwP9mzXKuiCXOs+Y9SzPdYG/HGt/RpUx2drHDa7J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebeRGoMYbTZd2SfuijG7tuIxqoBpjfvwIZJnfD/90W8lULSGbjjBUobyzxBQYhoOO
	 h+qoJw8YLwP8RvzGyl3HgUFTfSpmFM9otwil+uqnndpim1jG0S3tFveQcvzR7JGApV
	 o2iXRA10BU3x9wo5XjPlDh1t782hkJmymH28h4ey/b1NLNGtgL+htxyWC7IOhcivjy
	 ECmioTToU65ecSINjnchVemGqfXjrs2i61bdkDy1CVorYfbKHRFBepM/ZBtxu45fyj
	 LsOmEnysEAOp851zcnqx2A7TV8r45lKhcqDrdpPn5KuBYRV3vsx//uq5tMSiwZxFHU
	 UDfYoQpp5j/xw==
Date: Wed, 12 Feb 2025 00:39:04 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6vtqMB1P_t390Vg@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com>
 <Z6JAcsAOCCWp-y66@google.com>
 <Z6owv7koMsTWH1uM@google.com>
 <Z6o1TcS7mQ2POrc9@casper.infradead.org>
 <Z6pNBxgMKHTiHAnv@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6pNBxgMKHTiHAnv@google.com>

On 02/10, Jaegeuk Kim wrote:
> On 02/10, Matthew Wilcox wrote:
> > On Mon, Feb 10, 2025 at 05:00:47PM +0000, Jaegeuk Kim wrote:
> > > On 02/04, Jaegeuk Kim wrote:
> > > > On 01/17, Jaegeuk Kim wrote:
> > > > > On 01/17, Matthew Wilcox wrote:
> > > > > > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > > > > > I don't understand how this is different from MADV_COLD.  Please
> > > > > > > > explain.
> > > > > > > 
> > > > > > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > > > > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > > > > > at the time when it's called. The idea is to keep the hints only, and try to
> > > > > > > reclaim all later when admin expects system memory pressure soon.
> > > > > > 
> > > > > > So you're saying you want POSIX_FADV_COLD?
> > > > > 
> > > > > Yeah, the intention looks similar like marking it cold and paging out later.
> > > > 
> > > > Kindly ping, for the feedback on the direction. If there's demand for something
> > > > generalized api, I'm happy to explore.
> > > 
> > > If there's no objection, let me push the change in f2fs and keep an eye on
> > > who more will need this in general.
> > 
> > I don't know why you're asking for direction.  I gave my direction: use
> > fadvise().
> 
> Funny, that single question didn't mean like this at all. Will take a look
> how the patch looks like.

Ok, it seems we can get this hint via POSIX_FADV_NOREUSE. I'll take that
instead of adding a new API. Thanks.

> 
> > 
> > Putting this directly in f2fs is a horrible idea.  NAK.

