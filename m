Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80E3458FD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhKVOCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 09:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbhKVOCh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:02:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F08FC06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 05:59:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m27so80881104lfj.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q7OhoPungBQlpmy/07g8Fe+342nGWhdV6y8JU2nGv18=;
        b=vT0USDJF2fCKLhM7AtmhHZ6TqmNhALxV9Bh1G9113KXxZPkG5aIQh+e3yJp+NMyEgB
         yyjush06rRDAKf6xyUA+EMVlTfQFUDAid0CUtMtmeUtHix0pvnF7sbVcje0OV7nvBw9a
         g/8GZ6NHc48vcDLcr1f3fW01yrRMGBsBbjITwRurbUP5g1aabFr4PnvcR9GVkDnhTJOZ
         I3gDHccbJ7qYXpaRZGgxrspIfnGqi2qJLDQzshng4iQv3se7ahPPk7IgwWM5bY1jozMl
         SfrrFIYhsGdWwbB4Wq4Hi54Cs40biyzXYNHrpN0Wwyms/lv0ik/a9vUpy/9oPybPTkwE
         XN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7OhoPungBQlpmy/07g8Fe+342nGWhdV6y8JU2nGv18=;
        b=AQxWvvRnYyXHtKasg+jJlwtuPV6rXn/RGostmc6GjkgoxEwj0BWBMlh9GlIBkZuZSR
         CH5axeSbOrZgFJ0Dz7EKHKQoqwQoBl4xI+uWrmynh81x9dPMfqzsF8QIpirg3uw5b85h
         1c6xuoBBKsmHWqAuf4gsyyZhelXVcAo+NqzIw1r1vu2kCrNgan8v50jEoWHc94RIhgz6
         wgnbNr3ZH/5dkhJxixlRcPqHQcVODPNVDPSRZa7cT+9EwXM190JGzYfYUiar2wyGwnYa
         WzJZsLps+pnHVBjxeWIUjnj8w8cbze2/HKGhOZTjoasmb9LVHy37j4jMj/i1HnjyIXXJ
         O1dg==
X-Gm-Message-State: AOAM533VLR2sshwtFx2pp+pkV+EkZpB9fvDytznHjv5Bo7OmNmyA8gGS
        PShxfpSkpX3CEYWIEH47t9WADw==
X-Google-Smtp-Source: ABdhPJwOSduIL/T2HcuHSSI/wDp1Ip4IJTwBbrmlaHHjfVN4PCNHDjahR2ZbiKbNVp+QmDNNUEuLww==
X-Received: by 2002:a2e:9545:: with SMTP id t5mr51763112ljh.225.1637589567919;
        Mon, 22 Nov 2021 05:59:27 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i17sm967582lfe.281.2021.11.22.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 05:59:27 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id AD905103610; Mon, 22 Nov 2021 16:59:33 +0300 (+03)
Date:   Mon, 22 Nov 2021 16:59:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Wanpeng Li <wanpengli@tencent.com>, luto@kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>, dave.hansen@intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        jun.nakajima@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, john.ji@intel.com,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211122135933.arjxpl7wyskkwvwv@box.shutemov.name>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <942e0dd6-e426-06f6-7b6c-0e80d23c27e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942e0dd6-e426-06f6-7b6c-0e80d23c27e6@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 02:51:11PM +0100, David Hildenbrand wrote:
> On 19.11.21 14:47, Chao Peng wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > The new seal type provides semantics required for KVM guest private
> > memory support. A file descriptor with the seal set is going to be used
> > as source of guest memory in confidential computing environments such as
> > Intel TDX and AMD SEV.
> > 
> > F_SEAL_GUEST can only be set on empty memfd. After the seal is set
> > userspace cannot read, write or mmap the memfd.
> > 
> > Userspace is in charge of guest memory lifecycle: it can allocate the
> > memory with falloc or punch hole to free memory from the guest.
> > 
> > The file descriptor passed down to KVM as guest memory backend. KVM
> > register itself as the owner of the memfd via memfd_register_guest().
> > 
> > KVM provides callback that needed to be called on fallocate and punch
> > hole.
> > 
> > memfd_register_guest() returns callbacks that need be used for
> > requesting a new page from memfd.
> > 
> 
> Repeating the feedback I already shared in a private mail thread:
> 
> 
> As long as page migration / swapping is not supported, these pages
> behave like any longterm pinned pages (e.g., VFIO) or secretmem pages.
> 
> 1. These pages are not MOVABLE. They must not end up on ZONE_MOVABLE or
> MIGRATE_CMA.
> 
> That should be easy to handle, you have to adjust the gfp_mask to
> 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> just as mm/secretmem.c:secretmem_file_create() does.

Okay, fair enough. mapping_set_unevictable() also makes sesne.

> 2. These pages behave like mlocked pages and should be accounted as such.
> 
> This is probably where the accounting "fun" starts, but maybe it's
> easier than I think to handle.
> 
> See mm/secretmem.c:secretmem_mmap(), where we account the pages as
> VM_LOCKED and will consequently check per-process mlock limits. As we
> don't mmap(), the same approach cannot be reused.
> 
> See drivers/vfio/vfio_iommu_type1.c:vfio_pin_map_dma() and
> vfio_pin_pages_remote() on how to manually account via mm->locked_vm .
> 
> But it's a bit hairy because these pages are not actually mapped into
> the page tables of the MM, so it might need some thought. Similarly,
> these pages actually behave like "pinned" (as in mm->pinned_vm), but we
> just don't increase the refcount AFAIR. Again, accounting really is a
> bit hairy ...

Accounting is fun indeed. Non-mapped mlocked memory is going to be
confusing. Hm...

I will look closer.

-- 
 Kirill A. Shutemov
