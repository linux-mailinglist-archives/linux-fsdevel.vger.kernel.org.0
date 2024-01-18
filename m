Return-Path: <linux-fsdevel+bounces-8246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772B831B19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD0DB25553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3125773;
	Thu, 18 Jan 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSLfcV/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C6324B4B;
	Thu, 18 Jan 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586988; cv=none; b=mfy3Eu12gMspVJUZQRJGL19wrsDqE2Mauq2U3x9XF6SX48L8Kb3OsbgJh6vttNScauURw/KiDlEWofWKKPS0I3NbHDGfEnp8TWcKZUsNafonxyWnjOixd91/zmbXknPjIxEyVo9rfDszi1uiq10KAM/7BuZXI+rVmz0hnZtKPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586988; c=relaxed/simple;
	bh=+uFBRg+XaeNY1sPVwHQo/VqbyI65U/bod8Ks5LIqYek=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=dT1VsbuvYOXPUppMRe4GMB8qX9ng9dE6MLeQXq1TlxHyZwIdbUvKZSk7fcfsJv2tPTGAtYjrB8KVibE+TA1dCmQQ8P6EkLEuuOY2DEbRs7umcXaYjqGsej8FSy8cP+SMzkK5ohGU1b+3eYnCGyltS9u6nerY9WYm0CP7f6xCxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSLfcV/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C05BC433C7;
	Thu, 18 Jan 2024 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705586988;
	bh=+uFBRg+XaeNY1sPVwHQo/VqbyI65U/bod8Ks5LIqYek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSLfcV/8yBbm5ZKTFUL/doJcqcL30ntPGL5eUWW/TeQoN3+eR18xeiODZBxQm/phq
	 MvI2qyplIJVT4lioZi9Qsn3Bxa875gxGHedOjrayo+doO0D6kpFHloWjxREaTxRJm0
	 bvHwOiooFm9wMJEHLlClXMob6KwfpLcexr47QGf1QIaZ4d8u/N7FhnQZ7BBeoBiUBF
	 74ub4EOUPfPj3gveMAblHaarh2jWcCqV4rUTTJ4YJsNr+nVt7ylmBofxtmCshPONyE
	 sb5r5cvstJGRU/wa6pT770I+bpWtWZbHaZFEuKx+tVbj7BVsMZAKVCUx2Sb9AlWo41
	 lYc8CNKddhXfQ==
Date: Thu, 18 Jan 2024 15:09:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	adrianvovk@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240118-wieweit-windschatten-19cfa8111b45@brauner>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <ZabtYQqakvxJVYjM@dread.disaster.area>
 <20240117-yuppie-unflexibel-dbbb281cb948@brauner>
 <ZahUBkqYad0Lb3/V@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZahUBkqYad0Lb3/V@dread.disaster.area>

> > The fact that after a block layer initiated freeze - again mostly a
> > device mapper problem - one may or may not be able to successfully read
> > from the filesystem is annoying. Of course one can't write, that will
> > hang one immediately. But if one still has some data in the page cache
> > one can still dump the contents of that file. That's at least odd
> > behavior from a users POV even if for us it's cleary why that's the
> > case.
> 
> A frozen filesystem doesn't prevent read operations from occurring.

Yes, that's what I was saying. I'm not disputing that.

> 
> > And a freeze does do a sync_filesystem() and a sync_blockdev() to flush
> > out any dirty data for that specific filesystem.
> 
> Yes, it's required to do that - the whole point of freezing a
> filesystem is to bring the filesystem into a *consistent physical
> state on persistent storage* and to hold it in that state until it
> is thawed.
> 
> > So it would be fitting
> > to give users an api that allows them to also drop the page cache
> > contents.
> 
> Not as part of a freeze operation.

Yes, that's why I'd like to have a separate e.g., flag for fadvise.

> > For some use-cases like the Gnome use-case one wants to do a freeze and
> > drop everything that one can from the page cache for that specific
> > filesystem.
> 
> So they have to do an extra system call between FS_IOC_FREEZE and
> FS_IOC_THAW. What's the problem with that? What are you trying to
> optimise by colliding cache purging with FS_IOC_FREEZE?
> 
> If the user/application/infrastructure already has to iterate all
> the mounted filesystems to freeze them, then it's trivial for them
> to add a cache purging step to that infrastructure for the storage
> configurations that might need it. I just don't see why this needs
> to be part of a block device freeze operation, especially as the
> "purge caches on this filesystem" operation has potential use cases
> outside of the luksSuspend context....

Ah, I'm sorry I think we're accidently talking past each other... I'm
_not_ trying to tie block layer freezing and cache purging. I'm trying
to expose something like:

posix_fadvise(fs_fd, [...], POSIX_FADV_FS_DONTNEED/DROP);

The Gnome people could then do:

cryptsetup luksSuspend
posix_fadvise(fs_fd, [...], POSIX_FADV_FS_DONTNEED/DROP);

as two separate operations.

Because the dropping the caches step is useful to other users as well;
completely independent of the block layer freeze that I used to
motivate this.

