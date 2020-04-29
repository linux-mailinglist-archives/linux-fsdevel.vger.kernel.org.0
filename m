Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941211BE7EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2T4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 15:56:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726743AbgD2T4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588190200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6rk25Tv2imwj4OrlKEUTzABdfyr8dyAJgvrX//k5fs=;
        b=D1S0Ba1qaQQe6L/411Vh8WBHUHWaZ0mIyejkNERPzR1DZvwRPzs2h1RG4OiNz0ociyqy1l
        a7Su5UMGHALKfY5SBS28UpovBcowFSjjUbf+s2so/fg057U3c6J/F2CM6TbeouE20Ytf6C
        HPmCTY1hZIYpNREXrTRUaoNtI6+EkGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Jn-7UCXpM_6y8Jb0umYfuw-1; Wed, 29 Apr 2020 15:56:38 -0400
X-MC-Unique: Jn-7UCXpM_6y8Jb0umYfuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D5CC107ACCA;
        Wed, 29 Apr 2020 19:56:35 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9425366062;
        Wed, 29 Apr 2020 19:56:33 +0000 (UTC)
Date:   Wed, 29 Apr 2020 13:56:33 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-doc@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [regression?] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200429135633.626a8411@w520.home>
In-Reply-To: <20200429002903.GZ26002@ziepe.ca>
References: <20200211001536.1027652-7-jhubbard@nvidia.com>
        <20200424121846.5ee2685f@w520.home>
        <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
        <20200424141548.5afdd2bb@w520.home>
        <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
        <20200428105455.30343fb4@w520.home>
        <20200428174957.GV26002@ziepe.ca>
        <20200428130752.75c153bd@w520.home>
        <20200428192251.GW26002@ziepe.ca>
        <20200428141223.5b1653db@w520.home>
        <20200429002903.GZ26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Apr 2020 21:29:03 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Apr 28, 2020 at 02:12:23PM -0600, Alex Williamson wrote:
> 
> > > > Maybe I was just getting lucky before this commit.  For a
> > > > VM_PFNMAP, vaddr_get_pfn() only needs pin_user_pages_remote() to return
> > > > error and the vma information that we setup in vfio_pci_mmap().    
> > > 
> > > I've written on this before, vfio should not be passing pages to the
> > > iommu that it cannot pin eg it should not touch VM_PFNMAP vma's in the
> > > first place.
> > > 
> > > It is a use-after-free security issue the way it is..  
> > 
> > Where is the user after free?  Here I'm trying to map device mmio space
> > through the iommu, which we need to enable p2p when the user owns
> > multiple devices.  
> 
> Yes, I gathered what the intent was..
> 
> > The device is owned by the user, bound to vfio-pci, and can't be
> > unbound while the user has it open.  The iommu mappings are torn
> > down on release.  I guess I don't understand the problem.  
> 
> For PFNMAP VMAs the lifecycle rule is basically that the PFN inside
> the VMA can only be used inside the mmap_sem that read it. Ie you
> cannot take a PFN outside the mmap_sem and continue to use it.
> 
> This is because the owner of the VMA owns the lifetime of that PFN,
> and under the write side of the mmap_sem it can zap the PFN, or close
> the VMA. Afterwards the VMA owner knows that there are no active
> reference to the PFN in the system and can reclaim the PFN
> 
> ie the PFNMAP has no per-page pin counter. All lifetime revolves around
> the mmap_sem and the vma.
> 
> What vfio does is take the PFN out of the mmap_sem and program it into
> the iommu.
> 
> So when the VMA owner decides the PFN has no references, it actually
> doesn't: vfio continues to access it beyond its permitted lifetime.
> 
> HW like mlx5 and GPUs have BAR pages which have security
> properties. Once the PFN is returned to the driver the security
> context of the PFN can be reset and re-assigned to another
> process. Using VFIO a hostile user space can retain access to the BAR
> page and upon its reassignment access a security context they were not
> permitted to access.
> 
> This is why GUP does not return PFNMAP pages and vfio should not carry
> a reference outside the mmap_sem. It breaks all the lifetime rules.

Thanks for the explanation.  I'm inferring that there is no solution to
this, but why can't we use mmu notifiers to invalidate the iommu on zap
or close?  I know that at least QEMU won't consider these sorts of
mapping fatal, so we could possibly change the default and make support
for such mappings opt-in, but I don't know if I'd break DPDK, or
potentially users within QEMU that make use of p2p between devices.
Thanks,

Alex

