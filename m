Return-Path: <linux-fsdevel+bounces-49439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A3ABC6D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5517889D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE8288CB5;
	Mon, 19 May 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chcLdKae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5B1F2BB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677638; cv=none; b=a1PzHWEbb9RBm+ChUY4WoS7joAlXh+TxxdlxR/QsBfrmRK/agU36U12RYrXwfFDUBLBFsYsDx0yWVjC/AH9ll6tUG5mTXaiv6RVHV3OXjFV+Pzm/8Q5e1MoSs88753m+Toy1p3TiJJ1DchBubyeACbVC2yC4JXWdF7YWPHQRWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677638; c=relaxed/simple;
	bh=LTHw/rgMhHeXWoQSK08BOTFZpqVuSxT6VuqE00+e44g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAyO7GbOS+8oaTUJ6uuMNPJ9vTCaXXBc8aMGRm99zLNGnURz6dcFwGQNSW8RmgwXQk5y2dwHykslskDjypQrXo2YQLZee7K1KETwj3gov+P5H40oCr/DDF8mMNMOQWOffv4FOTOPhOza6cJzPSn3LwYJ5toEHluV0ykH38H02dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chcLdKae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747677635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UXbC4Dnz7rnSGIvOTw3tnEOtF89rRJMSvQjwW/9D6t8=;
	b=chcLdKaeu3ONshs9VPy7QNlXBsQYCScDQy8/htGdruwOGN62XNfu0KB9jQ7bGaZTe2deSi
	HqJuUVVi6w/2aptyBNnrN7YBlwZQnoVBk7PVaGXY1UdmyRk8GvwJ6SlAB6AFLSDo999pfE
	U/UvrzkUjbmKLsJnRn/b4+HLPuJBUZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-BVLR5JeFPHWWZIlj1BFepw-1; Mon, 19 May 2025 14:00:33 -0400
X-MC-Unique: BVLR5JeFPHWWZIlj1BFepw-1
X-Mimecast-MFC-AGG-ID: BVLR5JeFPHWWZIlj1BFepw_1747677632
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a364394fa8so1331017f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 11:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677632; x=1748282432;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UXbC4Dnz7rnSGIvOTw3tnEOtF89rRJMSvQjwW/9D6t8=;
        b=mSrRFe7r/L6Edbzr/WaDSILXknkyxIaZNLJojhyCgAKf6kDaWhfZMt4OvMeHaLC3fG
         FNnlr71VNaZPDTmMXDsE6YK+64lpo0V6v3in0Zm7QCT5J4582t30uSe6427SDJTB8zGp
         kE3ZYVkL3rcKIRa5lobyebbLCJmW0aWDdGe8jIcX6lng/UwDAEOfaicdMEopuW5tBfzp
         JG+sSKN5L+QhtWwrU8DopQyKwUD460iY0UfAOuzX2rjH/BVGjI2xZruvl98spP096fb3
         vvArYEMyOF9udZdnQRFWqvgeijb8wTPxDSQ7vHaoa+fqp9J58ng7OFTBwEl4CpsuOsQk
         oNdw==
X-Forwarded-Encrypted: i=1; AJvYcCXcDM60US/L7C5RaXgbyLUuBkG1HYTxnn2EZhzP06Mh/bFqNM921+8GRmCluJAdchkpii7hHGQskPjg6ce0@vger.kernel.org
X-Gm-Message-State: AOJu0YygD3SNDBMrUM0Tv/So41ZoBMlg0QYRLz88VXfV9QLATuAIydxu
	1k0LKshzpCFM5ZgnTAn+kVPfYjISL42q2Uc7BeC3HDJvmXRJwG/ZEb+5BDytZwV8scA1oK3vTEV
	SKzf5TgW/SPbFBUG6/zB3WVCg8f9Aoi96VDayM48jrW55UvyIH7X3hXYws85DYRuxWPI=
X-Gm-Gg: ASbGncv3TjaMMY9BuyjLZ4g6imr312ZPKEby6sf5j4qBXn0ryvaLujf/MK0d67WREHN
	J8wBQbukZXCur+dYuQYacOrVC4iNY+qfCAWynA76+lWIJXjfSMen4xkpfxqgd5SOXBAulJ6sjM9
	e87HXIqPZfCBDRl76CBbIloBeDhvabIA2S8zEwX83OeiaexEM4+YEwo8pt8OuWx3RRyDKa7/Aa8
	wWoupz7dkK8oo+SEE/F6imCZXpN4IFCtrLeWALwIRHKl5zh/r9JdLs3evhRDOG/qATsLqod6UDR
	20PMpdEJa6ctcPMLfLf4ur/xFVDLKi6qUKFBLlaDkT8kf9Tpgi0CIGouUpAYk5UdKFj3zrnTL19
	UinW2L2uYnmmoF0gVgZNZliXFgzz9LX6XO97Baxs=
