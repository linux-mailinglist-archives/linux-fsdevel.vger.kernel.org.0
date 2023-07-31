Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C69769B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjGaP7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjGaP66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3F1732
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690819094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fe6hbS0UUlu2v7dj0yh2sFuv9miEav3h35iCM+LzrA=;
        b=aUQq25fVqVWRGJcq14zax3WJWOdERpcRUDxaubSMjuwjb4gcPLAOGJbyxtCDwkniCKlJ3A
        34Ri8Ndk4IgrJ6ACHR9Izl47SEjcAo7ESiNsQo6KC2L9xOGNOPqpvy7Vg35yslyEbhA5Ms
        /snhZhML6Csfbsbcb9TXSuqmd5USAgY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-f6y33eEYMWedi9cZG4vFHg-1; Mon, 31 Jul 2023 11:58:12 -0400
X-MC-Unique: f6y33eEYMWedi9cZG4vFHg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c0bd2ca23so110736066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 08:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690819091; x=1691423891;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fe6hbS0UUlu2v7dj0yh2sFuv9miEav3h35iCM+LzrA=;
        b=IDtgRV0Gp50KVWyjgzbQjplTgXMbnlUOquHCeMNORqoaKwNu114yGwkl5WB2uShq9R
         UbFhPjIehvifvpUgwVXlXvYIEgd0/gJreDXZTfEwLRIQMcDpUVGG2FvfPHL77NbTO/DR
         1IwY8Hnv11xwRSy84PlbUeuKJbM2W0ozmPjcAXwe+O4iIshCvu02goOHVBFzh5qT5nGB
         lnafIZCFsVnNub45Hd9K6JPeoYAdVZhOfrju+u2l2DjGtsnGgwoewy996+gqyu4FjU44
         FQV4TBmdGaUBzEIIEgrLDZOzuGNCX/ShTu1qtC8yNcIJFqy8yNGVTJQiuXzH+ZKknYrW
         FknQ==
X-Gm-Message-State: ABy/qLblIWShX/q7jX5/JfnChiUAfQatjo2NqSIwewBeC7am0FXjDbK8
        orZq4osEql/F2XjMjA2DjFxcjbnpJ2IqVCHNOEC6XNwVCpwNLma6vLN1avPmOfL7HJTo1PZQqlX
        Gy7ZqKpSSuwlE4iRze1LKWfX5hw==
X-Received: by 2002:a17:906:11:b0:993:f744:d235 with SMTP id 17-20020a170906001100b00993f744d235mr164004eja.6.1690819091656;
        Mon, 31 Jul 2023 08:58:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4qcb0DCH0D/UYAr1wihMNcJs7WXVHvdtoT78VyrDkWJveoJUy2CwgTeDnMx93k7Ts+Uy66g==
X-Received: by 2002:a17:906:11:b0:993:f744:d235 with SMTP id 17-20020a170906001100b00993f744d235mr163994eja.6.1690819091362;
        Mon, 31 Jul 2023 08:58:11 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f21-20020a170906139500b00992dcae806bsm6371003ejc.5.2023.07.31.08.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 08:58:10 -0700 (PDT)
Message-ID: <eb356cf1-c661-930b-2175-427a59267d1f@redhat.com>
Date:   Mon, 31 Jul 2023 17:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-7-seanjc@google.com> <ZMOJgnyzzUNIx+Tn@google.com>
 <ZMRXVZYaJ9wojGtS@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v11 06/29] KVM: Introduce KVM_SET_USER_MEMORY_REGION2
In-Reply-To: <ZMRXVZYaJ9wojGtS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/29/23 02:03, Sean Christopherson wrote:
> KVM would need to do multiple uaccess reads, but that's not a big
> deal.  Am I missing something, or did past us just get too clever and
> miss the obvious solution?

You would have to introduce struct kvm_userspace_memory_region2 anyway, 
though not a new ioctl, for two reasons:

1) the current size of the struct is part of the userspace API via the 
KVM_SET_USER_MEMORY_REGION #define, so introducing a new struct is the 
easiest way to preserve this

2) the struct can (at least theoretically) enter the ABI of a shared 
library, and such mismatches are really hard to detect and resolve.  So 
it's better to add the padding to a new struct, and keep struct 
kvm_userspace_memory_region backwards-compatible.


As to whether we should introduce a new ioctl: doing so makes 
KVM_SET_USER_MEMORY_REGION's detection of bad flags a bit more robust; 
it's not like we cannot introduce new flags at all, of course, but 
having out-of-bounds reads as a side effect of new flags is a bit nasty. 
  Protecting programs from their own bugs gets into diminishing returns 
very quickly, but introducing a new ioctl can make exploits a bit harder 
when struct kvm_userspace_memory_region is on the stack and adjacent to 
an attacker-controlled location.

Paolo

