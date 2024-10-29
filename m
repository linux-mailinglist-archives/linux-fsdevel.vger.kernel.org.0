Return-Path: <linux-fsdevel+bounces-33169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC249B5677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34861C21564
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6085E20D4E4;
	Tue, 29 Oct 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mCQKQDO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5D20C49B;
	Tue, 29 Oct 2024 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243179; cv=none; b=rwaLWGgbnS0gmR56RGQ/vZfTkCG5F0saoX9Yh7rGTwrkBCSvmTb2CbX7c80X0SaQca8UMyCYBK0+MExePcoWEL3sB3kvGJ3io2vhNXRyq2kGCiXECfAttfVgDPwZk00pkfMqP6dNgVqw47Kelh2nV1qBg2UMi3+aWGnVXgFYkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243179; c=relaxed/simple;
	bh=9W+AHt/u5MeZwhEMrDWMOoEiPok8YXhk3IbKNloyLig=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUZIFpMuQe0wlk3cqwPSDcoK9cmmeA4Nj/CYmQ0cOIIf6YGsHykmfLmZaYRpj8GjBu94EVs5P1eZqJJjPNJcemSUd+Rcfj/uQGN1DoIet/b0M2NZATK4rROGhTPw1dCXNEFapxe9VcJiawtae+qB8IIIpjrfzxquP89ts2epwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mCQKQDO9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLjePI025437;
	Tue, 29 Oct 2024 23:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XvPjFHvm1+HBenMPEFmypiCz
	DsR7VO/a8uKBoMokM3U=; b=mCQKQDO9bf3KfjOJU9ltheoQ4pi0fn1YYss4JVAT
	q1v+p9+u9ONpdRk7Qgy5XsZ3UXOhgNR2wlEUyIZJiTATUwupgdqCX8w2AzPTkQHD
	o7My0k7jrEgNK/E8DCtuwASBBQvKrb0z5dzki/3JQPD86QZg/Jx7q7OyRcpYlhX4
	kL/qq7w+YWQzddaE2fHnJ3F7FG6kbEWr7MwYfkkeOIYh1k/UFHNc7Hezg+xvrhXG
	9BAKuIplcwNjNJp/KZs98qV/cW4m01e13kPJS0HhNvYCtdWhMLpAjvVvjd87NFVK
	tTp/G4ONtnEkJgL68a8jrsECbbgSoCHa4JrFK6nSf6Jnpw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8hwyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 23:05:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TN5tQ9001175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 23:05:55 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 29 Oct 2024 16:05:54 -0700
Date: Tue, 29 Oct 2024 16:05:54 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: James Gowans <jgowans@amazon.com>
CC: <linux-kernel@vger.kernel.org>, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Steve Sistare <steven.sistare@oracle.com>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Anthony
 Yznaga <anthony.yznaga@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, <linux-fsdevel@vger.kernel.org>,
        Usama Arif
	<usama.arif@bytedance.com>, <kvm@vger.kernel.org>,
        Alexander Graf
	<graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Paul Durrant
	<pdurrant@amazon.co.uk>,
        Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Message-ID: <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-6-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240805093245.889357-6-jgowans@amazon.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YHT3SO5zWSaOsoLiIh9WLH0BmLD6E99w
X-Proofpoint-ORIG-GUID: YHT3SO5zWSaOsoLiIh9WLH0BmLD6E99w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290175

On Mon, Aug 05, 2024 at 11:32:40AM +0200, James Gowans wrote:
> Make the file data usable to userspace by adding mmap. That's all that
> QEMU needs for guest RAM, so that's all be bother implementing for now.
> 
> When mmaping the file the VMA is marked as PFNMAP to indicate that there
> are no struct pages for the memory in this VMA. Remap_pfn_range() is
> used to actually populate the page tables. All PTEs are pre-faulted into
> the pgtables at mmap time so that the pgtables are usable when this
> virtual address range is given to VFIO's MAP_DMA.

Thanks for sending this out! I'm going through the series with the
intention to see how it might fit within the existing guest_memfd work
for pKVM/CoCo/Gunyah.

It might've been mentioned in the MM alignment session -- you might be
interested to join the guest_memfd bi-weekly call to see how we are
overlapping [1].

[1]: https://lore.kernel.org/kvm/ae794891-fe69-411a-b82e-6963b594a62a@redhat.com/T/

---

Was the decision to pre-fault everything because it was convenient to do
or otherwise intentionally different from hugetlb?

