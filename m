Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF854CB5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353778AbiFOO3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbiFOO3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:29:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA0535A82
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:29:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i64so11604203pfc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urXLCEo0HdMiwrT9/lHPLDvk+tFr+S8kFKoTasWYgTM=;
        b=jE8+1EoaVPLQAQgJuF6uSHsVQUNEYiULaZEf4qWJ+FDCtBcy5wU+1PuRU/qTw6mXuJ
         rhkDSC1GoM3r6gP1XqDzyFKdRxVJyQscQceF46fTmrMh4tpJ7/3OD4E0UUUL4FXaE4E4
         HLsY4nWxsZ1bLbc4mtfRzI75UcR7ige6egZvCSqqgKpyeTsqtkTZjDQiW2mEf6TP1C0u
         784mpZz2YhCQYjeTdJsTJu7oJeXZ7GHllZjsJApUFHo2QiJHGuFpB3Xi7l8+I0pC+m8X
         WUI+8LcLsPMDaqunWg8z0EiW4EPIpYE086RJe+7JyYOWlUAXkMPBTz0xEA+GhbwuK97s
         EpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urXLCEo0HdMiwrT9/lHPLDvk+tFr+S8kFKoTasWYgTM=;
        b=8CasHC1NDrIe8GvU/CGPmSUvB0u3ECNZCwdsEqJbWR0TRKbnep93vOQBKkR9ECdxZH
         Ai04wRPNpHKAz/rEMGhyvz+wHTdteO9E/1m5BCQrHFoPMIo1CdWSvuZqHR+A6uKTTsJc
         w+W87HSIgWJaMh0M3SXx8m8I8mSSIDjxPXbY+/IQmxOMqZMqFk85GMLdcNRwgMp1m442
         w7mSxrAKP06v947GQFMqsOTL3iWIla5cx+Ko6MtNUhkKT8u+UTEv92ZhEKL+Mlv1d82W
         MJjEvsso36bVKhqL+dRNJRFgtKus5u/BzeM1v5txpJmTWf6SZIgf2LDIqR/AJ9wIgA+b
         raYA==
X-Gm-Message-State: AJIora/0nbZL8Nxee7lAa/ll5bRK91TTdYENOpCTW8kRnecprlz2w/by
        yJCYl06J9zfqbI0gpi0/tJnR2A==
X-Google-Smtp-Source: AGRyM1tbE6e2B2i42MyE6StE9nppc07YDmrFHDgu8iNlTHFWW5xo4NNjzQzQb9yFXGjB6QHFLP8hJw==
X-Received: by 2002:a63:e1c:0:b0:3fd:f319:df7b with SMTP id d28-20020a630e1c000000b003fdf319df7bmr75509pgl.135.1655303389770;
        Wed, 15 Jun 2022 07:29:49 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b0015eb200cc00sm9366660plg.138.2022.06.15.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:29:49 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:29:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Vishal Annapurve <vannapurve@google.com>,
        Marc Orr <marcorr@google.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
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
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <Yqns2ar0TND4RP9P@google.com>
References: <20220607065749.GA1513445@chaop.bj.intel.com>
 <CAA03e5H_vOQS-qdZgacnmqP5T5jJLnEfm44yfRzJQ2KVu0Br+Q@mail.gmail.com>
 <20220608021820.GA1548172@chaop.bj.intel.com>
 <CAGtprH8xyf07jMN7ubTC__BvDj+z41uVGRiCJ7Rc5cv3KWg03w@mail.gmail.com>
 <YqJYEheLiGI4KqXF@google.com>
 <20220614072800.GB1783435@chaop.bj.intel.com>
 <CALCETrWw=Q=1AKW0Jcj3ZGscjyjDJXAjuxOnQx_sabQ6ZtS-wg@mail.gmail.com>
 <Yqjcx6u0KJcJuZfI@google.com>
 <CALCETrUdGoZ2yUnNGbxJ-Xr3KD7QhTi-ddhS8AUMjFyJM5pDfA@mail.gmail.com>
 <20220615091759.GB1823790@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615091759.GB1823790@chaop.bj.intel.com>
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

On Wed, Jun 15, 2022, Chao Peng wrote:
> On Tue, Jun 14, 2022 at 01:59:41PM -0700, Andy Lutomirski wrote:
> > On Tue, Jun 14, 2022 at 12:09 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Tue, Jun 14, 2022, Andy Lutomirski wrote:
> > > > This patch series is fairly close to implementing a rather more
> > > > efficient solution.  I'm not familiar enough with hypervisor userspace
> > > > to really know if this would work, but:
> > > >
> > > > What if shared guest memory could also be file-backed, either in the
> > > > same fd or with a second fd covering the shared portion of a memslot?
> > > > This would allow changes to the backing store (punching holes, etc) to
> > > > be some without mmap_lock or host-userspace TLB flushes?  Depending on
> > > > what the guest is doing with its shared memory, userspace might need
> > > > the memory mapped or it might not.
> > >
> > > That's what I'm angling for with the F_SEAL_FAULT_ALLOCATIONS idea.  The issue,
> > > unless I'm misreading code, is that punching a hole in the shared memory backing
> > > store doesn't prevent reallocating that hole on fault, i.e. a helper process that
> > > keeps a valid mapping of guest shared memory can silently fill the hole.
> > >
> > > What we're hoping to achieve is a way to prevent allocating memory without a very
> > > explicit action from userspace, e.g. fallocate().
> > 
> > Ah, I misunderstood.  I thought your goal was to mmap it and prevent
> > page faults from allocating.

I don't think you misunderstood, that's also one of the goals.  The use case is
that multiple processes in the host mmap() guest memory, and we'd like to be able
to punch a hole without having to rendezvous with all processes and also to prevent
an unintentional re-allocation.

> I think we still need the mmap, but want to prevent allocating when
> userspace touches previously mmaped area that has never filled the page.

Yes, or if a chunk was filled at some point but then was removed via PUNCH_HOLE.

> I don't have clear answer if other operations like read/write should be
> also prevented (probably yes). And only after an explicit fallocate() to
> allocate the page these operations would act normally.

I always forget about read/write.  I believe reads should be ok, the semantics of
holes are that they return zeros, i.e. can use ZERO_PAGE() and not allocate a new
backing page.  Not sure what to do about writes though.  Allocating on direct writes
might be ok for our use case, but that could also result in a rather wierd API.

> > It is indeed the case (and has been since before quite a few of us
> > were born) that a hole in a sparse file is logically just a bunch of
> > zeros.  A way to make a file for which a hole is an actual hole seems
> > like it would solve this problem nicely.  It could also be solved more
> > specifically for KVM by making sure that the private/shared mode that
> > userspace programs is strict enough to prevent accidental allocations
> > -- if a GPA is definitively private, shared, neither, or (potentially,
> > on TDX only) both, then a page that *isn't* shared will never be
> > accidentally allocated by KVM.
> 
> KVM is clever enough to not allocate since it knows a GPA is shared or
> not. This case it's the host userspace that can cause the allocating and
> is too complex to check on every access from guest.

Yes, KVM is not in the picture at all.  KVM won't trigger allocation, but KVM also
is not in a position to prevent userspace from touching memory.

> > If the shared backing is not mmapped,
> > it also won't be accidentally allocated by host userspace on a stray
> > or careless write.
> 
> As said above, mmap is still prefered, otherwise too many changes are
> needed for usespace VMM.

Forcing userspace to change doesn't bother me too much, the biggest concern is
having to take mmap_lock for write in a per-host process.
