Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2D425B16B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgIBQTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIBQTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:19:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9CEC061244;
        Wed,  2 Sep 2020 09:19:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f127so107414lfd.7;
        Wed, 02 Sep 2020 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A4Ns4FXyKzBbQIQFhXeIN99gK1TEB4bN7K2rZb3tfqs=;
        b=tBR2n6hvrbBmXRV3KYYvZLMZe1zksCcBHJSuVij9v/Mfx0mjvXpvKQv+n2NjGjB5+7
         FUlvE06p5sp9p7lyyIWi2rgXvbZt8LHbpMfb31wmHq2MfE2dN19KZjip4hM9j1mjci7b
         4ne3Nb7NNiRJSUh+wLALVk4vZsU1Ajv1tiTjTq6NzgX7BjYPwRrhcbzY0D+CobKQFM5v
         8XGrSnvqb5C7xMnlLSeEs0UBZ29+9TXxGbshDEYoHp3P1wd6/6YZ2fziqnj3SZstZtRE
         x6ZYyh15XZdwqOUWKRSnXUgcM7FViI71QM9cYJmMkibTmGfYjd+IhDtQgPUPE8dXMjn3
         7Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4Ns4FXyKzBbQIQFhXeIN99gK1TEB4bN7K2rZb3tfqs=;
        b=MUgVFGcsjmr0W425VRqQi7lYsvMYVVwTk+Yj3+3b+DBfnXGrqZ66LwYYb1Tqfkmc7j
         wsTpownH38me6I7YoR1apJZ5AZWuT/rHrEDz/DbokHypcht0GSgMXLsW/TQd+F4iMbSe
         qPxofvaLCQSgxg8xCaBzuX8mgFz/sfNyJ8lHOOqXK3F7rgD/txrQQL4pnLbBoqQxR0G1
         woaSlUfevydf5eLuE3odqFVaUSJZ8Fh0cKPgRv2aLC69D+x95ujEDdd7p6urUX5YlWtU
         Q3t1W5+7B9rmYPPw9Jl1D4+svDwu0MHG3dBq50MeefFNMKqeIGuGQV6n4TxZs3JWblrr
         oJ7w==
X-Gm-Message-State: AOAM533ik1s+alzTKp5THuIQ7Nk2WWivCwHlW6OzdGMk316OfJEew5Tb
        DtCXuISmG/A6H7GNMwVWueDVd5O1JyZYwQ==
X-Google-Smtp-Source: ABdhPJxorOuMt+fF1q/dzHdE2W3hPAzBwNmMujGF4eljWGZI3dJVEHHttghNXMYbfHt9AmKOTnf+bg==
X-Received: by 2002:a19:dcb:: with SMTP id 194mr3481675lfn.25.1599063559361;
        Wed, 02 Sep 2020 09:19:19 -0700 (PDT)
Received: from wasted.omprussia.ru ([2a00:1fa0:44ba:bd37:6990:9f35:8864:71b0])
        by smtp.gmail.com with ESMTPSA id d6sm19235ljg.25.2020.09.02.09.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 09:19:18 -0700 (PDT)
Subject: Re: [PATCH 16/19] sd: use bdev_check_media_change
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-17-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <1b972d93-e8e3-8f32-86de-76792948e20b@gmail.com>
Date:   Wed, 2 Sep 2020 19:19:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902141218.212614-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/20 5:12 PM, Christoph Hellwig wrote:

> Switch to use bdev_check_media_change instead of check_disk_change and
> call cd_revalidate_disk manually.  As sd also calls sd_revalidate_disk

   s/cd/sd/?

> manually during probe and open, , the extra call into ->revalidate_disk
> from bdev_disk_changed is not required either, so stop wiring up the
> method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/sd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 2bec8cd526164d..d020639c28c6ca 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1381,8 +1381,10 @@ static int sd_open(struct block_device *bdev, fmode_t mode)
>  	if (!scsi_block_when_processing_errors(sdev))
>  		goto error_out;
>  
> -	if (sdev->removable || sdkp->write_prot)
> -		check_disk_change(bdev);
> +	if (sdev->removable || sdkp->write_prot) {
> +		if (bdev_check_media_change(bdev))
> +			sd_revalidate_disk(bdev->bd_disk);
> +	}
>  
>  	/*
>  	 * If the drive is empty, just let the open fail.
[...]

MBR, Sergei
