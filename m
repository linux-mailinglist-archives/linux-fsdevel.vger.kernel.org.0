Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4B7771B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHJHmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjHJHmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356E2704
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691653262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wo0nlmTB+yI/EjPzL+nHf3s+1gZ0NohNOJVrAJSRTwA=;
        b=NVDAfkrbzmp4r1dq71fDuwYtMK0sbn4tMV/rpC2OjkiQxuIc26cmKq/u6w9PM2boK2Hn89
        539Hz8CSsuE/kXnU+v2rRH9pCt+Dtidtp92SIqu/OOqZXVdZpjX7LMXgPcVHuHiRLA441B
        mGvXwYB9fVrAOLs5//URoKX4Dpqga5Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-dPtrGxSWPHyXUMCcVdK9Ww-1; Thu, 10 Aug 2023 03:41:00 -0400
X-MC-Unique: dPtrGxSWPHyXUMCcVdK9Ww-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe2fc65f1fso3851375e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 00:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653259; x=1692258059;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo0nlmTB+yI/EjPzL+nHf3s+1gZ0NohNOJVrAJSRTwA=;
        b=fPDbSzlYRsBLpTCKhqoontsLYcU3T40LeUMQUA32KgCkR8mI32b5m2R0rLCpoBW9DC
         1Qe2Ag9ADHEoc3bGZ65uIaUcsJ/+pbUh0BdsL4Zono6K+AeMsI+17WIzIsoh97GiBANy
         //cxb4OIPwME+8IIIHa7GDCBbD+OqrHtcoXZBB9um/IUcOu/uTs8LLiqh2loCF2phzju
         G9r8LiMZam+lcG9MQljPT5spEhPNToVgWa0aJM/y5307O5wf1qvjM+9TDstW4Axgc5tc
         4iF3eyaerdn+/Wkyx3FPo6kRu6zgEQWg4KEcgn7YU7wvDBBqcu6vmPou+hb/s3DTyh/z
         YONA==
X-Gm-Message-State: AOJu0YwAs2CriZ2HKZuc6FnncD1KsL6pbMeayqz+4VpyiXCP7lg+yOuR
        wX6MneXu2Q2zfHtDEkVdQFKjnkmTi86obEgP8AdYkx9XMrY35Iz3ch2GYUTIxr4VPaXsN4TxsKj
        WrnUH2g63Ay642FykE6NETdIHww==
X-Received: by 2002:a05:600c:da:b0:3fd:29cf:20c5 with SMTP id u26-20020a05600c00da00b003fd29cf20c5mr1271254wmm.7.1691653259491;
        Thu, 10 Aug 2023 00:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvM10aRE0/c6fVx3Q56OHfaGwLcM5SZ9caahh1IpRqOJJTKbhysWzSoWCzzN7tmB5JyQridg==
X-Received: by 2002:a05:600c:da:b0:3fd:29cf:20c5 with SMTP id u26-20020a05600c00da00b003fd29cf20c5mr1271232wmm.7.1691653258988;
        Thu, 10 Aug 2023 00:40:58 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm1214769wmf.41.2023.08.10.00.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 00:40:58 -0700 (PDT)
Message-ID: <01e20a4a-35dc-b342-081f-0edaf8780f51@redhat.com>
Date:   Thu, 10 Aug 2023 09:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, yuzhao@google.com,
        dhowells@redhat.com, hughd@google.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230630211957.1341547-1-surenb@google.com>
 <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com>
 <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
