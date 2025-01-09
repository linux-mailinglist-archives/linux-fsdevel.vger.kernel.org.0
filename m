Return-Path: <linux-fsdevel+bounces-38699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79DA06D31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 05:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409AC3A4840
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 04:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0921421D;
	Thu,  9 Jan 2025 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LniHAgOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA112F2F;
	Thu,  9 Jan 2025 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736397529; cv=none; b=uWJ4RT/zQ7Klc4eTxFRNoBGeeMouBozhZsbZ6TIVIfQDqR8zZ5gLtkWs522MfoNdXX6mYiE2G6RF3A5aPo9pRh06OaBB+qcie3/+R9SI10q2XTofywi/y9E15fqtsMvg56k5Vx5wZ8bAe0Ln+yEAqAevu2sdWiNpYy6Iu0C2QI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736397529; c=relaxed/simple;
	bh=K/Jxg4yV7XCaCxN0FheulNwWir26pybxv74i0hgL64A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX8ESAesRi9X/HQdRRTGvM39nkAv8MEr47akQzyk6EhxkgwzRm+vuIS3mG5mTVxtcSeMxi6DGi5zVlYz8f5YfjYcpKMc9JZ97EY3TddPY5x5MlD/kbVBOgHC3Z6LaKxhh6jWk0N8JClVbKdpbs7Y5nzWwXlFn0Q0+8cdeuwj4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LniHAgOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED1FC4CED2;
	Thu,  9 Jan 2025 04:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736397528;
	bh=K/Jxg4yV7XCaCxN0FheulNwWir26pybxv74i0hgL64A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LniHAgOlSwvamcHjkdHfgSCZaBXg3wG/FWh1TIyrj234C2bP3tG9B7Deq1y0OMUKx
	 rDyAlRe5riqVYfalHXturljo+42eVFFd58/dTxb9W1sw5AfT94neXzsFUcY/Qbr2g5
	 od/G2A1t3SqZEyZgrEjbmfQ6cMmxkt80md5Fst2lkDl/25C7y4AUWbAV13GupKVLNo
	 wokvCKg0zTSXPe3SLqUcnQoaoVleklOqjOm6qVaNi967T4IX199BV7NlmUpoAImNBX
	 87sJXi/ttGTlq9lAjcTXRZCWTl6N9nYqWhJuXARzWmvTqPZ3jv3ItLf7rt9qPbrRG3
	 Q1V55p2VkVzwg==
Date: Wed, 8 Jan 2025 20:38:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Marco Nelissen <marco.nelissen@gmail.com>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid avoid truncating 64-bit offset to 32 bits
Message-ID: <20250109043846.GJ1387004@frogsfrogsfrogs>
References: <20250109041253.2494374-1-marco.nelissen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109041253.2494374-1-marco.nelissen@gmail.com>

On Wed, Jan 08, 2025 at 08:11:50PM -0800, Marco Nelissen wrote:
> on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
> 32-bit position due to folio_next_index() returning an unsigned long.
> This could lead to an infinite loop when writing to an xfs filesystem.
> 
> Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 54dc27d92781..d303e6c8900c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
>  				start_byte, end_byte, iomap, punch);
>  
>  		/* move offset to start of next folio in range */
> -		start_byte = folio_next_index(folio) << PAGE_SHIFT;
> +		start_byte = folio_pos(folio) + folio_size(folio);

eeek.  Yeah, I guess that would happen towards the upper end of the 16T
range on 32-bit.

I wonder if perhaps pagemap.h should have:

static inline loff_t folio_next_pos(struct folio *folio)
{
	return folio_pos(folio) + folio_size(folio);
}

But I think this is the only place in the kernel that uses this
construction?  So maybe not worth the fuss.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		folio_unlock(folio);
>  		folio_put(folio);
>  	}
> -- 
> 2.39.5
> 

