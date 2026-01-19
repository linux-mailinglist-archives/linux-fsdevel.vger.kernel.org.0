Return-Path: <linux-fsdevel+bounces-74509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A953ED3B4A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BA1D3075B74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1C32E686;
	Mon, 19 Jan 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ9MEf6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F932C937;
	Mon, 19 Jan 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844459; cv=none; b=ET0yCPCdzfJ0HH/Spmja3N+jtGn+Jo4N8kcxLz9KZJHJ9SsB+eco2gowvnbaiBHeGisBnJiXRmOcjK1A8MdDSN2GPaw4P5di2OiwgXtTu6+/8ANzhvU0kir2NRzWegCANIk52tu6XlFiavZT57JGpMdNRsxkHjFAHJkFXkaknxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844459; c=relaxed/simple;
	bh=BS+NKcICrRrnj0S+OS2EH3so28h66QIWlb5Nmti/+88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVxfjhz9KKEwxhI/bsMCh1fNBVXiu9vrqWqb2brmdJvQ3D/TY/bZXb0dEpu2ndhOvwjNTqY1CSLGfjGnD0dS1ob5bwtwUhMNU1Rbf8dXHX2r6e2FSfvhjozhnK49Xmxmsi5+Y3j4FokVQZdG3KRLMNmUOCiwWqBha17Jv3i9RLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ9MEf6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E37EC116C6;
	Mon, 19 Jan 2026 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768844459;
	bh=BS+NKcICrRrnj0S+OS2EH3so28h66QIWlb5Nmti/+88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ9MEf6EC7SdoQr3VcPmfkO0Z6hRk1nusvyU3v2cz215vVaeS9Bpqli5ccYJKTfeB
	 XDoZcAYcuJHGTC3sv4CV2d2AHtTIVAOuO70WXVq7LyXhnsd4/1QL0hDisnq2OLAEed
	 emE573K87qRiSuoEEmlM0k2PzqqkRXvE1WYzXhK7mfdM1QBPNbgOuCHL8ivWc4hHe1
	 1Z49+AN09VGKNSNxUlx1sfHj+Vvp75Dvzvbbp4wLAQEuLI7eWDdpZ1DSCob0YkBZCp
	 qXnMXNZ3EL50xfSrij85HStN7mmtiMkqjdbq6crHL3+cPDyGlUBmfVg+DDOTUAl2Xe
	 mJq38OFTCQHgw==
Date: Mon, 19 Jan 2026 09:40:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/14] iomap: fix submission side handling of completion
 side errors
Message-ID: <20260119174058.GA15551@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119074425.4005867-7-hch@lst.de>

On Mon, Jan 19, 2026 at 08:44:13AM +0100, Christoph Hellwig wrote:
> The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
> more bios when a completion already return an error.  Commit cfe057f7db1f
> ("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
> "copied", which is very wrong given that we've already consumed that
> range and submitted a bio for it.
> 
> Fixes: cfe057f7db1f ("iomap_dio_actor(): fix iov_iter bugs")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for answering my question last time around,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4000c8596d9b..867c0ac6df8f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -443,9 +443,13 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
>  	do {
>  		size_t n;
> -		if (dio->error) {
> -			iov_iter_revert(dio->submit.iter, copied);
> -			copied = ret = 0;
> +
> +		/*
> +		 * If completions already occurred and reported errors, give up now and
> +		 * don't bother submitting more bios.
> +		 */
> +		if (unlikely(data_race(dio->error))) {
> +			ret = 0;
>  			goto out;
>  		}
>  
> -- 
> 2.47.3
> 
> 

