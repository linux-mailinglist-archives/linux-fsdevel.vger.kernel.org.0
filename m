Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B524304C68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbhAZWk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbhAZVvr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:51:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0E7A20449;
        Tue, 26 Jan 2021 21:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611697866;
        bh=uF4Zh493+gdGT/Bg0kWKqJydeGxsHWjFoA7xBs16rsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCGLIreDb/5Hwx8N2JmnAiiS0jiqRFkx5lWB+dYgajzTx5WDO2x1R1zbHYLyQO1UE
         98ScSw7v1shjHJr3DWN8DeVEKxjccGxz8l94yiaaEhvMgOjW92D6rHh7wIPb+Z8Wcf
         /WrH9o9CZLj9VLpBgdfMlPa9On6Ygs1IpZ1Ijf2DQsb5xhrrGFiJVmYaEU6R3mgkut
         QaKR1+XYY5LF7MORkDaq36e+R/ZWRbwey+gnJIfZYHPT0K+eh+0B9d6nRjRnNDd/S0
         dIZkNMAj/KUbyyLBEMzujKws37eYXRnxT13Nwk2S64RN7RIaBpTrze3+70kHOv4aD1
         nwTbNcB4SZj3w==
Date:   Tue, 26 Jan 2021 13:51:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        David Sterba <dsterba@suse.com>, dm-devel@redhat.com,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-nilfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chao Yu <chao@kernel.org>, linux-nfs@vger.kernel.org,
        Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org, drbd-dev@tron.linbit.com,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/17] blk-crypto: use bio_kmalloc in blk_crypto_clone_bio
Message-ID: <YBCOyBxDnSsT4jzU@sol.localdomain>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126145247.1964410-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 03:52:33PM +0100, Christoph Hellwig wrote:
> Use bio_kmalloc instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-crypto-fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 50c225398e4d60..e8327c50d7c9f4 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -164,7 +164,7 @@ static struct bio *blk_crypto_clone_bio(struct bio *bio_src)
>  	struct bio_vec bv;
>  	struct bio *bio;
>  
> -	bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src), NULL);
> +	bio = bio_kmalloc(GFP_NOIO, bio_segments(bio_src));
>  	if (!bio)
>  		return NULL;
>  	bio->bi_bdev		= bio_src->bi_bdev;
> -- 

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>
