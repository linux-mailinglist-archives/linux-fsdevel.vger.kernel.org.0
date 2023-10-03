Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344737B7302
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjJCVFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 17:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbjJCVFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE9AB
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696367083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cUoqfdOw5XZHcgjUV+sI5thBgqq8pWph++w1cw0LK0=;
        b=AjtA78v1aG+o5BjkMmbkRL8mhmCpEfiFwYPWMtrUe3yPzYr0k1fV/RKhBAH6lX80I+zWKn
        rE8luWW4Wif+QNgTj9BEsScnB9pExi8LnOu8rFl8ruoL9HepZayNbTQjqPazMGwFFVyxer
        wEa90XqkLyVJSa4iJJkrm6fX0xINVOo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-jceN7jf2NKauCmSDnEBCgg-1; Tue, 03 Oct 2023 17:04:42 -0400
X-MC-Unique: jceN7jf2NKauCmSDnEBCgg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4053d832d51so9929445e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 14:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367081; x=1696971881;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cUoqfdOw5XZHcgjUV+sI5thBgqq8pWph++w1cw0LK0=;
        b=GwIhx1+KMZk/wuPbu5Rz1QhPKv+kJf6erJFOLbwBo3k31khdI7fTLGKs00Yyyrk/2E
         8vuh2/VY0McoaR1yr+DJMO41XfflSLSw9DjOvoty6mn0ycjcSI/gKzz0rvYrF3FM/L7d
         ZIDkSrXwaW22o0E65pjgBUNA1/LsGgWGeRgq1GGs+FyC9pVvy3lrqtXln5V8VYhCbIYe
         W9v1BLnGQkGn3m7fdYQuh8tYmPlMHYFLX2uj5psx2FcAut6wxivJJVKuJBPIHQtwKRpO
         dxV82wIxmpa1HxxWnDFqqqtdzu+ng5QGU6oxTjtAv1VOg3eam/UbUmi1jrQeHb2HVz3f
         XThQ==
X-Gm-Message-State: AOJu0Yz9H6Ekqr9pRHvBTKAPOMkogCjMWSsmFeztpEjEGmqHCMdd9bQJ
        XHI6ege6m7Z5yBq3vuldioWFFeJApi0mgS2oYgKByXXAH1IT94n49OadPWlzAzbzSoJVO7WVkEo
        JYLrFjxhb0wlPXDTAH2ZBfR1CDA==
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id m11-20020a7bcb8b000000b003fbe1893532mr591783wmi.20.1696367081195;
        Tue, 03 Oct 2023 14:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCEM3CW7oIUIpk49usru6wH655xRCmLet2S1OOC6d3hz6/2QR8k4YhBQDCY3vQccozPA5b7Q==
X-Received: by 2002:a7b:cb8b:0:b0:3fb:e189:3532 with SMTP id m11-20020a7bcb8b000000b003fbe1893532mr591768wmi.20.1696367080771;
        Tue, 03 Oct 2023 14:04:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c736:1b00:e1fc:b01b:70f5:1985? (p200300cbc7361b00e1fcb01b70f51985.dip0.t-ipconnect.de. [2003:cb:c736:1b00:e1fc:b01b:70f5:1985])
        by smtp.gmail.com with ESMTPSA id m11-20020a7bce0b000000b004064741f855sm23560wmc.47.2023.10.03.14.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 14:04:40 -0700 (PDT)
Message-ID: <2e2dfe74-8185-5f10-a5ce-5f6252ad0d42@redhat.com>
Date:   Tue, 3 Oct 2023 23:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
 <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.10.23 22:04, Suren Baghdasaryan wrote:
