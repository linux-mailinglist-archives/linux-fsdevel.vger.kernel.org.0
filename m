Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BB54B7CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbiFNRh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbiFNRhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1EFDC
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 10:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6E50616A4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 17:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB1C3411E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655228271;
        bh=IfvLnQR788L8QWGOY03Cidk5AO0MFCOejaXVfQOMPCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rVsqTEMCOYtQg0EhaeIyrGXi4SPR+xCja/Zzrm4/rXKs2rHudfxst4/iDfEc7IQHK
         231UQkTDY6d6nmdAlt1kRM+zRgLLBDu035jXo5xVowLng3mEh3oiXDy8mQR20Hacmd
         LnzQlaeG3xrE2iaFi/ZdceqCE70b9VENcDWjU+WHKEa2HJsyqUZj0vCI94Pk49Z42u
         h/RWzCu6j4a9w8yEsj7rK5e9uiDjc2EiFUc+avH0qZI0dyuzeA/z91zXgiRd7yeSl3
         8mOVqXBg2pv8zvUY79qtaym4zlYLKvBcSVb7us+LoO+lJ2erExWSiAMs/ARQBPGhP9
         Q8CDnPjgM2DNQ==
Received: by mail-ej1-f44.google.com with SMTP id g25so18562681ejh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 10:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM530WZIJfSBIq9KhEXUFWYDSBp457eDs5hGDnJjbJdeeaGJfqIn82
        SF5b8FMUxFGl4qpsf26ZDzPlwYAPZZz0VnQcjqykGw==
X-Google-Smtp-Source: ABdhPJww+lYVXFvUzPwylC2186LPMaNfdFPXgghAh2gRgIANvpNaY/HFZOJeSAxuhp7fvjON6/ZRor4QvsJ9snnK8jU=
X-Received: by 2002:a17:906:2298:b0:715:7f3d:32ec with SMTP id
 p24-20020a170906229800b007157f3d32ecmr5255068eja.538.1655228269361; Tue, 14
 Jun 2022 10:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
 <20220607065749.GA1513445@chaop.bj.intel.com> <CAA03e5H_vOQS-qdZgacnmqP5T5jJLnEfm44yfRzJQ2KVu0Br+Q@mail.gmail.com>
 <20220608021820.GA1548172@chaop.bj.intel.com> <CAGtprH8xyf07jMN7ubTC__BvDj+z41uVGRiCJ7Rc5cv3KWg03w@mail.gmail.com>
 <YqJYEheLiGI4KqXF@google.com> <20220614072800.GB1783435@chaop.bj.intel.com>
In-Reply-To: <20220614072800.GB1783435@chaop.bj.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 14 Jun 2022 10:37:37 -0700
X-Gmail-Original-Message-ID: <CALCETrWw=Q=1AKW0Jcj3ZGscjyjDJXAjuxOnQx_sabQ6ZtS-wg@mail.gmail.com>
Message-ID: <CALCETrWw=Q=1AKW0Jcj3ZGscjyjDJXAjuxOnQx_sabQ6ZtS-wg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
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
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:32 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 08:29:06PM +0000, Sean Christopherson wrote:
> > On Wed, Jun 08, 2022, Vishal Annapurve wrote:
> >
> > One argument is that userspace can simply rely on cgroups to detect misbehaving
> > guests, but (a) those types of OOMs will be a nightmare to debug and (b) an OOM
> > kill from the host is typically considered a _host_ issue and will be treated as
> > a missed SLO.
> >
> > An idea for handling this in the kernel without too much complexity would be to
> > add F_SEAL_FAULT_ALLOCATIONS (terrible name) that would prevent page faults from
> > allocating pages, i.e. holes can only be filled by an explicit fallocate().  Minor
> > faults, e.g. due to NUMA balancing stupidity, and major faults due to swap would
> > still work, but writes to previously unreserved/unallocated memory would get a
> > SIGSEGV on something it has mapped.  That would allow the userspace VMM to prevent
> > unintentional allocations without having to coordinate unmapping/remapping across
> > multiple processes.
>
> Since this is mainly for shared memory and the motivation is catching
> misbehaved access, can we use mprotect(PROT_NONE) for this? We can mark
> those range backed by private fd as PROT_NONE during the conversion so
> subsequence misbehaved accesses will be blocked instead of causing double
> allocation silently.

This patch series is fairly close to implementing a rather more
efficient solution.  I'm not familiar enough with hypervisor userspace
to really know if this would work, but:

What if shared guest memory could also be file-backed, either in the
same fd or with a second fd covering the shared portion of a memslot?
This would allow changes to the backing store (punching holes, etc) to
be some without mmap_lock or host-userspace TLB flushes?  Depending on
what the guest is doing with its shared memory, userspace might need
the memory mapped or it might not.

--Andy
