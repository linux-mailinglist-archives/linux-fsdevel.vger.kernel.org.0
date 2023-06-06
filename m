Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1407723B74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjFFIZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 6 Jun 2023 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjFFIYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:24:48 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC10E62;
        Tue,  6 Jun 2023 01:24:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A2DC56081100;
        Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id siZzZpJorNJf; Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 34240616B2CF;
        Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YeogKuuY1hxw; Tue,  6 Jun 2023 10:24:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E97466081100;
        Tue,  6 Jun 2023 10:24:38 +0200 (CEST)
Date:   Tue, 6 Jun 2023 10:24:38 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     hch <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-bcache <linux-bcache@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Message-ID: <318049918.3687133.1686039878761.JavaMail.zimbra@nod.at>
In-Reply-To: <20230606073950.225178-24-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-24-hch@lst.de>
Subject: Re: [PATCH 23/31] mtd: block: use a simple bool to track open for
 write
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: use a simple bool to track open for write
Thread-Index: X/xlpyhSf8bloXE5HNEoh3ox5Q1J9Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "hch" <hch@lst.de>
> Instead of propagating the fmode_t, just use a bool to track if a mtd
> block device was opened for writing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/mtd/mtd_blkdevs.c    | 2 +-
> drivers/mtd/mtdblock.c       | 2 +-
> include/linux/mtd/blktrans.h | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index f0bb09fde95e3a..bd0b7545364349 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -208,7 +208,7 @@ static int blktrans_open(struct gendisk *disk, fmode_t mode)
> 	ret = __get_mtd_device(dev->mtd);
> 	if (ret)
> 		goto error_release;
> -	dev->file_mode = mode;
> +	dev->writable = mode & FMODE_WRITE;
> 
> unlock:
> 	dev->open++;
> diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> index a0a1194dc1d902..fa476fb4dffb6c 100644
> --- a/drivers/mtd/mtdblock.c
> +++ b/drivers/mtd/mtdblock.c
> @@ -294,7 +294,7 @@ static void mtdblock_release(struct mtd_blktrans_dev *mbd)
> 		 * It was the last usage. Free the cache, but only sync if
> 		 * opened for writing.
> 		 */
> -		if (mbd->file_mode & FMODE_WRITE)
> +		if (mbd->writable)
> 			mtd_sync(mbd->mtd);
> 		vfree(mtdblk->cache_data);
> 	}
> diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
> index 15cc9b95e32b52..6e471436bba556 100644
> --- a/include/linux/mtd/blktrans.h
> +++ b/include/linux/mtd/blktrans.h
> @@ -34,7 +34,7 @@ struct mtd_blktrans_dev {
> 	struct blk_mq_tag_set *tag_set;
> 	spinlock_t queue_lock;
> 	void *priv;
> -	fmode_t file_mode;
> +	bool writable;
> };

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
