Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5236CFAE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC3Fsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 01:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC3Fss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:48:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1082139;
        Wed, 29 Mar 2023 22:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20BDEB825D8;
        Thu, 30 Mar 2023 05:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6990DC433D2;
        Thu, 30 Mar 2023 05:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680155323;
        bh=lQIWkG96HEOigO4uxjKwseyUJFpfgWSVR2DNobYfCEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1y5ebevSlJFzuLM5GzkEyt/CYemxPmct+Tz3wAEbvbGVWEAXsQTkg1fmRCEliSsl
         LEdSb/Gl1dECvicoc6sJKNqlIVR8GONQ0rgtvlFJ5c3H6Z6sDmYypmKZ75MxFAr9B5
         GgHX5jGLB8a5N5l8MPXcfkN4W21aGIiqZ0rlLl9QdEWkKDHyXn7suBHLJGk1UEUpEB
         MN7hrqBJmCCdC/nkPxaexkfrDkTCuQlHDWiZSSOWAr8DwpibCISqDB1MBgQjWpPF4D
         Tq5KlHh4/a4K2BJ4iqn5ohJOkYqItOrroYvLlO9xbruZlXLhNPVQzUdK0ppON3P1H7
         WlJYooCLwgEgQ==
Date:   Thu, 30 Mar 2023 07:48:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Message-ID: <20230330-strode-deforest-b65424417062@brauner>
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084244epcas5p1b0ede867e558ff6faf258de3656a8aa4@epcas5p1.samsung.com>
 <20230327084103.21601-5-anuj20.g@samsung.com>
 <20230329-glitter-drainpipe-bdf9d3876ac4@brauner>
 <20230329124236.GB3895@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230329124236.GB3895@green5>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 06:12:36PM +0530, Nitesh Shetty wrote:
> On Wed, Mar 29, 2023 at 02:14:40PM +0200, Christian Brauner wrote:
> > On Mon, Mar 27, 2023 at 02:10:52PM +0530, Anuj Gupta wrote:
> > > From: Nitesh Shetty <nj.shetty@samsung.com>
> > > 
> > > For direct block device opened with O_DIRECT, use copy_file_range to
> > > issue device copy offload, and fallback to generic_copy_file_range incase
> > > device copy offload capability is absent.
> > > Modify checks to allow bdevs to use copy_file_range.
> > > 
> > > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > ---
> > >  block/blk-lib.c        | 22 ++++++++++++++++++++++
> > >  block/fops.c           | 20 ++++++++++++++++++++
> > >  fs/read_write.c        | 11 +++++++++--
> > >  include/linux/blkdev.h |  3 +++
> > >  4 files changed, 54 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > index a21819e59b29..c288573c7e77 100644
> > > --- a/block/blk-lib.c
> > > +++ b/block/blk-lib.c
> > > @@ -475,6 +475,28 @@ static inline bool blk_check_copy_offload(struct request_queue *q_in,
> > >  	return blk_queue_copy(q_in) && blk_queue_copy(q_out);
> > >  }
> > >  
> > > +int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
> > > +		      struct block_device *bdev_out, loff_t pos_out, size_t len,
> > > +		      cio_iodone_t end_io, void *private, gfp_t gfp_mask)
> > > +{
> > > +	struct request_queue *in_q = bdev_get_queue(bdev_in);
> > > +	struct request_queue *out_q = bdev_get_queue(bdev_out);
> > > +	int ret = -EINVAL;
> > 
> > Why initialize to -EINVAL if blk_copy_sanity_check() initializes it
> > right away anyway?
> > 
> 
> acked.
> 
> > > +	bool offload = false;
> > 
> > Same thing with initializing offload.
> > 
> acked
> 
> > > +
> > > +	ret = blk_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	offload = blk_check_copy_offload(in_q, out_q);
> > > +	if (offload)
> > > +		ret = __blk_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
> > > +				len, end_io, private, gfp_mask);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(blkdev_copy_offload);
> > > +
> > >  /*
> > >   * @bdev_in:	source block device
> > >   * @pos_in:	source offset
> > > diff --git a/block/fops.c b/block/fops.c
> > > index d2e6be4e3d1c..3b7c05831d5c 100644
> > > --- a/block/fops.c
> > > +++ b/block/fops.c
> > > @@ -611,6 +611,25 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >  	return ret;
> > >  }
> > >  
> > > +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> > > +				struct file *file_out, loff_t pos_out,
> > > +				size_t len, unsigned int flags)
> > > +{
> > > +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> > > +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> > > +	int comp_len = 0;
> > > +
> > > +	if ((file_in->f_iocb_flags & IOCB_DIRECT) &&
> > > +		(file_out->f_iocb_flags & IOCB_DIRECT))
> > > +		comp_len = blkdev_copy_offload(in_bdev, pos_in, out_bdev,
> > > +				 pos_out, len, NULL, NULL, GFP_KERNEL);
> > > +	if (comp_len != len)
> > > +		comp_len = generic_copy_file_range(file_in, pos_in + comp_len,
> > > +			file_out, pos_out + comp_len, len - comp_len, flags);
> > 
> > I'm not deeply familiar with this code but this looks odd. It at least
> > seems possible that comp_len could be -EINVAL and len 20 at which point
> > you'd be doing len - comp_len aka 20 - 22 = -2 in generic_copy_file_range().

20 - -22 = 44 ofc

> 
> comp_len should be 0 incase of error. We do agree, some function

I mean, not to hammer on this point too much but just to be clear
blk_copy_sanity_check(), which is introduced in the second patch, can
return both -EPERM and -EINVAL and is first called in
blkdev_copy_offload() so it's definitely possible for comp_len to be
negative.
