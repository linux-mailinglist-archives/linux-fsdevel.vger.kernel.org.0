Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809677257CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbjFGIee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjFGIed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:34:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B8198B;
        Wed,  7 Jun 2023 01:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 679EC6386F;
        Wed,  7 Jun 2023 08:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A10C433D2;
        Wed,  7 Jun 2023 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686126852;
        bh=WLIiOy1LVRNyW0WZKHMIEfuQqspHlo5YhO+pF9gbKTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOuWu1dlGBSnRsTIERY3XMHE9OvetSc+XVDTNH9LUt5Ur7MEzWHQldJkC0OjFF39K
         8gGF0zsP8mAReVRRLxbA3ZDMv8aReZJfLmnxqg2TjHMWlP4lcMK9VVsvtBUjxWcffe
         iriT6wbTkvybZ5ExwZT785rTN0BZKNtthQHc5REmf28J1I7IlqVDJgibRROBA8W6ym
         o7kZewH3FWNgkyfATBHcyXzIU6aVOCyONuL3m8m1iO12qt2laJZWwD1ve/kVe3HC7N
         SAc45LJ2WAm7wX6H10W0XR8XlHHzXCy54pHlLC7qCDuxE5H2tx4uNHCy0AYTeLwOxb
         XjEhfMSt+EF+Q==
Date:   Wed, 7 Jun 2023 10:34:04 +0200
From:   Christian Brauner <brauner@kernel.org>
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
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/31] block: pass a gendisk to ->open
Message-ID: <20230607-einlieferung-beantragen-062729bc8f6c@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-10-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:28AM +0200, Christoph Hellwig wrote:
> ->open is only called on the whole device.  Make that explicit by

Ok, that answers my question in
https://lore.kernel.org/all/20230607-chefsessel-angeordnet-269f0596f9b3@brauner

> passing a gendisk instead of the block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a1688eba7e5e9a..1366eea881860e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1386,7 +1386,7 @@ struct block_device_operations {
>  	void (*submit_bio)(struct bio *bio);
>  	int (*poll_bio)(struct bio *bio, struct io_comp_batch *iob,
>  			unsigned int flags);
> -	int (*open) (struct block_device *, fmode_t);
> +	int (*open)(struct gendisk *disk, fmode_t mode);
>  	void (*release) (struct gendisk *, fmode_t);
>  	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
>  	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

(I didn't bother going through all the individual conversions.)
