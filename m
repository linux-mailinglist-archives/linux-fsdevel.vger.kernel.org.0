Return-Path: <linux-fsdevel+bounces-51046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AFFAD2360
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B95189113D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9CA218585;
	Mon,  9 Jun 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOfCOSlu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FF20A5F1;
	Mon,  9 Jun 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485269; cv=none; b=Z1/8S03DooOejd899sRf/F380+O4iQ2IpV9h+2Ra42HVLuWrnI0MABrYeTLNsur8lSetUo9alynOa3bCY7Q72nCgm4Cbt2ir+37awwtsXVdqs50cVsZgNlzF+HWdisFhnOwJPTeFR63ykfnf/0CURwFe7EYso7aR0i3CQoVkiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485269; c=relaxed/simple;
	bh=ilnLvA0T6+iOwyYESqgjEj/JxpmDoP0F1PvGEw+kUQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehs2eeJPD88O4go8XrcRXU49l6tsMNJgsL8XljPNw0u/kS0zAk/Np3zav/ha1f4AdlHdTC/I6s+4DLVCqtT2R6MLlW/XQ8+Uen4LW/M8I3MQdoO+C9VmvvNITMdhNyvqmUcfM6UensVQ/SCiLN3lLaSavqWwtAF4QGlJIN1eMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOfCOSlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DA9C4CEEF;
	Mon,  9 Jun 2025 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485269;
	bh=ilnLvA0T6+iOwyYESqgjEj/JxpmDoP0F1PvGEw+kUQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOfCOSluUYlPvqxkecU8Q1/F2Cj+xZlcUaW5Ggv5lzcaDKQe00lUhH03L9cjBXluV
	 uZGlFAbgJtFk3D7fILnw8dxOjmsxs9OiEg8urub114GafROib4vOfeD398x9m5+ZNi
	 y3k62uBpUY4WJUdliJGjvWGViOqkN1UPW+80hrppOagUcL9R5U0VwFG7oa/XumVAcr
	 QHCXl8+WbWMspVa/qX7bUb061R2KdRNZdYcPCRun3bthHfRBq19jmO9XbNV8IOE5p9
	 oGuEngdNhIHBVpogacVHYH3mtKjPfbE5H9Ov/zvBpp0YoHlihXodIhaZhpYp9sr9vN
	 hQOCf/n6nuMLw==
Date: Mon, 9 Jun 2025 09:07:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 4/7] xfs: always trim mapping to requested range for zero
 range
Message-ID: <20250609160748.GD6156@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-5-bfoster@redhat.com>

On Thu, Jun 05, 2025 at 01:33:54PM -0400, Brian Foster wrote:
> Refactor and tweak the IOMAP_ZERO logic in preparation to support
> filling the folio batch for unwritten mappings. Drop the superfluous
> imap offset check since the hole case has already been filtered out.
> Split the the delalloc case handling into a sub-branch, and always
> trim the imap to the requested offset/count so it can be more easily
> used to bound the range to lookup in pagecache.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yeah, makes sense to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index ff05e6b1b0bb..b5cf5bc6308d 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1756,21 +1756,20 @@ xfs_buffered_write_iomap_begin(
>  	}
>  
>  	/*
> -	 * For zeroing, trim a delalloc extent that extends beyond the EOF
> -	 * block.  If it starts beyond the EOF block, convert it to an
> +	 * For zeroing, trim extents that extend beyond the EOF block. If a
> +	 * delalloc extent starts beyond the EOF block, convert it to an
>  	 * unwritten extent.
>  	 */
> -	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
> -	    isnullstartblock(imap.br_startblock)) {
> +	if (flags & IOMAP_ZERO) {
>  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
>  
> -		if (offset_fsb >= eof_fsb)
> +		if (isnullstartblock(imap.br_startblock) &&
> +		    offset_fsb >= eof_fsb)
>  			goto convert_delay;
> -		if (end_fsb > eof_fsb) {
> +		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
>  			end_fsb = eof_fsb;
> -			xfs_trim_extent(&imap, offset_fsb,
> -					end_fsb - offset_fsb);
> -		}
> +
> +		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
>  	}
>  
>  	/*
> -- 
> 2.49.0
> 
> 

