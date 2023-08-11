Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F680779977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 23:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjHKVdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 17:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjHKVdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:33:39 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABCC213B;
        Fri, 11 Aug 2023 14:33:39 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so18370815ad.1;
        Fri, 11 Aug 2023 14:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789618; x=1692394418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL47jFFvDt7OXD+hxa5Uxt7WguECwOQyvoULO24VUWQ=;
        b=Dh0MOfU1NkRojl0RuAjwAque2K16nkp4fsGy9S8iv9duyyy13UyYb586V03V1qiFra
         Fi4x4GGS95SngtDhXh6UUIVprop/rkcofl+MesL8ocnhqyP3kg8FfNrWtPy7pI6InWQ0
         ZL+f7UJ1FlWaCZPj2lb5Zk0ihCeHwpXUMsVL04fS1V2EzUIfBp+MsyUQHBCZEvSI36ci
         ThOEHjueCIx7fpqxqW8ZUIutn1O2NhHserpEIhf6cW596mdpyy5ygfeU6lpKy/bLr2WO
         XqvDB0w0t59MApxFAmKBuupRtPlUa7ppQblWEr3LElQwGDKeXBOVTqj7s0XP8siGYoqx
         jtsA==
X-Gm-Message-State: AOJu0YycKTyvF08+GxrxLzXTckuswGNTawIMte4/2SWyci1zs57LR+SV
        H3iWmW3hRzQF8y2Ps/GN/yk=
X-Google-Smtp-Source: AGHT+IGAmnk9VKQD1Jo/hqmiveT5ZuVgUoMRBZbu5CA4433fTlsSPS9CN76yfuE6JEcmMaoZvr7xdA==
X-Received: by 2002:a17:902:e809:b0:1bb:de7f:a4d4 with SMTP id u9-20020a170902e80900b001bbde7fa4d4mr3429993plg.61.1691789618406;
        Fri, 11 Aug 2023 14:33:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001bc87e6e26bsm4378373plm.222.2023.08.11.14.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:33:37 -0700 (PDT)
Message-ID: <0899ddc3-d9c1-3d9a-3649-2b1add9b2a7f@acm.org>
Date:   Fri, 11 Aug 2023 14:33:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-doc@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
 <20230811105300.15889-4-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/23 03:52, Nitesh Shetty wrote:
> + * Description:
> + *	Copy source offset to destination offset within block device, using
> + *	device's native copy offload feature.

Offloading the copy operation is not guaranteed so I think that needs to 
be reflected in the above comment.

> + *	We perform copy operation by sending 2 bio's.
> + *	1. We take a plug and send a REQ_OP_COPY_SRC bio along with source
> + *	sector and length. Once this bio reaches request layer, we form a
> + *	request and wait for dst bio to arrive.

What will happen if the queue depth of the request queue at the bottom 
is one?

> +		blk_start_plug(&plug);
> +		dst_bio = blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DST, gfp);

blk_next_bio() can return NULL so its return value should be checked.

> +		dst_bio->bi_iter.bi_size = chunk;
> +		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
> +		dst_bio->bi_end_io = blkdev_copy_offload_dst_endio;
> +		dst_bio->bi_private = offload_io;

Thanks,

Bart.

