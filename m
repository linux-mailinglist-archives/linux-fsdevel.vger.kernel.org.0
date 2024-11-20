Return-Path: <linux-fsdevel+bounces-35295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480F9D374E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BCB1F22E47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022D19CC06;
	Wed, 20 Nov 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPc65wOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDD19D093
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095916; cv=none; b=cZ78CkLZhC/Tl8A8HV4YdHMnJWSuWj7Vbhex1fCljUQaF13h/xhw63qv33QoM6sybFYqhvQZ3dntxG7NclQrwMjUuquc0E5zGeRbO2buqmbDEN4L+zIBERDz/XhTR91LTJ0rdLahJPQqE9NmyszjCvDaQlV6nd7YQQH/GTnozig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095916; c=relaxed/simple;
	bh=ifnyv1d3sztNi3k4bwM+5btJy7wZJFA0rEOKEXcKV1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me337Qh4Yc1zv5Ksj/czeFSFCJn5Iav2nclHLOOPDcypESUH9X9+HYCNaBxH6g6L0FbqvOc2lFddRFsX5xU8Uxgmm81lBUI3f0P9pNAFPu/h5nVbnJ+b6/qOybdQXl3CwdU+ZEHaNIJa05wqQ/s1eHyOC1VHDKiUCxXlZ/qkQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPc65wOT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732095913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/vmlr1THzcj/O2Lltl3HGhrofUeBCh2vBg0AXGmDaA=;
	b=FPc65wOTPnMfpRC+ceJ8MuBKQigRo3eZB9Q5r1qfDLj1XZAYPKvJLjGHoqmUb3p8Gooau4
	R3vRTsVUeiv9vZF83bKgVff7uoOfZGNrgpqpAMJiRVH7qqbYQGUP3uQ3nOuQKsxYbufmxg
	oCvtc7oFA4XJ62sbXCIa2+Vf+V1lRhE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-OEXwKvnHMPmrea1pxaUrkA-1; Wed,
 20 Nov 2024 04:45:10 -0500
X-MC-Unique: OEXwKvnHMPmrea1pxaUrkA-1
X-Mimecast-MFC-AGG-ID: OEXwKvnHMPmrea1pxaUrkA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 749C31955F43;
	Wed, 20 Nov 2024 09:45:08 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700CA195607C;
	Wed, 20 Nov 2024 09:45:06 +0000 (UTC)
Date: Wed, 20 Nov 2024 17:45:02 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 05/11] fs/proc/vmcore: factor out allocating a vmcore
 memory node
Message-ID: <Zz2vnl1HQOC6vF20@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-6-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-6-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> Let's factor it out into include/linux/crash_dump.h, from where we can
> use it also outside of vmcore.c later.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c           | 21 ++-------------------
>  include/linux/crash_dump.h | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 47652df95202..76fdc3fb8c0e 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -683,11 +683,6 @@ static const struct proc_ops vmcore_proc_ops = {
>  	.proc_mmap	= mmap_vmcore,
>  };
>  
> -static struct vmcore_mem_node * __init get_new_element(void)
> -{
> -	return kzalloc(sizeof(struct vmcore_mem_node), GFP_KERNEL);
> -}
> -
>  static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
>  			   struct list_head *vc_list)
>  {
> @@ -1090,7 +1085,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
>  						size_t elfnotes_sz,
>  						struct list_head *vc_list)
>  {
> -	struct vmcore_mem_node *new;
>  	int i;
>  	Elf64_Ehdr *ehdr_ptr;
>  	Elf64_Phdr *phdr_ptr;
> @@ -1113,13 +1107,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
>  		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
>  		size = end - start;
>  
> -		/* Add this contiguous chunk of memory to vmcore list.*/
> -		new = get_new_element();
> -		if (!new)
> +		if (vmcore_alloc_add_mem_node(vc_list, start, size))
>  			return -ENOMEM;
> -		new->paddr = start;
> -		new->size = size;
> -		list_add_tail(&new->list, vc_list);
>  
>  		/* Update the program header offset. */
>  		phdr_ptr->p_offset = vmcore_off + (paddr - start);
> @@ -1133,7 +1122,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
>  						size_t elfnotes_sz,
>  						struct list_head *vc_list)
>  {
> -	struct vmcore_mem_node *new;
>  	int i;
>  	Elf32_Ehdr *ehdr_ptr;
>  	Elf32_Phdr *phdr_ptr;
> @@ -1156,13 +1144,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
>  		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
>  		size = end - start;
>  
> -		/* Add this contiguous chunk of memory to vmcore list.*/
> -		new = get_new_element();
> -		if (!new)
> +		if (vmcore_alloc_add_mem_node(vc_list, start, size))
>  			return -ENOMEM;
> -		new->paddr = start;
> -		new->size = size;
> -		list_add_tail(&new->list, vc_list);
>  
>  		/* Update the program header offset */
>  		phdr_ptr->p_offset = vmcore_off + (paddr - start);
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 5e48ab12c12b..ae77049fc023 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -121,6 +121,20 @@ struct vmcore_mem_node {
>  	loff_t offset;
>  };
>  
> +/* Allocate a vmcore memory node and add it to the list. */
> +static inline int vmcore_alloc_add_mem_node(struct list_head *list,
> +		unsigned long long paddr, unsigned long long size)
> +{
> +	struct vmcore_mem_node *m = kzalloc(sizeof(*m), GFP_KERNEL);
> +
> +	if (!m)
> +		return -ENOMEM;
> +	m->paddr = paddr;
> +	m->size = size;
> +	list_add_tail(&m->list, list);
> +	return 0;
> +}
> +
>  #else /* !CONFIG_CRASH_DUMP */
>  static inline bool is_kdump_kernel(void) { return false; }
>  #endif /* CONFIG_CRASH_DUMP */
> -- 
> 2.46.1
> 


