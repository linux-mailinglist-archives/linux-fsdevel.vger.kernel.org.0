Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76002FB0FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 14:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKMNCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 08:02:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38070 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfKMNCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:02:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id p20so2453503qtq.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMayMeIif+74vqoR9Hg244XFAjXhPl1nedXCyPx66Cc=;
        b=nx3682LY4M40wGJ/sVGEu1B6oRowx3yCQZUXaDyQPZ8wp2PPM1JbbnvXpnwJ+1w7kN
         lveYAqZtu6ZiCNE2GeOgCzqCbaPveYJh+bEnyDI89VRNGCHDXS9A7L5ZDDa96GF+3bm0
         VmapuAT4FqF5vTUEuSGlcRA+NIY79GOrBmWnh2u551hGbiYfLURBD9nS87LvoXBLbrK0
         o1TB/3BSIGkHlZVczCO3ubOoj5u0dVQwEYLzu7svoxCzx/+RmvcCH+ACjaNBf3sl94Zf
         NRZR8twQGuvzHtghZ4nzQu/TUj0hyyqfJ3dXa+O6cdFNGC6w6BZNjOabe9aQdvwtecNu
         AUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMayMeIif+74vqoR9Hg244XFAjXhPl1nedXCyPx66Cc=;
        b=TML3TuKSl2Nl6jTwW4PYSFf4mKo3+EpqR4Ykwb5o/HHjZOoSYWupkGced2caNyaL7v
         Pj/7lW+MwjpORbYyxHbkk9BV/gLPfGW96nfgeklAnFiZ0+yg1GUUXpyfbLHxufDs+hRN
         TeOnK0ZqnsyWsLtX2ufKjvIj9/cxds4IBFzsQvq0dhFWnlZVtDFRdRk/hj9LoNKsqveM
         LPGTsYhR6N0Z5DX1n8rJbzimye57aMZy16ciRhqdnuoKe4xu6duI3rLeSNV/dZwJ1heh
         WHNfwqWfKDJq0kMnPHvFHiECsKXOXG4NjLv2N/DIsqycBeAAFOVgG1o4VXYz6aXH62px
         o5zw==
X-Gm-Message-State: APjAAAWj/JY2sqjCnLxntHW9+V0Xn1+2oMIYRZdIO/M0EJHAGCnNCUl2
        sDAR1GTt6ZD4Ba3NWkDJZetWMg==
X-Google-Smtp-Source: APXvYqwGbusmGQAfGHn3CXk2dU2JO4knhTY4prDGLzmyu8apMpc1WOd3WOgt9K6JkDyAWe/3c1LxDA==
X-Received: by 2002:ac8:724f:: with SMTP id l15mr2476006qtp.234.1573650124104;
        Wed, 13 Nov 2019 05:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 187sm918223qkk.103.2019.11.13.05.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 05:02:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUsHa-000767-Jc; Wed, 13 Nov 2019 09:02:02 -0400
Date:   Wed, 13 Nov 2019 09:02:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/23] vfio, mm: fix get_user_pages_remote() and
 FOLL_LONGTERM
Message-ID: <20191113130202.GA26068@ziepe.ca>
References: <20191113042710.3997854-1-jhubbard@nvidia.com>
 <20191113042710.3997854-9-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113042710.3997854-9-jhubbard@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:26:55PM -0800, John Hubbard wrote:
> As it says in the updated comment in gup.c: current FOLL_LONGTERM
> behavior is incompatible with FAULT_FLAG_ALLOW_RETRY because of the
> FS DAX check requirement on vmas.
> 
> However, the corresponding restriction in get_user_pages_remote() was
> slightly stricter than is actually required: it forbade all
> FOLL_LONGTERM callers, but we can actually allow FOLL_LONGTERM callers
> that do not set the "locked" arg.
> 
> Update the code and comments accordingly, and update the VFIO caller
> to take advantage of this, fixing a bug as a result: the VFIO caller
> is logically a FOLL_LONGTERM user.
> 
> Also, remove an unnessary pair of calls that were releasing and
> reacquiring the mmap_sem. There is no need to avoid holding mmap_sem
> just in order to call page_to_pfn().
> 
> Also, move the DAX check ("if a VMA is DAX, don't allow long term
> pinning") from the VFIO call site, all the way into the internals
> of get_user_pages_remote() and __gup_longterm_locked(). That is:
> get_user_pages_remote() calls __gup_longterm_locked(), which in turn
> calls check_dax_vmas(). It's lightly explained in the comments as well.
> 
> Thanks to Jason Gunthorpe for pointing out a clean way to fix this,
> and to Dan Williams for helping clarify the DAX refactoring.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>  drivers/vfio/vfio_iommu_type1.c | 25 ++-----------------------
>  mm/gup.c                        | 27 ++++++++++++++++++++++-----
>  2 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index d864277ea16f..7301b710c9a4 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -340,7 +340,6 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  {
>  	struct page *page[1];
>  	struct vm_area_struct *vma;
> -	struct vm_area_struct *vmas[1];
>  	unsigned int flags = 0;
>  	int ret;
>  
> @@ -348,33 +347,13 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  		flags |= FOLL_WRITE;
>  
>  	down_read(&mm->mmap_sem);
> -	if (mm == current->mm) {
> -		ret = get_user_pages(vaddr, 1, flags | FOLL_LONGTERM, page,
> -				     vmas);
> -	} else {
> -		ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
> -					    vmas, NULL);
> -		/*
> -		 * The lifetime of a vaddr_get_pfn() page pin is
> -		 * userspace-controlled. In the fs-dax case this could
> -		 * lead to indefinite stalls in filesystem operations.
> -		 * Disallow attempts to pin fs-dax pages via this
> -		 * interface.
> -		 */
> -		if (ret > 0 && vma_is_fsdax(vmas[0])) {
> -			ret = -EOPNOTSUPP;
> -			put_page(page[0]);
> -		}
> -	}
> -	up_read(&mm->mmap_sem);
> -
> +	ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags | FOLL_LONGTERM,
> +				    page, NULL, NULL);
>  	if (ret == 1) {
>  		*pfn = page_to_pfn(page[0]);
>  		return 0;

Mind the return with the lock held this needs some goto unwind

Jason
