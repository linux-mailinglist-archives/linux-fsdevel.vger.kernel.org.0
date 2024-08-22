Return-Path: <linux-fsdevel+bounces-26835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09195BF9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2955C2857E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DC1D0DF7;
	Thu, 22 Aug 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCLvJqa/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEED2AE77;
	Thu, 22 Aug 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358911; cv=none; b=a+ybTlfHAUpjndzVJWgpNxyJFrVaCAncPhVU3ANsZ/Ii/G+CzIiv0mKSTlNrjQmMPnnZ+CxIVzjKI3wOkkCAvLm6LHImxycTEMhKUC6WpZhmoaN2/fVk4oiiJzAay6TtVgbrub7BQKOOmB/zK9Yexe9ktxHpF0rEfx+jcUDTz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358911; c=relaxed/simple;
	bh=0ONpzREj/70uQ9uEm0QHIgrVvV+MVjNhOwX1XyuFSww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBWJ7v/r7/g7O5dKNyIDYtNO8ic+SAr/be45bHpwRnXp+cXs8YLbq4O5oyYOcb8zN/4VtBrRnhO9DBxH65ekU7DNUaUykWnDArn6WfprlMH4S58B+ucR5pmaBFY8kjOzSjOJyGT7wNPYCUqNpsPymd2psW8icXkZJwQJA18uWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCLvJqa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF8AC32782;
	Thu, 22 Aug 2024 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724358910;
	bh=0ONpzREj/70uQ9uEm0QHIgrVvV+MVjNhOwX1XyuFSww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCLvJqa/8NzwGN4MFaEWFnwAh7AHhe/7DUl2U9uf+dczuJ2tl/A01xDD3fSomQ0WI
	 +VWMmDfkpK5FEWAeDeHqzoSn26+NJitnldwzHm+0yR/94t7tWy2avGjyOkH/APlOLL
	 S7hMvWumelioBnX35y/ZqXLDO0a8qnB+vFr7cLcW0ECJITpyGt450JNTpND9SjQW8Z
	 RpBvJVjuumUPiCYqKwC9uXKMyxrgsJ6sIRlDcYh7A1hF42f7M6fxXNFV9+jTam72RZ
	 bSkJPtEQpjTrXST2X5SsX1gGOpKCR0p3iF1dFaCRiqdipaeqm81T4gNmBrLc6r1XG/
	 Q4YzuAL0INk4A==
Date: Thu, 22 Aug 2024 13:35:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
Message-ID: <20240822203510.GS865349@frogsfrogsfrogs>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
 <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
 <c8be257c-833f-4394-937d-eab515ad6996@oracle.com>
 <20240726171358.GA27612@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726171358.GA27612@lst.de>

On Fri, Jul 26, 2024 at 07:13:58PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 26, 2024 at 03:29:48PM +0100, John Garry wrote:
> > I have been considering another approach to solve this problem.
> >
> > In this patch - as you know - we zero unwritten parts of a newly allocated 
> > extent. This is so that when we later issue an atomic write, we would not 
> > have the problem of unwritten extents and how the iomap iterator will 
> > create multiple BIOs (which is not permitted).
> >
> > How about an alternate approach like this:
> > - no sub-extent zeroing
> > - iomap iter is changed to allocate a single BIO for an atomic write in 
> > first iteration
> > - each iomap extent iteration appends data to that same BIO
> > - when finished iterating, we submit the BIO
> >
> > Obviously that will mean many changes to the iomap bio iterator, but is 
> > quite self-contained.
> 
> Yes, I also suggested that during the zeroing fix discussion.  There
> is generally no good reason to start a new direct I/O bio if the
> write is contiguous on disk and only the state of the srcmap is different.
> This will also be a big win for COW / out of place overwrites.

But what happens if the pre-write state is:

WUWUWUWU

You can write all 8 blocks with a single bio, but the directio write
completion has to run four separate transactions to convert the four
unwritten mappings.  For COW it's ok if we crash midway through the
ioend such that a read after recovery sees this:

WWWWW0W0

because we've never guaranteed what happens if the system crashes before
fsync completes.  For untorn writes this is not allowed (even if the
actual disk contents landed successfully) because we said we wouldn't
tear the write.

--D

