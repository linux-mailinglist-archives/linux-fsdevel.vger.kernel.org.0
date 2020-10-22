Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C12967AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373432AbgJVXkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 19:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373402AbgJVXkO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 19:40:14 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB9924631;
        Thu, 22 Oct 2020 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603410013;
        bh=lH4bMrjkVAVlYOh5q1ONShh5MSaDk59ICohHCc0M7t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uz+8OYcd/BhE2Xo8yZZb5GVG3dmq9yIEXUV95/lMVIXyrBDAsZ8EZ6r4LUxd43z1
         LL19rB6JEGjdc5fwe4Yz2Vx36ZxPpbBP0m55+VA9OTa1R2TiR+zZ9RQhiorf5EalzB
         0sPs7S2Uhpz7JXGIA/O3k2lWUzZa5uG89oAJwlKs=
Date:   Thu, 22 Oct 2020 16:40:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 3/6] fs: Convert block_read_full_page to be synchronous
Message-ID: <20201022234011.GD3613750@gmail.com>
References: <20201022212228.15703-1-willy@infradead.org>
 <20201022212228.15703-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022212228.15703-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 10:22:25PM +0100, Matthew Wilcox (Oracle) wrote:
> +static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
> +		unsigned int nr, struct buffer_head **bhs)
> +{
> +	struct bio *bio = NULL;
> +	unsigned int i;
> +	int err;
> +
> +	blk_completion_init(cmpl, nr);
> +
> +	for (i = 0; i < nr; i++) {
> +		struct buffer_head *bh = bhs[i];
> +		sector_t sector = bh->b_blocknr * (bh->b_size >> 9);
> +		bool same_page;
> +
> +		if (buffer_uptodate(bh)) {
> +			end_buffer_async_read(bh, 1);
> +			blk_completion_sub(cmpl, BLK_STS_OK, 1);
> +			continue;
> +		}
> +		if (bio) {
> +			if (bio_end_sector(bio) == sector &&
> +			    __bio_try_merge_page(bio, bh->b_page, bh->b_size,
> +					bh_offset(bh), &same_page))
> +				continue;
> +			submit_bio(bio);
> +		}
> +		bio = bio_alloc(GFP_NOIO, 1);
> +		bio_set_dev(bio, bh->b_bdev);
> +		bio->bi_iter.bi_sector = sector;
> +		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
> +		bio->bi_end_io = readpage_end_bio;
> +		bio->bi_private = cmpl;
> +		/* Take care of bh's that straddle the end of the device */
> +		guard_bio_eod(bio);
> +	}

The following is needed to set the bio encryption context for the
'-o inlinecrypt' case on ext4:

diff --git a/fs/buffer.c b/fs/buffer.c
index 95c338e2b99c..546a08c5003b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2237,6 +2237,7 @@ static int readpage_submit_bhs(struct page *page, struct blk_completion *cmpl,
 			submit_bio(bio);
 		}
 		bio = bio_alloc(GFP_NOIO, 1);
+		fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 		bio_set_dev(bio, bh->b_bdev);
 		bio->bi_iter.bi_sector = sector;
 		bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
