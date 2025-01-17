Return-Path: <linux-fsdevel+bounces-39514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D656A1568E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC863A735F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896371A726B;
	Fri, 17 Jan 2025 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lST5Pkkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119F166F3D;
	Fri, 17 Jan 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138587; cv=none; b=tS7Z97iQH9TrTlkrOfFJDp+BqIQB0hyQyHnd7kdDniHod4UMQHd5d19w3pYeAImSahuEnhiQ8EfwAyq/3jQ1nlXGLTuJa42vTqflgadKnZPn2TXOnRdOwq1bIC6j3kYCCQJCR0vWiC7Z2snxHxcRZl6LsF7hXDj+7jaGOeljM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138587; c=relaxed/simple;
	bh=vPiJ1zoVNCjg0h2CznQ0UgJouAXELt7xZY9Fh151V38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3KQ8y2MAh53zhnZmIl7uTOJNnJODyJZEOVlHexNXb8B94bsxMb1O+BlL/NA7whwSzvpFBNFc3WSGpt1XMtMmtxHiWGQLGc2MBjDOsXg5nl0Xt6r803e6R4TNyqsH+P3qF5FAeS9StiOu3cX0sGo/PkNnrM8uuwpkMWiwY9mX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lST5Pkkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532AEC4CEE3;
	Fri, 17 Jan 2025 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737138586;
	bh=vPiJ1zoVNCjg0h2CznQ0UgJouAXELt7xZY9Fh151V38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lST5PkktozMAzz8qxAZVQCwfOavw5m6hW2HqaTATuiaJiKIk9u+U8WghZ+Y16gt4/
	 CzqkXPDW1G5UGoKEwyccsiSZAVTwuCt3SCeWsJDy7bKaP53+8cAVxpjZvpaDHc4+T2
	 aBlxNlsiyMWe0Zx2S36i3ZtFIWbUXL2ceVIN2TkHDu0KiqApsp9V7wWFHtNcY+KO9w
	 QPxthcoUHWhlPIm7qZfXO1JfG/NXbaUep0YGBHdyLSsPvX31RJ3cBsGWOm2K7C0J9j
	 CRV03aFqgEzZ1wMdTdQ4E/ZX1h6fG7BjfQXRJNpu1JOuEihKvEupQeGUZKXX/F10us
	 wA4mBScD4jxpw==
Date: Fri, 17 Jan 2025 10:29:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20250117182945.GH1611770@frogsfrogsfrogs>
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs>
 <01e781da-0798-4de6-ad03-6099f15f308e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e781da-0798-4de6-ad03-6099f15f308e@oracle.com>

On Fri, Jan 17, 2025 at 10:26:34AM +0000, John Garry wrote:
> On 14/01/2025 23:57, Darrick J. Wong wrote:
> > > i.e. RWF_ATOMIC as implemented by a COW capable filesystem should
> > > always be able to succeed regardless of IO alignment. In these
> > > situations, the REQ_ATOMIC block layer offload to the hardware is a
> > > fast path that is enabled when the user IO and filesystem extent
> > > alignment matches the constraints needed to do a hardware atomic
> > > write.
> > > 
> > > In all other cases, we implement RWF_ATOMIC something like
> > > always-cow or prealloc-beyond-eof-then-xchg-range-on-io-completion
> > > for anything that doesn't correctly align to hardware REQ_ATOMIC.
> > > 
> > > That said, there is nothing that prevents us from first implementing
> > > RWF_ATOMIC constraints as "must match hardware requirements exactly"
> > > and then relaxing them to be less stringent as filesystems
> > > implementations improve. We've relaxed the direct IO hardware
> > > alignment constraints multiple times over the years, so there's
> > > nothing that really prevents us from doing so with RWF_ATOMIC,
> > > either. Especially as we have statx to tell the application exactly
> > > what alignment will get fast hardware offloads...
> > Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
> > write that's correctly aligned and targets a single mapping in the
> > correct state, we can build the untorn bio and submit it.  For
> > everything else, prealloc some post EOF blocks, write them there, and
> > exchange-range them.
> 
> I have some doubt about this, but I may be misunderstanding the concept:
> 
> So is there any guarantee that what we write into is aligned (after the
> exchange-range routine)? If not, surely every subsequent write with
> RWF_ATOMIC to that logical range will require this exchange-range routine
> until we get something aligned (and correct granularity) - correct?

Correct, you'd still need forcealign to make sure that the new
allocations for exchange-range are aligned to awumin.

--D

> I know that getting unaligned blocks continuously is unlikely, unless a
> heavily fragmented disk. However, databases prefer guaranteed performance
> (which HW offload gives).
> 
> We can use extszhint to hint at granularity, but that does not help with
> alignment (AFAIK).
> 
> > 
> > Tricky questions: How do we avoid collisions between overlapping writes?
> > I guess we find a free file range at the top of the file that is long
> > enough to stage the write, and put it there?  And purge it later?
> > 
> > Also, does this imply that the maximum file size is less than the usual
> > 8EB?
> > 
> > (There's also the question about how to do this with buffered writes,
> > but I guess we could skip that for now.)
> 
> 

