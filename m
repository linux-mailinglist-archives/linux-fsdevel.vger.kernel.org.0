Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1330673F3FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 07:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjF0FlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjF0FlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:41:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A5F173B;
        Mon, 26 Jun 2023 22:41:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7f2239bfdso22579405ad.1;
        Mon, 26 Jun 2023 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687844470; x=1690436470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUHv1b8aqLsb4R7LditAal7kNTag6lxKqXAOQ2qujCU=;
        b=fG/WGax37UoauKBSyv6kej64LdcGJrv6k66h8NGOsMv9uaUsNclSu7DiDyHvg7N0+H
         TpLbLvnFmTkLJuRzyFn0V5R9/xG3MBNfmS6gpoZxFQmbIvFJa8XU1iIC6Fyl95ACCFHi
         Ys+3TEnr35uP041kETcaQnaFL3Zzmuv0Ara4RUBuuI4A1DlyY37o026XtSt1PCG00d7o
         R82xvUrMlfJH4JujFDKNZYqLCuYZs3onB7GlXFtQZdgcqNFnR06TCpWzVOviTJnvGG64
         v3WIIO+Pf3siD1OxDgXeCgfd8ad+rtq0TuDOYOoPNLLpd/YOKy903+fL59/xrY4ynCa9
         WP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687844470; x=1690436470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUHv1b8aqLsb4R7LditAal7kNTag6lxKqXAOQ2qujCU=;
        b=du9CZbEIY3iks5eVJgPE5NhzfXvDFcVsZcOB1xr4m2W1GIycHe7Iyggp1lBugeqql1
         YEAV8L4wzKe2RLBmU7YHtBhSYMW3R7c/oJQvf/rvRNjVPf0Xx4e2qpwW/ED5eD596s/B
         QzztS9wnezPyTT0Tu6cw6eSJMHvSmnPqKwjOGKYzdtRLzhzy7wrjD0RUtyRjNHWO/5wS
         viGzBozIh/5VvtzM/v6k5L1TjNMXZ7pDfz2CQTBFCdBwS6OWdLmgWz8GvkA8olJRzSO4
         WuN49jDu3lF4V8MaWFkisoTwCeaMO8kN738KUjIBKdzjCuQFTxaKUc84cmwXhdn2q/9z
         8C5g==
X-Gm-Message-State: AC+VfDz9mQ4v+z/lN1O+GFOSNl1V3Fg7ygkfUs+n3LjHS0YO7IurhqUC
        HkoNqpbjyn60vSDLykeiOEs=
X-Google-Smtp-Source: ACHHUZ4Aj+CfQoLGg0YEyBUDipJUlv6nej6ije3P7CId9SMSoIBcFwHmOjcIwHyQMLpCclEzduuKWQ==
X-Received: by 2002:a17:902:f54b:b0:1b6:b805:5ae3 with SMTP id h11-20020a170902f54b00b001b6b8055ae3mr10571515plf.3.1687844469519;
        Mon, 26 Jun 2023 22:41:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9-20020a1709026a8900b001b80d411e5bsm2144863plk.253.2023.06.26.22.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:41:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Jun 2023 22:41:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
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
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/31] cdrom: remove the unused mode argument to
 cdrom_release
Message-ID: <fb21bb8b-958a-4238-aab8-c2720ac519ad@roeck-us.net>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-7-hch@lst.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:25AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

$ git grep cdrom_release
Documentation/cdrom/cdrom-standard.rst:         cdrom_release,          /* release */
Documentation/cdrom/cdrom-standard.rst:the door, should be left over to the general routine *cdrom_release()*.
Documentation/cdrom/cdrom-standard.rst: void cdrom_release(struct inode *ip, struct file *fp)
                                                                           ^^^^^^^^^^^^^^^^^
drivers/cdrom/cdrom.c:void cdrom_release(struct cdrom_device_info *cdi)
drivers/cdrom/cdrom.c:  cd_dbg(CD_CLOSE, "entering cdrom_release\n");
drivers/cdrom/cdrom.c:EXPORT_SYMBOL(cdrom_release);
drivers/cdrom/gdrom.c:  cdrom_release(gd.cd_info, mode);
                                                ^^^^^^
drivers/scsi/sr.c:      cdrom_release(&cd->cdi);
include/linux/cdrom.h:void cdrom_release(struct cdrom_device_info *cdi);

$ git grep cdrom_open
Documentation/cdrom/cdrom-standard.rst:         cdrom_open,             /* open */
Documentation/cdrom/cdrom-standard.rst: int cdrom_open(struct inode * ip, struct file * fp)
Documentation/cdrom/cdrom-standard.rst:This function implements the reverse-logic of *cdrom_open()*, and then
drivers/cdrom/cdrom.c:static int cdrom_open_write(struct cdrom_device_info *cdi)
drivers/cdrom/cdrom.c:int cdrom_open(struct cdrom_device_info *cdi, blk_mode_t mode)
drivers/cdrom/cdrom.c:  cd_dbg(CD_OPEN, "entering cdrom_open\n");
drivers/cdrom/cdrom.c:                  if (cdrom_open_write(cdi))
drivers/cdrom/cdrom.c:EXPORT_SYMBOL(cdrom_open);
drivers/cdrom/gdrom.c:  ret = cdrom_open(gd.cd_info);
                                         ^^^^^^^^^^
drivers/scsi/sr.c:      ret = cdrom_open(&cd->cdi, mode);
include/linux/cdrom.h:int cdrom_open(struct cdrom_device_info *cdi, blk_mode_t mode);

>  drivers/cdrom/cdrom.c | 2 +-
>  drivers/cdrom/gdrom.c | 2 +-
>  drivers/scsi/sr.c     | 2 +-
>  include/linux/cdrom.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index adebac1bd210d9..998b03fe976e22 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1250,7 +1250,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
>  	return 0;
>  }
>  
> -void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
> +void cdrom_release(struct cdrom_device_info *cdi)
>  {
>  	const struct cdrom_device_ops *cdo = cdi->ops;
>  
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 14922403983e9e..a401dc4218a998 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
>  	bdev_check_media_change(bdev);
>  
>  	mutex_lock(&gdrom_mutex);
> -	ret = cdrom_open(gd.cd_info, mode);
> +	ret = cdrom_open(gd.cd_info);
>  	mutex_unlock(&gdrom_mutex);
>  	return ret;
>  }
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index 444c7efc14cba7..6d33120ee5ba85 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -512,7 +512,7 @@ static void sr_block_release(struct gendisk *disk, fmode_t mode)
>  	struct scsi_cd *cd = scsi_cd(disk);
>  
>  	mutex_lock(&cd->lock);
> -	cdrom_release(&cd->cdi, mode);
> +	cdrom_release(&cd->cdi);
>  	mutex_unlock(&cd->lock);
>  
>  	scsi_device_put(cd->device);
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 385e94732b2cf1..3f23d5239de254 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -102,7 +102,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
>  
>  /* the general block_device operations structure: */
>  int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
> -extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
> +void cdrom_release(struct cdrom_device_info *cdi);
>  int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
>  		unsigned int cmd, unsigned long arg);
>  extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
> -- 
> 2.39.2
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
