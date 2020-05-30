Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C807C1E934C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgE3TOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 15:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3TOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 15:14:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F5C03E969;
        Sat, 30 May 2020 12:14:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jf6w4-000YbD-9X; Sat, 30 May 2020 19:14:24 +0000
Date:   Sat, 30 May 2020 20:14:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
Message-ID: <20200530191424.GR23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
 <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
 <20200530183853.GQ23230@ZenIV.linux.org.uk>
 <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 11:52:44AM -0700, Linus Torvalds wrote:
> 
> It really isn't.
> 
> Your very first statement shows how broken it is:
> 
> > FWIW, the kvm side of things (vhost is yet another pile of fun) is
> >
> > [x86] kvm_hv_set_msr_pw():
> > arch/x86/kvm/hyperv.c:1027:             if (__copy_to_user((void __user *)addr, instructions, 4))
> >         HV_X64_MSR_HYPERCALL
> > arch/x86/kvm/hyperv.c:1132:             if (__clear_user((void __user *)addr, sizeof(u32)))
> >         HV_X64_MSR_VP_ASSIST_PAGE
> > in both cases addr comes from
> >                 gfn = data >> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT;
> >                 addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
> >                 if (kvm_is_error_hva(addr))
> >                         return 1;
> 
> Just look at that. You have _zero_ indication that 'adds" is a user
> space address. It could be a kernel address.
> 
> That kvm_vcpu_gfn_to_hva() function is a complicated mess that first
> looks for the right 'memslot', and basically uses a search with a
> default slot to try to figure it out. It doesn't even use locking for
> any of it, but assumes the arrays are stable, and that it can use
> atomics to reliably read and set the last successfully found slot.
> 
> And none of that code verifies that the end result is a user address.

kvm_is_error_hva() is
	return addr >= PAGE_OFFSET;
