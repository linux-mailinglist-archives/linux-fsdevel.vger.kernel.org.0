Return-Path: <linux-fsdevel+bounces-65963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5DC1740E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 23:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B8750278F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FAF36A614;
	Tue, 28 Oct 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRYSQjsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201636A5F9;
	Tue, 28 Oct 2025 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692211; cv=none; b=i1biNvuN9LLoiwI73q3iTysnPhJZFQpDtWvQsazqspF4upv85Hyngn3MuiHqGA9XRZCZfKLPttHwC0CeFFjy77Wf1QWt6YOgEfpxW2NjTcwj4Ali8BqKiHvd0f69XZg4t6tHvYTnjLnu+JHZY7vxPcDcxVFe/XXgR8xn8040zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692211; c=relaxed/simple;
	bh=/F5kgoe5C5XU2F//VBFRUy18gOx341JGs3vxy9AYbPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4b5pgLufjAjO3uRRk43CVX2OttTb2qzjw+4UypV4i5vScFcT06/ajHpGLddhNYrxrPlDdayOeGR8bGCfTUBn3XNIpZbGI3Zcr8Ob9xRbpuKqVZYGKc/rwoufbp/tiD2eI67mPsb9Q55SgsMeMMKZfb18LADJV8G5id6lR8T1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRYSQjsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9377FC4CEFD;
	Tue, 28 Oct 2025 22:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761692211;
	bh=/F5kgoe5C5XU2F//VBFRUy18gOx341JGs3vxy9AYbPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRYSQjsx7QVzIWDfne23bgK9vxGdiscBffiW6mDzC6I49eARa0gZPku084Vf9jgjN
	 xlNhURyzIOZeL6g8gXYWbcHxl/fwziKjB7Lx/NnnXG6r2uK0utj3fErxDHm672L3bT
	 dMV2FkWyG7TJ3WfkcKAOLxLhtrWBDWdScirpL8kTEjeRpnSNklouPTFf52JWodD26s
	 4HjX/bNBLMZIKfQn0UWrbke6tUBW6Gre1kBM5yHGfwIW33Zx2P4Bz47Ct1vp9pvD6H
	 Ltc6WKl+Z7nA4cYibQ6Ysc0omfbtrjxhnSsSDvQEOJanzj3b+9WFvWHZL7+Z5q6GYd
	 CJL7VHP5kKuBg==
Date: Tue, 28 Oct 2025 22:56:48 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251028225648.GA1639650@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
 <aQFIGaA5M4kDrTlw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQFIGaA5M4kDrTlw@google.com>

On Tue, Oct 28, 2025 at 10:47:53PM +0000, Carlos Llamas wrote:
> Ok, I did a bit more digging. I'm using f2fs but the problem in this
> case is the blk_crypto layer. The OP_READ request goes through
> submit_bio() which then calls blk_crypto_bio_prep() and if the bio has
> crypto context then it checks for bio_crypt_check_alignment().
> 
> This is where the LTP tests fails the alignment. However, the propagated
> error goes through "bio->bi_status = BLK_STS_IOERR" which in bio_endio()
> get translates to EIO due to blk_status_to_errno().
> 
> I've verified this restores the original behavior matching the LTP test,
> so I'll write up a patch and send it a bit later.
> 
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 1336cbf5e3bd..a417843e7e4a 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -293,7 +293,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
>  	}
>  
>  	if (!bio_crypt_check_alignment(bio)) {
> -		bio->bi_status = BLK_STS_IOERR;
> +		bio->bi_status = BLK_STS_INVAL;
>  		goto fail;
>  	}

That change looks fine, but I'm wondering how this case was reached in
the first place.  Upper layers aren't supposed to be submitting
misaligned bios like this.  For example, ext4 and f2fs require
filesystem logical block size alignment for direct I/O on encrypted
files.  They check for this early, before getting to the point of
submitting a bio, and fall back to buffered I/O if needed.

- Eric

