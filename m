Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1855E56412E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiGBPp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jul 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGBPp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:45:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57407E021
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Jul 2022 08:45:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v126so5030421pgv.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Jul 2022 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L8uRugG259ow8lB/6bwsm0wXpVSdlTgfQOD2OG9pVM8=;
        b=a/URZv0YNXb2JWskKUnMyYGVCaH6eKzyZwpc+VgRXHWz/jzXEiLkoavTAyEgqjAWV9
         aJW8AovEsvGt6N7ooM0r5auDchH69iKhsMCgHsUA3fKlUHEvpgurobUhtD822xWQSuy1
         77CxWfdpadYYgjBuG7GtcIGo9LgUIFjNo9SyBiYK30dGeQi7sKwrzJns84oLmrOrTPKZ
         M3IOkY0F6xnF6h5dfY/GJpMt9xVLNu1g/DvssHfLlP16vcBRtG0OECQrfpbJUI4zuCTP
         wQISiIS9W/hVSgvH51xKPp+T+A7V2VkqcckJKEm9TMPZAhwsb2TzzDMV7/QDMogNrAPt
         spnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8uRugG259ow8lB/6bwsm0wXpVSdlTgfQOD2OG9pVM8=;
        b=iy+TUKXTQHwB1TqFR+bnWbr58i//DE9+zj1pXb+QqdnCBLwxJLWDcdKkd0Bv1GpDsZ
         /o/zqF8phR+iQT3lr2wzOeHa7P2NISgniLPasterKftGcXLun3D9mN6mEjGQFQpb4XoP
         8o5PdSEf/1QcxZUB8+sMgJA1LB0fkXraVqsLsV8WrJXTTgS+OxH7kIYlvOCaEm/uybsp
         KCkTHho/BJh5J/YbiNbifQYCDOWxd8WaHW3GH/2L8EfLrwL0D0lcbzzhjC3X01R1tZuz
         F4ZunDNi5I49EQNJgJx9BlZzOFBlKfVB7RYUca/tZgoD8Gpt8dyyJNYSfe+xFVBbbVmU
         Zw5g==
X-Gm-Message-State: AJIora/wIQ1FYDLTb9FjJ02Y0Z6nTU2zLENBXm0TcaXH3RFqD0hVgPe5
        9PPpX2RpUvNJFC3GumjrUBup4w==
X-Google-Smtp-Source: AGRyM1uoCqB3+qSGT7jodAAtPjFmzXlE/CkwxVYh/uP7bk8sUaXS+NqiuWZHyBTBR9YBmP7RdH/yXw==
X-Received: by 2002:a63:548:0:b0:412:1de7:89e0 with SMTP id 69-20020a630548000000b004121de789e0mr1097416pgf.373.1656776724772;
        Sat, 02 Jul 2022 08:45:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b001eee6b107fasm8708693pju.39.2022.07.02.08.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 08:45:24 -0700 (PDT)
Message-ID: <5cfdd462-d21b-cb62-3ad3-3ecd8cbc0a31@kernel.dk>
Date:   Sat, 2 Jul 2022 09:45:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fs: allow inode time modification with IOCB_NOWAIT
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stefan Roesch <shr@fb.com>
References: <39f8b446-dce3-373f-eb86-e3333b31122c@kernel.dk>
 <Yr/gFLRLBE76enwG@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yr/gFLRLBE76enwG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/2/22 12:05 AM, Christoph Hellwig wrote:
> On Fri, Jul 01, 2022 at 02:09:32PM -0600, Jens Axboe wrote:
>> generic/471 complains because it expects any write done with RWF_NOWAIT
>> to succeed as long as the blocks for the write are already instantiated.
>> This isn't necessarily a correct assumption, as there are other conditions
>> that can cause an RWF_NOWAIT write to fail with -EAGAIN even if the range
>> is already there.
>>
>> Since the risk of blocking off this path is minor, just allow inode
>> time updates with IOCB_NOWAIT set. Then we can later decide if we should
>> catch this further down the stack.
> 
> I think this is broken.  Please just drop the test, the non-blocking
> behavior here makes a lot of sense.  At least for XFS, the update
> will end up allocating and commit a transaction which involves memory
> allocation, a blocking lock and possibly waiting for lock space.

I'm fine with that, I've made my opinions on that test case clear in
previous emails. I'll drop the patch for now.

I will say though that even in low memory testing, I never saw XFS block
off the inode time update. So at least we have room for future
improvements here, it's wasteful to return -EAGAIN here when the vast
majority of time updates don't end up blocking.

One issue there too is that, by default, XFS uses a high granularity
threshold for when the time should be updated, making the problem worse.

-- 
Jens Axboe

