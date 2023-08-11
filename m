Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B857799E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjHKVuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 17:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjHKVuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:50:55 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1755E271B;
        Fri, 11 Aug 2023 14:50:55 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bc0d39b52cso16819215ad.2;
        Fri, 11 Aug 2023 14:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790654; x=1692395454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrI+uxp3aYoFCrzZoU6uRvoRMnje8fjhUyPHKIqWtFA=;
        b=atiQDcbEW7PE118c8LmB0JiNf1VT4ABHmvfctYqPOZZYMReiWsIv+WxZ7CY5aXq3/h
         sQ+SCxBmtXZSqMQpoqX3LbRyWwUxzfeY3AqWO1qs6j8T39YCLJ+9rcN5CXusLfrhkW6U
         aTPMoHrrHecYxWbVp2ZH+PjBevXXVjUwKbMZCnq5sN9q8C+0UeFt7ZZUs88nWrKfeSYr
         UuwuMcTv8pRupD+oJKjSILuuMo55E0eEGsmZxjACXCGTBI8GLxsZOnVB+2+S879ipB9G
         YhWYSljSnsfXrUAWqfDfJMe+L1xH+QuNCyoAFBO/ohAJqXjfSqEI+UUf6plsA05VibLQ
         hXnw==
X-Gm-Message-State: AOJu0YwcZaXnKSsVfbRXWGQT9iCm6BbKlnieGWthzsdcG52hb8NVwVho
        oilbhABMtjI+nUM5JZARAng=
X-Google-Smtp-Source: AGHT+IF8U+lGorQ6rte8/N0gRF/coyHYDMaevJEd+XYzOy0jSGnPMMJg+8prLKGskrtcXvIzIdxvzA==
X-Received: by 2002:a17:902:ab5a:b0:1bd:bfc0:4627 with SMTP id ij26-20020a170902ab5a00b001bdbfc04627mr1837548plb.40.1691790654475;
        Fri, 11 Aug 2023 14:50:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d30100b001b85bb5fd77sm4388437plc.119.2023.08.11.14.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:50:54 -0700 (PDT)
Message-ID: <2cc56fb5-ddba-b6d0-f66b-aa8fffa42af0@acm.org>
Date:   Fri, 11 Aug 2023 14:50:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 00/11] Implement copy offload support
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
        gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        mcgrof@kernel.org, dlemoal@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <CGME20230811105627epcas5p1aa1ef0e58bcd0fc05a072c8b40dcfb96@epcas5p1.samsung.com>
 <20230811105300.15889-1-nj.shetty@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/11/23 03:52, Nitesh Shetty wrote:
> We achieve copy offload by sending 2 bio's with source and destination
> info and merge them to form a request. This request is sent to driver.
> So this design works only for request based storage drivers.

[ ... ]

> Overall series supports:
> ========================
> 	1. Driver
> 		- NVMe Copy command (single NS, TP 4065), including support
> 		in nvme-target (for block and file back end).
> 
> 	2. Block layer
> 		- Block-generic copy (REQ_OP_COPY_DST/SRC), operation with
>                    interface accommodating two block-devs
>                  - Merging copy requests in request layer
> 		- Emulation, for in-kernel user when offload is natively
>                  absent
> 		- dm-linear support (for cases not requiring split)
> 
> 	3. User-interface
> 		- copy_file_range

Is this sufficient? The combination of dm-crypt, dm-linear and the NVMe 
driver is very common. What is the plan for supporting dm-crypt? 
Shouldn't bio splitting be supported for dm-linear?

Thanks,

Bart.
