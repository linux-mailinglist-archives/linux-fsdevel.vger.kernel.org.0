Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4A7766F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjHISE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjHISE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F310F5
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691604252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HbwBg4GAxGJiE0CMpJJ3jphUu511OGFmYHEDw/DnWsE=;
        b=ShI4ir+BopXxL/aENW3GC68tYevBRo48eUOvpSNd9yxCNd+6Cc1PxbCX/g8akeWUSEPWa/
        +oNLxXQEoZoaOTmCoG/Dp6CovLet3df2MM4fTuQYplTDxn7Uf69L+p8oLBscbK1YiVFaBM
        kAvSARzHnGPM2vtTJf3j+P0sraPsndY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-cntlENDbOJCxX5qZW03UYw-1; Wed, 09 Aug 2023 14:04:08 -0400
X-MC-Unique: cntlENDbOJCxX5qZW03UYw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3180a68fff0so84437f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Aug 2023 11:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604247; x=1692209047;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbwBg4GAxGJiE0CMpJJ3jphUu511OGFmYHEDw/DnWsE=;
        b=AfUio+Y1HTkuxpA+vVTqlFvXiULdihIdqsDQIRx9B1r7SJ5gxKGhe0/kw5R1BfwtQm
         L5I3v45i6g/C9W0R805LIIevreoe5W7fkmBHoPQOQuJfmt1mCh6bshQU0zsGENckdbE0
         UgI0T9+/BQFJ55Y/HsuISpUQkSZHme1QbBi5k8nea3Cc9gjwbsxX8m2fAjqnan+7PKZu
         XQse6Sm239SoagwmEeom+IwNx+GvaP2BA05LQWvX7ucqjIE2YJPYCk16VJ10XytqGadY
         BWGuzP4+JwQluo0U51eEd9+rhq6gXCsR8mx6FJgina3VMsjb4VOapHKteF93k5f8R7B/
         KYAg==
X-Gm-Message-State: AOJu0YzztPJfGj3G31X0vOQcAuO5kEDLL7xh+zxQ1BgrgjdHWldQS74V
        5toBuxtghfB+XmLhDLWn4UelPlnIjtpoAeWjvk6NSRvRQzWich27IepeC60xsEBfBBmAm+TB+gE
        AcyD2KvJmp57dPwn/GPmq56oSDg==
X-Received: by 2002:adf:e70d:0:b0:317:5c36:913b with SMTP id c13-20020adfe70d000000b003175c36913bmr90579wrm.48.1691604247090;
        Wed, 09 Aug 2023 11:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWxK24GMlKeGao4+91vvwu97P2OD3dJYC6y1xibxixrcmAbm4WRZuRM1zvrtrq7ym1tGAGzg==
X-Received: by 2002:adf:e70d:0:b0:317:5c36:913b with SMTP id c13-20020adfe70d000000b003175c36913bmr90532wrm.48.1691604246713;
        Wed, 09 Aug 2023 11:04:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5? (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de. [2003:cb:c70e:6800:9933:28db:f83a:ef5])
        by smtp.gmail.com with ESMTPSA id u16-20020adfdb90000000b003175a994555sm17817887wri.6.2023.08.09.11.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 11:04:06 -0700 (PDT)
Message-ID: <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com>
Date:   Wed, 9 Aug 2023 20:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230630211957.1341547-1-surenb@google.com>
 <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>> Which ends up being
>>>>
>>>> VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>>>>
>>>> I did not check if this is also the case on mainline, and if this series is responsible.
>>>
>>> Thanks for reporting! I'm checking it now.
>>
>> Hmm. From the code it's not obvious how lock_mm_and_find_vma() ends up
>> calling find_vma() without mmap_lock after successfully completing
>> get_mmap_lock_carefully(). lock_mm_and_find_vma+0x3f/0x270 points to
>> the first invocation of find_vma(), so this is not even the lock
>> upgrade path... I'll try to reproduce this issue and dig up more but
>> from the information I have so far this issue does not seem to be
>> related to this series.

I just checked on mainline and it does not fail there.

> 
> This is really weird. I added mmap_assert_locked(mm) calls into
> get_mmap_lock_carefully() right after we acquire mmap_lock read lock
> and one of them triggers right after successful
> mmap_read_lock_killable(). Here is my modified version of
> get_mmap_lock_carefully():
> 
> static inline bool get_mmap_lock_carefully(struct mm_struct *mm,
> struct pt_regs *regs) {
>       /* Even if this succeeds, make it clear we might have slept */
>       if (likely(mmap_read_trylock(mm))) {
>           might_sleep();
>           mmap_assert_locked(mm);
>           return true;
>       }
>       if (regs && !user_mode(regs)) {
>           unsigned long ip = instruction_pointer(regs);
>           if (!search_exception_tables(ip))
>               return false;
>       }
>       if (!mmap_read_lock_killable(mm)) {
>           mmap_assert_locked(mm);                     <---- generates a BUG
>           return true;
>       }
>       return false;
> }

Ehm, that's indeed weird.

> 
> AFAIKT conditions for mmap_read_trylock() and
> mmap_read_lock_killable() are checked correctly. Am I missing
> something?

Weirdly enough, it only triggers during that specific uffd test, right?

-- 
Cheers,

David / dhildenb