> 
> Signed-off-by: James Gowans <jgowans@amazon.com>
> ---
>  fs/guestmemfs/file.c       | 43 +++++++++++++++++++++++++++++++++++++-
>  fs/guestmemfs/guestmemfs.c |  2 +-
>  fs/guestmemfs/guestmemfs.h |  3 +++
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/guestmemfs/file.c b/fs/guestmemfs/file.c
> index 618c93b12196..b1a52abcde65 100644
> --- a/fs/guestmemfs/file.c
> +++ b/fs/guestmemfs/file.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include "guestmemfs.h"
> +#include <linux/mm.h>
>  
>  static int truncate(struct inode *inode, loff_t newsize)
>  {
> @@ -41,6 +42,46 @@ static int inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry, struct
>  	return 0;
>  }
>  
> +/*
> + * To be able to use PFNMAP VMAs for VFIO DMA mapping we need the page tables
> + * populated with mappings. Pre-fault everything.
> + */
> +static int mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	int rc;
> +	unsigned long *mappings_block;
> +	struct guestmemfs_inode *guestmemfs_inode;
> +
> +	guestmemfs_inode = guestmemfs_get_persisted_inode(filp->f_inode->i_sb,
> +			filp->f_inode->i_ino);
> +
> +	mappings_block = guestmemfs_inode->mappings;
> +
> +	/* Remap-pfn-range will mark the range VM_IO */
> +	for (unsigned long vma_addr_offset = vma->vm_start;
> +			vma_addr_offset < vma->vm_end;
> +			vma_addr_offset += PMD_SIZE) {
> +		int block, mapped_block;
> +		unsigned long map_size = min(PMD_SIZE, vma->vm_end - vma_addr_offset);
> +
> +		block = (vma_addr_offset - vma->vm_start) / PMD_SIZE;
> +		mapped_block = *(mappings_block + block);
> +		/*
> +		 * It's wrong to use rempa_pfn_range; this will install PTE-level entries.
> +		 * The whole point of 2 MiB allocs is to improve TLB perf!
> +		 * We should use something like mm/huge_memory.c#insert_pfn_pmd
> +		 * but that is currently static.
> +		 * TODO: figure out the best way to install PMDs.
> +		 */
> +		rc = remap_pfn_range(vma,
> +				vma_addr_offset,
> +				(guestmemfs_base >> PAGE_SHIFT) + (mapped_block * 512),
> +				map_size,
> +				vma->vm_page_prot);
> +	}
> +	return 0;
> +}
> +
>  const struct inode_operations guestmemfs_file_inode_operations = {
>  	.setattr = inode_setattr,
>  	.getattr = simple_getattr,
> @@ -48,5 +89,5 @@ const struct inode_operations guestmemfs_file_inode_operations = {
>  
>  const struct file_operations guestmemfs_file_fops = {
>  	.owner = THIS_MODULE,
> -	.iterate_shared = NULL,
> +	.mmap = mmap,
>  };
> diff --git a/fs/guestmemfs/guestmemfs.c b/fs/guestmemfs/guestmemfs.c
> index c45c796c497a..38f20ad25286 100644
> --- a/fs/guestmemfs/guestmemfs.c
> +++ b/fs/guestmemfs/guestmemfs.c
> @@ -9,7 +9,7 @@
>  #include <linux/memblock.h>
>  #include <linux/statfs.h>
>  
> -static phys_addr_t guestmemfs_base, guestmemfs_size;
> +phys_addr_t guestmemfs_base, guestmemfs_size;
>  struct guestmemfs_sb *psb;
>  
>  static int statfs(struct dentry *root, struct kstatfs *buf)
> diff --git a/fs/guestmemfs/guestmemfs.h b/fs/guestmemfs/guestmemfs.h
> index 7ea03ac8ecca..0f2788ce740e 100644
> --- a/fs/guestmemfs/guestmemfs.h
> +++ b/fs/guestmemfs/guestmemfs.h
> @@ -8,6 +8,9 @@
>  #define GUESTMEMFS_FILENAME_LEN 255
>  #define GUESTMEMFS_PSB(sb) ((struct guestmemfs_sb *)sb->s_fs_info)
>  
> +/* Units of bytes */
> +extern phys_addr_t guestmemfs_base, guestmemfs_size;
> +
>  struct guestmemfs_sb {
>  	/* Inode number */
>  	unsigned long next_free_ino;
> -- 
> 2.34.1
> 
> 

