Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3B06AF6B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 21:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCGU1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 15:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCGU1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:27:32 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1717CF1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 12:27:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u14-20020a170902e5ce00b0019e3ce940b7so8286997plf.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678220850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGcASroMdccxdn62Jjtjh8PVnJGDXhBcjr99ONuCvY4=;
        b=OwwLfDPKljzAkPvlj0S/FrolNQFkMYhVCSYaPZA6BhlyFeubRSg3vonk6akM+nwgAx
         dcS6vYx/LWgfF4nSPN+n5wRbJl1+oX04X/RQuea86YN+QKQuGEhXA8GHTKbpJNljgVbg
         1tgLB7KavCS6Q8io76xaUiHKm29QSamSGbG7VBUDlQZNg7fOcC8uJ1SLfFlvvf38+NHp
         H0+zdtAOsLWl91QdOI5eJY+EmcNzqsXqCw01IvZ9IrObznTsFWqkSsLtumj8X2Gb549e
         mgTJkRz7STcC9OGGE966xqlp75dxFmI9JO9DcpLgaboo61ZXNHLGYkcot+ahXB1p5gKf
         Im0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678220850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGcASroMdccxdn62Jjtjh8PVnJGDXhBcjr99ONuCvY4=;
        b=yId5TWFjCSu9WYVjMk2+/QW/rQjiaVrlP/oBrwQjwqCdMKQO98xDTEVNRuRgFKBCPE
         SnoIhGjVzOEXtXeRIIk6Y52XOrE8zhQ/LJswOXjBw1iOz3lVns64s0y/qvJEh/FQ20lX
         YFjpoAJTu4eoe5m+dlZoeNc7WqPRGzKg832IH9OTg+xeP8XbmgahnjDJz+Bu5Mf4Um8G
         ayjkJKUuuZIvut+ASsu2HEWIgc1fSQO8zoz9hWpJ3YbqB+UNe4YwkGHdBwsu65L4NdFp
         lrUH9ISnOSZCim8RebdaE+mHFy3jEI2fjU47CxD9WphCUllz9h7oqGkHGc8BRkYItkmo
         BU8A==
X-Gm-Message-State: AO0yUKWQwsnV8KljoyGad6Fx3A/VTKtwnnfjm2yEhodoXHI4jXjHY3sj
        mMG0fhUrcckENirZLgDgP3s7XpZBh/U=
X-Google-Smtp-Source: AK7set9n+PBGh5X4bHcHssSmlZaRESH4dUDPeHJTAkKKGP+YbNHu8+uM5MNsGFpRsbe7uC0L5WQKdFmMJ3c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2948:0:b0:503:7bcd:9806 with SMTP id
 bu8-20020a632948000000b005037bcd9806mr5442294pgb.4.1678220850029; Tue, 07 Mar
 2023 12:27:30 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:27:28 -0800
In-Reply-To: <diqzcz5kz85e.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <20221202061347.1070246-10-chao.p.peng@linux.intel.com> <diqzcz5kz85e.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <ZAeeMA9pPYwFiuaX@google.com>
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, pbonzini@redhat.com, corbet@lwn.net,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arnd@arndb.de, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, x86@kernel.org, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, shuah@kernel.org, rppt@kernel.org,
        steven.price@arm.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        vannapurve@google.com, yu.c.zhang@linux.intel.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, qperret@google.com, tabba@google.com,
        michael.roth@amd.com, mhocko@suse.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please trim your replies so that readers don't need to scan through a hundred or
so lines of quotes just to confirm there's nothing there.

On Tue, Mar 07, 2023, Ackerley Tng wrote:
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > Register/unregister private memslot to fd-based memory backing store
> > restrictedmem and implement the callbacks for restrictedmem_notifier:
> >    - invalidate_start()/invalidate_end() to zap the existing memory
> >      mappings in the KVM page table.
> >    - error() to request KVM_REQ_MEMORY_MCE and later exit to userspace
> >      with KVM_EXIT_SHUTDOWN.
> 
> > Expose KVM_MEM_PRIVATE for memslot and KVM_MEMORY_ATTRIBUTE_PRIVATE for
> > KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES to userspace but either are
> > controlled by kvm_arch_has_private_mem() which should be rewritten by
> > architecture code.
> 
> Could we perhaps rename KVM_MEM_PRIVATE to KVM_MEM_PROTECTED, to be in
> line with KVM_X86_PROTECTED_VM?
> 
> I feel that a memslot that has the KVM_MEM_PRIVATE flag need not always
> be private; It can sometimes be providing memory that is shared and
> also accessible from the host.
> 
> KVM_MEMORY_ATTRIBUTE_PRIVATE is fine as-is because this flag is set when
> the guest memory is meant to be backed by private memory.
> 
> KVM_MEMORY_EXIT_FLAG_PRIVATE is also okay because the flag is used to
> indicate when the memory error is caused by a private access (as opposed
> to a shared access).
> 
> kvm_slot_can_be_private() could perhaps be renamed kvm_is_protected_slot()?

No to this suggestion.  I agree that KVM_MEM_PRIVATE is a bad name, but
kvm_is_protected_slot() is just as wrong.  The _only_ thing that the flag controls
is whether whether or not the memslot has an fd that is bound to restricted memory.
The memslot itself is not protected in any way, and if the entire memslot is mapped
shared, then the data backed by the memslot isn't protected either.

What about KVM_MEM_CAN_BE_PRIVATE?  KVM_MEM_PRIVATIZABLE is more succinct, but
AFAICT that's a made up word, and IMO is unnecessarily fancy.
