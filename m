Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE76E4F49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 19:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjDQRek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDQRe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BD268A
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681752829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jm85SSVaopQAxnU3x7Lrot1DU+GlbD9SOLxgFW9cj5k=;
        b=LllccCU3Ep0cOJWzD9G/0qtct0Lc15QTRzSXIO+Y2bpaxpuEsIZnxmPkOeQDus+q8EOsxT
        GtH9NzcBf7W+voGtm5KWKZnVxDKrOcqqgnEkd55jmG6FV6KYVf3xeE44q8sIXCaD4gMckl
        DyB2JHyIxZGOJzzhyAtb+tp2sQD1f7Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-QsWFr22qPoeoWa61-6tTDw-1; Mon, 17 Apr 2023 13:33:45 -0400
X-MC-Unique: QsWFr22qPoeoWa61-6tTDw-1
Received: by mail-qv1-f72.google.com with SMTP id p11-20020a0cf68b000000b005ef7012cff3so1610530qvn.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 10:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681752824; x=1684344824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm85SSVaopQAxnU3x7Lrot1DU+GlbD9SOLxgFW9cj5k=;
        b=PYC5brfouu5BtWgvW5ymtnlyEFcKOdF2Rpyo9zgJP6ZBzqNqVWFCN3gFWvoD28jK1S
         ISbCyMm5UGw2JFVF1plbYxrX/esqjnmAH1nzmo+WwCbt1Z2fbz5QROOu1WAIYjQnKfnA
         yPrW/d6eIOMxc3MReqMUMNbPNFCYJfCTLCZI7SH450SRo2YTtrQ4Wabe3m4suWW4wNuv
         lNgfNSygMmp5xj+d/lMGeH5Q/0u05aizklyZR5O+QiP0dggL/tmRA/osIGM8MWBsknmO
         5IFo0KQ9wf/BVSRCJt7rcs23kg7cVHFbxvVipK5zfiOAI1Pu7FuLYwhiep//LMoD2esK
         knKQ==
X-Gm-Message-State: AAQBX9cSoMpX+oy7wbiAOhoXyDEbRjrQebEB1DtS4x/7kZ+w+VxGywzS
        6sAk/FpljwN9Do2o7IAke1R/aCCCt87aisr9WsejlYq9wlkLMDcK1qLdbw/gdokaLRPFkNT7Nbg
        KzW4wHrDqgKBYwN14AcpP3m+LprWOiXFRSWvN
X-Received: by 2002:a05:622a:1746:b0:3ec:e29f:6f4f with SMTP id l6-20020a05622a174600b003ece29f6f4fmr13735683qtk.33.1681752824527;
        Mon, 17 Apr 2023 10:33:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZygDANXtkSDESQaT+/nlutXw5EifsNXMDbt5vvWnxrF6WrCl5NaVCG+oOnpCy/E82arPOA9Q==
X-Received: by 2002:a05:622a:1746:b0:3ec:e29f:6f4f with SMTP id l6-20020a05622a174600b003ece29f6f4fmr13735633qtk.33.1681752824192;
        Mon, 17 Apr 2023 10:33:44 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id p24-20020a05620a22f800b0074a2467f541sm3337263qki.35.2023.04.17.10.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:33:43 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:35:46 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 1/3] block: Introduce provisioning primitives
