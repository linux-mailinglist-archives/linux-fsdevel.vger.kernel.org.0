Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F921ECD41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFCKKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFCKK3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:10:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C8C05BD43;
        Wed,  3 Jun 2020 03:10:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so666868plr.2;
        Wed, 03 Jun 2020 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jz2L/H8VvSCV17Sm2ywMJzw285Q3gBg6Du7pbd9Qox0=;
        b=e2V8SnEQWQJhThG+INeX5TeZNkgDX0fPh6+18m6txMx0bqsoqSXwhkHoKpQ2SnBoy5
         SUBzucz500f4P6Fhn3hXnvYgSJANoCij01N0oXQdX/ip/sSLXrbFMLbwDzrjnYQQNNR+
         y88Hg/hQuck58NCufye7WvhKFlcNNeV4KUUh0gAOYXehXR+9A7w1t0g8ZCDtOEclTrnZ
         oZOR2YUTZ0FtJjas9G7RVFm1SdX5m/ZcjajyLU+X3emvY0oeBN/nBRVumFEQqNW/00RH
         nEzJ7ZNMDhvKiIKklrdvqgdwYO56DkTeJy/4tJbrLZIPPWf5l4zhhvPLfA+c0xGI3Q3c
         j+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jz2L/H8VvSCV17Sm2ywMJzw285Q3gBg6Du7pbd9Qox0=;
        b=uH2g9eorKOcuB7wVj5XfVZBG3LniisDxZ5Sa95/S20ewXiwJM5mJpvmp9rUoZmgzQL
         j/J2GP3TQxE0TGMLX6U3OeRESIk4xhiz+D3I9+c93SJWoU92mpcwbKCeUZQ02rLUnN4w
         SerbchjMGTeQgvjUNXkbRoExDqsMFAhYpr2Qe38OUMzx/CZITxHF7a6v+ceWIx8FNwiP
         JoYOkOTEEJRYucXBOKeSye4qB7I+4uN5LEIGhmXpyoiyNPAYvd8X0DuLs65cZbmJiHXi
         GMw0zeV88DxhIR8GpYUee+RIyJY+GN42OsBLb2xa30evqTjUc/62Bpfk0CS6GZfh1hqt
         dRDA==
X-Gm-Message-State: AOAM533/Iub6cKihH5QfypSnfr/pr7HOzrFrS0tsP/mwgycLfzaW9IJc
        F1fidT6xIqWFa8q8m4QD8GgnS80L
X-Google-Smtp-Source: ABdhPJw0hkjlTTmytNbvwkjhqPHLxMSKXpsewrKs9JYTP9Xsga92TMwF2EZ2WC6y/61vbvpADux9aQ==
X-Received: by 2002:a17:902:502:: with SMTP id 2mr28551862plf.134.1591179026938;
        Wed, 03 Jun 2020 03:10:26 -0700 (PDT)
Received: from localhost.localdomain ([124.123.82.91])
        by smtp.gmail.com with ESMTPSA id f6sm1644839pfe.174.2020.06.03.03.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 03:10:26 -0700 (PDT)
Subject: Re: [PATCHv5 3/5] ext4: mballoc: Introduce pcpu seqcnt for freeing PA
 to improve ENOSPC handling
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1589955723.git.riteshh@linux.ibm.com>
 <7f254686903b87c419d798742fd9a1be34f0657b.1589955723.git.riteshh@linux.ibm.com>
 <CGME20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b@eucas1p2.samsung.com>
 <aa4f7629-02ff-e49b-e9c0-5ef4a1deee90@samsung.com>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <2940d744-3f6f-d0b5-ad8d-e80128c495d0@gmail.com>
Date:   Wed, 3 Jun 2020 15:40:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <aa4f7629-02ff-e49b-e9c0-5ef4a1deee90@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Marek,

On 6/3/20 12:18 PM, Marek Szyprowski wrote:
> Hi Ritesh,
> 
> On 20.05.2020 08:40, Ritesh Harjani wrote:
>> There could be a race in function ext4_mb_discard_group_preallocations()
>> where the 1st thread may iterate through group's bb_prealloc_list and
>> remove all the PAs and add to function's local list head.
>> Now if the 2nd thread comes in to discard the group preallocations,
>> it will see that the group->bb_prealloc_list is empty and will return 0.
>>
>> Consider for a case where we have less number of groups
>> (for e.g. just group 0),
>> this may even return an -ENOSPC error from ext4_mb_new_blocks()
>> (where we call for ext4_mb_discard_group_preallocations()).
>> But that is wrong, since 2nd thread should have waited for 1st thread
>> to release all the PAs and should have retried for allocation.
>> Since 1st thread was anyway going to discard the PAs.
>>
>> The algorithm using this percpu seq counter goes below:
>> 1. We sample the percpu discard_pa_seq counter before trying for block
>>      allocation in ext4_mb_new_blocks().
>> 2. We increment this percpu discard_pa_seq counter when we either allocate
>>      or free these blocks i.e. while marking those blocks as used/free in
>>      mb_mark_used()/mb_free_blocks().
>> 3. We also increment this percpu seq counter when we successfully identify
>>      that the bb_prealloc_list is not empty and hence proceed for discarding
>>      of those PAs inside ext4_mb_discard_group_preallocations().
>>
>> Now to make sure that the regular fast path of block allocation is not
>> affected, as a small optimization we only sample the percpu seq counter
>> on that cpu. Only when the block allocation fails and when freed blocks
>> found were 0, that is when we sample percpu seq counter for all cpus using
>> below function ext4_get_discard_pa_seq_sum(). This happens after making
>> sure that all the PAs on grp->bb_prealloc_list got freed or if it's empty.
>>
>> It can be well argued that why don't just check for grp->bb_free to
>> see if there are any free blocks to be allocated. So here are the two
>> concerns which were discussed:-
>>
>> 1. If for some reason the blocks available in the group are not
>>      appropriate for allocation logic (say for e.g.
>>      EXT4_MB_HINT_GOAL_ONLY, although this is not yet implemented), then
>>      the retry logic may result into infinte looping since grp->bb_free is
>>      non-zero.
>>
>> 2. Also before preallocation was clubbed with block allocation with the
>>      same ext4_lock_group() held, there were lot of races where grp->bb_free
>>      could not be reliably relied upon.
>> Due to above, this patch considers discard_pa_seq logic to determine if
>> we should retry for block allocation. Say if there are are n threads
>> trying for block allocation and none of those could allocate or discard
>> any of the blocks, then all of those n threads will fail the block
>> allocation and return -ENOSPC error. (Since the seq counter for all of
>> those will match as no block allocation/discard was done during that
>> duration).
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> This patch landed in yesterday's linux-next and causes following
> WARNING/BUG on various Samsung Exynos-based boards:
> 
>    BUG: using smp_processor_id() in preemptible [00000000] code: logsave/552
>    caller is ext4_mb_new_blocks+0x404/0x1300

Yes, this is being discussed in the community.
I have submitted a patch which should help fix this warning msg.
Feel free to give this a try on your setup.

https://marc.info/?l=linux-ext4&m=159110574414645&w=2


-ritesh

