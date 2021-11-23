Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694FE459ED9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 10:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKWJJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 04:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhKWJJT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:09:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94749C061574;
        Tue, 23 Nov 2021 01:06:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so88608126edv.1;
        Tue, 23 Nov 2021 01:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=F1MNEC3Zm1/pIEcv2UTnLR98/iLdaUYqO7rHMG7hrdo=;
        b=Jm9x7hgSTNjPI95TZAUBpStM6prfp4omw3ghFep8880iRmSAlHCDncfrvx0ZulBI0k
         uRF5cVosy0ZAOkN7k7DHR8RMikef0GsMjGQBfRTJwdkQbBMHTKC+8dQN1jtIFPu/LodB
         90BcipA2sMj4E5xYeVoMPvPdNt35Ov3ieONi6ofL5eaMrC06b5r69wta703vt/dp6HKl
         mOKyc1FX3+WeBazndttgraQfRx7Eyezb5K7ZBECIUI7je7n+CMTvD9S4yOGS7EgohGY2
         O5wumNy0wpF7upaxJWi4BEBUaXuKcq7lsh8+oCARlwW6EDQwTmq4rNCfdtxR2Wi17h0r
         PFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=F1MNEC3Zm1/pIEcv2UTnLR98/iLdaUYqO7rHMG7hrdo=;
        b=MGIR+4t+XHauazvp012J4faYkdty2b4DLUni458oB858zOIOgUkI8whiCtTQZmbZfG
         P1tK4Keh8eErZkOcxOhfIENxgAnu/KO6lvbTCQ95aTMedFdU3suPiXIfzbymOA5yekoH
         7hAYXtxzHaO2Dbh1bN8Vn8ZUbQoYpCGxUBleBvGkNWR28q4NuHWstzRNHu4Zb9AXYcSG
         BG26k8a+94fYZVmhbxkAAq68xzjHhyuurfwEpb4Ufp2nNAyv9ZdBHrCXUCRqu67tPLUk
         48TGISt5tQnQMYRkTRIQzvfcqnCRU6q1VIPgBZpu5JqbpleV8i1DWsQZqxeeJQPT9mUT
         tbhA==
X-Gm-Message-State: AOAM530JLg1Ovpb4ZTJzNSpQh6F4785NaIUxIJEEuwz+Wai5GquG4MaJ
        G/7VDof2zsKQmNNt0Bni5mc=
X-Google-Smtp-Source: ABdhPJzIThjxkju4L1CcQt8+JnyuJ4ximXnhRtdaj22BULFxN4ENlWBQUkSzm8vAQr99AxeWyw2Nkw==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr5448342ejc.275.1637658369748;
        Tue, 23 Nov 2021 01:06:09 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id mc3sm4956388ejb.24.2021.11.23.01.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 01:06:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
Date:   Tue, 23 Nov 2021 10:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Jonathan Corbet <corbet@lwn.net>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
In-Reply-To: <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 16:39, David Hildenbrand wrote:
>> If qmeu can put all the guest memory in a memfd and not map it, then
>> I'd also like to see that the IOMMU can use this interface too so we
>> can have VFIO working in this configuration.
> 
> In QEMU we usually want to (and must) be able to access guest memory
> from user space, with the current design we wouldn't even be able to
> temporarily mmap it -- which makes sense for encrypted memory only. The
> corner case really is encrypted memory. So I don't think we'll see a
> broad use of this feature outside of encrypted VMs in QEMU. I might be
> wrong, most probably I am:)

It's not _that_ crazy an idea, but it's going to be some work to teach 
KVM that it has to kmap/kunmap around all memory accesses.

I think it's great that memfd hooks are usable by more than one 
subsystem, OTOH it's fair that whoever needs it does the work---and VFIO 
does not need it for confidential VMs, yet, so it should be fine for now 
to have a single user.

On the other hand, as I commented already, the lack of locking in the 
register/unregister functions has to be fixed even with a single user. 
Another thing we can do already is change the guest_ops/guest_mem_ops to 
something like memfd_falloc_notifier_ops/memfd_pfn_ops, and the 
register/unregister functions to memfd_register/unregister_falloc_notifier.

Chao, can you also put this under a new CONFIG such as "bool MEMFD_OPS", 
and select it from KVM?

Thanks,

Paolo
