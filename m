Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E546F457247
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhKSQD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 11:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhKSQD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:03:29 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338CC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 08:00:27 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id f20so9882150qtb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtV9HHXd4X5WRhcYz4pKiiL6eAEsTLpENVV+xmm0B1E=;
        b=gsJUvh5WctLgXnshRJv4wGg2JAgnGdSqNb3S1bmxpaDvTOBEX8LcgLW/+JvwTzVB37
         v5K7AG9csFvUa4d1e8VMH07tEJ/4GXeXR0y5xTNeGGDEbPPYGPgXDzn7G4nizRSxv1eO
         ORYsNAAPbkIfEb6NsGnWQ8GCPrvVKrf/49w0ZT27g2F3XOg052ttHxyU5wmveX2QAeR0
         /CkUMXANh4cDh+HorkLPLoxEa1f7SRa67fSFzDU/E1oWa7A8N6PtOVfUv80pyqxAxqRj
         YJDGrR6Uf5+iNfe0u7fumnhfivIpDOd+RCAzSsT04BV51dAxqsTNgRzPecBJz4DuF5VH
         RdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtV9HHXd4X5WRhcYz4pKiiL6eAEsTLpENVV+xmm0B1E=;
        b=hW9q3XNJ+5UG5KUF7M4A9cytcS3FfZwMIxPBzrxHBlm7u/ytr3bO4G5oYNyMcUnLpJ
         QG/87ltEO4bQGUqcQzA34mdsd11eqlXRblGROrEgnpJMi+5S9JMf3eGCBtdeA9Qb3mJi
         KRR53S11CrGeEtsfSi7rOCgUw17nAdpwRpMx0ncwHeA6tMRfm0EF3k+IecyGG+2mb4Aq
         xPxTZRE0BkcMe7lfdN+ELbrumlhpkkubSvse/HbxllpiCu5pDXKQAA/OaGAiQgV9GNnu
         5i0Vu8DaBKklKQVEHa9WRQU06Ehi/eacUll6NfpjYkJIjHYRQP1Os+yoSM4QZX7D3bel
         jpBw==
X-Gm-Message-State: AOAM5307fdHdJJrZFcpkkCfEGszKtNTwnQNPFVjRn/bOhw2zuLmyvV0D
        3c+9dOY3XZfdwRxgYBZ0YaLkAA==
X-Google-Smtp-Source: ABdhPJxKednFIP8LV5fXPBeBBtPHTY7W03I8IO74iFi+Vm9ZxLiGU52DJu0TAbPkEtajZX/lLl8ZnA==
X-Received: by 2002:a05:622a:349:: with SMTP id r9mr7258679qtw.213.1637337626383;
        Fri, 19 Nov 2021 08:00:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j20sm54140qko.117.2021.11.19.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:00:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mo6JL-00CHtq-W3; Fri, 19 Nov 2021 12:00:24 -0400
Date:   Fri, 19 Nov 2021 12:00:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211119160023.GI876299@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 04:39:15PM +0100, David Hildenbrand wrote:

> > If qmeu can put all the guest memory in a memfd and not map it, then
> > I'd also like to see that the IOMMU can use this interface too so we
> > can have VFIO working in this configuration.
> 
> In QEMU we usually want to (and must) be able to access guest memory
> from user space, with the current design we wouldn't even be able to
> temporarily mmap it -- which makes sense for encrypted memory only. The
> corner case really is encrypted memory. So I don't think we'll see a
> broad use of this feature outside of encrypted VMs in QEMU. I might be
> wrong, most probably I am :)

Interesting..

The non-encrypted case I had in mind is the horrible flow in VFIO to
support qemu re-execing itself (VFIO_DMA_UNMAP_FLAG_VADDR).

Here VFIO is connected to a VA in a mm_struct that will become invalid
during the kexec period, but VFIO needs to continue to access it. For
IOMMU cases this is OK because the memory is already pinned, but for
the 'emulated iommu' used by mdevs pages are pinned dynamically. qemu
needs to ensure that VFIO can continue to access the pages across the
kexec, even though there is nothing to pin_user_pages() on.

This flow would work a lot better if VFIO was connected to the memfd
that is storing the guest memory. Then it naturally doesn't get
disrupted by exec() and we don't need the mess in the kernel..

I was wondering if we could get here using the direct_io APIs but this
would do the job too.

> Apart from the special "encrypted memory" semantics, I assume nothing
> speaks against allowing for mmaping these memfds, for example, for any
> other VFIO use cases.

We will eventually have VFIO with "encrypted memory". There was a talk
in LPC about the enabling work for this.

So, if the plan is to put fully encrpyted memory inside a memfd, then
we still will eventually need a way to pull the pfns it into the
IOMMU, presumably along with the access control parameters needed to
pass to the secure monitor to join a PCI device to the secure memory.

Jason
