Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B6D53F6C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiFGHBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 03:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiFGHBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:01:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA2DFD13;
        Tue,  7 Jun 2022 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654585305; x=1686121305;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ZV74rA8Yj9vsewf5ZR+zBoOmFi7pomIO9JTPNnhNKN8=;
  b=K0kATua1kyotCI00blMzra3BpvqvEwQpBF3ONucBFBtci+cCdKzXAutw
   TBRE/He+PipiFuZbJFq3dCEGT8pTGxug7femgjarN8qJP2e2NkuICxD85
   HC2IekcArSCZXgpkrgzLbRbmtScHP5OtGxCXKBJ+cHOVpPd0euTpANd31
   dky0nXhbdal3koQTU6Fcg0ba6j2EmTCTISRqo90924sTdqmqBovn664lZ
   u+cIB0RT1tm9jbvR+OqPKgjFNCp2zunFI7j0sJQzy7fe8fnKCkWxXteXY
   FQOOWwTmyKy2m/CdR8+Ki7bZBapqBZfdYU7urAQ18blSGx87h3yeYkBFq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277355550"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277355550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="579485634"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2022 00:01:13 -0700
Date:   Tue, 7 Jun 2022 14:57:49 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220607065749.GA1513445@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 01:09:50PM -0700, Vishal Annapurve wrote:
> >
> > Private memory map/unmap and conversion
> > ---------------------------------------
> > Userspace's map/unmap operations are done by fallocate() ioctl on the
> > backing store fd.
> >   - map: default fallocate() with mode=0.
> >   - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.
> > The map/unmap will trigger above memfile_notifier_ops to let KVM map/unmap
> > secondary MMU page tables.
> >
> ....
> >    QEMU: https://github.com/chao-p/qemu/tree/privmem-v6
> >
> > An example QEMU command line for TDX test:
> > -object tdx-guest,id=tdx \
> > -object memory-backend-memfd-private,id=ram1,size=2G \
> > -machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1
> >
> 
> There should be more discussion around double allocation scenarios
> when using the private fd approach. A malicious guest or buggy
> userspace VMM can cause physical memory getting allocated for both
> shared (memory accessible from host) and private fds backing the guest
> memory.
> Userspace VMM will need to unback the shared guest memory while
> handling the conversion from shared to private in order to prevent
> double allocation even with malicious guests or bugs in userspace VMM.

I don't know how malicious guest can cause that. The initial design of
this serie is to put the private/shared memory into two different
address spaces and gives usersapce VMM the flexibility to convert
between the two. It can choose respect the guest conversion request or
not.

It's possible for a usrspace VMM to cause double allocation if it fails
to call the unback operation during the conversion, this may be a bug
or not. Double allocation may not be a wrong thing, even in conception.
At least TDX allows you to use half shared half private in guest, means
both shared/private can be effective. Unbacking the memory is just the
current QEMU implementation choice.

Chao
> 
> Options to unback shared guest memory seem to be:
> 1) madvise(.., MADV_DONTNEED/MADV_REMOVE) - This option won't stop
> kernel from backing the shared memory on subsequent write accesses
> 2) fallocate(..., FALLOC_FL_PUNCH_HOLE...) - For file backed shared
> guest memory, this option still is similar to madvice since this would
> still allow shared memory to get backed on write accesses
> 3) munmap - This would give away the contiguous virtual memory region
> reservation with holes in the guest backing memory, which might make
> guest memory management difficult.
> 4) mprotect(... PROT_NONE) - This would keep the virtual memory
> address range backing the guest memory preserved
> 
> ram_block_discard_range_fd from reference implementation:
> https://github.com/chao-p/qemu/tree/privmem-v6 seems to be relying on
> fallocate/madvise.
> 
> Any thoughts/suggestions around better ways to unback the shared
> memory in order to avoid double allocation scenarios?
> 
> Regards,
> Vishal
