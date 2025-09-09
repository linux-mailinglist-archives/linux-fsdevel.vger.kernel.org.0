Return-Path: <linux-fsdevel+bounces-60608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1918B49FE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 05:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF03A441D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 03:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141C26F2B6;
	Tue,  9 Sep 2025 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="neOoo9fi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79A22A7E4;
	Tue,  9 Sep 2025 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387968; cv=none; b=T4enqM5JHCIBBHIcqrYYHTG4NbFzcGuN2Cn8IzeySWAR6LQM3Xv9az48CTfWGA93Tlu1+r+NCeuS7JAvm6zrNhc745W57llO07bJIwJHrP4CNhymFmuFGO0DOU32INwCkJSXGQPWjn8p9ShJEnxaGVdJAfV4KPcQCo51ykemrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387968; c=relaxed/simple;
	bh=dXeL8bHgEJS0WBDFa6oVj6Cg2JQha9x3GSBxLbSsSp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSqDZVHg4Zx472kGkR+tYRLJspdYZuRjjKjo6CxSmyaDauKcLpk7IU078AXpPziEr7EWy9DGZplR//cep5S7lqI2cr4dBRnw8MpWzKg0pJBrVu7WsqkAOucrKY2bdqXpOyRmWVpJWLeyU8XyWY05PAAL632+OfBrNqLClQ6Ul/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=neOoo9fi; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757387962; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kp/49YwOqYc4XSnECrXc1wc8q5JFsR73JTB4gmB0H9s=;
	b=neOoo9fiPql50Cf0f0s9a8YQh/khunQ8lY2XlD2dktzPloXUrCLWlf5pOFiqwzzBEvFMWEDG6pRsUWq+HEJaTDjpsGDTssXG99pVuT3y//1TUxM4no2j1JxrY3O7Kthd2X6o5Puo15wFv2fMWFwlMaZGQusUltdTTsm3Kd6qkX8=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wnc5f31_1757387957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 11:19:18 +0800
Message-ID: <2a08292a-fdad-49f1-8ad9-550bf3129b2f@linux.alibaba.com>
Date: Tue, 9 Sep 2025 11:19:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] mm/shmem: update shmem to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <2f84230f9087db1c62860c1a03a90416b8d7742e.1757329751.git.lorenzo.stoakes@oracle.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2f84230f9087db1c62860c1a03a90416b8d7742e.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/8 19:10, Lorenzo Stoakes wrote:
> This simply assigns the vm_ops so is easily updated - do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/shmem.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 29e1eb690125..cfc33b99a23a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2950,16 +2950,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
>   	return retval;
>   }
>   
> -static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> +static int shmem_mmap_prepare(struct vm_area_desc *desc)
>   {
> +	struct file *file = desc->file;
>   	struct inode *inode = file_inode(file);
>   
>   	file_accessed(file);
>   	/* This is anonymous shared memory if it is unlinked at the time of mmap */
>   	if (inode->i_nlink)
> -		vma->vm_ops = &shmem_vm_ops;
> +		desc->vm_ops = &shmem_vm_ops;
>   	else
> -		vma->vm_ops = &shmem_anon_vm_ops;
> +		desc->vm_ops = &shmem_anon_vm_ops;
>   	return 0;
>   }
>   
> @@ -5229,7 +5230,7 @@ static const struct address_space_operations shmem_aops = {
>   };
>   
>   static const struct file_operations shmem_file_operations = {
> -	.mmap		= shmem_mmap,
> +	.mmap_prepare	= shmem_mmap_prepare,
>   	.open		= shmem_file_open,
>   	.get_unmapped_area = shmem_get_unmapped_area,
>   #ifdef CONFIG_TMPFS