X-Received: by 2002:a05:6000:1881:b0:3a1:f635:1136 with SMTP id ffacd0b85a97d-3a35fead113mr11130046f8f.28.1747677631922;
        Mon, 19 May 2025 11:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNOlabkxqP3Ndi5EnXXXETD47WSduA7TE65M2Mu+MvxkHNO1hvWofRxxLgEY+hHNW2x7LZrA==
X-Received: by 2002:a05:6000:1881:b0:3a1:f635:1136 with SMTP id ffacd0b85a97d-3a35fead113mr11130023f8f.28.1747677631473;
        Mon, 19 May 2025 11:00:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8874bsm13775350f8f.67.2025.05.19.11.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 11:00:31 -0700 (PDT)
Message-ID: <e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
Date: Mon, 19 May 2025 20:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 10:51, Lorenzo Stoakes wrote:
> If a user wishes to enable KSM mergeability for an entire process and all
> fork/exec'd processes that come after it, they use the prctl()
> PR_SET_MEMORY_MERGE operation.
> 
> This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> (in order to indicate they are KSM mergeable), as well as setting this flag
> for all existing VMAs.
> 
> However it also entirely and completely breaks VMA merging for the process
> and all forked (and fork/exec'd) processes.
> 
> This is because when a new mapping is proposed, the flags specified will
> never have VM_MERGEABLE set. However all adjacent VMAs will already have
> VM_MERGEABLE set, rendering VMAs unmergeable by default.
> 
> To work around this, we try to set the VM_MERGEABLE flag prior to
> attempting a merge. In the case of brk() this can always be done.
> 
> However on mmap() things are more complicated - while KSM is not supported
> for file-backed mappings, it is supported for MAP_PRIVATE file-backed
> mappings.
> 
> And these mappings may have deprecated .mmap() callbacks specified which
> could, in theory, adjust flags and thus KSM merge eligiblity.
> 
> So we check to determine whether this at all possible. If not, we set
> VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> previous behaviour.
> 
> When .mmap_prepare() is more widely used, we can remove this precaution.
> 
> While this doesn't quite cover all cases, it covers a great many (all
> anonymous memory, for instance), meaning we should already see a
> significant improvement in VMA mergeability.

We should add a Fixes: tag.

CCing stable is likely not a good idea at this point (and might be 
rather hairy).

[...]

>   /**
> - * ksm_add_vma - Mark vma as mergeable if compatible
> + * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
>    *
> - * @vma:  Pointer to vma
> + * @mm:       Proposed VMA's mm_struct
> + * @file:     Proposed VMA's file-backed mapping, if any.
> + * @vm_flags: Proposed VMA"s flags.
> + *
> + * Returns: @vm_flags possibly updated to mark mergeable.
>    */
> -void ksm_add_vma(struct vm_area_struct *vma)
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags)
>   {
> -	struct mm_struct *mm = vma->vm_mm;
> +	vm_flags_t ret = vm_flags;
>   
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> -		__ksm_add_vma(vma);
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> +	    __ksm_should_add_vma(file, vm_flags))
> +		ret |= VM_MERGEABLE;
> +
> +	return ret;
>   }


No need for ret without harming readability.

if ()
	vm_flags |= VM_MERGEABLE
return vm_flags;

[...]

> +/*
> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> + *
> + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> + *
> + * If this is not the case, then we set the flag after considering mergeability,
> + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> + * preventing any merge.

Hmmm, so an ordinary MAP_PRIVATE of any file (executable etc.) will get 
VM_MERGEABLE set but not be able to merge?

Probably these are not often expected to be merged ...

Preventing merging should really only happen because of VMA flags that 
are getting set: VM_PFNMAP, VM_MIXEDMAP, VM_DONTEXPAND, VM_IO.


I am not 100% sure why we bail out on special mappings: all we have to 
do is reliably identify anon pages, and we should be able to do that.

GUP does currently refuses any VM_PFNMAP | VM_IO, and KSM uses GUP, 
which might need a tweak then (maybe the solution could be to ... not 
use GUP but a folio_walk).

So, assuming we could remove the VM_PFNMAP | VM_IO | VM_DONTEXPAND | 
VM_MIXEDMAP constraint from vma_ksm_compatible(), could we simplify?

That is: the other ones must not really be updated during mmap(), right?
(in particular: VM_SHARED  | VM_MAYSHARE | VM_HUGETLB | VM_DROPPABLE)

Have to double-check VM_SAO and VM_SPARC_ADI.

> + */
> +static bool can_set_ksm_flags_early(struct mmap_state *map)
> +{
> +	struct file *file = map->file;
> +
> +	/* Anonymous mappings have no driver which can change them. */
> +	if (!file)
> +		return true;
> +
> +	/* shmem is safe. */
> +	if (shmem_file(file))
> +		return true;
> +
> +	/*
> +	 * If .mmap_prepare() is specified, then the driver will have already
> +	 * manipulated state prior to updating KSM flags.
> +	 */
> +	if (file->f_op->mmap_prepare)
> +		return true;
> +
> +	return false;
> +}

So, long-term (mmap_prepare) this function will essentially go away?

Nothing jumped at me, this definitely improves the situation.

-- 
Cheers,

David / dhildenb


