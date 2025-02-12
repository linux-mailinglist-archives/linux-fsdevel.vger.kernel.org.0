Return-Path: <linux-fsdevel+bounces-41574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90005A3239B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 11:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E254A18867C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D902209F2A;
	Wed, 12 Feb 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bORUvimi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6E6208988
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356766; cv=none; b=u7zE2b7ZCL9xz/GKwaE2a82aLVglzqMjsBBnrEbULifv1+b4ZNvCb2a+eUxYSEacXO2h4zZlbeQkjQgCdThMMrCxkhyVPof6+TTDCsxCkHZKzu/OPA5aMCv/5iCAVIiQaw9i07z6Kw0sHPOOHZ1mbD6ftn/0k/mpJO01oNJpXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356766; c=relaxed/simple;
	bh=4tYaNq1YUzR7xbCfa6M7JF8G3YzrwrXnQ/T3Jqjroy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLMVcsdBPlNIcamUMxflRJE/kxniMn5Q41JTTcd+QYIcWz5ePq89V36a3QJuSVzbwGHw9yBHT6znq73/HR8uQFfOC0+6+lSjqEomt80ZJZPdyXFHwJAQQQrq6lSHRKx5gdZFXYt7XjHq/OBiksgDmhAeFS96cJHrA7Lt3HzqaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bORUvimi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739356763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yJerI8drpoZ0/TsOfXFWnQ0scPP+Ef3H3mLwdeVJ5tE=;
	b=bORUvimixrloILu/X+rBA1QsnqXWkWpGqadmAJnNaGxuqB7am+9M5fNXS/FdhvLeL2fPJF
	b1G5f9GPXaFEfeSoLFq+bVoM4fyAVMFHYj/E6toUAGaWvxLs9vTbXfNIeh5g5cma0ohk/s
	VdZ3skDa52dFiBGtVGdRLcQeyNtRJ6s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-0Pr_rQR7PEK7qYRV-3wIWA-1; Wed, 12 Feb 2025 05:39:21 -0500
X-MC-Unique: 0Pr_rQR7PEK7qYRV-3wIWA-1
X-Mimecast-MFC-AGG-ID: 0Pr_rQR7PEK7qYRV-3wIWA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43933b8d9b1so22500585e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 02:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739356760; x=1739961560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yJerI8drpoZ0/TsOfXFWnQ0scPP+Ef3H3mLwdeVJ5tE=;
        b=rGeOK2S4z2FSwRHDUX0LLlUlB34WgfEoxGVmE/yYdX+1wa0X8IxPIeg/9f2pdHHFND
         XRaKRCWRBK9kYqfVKOkUSlil6OVTrh0IKwSuxf4a9bHzvsX7niZlTVxMvYDmX/uPWeAw
         dLrIzcer3ky265JFbXEnenjBNfav4ddE+ZoMXSq9OUtKYfaMCgBAHe67ztVYX35qko49
         /jDjgYgPqLe3ErX0Z4dwComF2cYFoSQh0IT7bE8HzIoOmAa4v3DKa+yhced9KmXYKIDL
         gtZz1xnyQCZG00mqiUyEFy/PxGxLDXysbK2HKN86DWuSh6CmQeuoqQVMaTeFoQUrNqwI
         ZrVw==
X-Gm-Message-State: AOJu0YymqS2VruPjiC9fC+WG9Cx74io5zXC4pZtYdnXProGZQdnEI+ev
	MDL3+7XHq+n47KKkTCzirUwGB6voFzoVnNlgoErJIbg9YVbP8idadt+8KBPt3ZeNH5fBUqL9okQ
	Gk9Pt5UdOWpYPyQkzEZYzw0L6Skac1/SAoy6ogJUUN6w/e2rjsiHVG8RyPhjyFK8=
X-Gm-Gg: ASbGncuIi4XF008VXaT2IIHJLrTvA45iOX9a9zb9QRa11mkyyfwh5Z37GUg2AaSIRah
	1Zn9K484+q2cT8UtRwpHClSegZ5SyriRi1HsP4KNqXlg6XPDP/d5/Jy5agQ3mpfzYCMzUWEqnwn
	VjYHHCGvytUqjM2EF2qXe/OO69tlYJAiTJjAbc3Z7gSpQ9+adRAF0XTp8DYk9kWKjkDxfayCrLT
	L7cu4CYdclNLZ3+l9/9/KBj48ysTJ9NmN0Tc4hplhdXLH87f5Yue/rNg82Us2SohogTCe2fjK8i
	/lD+/16sfeGvpVdwDSKFYFxAn14DyQxbhpCnx908hERbO1BE0Rczf/BaSscor670CVcYO17YvS9
	uw03YzNoMWoKww16ID3YdltmkMZ5CYg==
X-Received: by 2002:a05:600c:1c24:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4395815fddcmr26874325e9.4.1739356760390;
        Wed, 12 Feb 2025 02:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF4MYfbFVvDo57SWW/XdoivU59ZYNcJEUnst6OF39h3SptnFfEVlsoezf+ni/KL7k+3Ov6vw==
