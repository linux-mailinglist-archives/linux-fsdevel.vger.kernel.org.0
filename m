Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF32F7B865C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjJDRWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJDRWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:22:31 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64214D8;
        Wed,  4 Oct 2023 10:22:28 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c4d625da40so37896a34.1;
        Wed, 04 Oct 2023 10:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440147; x=1697044947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrSFuIFom3a3FCpBLPqbU0TDngZDytGzCb9fcci2Vps=;
        b=L6ZW01o76NttKXwgElopu/dVoC6/zWfwOsAWYmeeezPmUecjm1rvJ/NpPMR/wJ73Mt
         10HbUcI8CHx0AsBgrGcwvoScEdPDhWwoWaQnAcgSNEo73rDS0phSI37alsqgRRWTEDBu
         4C4s/0CapCuMbkoDnGjZs96ryZZ5iuHYrHcB/yBt40hdmWxm6vlPbx8XR92Mmjyy0y8v
         R48Wv5O3Z0wFAoOn8vMKVqkbc0GwuozM3flnCGyaCM/DVOYEdtxr5y3EBwjqLPuFnJQC
         WFS4Q0NTQdXgJOasLL/hHIfXjArWw6Nbg+BtWMOMW/wFI0V4WVy+U2ycW6GLREe2bZS7
         sQZg==
X-Gm-Message-State: AOJu0YwvAw0cd3zk7BOgbs5C2+RvqCdFXgOEV0FOMTxEXEy4a/sko14H
        H59kWymZgoxo9iVzq6FPKqw=
X-Google-Smtp-Source: AGHT+IFwPyh3g7K1zFFS2K1tx2oSQ5TBcHsOPmaP77rA8BiXr0rEAmLGpZb5/vvrvCmoSVs2TDMIpQ==
X-Received: by 2002:a05:6358:7f15:b0:143:786b:3de5 with SMTP id p21-20020a0563587f1500b00143786b3de5mr3022855rwn.9.1696440147475;
        Wed, 04 Oct 2023 10:22:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id t19-20020a63dd13000000b0055c178a8df1sm3537955pgg.94.2023.10.04.10.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:22:26 -0700 (PDT)
Message-ID: <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
Date:   Wed, 4 Oct 2023 10:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/3/23 19:53, Martin K. Petersen wrote:
> 
> Bart,
> 
>> I'm still wondering whether we really should support storage
>> devices that report an ATOMIC TRANSFER LENGTH GRANULARITY that is
>> larger than the logical block size.
> 
> We should. The common case is that the device reports an ATOMIC
> TRANSFER LENGTH GRANULARITY matching the reported physical block
> size. I.e. a logical block size of 512 bytes and a physical block
> size of 4KB. In that scenario a write of a single logical block would
> require read-modify-write of a physical block.

Block devices must serialize read-modify-write operations internally
that happen when there are multiple logical blocks per physical block.
Otherwise it is not guaranteed that a READ command returns the most
recently written data to the same LBA. I think we can ignore concurrent
and overlapping writes in this discussion since these can be considered
as bugs in host software.

In other words, also for the above example it is guaranteed that writes
of a single logical block (512 bytes) are atomic, no matter what value
is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.

>> Is my understanding correct that the NVMe specification makes it 
>> mandatory to support single logical block atomic writes since the 
>> smallest value that can be reported as the AWUN parameter is one 
>> logical block because this parameter is a 0's based value? Is my 
>> understanding correct that SCSI devices that report an ATOMIC
>> TRANSFER LENGTH GRANULARITY that is larger than the logical block
>> size are not able to support the NVMe protocol?
> 
> That's correct. There are obviously things you can express in SCSI
> that you can't in NVMe. And the other way around. Our intent is to
> support both protocols.

How about aligning the features of the two protocols as much as
possible? My understanding is that all long-term T10 contributors are
all in favor of this.

Thanks,

Bart.
