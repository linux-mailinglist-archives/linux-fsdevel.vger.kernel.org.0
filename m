Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99576E9A14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 11:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJ3KiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 06:38:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2501 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfJ3KiH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:38:07 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 180FDFE20842B11A1B1F;
        Wed, 30 Oct 2019 18:38:05 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 18:38:04 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 30 Oct 2019 18:38:04 +0800
Date:   Wed, 30 Oct 2019 18:40:49 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ext4: bio_alloc never fails
Message-ID: <20191030104049.GA170703@architecture4>
References: <20191030042618.124220-1-gaoxiang25@huawei.com>
 <20191030101311.2175EA4055@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191030101311.2175EA4055@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritech,

On Wed, Oct 30, 2019 at 03:43:10PM +0530, Ritesh Harjani wrote:
> 
> 
> On 10/30/19 9:56 AM, Gao Xiang wrote:
> > Similar to [1] [2], it seems a trivial cleanup since
> > bio_alloc can handle memory allocation as mentioned in
> > fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)
> > 
> 
> AFAIU, the reason is that, bio_alloc with __GFP_DIRECT_RECLAIM
> flags guarantees bio allocation under some given restrictions,
> as stated in fs/direct-io.c
> So here it is ok to not check for NULL value from bio_alloc.
> 
> I think we can update above info too in your commit msg.

Ok, I will update commit msg as you suggested.

> 
> > [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> > [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> >   fs/ext4/page-io.c  | 11 +++--------
> >   fs/ext4/readpage.c |  2 --
> >   2 files changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> > index 12ceadef32c5..f1f7b6601780 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -358,14 +358,12 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
> >   	io->io_end = NULL;
> >   }
> > 
> > -static int io_submit_init_bio(struct ext4_io_submit *io,
> > -			      struct buffer_head *bh)
> > +static void io_submit_init_bio(struct ext4_io_submit *io,
> > +			       struct buffer_head *bh)
> >   {
> >   	struct bio *bio;
> > 
> >   	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
> > -	if (!bio)
> > -		return -ENOMEM;
> >   	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
> >   	bio_set_dev(bio, bh->b_bdev);
> >   	bio->bi_end_io = ext4_end_bio;
> > @@ -373,7 +371,6 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
> >   	io->io_bio = bio;
> >   	io->io_next_block = bh->b_blocknr;
> >   	wbc_init_bio(io->io_wbc, bio);
> > -	return 0;
> >   }
> > 
> >   static int io_submit_add_bh(struct ext4_io_submit *io,
> > @@ -388,9 +385,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
> >   		ext4_io_submit(io);
> >   	}
> >   	if (io->io_bio == NULL) {
> > -		ret = io_submit_init_bio(io, bh);
> > -		if (ret)
> > -			return ret;
> > +		io_submit_init_bio(io, bh);
> >   		io->io_bio->bi_write_hint = inode->i_write_hint;
> >   	}
> >   	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
> 
> 
> Also we can further simplify it like below. Please check.

Got it, let me update the patch later. :-)
Thanks for your suggestion. I will wait for a while and
see if other opinions raise up...

Thanks,
Gao Xiang

> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index f1f7b6601780..a3a2edeb3bbf 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -373,7 +373,7 @@ static void io_submit_init_bio(struct ext4_io_submit
> *io,
>  	wbc_init_bio(io->io_wbc, bio);
>  }
> 
> -static int io_submit_add_bh(struct ext4_io_submit *io,
> +static void io_submit_add_bh(struct ext4_io_submit *io,
>  			    struct inode *inode,
>  			    struct page *page,
>  			    struct buffer_head *bh)
> @@ -393,7 +393,6 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
>  		goto submit_and_retry;
>  	wbc_account_cgroup_owner(io->io_wbc, page, bh->b_size);
>  	io->io_next_block++;
> -	return 0;
>  }
> 
>  int ext4_bio_write_page(struct ext4_io_submit *io,
> @@ -495,30 +494,23 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  	do {
>  		if (!buffer_async_write(bh))
>  			continue;
> -		ret = io_submit_add_bh(io, inode, bounce_page ?: page, bh);
> -		if (ret) {
> -			/*
> -			 * We only get here on ENOMEM.  Not much else
> -			 * we can do but mark the page as dirty, and
> -			 * better luck next time.
> -			 */
> -			break;
> -		}
> +		io_submit_add_bh(io, inode, bounce_page ?: page, bh);
>  		nr_submitted++;
>  		clear_buffer_dirty(bh);
>  	} while ((bh = bh->b_this_page) != head);
> 
> -	/* Error stopped previous loop? Clean up buffers... */
> -	if (ret) {
> -	out:
> -		fscrypt_free_bounce_page(bounce_page);
> -		printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
> -		redirty_page_for_writepage(wbc, page);
> -		do {
> -			clear_buffer_async_write(bh);
> -			bh = bh->b_this_page;
> -		} while (bh != head);
> -	}
> +	goto unlock;
> +
> +out:
> +	fscrypt_free_bounce_page(bounce_page);
> +	printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
> +	redirty_page_for_writepage(wbc, page);
> +	do {
> +		clear_buffer_async_write(bh);
> +		bh = bh->b_this_page;
> +	} while (bh != head);
> +
> +unlock:
>  	unlock_page(page);
>  	/* Nothing submitted - we have to end page writeback */
>  	if (!nr_submitted)
> 
> 
> -ritesh
> 
