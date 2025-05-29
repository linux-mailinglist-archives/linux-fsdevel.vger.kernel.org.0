Return-Path: <linux-fsdevel+bounces-50066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E8AC7D74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81CFA25ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E5223320;
	Thu, 29 May 2025 11:54:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6114202F6D;
	Thu, 29 May 2025 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519683; cv=none; b=rUIaatzUcip/EHWBKIhnqe6NBhlIQU1OoCBrqx3IT0X3+Bl687plvGIaHGWxtZSI/kjapkXiscN3cvRGp9JgoEqPJN3cM2de+64fcj5mmIItEzHdBl50EpsmwsgYj8V+1Iq3nXoxTX6GRK4P3LfbcdNN5xyJle5nBSSvRtYS4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519683; c=relaxed/simple;
	bh=fg0AZBr3tvoG8AZR9xvvZvCVeikm6KgUTNO5GMK5whs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAy47RZtNxTpi+EXuUFD+gD3j0hqP/l0i5jYlczeFmj+vLJgd+L9steRaN/Mb8Vi3P5SabOI2pNh06/7fetI4X/t3jwZTemxAFfPLYxg2+3kMPcu96Vhvb9rv3iicdu67g2Oc4hkK8jZ+qCxD1bSalWSKVQ0Wufdj2zOInQWTL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7PpG0pPHz6L5j3;
	Thu, 29 May 2025 19:51:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A1AA5140519;
	Thu, 29 May 2025 19:54:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 May
 2025 13:54:37 +0200
Date: Thu, 29 May 2025 12:54:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alistair Popple <apopple@nvidia.com>
CC: <linux-mm@kvack.org>, <gerald.schaefer@linux.ibm.com>,
	<dan.j.williams@intel.com>, <jgg@ziepe.ca>, <willy@infradead.org>,
	<david@redhat.com>, <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <jhubbard@nvidia.com>, <hch@lst.de>,
	<zhang.lyra@gmail.com>, <debug@rivosinc.com>, <bjorn@kernel.org>,
	<balbirs@nvidia.com>, <lorenzo.stoakes@oracle.com>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-cxl@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<John@Groves.net>
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
Message-ID: <20250529125435.00001378@huawei.com>
In-Reply-To: <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
	<2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 29 May 2025 16:32:08 +1000
Alistair Popple <apopple@nvidia.com> wrote:

> DAX was the only thing that created pmd_devmap and pud_devmap entries
> however it no longer does as DAX pages are now refcounted normally and
> pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
> and pXd_trans_huge() is redundant and the former can be removed without
> changing behaviour as it will always be false.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8d9d706..31b4110 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1398,10 +1398,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  
>  	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
> -	if (pfn_t_devmap(pfn))

Didn't this go away in patch 5?  I didn't check but this looks like a bisectability issue.

> -		entry = pmd_mkdevmap(entry);
> -	else
> -		entry = pmd_mkspecial(entry);
> +	entry = pmd_mkspecial(entry);
>  	if (write) {
>  		entry = pmd_mkyoung(pmd_mkdirty(entry));
>  		entry = maybe_pmd_mkwrite(entry, vma);

