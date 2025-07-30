Return-Path: <linux-fsdevel+bounces-56347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DEEB1635E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 17:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DABF3AE1EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6862DCF40;
	Wed, 30 Jul 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVWkZert"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472D1AF0A7;
	Wed, 30 Jul 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888138; cv=none; b=HkJVLZ9nLQz2/VbmT7fjYXMwrw7TZcIwG7j9R7TRtvaRCVn4xswHkiP3LVCdEcdfJ2yAoNmX+YYQmCr06boCAU6egHFpvvKRM51DwK7s+ooviBLtfJw8X0nJEGaxFyGG833KyAzVxM6nI7o7Rcy0gX/kKSPmYZ84HAjG6XTgPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888138; c=relaxed/simple;
	bh=8kc0GHFmnKScUmlaZFHc1wSECZCEG/E0Fpx0q2QM6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp9G8eBxGOOdTr7xpseIpSb6GTxcSuqR2zH6jNayoMrYlOnBE9q7wgKoooqt50o6iNKJX2mDRofvtDGrdiTAvTggoenFjX0zHok2OkzO8oW86WQXeoJ5slLV853tdnxilTHxLRrc5FqmBL5qZnZmqyndhOErpD9IJ+m45hvUbR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVWkZert; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE41DC4CEE3;
	Wed, 30 Jul 2025 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753888138;
	bh=8kc0GHFmnKScUmlaZFHc1wSECZCEG/E0Fpx0q2QM6nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVWkZert7EapaTfwkDgMyjTlI8rpYSXJdOw2iURI620cDmsedlZl6EJ3nvBaTDr/L
	 6Z+IhLmNaemZ/fm3QD5ivITY/B7mNDKtadGn8JPwPPFMpzgMT1NDSe0jbxZWqImS9W
	 Vg/UJJT5pGca8gkQ1P8G7Mdx0dXiHM4WKwMLeKf8Ylgrj14WLSG3LIk2OycqJLK3BJ
	 PDB6/ozbl2Cd08AXoKZrF7mX9l/McNHLK6hjvQ6WOnF5RZVN3goyYH7necbqDLqISR
	 QyzUYN+Y0hg/7U3Sup9GS0B3SSleiB5B4DN9vlDaheZ+X34GOJ/WDweUEadJQzqKxj
	 4GloNKGM/icGQ==
Date: Wed, 30 Jul 2025 08:08:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix broken data integrity guarantees for O_SYNC
 writes
Message-ID: <20250730150857.GX2672029@frogsfrogsfrogs>
References: <20250730102840.20470-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730102840.20470-2-jack@suse.cz>

On Wed, Jul 30, 2025 at 12:28:41PM +0200, Jan Kara wrote:
> Commit d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()") has broken
> the logic in iomap_dio_bio_iter() in a way that when the device does
> support FUA (or has no writeback cache) and the direct IO happens to
> freshly allocated or unwritten extents, we will *not* issue fsync after
> completing direct IO O_SYNC / O_DSYNC write because the
> IOMAP_DIO_WRITE_THROUGH flag stays mistakenly set. Fix the problem by
> clearing IOMAP_DIO_WRITE_THROUGH whenever we do not perform FUA write as
> it was originally intended.
> 
> CC: John Garry <john.g.garry@oracle.com>
> CC: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Fixes: d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Aha, I wonder if that's why fuse2fs+iomap occasionally fails the fstest
that tries to replay all the FUA writes, finds none, and complains.

(and I bet nobody noticed this on xfs because the log sends FUA, whereas
fuse2fs merely sends fsync to the block device)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> BTW, I've spotted this because some performance tests got suspiciously fast
> on recent kernels :) Sadly no easy improvement to cherry-pick for me to fix
> customer issue I'm chasing...
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6f25d4cfea9f..b84f6af2eb4c 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -363,14 +363,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		if (iomap->flags & IOMAP_F_SHARED)
>  			dio->flags |= IOMAP_DIO_COW;
>  
> -		if (iomap->flags & IOMAP_F_NEW) {
> +		if (iomap->flags & IOMAP_F_NEW)
>  			need_zeroout = true;
> -		} else if (iomap->type == IOMAP_MAPPED) {
> -			if (iomap_dio_can_use_fua(iomap, dio))
> -				bio_opf |= REQ_FUA;
> -			else
> -				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
> -		}
> +		else if (iomap->type == IOMAP_MAPPED &&
> +			 iomap_dio_can_use_fua(iomap, dio))
> +			bio_opf |= REQ_FUA;
> +
> +		if (!(bio_opf & REQ_FUA))
> +			dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
>  
>  		/*
>  		 * We can only do deferred completion for pure overwrites that
> -- 
> 2.43.0
> 
> 

