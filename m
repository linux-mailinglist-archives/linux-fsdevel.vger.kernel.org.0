Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB257B4D04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjJBIA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjJBIA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B33BD
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696233608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hMwBDQxPqEr2KGnCZRjOsa4DbxGMCcRw1+qHGhTgF8=;
        b=dlkSa/MBKxMnCmVhC4xqTA85+AtEDORgMq5Z8lSyuaCZEaqeDXNDmbsVe33SdTvE7ohOEs
        fDP2eG/2kdW7mWUujW39ujQqfr1nQSZXW0wt7PjZjjIUGdTOZRjbwHl7pBjSl9iVzt18+B
        8lOO1BDF3YLZ5cKeBw6vblOVsWwD0l0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-tGhoYZ7zNyu4nIH4EvSz3A-1; Mon, 02 Oct 2023 04:00:06 -0400
X-MC-Unique: tGhoYZ7zNyu4nIH4EvSz3A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-405535740d2so120332395e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 01:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696233605; x=1696838405;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hMwBDQxPqEr2KGnCZRjOsa4DbxGMCcRw1+qHGhTgF8=;
        b=PggHR+fxYnrl6S6hTqbIjhp59RdaU+WUXWQ6BjQIBKv5FUjGxtkWZW8/ipKFkb6L+c
         iXxUAYKVACmBqZvykA2x0J+U9sd1K1Sg2uxwVBEgR5L8rMUVrgyPoY3Q3VQuuZafCoJx
         ekoMK4HmklZaNvB5yv6eGSmMNwIpEdW7gpQ0NJj2/RkTaBCpOo6rRB5prbgXxPJ4v+Kr
         Q8JCx1oDyq2BnV5UlkO0UAZvGzuauh08Ri/awaV53cl4uSZztmi7WUtfZXmEWfp+sBd4
         HgscJgUnQbyJB3iVNR7ulHqBPApnQwoxbwuo/llfWGEjVaARIEgE+2YLY822BVch+Yhy
         17+Q==
X-Gm-Message-State: AOJu0YwUS6rSo0YGJvDoYWo2ERMEtsAi2XrINRqVK0Xh2JByTb7WGDbn
        J2YsZ/1Mox80LiJaVIEhnpf4cbS4p+lH7DCa0A3qJAjDpK6h9QziKgcZDECZqMZrgIodL+C2oxy
        VYYMDiwVQZMat/zAHGNLElu60Vw==
X-Received: by 2002:a05:600c:ac1:b0:402:f501:447c with SMTP id c1-20020a05600c0ac100b00402f501447cmr9457531wmr.0.1696233605520;
        Mon, 02 Oct 2023 01:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLXTkL+9EEt3zHQk5ZsLeQprJDYGJsst31lbLdGGFpUez2Jqfmw0gPneDp6ON/b1DJjaaQzg==
X-Received: by 2002:a05:600c:ac1:b0:402:f501:447c with SMTP id c1-20020a05600c0ac100b00402f501447cmr9457493wmr.0.1696233604995;
        Mon, 02 Oct 2023 01:00:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b004063cced50bsm6701171wmi.23.2023.10.02.01.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 01:00:04 -0700 (PDT)
Message-ID: <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com>
Date:   Mon, 2 Oct 2023 10:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <ZRXHK3hbdjfQvCCp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.09.23 20:34, Peter Xu wrote:
> On Thu, Sep 28, 2023 at 07:51:18PM +0200, David Hildenbrand wrote:
>> On 28.09.23 19:21, Peter Xu wrote:
>>> On Thu, Sep 28, 2023 at 07:05:40PM +0200, David Hildenbrand wrote:
>>>> As described as reply to v1, without fork() and KSM, the PAE bit should
>>>> stick around. If that's not the case, we should investigate why.
>>>>
>>>> If we ever support the post-fork case (which the comment above remap_pages()
>>>> excludes) we'll need good motivation why we'd want to make this
>>>> overly-complicated feature even more complicated.
>>>
>>> The problem is DONTFORK is only a suggestion, but not yet restricted.  If
>>> someone reaches on top of some !PAE page on src it'll never gonna proceed
>>> and keep failing, iiuc.
>>
>> Yes. It won't work if you fork() and not use DONTFORK on the src VMA. We
>> should document that as a limitation.
>>
>> For example, you could return an error to the user that can just call
>> UFFDIO_COPY. (or to the UFFDIO_COPY from inside uffd code, but that's
>> probably ugly as well).
> 
> We could indeed provide some special errno perhaps upon the PAE check, then
> document it explicitly in the man page and suggest resolutions (like
> DONTFORK) when user hit it.
> 

Maybe it might be reasonable to consider an operation that moves the 
page, even if it might do an internal copy. UFFDIO_MOVE might be a 
better name for something like that.

In case we cannot simply remap the page, the fallback sequence (from the 
cover letter) would be triggered.

1) UFFDIO_COPY
2) MADV_DONTNEED

So we would just handle the operation internally without a fallback.

The recommendation to the user to make the overall operation as fast as 
possible would be to not use KSM, to avoid fork(), or to use 
MADV_DONTFORK when fork() must be used.


-- 
Cheers,

David / dhildenb

