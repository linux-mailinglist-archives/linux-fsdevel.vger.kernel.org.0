Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159C7BBE6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjJFSHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjJFSHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:07:39 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A27FD44;
        Fri,  6 Oct 2023 11:07:06 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-690ba63891dso2052999b3a.2;
        Fri, 06 Oct 2023 11:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615625; x=1697220425;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9EMLKlcv/CZV0HfxzZTVE5do7+8meEwi+9ls+XR7Lo=;
        b=L2KuJkJ1SGmnw4QkIbn5t3y+QKLz6RCXs+G7WEgHzMUP3x5vtq8ZwiqQqv5Ox9RLFW
         rCueiD5hfDOBtKAmnodJbV2+RZXGGeS0DSfl+R5q3LxQE3RRjQ/CyQOQ/wyPx/A7cZio
         RQrYRLB9ZkrbP1NvYz9l4/Enmd4Bxmsp1R3gDk1cqo3E7l6YjSSdsHuQj5pfBHKcdJLq
         YyfUxeIM7tcUWwRRKfWN+FqJf3FDb5bogSGIql+EWVutB6hJqTlR2MRnXmmX5Xc81G4k
         9ggmMUYAGGH4S5bRj3W1bmnBZ1PGH4P22jnuZdPjloeqqW7hSIdwgS6um10DER+l3SUs
         GBdQ==
X-Gm-Message-State: AOJu0Yyk+weymleOlTrVF8WO8zGlnDFIk9vTKle/KL9+WPRFKKWrVf3J
        gggMEqu4XtkN6xsWiMqAT78=
X-Google-Smtp-Source: AGHT+IEGzYVEUHi2QtaGXQzuP3HcQzAp1I/zk7dd7MyuyWhwrNemy0qnpGxr5tbyV25v/RioTKneEg==
X-Received: by 2002:a05:6a21:3397:b0:15d:c86d:27a6 with SMTP id yy23-20020a056a21339700b0015dc86d27a6mr9750234pzb.55.1696615624770;
        Fri, 06 Oct 2023 11:07:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0057a868900a9sm3586763pge.67.2023.10.06.11.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:07:03 -0700 (PDT)
Message-ID: <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
Date:   Fri, 6 Oct 2023 11:07:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/23 01:19, Damien Le Moal wrote:
> Your change seem to assume that it makes sense to be able to combine CDL with
> lifetime hints. But does it really ? CDL is of dubious value for solid state
> media and as far as I know, UFS world has not expressed interest. Conversely,
> data lifetime hints do not make much sense for spin rust media where CDL is
> important. So I would say that the combination of CDL and lifetime hints is of
> dubious value.
> 
> Given this, why not simply define the 64 possible lifetime values as plain hint
> values (8 to 71, following 1 to 7 for CDL) ?
> 
> The other question here if you really want to keep the bit separation approach
> is: do we really need up to 64 different lifetime hints ? While the scsi
> standard allows that much, does this many different lifetime make sense in
> practice ? Can we ever think of a usecase that needs more than say 8 different
> liftimes (3 bits) ? If you limit the number of possible lifetime hints to 8,
> then we can keep 4 bits unused in the hint field for future features.

Hi Damien,

Not supporting CDL for solid state media and supporting eight different
lifetime values sounds good to me. Is this perhaps what you had in mind?

Thanks,

Bart.

--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -100,6 +100,14 @@ enum {
         IOPRIO_HINT_DEV_DURATION_LIMIT_5 = 5,
         IOPRIO_HINT_DEV_DURATION_LIMIT_6 = 6,
         IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
+       IOPRIO_HINT_DATA_LIFE_TIME_0 = 8,
+       IOPRIO_HINT_DATA_LIFE_TIME_1 = 9,
+       IOPRIO_HINT_DATA_LIFE_TIME_2 = 10,
+       IOPRIO_HINT_DATA_LIFE_TIME_3 = 11,
+       IOPRIO_HINT_DATA_LIFE_TIME_4 = 12,
+       IOPRIO_HINT_DATA_LIFE_TIME_5 = 13,
+       IOPRIO_HINT_DATA_LIFE_TIME_6 = 14,
+       IOPRIO_HINT_DATA_LIFE_TIME_7 = 15,
  };


