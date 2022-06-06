Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C553EF28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiFFUKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiFFUKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:10:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11512D1DD
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 13:10:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e11so13571186pfj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jun 2022 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQFpDXi6bD7+wKzTyAPy27GXXUSscdFak0V6JCay3LM=;
        b=Lt8bn1CKv27NBAN2LZ6a3kjXi7zTNT9n5YC6qdlDRRz27wSGX169ro34tJXroQ4ylw
         9Wh5AtBkZYrRJCB6VOaJC0MlhiSdzn1C4PqwPfP5C2UQ58ClSnY1eORDsS+jz9o2IDri
         ni9cn1KDaMb5LTVmi0K48gTlOfkMsvw04FEVxngHWMm311dg/8tSsLNw8NZngXEjzLdm
         MRj2v0erbTuphncL4y5iv8ZG1Wuu7I1voO3ifQtd6JmL8xCnR4egkVJv67k8mCcsucuy
         B7Vorowmpt94+GNwzICo6EQEcNJyTDkVWQJuYGl9kQjzC8CdwmuVUJOWPEVPDexxdgNI
         LvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQFpDXi6bD7+wKzTyAPy27GXXUSscdFak0V6JCay3LM=;
        b=PLdmS4vTzJpzuUCDL4sSyKCJPFYMe7CwcwQVdSb1faPM7bjRGYWj73xidN7Fan+nyN
         81bXBCIDFSJvjzQ1K6NJkrwOb02av0FZe0+xiIyX5znv0hNCjDdfapTl1TpahtlS2fah
         G/as800DziNR+xyDCRDzvMEpr33dW8rF9Pb3pp49GG7CB8ezWVBTBqQvhqoakD+Bbid7
         wJIaFykPG5A8+ybiHagOCNHiWSPnmtERy4Snb4isF1mMVq0pEN686KvOLy1CNBNJslxy
         yrl3RJrrd8mXzDg0wt7WTLHugFklh7qU3gRlN3/TI1fp7twTptYWAeQQadgAnb5bgDap
         t8uQ==
X-Gm-Message-State: AOAM533DF+T/d7SgYPamiZV2xNMUDCzKJh+63FdRAeiR2P2vhVcQc6G/
        TK0HlClQvQ0tZ4INqx71u2hI/m5Ado01A+cKBukI8A==
X-Google-Smtp-Source: ABdhPJz71kp7wjsXPjRB2ML7eIa2fwB82eNGfeI62OXeQw8INa+MLyq06Q2ncMec3mjRtswZPQ72CnuvPkBz4ir4YOc=
X-Received: by 2002:a63:69c2:0:b0:3fa:78b5:d991 with SMTP id
 e185-20020a6369c2000000b003fa78b5d991mr23043411pgc.40.1654546201400; Mon, 06
 Jun 2022 13:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
In-Reply-To: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 6 Jun 2022 13:09:50 -0700
Message-ID: <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> Private memory map/unmap and conversion
> ---------------------------------------
> Userspace's map/unmap operations are done by fallocate() ioctl on the
> backing store fd.
>   - map: default fallocate() with mode=0.
>   - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.
> The map/unmap will trigger above memfile_notifier_ops to let KVM map/unmap
> secondary MMU page tables.
>
....
>    QEMU: https://github.com/chao-p/qemu/tree/privmem-v6
>
> An example QEMU command line for TDX test:
> -object tdx-guest,id=tdx \
> -object memory-backend-memfd-private,id=ram1,size=2G \
> -machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1
>

There should be more discussion around double allocation scenarios
when using the private fd approach. A malicious guest or buggy
userspace VMM can cause physical memory getting allocated for both
shared (memory accessible from host) and private fds backing the guest
memory.
Userspace VMM will need to unback the shared guest memory while
handling the conversion from shared to private in order to prevent
double allocation even with malicious guests or bugs in userspace VMM.

Options to unback shared guest memory seem to be:
1) madvise(.., MADV_DONTNEED/MADV_REMOVE) - This option won't stop
kernel from backing the shared memory on subsequent write accesses
2) fallocate(..., FALLOC_FL_PUNCH_HOLE...) - For file backed shared
guest memory, this option still is similar to madvice since this would
still allow shared memory to get backed on write accesses
3) munmap - This would give away the contiguous virtual memory region
reservation with holes in the guest backing memory, which might make
guest memory management difficult.
4) mprotect(... PROT_NONE) - This would keep the virtual memory
address range backing the guest memory preserved

ram_block_discard_range_fd from reference implementation:
https://github.com/chao-p/qemu/tree/privmem-v6 seems to be relying on
fallocate/madvise.

Any thoughts/suggestions around better ways to unback the shared
memory in order to avoid double allocation scenarios?

Regards,
Vishal
