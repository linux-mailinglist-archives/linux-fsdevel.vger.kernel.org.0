Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A866977DD7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbjHPJkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbjHPJkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F44826AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692178796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFBldxIxVEKk73g4QkQjpL3ZIahoGA8LCqEDtviYvlo=;
        b=bF/DrrOTN1JVO127lMvjya6HD7Nq0kw9/eQYG2Yz5z2e4cMszce79bKJXDeV7mdu3Q+q+F
        bdLBCkQva9HwYAOh188ChUJEyU6QUdjpoq6kSaYn1PWge8BSVlXIXAh0hEwK+eAdx7jy/1
        JFH3g707xmBxW7lq3mq9B8G1a+DhHaE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-ufRedR7JP26KtIwTucI3OA-1; Wed, 16 Aug 2023 05:39:55 -0400
X-MC-Unique: ufRedR7JP26KtIwTucI3OA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3178ddc3d94so3700177f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 02:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692178794; x=1692783594;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFBldxIxVEKk73g4QkQjpL3ZIahoGA8LCqEDtviYvlo=;
        b=WoiQCA+l4uEuw0NMJj78QoDMOe1efYruhYeIfWJjmzXLSxm3gifASh2PXYSw4mfHrj
         5gDV+LfqLoX1LSRIyLn6nG+va67R8F0L/qoRe5yAp27WQfpeS6kaVoSJ0IMFJClr1uOr
         b6xqqMU66WtVpVrupY/6q7DkJ+99QtrJVXp6c1zILQUxoPuhw2cLIyf094AZwDFwKdl3
         TZaRBREltSB8xviKVgVDUmNGUtquvtivDccIOjORY5Qp751G9Zvh+Gkuu94A7k1nRdBm
         SOQiXYIcjZxYkABBMEKLQSgqFi+Eb2Tu9jpiiFKQlAE2Aj19c8WFnmCg1bCPdKqFZ3Ix
         fm8g==
X-Gm-Message-State: AOJu0Yxp1aIZoPB9XLZ0yjdCrAu1rv/807hNYZ/EzF8uY8CnO2e4YhX8
        gZEED4JEYWODe6nel8PGWGqR8EbjAv4C0TEHwNNFCA/CzaDTC277qy2PN7O95zLgDUptKozv/Xs
        HLOURaIj+e/Vpd8LR8DMwZiGiJg==
X-Received: by 2002:a5d:5350:0:b0:30e:3caa:971b with SMTP id t16-20020a5d5350000000b0030e3caa971bmr940169wrv.51.1692178794034;
        Wed, 16 Aug 2023 02:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRFIhnThxW0BbPGIEJTHC8cYHE/astUjt339LTkbvSoWyXFKTf7BU6uWrnGn27t/0dYCxcOg==
X-Received: by 2002:a5d:5350:0:b0:30e:3caa:971b with SMTP id t16-20020a5d5350000000b0030e3caa971bmr940162wrv.51.1692178793602;
        Wed, 16 Aug 2023 02:39:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:8b00:5520:fa3c:c527:592f? (p200300cbc74b8b005520fa3cc527592f.dip0.t-ipconnect.de. [2003:cb:c74b:8b00:5520:fa3c:c527:592f])
        by smtp.gmail.com with ESMTPSA id z7-20020adfd0c7000000b00317afc7949csm20109208wrh.50.2023.08.16.02.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:39:53 -0700 (PDT)
Message-ID: <ad33c7f1-8c7c-27b6-7c2e-adbb349f2dff@redhat.com>
Date:   Wed, 16 Aug 2023 11:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] proc/ksm: add ksm stats to /proc/pid/smaps
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230811162803.1361989-1-shr@devkernel.io>
 <43d64aee-4bd9-bba0-9434-55cec26bd9dc@redhat.com>
 <qvqwmsysdy3p.fsf@devbig1114.prn1.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqwmsysdy3p.fsf@devbig1114.prn1.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15.08.23 19:10, Stefan Roesch wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> Sorry for the late reply, Gmail once again decided to classify your mails as
