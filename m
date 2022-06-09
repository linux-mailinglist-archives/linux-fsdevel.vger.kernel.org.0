Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C754559D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 22:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbiFIU3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbiFIU3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:29:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2B26EEA1
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 13:29:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso358523pjl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C4/yJYyLya7rE6Jieokr56CujDpfPfuLcGNiEECS+QU=;
        b=CjppovKB2YLi+/umkUgs7TGbUGFHqjbhz+/vuQpURnYcTn7Y/XOYbzw0Ykj8khDf1D
         lU6118PzbLcDnYEohwwuQpWRqLnFFor88HMkhxJnTWzVFPYmlDCWI4t25w0FcOY9LsJ3
         Xx+fRvY97K5Q4b9fyl2wIJsNDu8BFxuzsJC2MBkEM8rOua9Xl2avo9S7S1w8ygcb6WQp
         l07wjz7O+ipoSddpByuvOEx8LLG0at/WFa44rE+IaodvVFqdep6gbL1AbyDvvOmSNBeS
         GcNHdTH1imkTwWGYIM5B+u73KBCppBXzzkigAH/N4DrtNRxqLpENGyWxu6onk+j5isHM
         5lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4/yJYyLya7rE6Jieokr56CujDpfPfuLcGNiEECS+QU=;
        b=txkU3Nzp/MPaEJr4iX1AawPnAwNC4+hQSnMGpdCu0u/qp5PAtliRlkHgFY4LIpF1ZD
         IlUQ0RYnbY4KbUkHdQk8KOE5twVqWlnBEScng8qWvqpDRxl+ewZaaLwihr+D2Ev4JGbH
         WbnXBmX0V5xgQ4m9w6q9vb9QivS2rBdBaqXMo8WGssyppU6MXoR1r5jYt/6RexS9/AfK
         ApE5uQMmvBlOkRw6k/ov4IuEsrDdVyeCH4DBI9nsfd0xihrocXM8LjzxtkV7mWHeWMMK
         EJZKmN6TuuMYKKb/DOQ6k+cBQMyKCFdSCgZpSsOmz/QIrg3BQFvCnI+NMOFc4ugCfsJ4
         LAFA==
X-Gm-Message-State: AOAM5319DipiQZqlcV7txX8aAI9XTonkVZSCwrXzrvAUbPBDYT0nJoqX
        exG9U6WefGgkTnX5ICCiveoTGw==
X-Google-Smtp-Source: ABdhPJx0nBU6Y+TUh04OO6/IROXMWJ7hUc76Ud455mDwfSNlb8nAgIObkwH4NgXB0NSx9cPem36m4g==
X-Received: by 2002:a17:90a:b284:b0:1e3:826b:d11d with SMTP id c4-20020a17090ab28400b001e3826bd11dmr5147277pjr.79.1654806551448;
        Thu, 09 Jun 2022 13:29:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b0016511314b94sm17748369plh.159.2022.06.09.13.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:29:10 -0700 (PDT)
Date:   Thu, 9 Jun 2022 20:29:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
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
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YqJYEheLiGI4KqXF@google.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
 <20220607065749.GA1513445@chaop.bj.intel.com>
 <CAA03e5H_vOQS-qdZgacnmqP5T5jJLnEfm44yfRzJQ2KVu0Br+Q@mail.gmail.com>
 <20220608021820.GA1548172@chaop.bj.intel.com>
 <CAGtprH8xyf07jMN7ubTC__BvDj+z41uVGRiCJ7Rc5cv3KWg03w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH8xyf07jMN7ubTC__BvDj+z41uVGRiCJ7Rc5cv3KWg03w@mail.gmail.com>
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

On Wed, Jun 08, 2022, Vishal Annapurve wrote:
> ...
> > With this patch series, it's actually even not possible for userspace VMM
> > to allocate private page by a direct write, it's basically unmapped from
> > there. If it really wants to, it should so something special, by intention,
> > that's basically the conversion, which we should allow.
> >
> 
> A VM can pass GPA backed by private pages to userspace VMM and when
> Userspace VMM accesses the backing hva there will be pages allocated
> to back the shared fd causing 2 sets of pages backing the same guest
> memory range.
> 
> > Thanks for bringing this up. But in my mind I still think userspace VMM
> > can do and it's its responsibility to guarantee that, if that is hard
> > required.

That was my initial reaction too, but there are unfortunate side effects to punting
this to userspace. 

> By design, userspace VMM is the decision-maker for page
> > conversion and has all the necessary information to know which page is
> > shared/private. It also has the necessary knobs to allocate/free the
> > physical pages for guest memory. Definitely, we should make userspace
> > VMM more robust.
> 
> Making Userspace VMM more robust to avoid double allocation can get
> complex, it will have to keep track of all in-use (by Userspace VMM)
> shared fd memory to disallow conversion from shared to private and
> will have to ensure that all guest supplied addresses belong to shared
> GPA ranges.

IMO, the complexity argument isn't sufficient justfication for introducing new
kernel functionality.  If multiple processes are accessing guest memory then there
already needs to be some amount of coordination, i.e. it can't be _that_ complex.

My concern with forcing userspace to fully handle unmapping shared memory is that
it may lead to additional performance overhead and/or noisy neighbor issues, even
if all guests are well-behaved.

Unnmapping arbitrary ranges will fragment the virtual address space and consume
more memory for all the result VMAs.  The extra memory consumption isn't that big
of a deal, and it will be self-healing to some extent as VMAs will get merged when
the holes are filled back in (if the guest converts back to shared), but it's still
less than desirable.

More concerning is having to take mmap_lock for write for every conversion, which
is very problematic for configurations where a single userspace process maps memory
belong to multiple VMs.  Unmapping and remapping on every conversion will create a
bottleneck, especially if a VM has sub-optimal behavior and is converting pages at
a high rate.

One argument is that userspace can simply rely on cgroups to detect misbehaving
guests, but (a) those types of OOMs will be a nightmare to debug and (b) an OOM
kill from the host is typically considered a _host_ issue and will be treated as
a missed SLO.

An idea for handling this in the kernel without too much complexity would be to
add F_SEAL_FAULT_ALLOCATIONS (terrible name) that would prevent page faults from
allocating pages, i.e. holes can only be filled by an explicit fallocate().  Minor
faults, e.g. due to NUMA balancing stupidity, and major faults due to swap would
still work, but writes to previously unreserved/unallocated memory would get a
SIGSEGV on something it has mapped.  That would allow the userspace VMM to prevent
unintentional allocations without having to coordinate unmapping/remapping across
multiple processes.