Message-ID: <ZD2DcvyHdNmkdwr1@bfoster>
References: <20221229071647.437095-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230414000219.92640-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414000219.92640-2-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 05:02:17PM -0700, Sarthak Kukreti wrote:
> Introduce block request REQ_OP_PROVISION. The intent of this request
> is to request underlying storage to preallocate disk space for the given
> block range. Block devices that support this capability will export
> a provision limit within their request queues.
> 
> This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/blk-core.c          |  5 ++++
>  block/blk-lib.c           | 53 +++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         | 18 +++++++++++++
>  block/blk-settings.c      | 19 ++++++++++++++
>  block/blk-sysfs.c         |  8 ++++++
>  block/bounce.c            |  1 +
>  block/fops.c              | 14 ++++++++---
>  include/linux/bio.h       |  6 +++--
>  include/linux/blk_types.h |  5 +++-
>  include/linux/blkdev.h    | 16 ++++++++++++
>  10 files changed, 138 insertions(+), 7 deletions(-)
> 
...
> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c..f82da2fb8af0 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -625,7 +625,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	int error;
>  
>  	/* Fail if we don't recognize the flags. */
> -	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> +	if (mode != 0 && mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
>  		return -EOPNOTSUPP;
>  
>  	/* Don't go off the end of the device. */
> @@ -649,11 +649,17 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	filemap_invalidate_lock(inode->i_mapping);
>  
>  	/* Invalidate the page cache, including dirty pages. */
> -	error = truncate_bdev_range(bdev, file->f_mode, start, end);
> -	if (error)
> -		goto fail;
> +	if (mode != 0) {
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> +		if (error)
> +			goto fail;
> +	}
>  
>  	switch (mode) {
> +	case 0:
> +		error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> +					       len >> SECTOR_SHIFT, GFP_KERNEL);
> +		break;

I would think we'd want to support any combination of
FALLOC_FL_KEEP_SIZE and FALLOC_FL_UNSHARE_RANGE..? All of the other
commands support the former modifier, for one. It also looks like if
somebody attempts to invoke with mode == FALLOC_FL_KEEP_SIZE, even with
the current upstream code that would perform the bdev truncate before
returning -EOPNOTSUPP. That seems like a bit of an unfortunate side
effect to me.

WRT to unshare, if the PROVISION request is always going to imply an
unshare (which seems reasonable to me), there's probably no reason to
-EOPNOTSUPP if a caller explicitly passes UNSHARE_RANGE.

Brian

>  	case FALLOC_FL_ZERO_RANGE:
>  	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
>  		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index d766be7152e1..9820b3b039f2 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -57,7 +57,8 @@ static inline bool bio_has_data(struct bio *bio)
>  	    bio->bi_iter.bi_size &&
>  	    bio_op(bio) != REQ_OP_DISCARD &&
>  	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
> +	    bio_op(bio) != REQ_OP_PROVISION)
>  		return true;
>  
>  	return false;
> @@ -67,7 +68,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
>  {
>  	return bio_op(bio) == REQ_OP_DISCARD ||
>  	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
> -	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
> +	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
> +	       bio_op(bio) == REQ_OP_PROVISION;
>  }
>  
>  static inline void *bio_data(struct bio *bio)
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 99be590f952f..27bdf88f541c 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -385,7 +385,10 @@ enum req_op {
>  	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
>  	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
>  
> -	REQ_OP_LAST		= (__force blk_opf_t)36,
> +	/* request device to provision block */
> +	REQ_OP_PROVISION        = (__force blk_opf_t)37,
> +
> +	REQ_OP_LAST		= (__force blk_opf_t)38,
>  };
>  
>  enum req_flag_bits {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 941304f17492..239e2f418b6e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -303,6 +303,7 @@ struct queue_limits {
>  	unsigned int		discard_granularity;
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
> +	unsigned int		max_provision_sectors;
>  
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
> @@ -921,6 +922,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors);
>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>  		unsigned int max_write_same_sectors);
> +extern void blk_queue_max_provision_sectors(struct request_queue *q,
> +		unsigned int max_provision_sectors);
>  extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
>  extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
>  		unsigned int max_zone_append_sectors);
> @@ -1060,6 +1063,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp);
>  
> +extern int blkdev_issue_provision(struct block_device *bdev, sector_t sector,
> +		sector_t nr_sects, gfp_t gfp_mask);
> +
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
>  
> @@ -1139,6 +1145,11 @@ static inline unsigned short queue_max_discard_segments(const struct request_que
>  	return q->limits.max_discard_segments;
>  }
>  
> +static inline unsigned short queue_max_provision_sectors(const struct request_queue *q)
> +{
> +	return q->limits.max_provision_sectors;
> +}
> +
>  static inline unsigned int queue_max_segment_size(const struct request_queue *q)
>  {
>  	return q->limits.max_segment_size;
> @@ -1281,6 +1292,11 @@ static inline bool bdev_nowait(struct block_device *bdev)
>  	return test_bit(QUEUE_FLAG_NOWAIT, &bdev_get_queue(bdev)->queue_flags);
>  }
>  
> +static inline unsigned int bdev_max_provision_sectors(struct block_device *bdev)
> +{
> +	return bdev_get_queue(bdev)->limits.max_provision_sectors;
> +}
> +
>  static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  {
>  	return blk_queue_zoned_model(bdev_get_queue(bdev));
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

