Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574975A832
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 09:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjGTHu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGTHu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:50:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BB12128;
        Thu, 20 Jul 2023 00:50:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C7756732D; Thu, 20 Jul 2023 09:50:50 +0200 (CEST)
Date:   Thu, 20 Jul 2023 09:50:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230720075050.GB5042@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com> <20230627183629.26571-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-4-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
> +		gfp_t gfp_mask)
> +{
> +	int min_size = PAGE_SIZE;
> +	void *buf;
> +
> +	while (req_size >= min_size) {
> +		buf = kvmalloc(req_size, gfp_mask);
> +		if (buf) {
> +			*alloc_size = req_size;
> +			return buf;
> +		}
> +		/* retry half the requested size */
> +		req_size >>= 1;
> +	}
> +
> +	return NULL;

Is there any good reason for using vmalloc instead of a bunch
of distcontiguous pages?

> +		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +		if (!ctx)
> +			goto err_ctx;

I'd suspect it would be better to just allocte a single buffer and
only have a single outstanding copy.  That will reduce the bandwith
you can theoretically get, but copies tend to be background operations
anyway.  It will reduce the required memory, and thus the chance for
this operation to fail on a loaded system.  It will also dramatically
reduce the effect on memory managment.

> +		read_bio = bio_map_kern(in, buf, buf_len, gfp_mask);
> +		if (IS_ERR(read_bio))
> +			goto err_read_bio;
> +
> +		write_bio = bio_map_kern(out, buf, buf_len, gfp_mask);
> +		if (IS_ERR(write_bio))
> +			goto err_write_bio;

bio_map_kern is only for passthrough I/Os.  You need to use
a bio_add_page loop here.

> index 336146798e56..f8c80940c7ad 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -562,4 +562,9 @@ struct cio {
>  	atomic_t refcount;
>  };
>  
> +struct copy_ctx {
> +	struct cio *cio;
> +	struct work_struct dispatch_work;
> +	struct bio *write_bio;
> +};

This is misnamed as it's only used by the fallback code, and also
should be private to blk-lib.c.

