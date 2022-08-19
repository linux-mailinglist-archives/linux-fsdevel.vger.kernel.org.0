Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C9599346
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbiHSDBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 23:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244358AbiHSDBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:01:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B4D5DFF
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 20:00:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m5so2524870qkk.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 20:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=SqzHyhYdK1V4JBswn3yCW3hnqnnsbZPFsQYu2RllJTY=;
        b=MxC5bzVaVdTyRqcXd62vZSPNLWDIJzWO3NZV9BGtCGtukJbO3aGq8wTVM4NPvqGiXM
         Gwc6h1B2pl0StsRb9qHw1ezYc+eQKsJIFXHOJkJLQK56Yba/yXH12A/qAvt/GHNn4Nya
         D707Il8MyVwvmgV3dWYtEIyhdJZzXlXNrItW6N159s2XcDc/5O67GqerWAOl040sCh35
         4zpUkW1pYDENJhKanUxKdo667PCS62uqKq4XmxXxPY4k3OmC4ujqf2Q1wmpbT3OoINdz
         1+IaFPCzNeCdYyUh7KL9Q1cBjUgSUMCQLB6oYTt/hylhnCM1omtR0JcwyZbN6lcakGds
         Oplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=SqzHyhYdK1V4JBswn3yCW3hnqnnsbZPFsQYu2RllJTY=;
        b=T9GW+O3txpwOprdiz5xvt6Lu/AMd6WQuQNP/0LF6/9I59zngcXhgWCEGajb+Hsslc4
         LI/ocZ2bojOJSDQ0o7/qs93AEan8504tCZgiu1Q1M5/RIK7SBAyNSRjj4YEa0vEWnXoh
         FN0XkChfqTTVjkA/N8psVPqL2DW2VsI+Xle3g0iecSlZ82XV/BWktbGFDgJepf0wya0I
         J+6CHjaF5O8N592zNRIyu1fKxc9maMTK7GIC4fEo8ra+uwrZAg4+7tmqebkDNxxnLAKV
         CZoiV88pwHUJDtA+X0GtPzw9GheeAEg4KzSV1rm8kKfoTAa0gu9X7IIG1m4D4iXMW61u
         ASSA==
X-Gm-Message-State: ACgBeo3hjHGdUmjwEe6tV7cvHybkXzkguNeHmL7ZzaSzDqnQ2AzXbcBl
        swRjk5jZ6yGcZ8a4mSbIDFIMSg==
X-Google-Smtp-Source: AA6agR7KQTVz3JYFrJLB5lhd2uJBBP000qbAVx/oSm/fFTrnVR58FRN6Fmbj1fOpDd+LLvaHPxpv8g==
X-Received: by 2002:a05:620a:1d0e:b0:6ba:c419:81a1 with SMTP id dl14-20020a05620a1d0e00b006bac41981a1mr4066120qkb.526.1660878058827;
        Thu, 18 Aug 2022 20:00:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a18-20020ac844b2000000b0031ef69c9024sm2045363qto.91.2022.08.18.20.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 20:00:58 -0700 (PDT)
Date:   Thu, 18 Aug 2022 20:00:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
In-Reply-To: <20220818132421.6xmjqduempmxnnu2@box>
Message-ID: <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com> <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com> <20220818132421.6xmjqduempmxnnu2@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Aug 2022, Kirill A . Shutemov wrote:
> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > 
> > If your memory could be swapped, that would be enough of a good reason
> > to make use of shmem.c: but it cannot be swapped; and although there
> > are some references in the mailthreads to it perhaps being swappable
> > in future, I get the impression that will not happen soon if ever.
> > 
> > If your memory could be migrated, that would be some reason to use
> > filesystem page cache (because page migration happens to understand
> > that type of memory): but it cannot be migrated.
> 
> Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
> theoretically possible, but I'm not aware of any plans as of now.
> 
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html

I always forget, migration means different things to different audiences.
As an mm person, I was meaning page migration, whereas a virtualization
person thinks VM live migration (which that reference appears to be about),
a scheduler person task migration, an ornithologist bird migration, etc.

But you're an mm person too: you may have cited that reference in the
knowledge that TDX 1.5 Live Migration will entail page migration of the
kind I'm thinking of.  (Anyway, it's not important to clarify that here.)

