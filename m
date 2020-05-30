Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5670D1E9211
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgE3Obw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Obw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 10:31:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5DC03E969;
        Sat, 30 May 2020 07:31:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jf2WZ-000TFN-2S; Sat, 30 May 2020 14:31:47 +0000
Date:   Sat, 30 May 2020 15:31:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
Message-ID: <20200530143147.GN23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 04:52:59PM -0700, Linus Torvalds wrote:
> On Fri, May 29, 2020 at 4:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > a/arch/x86/kvm/hyperv.c
> > -               if (__clear_user((void __user *)addr, sizeof(u32)))
> > +               if (__put_user(0, (u32 __user *)addr))
> 
> I'm not doubting that this is a correct transformation and an
> improvement, but why is it using that double-underscore version in the
> first place?
> 
> There's a __copy_to_user() in kvm_hv_set_msr_pw() in addition to this
> one in kvm_hv_set_msr(). Both go back to 2011 and commit 8b0cedff040b
> ("KVM: use __copy_to_user/__clear_user to write guest page") and both
> look purely like "pointlessly avoid the access_ok".
> 
> All these KVM "optimizations" seem entirely pointless, since
> access_ok() isn't the problem. And the address _claims_ to be
> verified, but I'm not seeing it. There is not a single 'access_ok()'
> anywhere in arch/x86/kvm/ that I can see.
> 
> It looks like the argument for the address being validated is that it
> comes from "gfn_to_hva()", which should only return
> host-virtual-addresses. That may be true.
> 
> But "should" is not "does", and honestly, the cost of gfn_to_hva() is
> high enough that then using that as an argument for removing
> "access_ok()" smells.
> 
> So I would suggest just removing all these completely bogus
> double-underscore versions. It's pointless, it's wrong, and it's
> unsafe.

It's a bit trickier than that, but I want to deal with that at the same
time as the rest of kvm/vhost stuff.  So for this series I just went
for minimal change.  There's quite a pile of vhost and kvm stuff,
but it's not ready yet - wait for the next cycle.
