Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52F542310
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiFHDqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 23:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiFHDpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:45:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774619CB79
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 17:56:07 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h187so13061790oif.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFH16JpjBRikHN1IAO48ehtoxfzCGCzN3oM9EiMa6X8=;
        b=l4i+k+6Abr5HeudzU075zO0r/BLzbacv0V6STNZIEAEBluaeTcRvx1TChTOuxyCASs
         uAUgVwmDgoEyG6k0dhZ8NFmw5OEbd2l74yvSxXxWA53CBaw9OoBV3iEq26EPYk4y+7IT
         qKn9JDYz2OP806c9cvPpDahmxZAZDvrVhTSIayulr7dYNanhmDiOChse+RJNE6HykCsj
         9xuaaLmPGA8/BJDWN8cpUzOPbGbAyNe0shOzPx2NRgDBxX7ug5Bu5rZe5CkKdYsGZDwp
         RBwBbso17/gWhg2hEdQ9VBPL7L2J3NplhFzwna8YW9Inmvn2hE+jo34OGkRp4w12iAUj
         sThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFH16JpjBRikHN1IAO48ehtoxfzCGCzN3oM9EiMa6X8=;
        b=TlHSx72af03jzI8Fr369SwU7JY/bYF8uoXSQfbyliPA9dlyc+TojeQGdZgZvY9S9+m
         ZlnnL8mzPBAJSsRAkjeZqEJZquxLG8pOFGJ7/KQrOCQUCHdDgqb6wx7Ftce222mjFsCI
         yfD56vReAg0aPg6RU5r7n+vlnAViL5ptw77XOyOuAzzDKEMLJYbdDAJhHDgYqlsvRHzt
         yXz1NiXVzP+ZgBnMqbm4N0VJJbezTd6U52l0rD9qxqou9N9I4U+bR5xy6fFeJAUXnWKu
         vFmj2jT4385f3brSgpv5Aq46tqXaGx7uWchcT8HMzUrd5RDYoegohvHOm6eflTZD+RY+
         eMnw==
X-Gm-Message-State: AOAM530EClbhZeRQRm+K+OU3mqCa5MvDXE474h4ZY/YFUK9K4sTIT8Q0
        dACpJ7eJQJXmAOEwi1NXduEcIDK0vMFnzLbL2ajm2Q==
X-Google-Smtp-Source: ABdhPJwjBSZgp55zoUZOFIm3kjCTD4NqCF0p7muhSr/F2gMJemxqIIRloSiqM46aTGwoS/mB8l6y90gRDZltreZ8pZ8=
X-Received: by 2002:a05:6808:bd3:b0:32e:400d:1eb1 with SMTP id
 o19-20020a0568080bd300b0032e400d1eb1mr1047136oik.110.1654649757116; Tue, 07
 Jun 2022 17:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com> <20220607065749.GA1513445@chaop.bj.intel.com>
In-Reply-To: <20220607065749.GA1513445@chaop.bj.intel.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 7 Jun 2022 17:55:46 -0700
Message-ID: <CAA03e5H_vOQS-qdZgacnmqP5T5jJLnEfm44yfRzJQ2KVu0Br+Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Vishal Annapurve <vannapurve@google.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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

On Tue, Jun 7, 2022 at 12:01 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> On Mon, Jun 06, 2022 at 01:09:50PM -0700, Vishal Annapurve wrote:
> > >
> > > Private memory map/unmap and conversion
> > > ---------------------------------------
> > > Userspace's map/unmap operations are done by fallocate() ioctl on the
> > > backing store fd.
> > >   - map: default fallocate() with mode=0.
> > >   - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.
> > > The map/unmap will trigger above memfile_notifier_ops to let KVM map/unmap
> > > secondary MMU page tables.
> > >
> > ....
> > >    QEMU: https://github.com/chao-p/qemu/tree/privmem-v6
> > >
> > > An example QEMU command line for TDX test:
> > > -object tdx-guest,id=tdx \
> > > -object memory-backend-memfd-private,id=ram1,size=2G \
> > > -machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1
> > >
> >
> > There should be more discussion around double allocation scenarios
> > when using the private fd approach. A malicious guest or buggy
> > userspace VMM can cause physical memory getting allocated for both
> > shared (memory accessible from host) and private fds backing the guest
> > memory.
> > Userspace VMM will need to unback the shared guest memory while
> > handling the conversion from shared to private in order to prevent
> > double allocation even with malicious guests or bugs in userspace VMM.
>
> I don't know how malicious guest can cause that. The initial design of
> this serie is to put the private/shared memory into two different
> address spaces and gives usersapce VMM the flexibility to convert
> between the two. It can choose respect the guest conversion request or
> not.

For example, the guest could maliciously give a device driver a
private page so that a host-side virtual device will blindly write the
private page.

> It's possible for a usrspace VMM to cause double allocation if it fails
> to call the unback operation during the conversion, this may be a bug
> or not. Double allocation may not be a wrong thing, even in conception.
> At least TDX allows you to use half shared half private in guest, means
> both shared/private can be effective. Unbacking the memory is just the
> current QEMU implementation choice.

Right. But the idea is that this patch series should accommodate all
of the CVM architectures. Or at least that's what I know was
envisioned last time we discussed this topic for SNP [*].

Regardless, it's important to ensure that the VM respects its memory
budget. For example, within Google, we run VMs inside of containers.
So if we double allocate we're going to OOM. This seems acceptable for
an early version of CVMs. But ultimately, I think we need a more
robust way to ensure that the VM operates within its memory container.
Otherwise, the OOM is going to be hard to diagnose and distinguish
from a real OOM.

[*] https://lore.kernel.org/all/20210820155918.7518-1-brijesh.singh@amd.com/

>
> Chao
> >
> > Options to unback shared guest memory seem to be:
> > 1) madvise(.., MADV_DONTNEED/MADV_REMOVE) - This option won't stop
> > kernel from backing the shared memory on subsequent write accesses
> > 2) fallocate(..., FALLOC_FL_PUNCH_HOLE...) - For file backed shared
> > guest memory, this option still is similar to madvice since this would
> > still allow shared memory to get backed on write accesses
> > 3) munmap - This would give away the contiguous virtual memory region
> > reservation with holes in the guest backing memory, which might make
> > guest memory management difficult.
> > 4) mprotect(... PROT_NONE) - This would keep the virtual memory
> > address range backing the guest memory preserved
> >
> > ram_block_discard_range_fd from reference implementation:
> > https://github.com/chao-p/qemu/tree/privmem-v6 seems to be relying on
> > fallocate/madvise.
> >
> > Any thoughts/suggestions around better ways to unback the shared
> > memory in order to avoid double allocation scenarios?

I agree with Vishal. I think this patch set is making great progress.
But the double allocation scenario seems like a high-level design
issue that warrants more discussion.
