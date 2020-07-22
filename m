Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B3229CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGVQI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgGVQI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:08:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B60C0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 09:08:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so2415623wmh.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AopLUumd1oP3C4JH4MOyeuojCVomrApkWKKCnfDQENc=;
        b=ZBI5Q6rk/Pmc3cgG4gTM6ousPukd1JKBI06yWojOp9/c48ijLvpc9hoZed2sNWsy5e
         x6MXkIUHHJQ2F1c7lfPggb5NiUxwYoqXDMe2yYa3jbZJ+KLlTrXTpzRmNFaF9X08dEkX
         WJ26/yV1dGHmwNfLN37OtLaxvzewd99oEmhnkYaUuSV4D51b5YCxldKKF8qnZTuU3V7A
         yz2bIY0kTeZASVS6noff69ajZvBZ3t9d5+mREAZQm3vVvQVTS2941PujseN7eFsU6HTE
         lk0vTJGmwsJe7MTJWB13RwiqxhNUf1Qy0h4CkOky5/MBJfsldB0ow5xcUySRGeieQ8KQ
         EdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=AopLUumd1oP3C4JH4MOyeuojCVomrApkWKKCnfDQENc=;
        b=PQ1GYcK25RoLo78s2pxt8O8oViswv5wAKu4FxXDgeTFkadVmWsZcFKX4ZqlFcGIu/x
         VmhTp8l4bQodQ4CyAp+T//FVQRm5Ct3f7cjBCjk+zlLXJMgTWnk+xIBemPfEca7tMcgs
         nPi5dHg+pehnDTFGmsuKLaDVQe1EXnK32D+qfCDKqZ3dNK48GVEdLQU7QoXXFbdFo4j+
         vyDi8SoIvfWCpaJhpPpuJ4LPuLU6syoUu9kr+pgFYaVTYcD4L/Spi1nMVoe7euCSSzUo
         LsaAF1BFWvGNGBKDYFjvBdkOTSS3ShA4Za4oQzDLtU6tTfL8QQ06LbTDchcmR8N0+QXs
         RHyQ==
X-Gm-Message-State: AOAM530g5Ec5SnqeCszfBtTw3WEfNgTvhzp87nCNYFFPWI2FzCMkWLZB
        WfAVaWOAfkFAwouWaUQOs/bSXrJ+Gsh3/A==
X-Google-Smtp-Source: ABdhPJzo1ms9m1ZE+fGfJkkAuzjgnlBz71nAb+7HZ5xXa9TnQHO+ikZv+s3+ssRAE/csLvDu/uf5dA==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr373301wmc.110.1595434103778;
        Wed, 22 Jul 2020 09:08:23 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id z63sm234972wmb.2.2020.07.22.09.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:08:22 -0700 (PDT)
Subject: Re: [PATCH] fs: Return EOPNOTSUPP if block layer does not support
 REQ_NOWAIT
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-aio@kvack.org
References: <20181213115306.fm2mjc3qszjiwkgf@merlin>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <833af9cb-7c94-9e69-65cb-abd3cee5af65@scylladb.com>
Date:   Wed, 22 Jul 2020 19:08:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20181213115306.fm2mjc3qszjiwkgf@merlin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 13/12/2018 13.53, Goldwyn Rodrigues wrote:
> For AIO+DIO with RWF_NOWAIT, if the block layer does not support REQ_NOWAIT,
> it returns EIO. Return EOPNOTSUPP to represent the correct error code.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/direct-io.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 41a0e97252ae..77adf33916b8 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -542,10 +542,13 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
>   	blk_status_t err = bio->bi_status;
>   
>   	if (err) {
> -		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
> -			dio->io_error = -EAGAIN;
> -		else
> -			dio->io_error = -EIO;
> +		dio->io_error = -EIO;
> +		if (bio->bi_opf & REQ_NOWAIT) {
> +			if (err == BLK_STS_AGAIN)
> +				dio->io_error = -EAGAIN;
> +			else if (err == BLK_STS_NOTSUPP)
> +				dio->io_error = -EOPNOTSUPP;
> +		}
>   	}
>   
>   	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {


In the end, did this or some alternative get applied? I'd like to enable 
RWF_NOWAIT support, but EIO scares me and my application.


