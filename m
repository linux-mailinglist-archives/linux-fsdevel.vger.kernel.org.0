Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6962316D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKIR0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 12:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKIR0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:26:07 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B8B222B5
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 09:26:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1776999wmo.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCXeEArAtZpsAV3+eRTf/uuyrZvxHawTJioxLNt9+dY=;
        b=r7GxC3viikU1BMakG5VODgDk9Ij9V8KtgDgvhaAN4UHpivyY3e4nV49LEEY1sqxbmO
         LqfOPKqYXKHHfn7bIaMP1n+YbjvZyEGpi2gRLeDhLnhu6zXhMMNnaUVq+wqhCeIPC/Gy
         fJlFTR2cil1rBrbYX3MJu6fsyyFBl6IC0nfrApkOkx5tl23d2Q3URRaaEILdCISe+NAP
         g6qlYZIrrCm7ReiwB3g5Y7/TPguUmRf3j0jhn4wcUda1kbxgOAwJ+j1hmr/qQGbvrasW
         n9PIqCPu3Tqs6PyOK6uKyxZouglTgkp60ax4a7+WT07hntm100KUa677jm4dYvReXyEh
         Iv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCXeEArAtZpsAV3+eRTf/uuyrZvxHawTJioxLNt9+dY=;
        b=mIQM6U4Fw1iUET4I5FxVzUVVv8pHJ/LFPkEJTtI4ha6ux6eLuACFauMwLWS0rCjpuB
         UvmzMPpHdCsP8Uw9GAessZBvny8aGrxbyrx7h7c8c2tLO5WQqiQuBwvnDD/DFvWjz3V4
         UqhTZHoSXXXTCN/VoDZirjMVkZ3OCCjNnVuXSq47TQxAHaTnbkrJhxT3QqaH8jk/N0i9
         V8oOaBB/TiyHlrjSW0hJAkYFYkOQ8ldqw6YuLW6VgUsGqRYSiZTejy9QYE4ep/a64puM
         07VR3cmMMDFRIMIocqdeAyzRxKRVtjvh4Tl8oL3sKJi2MDOXr+EPQwHoRDD0CAvTcx0R
         Z0pg==
X-Gm-Message-State: ACrzQf13JKlLAjgqvV5j2KsFpULppLXVAhjKX2RrbRTW7R+JODYimCzQ
        sHMnJNNAHReCHlj4bsRHWqpsjL2elWyPoKGd
X-Google-Smtp-Source: AMsMyM5/nJv3lbVZCjlhCxvQw9vBCMdyhzzwwyfsJrMd9x8XBUHC9V7Ftyi3Z0ER7AqpImwLPc2RWg==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr50635675wmr.27.1668014760612;
        Wed, 09 Nov 2022 09:26:00 -0800 (PST)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c489400b003cfa80443a0sm2064380wmp.35.2022.11.09.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:25:58 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: Re: [PATCH] selftests: proc: Fix proc-empty-vm build error on
 non x86_64
References: <20221109110621.1791999-1-punit.agrawal@bytedance.com>
        <Y2vcc00tszEg7Ljz@p183>
Date:   Wed, 09 Nov 2022 17:25:56 +0000
In-Reply-To: <Y2vcc00tszEg7Ljz@p183> (Alexey Dobriyan's message of "Wed, 9 Nov
        2022 19:59:31 +0300")
Message-ID: <87leok11ln.fsf_-_@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Wed, Nov 09, 2022 at 11:06:21AM +0000, Punit Agrawal wrote:
>> The proc-empty-vm test is implemented for x86_64 and fails to build
>> for other architectures. Rather then emitting a compiler error it
>> would be preferable to only build the test on supported architectures.
>
> Ehh, can you just port it to whatever arch you're using?
> What's the address space on arm/arm64?

On arm64, it is 0x0000ffffffffffff ((1 << 48) - 1) when using 48bit VA,
but goes up when using 52-bit VA[0].

> 	#ifdef __amd64__
>                 munmap(NULL, ((size_t)1 << 47) - 4096);
> 	#else
> 	#error "implement 'unmap everything'"
> 	#endif
>
> This program is almost arch-independent.

I did try updating the #ifdef but then hit the asm block in
vsyscall(). Also, the test would be still fail to build on other
architectures.

While support for architectures is added, it would be good to not have
the compiler throw an error on unsuspecting kselftest users.

>> +TEST_GEN_PROGS_x86_64 += proc-empty-vm

[0] https://docs.kernel.org/arm64/memory.html
