Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028B607CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJUQxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiJUQxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB128B1E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so7179261pjq.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrysGx55UenjRLyS1DI8lWgE85TWYqrMWgtnLZZFAkc=;
        b=RHWZQBLe9HXVngD3tJPBIAxrqGbPxOHUi+EuoMf2wh8wAVWCUykhVBw5M4bpHipxKX
         AQrvUqN4owfPyZqdyzULb7AFBCSDE+f4NUKYHAYIddpZR67VGGUvvxapOtY3ozT/Ml4t
         aiXuSjYrXY3eVMT1GbVbskQFgGxypZbRWqNEOhCm30Zif46drkOhIOZelqHekwQwUk43
         bnuW3YgCEoukR20OzDrDD/o7UY7n/fRCHqej35doY178zBweJ3IoeGQQs9hPHYSo3Ohx
         OqzLxanZHEvXOsNtWfWWxGtsKOFGJnejx5vYFgdKqN5Vb6+SO3aa9cMSKsUkIyd4p5eH
         sJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrysGx55UenjRLyS1DI8lWgE85TWYqrMWgtnLZZFAkc=;
        b=aAyBEKRJGdQWfB8Vt/F4wHKcXtAXQklzGHr+iRjolZdA1dhDTK6+INfpT3pawjHHCz
         5lOoR1t/9CTjhH49XwrLoB2qIAs2ke66nr9R45c3IBzWhsaPqWXCUSmhfo+ZF0QFhFwa
         snCxSKLf9KgQxcA/uKAAqCR8vfKJifqaPeaKGJPSfMrDnNXq6qI3CPsDgw/S3vchfZvm
         lX7qPH648xm7QMmixPzAP4uIb2gRZDEvNDrsP1cUuH40TvvBQcGlE8K9YvtaaUpm7z/R
         8P9lqHao60Zxp9b4XkApoTagko6UDFVvxILAkYfWFTKrK4i+l44earQerjt9u4By4E97
         WftQ==
X-Gm-Message-State: ACrzQf07bgRGhUMRbZQ4DCuKXqfgGDzBaKL6sTNib7+F8FrWEo6mdwZY
        WXGG1QdRlefsU+eHgoUKQgU6mA==
X-Google-Smtp-Source: AMsMyM4X0ByBcSID7/aMrdZ0mivytsG1EHhlrHnS2og4yoaJvAdKT/AGmOFlcmS9yqzFtIJMO1ZXxQ==
X-Received: by 2002:a17:90b:2651:b0:20a:daaf:75f0 with SMTP id pa17-20020a17090b265100b0020adaaf75f0mr22464873pjb.142.1666371200475;
        Fri, 21 Oct 2022 09:53:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00176e8f85147sm15298020plh.83.2022.10.21.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:53:19 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:53:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Vishal Annapurve <vannapurve@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <Y1LOe4JvnTbFNs4u@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <de680280-f6b1-9337-2ae4-4b2faf2b823b@suse.cz>
 <20221017161955.t4gditaztbwijgcn@box.shutemov.name>
 <c63ad0cd-d517-0f1e-59e9-927d8ae15a1a@amd.com>
 <20221017215640.hobzcz47es7dq2bi@box.shutemov.name>
 <CAGtprH8xEdgATjQdhi2b_KqUuSOZHUM-Lh+O-ZtcFKbHf2_75g@mail.gmail.com>
 <20221019153225.njvg45glehlnjgc7@box.shutemov.name>
 <CAGtprH-8y9iTyVZ+EYW2t=zGqz7fVgPu-3wVm0Wgv5134NU6WQ@mail.gmail.com>
 <20221021135434.GB3607894@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021135434.GB3607894@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022, Chao Peng wrote:
> On Thu, Oct 20, 2022 at 04:20:58PM +0530, Vishal Annapurve wrote:
> > On Wed, Oct 19, 2022 at 9:02 PM Kirill A . Shutemov <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Tue, Oct 18, 2022 at 07:12:10PM +0530, Vishal Annapurve wrote:
> > > > I think moving this notifier_invalidate before fallocate may not solve
> > > > the problem completely. Is it possible that between invalidate and
> > > > fallocate, KVM tries to handle the page fault for the guest VM from
> > > > another vcpu and uses the pages to be freed to back gpa ranges? Should
> > > > hole punching here also update mem_attr first to say that KVM should
> > > > consider the corresponding gpa ranges to be no more backed by
> > > > inaccessible memfd?
> > >
> > > We rely on external synchronization to prevent this. See code around
> > > mmu_invalidate_retry_hva().
> > >
> > > --
> > >   Kiryl Shutsemau / Kirill A. Shutemov
> > 
> > IIUC, mmu_invalidate_retry_hva/gfn ensures that page faults on gfn
> > ranges that are being invalidated are retried till invalidation is
> > complete. In this case, is it possible that KVM tries to serve the
> > page fault after inaccessible_notifier_invalidate is complete but
> > before fallocate could punch hole into the files?

It's not just the page fault edge case.  In the more straightforward scenario
where the memory is already mapped into the guest, freeing pages back to the kernel
before they are removed from the guest will lead to use-after-free.

> > e.g.
> > inaccessible_notifier_invalidate(...)
> > ... (system event preempting this control flow, giving a window for
> > the guest to retry accessing the gfn range which was invalidated)
> > fallocate(.., PUNCH_HOLE..)
> 
> Looks this is something can happen.
> And sounds to me the solution needs
> just follow the mmu_notifier's way of using a invalidate_start/end pair.
> 
>   invalidate_start()  --> kvm->mmu_invalidate_in_progress++;
>                           zap KVM page table entries;
>   fallocate()
>   invalidate_end()  --> kvm->mmu_invalidate_in_progress--;
> 
> Then during invalidate_start/end time window mmu_invalidate_retry_gfn
> checks 'mmu_invalidate_in_progress' and prevent repopulating the same
> page in KVM page table.

Yes, if it's not safe to invalidate after making the change (fallocate()), then
the change needs to be bookended by a start+end pair.  The mmu_notifier's unpaired
invalidate() hook works by zapping the primary MMU's PTEs before invalidate(), but
frees the underlying physical page _after_ invalidate().

And the only reason the unpaired invalidate() exists is because there are secondary
MMUs that reuse the primary MMU's page tables, e.g. shared virtual addressing, in
which case bookending doesn't work because the secondary MMU can't remove PTEs, it
can only flush its TLBs.

For this case, the whole point is to not create PTEs in the primary MMU, so there
should never be a use case that _needs_ an unpaired invalidate().

TL;DR: a start+end pair is likely the simplest solution.
