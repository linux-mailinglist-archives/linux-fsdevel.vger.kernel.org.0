Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351C26F8B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgIRIw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRIw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:52:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8562C06174A;
        Fri, 18 Sep 2020 01:52:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n25so4442122ljj.4;
        Fri, 18 Sep 2020 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=asjClMEVQUugwRnuiCaRpILyUTB6qCyLua353zU0XaA=;
        b=W/z/lqMIRm38/rH5hoC1y6v6zRQO1N/LODV5dyUEiJu3Z0Ysqlp/3+8L1e9rLDMk2m
         sBItJh8qIyGYm03eIK0hTdBoxXVBw4cghdDiPSwhWAZoWgfzs33gNea15pJClLwx2PyP
         hHZXDHkjh03U3WZVcKBTqEHufGASOVouVB4m7BE5RIoKEh2joN3kIYcDTDJq0Chrbk2i
         J/NdgDEshJe1yWvUgaAnM4jfYus4kL1oPcAFg4fuHOSe5l7mwswJJ6COScNBGhNcGGPN
         q/gR4vXJlWd2ZXlKnLgsRNsC12UFA86our5/zZc8O5yxXBZ6W0BJN8M0aPB9fejtttXs
         Ecww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=asjClMEVQUugwRnuiCaRpILyUTB6qCyLua353zU0XaA=;
        b=bPGMdLSNGpN+eR9u0Fl1QDq/0v79LoG8B97Tw1jVC8CNpOvFs8jWZuY4atGcXXcyfe
         s+OFC8sn/4DOnzifzBczsa9rC7ZwEf7pMNEbAN545w2VVBbQbqwPGMPw2t4clTNFPw5I
         eQFp30PFhmnGQGoa0vKzhwfFyH1HhmjcEdSXBonhaAF8IrA82MvORwueUdl9vvZKpt+4
         YY47lzll5sQ8CMO78s7UKjRthA9CvUd9hfOmHfZzOaxIZwHekwL0HnjFhhv0xEAnO32k
         H8XAs3VNwCgraBWmrfu1RUgQoavdjfXdg8P0DEen5FuWug1pLvdKHJbrmIibj1Oxp8hh
         hStg==
X-Gm-Message-State: AOAM531X8clfpj3CiIKTNYJmczYVSI3k8dz6gF1VICKfVCd9QRKmjQNq
        xV7PQ9i9jXLH3TM78Jk8AEo1eJ2NV4BV+A==
X-Google-Smtp-Source: ABdhPJy1RlFuj0xDkan2bS2ZV4OPmRHWdA9YyD0WopBAfX+NGu2O9O4BkfmuLbcTQkb9zURbzOO0Aw==
X-Received: by 2002:a2e:a48c:: with SMTP id h12mr12544381lji.221.1600419176113;
        Fri, 18 Sep 2020 01:52:56 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:44fb:767f:35b0:3244:6cdc:c4a2? ([2a00:1fa0:44fb:767f:35b0:3244:6cdc:c4a2])
        by smtp.gmail.com with ESMTPSA id u1sm459692lfu.24.2020.09.18.01.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 01:52:55 -0700 (PDT)
Subject: Re: [PATCH 02/14] block: switch register_disk to use
 blkdev_get_by_dev
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <20200917165720.3285256-1-hch@lst.de>
 <20200917165720.3285256-3-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <091931b1-eb9c-e45e-c9e8-501554618508@gmail.com>
Date:   Fri, 18 Sep 2020 11:52:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917165720.3285256-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 17.09.2020 19:57, Christoph Hellwig wrote:

> Use blkdev_get_by_dev instead of open coding it using bdget_disk +
> blkdev_get.

    I don't see where you are removing bdget_disk() call (situated just before
the below code?)...

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 7b56203c90a303..f778716fac6cde 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -732,10 +732,9 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>   		goto exit;
>   
>   	set_bit(GD_NEED_PART_SCAN, &disk->state);
> -	err = blkdev_get(bdev, FMODE_READ, NULL);
> -	if (err < 0)
> -		goto exit;
> -	blkdev_put(bdev, FMODE_READ);
> +	bdev = blkdev_get_by_dev(disk_devt(disk), FMODE_READ, NULL);
> +	if (!IS_ERR(bdev))
> +		blkdev_put(bdev, FMODE_READ);
>   
>   exit:
>   	/* announce disk after possible partitions are created */

MBR, Sergei
