Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163AA262936
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 09:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIHuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgIIHuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:50:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7AC061573;
        Wed,  9 Sep 2020 00:50:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r24so2285150ljm.3;
        Wed, 09 Sep 2020 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+eoBy/bwt6qKy1ZU0hQLUIIb2eFiZ29uRJfoY0zAIck=;
        b=M9Ywp41A+KsRDVsFPG6mUL2IKvRoQoehb0HspBt50pCHhLzboHNdhVGwGVEipw9wfJ
         7hZZSg+T3fmGnUNuwAkfEqUaTbXRuOm31dKLaSiLK026mhUTT/MrgXoeTzmOHzbYsFqm
         +A8i4gcA/t91nbljx6J9SSGkTYI6ynwT265Z3mOGFjpWNL9gaZ4VqBN67iae0YWqY2Qp
         uVEDfPiK0Fw4oHjuJLVVPz0sykxlu2UC+lgqHqRKtuH3CMZ8CJdzDYkUlzjTONJogZ9Q
         IHwXpYNPCNRByf2ynwQbgD+zOradLAKQbshX5mZ6mVJ8YryvtbQKQDlilS86zU1+4NWs
         iquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+eoBy/bwt6qKy1ZU0hQLUIIb2eFiZ29uRJfoY0zAIck=;
        b=QqERKsJI96CeBEoxw6Bk5ciGi6jStwSUemb4cjggUDMxM+zXfAdF51TzgIJcUgABwf
         5nwLRT3Lm5oBQwpBKrZxpz3qpRaGNI7s+BgErUAh9T0YeSn6lVktvAnc46/MYmFdo6ia
         feQplupQLNlO7YAfMDK5prVO8cmSmBX2/KKHg2WNMec9eBjC3Qtnqv34fwtXIXF7RjrJ
         X4zZ/lI8hHWzOmsOQsgLpegkL4/WqMBtbEV08IxGKRGbmuLSC2YDidUyeTWDlXovdFrp
         XvU7yj8c1noGKPVz3kW6TBTMsRKF8iwj+3iKvIkJsiRyZJPyp90ZZAJhxlAt72/Q59CT
         XsKg==
X-Gm-Message-State: AOAM530C5YlJZessBxek19VBWbX/xPbEg8sobBZeNMCaJtZKzCgzi4ng
        yOFLuT+j1keFsYeKtvvIIqWjx8duhcq3pA==
X-Google-Smtp-Source: ABdhPJwEA3XTx1gh59N0mVW4YGXuKKn+jsdBgABsdtOTBUZ1LgQuaosBlCBjZQ2p2fQTw9bkjzWHyA==
X-Received: by 2002:a2e:3215:: with SMTP id y21mr1180072ljy.52.1599637807929;
        Wed, 09 Sep 2020 00:50:07 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:290:64e3:f5dd:84ac:70b0:5629? ([2a00:1fa0:290:64e3:f5dd:84ac:70b0:5629])
        by smtp.gmail.com with ESMTPSA id z24sm403079lfe.54.2020.09.09.00.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 00:50:07 -0700 (PDT)
Subject: Re: [PATCH 07/19] swim3: use bdev_check_media_changed
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
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200908145347.2992670-1-hch@lst.de>
 <20200908145347.2992670-8-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <81bd0c24-81ec-c43f-5771-22fbe7b3dce4@gmail.com>
Date:   Wed, 9 Sep 2020 10:50:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908145347.2992670-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 08.09.2020 17:53, Christoph Hellwig wrote:

> Switch to use bdev_check_media_changed instead of check_disk_change and
             ^^^
    Using?

> call floppy_revalidate manually.  Given that floppy_revalidate only
> deals with media change events, the extra call into ->revalidate_disk
> from bdev_disk_changed is not required either, so stop wiring up the
> method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
[...]

MBR, Sergei
