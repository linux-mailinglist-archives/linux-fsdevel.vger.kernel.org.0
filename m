Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9E75A85D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 09:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjGTH5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGTH5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:57:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED2A2127;
        Thu, 20 Jul 2023 00:57:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 156026732D; Thu, 20 Jul 2023 09:57:11 +0200 (CEST)
Date:   Thu, 20 Jul 2023 09:57:10 +0200
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
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <20230720075710.GC5042@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184029epcas5p49a29676fa6dff5f24ddfa5c64e525a51@epcas5p4.samsung.com> <20230627183629.26571-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-5-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/* Copy source offset from source block device to destination block
> + * device. Returns the length of bytes copied.
> + */
> +ssize_t blkdev_copy_offload_failfast(
> +		struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out,
> +		size_t len, gfp_t gfp_mask)

This is an odd and very misnamed interface.

Either we have a klkdev_copy() interface that automatically falls back
to a fallback (maybe with an opt-out), or we have separate
blkdev_copy_offload/blkdev_copy_emulated interface and let the caller
decide.  But none of that really is "failfast".

Also this needs to go into the helpers patch and not a patch that is
supposed to just wire copying up for block device node.

> index b07de77ef126..d27148a2543f 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1447,7 +1447,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  		return -EOVERFLOW;
>  
>  	/* Shorten the copy to EOF */
> -	size_in = i_size_read(inode_in);
> +	size_in = i_size_read(file_in->f_mapping->host);

generic_copy_file_checks needs to be fixed to use ->mapping->host both
or inode_in and inode_out at the top of the file instead of this
band aid.  And that needs to be a separate patch with a Fixes tag.

> @@ -1708,7 +1709,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>  	/* Don't copy dirs, pipes, sockets... */
>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>  		return -EISDIR;
> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +
> +	if ((!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode)) &&
> +		(!S_ISBLK(inode_in->i_mode) || !S_ISBLK(inode_out->i_mode)))

This is using weird indentation, and might also not be doing
exactly what we want.  I think the better thing to do here is to:

 1) check for the accetable types only on the in inode
 2) have a check that the mode matches for the in and out inodes

And please do this as a separate prep patch instead of hiding it here.

