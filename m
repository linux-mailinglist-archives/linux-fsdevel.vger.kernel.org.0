Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589D62FB16D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbhASG3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 01:29:20 -0500
Received: from verein.lst.de ([213.95.11.211]:50786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbhASG2g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:28:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C863B6736F; Tue, 19 Jan 2021 07:27:53 +0100 (CET)
Date:   Tue, 19 Jan 2021 07:27:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 01/37] block: introduce bio_init_fields() helper
Message-ID: <20210119062753.GA21413@lst.de>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com> <20210119050631.57073-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119050631.57073-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't think a helper just to initialize a few fields is very useful.
But there is something in this area I've wanted to do for a while:

> +static inline void bio_init_fields(struct bio *bio, struct block_device *bdev,
> +				   sector_t sect, void *priv,
> +				   bio_end_io_t *end_io,
> +				   unsigned short prio, unsigned short whint)
> +{
> +	bio_set_dev(bio, bdev);
> +	bio->bi_iter.bi_sector = sect;
> +	bio->bi_private = priv;
> +	bio->bi_end_io = end_io;
> +	bio->bi_ioprio = prio;
> +	bio->bi_write_hint = whint;

Ensuring that the device, sector and op are always initialized would
really helper some of the bio mapping helpers, so I'd rather
add a new

struct bio *bio_new(struct block_device *bdev, sector_t sector,
		unsigned int op, unsigned int max_bvecs, gfp_t gfp_mask)

helper, where max_bvecs is clamped to BIO_MAX_PAGES.

bi_private, bi_end_io, bi_ioprio and bi_write_hint on the other hand
are purely optional and can be easily set just by the users that care.
