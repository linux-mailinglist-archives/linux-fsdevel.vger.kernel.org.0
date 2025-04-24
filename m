Return-Path: <linux-fsdevel+bounces-47168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0571A9A202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A7617C6AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252E1F09A8;
	Thu, 24 Apr 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7Xl11bb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F431E7C2D;
	Thu, 24 Apr 2025 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475800; cv=none; b=UbeJN2naVVo7JzbttYUecE9+HsDxYIasiGVKqtTQRRsmDKzSP4huDmghHEPKdMrUHpSYjW65F7zcAdPu/VZ3TEAuNEtOmcfFEXe7kjAvynA18SQdLFHGUNZVIOU0FivMB35Srb/1OApu743v2PVimfPsCDHXhQUwRJPNcCnRFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475800; c=relaxed/simple;
	bh=oDXbbN9r4nxljwwOH1ddnJGF98ZHdTPR+YXVsFhGpoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUlsteghZT8sn87xPWQify0ly8h6Jan0OoGTVVgt3LdH/9Kty0dUiHBzAG/34TEqMtlYmWaEbOzI16Kx1XlTDOYS4eghrWu3m4LlN9u0T6ub3nXcs6Pb5xUF1A2Mg/9FYnG8pdmRNwdvgxaQtvCN1mXo+67YG8QhJ3GT9Bm5QjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7Xl11bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FABC4CEE3;
	Thu, 24 Apr 2025 06:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475796;
	bh=oDXbbN9r4nxljwwOH1ddnJGF98ZHdTPR+YXVsFhGpoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r7Xl11bbtF7jez/zKFtqf/IlHy5z4wHivb2vr4TcNw4sSdzhQLzygSlKpvTyEPTI+
	 9WT/UKTugKQWMuw0nRfP7jpy7N0/XxG/IHU5o58kugxePZqxReD4HqlAPFBn+HZqHM
	 /flM1HOfyyK9s4e/obdw62xcAyw7PEU2ddPyasJm5JVkGVekVR5htL40aUg9k4pRXH
	 JQ6vYr2vwyx4XYadLlOWHBH3b9+zUOeHP4uqgo2Ldt6sv4pMMx8vvoDSOBfIk9BGVU
	 Bols/8PSwquVMNa5dkIQXCMEgeB7CPnoGLg1XwxRL68rYLVEK282bkSw5LdcRW1rmk
	 WMgwPRk2uS9IA==
Message-ID: <11b02dfa-9f71-48ac-9d20-ba5a6e44f289@kernel.org>
Date: Thu, 24 Apr 2025 15:23:12 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] gfs2: use bdev_rw_virt in gfs2_read_super
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-16-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Switch gfs2_read_super to allocate the superblock buffer using kmalloc
> which falls back to the page allocator for PAGE_SIZE allocation but
> gives us a kernel virtual address and then use bdev_rw_virt to perform
> the synchronous read into it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below.

> ---
>  fs/gfs2/ops_fstype.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index e83d293c3614..7c1014ba7ac7 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -226,28 +226,22 @@ static void gfs2_sb_in(struct gfs2_sbd *sdp, const struct gfs2_sb *str)
>  
>  static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
>  {
> -	struct super_block *sb = sdp->sd_vfs;
> -	struct page *page;
> -	struct bio_vec bvec;
> -	struct bio bio;
> +	struct gfs2_sb *sb;
>  	int err;
>  
> -	page = alloc_page(GFP_KERNEL);
> -	if (unlikely(!page))
> +	sb = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (unlikely(!sb))
>  		return -ENOMEM;
> -
> -	bio_init(&bio, sb->s_bdev, &bvec, 1, REQ_OP_READ | REQ_META);
> -	bio.bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
> -	__bio_add_page(&bio, page, PAGE_SIZE, 0);
> -
> -	err = submit_bio_wait(&bio);
> +	err = bdev_rw_virt(sdp->sd_vfs->s_bdev,
> +			sector * (sdp->sd_vfs->s_blocksize >> 9), sb, PAGE_SIZE,

While at it, use SECTOR_SHIFT here ?

> +			REQ_OP_READ | REQ_META);
>  	if (err) {
>  		pr_warn("error %d reading superblock\n", err);
> -		__free_page(page);
> +		kfree(sb);
>  		return err;
>  	}
> -	gfs2_sb_in(sdp, page_address(page));
> -	__free_page(page);
> +	gfs2_sb_in(sdp, sb);
> +	kfree(sb);
>  	return gfs2_check_sb(sdp, silent);
>  }
>  


-- 
Damien Le Moal
Western Digital Research

