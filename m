Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F74725047
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbjFFWyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbjFFWyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:54:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314A10FF
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:54:15 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30e412a852dso2458264f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686092054; x=1688684054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXBt7JZzXPFqym4cCnJPiy0FfIw5Z8TRQSIrowmnJ2I=;
        b=y/DPog6+x5wGemOO9REl8wWYWJzD4iMG9s0P4L75NF501qmTUKPPbjSmSWL8hk0aIH
         AReatV0VgQpuPEy6beyF6HQkDPhvz8Py1F5RgMVT0C0THCFzB5taD4RxBSZDph6MVAXv
         zq8qdbifmeoev+y+EMmyAhIWBhOh2u6DiEV1dl9i3upSb4XjHzWkpz+fQyiyAoqhOt72
         zBtDkRdlyEuvWSdP4/fWJTHUJreUQHAAXh+CUY+GkEkt/DXnJH0oIMni7ZM5hQbCL6t/
         vr1JxaS/c8scaopC4pHtcsjEmJADUTWY/pzY58wjFip8DTTkk41ATmdEOAV6RcEEIrIx
         yFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686092054; x=1688684054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXBt7JZzXPFqym4cCnJPiy0FfIw5Z8TRQSIrowmnJ2I=;
        b=IPImHOWH/JtkhJzse0k3OCL+DfxlVCdj8QO3jOuS79qNiUtt9BNJQPxJUElUa9YOio
         VoKgUB6vylNVOasEaRP3j0e83s2IywJK43ib4q+iTC1i1PG9HWUc/YysBSNjNggVBsOg
         YPPLhh7+vUmaxIVomXlEsQ7jhMKLqKhsQcOXDjCJZKIdEpzEm+PPxizP1IBxRcnV/1Qp
         VUP+iQKvVmkv00SoOohLEG8pCT2SHNxw2YGhiNwhodrt7F5oSnOXZYek0i0NHudeuTB+
         ThSsTVusxrYFs93Hii1jDpDNW6ibjZ8DvLKbL3Vjdm6DzeKPr1FOsFs7CVsxc+HogxdO
         8+cw==
X-Gm-Message-State: AC+VfDyiCcfln5alO7pgQDMRoXxniXNyuLKO5/NzsVGTKcVp8Nkv4+Ht
        OlcVo7BOTAev8myPYIDQNcW1eg==
X-Google-Smtp-Source: ACHHUZ5EAPVlS/dXZUIlff9U6cMvQ7qyxaaebNKkscChr1x36A65KZewdQ5EyNlkJSg7wU45zOpv+A==
X-Received: by 2002:a5d:458c:0:b0:309:4e85:897e with SMTP id p12-20020a5d458c000000b003094e85897emr2751249wrq.17.1686092054063;
        Tue, 06 Jun 2023 15:54:14 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d4ac6000000b002c70ce264bfsm13877769wrs.76.2023.06.06.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 15:54:13 -0700 (PDT)
Date:   Tue, 6 Jun 2023 23:54:11 +0100
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
Subject: Re: [PATCH 03/31] cdrom: remove the unused mode argument to
 cdrom_ioctl
Message-ID: <ZH+5E5OUUBcE1URG@equinox>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-4-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:22AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/cdrom/cdrom.c | 2 +-
>  drivers/cdrom/gdrom.c | 2 +-
>  drivers/scsi/sr.c     | 2 +-
>  include/linux/cdrom.h | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index e3eab319cb0474..245e5bbb05d41c 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -3336,7 +3336,7 @@ static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
>   * ATAPI / SCSI specific code now mainly resides in mmc_ioctl().
>   */
>  int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
> -		fmode_t mode, unsigned int cmd, unsigned long arg)
> +		unsigned int cmd, unsigned long arg)
>  {
>  	void __user *argp = (void __user *)arg;
>  	int ret;
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index eaa2d5a90bc82f..14922403983e9e 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -505,7 +505,7 @@ static int gdrom_bdops_ioctl(struct block_device *bdev, fmode_t mode,
>  	int ret;
>  
>  	mutex_lock(&gdrom_mutex);
> -	ret = cdrom_ioctl(gd.cd_info, bdev, mode, cmd, arg);
> +	ret = cdrom_ioctl(gd.cd_info, bdev, cmd, arg);
>  	mutex_unlock(&gdrom_mutex);
>  
>  	return ret;
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index 61b83880e395a4..444c7efc14cba7 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -539,7 +539,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
>  	scsi_autopm_get_device(sdev);
>  
>  	if (cmd != CDROMCLOSETRAY && cmd != CDROMEJECT) {
> -		ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
> +		ret = cdrom_ioctl(&cd->cdi, bdev, cmd, arg);
>  		if (ret != -ENOSYS)
>  			goto put;
>  	}
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index cc5717cb0fa8a8..4aea8c82d16971 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -103,8 +103,8 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
>  /* the general block_device operations structure: */
>  int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
>  extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
> -extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
> -		       fmode_t mode, unsigned int cmd, unsigned long arg);
> +int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
> +		unsigned int cmd, unsigned long arg);
>  extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
>  				       unsigned int clearing);
>  
> -- 
> 2.39.2
> 

Thanks, looks good.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
