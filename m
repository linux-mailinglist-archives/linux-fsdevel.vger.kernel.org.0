Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842D926294D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIIHxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgIIHw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:52:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05F0C061573;
        Wed,  9 Sep 2020 00:52:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so2250111ljk.8;
        Wed, 09 Sep 2020 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yVb2e282hdQLrLNJBNJnpxjhygO2ulaSK5Qta1nt9i4=;
        b=V33VD2Bb8Ip+WebEyfnQv1anRM4DsXTVmLZ7UG6OdWG/VA0/t9rUFMdrGahlSJRz0P
         ASJxKJ6tiYV8ZZKpgdOIQt5qoCMpWGCz4qrNCYQiKvsZ5J3XW0mnWY7kJdXgFmDLN0mL
         IjWveowF7IFmjnJxhzzpoDqwELXv6XjEffk+VIhnkUsiXmYnFIR6RjW47UCtlJz2Xxnx
         dNNJpZsnjc6/r2FHH24hC9J/Dx3SFNO8w6bf9B4dEpOGkoe7FXOFVKfAHxOtnIHDKl5n
         nuXH3dqSrnigC7w/C+ZQvV1tuqoKR923O8U0Gz2uNHQAaKb4mmvXdYxYSf3Pu/HEKGVF
         k7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yVb2e282hdQLrLNJBNJnpxjhygO2ulaSK5Qta1nt9i4=;
        b=XrqiSO2TWB5QTv8FRh2hmprnBSkFa4ozJHRSVyENVjXft0oTdTsXdgZKFj3RPdT9J5
         aNLtwA44wCRYTnxUAQcYpZoLk7aFZqgR/jLRStmMD0Pl63UoPiRqd4xKOZvgo46DMK6o
         qd8T1tJiMPoNsLl26noujLKJRBFznYGvc8OxvOehMUWOVFHiHGZVDf2BNV/fyg9pgxzR
         WTTuY6D1RcQQYiR6ffPDCvOe58Dw3rhtFN0mvMcV188VVpmPqn4uIS3dyZMZXWHffzXy
         F5www2yHWHB14sScULmu6rdtM9qUC876YjtRxsam5jxeKG1vpGbVytCFgcVHkPd1iRd1
         gItg==
X-Gm-Message-State: AOAM531ZZ+/KWaqnFlqYP3Ky2hCrvOmtemcl+/gnIjX6yqSgI5oyyyw4
        2AQt29sEdeDCheGdnEV4qnqcA4J4GE6VDg==
X-Google-Smtp-Source: ABdhPJxdOqw2y2E84GnrvUgPx4Wu/D8bPg+SVh1Tju19gcvcov5tEsIOa3Lw+N4xZh0hT6Djx969PA==
X-Received: by 2002:a2e:a418:: with SMTP id p24mr1289871ljn.205.1599637977185;
        Wed, 09 Sep 2020 00:52:57 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:290:64e3:f5dd:84ac:70b0:5629? ([2a00:1fa0:290:64e3:f5dd:84ac:70b0:5629])
        by smtp.gmail.com with ESMTPSA id s11sm530099ljh.56.2020.09.09.00.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 00:52:56 -0700 (PDT)
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
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200908145347.2992670-1-hch@lst.de>
 <20200908145347.2992670-17-hch@lst.de>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <31787d3e-05d2-3601-a88b-3c1ba5933f48@gmail.com>
Date:   Wed, 9 Sep 2020 10:52:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908145347.2992670-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.09.2020 17:53, Christoph Hellwig wrote:

> Switch to use bdev_check_media_change instead of check_disk_change and
> call sd_revalidate_disk manually.  As sd also calls sd_revalidate_disk
> manually during probe and open, , the extra call into ->revalidate_disk

    Too many commas. :-)

> from bdev_disk_changed is not required either, so stop wiring up the
> method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
[...]

MBR, Sergei
