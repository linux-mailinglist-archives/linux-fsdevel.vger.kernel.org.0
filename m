Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55BD2887FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgJILm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgJILm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:42:28 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A665C0613D2;
        Fri,  9 Oct 2020 04:42:28 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 16so9848448oix.9;
        Fri, 09 Oct 2020 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXOK1m3FD3UfW2u2hlQ7/M3TxfyRzNQFec749sTesbA=;
        b=QcJ1GtV5RB69XZFSZ+4kfpeOUPpgGfZPL08OuPM96ZZlLcJV0eM4wUvHvoHTVyP/hf
         XO2A+nfCaUi/lmYhXdI39GBeUgyiea1mRiSXKJ3LewRsSRdBmrbvru6b/5OFhPHE/8JR
         j0ZBxdZX+fE84i63hm1Jd42PGOsp7P/y8i6pXjAlycS2Cj58UoNfvkBKNoFfzxVATMfX
         9yw0VpBrdxaJfJ+MldElFxnCoY7zDm3OMfdGZbTgxMFPOrBjgwYHxDIRfLw7gIdoqtZ0
         MER/6yJJCvPrtHPMqXMb1nJbKYkckySioNphDGoo/EXgU/jMXvPrbvu+Pofic8nvR1EB
         UMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXOK1m3FD3UfW2u2hlQ7/M3TxfyRzNQFec749sTesbA=;
        b=WxX5RyqS3mFVLkqdz/TPIASCV63x8dj5XISbsnv1umfA9i3TloXB03WYoZ+q1b3Iuq
         5KGyL1DICorEPD4xxeGPpTjMh7lztuU2jbz3uYNUR7lgh3HIdhI+UzSQAgJiQRxqYwdQ
         BgiHXwv+oW/BPwtOeatuAqk2LJ3oogPI/mMEFijvnqIwgzAenUKSgjCOgTXMgRhzXbRn
         +aYMmH52tljcEWlT2A+vtj5JAv8lIxr1pWFsXJ0euiT7+p9+4c9AngorVNEncTXFXsg7
         LNvZ+pPgvPlBemI3PrbVJOvPWjUZ/0HIi4WVF5ThOoHzVQ1YH5tFdXv3UcmULPvcNkVk
         o6yw==
X-Gm-Message-State: AOAM530x+o5Q6vV1kj3hyopoOpZXCHrymzqO0MZON6maSQc1Y0gIy76+
        1hfyzsCdblzWOu4euEt7moULEOVlok/zQ/kBCQ4U4lcP
X-Google-Smtp-Source: ABdhPJzZiHR+wFgNZIb/LIZlrvspscgw66vXvl2VjBjRRM9QZT/FRiqjR2y9XNBraQPZFBemzsCY2J/dZLG2TBfMhow=
X-Received: by 2002:aca:ec4d:: with SMTP id k74mr2164591oih.96.1602243747954;
 Fri, 09 Oct 2020 04:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <b2b6837785f6786575823c919788464373d3ee05.1602093760.git.yuleixzhang@tencent.com>
 <20201009005823.GA11151@linux.intel.com> <a6dd5fbe-ca71-cf05-ec40-ec916843e9b7@oracle.com>
In-Reply-To: <a6dd5fbe-ca71-cf05-ec40-ec916843e9b7@oracle.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 19:42:17 +0800
Message-ID: <CACZOiM2W_8P_S6EypD3XfX1RuU+Do69w9qEMk7nDH2BxtK2E1g@mail.gmail.com>
Subject: Re: [PATCH 22/35] kvm, x86: Distinguish dmemfs page from mmio page
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, Paolo Bonzini <pbonzini@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sean and Joao, thanks for the feedback. Probably we can drop this change.

On Fri, Oct 9, 2020 at 6:28 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 10/9/20 1:58 AM, Sean Christopherson wrote:
> > On Thu, Oct 08, 2020 at 03:54:12PM +0800, yulei.kernel@gmail.com wrote:
> >> From: Yulei Zhang <yuleixzhang@tencent.com>
> >>
> >> Dmem page is pfn invalid but not mmio. Support cacheable
> >> dmem page for kvm.
> >>
> >> Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
> >> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
> >> ---
> >>  arch/x86/kvm/mmu/mmu.c | 5 +++--
> >>  include/linux/dmem.h   | 7 +++++++
> >>  mm/dmem.c              | 7 +++++++
> >>  3 files changed, 17 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> >> index 71aa3da2a0b7..0115c1767063 100644
> >> --- a/arch/x86/kvm/mmu/mmu.c
> >> +++ b/arch/x86/kvm/mmu/mmu.c
> >> @@ -41,6 +41,7 @@
> >>  #include <linux/hash.h>
> >>  #include <linux/kern_levels.h>
> >>  #include <linux/kthread.h>
> >> +#include <linux/dmem.h>
> >>
> >>  #include <asm/page.h>
> >>  #include <asm/memtype.h>
> >> @@ -2962,9 +2963,9 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
> >>                       */
> >>                      (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
> >>
> >> -    return !e820__mapped_raw_any(pfn_to_hpa(pfn),
> >> +    return (!e820__mapped_raw_any(pfn_to_hpa(pfn),
> >>                                   pfn_to_hpa(pfn + 1) - 1,
> >> -                                 E820_TYPE_RAM);
> >> +                                 E820_TYPE_RAM)) || (!is_dmem_pfn(pfn));
> >
> > This is wrong.  As is, the logic reads "A PFN is MMIO if it is INVALID &&
> > (!RAM || !DMEM)".  The obvious fix would be to change it to "INVALID &&
> > !RAM && !DMEM", but that begs the question of whether or DMEM is reported
> > as RAM.  I don't see any e820 related changes in the series, i.e. no evidence
> > that dmem yanks its memory out of the e820 tables, which makes me think this
> > change is unnecessary.
> >
> Even if there would exist e820 changes, e820__mapped_raw_any() checks against
> hardware-provided e820 that we are given before any changes happen i.e. not the one kernel
> has changed (e820_table_firmware). So unless you're having that memory carved from an MMIO
> range (which would be wrong), or the BIOS is misrepresenting its memory map... the
> e820__mapped_raw_any(E820_TYPE_RAM) ought to be enough to cover RAM.
>
> Or at least that has been my experience with similar work.
>
>         Joao
