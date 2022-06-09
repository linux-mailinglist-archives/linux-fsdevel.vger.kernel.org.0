Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AC544E6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiFIOKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiFIOKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:10:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A1E2E;
        Thu,  9 Jun 2022 07:10:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd25so31404137edb.3;
        Thu, 09 Jun 2022 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mEtsDMb1k6CAhwW7ISC2TInxkibSNypnKownS0OQOzM=;
        b=mgrJ9hp/GfgwWN5tXJmnl8BnnEqXCAKpNGpam7MtrpYO0SI1hQovYwM1cGtHRSBW8N
         8hwdKmACCRbdEVp3ztBxuOUpU8Lj8cWf+Kx+Z+HJz+f/NStxBiUuk3lNwo/iQqflxvTF
         InhPQenYDtubdWj0kzqQunKVK2VpuXe5lG3LqH359TPGOV1ya8aUubNqeEJm5slFN9UC
         s0l6wKpJdTKH6VEkOyvnAWu4FuxiRHTd1mmSc0t20a63BtaAauk73vDVGuMPaKxjSfDI
         ZF7BlODVAXy32IB8sffpp41YjC1ufolYJTK/mIyUwM1Gg4I4h8Te99MpvvqM5hnlFIwa
         jqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mEtsDMb1k6CAhwW7ISC2TInxkibSNypnKownS0OQOzM=;
        b=bfpDhOe3ZcKZbjcorPwQjYVm6N7fNRquF0Qobpu3I3Pnrj+bCp78CMOXKsmL7M0Bz9
         Z+lXMfyG2z8aAgEao6Sxkfy8MCkjcaYeBNDgsLCNM9Mggslu+nxOW9C5mDvfZJiDCjh2
         YdjZGPSyMgQCCielQmf5ciTDZ7YFVmvGAa9Qn+78NZjU+f/W5XH26EQOGDfd1VkJ1R0f
         f5Z1wv1SqKF8CigoARLcnT94TLyQzbvlU8m/YyVLp6tFMyWPXVK8zaLtW+0nW/72wjCw
         kQVNHnGwNe3fG9txulbpUtSB878nCH8p2EiymV8kfii/OT02u7L9lPInRDW62+9OOkX6
         z6Hw==
X-Gm-Message-State: AOAM532mHO5qujRHkN4OKeSdQJnvAsNOuGEXG+i+W+UP6adwsAqSpPRs
        WFyud28aZwTnfOSbl8R2m5FevebjqrQ=
X-Google-Smtp-Source: ABdhPJyeKHQqi9/0tzt/2RVsH3TlW5RXc5Nbx2kxhyDYn4Th+HmG5UQ3rIQ0Tdhh57D5z0Br/W8sFA==
X-Received: by 2002:a05:6402:3291:b0:42d:dd03:cbb1 with SMTP id f17-20020a056402329100b0042ddd03cbb1mr44742813eda.268.1654783846479;
        Thu, 09 Jun 2022 07:10:46 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:99ff:907d:6fef:f861? ([2a02:908:1256:79a0:99ff:907d:6fef:f861])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7d458000000b0042aad9edc9bsm14778769edr.71.2022.06.09.07.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 07:10:39 -0700 (PDT)
Message-ID: <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
Date:   Thu, 9 Jun 2022 16:10:33 +0200
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
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
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

Am 09.06.22 um 14:57 schrieb Michal Hocko:
> On Thu 09-06-22 14:16:56, Christian König wrote:
>> Am 09.06.22 um 11:18 schrieb Michal Hocko:
>>> On Tue 31-05-22 11:59:57, Christian König wrote:
>>>> This gives the OOM killer an additional hint which processes are
>>>> referencing shmem files with potentially no other accounting for them.
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>    mm/shmem.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 4b2fea33158e..a4ad92a16968 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -2179,6 +2179,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
>>>>    	return inflated_addr;
>>>>    }
>>>> +static long shmem_oom_badness(struct file *file)
>>>> +{
>>>> +	return i_size_read(file_inode(file)) >> PAGE_SHIFT;
>>>> +}
>>> This doesn't really represent the in memory size of the file, does it?
>> Well the file could be partially or fully swapped out as anonymous memory or
>> the address space only sparse populated, but even then just using the file
>> size as OOM badness sounded like the most straightforward approach to me.
> It covers hole as well, right?

Yes, exactly.

>
>> What could happen is that the file is also mmaped and we double account.
>>
>>> Also the memcg oom handling could be considerably skewed if the file was
>>> shared between more memcgs.
>> Yes, and that's one of the reasons why I didn't touched the memcg by this
>> and only affected the classic OOM killer.
> oom_badness is for all oom handlers, including memcg. Maybe I have
> misread an earlier patch but I do not see anything specific to global
> oom handling.

As far as I can see the oom_badness() function is only used in oom_kill.c and in procfs to return the oom score. Did I missed something?

Regards,
Christian.
