Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD70725034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjFFWvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjFFWvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:51:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C0171B
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:50:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ad458f085so14565f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686091846; x=1688683846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsgUvAUYrCnrR/1XiT9juxzkogVY5Vs72GapwMni78s=;
        b=VmbPZldWPYAwRsYyMwk8A03rXJyrpTvXOEYSvwFSEfXYGQ9f0DibZgbOcZv9ahaGKf
         PI5+OxAdMYvbZGfbUvFF/CsIWyPYoUJBv4adaCgbsLoKZ4qUcAWsIa6Ri3jpTK/bHQrT
         Ohep93vPQ7ryyJQWAyfDBFxol1ij/mZJMW0A0iwqiwl36LvAZOLX1aeY9L0SpoZCLnJz
         wVbN864mtnWORoS661vBrZSXNRIiY6AXoBUlqUh/rkIvLh2gwYqiK+WaVFKW8of/Br1s
         OKeXsZtVkiiCWR6CHlkqhjfmhnyDAQPTMoZhbcUNAf6eh7p56c8hqiOZ1oxWgdRViFlH
         o2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686091846; x=1688683846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsgUvAUYrCnrR/1XiT9juxzkogVY5Vs72GapwMni78s=;
        b=eM+Rhmr+/UMDsdH4456sULt60la5+3Hj2pWVsSS2N7S09ZVMil1P1pbB+Kep9nU4WD
         I87AszFsprsXeNe5Ckmmn7/UDyg8YglU8Jg1EPPwUuu2NBU+4D/Dn8znYKqHX57DiRPM
         kVk40RAe4Ce2q2Irv98Olig9heqdSqbfbfZzH/vXEnv7Wx/TAXuRp5U7hWRCULrhqcay
         Inh+EsZS0q8Jfp9HK86Y6mQ/vKrPK9hrgQy2fLfS5Zd16q0LjVz/vAFj5xoFe7WwjuZV
         mc4bXPDw4Z1zALJbcDPXgXZJeTZjrRerUlKCmYWaBi0SrOPnW28YT3WeAN+EThF6icUX
         WKSg==
X-Gm-Message-State: AC+VfDzOJ3Kvv9dumZ/49m8xUZJMTTOb++inwOk5QHxkq0zfXA2+zPoh
        fUqGkgHDER2s7u4vdrunOZSErw==
X-Google-Smtp-Source: ACHHUZ6DIZ/PhyT9JV3FzdchvbYZ3qIwLNNEqf/pmfFBTRfAYv0aDDapWKAK27qD8k0ew1wS3jRAUg==
X-Received: by 2002:a5d:6b82:0:b0:30e:47e2:7eca with SMTP id n2-20020a5d6b82000000b0030e47e27ecamr4524731wrx.3.1686091845858;
        Tue, 06 Jun 2023 15:50:45 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0030ae3a6be5bsm13760443wrt.78.2023.06.06.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:50:45 -0700 (PDT)
Date:   Tue, 6 Jun 2023 23:50:43 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
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
Subject: Re: [PATCH 02/31] cdrom: remove the unused bdev argument to
 cdrom_open
Message-ID: <ZH+4QyeJ2WCOaPGO@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-3-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:21AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/cdrom/cdrom.c | 3 +--
>  drivers/cdrom/gdrom.c | 2 +-
>  drivers/scsi/sr.c     | 2 +-
>  include/linux/cdrom.h | 3 +--
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb33..e3eab319cb0474 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -1155,8 +1155,7 @@ int open_for_data(struct cdrom_device_info *cdi)
>   * is in their own interest: device control becomes a lot easier
>   * this way.
>   */
> -int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
> -	       fmode_t mode)
> +int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
>  {
>  	int ret;
>  
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index ceded5772aac6d..eaa2d5a90bc82f 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
>  	bdev_check_media_change(bdev);
>  
>  	mutex_lock(&gdrom_mutex);
> -	ret = cdrom_open(gd.cd_info, bdev, mode);
> +	ret = cdrom_open(gd.cd_info, mode);
>  	mutex_unlock(&gdrom_mutex);
>  	return ret;
>  }
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index 12869e6d4ebda8..61b83880e395a4 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -498,7 +498,7 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
>  		sr_revalidate_disk(cd);
>  
>  	mutex_lock(&cd->lock);
> -	ret = cdrom_open(&cd->cdi, bdev, mode);
> +	ret = cdrom_open(&cd->cdi, mode);
>  	mutex_unlock(&cd->lock);
>  
>  	scsi_autopm_put_device(sdev);
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index 67caa909e3e615..cc5717cb0fa8a8 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -101,8 +101,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
>  		struct cdrom_tocentry *entry);
>  
>  /* the general block_device operations structure: */
> -extern int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
> -			fmode_t mode);
> +int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
>  extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
>  extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
>  		       fmode_t mode, unsigned int cmd, unsigned long arg);
> -- 
> 2.39.2
> 

Thanks for the patch, looks good to me.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
