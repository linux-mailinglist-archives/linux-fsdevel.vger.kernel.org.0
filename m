Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75E07B3937
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjI2Ryn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2Rym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:54:42 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A4919F;
        Fri, 29 Sep 2023 10:54:40 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-690d2441b95so725333b3a.1;
        Fri, 29 Sep 2023 10:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010080; x=1696614880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9/9Gv0T5SqN4UKcP3WTfyU63gOyTEvwA+tYFqPn6v4=;
        b=Aqrvk8M2ByaNlCu2DS+ieBqjgw4UHpV2wDuMiBIR5+dqCDRU5tJHMNFWHiukTJNwf9
         0cGC0X6ga2W47xi0H7+YMsfv4v1xqScn8qv5CSIfjDQhhNldbJrnbjuIpoJXMn0aUHOE
         8m1Hd6ySt40rhE+nvc8KVXXXIM1L80GsrvhXD3iXTpA9Jko0ILNaviufVoF/OHEzw6F5
         wYhiWfuWRoK6Eb8YiviLGQNvlSQKQZGUSYzWGlAlMXLpFw826b/0Awv4VlqdQprMwDn3
         /VC7qTFPov7DFGnXb98Hi8zumm/gUZ+l8ZFz7LVZOX0TE0rIs67st96OICmyFW0dtJpF
         ySqw==
X-Gm-Message-State: AOJu0Yz2X8b73a5XuK2Bm63JyjHFej8vrQJBUWB5u4gvvvsvs5AUc6Wt
        AOlmGF61LMys33lDiLSkER4=
X-Google-Smtp-Source: AGHT+IF7T70L+W8FzWQ7S9Hp4H3npZwWUK6+DQgaST+LZ35UudBV+LIK350rWU8eXdmjL58O/JFyrA==
X-Received: by 2002:a05:6a00:2d96:b0:68a:582b:6b62 with SMTP id fb22-20020a056a002d9600b0068a582b6b62mr6846347pfb.7.1696010079849;
        Fri, 29 Sep 2023 10:54:39 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b0068620bee456sm15197789pfo.209.2023.09.29.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 10:54:38 -0700 (PDT)
Message-ID: <2e5af8a4-f2e1-4c2e-bd0b-14cc9894b48e@acm.org>
Date:   Fri, 29 Sep 2023 10:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] scsi: sd: Support reading atomic properties from
 block limits VPD
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-19-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-19-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/23 03:27, John Garry wrote:
> +static void sd_config_atomic(struct scsi_disk *sdkp)
> +{
> +	unsigned int logical_block_size = sdkp->device->sector_size;
> +	struct request_queue *q = sdkp->disk->queue;
> +
> +	if (sdkp->max_atomic) {

Please use the "return early" style here to keep the indentation
level in this function low.

> +		unsigned int max_atomic = max_t(unsigned int,
> +			rounddown_pow_of_two(sdkp->max_atomic),
> +			rounddown_pow_of_two(sdkp->max_atomic_with_boundary));
> +		unsigned int unit_min = sdkp->atomic_granularity ?
> +			rounddown_pow_of_two(sdkp->atomic_granularity) :
> +			physical_block_size_sectors;
> +		unsigned int unit_max = max_atomic;
> +
> +		if (sdkp->max_atomic_boundary)
> +			unit_max = min_t(unsigned int, unit_max,
> +				rounddown_pow_of_two(sdkp->max_atomic_boundary));

Why does "rounddown_pow_of_two()" occur in the above code?

Thanks,

Bart.
