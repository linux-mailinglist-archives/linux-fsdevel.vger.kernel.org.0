Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF955B11C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiFZKUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiFZKUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:20:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219A12614
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jun 2022 03:20:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so1369219edb.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jun 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zy1Ih5xnZLYR31pscqnLVprtiUwTUenQdef+MWxKKMA=;
        b=oBfck6+XscL2VeZ+MF8T02/Q0GkUoM1jN27mDG9zEwpHpTEFhiBjXDUOLSiVvUMvGM
         2sicpmI3J24iRKAA/5RxJuX+VnPWJOq0n/0CFMTZwa0ERpZlFUFFpw22CJ5BPYHwH0NF
         xzEehUBouX/IGDTkYFQ5Ev+S6CtOjASt8p1uYEBuekmHqcuo9NYiLJuBQ11SgTbV+s4Q
         h+eTO5wsRZUjz6KnScQnB5ClLMK88d5eMfaRvO0FBf2N/bHMRc5rTU2sCUNWnro6M8G+
         X6ErBcZ5i27Gmfz0rtcLWgvjPPhKS2RKwPNQrtAxFkITjgYwLdz6VFt3v67paBWA0AQH
         wxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=zy1Ih5xnZLYR31pscqnLVprtiUwTUenQdef+MWxKKMA=;
        b=uruhqukfz4Nlql6zzNrxGbcu2Zk3uu10+uA9R9N2B49+jlgW1u/XnOz/kbCkvlvrBl
         B6f3Nyf+gmTL8M2JOYfoAgy7MwBbnNRqTMHLr9Wlk3ZE8d7KHbEj/ZYQ5skTWp19Foum
         0CojQbDzVl6x43UV2EA+8XD9mo2wrfRsuk+sxr33spW3+/cTzA9wrb3N7IQbtENCeBkL
         vBFWyzxGmYsw348u/xa4YvPdxJI0BgyRuszMXDCmamtOeWY/zkVsj1TqrOED4wmPczYT
         nebLAOYmO2q7KH1vnVgAag+bqPI3PM1qcAxSrtMpxd2cwQA5sfI1Q0I0p1moDdo7KjuU
         2RWw==
X-Gm-Message-State: AJIora9CnKLtFVd/58QZ3SRtLEw2keOBjQ7MURrrLMPHJjNeCqD+NhB7
        PjjfK9sWhfhn33HZh/rovb3Ldw==
X-Google-Smtp-Source: AGRyM1tv3WbUrJipd2xn/7Heq9RfOQOWLVedSKXLcrr95zGLiEg/pzWHi319OrG4Zqw5VAKidmbPoA==
X-Received: by 2002:a05:6402:26d5:b0:435:aba2:9495 with SMTP id x21-20020a05640226d500b00435aba29495mr10073740edd.133.1656238825841;
        Sun, 26 Jun 2022 03:20:25 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906340400b0070abf371274sm3634422ejb.136.2022.06.26.03.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:20:25 -0700 (PDT)
Message-ID: <23067de5-7955-7f58-f8ad-70a812602ac8@scylladb.com>
Date:   Sun, 26 Jun 2022 13:20:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
 <6c06b2d4-2d96-c4a6-7aca-5147a91e7cf2@scylladb.com>
 <YrgOUw6YM2c6k59U@infradead.org>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
In-Reply-To: <YrgOUw6YM2c6k59U@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 26/06/2022 10.44, Christoph Hellwig wrote:
> On Sun, Jun 19, 2022 at 02:30:47PM +0300, Avi Kivity wrote:
>>> * stx_dio_offset_align: the alignment (in bytes) required for file
>>>     offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
>>>     on the file.  This will only be nonzero if stx_dio_mem_align is
>>>     nonzero, and vice versa.
>>
>> If you consider AIO, this is actually three alignments:
>>
>> 1. offset alignment for reads (sector size in XFS)
>>
>> 2. offset alignment for overwrites (sector size in XFS since ed1128c2d0c87e,
>> block size earlier)
>>
>> 3. offset alignment for appending writes (block size)
>>
>>
>> This is critical for linux-aio since violation of these alignments will
>> stall the io_submit system call. Perhaps io_uring handles it better by
>> bouncing to a workqueue, but there is a significant performance and latency
>> penalty for that.
> I think you are mixing things up here.


Yes.


> We actually have two limits that
> matter:
>
>   a) the hard limit, which if violated will return an error.
>      This has been sector size for all common file systems for years,
>      but can be bigger than that with fscrypt in the game (which
>      triggered this series)
>   b) an optimal write size, which can be done asynchronous and
>      without exclusive locking.
>      This is what your cases 2) and 3) above refer to.
>
> Exposting this additional optimal performance size might be a good idea
> in addition to what is proposed here, even if matters a little less
> with io_uring.  But I'm not sure I'd additional split it into append
> vs overwrite vs hole filling but just round up to the maximum of those.


Rounding up will penalize database workloads, with and without io_uring. 
Database commit logs are characterized by frequent small writes. Telling 
the database to round up to 4k vs 512 bytes means large write 
amplification. The disk probably won't care (or maybe it will - it will 
also have to generate more erase blocks), but the database will run out 
of commitlog space much sooner and will have to compensate in expensive 
ways.


Of course, people that care can continue to use internal filesystem 
knowledge, and maybe there are few enough of those that the API can 
choose to ignore them.


