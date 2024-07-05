Return-Path: <linux-fsdevel+bounces-23208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E37928AA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5768B228D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43516B389;
	Fri,  5 Jul 2024 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GomyGT6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25D1581E3
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189463; cv=none; b=eNa9KVMJtVT1rNVwZygABx1IXOUEyCqxXUlrJVAaTSEWOXIqguOnuqajkQ6JiF9Wy73gAnAVWTDnxOnTYvkNftZ7OMGCacyB+YVK3EcsnEhVM6uj3VjeQ9aVd0lnO9mHFsjZGLd6aqHMKHtyIAWbxHO0Hz+QIvLquKdaJ1XvbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189463; c=relaxed/simple;
	bh=ezE9cMK85xGULq2NDfyultVM78ZkLbyifJxcFeIVVd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3F+3VH9qcVanS+kFO9YCpDmCKXmGa4O9LWVf+NMurIrX6pWCUL4AHUbvX+vGs0O9CgekBnkKatm6JQ8rn5uyiG04fZ7bE1QM/rQiiufe9aIF6K0Bk3xQWtuhI61gx5H4Yv3RWAhrMAbtqvP2iPONstcG94h88Oqj4AAsG4fgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GomyGT6q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720189460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IqBTg61cVL77faXIzfdAxULAIPGMk1ZHXjVPHmfrZtE=;
	b=GomyGT6q4Dkoew0pCRUYAoml9aFCdZYOXIEQEjz64CtThBXoFF7Mra3soyxFZs7BYZGnr4
	vzGyfb+mUwBbgyhfR+bveNOh3TOMIFBnkRrYodstWMD/mhDtfkrnQteBVO2+kFcUWqNqxi
	S8ghGxK+13S2T1g7QDuve6Z+12fHe3M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CzpId4q_PS6iU4Urq0kzCg-1; Fri, 05 Jul 2024 10:24:19 -0400
X-MC-Unique: CzpId4q_PS6iU4Urq0kzCg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44671e02749so3653361cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2024 07:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189459; x=1720794259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqBTg61cVL77faXIzfdAxULAIPGMk1ZHXjVPHmfrZtE=;
        b=Qfx+mvjs8pjdKsu9f9Y/qqmbPnY7V2ohvQIYCYQ0duIqiW31YrHGJhptbsastaKK1s
         xFpBhQFJ7orXqrONbqqcDXEn/bwYamid0l/2TvKZhd6EUxTAVJ03u8bTc8AujC972ION
         8F7R/L/5YP70qrFIoEsWNBZbNPLnYQKB4GoV01ED2CcXTrlOCr2TohfWEI9N8ADRozaj
         uOt5kS0f/x4OnO74OuifWjGIvocTZ+kKAsqYj7GjhNojp8Z3FSItjYNuYb7aclQkDvId
         br3lMAID/jGsUs1jH1Q993w9qrBVdq+Bpquo9l+Atwhs7BBfSpopUbdVOqdJPWYQkIip
         Tz4g==
X-Forwarded-Encrypted: i=1; AJvYcCWfb7e4toqgls4z2Ta29pYZrS/Z+4JbPgyZAD0xvb2ZnkMbzKwkfasDcy1gR6k+4RQti9ne6uqwA6Gms2WZjzk1VIiz5fdl/+yLuF0XBQ==
X-Gm-Message-State: AOJu0Yx0sN/lFMP1DnlcqCFR2YKISpyrskId7jQXswobuCQWo33kjRHH
	kjOyUCuQ+xwAGoqeksC0mNd1XgUKKwchh6mdi2iLFD8bSVMzchbzhU7Q4NyfqLSy/YHk/FjaNu4
	AYk+xhHMAxbhS6jDxVy3OQlLZBKFjHlwH1v8aFfoJkMCN2E1kvAtUV7RMqbBlTLw=
X-Received: by 2002:ac8:7c4b:0:b0:446:395a:37c9 with SMTP id d75a77b69052e-447cc1cd760mr50256751cf.4.1720189458362;
        Fri, 05 Jul 2024 07:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKP4/uPX8iCeoUcNLMV3z8vBAByHvLymsXhgYIxVOYKgo8tVByPTMSYbiLBJ2KPlAF3hMSkQ==
X-Received: by 2002:ac8:7c4b:0:b0:446:395a:37c9 with SMTP id d75a77b69052e-447cc1cd760mr50256521cf.4.1720189457935;
        Fri, 05 Jul 2024 07:24:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149b579sm69523231cf.75.2024.07.05.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:24:17 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:24:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 11/13] huge_memory: Remove dead vmf_insert_pXd code
Message-ID: <ZogCDpfSyCcjVXWH@x1n>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>

Hi, Alistair,

On Thu, Jun 27, 2024 at 10:54:26AM +1000, Alistair Popple wrote:
> Now that DAX is managing page reference counts the same as normal
> pages there are no callers for vmf_insert_pXd functions so remove
> them.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/huge_mm.h |   2 +-
>  mm/huge_memory.c        | 165 +-----------------------------------------
>  2 files changed, 167 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 9207d8e..0fb6bff 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
>  		    unsigned long cp_flags);
>  
> -vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> -vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);

There's a plan to support huge pfnmaps in VFIO, which may still make good
use of these functions.  I think it's fine to remove them but it may mean
we'll need to add them back when supporting pfnmaps with no memmap.

Is it still possible to make the old API generic to both service the new
dax refcount plan, but at the meantime working for pfn injections when
there's no page struct?

Thanks,

-- 
Peter Xu


