Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFEF7B2463
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjI1RwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjI1RwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBE1A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695923483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95cgsBpE/c9mQyni+eRrbJAAJxH4nZT5sQdvz0Yfag8=;
        b=Ki3Zpj4YagtDbLJJBpS7nxtaA4a5pnZRV5TxX+/uvmLApDqhOX7ucuhCEeRgT0472UgWlZ
        ke7fWqCEKMaL10z3uvCKVeE9wrC4ZN8glfeYDpJuZvIYa8JThpVCyP2VCIC/wxyEyQqT6y
        fmxxwf+RRMI4hoRS46GnyqBeETAGDjo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-L_xxglMBM3OIUvIm_SsPhA-1; Thu, 28 Sep 2023 13:51:22 -0400
X-MC-Unique: L_xxglMBM3OIUvIm_SsPhA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-317d5b38194so6428888f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 10:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695923481; x=1696528281;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95cgsBpE/c9mQyni+eRrbJAAJxH4nZT5sQdvz0Yfag8=;
        b=vm4U83horucqD6+eao/nbCS7MIODsk17p+4l2LlulloB9YHQBGgPMgTgDK9qkMz0OA
         ifgTelWmkUiL+DGL8UHuZD+TcjChjrXE5oMuDrMfaJoBOhwi1ZCYIZVXTlXEJto9tc/C
         S6yGrTnnq3MXRYB70vKthK9Tx+0/RuqlV+rEGGszaTavxL/4JHj+UlJsXGtHbiJ7GZWo
         NNvWNokJC5TJZcWceq1WnfkBIAzJiGUrs7kRHZlhV0AUFNxtrykoa7uzgMJrNwsp0ijx
         vM8kThxpGlLx4gvh+z6oB6YreSkXyQVcaqUb35xLVNN9enRRGQgNmP7KMzYTxY79mp7B
         zwLQ==
X-Gm-Message-State: AOJu0YyCkC+dIpaYOMxe/UBdSsYOKjvHCL7Bi1ejN++YAYr1HdvmX0zP
        SXy0txYw/sDdzG2ecfyA6aERLfVMYopZ60iBcXYiNBtdIZAs/QguUtFmgBqn61xaSnGZvMsze8U
        iVsEEkaqVXoFWaTL9wYBz59k/vA==
X-Received: by 2002:a05:6000:120f:b0:31f:ffe3:b957 with SMTP id e15-20020a056000120f00b0031fffe3b957mr1698510wrx.31.1695923481149;
        Thu, 28 Sep 2023 10:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYcuBaOu3jvw3GrSl/OuumCYTHTHQoVIIWotVFgz3Bzwq6L9eXfAvgxP8GhDuGA2gj4SKzuw==
X-Received: by 2002:a05:6000:120f:b0:31f:ffe3:b957 with SMTP id e15-20020a056000120f00b0031fffe3b957mr1698482wrx.31.1695923480663;
        Thu, 28 Sep 2023 10:51:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:f00:b37d:4253:cd0d:d213? (p200300cbc7180f00b37d4253cd0dd213.dip0.t-ipconnect.de. [2003:cb:c718:f00:b37d:4253:cd0d:d213])
        by smtp.gmail.com with ESMTPSA id m26-20020a056000025a00b003233a31a467sm6288708wrz.34.2023.09.28.10.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:51:20 -0700 (PDT)
Message-ID: <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com>
Date:   Thu, 28 Sep 2023 19:51:18 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
In-Reply-To: <ZRW2CBUDNks9RGQJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.09.23 19:21, Peter Xu wrote:
> On Thu, Sep 28, 2023 at 07:05:40PM +0200, David Hildenbrand wrote:
>> As described as reply to v1, without fork() and KSM, the PAE bit should
>> stick around. If that's not the case, we should investigate why.
>>
>> If we ever support the post-fork case (which the comment above remap_pages()
>> excludes) we'll need good motivation why we'd want to make this
>> overly-complicated feature even more complicated.
> 
> The problem is DONTFORK is only a suggestion, but not yet restricted.  If
> someone reaches on top of some !PAE page on src it'll never gonna proceed
> and keep failing, iiuc.

Yes. It won't work if you fork() and not use DONTFORK on the src VMA. We 
should document that as a limitation.

For example, you could return an error to the user that can just call 
UFFDIO_COPY. (or to the UFFDIO_COPY from inside uffd code, but that's 
probably ugly as well).

> 
> do_wp_page() doesn't have that issue of accuracy only because one round of
> CoW will just allocate a new page with PAE set guaranteed, which is pretty
> much self-heal and unnoticed.

Yes. But it might have to copy, at which point the whole optimization of 
remap is gone :)

> 
> So it'll be great if we can have similar self-heal way for PAE.  If not, I
> think it's still fine we just always fail on !PAE src pages, but then maybe
> we should let the user know what's wrong, e.g., the user can just forgot to
> apply DONTFORK then forked.  And then the user hits error and don't know
> what happened.  Probably at least we should document it well in man pages.
> 
Yes, exactly.

> Another option can be we keep using folio_mapcount() for pte, and another
> helper (perhaps: _nr_pages_mapped==COMPOUND_MAPPED && _entire_mapcount==1)
> for thp.  But I know that's not ideal either.

As long as we only set the pte writable if PAE is set, we're good from a 
CVE perspective. The other part is just simplicity of avoiding all these 
mapcount+swapcount games where possible.

(one day folio_mapcount() might be faster -- I'm still working on that 
patch in the bigger picture of handling PTE-mapped THP better)

-- 
Cheers,

David / dhildenb

