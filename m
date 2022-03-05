Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFE44CE7D8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiCEX4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 18:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEX4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 18:56:35 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26F275C6;
        Sat,  5 Mar 2022 15:55:44 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id o8so10514700pgf.9;
        Sat, 05 Mar 2022 15:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fTFM0BLrFEzuVT+NEbfUfqIis6Wa5g9+pZvF27yAoQo=;
        b=0wPEynVrY/qqA66VbkSOcfZOqffVUei6/bpMorLd1561OW2IiV7qCvgejAuNCp//XQ
         3Hu6SOrZYdWHBX7EdOQ4Du9vn+6JFWLFbUgZ+B1oTz3qfVud5dNxxmaGjP6pt53irw0p
         jzlGjQzwSgjAFqZIfZTr7zfJIrb8SYeE0KAgGeRhmuyrJpMCgA55ZXNXh1qOA+pL003Z
         ZpfyXZt7aXOGVEnFlk+HRpehv1G6q/RORGylCfwhQkk/h4Cj6ksJb6C6+QSb3+hkLFZN
         BtD5QNnMTnSIpAmc0c4e2efmwusSuyevh8ndn3Z7CP/6aW8uNaMsdG6zo3gMZeAeKRIk
         sWnA==
X-Gm-Message-State: AOAM530jGjMJMuFF7TLyaCxrs4S7fVj/sCh01IcmZvw2FvA/FgX2CfPe
        4YvKFbnE44/UKhKO6wnGfoM8S3uWgqU=
X-Google-Smtp-Source: ABdhPJz5VvA3U2fLc1z+mBiMQ4u+RZgL1KkG+Po1/Fl96HJUah2jzC5KKpI11NFwskc9qjJ1fhfUsQ==
X-Received: by 2002:a62:cdc3:0:b0:4e0:e439:ed2d with SMTP id o186-20020a62cdc3000000b004e0e439ed2dmr5770274pfg.39.1646524543626;
        Sat, 05 Mar 2022 15:55:43 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f6519ce666sm10984217pfi.170.2022.03.05.15.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 15:55:43 -0800 (PST)
Message-ID: <535ff59f-cde0-caf4-6e47-a0f2db03261e@acm.org>
Date:   Sat, 5 Mar 2022 15:55:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, sagi@grimberg.me, kbusch@kernel.org,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220305214056.GO3927073@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/22 13:40, Dave Chinner wrote:
> On Sat, Mar 05, 2022 at 06:19:29AM +0100, Christoph Hellwig wrote:
>> On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
>>> AFAICT, this patch leaves just the f2fs allocator usage of
>>> inode->i_rw_hint to select a segment to allocate from as the
>>> remaining consumer of this entire plumbing and user API. Is that
>>> used by applications anywhere, or can that be removed and so the
>>> rest of the infrastructure get removed and the fcntl()s no-op'd or
>>> -EOPNOTSUPP?
>>
>> I was told it is used quite heavily in android.
> 
> So it's primarily used by out of tree code? And that after this
> patch, there's really no way to test that this API does anything
> useful at all?

Hi Dave,

Android kernel developers follow the "upstream first" policy for core kernel 
code (this means all kernel code other than kernel drivers that implement 
support for the phone SoC). As a result, the Android 13 F2FS implementation is 
very close to the upstream F2FS code. So the statement above about "out of tree 
code" is not correct.

Bart.
