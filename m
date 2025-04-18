Return-Path: <linux-fsdevel+bounces-46689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF169A93C6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3418E4B02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF221CFEA;
	Fri, 18 Apr 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnXztOqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420921C9F7;
	Fri, 18 Apr 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998958; cv=none; b=NPCnwZpHCfXyZmyv5/ooALbvDThNgWa+saL/7cCOvmPyTvt9XBPAjOzwwRwIJ2cE724srfb9LjgSm5iDjHS/sYSl4WY06cIVk0t8jYfnI6LeGjK3u8ZstbLVYJr3r2LDhT/WHeix9vfw2gl/yyMnQBP0gQ0K2WVAMbrE2e//Ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998958; c=relaxed/simple;
	bh=VhKfdYgqpCKf6CE0wi4fGRaaQa8UVPPJjOMm7TJXQNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umzDICG7M6V5R4Q4G9+4VSVHFkTFmQmGPX61BZCb7umdo1Y90KSTO5HG0+BXAxpEzJB7vnUtPjW3mP3OnnfJVG9AMAaCydg2hLWzZQIWrzeyd9ZAqBCJ4s4FHgYdI5cQxa4dyTo6mc792iIieEhtjY1zT0jA1pv+Uk2+GFO24mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnXztOqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD790C4CEE2;
	Fri, 18 Apr 2025 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744998958;
	bh=VhKfdYgqpCKf6CE0wi4fGRaaQa8UVPPJjOMm7TJXQNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnXztOqKFg8aDX4jfxqGkqt9Her7PPKE2JJoG7CHKiK3LIeWyeE0+vCRy88If6pgP
	 WNAR/D1w+KaxrYiCshvb/B7DIuGNeYMlNgc72KT+2/CCwz9JOeclwRi45yph41jBVJ
	 XPqHzq2pfbkXYNP3NoMZ7WRcciFaKqIfNiclJUuH5AQP6ZKHvarX7WSZEsLA6rnFja
	 D8e/1hy4XqOX/+XHcqh5OHbQKlEN6iav7qFfDq3sd/4DUWeKYZOKC7PipEvsd5z+52
	 sj3gzD2+5x8P/Ew4/dJwW3Pqo3+8uPpiiaMtgmlHbJ8e9pf/UlW+3qFstxUD8Prvtn
	 VNvaD6pqMTixw==
Date: Fri, 18 Apr 2025 10:55:56 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: fix race between set_blocksize and read paths
Message-ID: <aAKSLGXX6ye3n032@bombadil.infradead.org>
References: <20250418155458.GR25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418155458.GR25675@frogsfrogsfrogs>

On Fri, Apr 18, 2025 at 08:54:58AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> With the new large sector size support, it's now the case that
> set_blocksize can change i_blksize and the folio order in a manner that
> conflicts with a concurrent reader and causes a kernel crash.
> 
> Specifically, let's say that udev-worker calls libblkid to detect the
> labels on a block device.  The read call can create an order-0 folio to
> read the first 4096 bytes from the disk.  But then udev is preempted.
> 
> Next, someone tries to mount an 8k-sectorsize filesystem from the same
> block device.  The filesystem calls set_blksize, which sets i_blksize to
> 8192 and the minimum folio order to 1.
> 
> Now udev resumes, still holding the order-0 folio it allocated.  It then
> tries to schedule a read bio and do_mpage_readahead tries to create
> bufferheads for the folio.  Unfortunately, blocks_per_folio == 0 because
> the page size is 4096 but the blocksize is 8192 so no bufferheads are
> attached and the bh walk never sets bdev.  We then submit the bio with a
> NULL block device and crash.
> 
> Therefore, truncate the page cache after flushing but before updating
> i_blksize.  However, that's not enough -- we also need to lock out file
> IO and page faults during the update.  Take both the i_rwsem and the
> invalidate_lock in exclusive mode for invalidations, and in shared mode
> for read/write operations.
> 
> I don't know if this is the correct fix, but xfs/259 found it.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

