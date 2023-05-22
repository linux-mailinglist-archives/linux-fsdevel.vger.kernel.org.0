Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B670C393
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjEVQhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjEVQhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 12:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD78BF;
        Mon, 22 May 2023 09:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E09F61B6C;
        Mon, 22 May 2023 16:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5BFC433EF;
        Mon, 22 May 2023 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684773430;
        bh=2He6U7qRXsvcUhtzbRqViBFgVaT+dg2a2JQ7qWLAX9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VZXeWVIh07NmnTCmgVxAUdNEN/GFI7px1Szk/0gj+mTlwADll5GDq8yMtIGHk/2/v
         5/+XsBtb4u/VtVnJCxv2Sz6CQpBonzMUKJNOvIBr4pzz33dCTT7DITwfmBrI3x/7ow
         wneGx6y9vdwA1JWQdHS2EFKj8jFdUnvBvenc3AXYljvXlM0gnZsSatAQ4vddWrPcq1
         ipIFtaHJQwicwfbn2dQwYqVu2ptWjeA3D01NbL1SID8nnUDpR0Vp6Ix4LyV+8cq4Xd
         RIhoQfcwi+TmdEyL1rA6Rkr3+y8L8gZJEQ7KuNfIkwe4F2GP5K8mdm0jBcUkdLgBnK
         xOXyAXGzdSmmw==
Date:   Mon, 22 May 2023 09:37:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH v7 5/5] loop: Add support for provision
 requests
Message-ID: <20230522163710.GA11607@frogsfrogsfrogs>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-6-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518223326.18744-6-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 03:33:26PM -0700, Sarthak Kukreti wrote:
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
>  drivers/block/loop.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bc31bb7072a2..7fe1a6629754 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -311,16 +311,20 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  {
>  	/*
>  	 * We use fallocate to manipulate the space mappings used by the image
> -	 * a.k.a. discard/zerorange.
> +	 * a.k.a. discard/provision/zerorange.
>  	 */
>  	struct file *file = lo->lo_backing_file;
>  	int ret;
>  
> -	mode |= FALLOC_FL_KEEP_SIZE;
> +	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE) &&
> +	    !bdev_max_discard_sectors(lo->lo_device))
> +		return -EOPNOTSUPP;
>  
> -	if (!bdev_max_discard_sectors(lo->lo_device))
> +	if (mode == 0 && !bdev_max_provision_sectors(lo->lo_device))
>  		return -EOPNOTSUPP;
>  
> +	mode |= FALLOC_FL_KEEP_SIZE;
> +
>  	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>  	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>  		return -EIO;
> @@ -488,6 +492,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  				FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_DISCARD:
>  		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
> +	case REQ_OP_PROVISION:
> +		return lo_fallocate(lo, rq, pos, 0);

If someone calls fallocate(UNSHARE_RANGE) on a loop bdev, shouldn't
there be a way to pass that through to the fallocate call to the backing
file?

--D

>  	case REQ_OP_WRITE:
>  		if (cmd->use_aio)
>  			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
> @@ -754,6 +760,25 @@ static void loop_sysfs_exit(struct loop_device *lo)
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
> @@ -1092,6 +1117,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	blk_queue_io_min(lo->lo_queue, bsize);
>  
>  	loop_config_discard(lo);
> +	loop_config_provision(lo);
>  	loop_update_rotational(lo);
>  	loop_update_dio(lo);
>  	loop_sysfs_init(lo);
> @@ -1304,6 +1330,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	}
>  
>  	loop_config_discard(lo);
> +	loop_config_provision(lo);
>  
>  	/* update dio if lo_offset or transfer is changed */
>  	__loop_update_dio(lo, lo->use_dio);
> @@ -1830,6 +1857,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	case REQ_OP_FLUSH:
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_PROVISION:
>  		cmd->use_aio = false;
>  		break;
>  	default:
> -- 
> 2.40.1.698.g37aff9b760-goog
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
