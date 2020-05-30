Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965E61E93A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgE3UnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3UnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 16:43:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31C8C03E969;
        Sat, 30 May 2020 13:43:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jf8Ju-000aBK-J6; Sat, 30 May 2020 20:43:06 +0000
Date:   Sat, 30 May 2020 21:43:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
Message-ID: <20200530204306.GV23230@ZenIV.linux.org.uk>
References: <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
 <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
 <20200530183853.GQ23230@ZenIV.linux.org.uk>
 <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
 <20200530191424.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wg03AwbLH0zLRbOOQR_cZD89dM0KMU-uLMkG2sG9K_yag@mail.gmail.com>
 <20200530194232.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530194232.GU23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 08:42:32PM +0100, Al Viro wrote:
> On Sat, May 30, 2020 at 12:20:54PM -0700, Linus Torvalds wrote:
> > On Sat, May 30, 2020 at 12:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > > And none of that code verifies that the end result is a user address.
> > >
> > > kvm_is_error_hva() is
> > >         return addr >= PAGE_OFFSET;
> > 
> > Ahh, that's what I missed. It won't work on other architectures, but
> > within x86 it's fine.
> 
> FWIW, we use virt/kvm on x86, powerpc, mips, s390 and arm64.
> 
> For x86 and powerpc the check is, AFAICS, OK (ppc kernel might start
> higher than PAGE_OFFSET, but not lower than it).  For arm64... not
> sure - I'm not familiar with the virtual address space layout we use
> there.  mips does *NOT* get that protection at all - there kvm_is_error_hva()
> is IS_ERR_VALUE() (thus the "at least on non-mips" upthread).  And
> for s390 it's also IS_ERR_VALUE(), but that's an separate can of worms -
> there access_ok() is constant true; if we ever hit any of that code in
> virt/kvm while under KERNEL_DS, we are well and truly fucked there.

Anyway, I really think it's too big to handle this cycle, what with the
amount of other stuff already in queue.  If anything, that __put_user()
is a useful marker of the things that will need attention.  That's arch/x86
and the test excluding the kernel space is just upstream of that call,
so IMO that's robust enough for now.  Crossing the limit just into the
beginning of kernel space is theoretically possible, but that would
depend upon slot->userspace_addr not being page-aligned (and would attempt
to zero up to 3 bytes past the PAGE_OFFSET in any case).  If we get
memory corruption going on, we have much worse problems than that.
And it would have to be memory corruption - ->userspace_addr is assign-once,
there's only one place doing the assignments and alignment check is
shortly upstream of it, so all instances must have that field page-aligned
all the time.

We'll need to sort the kvm-related issues out, but let's leave it for the
next cycle.
