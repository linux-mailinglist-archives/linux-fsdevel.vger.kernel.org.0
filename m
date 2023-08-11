Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D603C77995E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjHKV0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 17:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjHKV0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:26:07 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C32684;
        Fri, 11 Aug 2023 14:26:02 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5655f47ae3fso1418353a12.1;
        Fri, 11 Aug 2023 14:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789161; x=1692393961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkael3S2pdg/VfM2aJEaWso36Tz2Khr7pAvSvEHl94s=;
        b=Sh4HHYe/Rz/dg/H5o717KaXy0D1F/lfULPWTBy/iqDBt/PK8CxPRi7Ttwu2mHTvD3g
         YsweqgxQBV+Kw3CVCWotszr6Hih2NFcMaR+gNUGGOu7XRRPaIwU4kmeUlB6QIJi+MEII
         GZ1LGfQ8TgpYz/vgeSilmQRKSqLzAQxC6QM+3WW24NgyB0waYrvhmaP6fxlAy60gcuOv
         V5fgmjFZ7a5A+rL4cNVLMf1K8i25UmlstL9CyFFdzAWSXm74Ik1iXcultXSUd9LUiFqv
         AnWOmS0WzDpUaI8DE5QIv45/SV4jCGmLnoM2VgvbyKlvFDVcGpC2gNqHMgLr7rKDHvku
         cX5w==
X-Gm-Message-State: AOJu0YykkXoEGgu8ZFQqwNZaul1Qf4M2keTOZx0FH+SR9d4RT3YiDmyG
        0G6xfQ8QlaAs/RspdwIa4uY=
X-Google-Smtp-Source: AGHT+IGvgfv1o9rzwDcunf/qZS4YYopLpr1rFa2hIc4fQs8fXgSIMEA6km+8Z6cMKCMBJqWea0/OGQ==
X-Received: by 2002:a17:90a:bd95:b0:26b:ab3:493a with SMTP id z21-20020a17090abd9500b0026b0ab3493amr2567330pjr.16.1691789161399;
        Fri, 11 Aug 2023 14:26:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001bd41b70b60sm4386849pls.45.2023.08.11.14.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:26:00 -0700 (PDT)
Message-ID: <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
Date:   Fri, 11 Aug 2023 14:25:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
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
 <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-3-nj.shetty@samsung.com>
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
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0bad62cca3d0..de0ad7a0d571 100644
> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
> +		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
> +}
> +

The above function should be moved into include/linux/blk-mq.h below the
definition of req_op() such that it can use req_op() instead of 
open-coding it.

Thanks,

Bart.

