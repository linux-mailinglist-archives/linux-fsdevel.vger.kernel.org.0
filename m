Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A67B59DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjJBRoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJBRoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0577C90
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696268609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wp+uBb3vd++p/TELNcrTFrgdStWMZDT1c1gwMgRnAb0=;
        b=PRnD0d77mXz1UpQ7+H07YQa7ALwYdjwQTddnfYoYPn2kv+/LU6CrZdGcL7v2oXiE7iUsB4
        pH0jznBlVykXlfURc85uqoxIXr7vtvTIGE3642RJ6tmOteMpJEYZIn4Y1vlqQU9QlUz2/T
        zF8daEc3Fr3GWLMJfL9aRUnFE2HwSgI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-cqzuqd0NOCO5rQiziVBQTw-1; Mon, 02 Oct 2023 13:43:18 -0400
X-MC-Unique: cqzuqd0NOCO5rQiziVBQTw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-325a78c806eso38165f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 10:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268597; x=1696873397;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wp+uBb3vd++p/TELNcrTFrgdStWMZDT1c1gwMgRnAb0=;
        b=hAItDNRV1+S91I2JoxS/J8hzqsGTHvhj0hYXPr1LdnyZPRe3clELsPNY3IvFqorBAc
         lAQ0/kQSUGfSgH9lMzpwp3uq2IyQt/fdAD87pDvDiFSoqX0iE7VszJE7BD0QikMXHeQh
         2/rAyivk8WX7g+7+JCXJ5KovGdPpIBQ0OHnpkE4j5Vv6hZokv5e6TZ8UqKibLxBgeBJV
         kPjhTjMxElN2JXM/ZCrGhhrf0K7oXhcP0wM8nQ993abmisSXb+zX364mUvm0EeZSAmcL
         duTmFmqRRrQLB84ONPXAR887xYCic/HpWoeXTetlz5PifViEHS9h5a4fa+d3aKYQTWy9
         lg7g==
X-Gm-Message-State: AOJu0YyYXYt/Q5bWw3pV0jqwDIaOhmRnVLK1VqAinloa3edYPXmoeXnA
        zxvaC4dVAAZLH6w6QcWeVOo51BufqoX3eqZMTksh2DaL3zzr3RBF3DS5RTJ5eJGx2TzBwtUlZM5
        7GukZxinQpK3LZIIa1qZqEcSDdA==
X-Received: by 2002:a5d:6306:0:b0:31f:eed7:2fdc with SMTP id i6-20020a5d6306000000b0031feed72fdcmr9669346wru.35.1696268596933;
        Mon, 02 Oct 2023 10:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlnYfzZHHUMm6vDazX7X6pg+Hfr/KO2FNcqHXBe1PdnVdfBy7vPvSIlNwDZzVhMT/U34rc2w==
X-Received: by 2002:a5d:6306:0:b0:31f:eed7:2fdc with SMTP id i6-20020a5d6306000000b0031feed72fdcmr9669316wru.35.1696268596482;
        Mon, 02 Oct 2023 10:43:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id m12-20020a056000174c00b003233b554e6esm14288618wrf.85.2023.10.02.10.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:43:16 -0700 (PDT)
Message-ID: <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
Date:   Mon, 2 Oct 2023 19:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Lokesh Gidra <lokeshgidra@google.com>, Peter Xu <peterx@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.10.23 17:55, Lokesh Gidra wrote:
> On Mon, Oct 2, 2023 at 4:46 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>>
>> On Mon, Oct 2, 2023 at 4:21 PM Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
>>>> In case we cannot simply remap the page, the fallback sequence (from the
>>>> cover letter) would be triggered.
>>>>
>>>> 1) UFFDIO_COPY
>>>> 2) MADV_DONTNEED
>>>>
>>>> So we would just handle the operation internally without a fallback.
>>>
>>> Note that I think there will be a slight difference on whole remap
>>> atomicity, on what happens if the page is modified after UFFDIO_COPY but
>>> before DONTNEED.
>>>
>>> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, threads
>>> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lost
>>> during movement, and it will generate a missing event after moved, with
>>> latest data showing up on dest.
>>>
>>> I'm not sure that means such a fallback is a problem, Suren may know
>>> better with the use case.
>>
>> Although there is no problem in using fallback with our use case but
>> as a user of userfaultfd, I'd suggest leaving it to the developer.
>> Failing with appropriate errno makes more sense. If handled in the
>> kernel, then the user may assume at the end of the operation that the
>> src vma is completely unmapped. And if not correctness issues, it
>> could lead to memory leaks.
> 
> I meant that in addition to the possibility of correctness issues due
> to lack of atomicity, it could also lead to memory leaks, as the user
> may assume that src vma is empty post-operation. IMHO, it's better to
> fail with errno so that the user would fix the code with necessary
> changes (like using DONTFORK, if forking).

Leaving the atomicity discussion out because I think this can just be 
handled (e.g., the src_vma would always be empty post-operation):

It might not necessarily be a good idea to only expose micro-operations 
to user space. If the user-space fallback will almost always be 
"UFFDIO_COPY+MADV_DONTNEED", then clearly the logical operation 
performed is moving data, ideally with zero-copy.

[as said as reply to Peter, one could still have magic flags for users 
that really want to detect when zero-copy is impossible]

With a logical MOVE API users like compaction [as given in the cover 
letter], not every such user has to eventually implement fallback paths.

But just my 2 cents, the UFFDIO_REMAP users probably can share what the 
exact use cases are and if fallbacks are required at all or if no-KSM + 
DONTFORK just does the trick.

-- 
Cheers,

David / dhildenb

