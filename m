Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0FB787DE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 04:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHYCpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 22:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHYCpV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:45:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E167133;
        Thu, 24 Aug 2023 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BAs3vHnqB82jyF9T0JKZy08jGuQDnnwXLjj44ySrvFg=; b=qG/yF0qNQFz1HErcIOwDpMsE95
        yvpWaJiccPJne5E6IKKdLk49il4mSFXaxO10+cPRq4RqC2mgW99o+1yf2c4bs81MOg47gz2QA9ZFT
        aLJydE8tWV8lzCMv2+NeX7mQCMknUB5EhVQiqQN5lBaCEsUTiWdC5wvrGaIvwhXVRrB8AFK90tiyv
        FLjfEbnlTWQpGxkRRGa9YbyGmW5wSGD0SSIG8KNS+lDxJs8er6W0jn8lCxtIFwizoom7apeGKhs9v
        c0WlIDcCZSTbrPU9y3Jy4WWr/hC4ZjXs2RvO1eOF4P2UntF/l1INZ+xsvc1Hck8kt4ukocelH0IdQ
        bSBNV7lw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qZMoj-000edp-26;
        Fri, 25 Aug 2023 02:44:57 +0000
Date:   Fri, 25 Aug 2023 03:44:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/30] block: also call ->open for incremental partition
 opens
Message-ID: <20230825024457.GD95084@ZenIV>
References: <20230608110258.189493-1-hch@lst.de>
 <20230608110258.189493-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608110258.189493-2-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:02:29PM +0200, Christoph Hellwig wrote:

> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -683,9 +683,6 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  	struct gendisk *disk = part->bd_disk;
>  	int ret;
>  
> -	if (atomic_read(&part->bd_openers))
> -		goto done;
> -
>  	ret = blkdev_get_whole(bdev_whole(part), mode);
>  	if (ret)
>  		return ret;
> @@ -694,9 +691,10 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  	if (!bdev_nr_sectors(part))
>  		goto out_blkdev_put;
>  
> -	disk->open_partitions++;
> -	set_init_blocksize(part);
> -done:
> +	if (!atomic_read(&part->bd_openers)) {
> +		disk->open_partitions++;
> +		set_init_blocksize(part);
> +	}

[with apologies for very late (and tangential) reply]

That got me curious about the ->bd_openers - do we need it atomic?
Most of the users (and all places that do modifications) are
under ->open_mutex; the only exceptions are
	* early sync logics in blkdev_put(); it's explicitly racy -
see the comment there.
	* callers of disk_openers() in loop and nbd (the ones in
zram are under ->open_mutex).  There's driver-private exclusion
around those, but in any case - READ_ONCE() is no worse than
atomic_read() in those cases.

Is there something subtle I'm missing here?
