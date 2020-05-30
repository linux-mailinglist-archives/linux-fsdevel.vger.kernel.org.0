Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11CC1E9322
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgE3SjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgE3SjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 14:39:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D386C03E969;
        Sat, 30 May 2020 11:39:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jf6Nh-000XsX-Rs; Sat, 30 May 2020 18:38:53 +0000
Date:   Sat, 30 May 2020 19:38:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
Message-ID: <20200530183853.GQ23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
 <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 10:57:24AM -0700, Linus Torvalds wrote:

> So no. I disagree. There is absolutely nothing "obviously ok" about
> any of that kvm code. Quite the reverse.
> 
> I'd argue that it's very much obviously *NOT* ok, even while it might
> just happen to work.

Actually, it's somewhat less brittle than you think (on non-mips, at least)
and not due to those long-ago access_ok().

> That double underscore needs to go away. It's either actively buggy
> right now and I see no proof it isn't, or it's a bug just waiting to
> happen in the future.

FWIW, the kvm side of things (vhost is yet another pile of fun) is

[x86] kvm_hv_set_msr_pw():
arch/x86/kvm/hyperv.c:1027:             if (__copy_to_user((void __user *)addr, instructions, 4))
	HV_X64_MSR_HYPERCALL
arch/x86/kvm/hyperv.c:1132:             if (__clear_user((void __user *)addr, sizeof(u32)))
	HV_X64_MSR_VP_ASSIST_PAGE
in both cases addr comes from
                gfn = data >> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT;
                addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
                if (kvm_is_error_hva(addr))
                        return 1;

[x86] FNAME(walk_addr_generic), very hot:
arch/x86/kvm/mmu/paging_tmpl.h:403:             if (unlikely(__get_user(pte, ptep_user)))
                index = PT_INDEX(addr, walker->level);
                ...
                offset    = index * sizeof(pt_element_t);
		...
                host_addr = kvm_vcpu_gfn_to_hva_prot(vcpu, real_gfn,
                                            &walker->pte_writable[walker->level - 1]);
                if (unlikely(kvm_is_error_hva(host_addr)))
                        goto error;
                ptep_user = (pt_element_t __user *)((void *)host_addr + offset);

__kvm_read_guest_page():
virt/kvm/kvm_main.c:2252:       r = __copy_from_user(data, (void __user *)addr + offset, len);
        addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
        if (kvm_is_error_hva(addr))
                return -EFAULT;

__kvm_read_guest_atomic():
virt/kvm/kvm_main.c:2326:       r = __copy_from_user_inatomic(data, (void __user *)addr + offset, len);
        addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
        if (kvm_is_error_hva(addr))
                return -EFAULT;

__kvm_write_guest_page():
virt/kvm/kvm_main.c:2353:       r = __copy_to_user((void __user *)addr + offset, data, len);
        addr = gfn_to_hva_memslot(memslot, gfn);
        if (kvm_is_error_hva(addr))
                return -EFAULT;

kvm_write_guest_offset_cached():
virt/kvm/kvm_main.c:2490:       r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
        if (kvm_is_error_hva(ghc->hva))
                return -EFAULT;

kvm_read_guest_cached():
virt/kvm/kvm_main.c:2525:       r = __copy_from_user(data, (void __user *)ghc->hva, len);
        if (kvm_is_error_hva(ghc->hva))
                return -EFAULT;

default kvm_is_error_hva() is addr >= PAGE_OFFSET; however, on mips and s390 it's
IS_ERR_VALUE().

Sure, we can use non-__ variants, but is access_ok() the right primitive here?
We want userland memory, set_fs() be damned.  
