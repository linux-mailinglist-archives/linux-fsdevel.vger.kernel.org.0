Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1EB5127CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 01:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiD0X4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 19:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiD0X4Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:56:16 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E310D;
        Wed, 27 Apr 2022 16:53:03 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id a11so2856822pff.1;
        Wed, 27 Apr 2022 16:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=79AFRdpemBVck+ntzsW/yKNt4PCLDqnjtmYL3oWIWPs=;
        b=ERcJuxmAuVgbsIaump8T8yEPXPmGlPPG52HX+9B0YG5/lQFHIRQgdZL8cL00zhpld4
         yNiFx7gcHa4YDjKwkCMxHpRCCkq23pphhzGNq7Hb201elKOqMDUPTFUmdPm/uaHGvI74
         PDSrGLdR1coRP5bkv5jgEDVfW9HjUATh7PRbd7RjSr5jzAWdyAtjVxO03mHfrtdwplq+
         j8OotbuRJSRX5MTpoRlQtTy/fojF7+qO1Foh6RWTErWYT/vlE0UnCqE5P8crMrXc7+eR
         YaJIPvT9hJQjbL8sszTuJYTh0Sz2diXEqdB/ds6nL6Twg2GtR/zYudC4ggykQdcRdOvm
         qdCQ==
X-Gm-Message-State: AOAM532Y/cRWaBh6IB0xGlkBN6dArvyvn8q1+Fjya5pe3HzJ3ZxZk6AU
        +1zOkBGdMmvb5RBxc0U81mQ=
X-Google-Smtp-Source: ABdhPJwSGv1Za1U51Sy0XzpwyxC0M8/mR/bjHPIzXDoe+MDiEfgeZRKytqp5jH37HlZvkYhAFK/M7Q==
X-Received: by 2002:a05:6a00:a94:b0:4fd:c14b:21cb with SMTP id b20-20020a056a000a9400b004fdc14b21cbmr32159218pfl.53.1651103583186;
        Wed, 27 Apr 2022 16:53:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6cbb:d78e:9b3:bb62? ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
        by smtp.gmail.com with ESMTPSA id w129-20020a628287000000b0050d4246fbedsm11710895pfd.187.2022.04.27.16.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 16:53:02 -0700 (PDT)
Message-ID: <df8104aa-ca86-4053-5334-3bc4ff786c61@acm.org>
Date:   Wed, 27 Apr 2022 16:52:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/16] block: add blk_queue_zone_aligned and
 bdev_zone_aligned helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me,
        damien.lemoal@opensource.wdc.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160258eucas1p19548a7094f67b4c9f340add776f60082@eucas1p1.samsung.com>
 <20220427160255.300418-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 09:02, Pankaj Raghav wrote:
> +static inline bool bdev_zone_aligned(struct block_device *bdev, sector_t sec)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_zone_aligned(q, sec);
> +	return false;
> +}

Which patch uses this function? I can't find any patch in this series 
that introduces a call to this function.

Thanks,

Bart.


