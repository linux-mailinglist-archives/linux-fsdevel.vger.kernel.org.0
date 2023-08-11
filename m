Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F97799FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbjHKV4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbjHKV4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:56:20 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2111271E;
        Fri, 11 Aug 2023 14:56:19 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a76cbd4bbfso2242946b6e.3;
        Fri, 11 Aug 2023 14:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790979; x=1692395779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prWD167naOCUGhV8W2UI57hYvdDYVXZgEtS8e+7g7BM=;
        b=NnwIXpjH2G1ogfeuta663ZOrvhhybZwPicogZtJH4rAPg7P4scGlZKBzjFXNebnXkA
         B1JlhpAs0Ny+XS/9S3YyL+rOKsDno3IW+wq7jSIXRRWgxJ9AwvgAic5Ie8GmFK47CMOA
         fQMwpsI9LbzMlR65TwFKV+IiBv/Hv+8fuCnnxR4ITXvfmIpuKWflDmZ3ZR2dEFPi0Nvn
         vsjZS7VVHl/sYT9kCBoqL0JtBkXPxjDMD5X1F350/nLkoddfRBzalzaSvRUuGblvaa4B
         5S31c8v0CNBOdrCuJYRbB44qD/XImruPgl4L0KuJTS9Z/NGMo5Nr7b6atTbAkzcWRilA
         bP4w==
X-Gm-Message-State: AOJu0YypsQeyzofJJhua4zHIr9TAf4ars1YOrtwGodeX/T4jHrIcwoFl
        as0sPhg6H7Yh6uYdkcBS6YQ=
X-Google-Smtp-Source: AGHT+IFRmGiyvXV1VwlJ9tihqgTvBvrZ8iEiMT6ZbT0wpIrAxLL1zr/ocUv96iLtdTj5E+o7MmHKDw==
X-Received: by 2002:a05:6358:290f:b0:132:d07d:8f3b with SMTP id y15-20020a056358290f00b00132d07d8f3bmr3326632rwb.28.1691790978966;
        Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id c6-20020a17090a674600b0026b25c05495sm1808427pjm.20.2023.08.11.14.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
Message-ID: <170b68ca-b24c-0723-cc54-7fcdc9004bcc@acm.org>
Date:   Fri, 11 Aug 2023 14:56:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 01/11] block: Introduce queue limits and
 sysfs for copy-offload support
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
Cc:     Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
        linux-doc@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1@epcas5p4.samsung.com>
 <20230811105300.15889-2-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/23 03:52, Nitesh Shetty wrote:
> +/* maximum copy offload length, this is set to 128MB based on current testing */
> +#define COPY_MAX_BYTES		(1 << 27)

Since the COPY_MAX_BYTES constant is only used in source file
block/blk-settings.c it should be moved into that file. If you really
want to keep it in include/linux/blkdev.h, a BLK_ prefix should
be added.

Thanks,

Bart.