In-Reply-To: <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.08.23 08:24, Suren Baghdasaryan wrote:
> On Wed, Aug 9, 2023 at 10:29 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Wed, Aug 9, 2023 at 11:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>>
>>> On Wed, Aug 9, 2023 at 11:08 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>
>>>> On Wed, Aug 9, 2023 at 11:04 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>>>>>> Which ends up being
>>>>>>>>>
>>>>>>>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>>>>>>>>>
>>>>>>>>> I did not check if this is also the case on mainline, and if this series is responsible.
>>>>>>>>
>>>>>>>> Thanks for reporting! I'm checking it now.
>>>>>>>
>>>>>>> Hmm. From the code it's not obvious how lock_mm_and_find_vma() ends up
>>>>>>> calling find_vma() without mmap_lock after successfully completing
>>>>>>> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points to
>>>>>>> the first invocation of find_vma(), so this is not even the lock
>>>>>>> upgrade path... I'll try to reproduce this issue and dig up more but
>>>>>>> from the information I have so far this issue does not seem to be
>>>>>>> related to this series.
>>>>>
>>>>> I just checked on mainline and it does not fail there.
>>>
>>> Thanks. Just to eliminate the possibility, I'll try reverting my
>>> patchset in mm-unstable and will try the test again. Will do that in
>>> the evening once I'm home.
>>>
>>>>>
>>>>>>
>>>>>> This is really weird. I added mmap_assert_locked(mm) calls into
>>>>>> get_mmap_lock_carefully() right after we acquire mmap_lock read lock
>>>>>> and one of them triggers right after successful
>>>>>> mmap_read_lock_killable(). Here is my modified version of
>>>>>> get_mmap_lock_carefully():
>>>>>>
>>>>>> static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
>>>>>> struct pt_regs *regs) {
>>>>>>        /* Even if this succeeds, make it clear we might have slept */
>>>>>>        if (likely(mmap_read_trylock(mm))) {
>>>>>>            might_sleep();
>>>>>>            mmap_assert_locked(mm);
>>>>>>            return true;
>>>>>>        }
>>>>>>        if (regs && !user_mode(regs)) {
>>>>>>            unsigned long ip = instruction_pointer(regs);
>>>>>>            if (!search_exception_tables(ip))
>>>>>>                return false;
>>>>>>        }
>>>>>>        if (!mmap_read_lock_killable(mm)) {
>>>>>>            mmap_assert_locked(mm);                     <---- generates a BUG
>>>>>>            return true;
>>>>>>        }
>>>>>>        return false;
>>>>>> }
>>>>>
>>>>> Ehm, that's indeed weird.
>>>>>
>>>>>>
>>>>>> AFAIKT conditions for mmap_read_trylock() and
>>>>>> mmap_read_lock_killable() are checked correctly. Am I missing
>>>>>> something?
>>>>>
>>>>> Weirdly enough, it only triggers during that specific uffd test, right?
>>>>
>>>> Yes, uffd-unit-tests. I even ran it separately to ensure it's not some
>>>> fallback from a previous test and I'm able to reproduce this
>>>> consistently.
>>
>> Yeah, it is somehow related to per-vma locking. Unfortunately I can't
>> reproduce the issue on my VM, so I have to use my host and bisection
>> is slow. I think I'll get to the bottom of this tomorrow.
> 
> Ok, I think I found the issue. 

Nice!

> wp_page_shared() ->
> fault_dirty_shared_page() can drop mmap_lock (see the comment saying
> "Drop the mmap_lock before waiting on IO, if we can...", therefore we
> have to ensure we are not doing this under per-VMA lock.
> I think what happens is that this path is racing with another page
> fault which took mmap_lock for read. fault_dirty_shared_page()
> releases this lock which was taken by another page faulting thread and
> that thread generates an assertion when it finds out the lock it just
> took got released from under it.

I wonder if we could detect that someone releases the mmap lock that was 
not taken by that person, to bail out early at the right place when 
debugging such issues. Only with certain config knobs enabled, of course.

> The following crude change fixed the issue for me but there might be a
> more granular way to deal with this:
> 
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3293,18 +3293,18 @@ static vm_fault_t wp_page_shared(struct
> vm_fault *vmf, struct folio *folio)
>           struct vm_area_struct *vma = vmf->vma;
>           vm_fault_t ret = 0;
> 
> +        if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +                pte_unmap_unlock(vmf->pte, vmf->ptl);
> +                vma_end_read(vmf->vma);
> +                return VM_FAULT_RETRY;
> +        }
> +

I won't lie: all of these locking checks are a bit hard to get and 
possibly even harder to maintain.

Maybe better mmap unlock sanity checks as spelled out above might help 
improve part of the situation.


And maybe some comments regarding the placement might help as well ;)

-- 
Cheers,

David / dhildenb

