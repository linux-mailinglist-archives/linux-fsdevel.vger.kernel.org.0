Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E04590A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhKVPAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:00:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232494AbhKVPAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637593043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6sxP8BbpsAMN/5roSu3j/ZWT90syA5vCmiIsqjbMtk=;
        b=CTZzBYOj9NMS5ihn+fb5DQ0CxKjOREYArVSwooh1gGYa7KVAOl/GRdo+Lm3TQbPQ0N5RMX
        trHokDDWh6MqpRVL150h4rHCDPS8CKctvHJXt7xOcml7yfI84XG/1CzOa+lx8Ku+yVMg34
        1mEDWYR0JMwosIttyQ5pqFLcz9/tpK8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-123-GN8Ubqx1NTefQC_Iw42nkw-1; Mon, 22 Nov 2021 09:57:22 -0500
X-MC-Unique: GN8Ubqx1NTefQC_Iw42nkw-1
Received: by mail-wr1-f72.google.com with SMTP id f3-20020a5d50c3000000b00183ce1379feso3159582wrt.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 06:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=a6sxP8BbpsAMN/5roSu3j/ZWT90syA5vCmiIsqjbMtk=;
        b=z0MEQ5NqpNANTlm5UmgIk9U8R34DjU1/xUMdBZoX7IGbxQBRN9doHMtSDyjYV6znmx
         LNKj6D1qwcwVdzbjDtl03v/RQkrxeSRj454AKZvwFT/RN6o9LP78LJbPjVycY+AFJQao
         jnCKbL2VcdOxF3l5WKfw1w7Zip6amVTmt7jF9dFzxXe/eAzcU7S32rzRQGFbT++COQMm
         SrduGcGAYFu8gatbBLo44QshRwIDfY5vZLDJNgjZuK1uxtaocmwWa2FdZyM8CqvkIXUz
         S5X5V0Cecd//N4vz7AhRdQDeAUHa5AzS9x1uc/Mma8AVgRZ0NagUpOobAE6zENA2Ue8A
         rE3g==
X-Gm-Message-State: AOAM532F2h+qA+qkkVJ6QwHFmPzyA6S1eG9FZyIDbkrYQHp4HNn9UMTE
        Ap94E1Y1xp2/NrnE+jOyKCkw25kViWmqB9lS/1Bgc8Wq9wy/mNhzn7OJ3l5mKPyVBupJHPvrw0B
        a5DGRS+B+nOvY3CeYsWB6nu5LJA==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr29900023wmj.91.1637593040912;
        Mon, 22 Nov 2021 06:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzb1fVkmOhpRnzBJsEnrS5eq+nBwa2MfaKvZWrzzGVY0sVj4OHkUiEBZAugOc7zSp386W7pog==
X-Received: by 2002:a7b:ce8c:: with SMTP id q12mr29899978wmj.91.1637593040715;
        Mon, 22 Nov 2021 06:57:20 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id s63sm10249585wme.22.2021.11.22.06.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 06:57:20 -0800 (PST)
Message-ID: <d2b46b84-8930-4304-2946-4d4a16698b24@redhat.com>
Date:   Mon, 22 Nov 2021 15:57:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <20211119160023.GI876299@ziepe.ca>
 <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
 <20211122133145.GQ876299@ziepe.ca>
 <56c0dffc-5fc4-c337-3e85-a5c9ce619140@redhat.com>
 <20211122140148.GR876299@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211122140148.GR876299@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.11.21 15:01, Jason Gunthorpe wrote:
> On Mon, Nov 22, 2021 at 02:35:49PM +0100, David Hildenbrand wrote:
>> On 22.11.21 14:31, Jason Gunthorpe wrote:
>>> On Mon, Nov 22, 2021 at 10:26:12AM +0100, David Hildenbrand wrote:
>>>
>>>> I do wonder if we want to support sharing such memfds between processes
>>>> in all cases ... we most certainly don't want to be able to share
>>>> encrypted memory between VMs (I heard that the kernel has to forbid
>>>> that). It would make sense in the use case you describe, though.
>>>
>>> If there is a F_SEAL_XX that blocks every kind of new access, who
>>> cares if userspace passes the FD around or not?
>> I was imagining that you actually would want to do some kind of "change
>> ownership". But yeah, the intended semantics and all use cases we have
>> in mind are not fully clear to me yet. If it's really "no new access"
>> (side note: is "access" the right word?) then sure, we can pass the fd
>> around.
> 
> What is "ownership" in a world with kvm and iommu are reading pages
> out of the same fd?

In the world of encrypted memory / TDX, KVM somewhat "owns" that memory
IMHO (for example, only it can migrate or swap out these pages; it's
might be debatable if the TDX module or KVM actually "own" these pages ).

-- 
Thanks,

David / dhildenb

