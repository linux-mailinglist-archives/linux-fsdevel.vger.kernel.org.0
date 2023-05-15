Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65856702CEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbjEOMla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 08:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEOMkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 08:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE210E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684154265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GMaiL4YHC7uUUhHJ2ubX8SKdgheUKgR6Z34QRTwNRu8=;
        b=Jz3uav0+Kn4KWQ/CplznHBFvSvPduWefmHAwiDC42jrkKis4wgCSusdAEbRzP/Y9IZvGn+
        dxWvSrURZkq3PMSpNNUqpEpikjHx0SKoPGY/QzwOHrETYk9BOYhsdYpdtYolsNGNnqATgc
        UW+ve9SAj2xbDJIfxi0dY8w++YZh+sc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-f7JmLzVBPoqwHb0AOr58dw-1; Mon, 15 May 2023 08:37:43 -0400
X-MC-Unique: f7JmLzVBPoqwHb0AOr58dw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b5af37298so70286286d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 05:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684154262; x=1686746262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMaiL4YHC7uUUhHJ2ubX8SKdgheUKgR6Z34QRTwNRu8=;
        b=gfwVXI1Q6zUkKLnuDJNx6OrfC+CQox4IQph/s1aaMHWw9aTusTCYSROwOSuYqa4A3X
         65Gtj4UrSYnDzCCodyQbk/4GoOtb1a2jZ/oBCeopSCzdRdTOKdbJAGFRXtDUa4h2t4Cd
         1OJEN8N5HWD/QP2P3RtD+hsMH5tduDFTgvJdz5dIOSdyR7gvG+g4eH+ylN32zFpzIC0Q
         4my5aVrPWtn/ot4L6FfCyeX0Q2rD04QGKGvHedSA2MrYpx3B2W2kM8qg6N/EOgfu7mtI
         4yzFDiIU6lIEuChkvH4uVcnHaz8/sMw+SwoylzBdNZi5FrkyfHFGviUriZNmZG1I6Yql
         xxmQ==
X-Gm-Message-State: AC+VfDxAm0nlQxmalxqXVzMHLLjcZIo/yIo8gg0gSpKe6lyRo713d8qB
        JTU5F3nng93sUL19pR4FiSfLp7MaOmKsAQ3mdt7WlkZTG6fXV8yCOsf9SX4H6wFYlenXAx9TvWR
        Ym+1p1OGi8MOy95HTllepsUhlQQ==
X-Received: by 2002:a05:6214:5007:b0:61b:743c:34f6 with SMTP id jo7-20020a056214500700b0061b743c34f6mr60348764qvb.30.1684154262697;
        Mon, 15 May 2023 05:37:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4f8e8bF39OseS5tHDGrQC563VXoeZlOAQEHKuj4FHMfFjvY/smfMQU9ypBiwBc9fk5VyO5gw==
X-Received: by 2002:a05:6214:5007:b0:61b:743c:34f6 with SMTP id jo7-20020a056214500700b0061b743c34f6mr60348721qvb.30.1684154262451;
        Mon, 15 May 2023 05:37:42 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id mm9-20020a0562145e8900b0062138a50d42sm4586271qvb.1.2023.05.15.05.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:37:41 -0700 (PDT)
Date:   Mon, 15 May 2023 08:40:10 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v6 5/5] loop: Add support for provision requests
Message-ID: <ZGIoKi7d5bKcMWw4@bfoster>
References: <20230420004850.297045-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-1-sarthakkukreti@chromium.org>
 <20230506062909.74601-6-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506062909.74601-6-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 11:29:09PM -0700, Sarthak Kukreti wrote:
> Add support for provision requests to loopback devices.
> Loop devices will configure provision support based on
> whether the underlying block device/file can support
> the provision request and upon receiving a provision bio,
> will map it to the backing device/storage. For loop devices
> over files, a REQ_OP_PROVISION request will translate to
> an fallocate mode 0 call on the backing file.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/block/loop.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bc31bb7072a2..13c4b4f8b9c1 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -327,6 +327,24 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	return ret;
>  }
>  
> +static int lo_req_provision(struct loop_device *lo, struct request *rq, loff_t pos)
> +{
> +	struct file *file = lo->lo_backing_file;
> +	struct request_queue *q = lo->lo_queue;
> +	int ret;
> +
> +	if (!q->limits.max_provision_sectors) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	ret = file->f_op->fallocate(file, 0, pos, blk_rq_bytes(rq));
> +	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
> +		ret = -EIO;
> + out:
> +	return ret;
> +}
> +
>  static int lo_req_flush(struct loop_device *lo, struct request *rq)
>  {
>  	int ret = vfs_fsync(lo->lo_backing_file, 0);
> @@ -488,6 +506,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  				FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_DISCARD:
>  		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
> +	case REQ_OP_PROVISION:
> +		return lo_req_provision(lo, rq, pos);

Hi Sarthak,

The only thing that stands out to me is the separate lo_req_provision()
helper here. It seems it might be a little cleaner to extend and reuse
lo_req_fallocate()..? But that's not something I feel strongly about, so
this all looks pretty good to me either way, FWIW.

Brian

>  	case REQ_OP_WRITE:
>  		if (cmd->use_aio)
>  			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
> @@ -754,6 +774,25 @@ static void loop_sysfs_exit(struct loop_device *lo)
>  				   &loop_attribute_group);
>  }
>  
> +static void loop_config_provision(struct loop_device *lo)
> +{
> +	struct file *file = lo->lo_backing_file;
> +	struct inode *inode = file->f_mapping->host;
> +
> +	/*
> +	 * If the backing device is a block device, mirror its provisioning
> +	 * capability.
> +	 */
> +	if (S_ISBLK(inode->i_mode)) {
> +		blk_queue_max_provision_sectors(lo->lo_queue,
> +			bdev_max_provision_sectors(I_BDEV(inode)));
> +	} else if (file->f_op->fallocate) {
> +		blk_queue_max_provision_sectors(lo->lo_queue, UINT_MAX >> 9);
> +	} else {
> +		blk_queue_max_provision_sectors(lo->lo_queue, 0);
> +	}
> +}
> +
>  static void loop_config_discard(struct loop_device *lo)
>  {
>  	struct file *file = lo->lo_backing_file;
> @@ -1092,6 +1131,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	blk_queue_io_min(lo->lo_queue, bsize);
>  
>  	loop_config_discard(lo);
> +	loop_config_provision(lo);
>  	loop_update_rotational(lo);
>  	loop_update_dio(lo);
>  	loop_sysfs_init(lo);
> @@ -1304,6 +1344,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	}
>  
>  	loop_config_discard(lo);
> +	loop_config_provision(lo);
>  
>  	/* update dio if lo_offset or transfer is changed */
>  	__loop_update_dio(lo, lo->use_dio);
> @@ -1830,6 +1871,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	case REQ_OP_FLUSH:
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_PROVISION:
>  		cmd->use_aio = false;
>  		break;
>  	default:
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 

