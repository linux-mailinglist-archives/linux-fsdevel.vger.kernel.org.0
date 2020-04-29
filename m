Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1F1BD115
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 02:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD2A3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 20:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2A3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:29:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC5C035494
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 17:29:05 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v18so320209qvx.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 17:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sum6zvnI9uuuHONOiogQ9HloeE5QbhDG16IxplXpyKw=;
        b=gBF0juzP6lNNN9CsauhPBhO02OANPJ2mLHyQLraLJuxmTXzYX3a/IrHNLRunWWLgiG
         YQVRsmq/CQUxnSlv750R4HNOe+f4kPwaWyk0MtrKXzmwYnqUFpOJ5CXJFPShUc+SQm/P
         4qBERO3b+TESmrHgaop2a4RXN2SQvRu7y9GSisP3W+GLS3SS3+L73GmaaALGOymT7K0K
         nIIR4A0TZGwRH9dThz9J/IhinJXc+OLdMJaRrWSTTSghWuweWS/w5EJSyzxLOzHuLQl0
         5dL0b3ddwCB3mIe+/kUSVtBffiLucojHhM3/PGLUAMEKHbSw9EZAapDnMT57NkF8ZjD5
         LVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sum6zvnI9uuuHONOiogQ9HloeE5QbhDG16IxplXpyKw=;
        b=J7fNe115Ywt6J5F3E4Vh4smJEtcPC+KJGFTvQXbddezvCwXKRamukJpuRBFK2pl0jS
         qb1BRQY75HvBmzYwKThQ5M2UTEWbnorXAcJKuNJQczN0gRWeBXSVLthYpdOPGMHgXQw4
         LeHCzSpW9B+VWkJtuUjDToTk9fqBqiK5E0afTvjnv+ndQALSeMs4FvkY4d1nQd+p9dwd
         ORdFfLHKWRc+jIjLR+01XSnglCY584EoLib/7eCUKTibjyjkWzrQywjlS0iVPhcwKhxX
         z/iDVwPphyR7f23nCjBO7HCUe7Fse1YCSDMZY5639vujhYenUXLlZIKhuqlze6XDrXKL
         wETA==
X-Gm-Message-State: AGi0PuZKqQ1AJAIwRJ1FdYR0cMNjrMCcN1TjSS0Jf9xHI551c4KiY/s7
        06GsySjNw0BjumGILw1lPF6J0g==
X-Google-Smtp-Source: APiQypKpF7REJXdifsNrbjdxjECMvWqO7VD/BFBVFuZ0JXzB0iNDmPtTStSILhzusynqtgGAwoi6Fw==
X-Received: by 2002:a0c:b651:: with SMTP id q17mr2047236qvf.135.1588120144906;
        Tue, 28 Apr 2020 17:29:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 134sm14193711qki.16.2020.04.28.17.29.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 17:29:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTab1-0001tN-Gx; Tue, 28 Apr 2020 21:29:03 -0300
Date:   Tue, 28 Apr 2020 21:29:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-doc@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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
Message-ID: <20200429002903.GZ26002@ziepe.ca>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428141223.5b1653db@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:12:23PM -0600, Alex Williamson wrote:

> > > Maybe I was just getting lucky before this commit.  For a
> > > VM_PFNMAP, vaddr_get_pfn() only needs pin_user_pages_remote() to return
> > > error and the vma information that we setup in vfio_pci_mmap().  
> > 
> > I've written on this before, vfio should not be passing pages to the
> > iommu that it cannot pin eg it should not touch VM_PFNMAP vma's in the
> > first place.
> > 
> > It is a use-after-free security issue the way it is..
> 
> Where is the user after free?  Here I'm trying to map device mmio space
> through the iommu, which we need to enable p2p when the user owns
> multiple devices.

Yes, I gathered what the intent was..

> The device is owned by the user, bound to vfio-pci, and can't be
> unbound while the user has it open.  The iommu mappings are torn
> down on release.  I guess I don't understand the problem.

For PFNMAP VMAs the lifecycle rule is basically that the PFN inside
the VMA can only be used inside the mmap_sem that read it. Ie you
cannot take a PFN outside the mmap_sem and continue to use it.

This is because the owner of the VMA owns the lifetime of that PFN,
and under the write side of the mmap_sem it can zap the PFN, or close
the VMA. Afterwards the VMA owner knows that there are no active
reference to the PFN in the system and can reclaim the PFN

ie the PFNMAP has no per-page pin counter. All lifetime revolves around
the mmap_sem and the vma.

What vfio does is take the PFN out of the mmap_sem and program it into
the iommu.

So when the VMA owner decides the PFN has no references, it actually
doesn't: vfio continues to access it beyond its permitted lifetime.

HW like mlx5 and GPUs have BAR pages which have security
properties. Once the PFN is returned to the driver the security
context of the PFN can be reset and re-assigned to another
process. Using VFIO a hostile user space can retain access to the BAR
page and upon its reassignment access a security context they were not
permitted to access.

This is why GUP does not return PFNMAP pages and vfio should not carry
a reference outside the mmap_sem. It breaks all the lifetime rules.

Jason