> On Mon, Oct 2, 2023 at 12:34 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>>
>> On Mon, Oct 2, 2023 at 6:43 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 02.10.23 17:55, Lokesh Gidra wrote:
>>>> On Mon, Oct 2, 2023 at 4:46 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>>>>>
>>>>> On Mon, Oct 2, 2023 at 4:21 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>
>>>>>> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
>>>>>>> In case we cannot simply remap the page, the fallback sequence (from the
>>>>>>> cover letter) would be triggered.
>>>>>>>
>>>>>>> 1) UFFDIO_COPY
>>>>>>> 2) MADV_DONTNEED
>>>>>>>
>>>>>>> So we would just handle the operation internally without a fallback.
>>>>>>
>>>>>> Note that I think there will be a slight difference on whole remap
>>>>>> atomicity, on what happens if the page is modified after UFFDIO_COPY but
>>>>>> before DONTNEED.
>>>>>>
>>>>>> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
>>>>>> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
>>>>>> during movement, and it will generate a missing event after moved, with
>>>>>> latest data showing up on dest.
>>>>>>
>>>>>> I'm not sure that means such a fallback is a problem, Suren may know
>>>>>> better with the use case.
>>>>>
>>>>> Although there is no problem in using fallback with our use case but
>>>>> as a user of userfaultfd, I'd suggest leaving it to the developer.
>>>>> Failing with appropriate errno makes more sense. If handled in the
>>>>> kernel, then the user may assume at the end of the operation that the
>>>>> src vma is completely unmapped. And if not correctness issues, it
>>>>> could lead to memory leaks.
>>>>
>>>> I meant that in addition to the possibility of correctness issues due
>>>> to lack of atomicity, it could also lead to memory leaks, as the user
>>>> may assume that src vma is empty post-operation. IMHO, it's better to
>>>> fail with errno so that the user would fix the code with necessary
>>>> changes (like using DONTFORK, if forking).
>>>
>>> Leaving the atomicity discussion out because I think this can just be
>>> handled (e.g., the src_vma would always be empty post-operation):
>>>
>>> It might not necessarily be a good idea to only expose micro-operations
>>> to user space. If the user-space fallback will almost always be
>>> "UFFDIO_COPY+MADV_DONTNEED", then clearly the logical operation
>>> performed is moving data, ideally with zero-copy.
>>>
>> IMHO, such a fallback will be useful only if it's possible that only
>> some pages in the src vma fail due to this. But even then it would be
>> really useful to have a flag maybe like UFFDIO_REMAP_FALLBACK_COPY to
>> control if the user wants the fallback or not. OTOH, if this is
>> something that can be detected for the entire src vma, then failing
>> with errno is more appropriate.
>>
>> Given that the patch is already quite complicated, I humbly suggest
>> leaving the fallback for now as a TODO.

I agree about the complexity, and I hope we can reduce that further. 
Otherwise such things end up being a maintainance nightmare.

> 
> Ok, I think it makes sense to implement the strict remap logic but in
> a way that we can easily add copy fallback if that's needed in the

I think whatever we do, we should

a) never talk about any of the implementation details (mapcount, 
swapcount, PAE) towards the users

b) make it clear from the start that we might change the decision when 
we fail (to the better or the worse); users should be prepared to 
implement backup paths. We certainly don't want such behavior to be ABI.

I'd suggest documenting something like the following

"The operation may fail for various reasons. Usually, remapping of pages 
that are not exclusive to the given process fail; once KSM might 
dedduplicate pages or fork() COW-shares pages during fork() with child 
processes, they are no longer exclusive. Further, the kernel might only 
perform lightweight checks for detecting whether the pages are 
exclusive, and return -EWHATSOEVER in case that check fails. To make the 
operation more likely to succeed, KSM should be disabled, fork() should 
be avoided or MADV_DONTFORK should be configured for the source VMA 
before fork()."

> future. So, I'll change UFFDIO_REMAP to UFFDIO_MOVE and will return
> some unique error, like EBUSY when the page is not PAE. If we need to
> add a copy fallback in the future, we will add a
> UFFDIO_MOVE_MODE_ALLOW_COPY flag and will implement the copy
> mechanism. Does that sound good?

To me, if we're talking about moving data, then zero-copy is the 
optimization and copy+delete would be the (slower) default.

If we're talking about remapping, then there is no copy; we're remapping 
pages.


So if we'd ever want to support the copy case, one combination would be

UFFDIO_MOVE + UFFDIO_MOVE_ZERO_COPY_ONLY

whereby we would fail if the latter is not specified.

But just my thoughts.

-- 
Cheers,

David / dhildenb

