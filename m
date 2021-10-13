Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0762742B4CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 07:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbhJMFXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 01:23:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38088 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJMFXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:23:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E2BE1FF87;
        Wed, 13 Oct 2021 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634102493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILLm2pe17/wADifWsNez+bTJrwsc+lrviMwLK7kUvDI=;
        b=bvKId0oH3n+XWRAa8k+X7S4sSfCSq6r7k6wkqvducj0gvOulmoiit7vAXJt7/Fugc4ApBB
        +eyuMKl31qjAEJWuSCiR357fXwBwkLJzIMHJmLSrbkPgZIeBcwzOpezb3tR0358vd8V0Yu
        v4i5Ls9qoC9uBvhPFPVe6ERT85hRkzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634102493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILLm2pe17/wADifWsNez+bTJrwsc+lrviMwLK7kUvDI=;
        b=7QNd9vO2OGh2y9jVTVQKK6beKgduFwgxo0TkSLgWMuvnfJFmYXqVQMfqyW0QcEDOD1zLDp
        Em1u+x09Gi2O+KBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B800113CAE;
        Wed, 13 Oct 2021 05:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rI5FINRsZmEARAAAMHmgww
        (envelope-from <colyli@suse.de>); Wed, 13 Oct 2021 05:21:24 +0000
Subject: Re: [PATCH 01/29] bcache: remove bdev_sectors
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-2-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <cd1b2185-9682-1d97-9789-96f833007f62@suse.de>
Date:   Wed, 13 Oct 2021 13:21:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013051042.1065752-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/13/21 1:10 PM, Christoph Hellwig wrote:
> Use the equivalent block layer helper instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>   drivers/md/bcache/super.c     | 2 +-
>   drivers/md/bcache/util.h      | 4 ----
>   drivers/md/bcache/writeback.c | 2 +-
>   3 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index f2874c77ff797..4f89985abe4b7 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1002,7 +1002,7 @@ static void calc_cached_dev_sectors(struct cache_set *c)
>   	struct cached_dev *dc;
>   
>   	list_for_each_entry(dc, &c->cached_devs, list)
> -		sectors += bdev_sectors(dc->bdev);
> +		sectors += bdev_nr_sectors(dc->bdev);
>   
>   	c->cached_dev_sectors = sectors;
>   }
> diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
> index b64460a762677..a7da7930a7fda 100644
> --- a/drivers/md/bcache/util.h
> +++ b/drivers/md/bcache/util.h
> @@ -584,8 +584,4 @@ static inline unsigned int fract_exp_two(unsigned int x,
>   void bch_bio_map(struct bio *bio, void *base);
>   int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask);
>   
> -static inline sector_t bdev_sectors(struct block_device *bdev)
> -{
> -	return bdev->bd_inode->i_size >> 9;
> -}
>   #endif /* _BCACHE_UTIL_H */
> diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> index 8120da278161e..c7560f66dca88 100644
> --- a/drivers/md/bcache/writeback.c
> +++ b/drivers/md/bcache/writeback.c
> @@ -45,7 +45,7 @@ static uint64_t __calc_target_rate(struct cached_dev *dc)
>   	 * backing volume uses about 2% of the cache for dirty data.
>   	 */
>   	uint32_t bdev_share =
> -		div64_u64(bdev_sectors(dc->bdev) << WRITEBACK_SHARE_SHIFT,
> +		div64_u64(bdev_nr_sectors(dc->bdev) << WRITEBACK_SHARE_SHIFT,
>   				c->cached_dev_sectors);
>   
>   	uint64_t cache_dirty_target =

