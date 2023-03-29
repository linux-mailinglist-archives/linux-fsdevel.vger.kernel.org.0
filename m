Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2D6CF166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC2Rsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC2Rsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:48:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A371A7;
        Wed, 29 Mar 2023 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iJ/vola4H8cgViEzEkBXlY8ssW/mXMKcLaixwmisg/8=; b=KzrLO9+ytx3PbWRmiLMufLNeIF
        uDOJXsmUYrUM1RWImI0Q6RZjfNc59DlaoUlO9FYruvV9zL6gp/6N8Ug10m9lq1fW6H4NVD/orTF3L
        UC22t2bbOh5slkLr32VRltg5atVlsd5nnPGmg+lSz88Pc2EuESTc5Z7LxUO9mbIq1l/uDb1uMyTLZ
        lLgUTqa4ZM52QW2KhPUgaxaIa9oitnfFZKC5nbMu3w+qsJg+Nhvy8Osq4w45CGu4TT3zT/bf/fRQy
        UoicfczStNRwCnW3SVVki5SWWM7i0XVCyJkhaCupv57+kOz/v7+3xTJlGG+mzQ2roOdv5F5YXJAQA
        /G6qJtWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phZu2-009drW-11; Wed, 29 Mar 2023 17:48:06 +0000
Date:   Wed, 29 Mar 2023 18:48:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/19] drbd: use __bio_add_page to add page to bio
Message-ID: <ZCR51cLkBH4yrYEy@casper.infradead.org>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0bf7d65cb7c64a0010524e5b39466f2b79870.1680108414.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:05:48AM -0700, Johannes Thumshirn wrote:
> +++ b/drivers/block/drbd/drbd_bitmap.c
> @@ -1043,9 +1043,11 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
>  	bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op, GFP_NOIO,
>  			&drbd_md_io_bio_set);
>  	bio->bi_iter.bi_sector = on_disk_sector;
> -	/* bio_add_page of a single page to an empty bio will always succeed,
> -	 * according to api.  Do we want to assert that? */
> -	bio_add_page(bio, page, len, 0);
> +	/*
> +	 * __bio_add_page of a single page to an empty bio will always succeed,
> +	 * according to api.  Do we want to assert that?
> +	 */
> +	__bio_add_page(bio, page, len, 0);

Surely the comment should just be deleted?  With no return value to
check, what would you assert?
