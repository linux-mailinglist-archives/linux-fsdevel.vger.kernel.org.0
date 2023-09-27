Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC27B0564
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjI0Nae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjI0Nab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC210A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695821386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G2hv5CuQPn74NEvKQKxD/ubIeG0HKIdGdn5RcarEG6U=;
        b=IdvIikP36tuLTZF6xdHwM5Yg6j64gP8HCz817rdwlJRi0Ci+4yqc0Iiel4q8mmAaxdw8ed
        XqrFQL7xIbqFxUJZyeEQsmFBJpJe6ASEt76zCFq4LUxrOEo/QpYGSELvR+3TB/zy8OoXDX
        7O61cSIi7T5D0eL4fMZ6+7NI/ZUZEH8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-NfbSFCw7MquJTeHO0g66Uw-1; Wed, 27 Sep 2023 09:29:43 -0400
X-MC-Unique: NfbSFCw7MquJTeHO0g66Uw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40540179bcdso87595515e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695821378; x=1696426178;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2hv5CuQPn74NEvKQKxD/ubIeG0HKIdGdn5RcarEG6U=;
        b=FQcvQMeVjtf+ux0kjpnwMQaTZGg7BsTSWVsMeOkvKWIHCjqD00oGam8HY9RriU01Nz
         R7f473gzJpdLRyIU7JNQXoSuQsfAdZAvDnF9cC26PD33voTX/RSIzz2aurRY0eW4i1Vf
         qi1ifa4vZfNQEJVdg9qnVQF+39cFpmr+nbUsYvEua6CFlcPX7DZff2r2PABLDq1NboOr
         73b35mp9sSUh/B68h11h0AVK5RLMUei3cob5mKuPt+mDomG9pNVJ/fswa+WHJvO12T00
         LQfUz6RvWriwpor81xf67RjnojpYLuq/GWxmLtTOrJu6xuoP6flcAHrtX6aknHoAwq8T
         mXiA==
X-Gm-Message-State: AOJu0YxnUrBFaPNyB4ybZ5XhSKs+VFnm6QdYxCS1/LmhMKr1SIh8W3kt
        PE6Z3V8PL9Uqq8SBqmMiYkrs4knJgcEMidyg8h9U5mzvblMcJxo1K94oyTjBR2UmNIREnPuE31Z
        2Zu1NDEE8HXqsfYA9CdTr9ZdHng==
X-Received: by 2002:a7b:c8cd:0:b0:405:3a63:6d12 with SMTP id f13-20020a7bc8cd000000b004053a636d12mr1881915wml.17.1695821377620;
        Wed, 27 Sep 2023 06:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmM/Vcbhyu+gFvAqhqp6gDueEI1OOogKEfv68sNWi+zB+gBfd/bHDtz9MAW7eJXY1rkpiOgg==
X-Received: by 2002:a7b:c8cd:0:b0:405:3a63:6d12 with SMTP id f13-20020a7bc8cd000000b004053a636d12mr1881872wml.17.1695821377080;
        Wed, 27 Sep 2023 06:29:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:6900:3a06:bd5:2f7b:e6eb? (p200300cbc74969003a060bd52f7be6eb.dip0.t-ipconnect.de. [2003:cb:c749:6900:3a06:bd5:2f7b:e6eb])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c210200b004063d8b43e7sm3920879wml.48.2023.09.27.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 06:29:36 -0700 (PDT)
Message-ID: <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
Date:   Wed, 27 Sep 2023 15:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> +static int remap_anon_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>> +                         struct vm_area_struct *dst_vma,
>> +                         struct vm_area_struct *src_vma,
>> +                         unsigned long dst_addr, unsigned long src_addr,
>> +                         pte_t *dst_pte, pte_t *src_pte,
>> +                         pte_t orig_dst_pte, pte_t orig_src_pte,
>> +                         spinlock_t *dst_ptl, spinlock_t *src_ptl,
>> +                         struct folio *src_folio)
>> +{
>> +       struct anon_vma *dst_anon_vma;
>> +
>> +       double_pt_lock(dst_ptl, src_ptl);
>> +
>> +       if (!pte_same(*src_pte, orig_src_pte) ||
>> +           !pte_same(*dst_pte, orig_dst_pte) ||
>> +           folio_test_large(src_folio) ||
>> +           folio_estimated_sharers(src_folio) != 1) {

^ here you should check PageAnonExclusive. Please get rid of any 
implicit explicit/implcit mapcount checks.

>> +               double_pt_unlock(dst_ptl, src_ptl);
>> +               return -EAGAIN;
>> +       }
>> +
>> +       BUG_ON(!folio_test_anon(src_folio));
>> +
>> +       dst_anon_vma = (void *)dst_vma->anon_vma + PAGE_MAPPING_ANON;
>> +       WRITE_ONCE(src_folio->mapping,
>> +                  (struct address_space *) dst_anon_vma);

I have some cleanups pending for page_move_anon_rmap(), that moves the 
SetPageAnonExclusive hunk out. Here we should be using 
page_move_anon_rmap() [or rather, folio_move_anon_rmap() after my cleanups]

I'll send them out soonish.

>> +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
>> +                                                     dst_addr)); >> +
>> +       orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
>> +       orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>> +       orig_dst_pte = maybe_mkwrite(pte_mkdirty(orig_dst_pte),
>> +                                    dst_vma);
> 
> I think there's still a theoretical issue here that you could fix by
> checking for the AnonExclusive flag, similar to the huge page case.
> 
> Consider the following scenario:
> 
> 1. process P1 does a write fault in a private anonymous VMA, creating
> and mapping a new anonymous page A1
> 2. process P1 forks and creates two children P2 and P3. afterwards, A1
> is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
> 3. process P1 removes its mapping of A1, dropping its mapcount to 2.
> 4. process P2 uses vmsplice() to grab a reference to A1 with get_user_pages()
> 5. process P2 removes its mapping of A1, dropping its mapcount to 1.
> 
> If at this point P3 does a write fault on its mapping of A1, it will
> still trigger copy-on-write thanks to the AnonExclusive mechanism; and
> this is necessary to avoid P3 mapping A1 as writable and writing data
> into it that will become visible to P2, if P2 and P3 are in different
> security contexts.
> 
> But if P3 instead moves its mapping of A1 to another address with
> remap_anon_pte() which only does a page mapcount check, the
> maybe_mkwrite() will directly make the mapping writable, circumventing
> the AnonExclusive mechanism.
> 

Yes, can_change_pte_writable() contains the exact logic when we can turn 
something easily writable even if it wasn't writable before. which 
includes that PageAnonExclusive is set. (but with uffd-wp or softdirty 
tracking, there is more to consider)

-- 
Cheers,

David / dhildenb

