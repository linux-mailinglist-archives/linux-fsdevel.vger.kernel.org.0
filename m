Return-Path: <linux-fsdevel+bounces-65964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3ABC1745B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB4E3B5F68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230C36A615;
	Tue, 28 Oct 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UitXAtQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AC199931;
	Tue, 28 Oct 2025 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692633; cv=none; b=WU6b12kFAexuY48nH1qIteo0cvXUKFK2KSRi8CbjJASkoyk33OYG+CwgF44RApHesBESH5zUrSoZtS/6V9D/dLnP8NuuTGRmV2eUKkDsYpCHusbPoiIO35AZ8f9XhMnC6aUXpFLyUGtysy1sH8S+VYGF6dNBRzDjYlUK0kIxnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692633; c=relaxed/simple;
	bh=kgX4g6vUYkvgZSZP1fvrdIYXiC9PY9BfKX/VN+ui3hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4lOLDILYJzwC4Pg9pltD0VVzkex0PRfw6atNjQB5HrPAvtIeNVdt4W+CEWZjMsqKOxmvzsXfxOLrjvBYBla2APjb+Dtg298wE6fgNY/ef5g1SZhZFD+6fPaUDxSYc1y1izQyMK17iac250pPxmUvoqB910vYrYmXeuLNj+Ofs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UitXAtQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB94C4CEE7;
	Tue, 28 Oct 2025 23:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761692632;
	bh=kgX4g6vUYkvgZSZP1fvrdIYXiC9PY9BfKX/VN+ui3hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UitXAtQ+ZUQ9Pn9+px3V6NR+FRxoklye0tQSSoWExizr1U8ODSP0DqrADg8Va1IlL
	 sqwUgTk5ScjgGkrAMJfBhVcyVE3LhHbxB38slMtsnhRIzJmsiUu62coD4x/gcDOrYj
	 f3Anr7AzIRiNB1MYTe6eu4FNeQlnF9y3YMlBVhuMxaTmWvyCJmL9nbg7C7vRytPG0W
	 Im0kvOsKKLmzbjsMLhvnLjC1WJ6PBU5vpisfNj04Ebulit1ohS/PMm2PtfhXsJDaPi
	 7W9Wv411rpbjAHdXtGH+1k9xg7pPNl+qtaUxWwea+86zkNWU17NTnJpufsc+eInCsS
	 s68rycFoWURDA==
Date: Tue, 28 Oct 2025 23:03:50 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251028230350.GB1639650@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
 <aQFIGaA5M4kDrTlw@google.com>
 <20251028225648.GA1639650@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028225648.GA1639650@google.com>

On Tue, Oct 28, 2025 at 10:56:48PM +0000, Eric Biggers wrote:
> On Tue, Oct 28, 2025 at 10:47:53PM +0000, Carlos Llamas wrote:
> > Ok, I did a bit more digging. I'm using f2fs but the problem in this
> > case is the blk_crypto layer. The OP_READ request goes through
> > submit_bio() which then calls blk_crypto_bio_prep() and if the bio has
> > crypto context then it checks for bio_crypt_check_alignment().
> > 
> > This is where the LTP tests fails the alignment. However, the propagated
> > error goes through "bio->bi_status = BLK_STS_IOERR" which in bio_endio()
> > get translates to EIO due to blk_status_to_errno().
> > 
> > I've verified this restores the original behavior matching the LTP test,
> > so I'll write up a patch and send it a bit later.
> > 
> > diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> > index 1336cbf5e3bd..a417843e7e4a 100644
> > --- a/block/blk-crypto.c
> > +++ b/block/blk-crypto.c
> > @@ -293,7 +293,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> >  	}
> >  
> >  	if (!bio_crypt_check_alignment(bio)) {
> > -		bio->bi_status = BLK_STS_IOERR;
> > +		bio->bi_status = BLK_STS_INVAL;
> >  		goto fail;
> >  	}
> 
> That change looks fine, but I'm wondering how this case was reached in
> the first place.  Upper layers aren't supposed to be submitting
> misaligned bios like this.  For example, ext4 and f2fs require
> filesystem logical block size alignment for direct I/O on encrypted
> files.  They check for this early, before getting to the point of
> submitting a bio, and fall back to buffered I/O if needed.

I suppose it's this code in f2fs_should_use_dio():

	/*
	 * Direct I/O not aligned to the disk's logical_block_size will be
	 * attempted, but will fail with -EINVAL.
	 *
	 * f2fs additionally requires that direct I/O be aligned to the
	 * filesystem block size, which is often a stricter requirement.
	 * However, f2fs traditionally falls back to buffered I/O on requests
	 * that are logical_block_size-aligned but not fs-block aligned.
	 *
	 * The below logic implements this behavior.
	 */
	align = iocb->ki_pos | iov_iter_alignment(iter);
	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
		return false;

So it relies on the alignment check in iomap in the case where the
request is neither logical_block_size nor filesystem_block_size aligned.

f2fs_should_use_dio() probably should just handle that case explicitly.

But making __blk_crypto_bio_prep() use a better error code sounds good
too.

- Eric

