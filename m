Return-Path: <linux-fsdevel+bounces-48551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0AAAB0FC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737475056E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642A28E5F6;
	Fri,  9 May 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um/0y8ch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922727465C
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784848; cv=none; b=s05bGzNdROPAjPoheYJ1XTOFd1QFjEMyoFTIs5h8EZJjvddb0apNCb3sPmh5HTPtTdX2+l9bVUiBgNPSFrN/qU4Xrlsvak63eMhZHcCuEbIDXn0hkJHbfnMFWWoQTiJUL+9YTPVGup/np3sgSaO0oUhgQdcE2uX6N2dtxX3fvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784848; c=relaxed/simple;
	bh=YIHLASraxeQeN4cvEtLjoGsf4tO1xddfe0FGGD2jVuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuozrJfpMWqbGxEIrBz2ZqOOoK7thLPLpE6gURJrDJ2U7mhcAqcNlFRAJw/1JK2m+4a6n25xu6cN9mvPxKJJyM8ftSM9Kda0BsAJ9B8+kFY3UzL822D4yPmmOHbdGerIX72HKPsygdohXjVa/wdtHXcbwP3PnAkCmS3UbDLKwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Um/0y8ch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746784845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YdI0c2Ef+H+t2CoZ3Ly3e5qaqDe8ORgkm4gpmqjbuzo=;
	b=Um/0y8chKp+7fCOw7cmis2Wh53CJXJ0k4f12bJzCVE81AmEmw+GOGwhkbaHF2+qPkSzWEM
	wKTjY+/MnqrvLt3V63e3697fdKKNANMxmxwxLEPIw2m7HLzM34t8QNOZvFHANdifWyF8Mi
	B+HIPdQqLjxAykOW9zh+zSAQ+WtUHj8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-f9ncdUnHObyDJuMnbqWeIQ-1; Fri, 09 May 2025 06:00:43 -0400
X-MC-Unique: f9ncdUnHObyDJuMnbqWeIQ-1
X-Mimecast-MFC-AGG-ID: f9ncdUnHObyDJuMnbqWeIQ_1746784842
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a0b662be0cso1092821f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 03:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746784841; x=1747389641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdI0c2Ef+H+t2CoZ3Ly3e5qaqDe8ORgkm4gpmqjbuzo=;
        b=HXnK3BBan8gCLkLCgcQi4PmmMldRNww+htY2/MVGX8Qpixf41VMb7enWOmecL4pBmh
         oI8noi4ulGHZCCdhJGQNTwBZYAI6t4R12Plct9Ffh3EQrNTQa80cNtBa6yGdMKynvc5W
         5XoydR6nyD1BTTwS2rzKQDTVm37zHV2E9ZoLkkoq3YbZqTpk4NApH6j11vPzrOkhrqqp
         Rqueam1WZzyBWeHhM1dZ0jH5cwGudVWMp/AytNJW8pbYZHEgBz6/bf3z/5HWpeaEOYL8
         DA0ybmKOQE0yJqoTfmsZ8R47Bjfuh8mH58vM3Cgr80eHqfi3VNDpKwzAuDASfp8YK3yX
         jOmA==
X-Forwarded-Encrypted: i=1; AJvYcCU+sbjhYPVA3z/8ONTnrrFV3iJTFVwxjdm/IYEdJrn5tDF1tbYRKF4YPXgpKIuP2PrfS0sDFONvy8hN/Mi+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj/6DxU1iH+HQElYZDiNt0nOHqCSCeqZ+utRX4pDj1TR+rt/zP
	+Dt1AqnDviNaI7tQ3Y2Jnq+l0lh3N/U4tM33Ra2HEtySXmNQ4bIvceoKLLr0MH3xCAM9lh2Ld2F
	9drOafEpEbXzOlw1kdqK4F+PSjgvRFP0ygYiO0OPjbnpsz5m8RVaZUVAp57b8E9o=
X-Gm-Gg: ASbGncuiX+LgEl2h2uG7h45l0OHGpoJeuI07MXJxPoTkpg4LvN15C7cUePoXU20U4o4
	Uf2sG8CIue8hoPwHZfnQYzge6cCyDoZpXDHCPpWKHetuTPhIQpeW9BQeQHfz2PrgQjFgaTvcH6M
	zOfsB0cACPjHTHthRaW9tPAT8hCnQLVFPszn0EdviRBvobP0PzAzu+QgL4SqGObJPxXImBRVH8f
	+ZE5y9DyE/clk6Mb4sQzOpzyEKIAITHg97egwrS/iIopnob6iY+mGw2ng+a68rwBhy47qhvjys7
	vb7lYEsUReV6JDG5CndLFob3reG/wEpdSeSpH/JWn2c/SgEQ8WbyurywXmpnaca2CGhd5mhn7GK
	YW/TXqkHCjbhLO0duGgdVvW0AtqYWxRalpLY0YxE=
X-Received: by 2002:a5d:59ae:0:b0:3a0:b4a7:6e56 with SMTP id ffacd0b85a97d-3a1f64ae7e4mr2062887f8f.56.1746784841405;
        Fri, 09 May 2025 03:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYtk7kpi0fEgjDBJYe3FZ+XRuJX0yVPoXvgyZF1DXmFH2J8LWLBlwtUV3NaxFWynOOHr+6zA==
