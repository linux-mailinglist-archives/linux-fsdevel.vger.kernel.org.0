Return-Path: <linux-fsdevel+bounces-65553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD1C07829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25F9422FB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539D340293;
	Fri, 24 Oct 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8IPDrVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF18253954;
	Fri, 24 Oct 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325857; cv=none; b=mND3exUsqZWDrVZ6vt8aA6a1K++u0ZZasIy0bMtZBcOjF5Vnpim+4d7O4Z8yzzC0qrJ4ZCYKQzqDx8eFDmw6wsvrBK5jn2dB0BF2aWh5UfgJA4e2N1xbWONlT2g6vJ9kiCskvTU5Sf8rXQRz4vMz9JgmDXSAL1S+zEXXA/GLN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325857; c=relaxed/simple;
	bh=iEjOOLJ0dXWgQLfSaNu50Gnh2bsbo1K+G0/Cr26Du2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSH3kMIzskVYmWqrqB1B2IWWDYF4CCZZ8mYyPnvuv/LhCJ4jiffoKvMxc9GCupmkWFHkpLZKiOV+HPXmQdg5fEQI/6D3k+KGXHB0UETZ7FDwjRtamLVNkS18edc6RNFLFAMoeQ5ymlgaaNXXBwZVSbdCBjK0FlZ2hhnxEalv/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8IPDrVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13979C4CEF1;
	Fri, 24 Oct 2025 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325857;
	bh=iEjOOLJ0dXWgQLfSaNu50Gnh2bsbo1K+G0/Cr26Du2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8IPDrVNYiQa3GUAtiE47yFrWSSEVd+gQTz4uX2UJJZicC+qtu9fKU07HXxX/Ul/M
	 1uLQBt12x/1J7zx2E3Hj+FKvScMyVSCL6E9hUh9+P9+ifddZYf8nGfoGrVpghQWBCc
	 ycMPXACXh/Hn1S03m6zdG/wgLW6hlfY+8aC323pw9v+bkHj3ugWyMm982ZSeG7484B
	 lpN1A4ew6YkKlcPCxciQpsf8qPNGJeHd476xrjE9mXtcNQrRX7cqfDUCsT4exdc2dn
	 KatlOGavhISWUQePX5BT6m2rrnfHyth/mgkwyYYdZDmTxapT3BwYbh46BgrS0WHWX2
	 WmqyoeOGygQ1Q==
Date: Fri, 24 Oct 2025 10:10:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/10] iomap: Use folio_next_pos()
Message-ID: <20251024171056.GJ4015566@frogsfrogsfrogs>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-8-willy@infradead.org>

On Fri, Oct 24, 2025 at 06:08:15PM +0100, Matthew Wilcox (Oracle) wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Cc: linux-xfs@vger.kernel.org

Looks like a nice win, even if a small one
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8b847a1e27f1..32a27f36372d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -707,7 +707,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
>  	 * are not changing pagecache contents.
>  	 */
>  	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
> -	    pos + len >= folio_pos(folio) + folio_size(folio))
> +	    pos + len >= folio_next_pos(folio))
>  		return 0;
>  
>  	ifs = ifs_alloc(iter->inode, folio, iter->flags);
> @@ -1097,8 +1097,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  	if (!ifs)
>  		return;
>  
> -	last_byte = min_t(loff_t, end_byte - 1,
> -			folio_pos(folio) + folio_size(folio) - 1);
> +	last_byte = min_t(loff_t, end_byte - 1, folio_next_pos(folio) - 1);
>  	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>  	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
>  	for (i = first_blk; i <= last_blk; i++) {
> @@ -1129,8 +1128,7 @@ static void iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
>  	 * Make sure the next punch start is correctly bound to
>  	 * the end of this data range, not the end of the folio.
>  	 */
> -	*punch_start_byte = min_t(loff_t, end_byte,
> -				folio_pos(folio) + folio_size(folio));
> +	*punch_start_byte = min_t(loff_t, end_byte, folio_next_pos(folio));
>  }
>  
>  /*
> @@ -1170,7 +1168,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
>  				start_byte, end_byte, iomap, punch);
>  
>  		/* move offset to start of next folio in range */
> -		start_byte = folio_pos(folio) + folio_size(folio);
> +		start_byte = folio_next_pos(folio);
>  		folio_unlock(folio);
>  		folio_put(folio);
>  	}
> -- 
> 2.47.2
> 

