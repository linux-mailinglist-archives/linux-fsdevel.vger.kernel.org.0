Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0B549A0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 19:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbiFMRcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiFMRcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:32:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759BE3525C;
        Mon, 13 Jun 2022 05:55:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w27so6993576edl.7;
        Mon, 13 Jun 2022 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eTQgrOtNKXeuE24E4z1BZTvFXtuq4jZXbc2fnCBYhC4=;
        b=Nj4MPAUCb8OsNfEZnsGGbUCGhFTknfSsE2F2y/SD3ys8pENJtRCBqv0QGE5MeJqZKf
         4ujqAiYBhiFAQIIMPaygZHU0/g+3YknfQZZNi4Zk1JY22jEvvgIxbsyGHQl/L5VMCTv+
         PhibmZ6Q8zOwiyhaUUxlLced1et9/+osLVbICikxeqZICFXFHZtDonOd+BrKN251SWnv
         dxbwERu7dgYthvRMX8FfmxERfODU787Zqp6sW7mpxaFLu2txINVkCxHxdrUWAlAktt3B
         5jBGTrYKi//rCcqiMtbP1tfziE+slRshLlGSrrgWkutmG5+D2MFut4UwQ9MF72FkL5M7
         IRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eTQgrOtNKXeuE24E4z1BZTvFXtuq4jZXbc2fnCBYhC4=;
        b=5ZDEipQaL0rIPJwEMV8LCu5GO+LFGB0BV3reYVan/Daj8VZVo+RK3PPvrdlpSK7BZw
         79PAysxVCrrZLnz2JA2oaGsMhYnWdSZw4kwuvf77lEIEOpIv/5mvZ0Ynr8Of+aOfnTqP
         hJMSj45tRTdCG/6DKYhpeQXQ73kR/UURlYDKGeANmEj+L/5sKlu6z7J4fPBo/wPpV+1g
         IhVaaX8SH0qWP8Vh0W508QAIPmxlvqKT3xxxnWXa6CKTay7dlXxu14LxFp8LO6PhJbgO
         mWYoLiYLHAPxFenVVkXo8huIiP+FqeC5pO1myAt1Ls7yWxEAGVrKDm/al1rTz3VBrBr5
         zBAg==
X-Gm-Message-State: AOAM533T4ApCOt10bUFXaiCRm2xa3MCBYrmOP2i70jwSnNkhdEnarhlZ
        K+6cvk/yMrr/rMyMaYbeyVU=
X-Google-Smtp-Source: ABdhPJyT0uwBN5ukf/MuNShwizt1LoZp0+Oby2zBTUXp3fSO81I8QLT2dBcsK6cZgTnu+DBQ4P/AYA==
X-Received: by 2002:a05:6402:1e92:b0:42d:dc34:e233 with SMTP id f18-20020a0564021e9200b0042ddc34e233mr65598749edf.386.1655124957390;
        Mon, 13 Jun 2022 05:55:57 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b659.dip0.t-ipconnect.de. [87.176.182.89])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709060b5400b0070662b3b792sm3765548ejg.222.2022.06.13.05.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 05:55:56 -0700 (PDT)
Message-ID: <34daa8ab-a9f4-8f7b-0ea7-821bc36b9497@gmail.com>
Date:   Mon, 13 Jun 2022 14:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <Yqbq/Q5jz2ou87Jx@dhcp22.suse.cz>
 <b8b9aba5-575e-8a34-e627-79bef4ed7f97@amd.com>
 <YqcpZY3Xx7Mk2ROH@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YqcpZY3Xx7Mk2ROH@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 13.06.22 um 14:11 schrieb Michal Hocko:
> [SNIP]
>>>> Alternative I could try to track the "owner" of a buffer (e.g. a shmem
>>>> file), but then it can happen that one processes creates the object and
>>>> another one is writing to it and actually allocating the memory.
>>> If you can enforce that the owner is really responsible for the
>>> allocation then all should be fine. That would require MAP_POPULATE like
>>> semantic and I suspect this is not really feasible with the existing
>>> userspace. It would be certainly hard to enforce for bad players.
>> I've tried this today and the result was: "BUG: Bad rss-counter state
>> mm:000000008751d9ff type:MM_FILEPAGES val:-571286".
>>
>> The problem is once more that files are not informed when the process
>> clones. So what happened is that somebody called fork() with an mm_struct
>> I've accounted my pages to. The result is just that we messed up the
>> rss_stats and  the the "BUG..." above.
>>
>> The key difference between normal allocated pages and the resources here is
>> just that we are not bound to an mm_struct in any way.
> It is not really clear to me what exactly you have tried.

I've tried to track the "owner" of a driver connection by keeping a 
reference to the mm_struct who created this connection inside our file 
private and then use add_mm_counter() to account all the allocations of 
the driver to this mm_struct.

This works to the extend that now the right process is killed in an OOM 
situation. The problem with this approach is that the driver is not 
informed about operations like fork() or clone(), so what happens is 
that after a fork()/clone() we have an unbalanced rss-counter.

Let me maybe get back to the initial question: We have resources which 
are not related to the virtual address space of a process, how should we 
tell the OOM killer about them?

Thanks for all the input so far,
Christian.