X-Received: by 2002:a5d:59ae:0:b0:3a0:b4a7:6e56 with SMTP id ffacd0b85a97d-3a1f64ae7e4mr2062808f8f.56.1746784840558;
        Fri, 09 May 2025 03:00:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f45:5500:8267:647f:4209:dedd? (p200300d82f4555008267647f4209dedd.dip0.t-ipconnect.de. [2003:d8:2f45:5500:8267:647f:4209:dedd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3af15bsm66971035e9.30.2025.05.09.03.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 03:00:40 -0700 (PDT)
Message-ID: <2204037e-f0bd-4059-b32a-d0970d96cea3@redhat.com>
Date: Fri, 9 May 2025 12:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: introduce new .mmap_prepare() file callback
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <c958ac6932eb8dd9ddbd2363bc2d242ff244341b.1746615512.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c958ac6932eb8dd9ddbd2363bc2d242ff244341b.1746615512.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.05.25 13:03, Lorenzo Stoakes wrote:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely new
> VMA).
> 
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
> 
> The existing .mmap() callback's freedom has caused a great deal of issues,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
> 
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
> 
> The .mmap_prepare() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavily
> restrict what can actually be modified, and being invoked very early in the
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.
> 
> The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> exclusive, so we permit only one to be invoked at a time.
> 
> Update vma userland test stubs to account for changes.
> 

In general, looks very good to me.

Some comments, especially regarding suboptimal code duplciation with the 
stubs. (unless I am missing fine details :) )

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   include/linux/fs.h               | 38 +++++++++++++++
>   include/linux/mm_types.h         | 24 ++++++++++
>   mm/memory.c                      |  3 +-
>   mm/mmap.c                        |  2 +-
>   mm/vma.c                         | 70 +++++++++++++++++++++++++++-
>   tools/testing/vma/vma_internal.h | 79 ++++++++++++++++++++++++++++++--
>   6 files changed, 208 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..d6c5a703a215 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2169,6 +2169,7 @@ struct file_operations {
>   	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
>   	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>   				unsigned int poll_flags);
> +	int (*mmap_prepare)(struct vm_area_desc *);
>   } __randomize_layout;
>   
>   /* Supports async buffered reads */
> @@ -2238,11 +2239,48 @@ struct inode_operations {
>   	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>   } ____cacheline_aligned;
>   
> +static inline bool file_has_deprecated_mmap_hook(struct file *file)
> +{
> +	return file->f_op->mmap;
> +}
> +
> +static inline bool file_has_mmap_prepare_hook(struct file *file)
> +{
> +	return file->f_op->mmap_prepare;
> +}

I am usually not a fan of such dummy helper functions .. I mean, how far 
do we go?

file_has_f_op()

file_is_non_null()

...

Or is this required for some stubbing regarding vma tests? But even the 
stubs below confuse me a bit, because they do exactly the same thing :(

:)

> +
> +/* Did the driver provide valid mmap hook configuration? */
> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> +{
> +	bool has_mmap = file_has_deprecated_mmap_hook(file);
> +	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
> +
> +	/* Hooks are mutually exclusive. */
> +	if (has_mmap && has_mmap_prepare)

Should this be WARN_ON_ONCE() ?

> +		return false;
> +
> +	/* But at least one must be specified. */
> +	if (!has_mmap && !has_mmap_prepare)
> +		return false;
> +
 > +	return true;

return has_mmap || has_mmap_prepare;

And I think you can drop the comment about "at least one" with that, 
should be quite clear from that simplified version.

> +}
> +
>   static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>   {
> +	/* If the driver specifies .mmap_prepare() this call is invalid. */
> +	if (file_has_mmap_prepare_hook(file))

Should this be WARN_ON_ONCE() ?

> +		return -EINVAL;
> +
>   	return file->f_op->mmap(file, vma);
>   }
>   
> +static inline int __call_mmap_prepare(struct file *file,
> +		struct vm_area_desc *desc)
> +{
> +	return file->f_op->mmap_prepare(desc);
> +}
> +

[...]

>   struct file {
>   	struct address_space	*f_mapping;
> +	const struct file_operations	*f_op;
>   };
>   
>   #define VMA_LOCK_OFFSET	0x40000000
> @@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
>   	vma->__vm_flags &= ~flags;
>   }
>   
> -static inline int call_mmap(struct file *, struct vm_area_struct *)
> -{
> -	return 0;
> -}
> -
>   static inline int shmem_zero_setup(struct vm_area_struct *)
>   {
>   	return 0;
> @@ -1405,4 +1432,46 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>   	(void)vma;
>   }
>   
> +static inline bool file_has_deprecated_mmap_hook(struct file *file)
> +{
> +	return file->f_op->mmap;
> +}
> +
> +static inline bool file_has_mmap_prepare_hook(struct file *file)
> +{
> +	return file->f_op->mmap_prepare;
> +}
 > +> +/* Did the driver provide valid mmap hook configuration? */
> +static inline bool file_has_valid_mmap_hooks(struct file *file)
> +{
> +	bool has_mmap = file_has_deprecated_mmap_hook(file);
> +	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
> +
> +	/* Hooks are mutually exclusive. */
> +	if (has_mmap && has_mmap_prepare)
> +		return false;
 > +> +	/* But at least one must be specified. */
> +	if (!has_mmap && !has_mmap_prepare)
> +		return false;
> +
 > +	return true;> +}
> +
> +static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	/* If the driver specifies .mmap_prepare() this call is invalid. */
> +	if (file_has_mmap_prepare_hook(file))
 > +		return -EINVAL;> +
> +	return file->f_op->mmap(file, vma);
> +}
> +
> +static inline int __call_mmap_prepare(struct file *file,
> +		struct vm_area_desc *desc)
> +{
> +	return file->f_op->mmap_prepare(desc);
> +}

Hm, is there a way avoid a copy of the exact same code from fs.h, and 
essentially test the implementation in fs.h (-> more coverage by using 
less duplciated stubs?).

-- 
Cheers,

David / dhildenb


