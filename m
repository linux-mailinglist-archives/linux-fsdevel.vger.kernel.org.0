Return-Path: <linux-fsdevel+bounces-31098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF260991B9B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C31E1F21125
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3497B67F;
	Sun,  6 Oct 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIC4DWJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6F63A9;
	Sun,  6 Oct 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174624; cv=none; b=bs8s7W0+/weDlAi9Y9DqV0ZPxAlekbwz4mSdj4xw0q69Y8brEOQ0JKRzPlUwpJYpuZmlELGD1/6Q9YEzah2phEnMVT3qywgpVrl6sSRN8Wz0CQ2UkMCcdh5RAh9ml6PmclqQog6R2k7uMhGRzechh9eGqHBbdMYUJD3BTXrjdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174624; c=relaxed/simple;
	bh=oqblIYdx9eZFWe5fwD+19RsYKavE0aEIhzBYTqN48/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkyTuBLWAKBDL65eBTR7UMmHD1WnU1An8pBZg/XbE/gJCyCFi9I/QM1Gg9dxcYMH6VkzCIcBoG2ZowNnJ6yqI2ll8sk1JkMrEpjPuP3L6NCpDsRdae6o7FWLFtr23/HFA1uAVCZk/16fTRXMZveTNRUglSUi7Bmfwp6X5IqVpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIC4DWJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA024C4CEC2;
	Sun,  6 Oct 2024 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174624;
	bh=oqblIYdx9eZFWe5fwD+19RsYKavE0aEIhzBYTqN48/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIC4DWJ4JLDTgiUmnoEbRm5EcqrGfzp1AukJ3VdKXV1wg12knyKwnhXFWVvdVewQp
	 U5mJ69n9bAhE8KIaYij2UpH1Khx3V74/nnqRbbon222TXnl03uvzAoTeuw6jCHoOYr
	 JlDnCgW+qOqww9KrWer065W4Lz0HKfoIu+OPD7ez5btz+2mNHzDzFTv8NhKFR/QWZd
	 CEBHlrfC0+XhPYAV8vHYpWerrkJ6oXA2ld5x3EEZmcQ6H/81sdGiAZlmsa2ZKnUBoJ
	 P5gasA7YG/ms6Q9jFk7H6QGDmZLSBM/SUfXE06voYQJWG/hw43lSU8dEJWZqolzNzc
	 hlOPAq8lUIqxA==
Date: Sat, 5 Oct 2024 20:30:22 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 237/244] iomap: fix iomap_dio_zero() for fs
 bs > system page size
Message-ID: <ZwHaHrQNr1KbgyN3@sashalap>
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-237-sashal@kernel.org>
 <ZvQJuuGxixcPgTUG@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZvQJuuGxixcPgTUG@dread.disaster.area>

On Wed, Sep 25, 2024 at 11:01:46PM +1000, Dave Chinner wrote:
>On Wed, Sep 25, 2024 at 07:27:38AM -0400, Sasha Levin wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> [ Upstream commit 10553a91652d995274da63fc317470f703765081 ]
>>
>> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
>> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
>> size < page_size. This is true for most filesystems at the moment.
>>
>> If the block size > page size, this will send the contents of the page
>> next to zero page(as len > PAGE_SIZE) to the underlying block device,
>> causing FS corruption.
>>
>> iomap is a generic infrastructure and it should not make any assumptions
>> about the fs block size and the page size of the system.
>
>Please drop this. It is for support of new functionality that was
>just merged and has no relevance to older kernels. It is not a bug
>fix.
>
>And ....
>
>> +
>> +	set_memory_ro((unsigned long)page_address(zero_page),
>> +		      1U << IOMAP_ZERO_PAGE_ORDER);
>
>.... this will cause stable kernel regressions.
>
>It was removed later in the merge because it is unnecessary and
>causes boot failures on (at least) some Power architectures.

Dropped, and sorry about sending this one out twice!

-- 
Thanks,
Sasha

