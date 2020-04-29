Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E71BEC61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 01:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgD2XDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 19:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgD2XDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:03:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CBCC08E859
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 16:03:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 23so3922974qkf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyDw5QOX4WfyUC8G627O7ysI5MXH2/kRIYRidhm+34A=;
        b=Lf9PP9+pAmFpHpj/QA/vAUx6tPP+SMmy9otSkTHgBufep+WZtwcfRYFXHUYzeNOZY0
         SSSAR5BfKXwu+JpXHmhJr/JUUF9F5hoGfhF6zI6lutQMd9Gy8+ZrIUYooreCLbeZdRSc
         A0tS3wmiYn5H/hE8vNDkLWe9KcZ9XxaAC14AzAByukRe7mwS8No33u3J0IZlCXxvO6Ph
         T0mxIgWGenP6PReTGK9OG7LFtVW/sn/EUUbm4WEIwCHNzRpfNw3inm8gqhw/QKNkHvdf
         0S5BwcySsi/C4sLiJ/A9nsBPJGLQoB/ie9s3uFiuMVtheZVMWRuv7ke7ViClk89F4oDY
         e4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyDw5QOX4WfyUC8G627O7ysI5MXH2/kRIYRidhm+34A=;
        b=gwYtxPImKrtAHIA06EEpmS9yXFrMXxce5TUaRQCje9kMciPFObmPujtWv4AjfOGRCK
         309QPGB1wAGkGpx7j7vWk3EdIfKcQxjN6bsHpvQCSLMVyn1Cbc+eEUcqGQ5QhIy4eA3M
         zsid1/Flo04NNHaZs6nIStjb4JTI5RFnQnBbYilS0meenDukRMMpAGQGp7yJqULT1Z5o
         W/6bZv53dSzJ6c1KVj/uJ8T9VHxBEl+Yl29HsmGV2gGclm7GGD4A2MT7fkHu+qnpf+CA
         zy3ar0QGMAsDKKlQO/bt10x9Nxbr++4VaRe6FmlVbrjlXr6Bcb1YeXdRAqk+yFEq51pu
         d/Tg==
X-Gm-Message-State: AGi0PuZvrL5jWJwOYw7p2ST6BUdsCabb6rghlHDnXMz/tE99hLbf3h1h
        p9KgBym8NVHNyjjcolXbfNZU1A==
X-Google-Smtp-Source: APiQypIMM3qPwE29FFUjHN0D+hYMHptYMFkDQiz7DJhIoeMIpRIpI7WoZIuhGnKXuL/3vQ+au4ADbA==
X-Received: by 2002:a05:620a:166d:: with SMTP id d13mr787657qko.448.1588201383344;
        Wed, 29 Apr 2020 16:03:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i2sm446118qki.54.2020.04.29.16.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 16:03:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTvjJ-0000sP-V0; Wed, 29 Apr 2020 20:03:01 -0300
Date:   Wed, 29 Apr 2020 20:03:01 -0300
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
Message-ID: <20200429230301.GL26002@ziepe.ca>
References: <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
 <20200424141548.5afdd2bb@w520.home>
 <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
 <20200428105455.30343fb4@w520.home>
 <20200428174957.GV26002@ziepe.ca>
 <20200428130752.75c153bd@w520.home>
 <20200428192251.GW26002@ziepe.ca>
 <20200428141223.5b1653db@w520.home>
 <20200429002903.GZ26002@ziepe.ca>
 <20200429135633.626a8411@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429135633.626a8411@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 01:56:33PM -0600, Alex Williamson wrote:
> On Tue, 28 Apr 2020 21:29:03 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Tue, Apr 28, 2020 at 02:12:23PM -0600, Alex Williamson wrote:
> > 
> > > > > Maybe I was just getting lucky before this commit.  For a
> > > > > VM_PFNMAP, vaddr_get_pfn() only needs pin_user_pages_remote() to return
> > > > > error and the vma information that we setup in vfio_pci_mmap().    
> > > > 
> > > > I've written on this before, vfio should not be passing pages to the
> > > > iommu that it cannot pin eg it should not touch VM_PFNMAP vma's in the
> > > > first place.
> > > > 
> > > > It is a use-after-free security issue the way it is..  
> > > 
> > > Where is the user after free?  Here I'm trying to map device mmio space
> > > through the iommu, which we need to enable p2p when the user owns
> > > multiple devices.  
> > 
> > Yes, I gathered what the intent was..
> > 
> > > The device is owned by the user, bound to vfio-pci, and can't be
> > > unbound while the user has it open.  The iommu mappings are torn
> > > down on release.  I guess I don't understand the problem.  
> > 
> > For PFNMAP VMAs the lifecycle rule is basically that the PFN inside
> > the VMA can only be used inside the mmap_sem that read it. Ie you
> > cannot take a PFN outside the mmap_sem and continue to use it.
> > 
> > This is because the owner of the VMA owns the lifetime of that PFN,
> > and under the write side of the mmap_sem it can zap the PFN, or close
> > the VMA. Afterwards the VMA owner knows that there are no active
> > reference to the PFN in the system and can reclaim the PFN
> > 
> > ie the PFNMAP has no per-page pin counter. All lifetime revolves around
> > the mmap_sem and the vma.
> > 
> > What vfio does is take the PFN out of the mmap_sem and program it into
> > the iommu.
> > 
> > So when the VMA owner decides the PFN has no references, it actually
> > doesn't: vfio continues to access it beyond its permitted lifetime.
> > 
> > HW like mlx5 and GPUs have BAR pages which have security
> > properties. Once the PFN is returned to the driver the security
> > context of the PFN can be reset and re-assigned to another
> > process. Using VFIO a hostile user space can retain access to the BAR
> > page and upon its reassignment access a security context they were not
> > permitted to access.
> > 
> > This is why GUP does not return PFNMAP pages and vfio should not carry
> > a reference outside the mmap_sem. It breaks all the lifetime rules.
> 
> Thanks for the explanation.  I'm inferring that there is no solution to
> this, 

Not a particularly good one unfortunately. I've been wanting to use
P2P_DMA pages to solve these kinds of things but they are kind of
expensive.

I have a copy of some draft patches trying to do this

> but why can't we use mmu notifiers to invalidate the iommu on zap or
> close?

Hum.. I think with the new mmu interval notifiers vfio might be able
to manage that without a huge amount of trouble. But the iommu
invalidation needs to be synchronous from a mmu notifier callback - is
that feasible?

But even so, we have all this stuff now for authorizing PCI P2P which
this design completely ignores as well. :(

> I know that at least QEMU won't consider these sorts of mapping
> fatal, so we could possibly change the default and make support for
> such mappings opt-in, but I don't know if I'd break DPDK, or
> potentially users within QEMU that make use of p2p between devices.

I'd heard this was mostly for GPU device assignment? I'd be surprised
if DPDK used this..

Jason