>> spam (for whatever reason).
>>
>> On 11.08.23 18:28, Stefan Roesch wrote:
>>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>>> is enabled we can query how effective KSM is overall. However we cannot
>>> easily query if an individual VMA benefits from KSM.
>>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>>> how many of the pages are KSM pages.
>>> Here is a typical output:
>>> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
>>> Size:             262144 kB
>>> KernelPageSize:        4 kB
>>> MMUPageSize:           4 kB
>>> Rss:               51212 kB
>>> Pss:                8276 kB
>>> Shared_Clean:        172 kB
>>> Shared_Dirty:      42996 kB
>>> Private_Clean:       196 kB
>>> Private_Dirty:      7848 kB
>>> Referenced:        15388 kB
>>> Anonymous:         51212 kB
>>> KSM:               41376 kB
>>> LazyFree:              0 kB
>>> AnonHugePages:         0 kB
>>> ShmemPmdMapped:        0 kB
>>> FilePmdMapped:         0 kB
>>> Shared_Hugetlb:        0 kB
>>> Private_Hugetlb:       0 kB
>>> Swap:             202016 kB
>>> SwapPss:            3882 kB
>>> Locked:                0 kB
>>> THPeligible:    0
>>> ProtectionKey:         0
>>> ksm_state:          0
>>> ksm_skip_base:      0
>>> ksm_skip_count:     0
>>> VmFlags: rd wr mr mw me nr mg anon
>>> This information also helps with the following workflow:
>>> - First enable KSM for all the VMA's of a process with prctl.
>>> - Then analyze with the above smaps report which VMA's benefit the most
>>> - Change the application (if possible) to add the corresponding madvise
>>> calls for the VMA's that benefit the most
>>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>>> ---
>>>    Documentation/filesystems/proc.rst | 3 +++
>>>    fs/proc/task_mmu.c                 | 5 +++++
>>>    2 files changed, 8 insertions(+)
>>> diff --git a/Documentation/filesystems/proc.rst
>>> b/Documentation/filesystems/proc.rst
>>> index 7897a7dafcbc..4ef3c0bbf16a 100644
>>> --- a/Documentation/filesystems/proc.rst
>>> +++ b/Documentation/filesystems/proc.rst
>>> @@ -461,6 +461,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
>>>        Private_Dirty:         0 kB
>>>        Referenced:          892 kB
>>>        Anonymous:             0 kB
>>> +    KSM:                   0 kB
>>>        LazyFree:              0 kB
>>>        AnonHugePages:         0 kB
>>>        ShmemPmdMapped:        0 kB
>>> @@ -501,6 +502,8 @@ accessed.
>>>    a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
>>>    and a page is modified, the file page is replaced by a private anonymous copy.
>>>    +"KSM" shows the amount of anonymous memory that has been de-duplicated.
>>
>>
>> How do we want to treat memory that has been deduplicated into the shared
>> zeropage?
>>
>> It would also match this description.
>>
>> See in mm-stable:
>>
>> commit 30ff6ed9a65c7e73545319fc15f7bcf9c52457eb
>> Author: xu xin <xu.xin16@zte.com.cn>
>> Date:   Tue Jun 13 11:09:28 2023 +0800
>>
>>      ksm: support unsharing KSM-placed zero pages
>>
>>      Patch series "ksm: support tracking KSM-placed zero-pages", v10.
> 
> I see two approaches how to deal with zero page:
>   - If zero page is not enabled, it works as is
>   - If enabled
>      - Document that zero page is accounted for the current vma or
>      - Pass in the pte from smaps_pte_entry() to smaps_account() so we can
>      determine if this is a zero page.

That's probably the right thing to do: make the stat return the same 
value independent of the usage of the shared zeropage.

>      I'm not sure what to do about smaps_pmd_entry in that case. We
>      probably don't care about compund pages.

No, KSM only places the shared zeropage for PTEs, no need to handle PMDs.

-- 
Cheers,

David / dhildenb

