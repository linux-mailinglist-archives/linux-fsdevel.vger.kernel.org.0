Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9C4FFB54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiDMQdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiDMQdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 428B846666
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649867453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpsTDUjpmmHkgiKCF75tJ9Qb2QqmtHwjLJW7Lijr6Ec=;
        b=cNCbHTmqTb8bPVzu3CxkRyurrghpw3o5MLA01vLKGEsCpSreBiBEXUa5ImJDFNdZP1QIfx
        SfRGVuteoZfl5E6SXQXu9LtzIk8UdNg0VIEZwONoBUbykOGy/AltUjbDXCZftYXpH8H+3x
        imP2tsX6Lno33D2AYWaV22HNT5Hd/Dc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-J3JT1fWwPGyfhBGTBK12DQ-1; Wed, 13 Apr 2022 12:30:51 -0400
X-MC-Unique: J3JT1fWwPGyfhBGTBK12DQ-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so999608wmj.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 09:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=JpsTDUjpmmHkgiKCF75tJ9Qb2QqmtHwjLJW7Lijr6Ec=;
        b=Oz6mNHDRn9cDG60F407VBgijDxUDOoe0Tw1Gmy0WU1x7X0O9s+BHxnTDvZQ/XBB1sp
         5xJeywwy91X5a969x1P0p8xRBiVt76COT1vPSFbJuhxzNjAOekQLzysQfKtMdlS/C6+Y
         U+Izmy9yq6PadUJ/GZZkNiqAe+4gAH1Iz/2fltFvb1otFD5gX9mFo14sCTA5TS5VKNf4
         iMTXnsPHCkdNpZEcwUuA2HCoY4wQUxnLSK0PTwoghU4wQcOdywNOeRQ/R17ATPTm18ld
         1ld7b/UiMD//2eq1Y5SIhduxQQWEAQoIoXeVHreOcRx2mxgBHZB/DSp4rojGyrFWa14p
         9WEA==
X-Gm-Message-State: AOAM531FjUQ5eam6RDI/1geazSHpgIUDKrUeaRbGHVcjSfd+TIDPoP6B
        6TPPyfe7u8OAwW3QJUOUZIiYqbTln3H9E17y/d+A62oGbah7PD3w/X1b1cUrofAn4Qg5yBk+Hig
        8lNN9+rG7zaO1POYZRVa0tms1fw==
X-Received: by 2002:a05:600c:3512:b0:38c:be56:fc9c with SMTP id h18-20020a05600c351200b0038cbe56fc9cmr9458245wmq.197.1649867450693;
        Wed, 13 Apr 2022 09:30:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkytZT68ibSBKNJoHlOqbNjWnA9Zh1oDwEE8SJcMIkEgIwTu5PARnU1fLD1KJu/KXuQqJYmA==
X-Received: by 2002:a05:600c:3512:b0:38c:be56:fc9c with SMTP id h18-20020a05600c351200b0038cbe56fc9cmr9458202wmq.197.1649867450341;
        Wed, 13 Apr 2022 09:30:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5800:1078:ebb9:e2c3:ea8c? (p200300cbc70458001078ebb9e2c3ea8c.dip0.t-ipconnect.de. [2003:cb:c704:5800:1078:ebb9:e2c3:ea8c])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0038cb98076d6sm3269751wmg.10.2022.04.13.09.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:30:49 -0700 (PDT)
Message-ID: <3b9effd9-4aba-e7ca-b3ca-6a474fd6469f@redhat.com>
Date:   Wed, 13 Apr 2022 18:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
 <YlB3Z8fqJ+67a2Ck@google.com>
 <7ab689e7-e04d-5693-f899-d2d785b09892@redhat.com>
 <20220412143636.GG64706@ziepe.ca>
 <6f44ddf9-6755-4120-be8b-7a62f0abc0e0@www.fastmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
In-Reply-To: <6f44ddf9-6755-4120-be8b-7a62f0abc0e0@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> So this is another situation where the actual backend (TDX, SEV, pKVM, pure software) makes a difference -- depending on exactly what backend we're using, the memory may not be unmoveable.  It might even be swappable (in the potentially distant future).

Right. And on a system without swap we don't particularly care about
mlock, but we might (in most cases) care about fragmentation with
unmovable memory.

> 
> Anyway, here's a concrete proposal, with a bit of handwaving:

Thanks for investing some brainpower.

> 
> We add new cgroup limits:
> 
> memory.unmoveable
> memory.locked
> 
> These can be set to an actual number or they can be set to the special value ROOT_CAP.  If they're set to ROOT_CAP, then anyone in the cgroup with capable(CAP_SYS_RESOURCE) (i.e. the global capability) can allocate movable or locked memory with this (and potentially other) new APIs.  If it's 0, then they can't.  If it's another value, then the memory can be allocated, charged to the cgroup, up to the limit, with no particular capability needed.  The default at boot is ROOT_CAP.  Anyone who wants to configure it differently is free to do so.  This avoids introducing a DoS, makes it easy to run tests without configuring cgroup, and lets serious users set up their cgroups.

I wonder what the implications are for existing user space.

Assume we want to move page pinning (rdma, vfio, io_uring, ...) to the
new model. How can we be sure

a) We don't break existing user space
b) We don't open the doors unnoticed for the admin to go crazy on
   unmovable memory.

Any ideas?

> 
> Nothing is charge per mm.
> 
> To make this fully sensible, we need to know what the backend is for the private memory before allocating any so that we can charge it accordingly.

Right, the support for migration and/or swap defines how to account.

-- 
Thanks,

David / dhildenb

