Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E941A078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhI0Ur0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 16:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237078AbhI0UrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632775544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXVqJbv8Jttk1+XcooW+mbayYSjb6BfIJ+KhdOYULFQ=;
        b=XDCilIPnG1PeNY+fmSmALCtduIzLoCLTLHiyACpac6M1IV9qwT58Bc5cqHsr6SaKyn4CEh
        WUuB/gjnHWG6wFFYgIpN8EFyoD6iFjCkHgr5DoXD4etJvVZ5aB4G/1JRF3jtTIdqxNG+sQ
        PKJ5KSP18ypfk8nrGsR6IgDVI3UxHvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-jUWXgS2DNuK0PrJRUqvVoA-1; Mon, 27 Sep 2021 16:45:42 -0400
X-MC-Unique: jUWXgS2DNuK0PrJRUqvVoA-1
Received: by mail-wr1-f70.google.com with SMTP id c8-20020adfef48000000b00160646ed62cso2827289wrp.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 13:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YXVqJbv8Jttk1+XcooW+mbayYSjb6BfIJ+KhdOYULFQ=;
        b=ndeG9zGQY5US7/AQw3iH+RnX91yWY1tuC4P7RF6/h3Yul2bSF0UEkuAK6RB3pKAPyb
         BML0BJdqU41Be590/h3MptVW4h9SC6mmhbW9pQFHoJmI9MmG4zZB5rVsmB/7Ym+r4he1
         Q/Ka4ss9yydD6Jz9SrNNxi3ppYYIwia63wAkqV8tB4HB+9O6P5wpH6Gk3SXQGdEEE1DF
         ePK2/FWgB8PHZBl1eSrZUDT9n7CxnENp9DjNteHIKMSOhnLY0hsyIw07PmkQcb1sPE7/
         7FwViPAMQLLumCMWEhShjNWW9L4fwkn5P6OAFf5t2v6sLVP7vL/oAtfePVf0p0iY9ww5
         l52A==
X-Gm-Message-State: AOAM531Na1V2Vbq9vgQfrGnnx4KjLU/OYdE3ZL+YSKDs/8YlX5ybbV7d
        PEhrr0iDJPuKbe+CbJwL9MUku+px2iDwKF/YGVdhHnpBGmuZXJc5RHH3GgDVpEtzILOOrQWV1vB
        77tQWCJrpVIa6y1uI8QgNMDKOwQ==
X-Received: by 2002:a1c:a552:: with SMTP id o79mr1074632wme.170.1632775541680;
        Mon, 27 Sep 2021 13:45:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKEMNt92BGbVGYI5r1wEmrDVxXlyGPFZ1tToLeSujUndYhXBh9fSeCg0QN1nPPYbzj7Wuqig==
X-Received: by 2002:a1c:a552:: with SMTP id o79mr1074611wme.170.1632775541475;
        Mon, 27 Sep 2021 13:45:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id v18sm501361wml.44.2021.09.27.13.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:45:40 -0700 (PDT)
Subject: Re: Struct page proposal
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIFNf/xZwlrWstK@moria.home.lan>
 <CAHk-=wjaL3xcv6LL=1+WdaicaDngvNOTCYU5c9UF_MTsibWBSw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9e3b16f6-bb54-5bcc-1664-2ecb61424018@redhat.com>
Date:   Mon, 27 Sep 2021 22:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjaL3xcv6LL=1+WdaicaDngvNOTCYU5c9UF_MTsibWBSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.09.21 20:34, Linus Torvalds wrote:
> On Mon, Sep 27, 2021 at 10:54 AM Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
>>
>> That list_head is the problematic one. Why do we need to be able to take a page
>> from the middle of a freelist?
> 
> At least for the merging with the buddy page case.

And alloc_contig_range(), page reporting, page poisioning ... and 
probably more.

-- 
Thanks,

David / dhildenb

