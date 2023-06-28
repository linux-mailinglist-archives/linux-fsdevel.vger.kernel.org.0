Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1522740B15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjF1IWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjF1IOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C49535AD;
        Wed, 28 Jun 2023 01:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9039561313;
        Wed, 28 Jun 2023 06:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0FDC433C8;
        Wed, 28 Jun 2023 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687935073;
        bh=kFdGBo6KtB8a4oZ+cEW87+zyKqsMbfQQzmLbCpziW2A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kla7NE7DMvYZIgfUZ+N8bsXWQJ2Oc/m2Js4i+rQGT9fpYXdLy6GxXEjWJ+zIzAfkB
         IHA+dC3ZfZvps7e9zAw2JenAv7FzJQqi6TTiQP+IPlyCk9pjlzjVkxKwaBs2gi95Mi
         zhxGn8q/BBi+wc3/JQZFnI2kbIr5n3K4eA3PRb1Jv+VQoNSU58TFRzQiytkOMHJ/mn
         TYxE7GsnKfzTSJUej8iljS/LmGmU4AH7oAyseW0nVEy4w/7QAbWGdJk8C8izw3yjMf
         LRKpLT8rO1+Kh8X8mE1O6o3z2qIvgYp7o6n7YFu3bZ7v+4piec/JNxgOecHYdcQ+go
         /rqZHDjb4CWIg==
Message-ID: <365d5129-b65e-919a-3ceb-cc2ccf6b7a5a@kernel.org>
Date:   Wed, 28 Jun 2023 15:51:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v13 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51@epcas5p4.samsung.com>
 <20230627183629.26571-5-nj.shetty@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230627183629.26571-5-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 03:36, Nitesh Shetty wrote:
> For direct block device opened with O_DIRECT, use copy_file_range to
> issue device copy offload, and fallback to generic_copy_file_range incase
> device copy offload capability is absent.

...if the device does not support copy offload or the device files are not open
with O_DIRECT.

No ?

> Modify checks to allow bdevs to use copy_file_range.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/blk-lib.c        | 26 ++++++++++++++++++++++++++
>  block/fops.c           | 20 ++++++++++++++++++++
>  fs/read_write.c        |  7 +++++--
>  include/linux/blkdev.h |  4 ++++
>  4 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 09e0d5d51d03..7d8e09a99254 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -473,6 +473,32 @@ ssize_t blkdev_copy_offload(
>  }
>  EXPORT_SYMBOL_GPL(blkdev_copy_offload);
>  
> +/* Copy source offset from source block device to destination block
> + * device. Returns the length of bytes copied.
> + */

Multi-line comment style: start with a "/*" line please.

> +ssize_t blkdev_copy_offload_failfast(

What is the "failfast" in the name for ?

> +		struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out,
> +		size_t len, gfp_t gfp_mask)
> +{
> +	struct request_queue *in_q = bdev_get_queue(bdev_in);
> +	struct request_queue *out_q = bdev_get_queue(bdev_out);
> +	ssize_t ret = 0;

You do not need this initialization.

> +
> +	if (blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len))
> +		return 0;
> +
> +	if (blk_queue_copy(in_q) && blk_queue_copy(out_q)) {

Given that I think we do not allow copies between different devices, in_q and
out_q should always be the same, no ?

> +		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
> +				len, NULL, NULL, gfp_mask);

Same here. Why pass 2 bdevs if we only allow copies within the same device ?

> +		if (ret < 0)
> +			return 0;
> +	}
> +
> +	return ret;

return 0;

> +}
> +EXPORT_SYMBOL_GPL(blkdev_copy_offload_failfast);
> +
>  static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>  		struct bio **biop, unsigned flags)
> diff --git a/block/fops.c b/block/fops.c
> index a286bf3325c5..a1576304f269 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -621,6 +621,25 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> +				struct file *file_out, loff_t pos_out,
> +				size_t len, unsigned int flags)
> +{
> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> +	ssize_t comp_len = 0;
> +
> +	if ((file_in->f_iocb_flags & IOCB_DIRECT) &&
> +		(file_out->f_iocb_flags & IOCB_DIRECT))
> +		comp_len = blkdev_copy_offload_failfast(in_bdev, pos_in,
> +				out_bdev, pos_out, len, GFP_KERNEL);
> +	if (comp_len != len)
> +		comp_len = generic_copy_file_range(file_in, pos_in + comp_len,
> +			file_out, pos_out + comp_len, len - comp_len, flags);
> +
> +	return comp_len;
> +}
> +
>  #define	BLKDEV_FALLOC_FL_SUPPORTED					\
>  		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
>  		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> @@ -714,6 +733,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_read	= filemap_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
> +	.copy_file_range = blkdev_copy_file_range,
>  };
>  
>  static __init int blkdev_init(void)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b07de77ef126..d27148a2543f 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1447,7 +1447,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  		return -EOVERFLOW;
>  
>  	/* Shorten the copy to EOF */
> -	size_in = i_size_read(inode_in);
> +	size_in = i_size_read(file_in->f_mapping->host);
> +
>  	if (pos_in >= size_in)
>  		count = 0;
>  	else
> @@ -1708,7 +1709,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	/* Don't copy dirs, pipes, sockets... */
>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>  		return -EISDIR;
> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +
> +	if ((!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode)) &&
> +		(!S_ISBLK(inode_in->i_mode) || !S_ISBLK(inode_out->i_mode)))
>  		return -EINVAL;
>  
>  	if (!(file_in->f_mode & FMODE_READ) ||
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c176bf6173c5..850168cad080 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1047,6 +1047,10 @@ ssize_t blkdev_copy_offload(
>  		struct block_device *bdev_in, loff_t pos_in,
>  		struct block_device *bdev_out, loff_t pos_out,
>  		size_t len, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
> +ssize_t blkdev_copy_offload_failfast(
> +		struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out,
> +		size_t len, gfp_t gfp_mask);
>  struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>  		gfp_t gfp_mask);
>  void bio_map_kern_endio(struct bio *bio);

-- 
Damien Le Moal
Western Digital Research