> 
> > Some of these impressions may come from earlier iterations of the
> > patchset (v7 looks better in several ways than v5).  I am probably
> > underestimating the extent to which you have taken on board other
> > usages beyond TDX and SEV private memory, and rightly want to serve
> > them all with similar interfaces: perhaps there is enough justification
> > for shmem there, but I don't see it.  There was mention of userfaultfd
> > in one link: does that provide the justification for using shmem?
> > 
> > I'm afraid of the special demands you may make of memory allocation
> > later on - surprised that huge pages are not mentioned already;
> > gigantic contiguous extents? secretmem removed from direct map?
> 
> The design allows for extension to hugetlbfs if needed. Combination of
> MFD_INACCESSIBLE | MFD_HUGETLB should route this way. There should be zero
> implications for shmem. It is going to be separate struct memfile_backing_store.

Last year's MFD_HUGEPAGE proposal would have allowed you to do it with
memfd via tmpfs without needing to involve hugetlbfs; but you may prefer
the determinism of hugetlbfs, relying on /proc/sys/vm/nr_hugepages etc.

But I've yet to see why you want to involve this or that filesystem
(with all its filesystem-icity suppressed) at all.  The backing store
is host memory, and tmpfs and hugetlbfs just impose their own
idiosyncrasies on how that memory is allocated; but I think you would
do better to choose your own idiosyncrasies in allocation directly -
you don't need a different "backing store" to choose between 4k or 2M
or 1G or whatever allocations.

tmpfs and hugetlbfs and page cache are designed around sharing memory:
TDX is designed around absolutely not sharing memory; and the further
uses which Sean foresees appear not to need it as page cache either.

Except perhaps for page migration reasons.  It's somewhat incidental,  
but of course page migration knows how to migrate page cache, so
masquerading as page cache will give a short cut to page migration,
when page migration becomes at all possible.

> 
> I'm not sure secretmem is a fit here as we want to extend MFD_INACCESSIBLE
> to be movable if platform supports it and secretmem is not migratable by
> design (without direct mapping fragmentations).
> 
> > Here's what I would prefer, and imagine much easier for you to maintain;
> > but I'm no system designer, and may be misunderstanding throughout.
> > 
> > QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
> > the fallocate syscall interface itself) to allocate and free the memory,
> > ioctl for initializing some of it too.  KVM in control of whether that
> > fd can be read or written or mmap'ed or whatever, no need to prevent it
> > in shmem.c, no need for flags, seals, notifications to and fro because
> > KVM is already in control and knows the history.  If shmem actually has
> > value, call into it underneath - somewhat like SysV SHM, and /dev/zero
> > mmap, and i915/gem make use of it underneath.  If shmem has nothing to
> > add, just allocate and free kernel memory directly, recorded in your
> > own xarray.
> 
> I guess shim layer on top of shmem *can* work. I don't see immediately why
> it would not. But I'm not sure it is right direction. We risk creating yet
> another parallel VM with own rules/locking/accounting that opaque to
> core-mm.

You are already proposing a new set of rules, foreign to how tmpfs works
for others.  You're right that KVM allocating large amounts of memory,
opaque to core-mm, carries risk: and you'd be right to say that shmem.c
provides some clues (security_vm_enough_memory checks, memcg charging,
user_shm_lock accounting) on what to remember.

But I'm not up to the job of being the one to police you there,
and you don't want to be waiting on me either.

To take a rather silly example: Ted just added chattr support to tmpfs,
and it fits in well.  But I don't now want to have to decide whether
"chattr +i" FS_IMMUTABLE_FL is or is not compatible with
MEMFILE_F_USER_INACCESSIBLE.  They are from different worlds,
and I'd prefer KVM to carry the weight of imposing INACCESSIBLE:
which seems easily done if it manages the fd, without making the
memory allocated to that fd accessible to those who hold the fd.

> 
> Note that on machines that run TDX guests such memory would likely be the
> bulk of memory use. Treating it as a fringe case may bite us one day.

Yes, I suspected that machines running TDX guests might well consume
most of the memory that way, but glad(?) to hear it confirmed.

I am not suggesting that this memory be treated as a fringe case, rather
the reverse: a different case, not something to hide away inside shmem.c.

Is there a notion that /proc/meminfo "Shmem:" is going to be a good hint
of this usage?  Whether or not it's also included in "Shmem:", I expect
that its different characteristics will deserve its own display.

Hugh
