Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D35FF101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJNPTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJNPTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:19:50 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063126AC3;
        Fri, 14 Oct 2022 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9FcX1J+0cwKyZaS3joif6Fb/FOBJClHbHVHQXJcliJM=; b=VzbzMei0aNMEABS5WXn1aLYbwp
        g+S1Ll2DxNL/0LsMzsJFR/3GexwQiM2Edydh6K9KzOwbNJuyxwZLpWHk0zJ2MPiTc3pArSOntSTJZ
        xiLEABTvduIWScGm2cIXgtpJs/s5qfeZWz5+0OkSWdR6UV3BqgDiPh+0d0E/SFBqPyVAmoWHYH09o
        jzzm0rU5gzwMVmTng6vNArk4OSKgpgcax6irOWc3WUuxtzuqfwBAT7wKm7+DaMX/1Xr6apSfJeoFh
        qlbTQXKzZRiaWo1EGpf8u/opFlzIu6Pg7ntb35z7qMLu5fwD4Rt6YlgjLJyU/5PDmcsyKQmoI33r8
        /yIa/9CQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojMTQ-001T5Y-Dw; Fri, 14 Oct 2022 17:19:44 +0200
Message-ID: <0d037ef8-e301-c0fd-8020-3846a4762ade@igalia.com>
Date:   Fri, 14 Oct 2022 12:19:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2 3/3] efi: pstore: Add module parameter for setting the
 record size
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
References: <20221013210648.137452-1-gpiccoli@igalia.com>
 <20221013210648.137452-4-gpiccoli@igalia.com>
 <CAMj1kXG7syjMsOL+AcUMfT0_nhGde6qc_6MexpdDtxFQpS2=7A@mail.gmail.com>
 <1c6a9461-0d3d-a049-0165-0d5c95aa9405@igalia.com>
 <CAMj1kXGLULYfA6UGwvH7NY5A5E6YaC4s8G+qU12MgChB1_5DKQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXGLULYfA6UGwvH7NY5A5E6YaC4s8G+qU12MgChB1_5DKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/10/2022 12:00, Ard Biesheuvel wrote:
> On Fri, 14 Oct 2022 at 16:58, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>>
>> On 14/10/2022 11:46, Ard Biesheuvel wrote:
>>> [...]
>>>>         for (;;) {
>>>> -               varname_size = EFIVARS_DATA_SIZE_MAX;
>>>> +               varname_size = record_size;
>>>>
>>>
>>> I don't think we need this - this is the size of the variable name not
>>> the variable itself.
>>>
>>
>> Ugh, my bad. Do you want to stick with 1024 then?
> 
> Yes let's keep this at 1024

Perfect, will re-send after we have more feedback on patches 1 and 2.
Thanks again,


Guilherme
