Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E0601FA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 02:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJRAg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 20:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiJRAfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:35:44 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D61D0F6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 17:35:26 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-132af5e5543so15167897fac.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 17:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZFNHgeagPRGpN511S5OVmTVLDSRxzqHSZND+ilItHI=;
        b=rX/14hxyK+jbBsNmsi6OICKyz6vY8MdAjLpdpmL8Eoa7S9QfTsmtZ2g16772VPAdQ3
         fyx8viqBFbhwe4fsuILQVTdMHesYZMcl1oUOCmX8b3E05NNXj84+XzmbL1LsDXmL5F1j
         LMV1n2XU1a76XmxIXhbX/jQLk94Nf9oyipbD0iN/8f2ZIv+JsTvOocrVsgP0HsxvQWOB
         FV59MeLky59LcmcQNFmf5mPPHgZyPDz4SSGEWvXafNz+jO3Il6nH3aWk0dudbCEewkRL
         w2EkcpSee8Zn3VXKnm1otN85uvjvLHE28I2YLKCADeFtBWdkawzMyHE1W2n1XGklWzw2
         7bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZFNHgeagPRGpN511S5OVmTVLDSRxzqHSZND+ilItHI=;
        b=A6Q1oIRgsH7gvKrev0ib2fnS3nTUQmL+gQWxB7tRWPtR/4C1Xy9aYdzVFLB3OJFK24
         +rNzYi9DFCJof1nZEx5+adbu6Ar0Ekdd6eS/eCZHPhbqXT+Rcqw31owb0lma826Hzo1k
         3G3FTz0BDM2kZGCe09LytqOFm50gHBVL4cOXNRgVKjoC/bpgX1FtFYsP4b5dSRxeVwoU
         ARTLjP3tHDeJ9hT5SjDyu/PZ1/6y7btOQn1XlMgb0noUrklIh6pstHlY0OpCP98qRCZs
         6kO+aZRwOw1YPbKgyIg7xr4OmDvsxBn91OXoqZ+AD8Wky5TE2mSyJfCj6BMdVSXb1xBO
         suIw==
X-Gm-Message-State: ACrzQf2pIiQ4ah5TgNoM9WQdcNQurqOA5JStErOcRhwFFL00NAYKU2zG
        Z9uBb8QWaAh0yCEljkfdXsSIN8ci+PnZrA==
X-Google-Smtp-Source: AMsMyM6GsW9qHuPFp8+B+qhuY2BytXR7EdsQrQz18ZdcSSusgW2PC6Ay30Uig0XRAo3WSxCvao9eLQ==
X-Received: by 2002:a17:90a:4594:b0:20b:23d5:8ead with SMTP id v20-20020a17090a459400b0020b23d58eadmr35608180pjg.127.1666053232202;
        Mon, 17 Oct 2022 17:33:52 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q59-20020a17090a1b4100b001efa9e83927sm9986738pjq.51.2022.10.17.17.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 17:33:51 -0700 (PDT)
Date:   Tue, 18 Oct 2022 00:33:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <Y030bGhh0mvGS6E1@google.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com>
 <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
 <20220926142330.GC2658254@chaop.bj.intel.com>
 <CA+EHjTz5yGhsxUug+wqa9hrBO60Be0dzWeWzX00YtNxin2eYHg@mail.gmail.com>
 <YzN9gYn1uwHopthW@google.com>
 <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
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

On Fri, Sep 30, 2022, Fuad Tabba wrote:
> > > > > pKVM would also need a way to make an fd accessible again
> > > > > when shared back, which I think isn't possible with this patch.
> > > >
> > > > But does pKVM really want to mmap/munmap a new region at the page-level,
> > > > that can cause VMA fragmentation if the conversion is frequent as I see.
> > > > Even with a KVM ioctl for mapping as mentioned below, I think there will
> > > > be the same issue.
> > >
> > > pKVM doesn't really need to unmap the memory. What is really important
> > > is that the memory is not GUP'able.
> >
> > Well, not entirely unguppable, just unguppable without a magic FOLL_* flag,
> > otherwise KVM wouldn't be able to get the PFN to map into guest memory.
> >
> > The problem is that gup() and "mapped" are tied together.  So yes, pKVM doesn't
> > strictly need to unmap memory _in the untrusted host_, but since mapped==guppable,
> > the end result is the same.
> >
> > Emphasis above because pKVM still needs unmap the memory _somehwere_.  IIUC, the
> > current approach is to do that only in the stage-2 page tables, i.e. only in the
> > context of the hypervisor.  Which is also the source of the gup() problems; the
> > untrusted kernel is blissfully unaware that the memory is inaccessible.
> >
> > Any approach that moves some of that information into the untrusted kernel so that
> > the kernel can protect itself will incur fragmentation in the VMAs.  Well, unless
> > all of guest memory becomes unguppable, but that's likely not a viable option.
> 
> Actually, for pKVM, there is no need for the guest memory to be GUP'able at
> all if we use the new inaccessible_get_pfn().

Ya, I was referring to pKVM without UPM / inaccessible memory.

Jumping back to blocking gup(), what about using the same tricks as secretmem to
block gup()?  E.g. compare vm_ops to block regular gup() and a_ops to block fast
gup() on struct page?  With a Kconfig that's selected by pKVM (which would also
need its own Kconfig), e.g. CONFIG_INACCESSIBLE_MAPPABLE_MEM, there would be zero
performance overhead for non-pKVM kernels, i.e. hooking gup() shouldn't be
controversial.

I suspect the fast gup() path could even be optimized to avoid the page_mapping()
lookup by adding a PG_inaccessible flag that's defined iff the TBD Kconfig is
selected.  I'm guessing pKVM isn't expected to be deployed on massivve NUMA systems
anytime soon, so there should be plenty of page flags to go around.

Blocking gup() instead of trying to play refcount games when converting back to
private would eliminate the need to put heavy restrictions on mapping, as the goal
of those were purely to simplify the KVM implementation, e.g. the "one mapping per
memslot" thing would go away entirely.

> This of course goes back to what I'd mentioned before in v7; it seems that
> representing the memslot memory as a file descriptor should be orthogonal to
> whether the memory is shared or private, rather than a private_fd for private
> memory and the userspace_addr for shared memory.

I also explored the idea of backing any guest memory with an fd, but came to
the conclusion that private memory needs a separate handle[1], at least on x86.

For SNP and TDX, even though the GPA is the same (ignoring the fact that SNP and
TDX steal GPA bits to differentiate private vs. shared), the two types need to be
treated as separate mappings[2].  Post-boot, converting is lossy in both directions,
so even conceptually they are two disctint pages that just happen to share (some)
GPA bits.

To allow conversions, i.e. changing which mapping to use, without memslot updates,
KVM needs to let userspace provide both mappings in a single memslot.  So while
fd-based memory is an orthogonal concept, e.g. we could add fd-based shared memory,
KVM would still need a dedicated private handle.

For pKVM, the fd doesn't strictly need to be mutually exclusive with the existing
userspace_addr, but since the private_fd is going to be added for x86, I think it
makes sense to use that instead of adding generic fd-based memory for pKVM's use
case (which is arguably still "private" memory but with special semantics).

[1] https://lore.kernel.org/all/YulTH7bL4MwT5v5K@google.com
[2] https://lore.kernel.org/all/869622df-5bf6-0fbb-cac4-34c6ae7df119@kernel.org

>  The host can then map or unmap the shared/private memory using the fd, which
>  allows it more freedom in even choosing to unmap shared memory when not
>  needed, for example.
