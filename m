Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0972CD0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjFLRkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbjFLRj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:39:58 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E26134;
        Mon, 12 Jun 2023 10:39:54 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2568caabfbfso2438006a91.3;
        Mon, 12 Jun 2023 10:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591593; x=1689183593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqrcW7dKqDqh3X1XpUeD4qSVl2OIxugj8mzYiL/6NUY=;
        b=Q95VeUju/ofp5ypVQgj88o8p0gbKIy6FYENT8QpF/u+mSbdpasG1DRydE6BTl4zfFR
         nY3M92bh048ULKxgMitmAimtexF+GXanLSMMGPAJu5CLR4t3brRKJvgE7TMq5qmu4zLH
         eGU79tl4rXFVmp/YdsNIvLWquUZnv14bPTrF+NH1jWXx8UBXA0wX3fyC9FtNFRsBQe4/
         1t9j7tyG6bbWkZRTEqACD8s+kumM1hIfp0X40p6imbtxScQ+adRobHSwJ3X/UZzhOaOc
         HqMn4K1EwBwhIYdLTlG/IRkd8KPNJdWYwQPvbWJi5W3kAbznnLwVtahg0pPhN6hqDz99
         4oGw==
X-Gm-Message-State: AC+VfDwwJCjP6Tk3pfS+z5iBp+JzLIZKF1K558kFwL4b5r/AZ3lmoiGu
        EfKixXMIRGPcUKWXAyFf2g4=
X-Google-Smtp-Source: ACHHUZ55fwWltcVU/4TIaIKtet3ye+yw8pX7D0kp6PmrZCInBSOH4wrjDftV/ZQGwhGwGj3MuvIaWA==
X-Received: by 2002:a17:90a:5a04:b0:25b:e747:103 with SMTP id b4-20020a17090a5a0400b0025be7470103mr3060607pjd.26.1686591593092;
        Mon, 12 Jun 2023 10:39:53 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ep11-20020a17090ae64b00b00255e2d5d56csm7674854pjb.1.2023.06.12.10.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:39:52 -0700 (PDT)
Message-ID: <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
Date:   Mon, 12 Jun 2023 10:39:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230612162545.frpr3oqlqydsksle@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/23 09:25, Jan Kara wrote:
> On Mon 12-06-23 18:16:14, Jan Kara wrote:
>> Writing to mounted devices is dangerous and can lead to filesystem
>> corruption as well as crashes. Furthermore syzbot comes with more and
>> more involved examples how to corrupt block device under a mounted
>> filesystem leading to kernel crashes and reports we can do nothing
>> about. Add config option to disallow writing to mounted (exclusively
>> open) block devices. Syzbot can use this option to avoid uninteresting
>> crashes. Also users whose userspace setup does not need writing to
>> mounted block devices can set this config option for hardening.
>>
>> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
>> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Please disregard this patch. I had uncommited fixups in my tree. I'll send
> fixed version shortly. I'm sorry for the noise.

Have alternatives been configured to making this functionality configurable
at build time only? How about a kernel command line parameter instead of a
config option?

Thanks,

Bart.

