Return-Path: <linux-fsdevel+bounces-34955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794D9CF11E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE50293DCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98701D47C8;
	Fri, 15 Nov 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a66cA9r+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C671BF37;
	Fri, 15 Nov 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686999; cv=none; b=uDTqFM7lM/iGzEkmQNqWDfNHFZyg34hPSvIGf80WLgXyXLDSRRdWBMXDAKElXfCgmPdHBTBE46cJhpUoMnzSkJ9T00Vm0Cao4NiL6bBvyKVEuVMB0XhnsPipe8yJs+RkFoNjr7QfZBZ8ag4K4bWkygka2RdwFWzegBbMg6S/06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686999; c=relaxed/simple;
	bh=b8H7D7v3YTEvQVoc9zvXB3qD75FHPuozVprLDEYekOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJfHUx0d7tKnjhcj4DKOyrB9QU7D7FNMw6NpALNW4uGJkKsx2cHdMgalwstPBJYSTG6D7iGD7HliSLEbOx3ZYV588NFLxxFyvgRrOiqEEo0Wwbn4ZjN0hP/uhL+3MMT2z9nz3ScAYU6GbLQQXMfdPctkV4BKY00lWWPVH6K0H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a66cA9r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1493C4CECF;
	Fri, 15 Nov 2024 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731686998;
	bh=b8H7D7v3YTEvQVoc9zvXB3qD75FHPuozVprLDEYekOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a66cA9r+o3mG97B+OoGsawqRKANoiQUe4jK67CDT6x/TwYIyy6JO2mqH14zaJ6TD8
	 y6A9k4L2NphdmzqEjKsgF8Y/DOorRKSbsZuy+zsA4PcHwJRqsUhBapMn/qTOa/+EZ4
	 4BiY3mZWzyr3NieXmMjyJ8w+ZW+iLqoXb4/dSUV805V9PhnjjE4O5cEkRHT3HBbY8g
	 Nuv61rjqDUglej5x7QzOiMX2a4EwIyL2sVdYPowXGkwvspPaq6pduOip6VoiGJXR98
	 J2eK8GI5b9j6KpBXldmqACsviGaXgQrYon3sNp6izdLxvMu4DYDGSq2KlV1hnzPRv6
	 CfhcXmuIJflnw==
Date: Fri, 15 Nov 2024 08:09:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH v2] iomap: warn on zero range of a post-eof folio
Message-ID: <20241115160957.GP9438@frogsfrogsfrogs>
References: <20241115145931.535207-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115145931.535207-1-bfoster@redhat.com>

On Fri, Nov 15, 2024 at 09:59:31AM -0500, Brian Foster wrote:
> iomap_zero_range() uses buffered writes for manual zeroing, no
> longer updates i_size for such writes, but is still explicitly
> called for post-eof ranges. The historical use case for this is
> zeroing post-eof speculative preallocation on extending writes from
> XFS. However, XFS also recently changed to convert all post-eof
> delalloc mappings to unwritten in the iomap_begin() handler, which
> means it now never expects manual zeroing of post-eof mappings. In
> other words, all post-eof mappings should be reported as holes or
> unwritten.
> 
> This is a subtle dependency that can be hard to detect if violated
> because associated codepaths are likely to update i_size after folio
> locks are dropped, but before writeback happens to occur. For
> example, if XFS reverts back to some form of manual zeroing of
> post-eof blocks on write extension, writeback of those zeroed folios
> will now race with the presumed i_size update from the subsequent
> buffered write.
> 
> Since iomap_zero_range() can't correctly zero post-eof mappings
> beyond EOF without updating i_size, warn if this ever occurs. This
> serves as minimal indication that if this use case is reintroduced
> by a filesystem, iomap_zero_range() might need to reconsider i_size
> updates for write extending use cases.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks fine to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> 
> v2:
> - Dropped unnecessary local var.
> v1: https://lore.kernel.org/linux-fsdevel/20241108124246.198489-5-bfoster@redhat.com/
> 
>  fs/iomap/buffered-io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index af2f59817779..25fbb541032a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1369,6 +1369,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> +		/* warn about zeroing folios beyond eof that won't write back */
> +		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
>  		offset = offset_in_folio(folio, pos);
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
> -- 
> 2.47.0
> 
> 

