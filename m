Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5C1BCD29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD1UMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 16:12:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1UMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588104753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OKswG1ruzns5I21UqjqGNJ9iohxx9gNx+0J1CK9CTA=;
        b=D0C+GL9gb42BSyu+10PlWp9ItWFFKkM8YSUAhBaz15H3FbaBdZC5rPLY5AMrIoOoL9BlIs
        qSvQTEanSzzgRY3yvQMe5H3fwOBde5QRyyau42pkjO9D/HkHNJNayrJGzHfb7ITZca907a
        KwSo9gOS6rSnSMk43SVdVp3Gv+U+7QA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-z8QR-YRYPemkXjd5Mb2htQ-1; Tue, 28 Apr 2020 16:12:28 -0400
X-MC-Unique: z8QR-YRYPemkXjd5Mb2htQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0171895A28;
        Tue, 28 Apr 2020 20:12:25 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 037E9648D6;
        Tue, 28 Apr 2020 20:12:23 +0000 (UTC)
Date:   Tue, 28 Apr 2020 14:12:23 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org
Cc:     John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20200428141223.5b1653db@w520.home>
In-Reply-To: <20200428192251.GW26002@ziepe.ca>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
        <20200211001536.1027652-7-jhubbard@nvidia.com>
        <20200424121846.5ee2685f@w520.home>
        <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
        <20200424141548.5afdd2bb@w520.home>
        <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
        <20200428105455.30343fb4@w520.home>
        <20200428174957.GV26002@ziepe.ca>
        <20200428130752.75c153bd@w520.home>
        <20200428192251.GW26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Apr 2020 16:22:51 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Apr 28, 2020 at 01:07:52PM -0600, Alex Williamson wrote:
> > On Tue, 28 Apr 2020 14:49:57 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > On Tue, Apr 28, 2020 at 10:54:55AM -0600, Alex Williamson wrote:  
> > > >  static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
> > > >  {
> > > >  	struct vfio_pci_device *vdev = device_data;
> > > > @@ -1253,8 +1323,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
> > > >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > >  	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
> > > >  
> > > > +	vma->vm_ops = &vfio_pci_mmap_ops;
> > > > +
> > > > +#if 1
> > > > +	return 0;
> > > > +#else
> > > >  	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> > > > -			       req_len, vma->vm_page_prot);
> > > > +			       vma->vm_end - vma->vm_start, vma->vm_page_prot);    
> > > 
> > > The remap_pfn_range here is what tells get_user_pages this is a
> > > non-struct page mapping:
> > > 
> > > 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> > > 
> > > Which has to be set when the VMA is created, they shouldn't be
> > > modified during fault.  
> > 
> > Aha, thanks Jason!  So fundamentally, pin_user_pages_remote() should
> > never have been faulting in this vma since the pages are non-struct
> > page backed.   
> 
> gup should not try to pin them.. I think the VM will still call fault
> though, not sure from memory?

Hmm, at commit 3faa52c03f44 the behavior is that I don't see a fault on
pin, maybe that's a bug.  But trying to rebase to current top of tree,
now my DMA mapping gets an -EFAULT, so something is still funky :-\

> > Maybe I was just getting lucky before this commit.  For a
> > VM_PFNMAP, vaddr_get_pfn() only needs pin_user_pages_remote() to return
> > error and the vma information that we setup in vfio_pci_mmap().  
> 
> I've written on this before, vfio should not be passing pages to the
> iommu that it cannot pin eg it should not touch VM_PFNMAP vma's in the
> first place.
> 
> It is a use-after-free security issue the way it is..

Where is the user after free?  Here I'm trying to map device mmio space
through the iommu, which we need to enable p2p when the user owns
multiple devices.  The device is owned by the user, bound to vfio-pci,
and can't be unbound while the user has it open.  The iommu mappings
are torn down on release.  I guess I don't understand the problem.

> > only need the fault handler to trigger for user access, which is what I
> > see with this change.  That should work for me.
> >   
> > > Also the vma code above looked a little strange to me, if you do send
> > > something like this cc me and I can look at it. I did some work like
> > > this for rdma a while ago..  
> > 
> > Cool, I'll do that.  I'd like to be able to zap the vmas from user
> > access at a later point and I have doubts that I'm holding the
> > refs/locks that I need to for that.  Thanks,  
> 
> Check rdma_umap_ops, it does what you described (actually it replaces
> them with 0 page, but along the way it zaps too).

Ok, thanks,

Alex