X-Received: by 2002:a05:600c:1c24:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4395815fddcmr26873955e9.4.1739356759890;
        Wed, 12 Feb 2025 02:39:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a? (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de. [2003:cb:c70c:a600:1e3e:c75:d269:867a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7c7sm15829755e9.27.2025.02.12.02.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:39:18 -0800 (PST)
Message-ID: <824f7d52-3304-4028-b10a-e10566b3dfc0@redhat.com>
Date: Wed, 12 Feb 2025 11:39:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/3] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
To: Shivank Garg <shivankg@amd.com>, akpm@linux-foundation.org,
 willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, vbabka@suse.cz, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, Fuad Tabba <tabba@google.com>
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-4-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250210063227.41125-4-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.02.25 07:32, Shivank Garg wrote:
> Previously, guest-memfd allocations were following local NUMA node id
> in absence of process mempolicy, resulting in random memory allocation.
> Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
> in VMM.
> 
> Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
> operation. This allows VMM to map the memory and use mbind() to set the
> desired NUMA policy. The policy is then retrieved via
> mpol_shared_policy_lookup() and passed to filemap_grab_folio_mpol() to
> ensure that allocations follow the specified memory policy.
> 
> This enables VMM to control guest memory NUMA placement by calling mbind()
> on the mapped memory regions, providing fine-grained control over guest
> memory allocation across NUMA nodes.

Yes, I think that is the right direction, especially with upcoming 
in-place conversion of shared<->private in mind.

> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>   virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b2aa6bf24d3a..e1ea8cb292fa 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -2,6 +2,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/falloc.h>
>   #include <linux/kvm_host.h>
> +#include <linux/mempolicy.h>
>   #include <linux/pagemap.h>
>   #include <linux/anon_inodes.h>
>   
> @@ -11,8 +12,13 @@ struct kvm_gmem {
>   	struct kvm *kvm;
>   	struct xarray bindings;
>   	struct list_head entry;
> +	struct shared_policy policy;
>   };
>   
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
> +						   pgoff_t index,
> +						   pgoff_t *ilx);
> +
>   /**
>    * folio_file_pfn - like folio_file_page, but return a pfn.
>    * @folio: The folio which contains this index.
> @@ -96,10 +102,20 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>    * Ignore accessed, referenced, and dirty flags.  The memory is
>    * unevictable and there is no storage to write back to.
>    */
> -static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
> +static struct folio *kvm_gmem_get_folio(struct file *file, pgoff_t index)

I'd probably do that change in a separate prep-patch; would remove some 
of the unrelated noise in this patch.

>   {
>   	/* TODO: Support huge pages. */
> -	return filemap_grab_folio(inode->i_mapping, index);
> +	struct folio *folio = NULL;

No need to init folio.

> +	struct inode *inode = file_inode(file);
> +	struct kvm_gmem *gmem = file->private_data;

Prefer reverse christmas-tree (longest line first) as possible.

> +	struct mempolicy *policy;
> +	pgoff_t ilx;

Why do you return the ilx from kvm_gmem_get_pgoff_policy() if it is 
completely unused?

> +
> +	policy = kvm_gmem_get_pgoff_policy(gmem, index, &ilx);
> +	folio =  filemap_grab_folio_mpol(inode->i_mapping, index, policy);
> +	mpol_cond_put(policy);

The downside is that we always have to lookup the policy, even if we 
don't have to allocate anything because the pagecache already contains a 
folio.

Would there be a way to lookup if there is something already allcoated 
(fast-path) and fallback to the slow-path (lookup policy+call 
filemap_grab_folio_mpol) only if that failed?

Note that shmem.c does exactly that: shmem_alloc_folio() is only called 
after filemap_get_entry() told us that there is nothing.

> +
> +	return folio;
>   }
>   

[...]

> +#ifdef CONFIG_NUMA
> +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kvm_gmem *gmem = file->private_data;
> +
> +	return mpol_set_shared_policy(&gmem->policy, vma, new);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
> +		unsigned long addr, pgoff_t *pgoff)
> +{
> +	struct file *file = vma->vm_file;
> +	struct kvm_gmem *gmem = file->private_data;
> +
> +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	return mpol_shared_policy_lookup(&gmem->policy, *pgoff);
> +}
> +
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
> +						   pgoff_t index,
> +						   pgoff_t *ilx)
> +{
> +	struct mempolicy *mpol;
> +
> +	*ilx = NO_INTERLEAVE_INDEX;
> +	mpol = mpol_shared_policy_lookup(&gmem->policy, index);
> +	return mpol ? mpol : get_task_policy(current);
> +}
> +
> +static const struct vm_operations_struct kvm_gmem_vm_ops = {
> +	.get_policy	= kvm_gmem_get_policy,
> +	.set_policy	= kvm_gmem_set_policy,
> +};
> +
> +static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	file_accessed(file);
> +	vma->vm_ops = &kvm_gmem_vm_ops;
> +	return 0;
> +}
> +#else
> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem *gmem,
> +						   pgoff_t index,
> +						   pgoff_t *ilx)
> +{
> +	*ilx = 0;
> +	return NULL;
> +}
> +#endif /* CONFIG_NUMA */
>   
>   static struct file_operations kvm_gmem_fops = {
> +#ifdef CONFIG_NUMA
> +	.mmap		= kvm_gmem_mmap,
> +#endif

With Fuad's work, this will be unconditional, and you'd only set the 
kvm_gmem_vm_ops conditionally -- just like shmem.c. Maybe best to 
prepare for that already: allow unconditional mmap (Fuad will implement 
the faulting logic of shared pages, until then all accesses would SIGBUS 
I assume, did you try that?) and only mess with get_policy/set_policy.

-- 
Cheers,

David / dhildenb


