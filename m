Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8585763F87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 21:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjGZT2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGZT2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:28:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD32D43
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 12:28:13 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbd4f526caso898755ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690399693; x=1691004493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT2UHI+2Np7L7QsdeetNAkLhraffv5kgEdfCjKl11Yk=;
        b=VVF1b7RUawi3/QYYQt22u1jH5OUH1Tf8XnLnE4b/agwXthOwpe69728aWprc+cBAPp
         m1NzpejyJPFn+J7cEl/k4Xfw7NV/DNs921DAj4mD25qN63m2UV8rxLRjeMa24TJWqXH7
         YevHJEPTBXycw8cNMxRiQayY5davffRodPeaquNPMlG3yhTbW+l2TZNv0KoNxIAjUf1u
         vx7QnvYOOpb+Nn9iea9EFg+zAfgVPq5/2O4eLtzlraYz5aepPr1S1PEGRUkv/ClpXjx1
         oD0KN8QbT88DXT6sIsMyGXbNhhlwFsmmZRUM0BDYakuaZeCUCb/tpsShC/zQA5q7Janp
         MXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690399693; x=1691004493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JT2UHI+2Np7L7QsdeetNAkLhraffv5kgEdfCjKl11Yk=;
        b=lSRW3yv4JCf/FOkMRbAUglg3rem6hjJxhydMg8A5WegxmHjUc1mWDc+IQC9HRFHWEK
         XAurJyRsltco3Zsm0f+7uuSDvpfEscilSo144qeMHBw5PUCM+9RhJJo/fMsBNVi6BGUX
         d9kcklo+PQ6fKEMrLamvpxod2Y7cVy26Z1ZTi6mycVY1FeEnJv99jW/GmVOBvJioRAL9
         0kWksLqbgTE/pkFz7IvAvgiimIojGdIY7KqGD6Ia8KmngvGLK+onxzkG3PVOvtldvPzs
         Lgn+wQ8t+dfKLfEJvJLbp0rSnMCdy3XnStygjF4OsggWSwWbnIu0KzoRrYZAqxnzl4kb
         Y0Hg==
X-Gm-Message-State: ABy/qLa03lOwNCS963jpT+IejUXrtTEz9TBA2zzVxeXoJ3L8c7wB8vhz
        Xq/gCAGzxI4lThRRInWF8VhF0+RrcME=
X-Google-Smtp-Source: APBJJlGcmwLcdH6TXOymYc9nTB5UyZup+2YRvQp3iON5gHoKZStwU7nqu5mwxNJ6DvyQEbhf1ifDNjwDMJ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce8b:b0:1b8:2055:fc1f with SMTP id
 f11-20020a170902ce8b00b001b82055fc1fmr13036plg.2.1690399693010; Wed, 26 Jul
 2023 12:28:13 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:28:11 -0700
In-Reply-To: <8f7ea958-7caa-a185-10d2-900024aeddf0@quicinc.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-13-seanjc@google.com>
 <8f7ea958-7caa-a185-10d2-900024aeddf0@quicinc.com>
Message-ID: <ZMFzyy5mZVxLn4uo@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023, Elliot Berman wrote:
> 
> 
> On 7/18/2023 4:44 PM, Sean Christopherson wrote:
> > TODO
>  <snip>
> > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > index 6325d1d0e90f..15041aa7d9ae 100644
> > --- a/include/uapi/linux/magic.h
> > +++ b/include/uapi/linux/magic.h
> > @@ -101,5 +101,6 @@
> >   #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
> >   #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
> >   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> > +#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */
> 
> 
> Should this be:
> 
> #define GUEST_MEMORY_KVM_MAGIC
> 
> or KVM_GUEST_MEMORY_KVM_MAGIC?
> 
> BALLOON_KVM_MAGIC is KVM-specific few lines above.

Ah, good point.  My preference would be either KVM_GUEST_MEMORY_MAGIC or
KVM_GUEST_MEMFD_MAGIC.  Though hopefully we don't actually need a dedicated
filesystem, I _think_ it's unnecessary if we don't try to support userspace
mounts.

> ---
> 
> Originally, I was planning to use the generic guest memfd infrastructure to
> support Gunyah hypervisor, however I see that's probably not going to be
> possible now that the guest memfd implementation is KVM-specific. I think
> this is good for both KVM and Gunyah as there will be some Gunyah specifics
> and some KVM specifics in each of implementation, as you mentioned in the
> previous series.

Yeah, that's where my headspace is at too.  Sharing the actual uAPI, and even
internal APIs to some extent, doesn't save all that much, e.g. wiring up an ioctl()
is the easy part.  Whereas I strongly suspect each hypervisor use case will want
different semantics for the uAPI.

> I'll go through series over next week or so and I'll try to find how much
> similar Gunyah guest mem fd implementation would be and we can see if it's
> better to pull whatever that ends up being into a common implementation?

That would be awesome!  

> We could also agree to have completely divergent fd implementations like we
> do for the UAPI. Thoughts?

I'd like to avoid _completely_ divergent implementations, e.g. the majority of
kvm_gmem_allocate() and __kvm_gmem_create() isn't KVM specific.  I think there
would be value in sharing the core allocation logic, even if the other details
are different.  Especially if we fully commit to not supporting migration or
swap, and decide to use xarray directly to manage folios instead of bouncing
through the filemap APIs.

Thanks!
