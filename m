Return-Path: <linux-fsdevel+bounces-34337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4BD9C48F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB63E1F2155E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EC1BD9E4;
	Mon, 11 Nov 2024 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNNvI30K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7321BC9ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363268; cv=none; b=cLwA5eL6c+YTmt2P15ZSCBufQc5koyht9vK/gls259p0WhKdlXWBLXABBawjVmYxXB0rzS06ShoAtyezOwp8Htn1aOTyvBXyrF8ASiqI1H7FAe7h4TgyE9rW+XNjPjYuPHfEoo5otXIyheT/aZBmbiOv8gdYNZUOoS35YtJhlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363268; c=relaxed/simple;
	bh=4e2faVv4xnB+7UV+V5ti1fHu/d/YCpjKrYt+AP58qj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5Gt8E8gsAZw5GRw4DfAchTxxhG76dWsmFaj6/AMNfA6nuIa4yqaRHG4vSvx9uUwcBiG6UXMsUOCavtBAgkmwG98V+MOrPEV4VwFh98DI+COlbGASH2qW0bWUhkjqItB7p1oSXM+OtNOTODIDsZwVmcuJxHAamYQYjFnh8iyT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNNvI30K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731363265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+vO5Chh4XyZzqgY6wUPooEn0FNBsk5Lf4RjLmwEopI=;
	b=eNNvI30KWvr8Rj8o5F6SvwT39uqMtzFnPKrutKDyjly3GjJ5NRL+pAI2yCNoZ0lgCShN+i
	X0EkEJrHSjei5n4X+CieQzeiwFWEjWSXpo9/o1PAxf41CwIciSw6i8d3OLf0wkDd/CTDJp
	eAg97s56UjbM9qfFxsuVJ1dBfu3q3eY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-lmgiQ2e1Oo6POaF7mwWMeg-1; Mon, 11 Nov 2024 17:14:23 -0500
X-MC-Unique: lmgiQ2e1Oo6POaF7mwWMeg-1
X-Mimecast-MFC-AGG-ID: lmgiQ2e1Oo6POaF7mwWMeg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so37838185e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 14:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731363262; x=1731968062;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+vO5Chh4XyZzqgY6wUPooEn0FNBsk5Lf4RjLmwEopI=;
        b=u/X/xoZqx+i0QvstGRXPQLx7va/l9z34lHVrvpZpn+R8WK5bWG8H8n49TazTFiYeUn
         HkFD3VvSdyKsuZfIKIvr7BnQjVx64jBRI6Ld72HH4pQ3JTxWgf+csZATsjzxw0BsC2qF
         ULZwF+pUA4QvIjxjVq1+D62IWxZPaB4vza5xEDd4erRe+LjlKqhCKGftK9wY/yois/y7
         ez+R5ahkt/t+OCHSzIMXLOLoFEA0vIV7ShOZMpyUwoc6FzyDYLnQcGD8pxrwxOB9bfTx
         iY8LJGuR1T3axrpERL4SPznTGwK9zBj5PtGbexzpzAQh/XnGGdPfu09I6kcWdvM1dSCV
         4g4w==
X-Forwarded-Encrypted: i=1; AJvYcCVFIwa6jrtB+/2ekv7m9I3l+Vv7KkJl19Tow68BQGLdU+bvqTWCzfue+l59NMrBuAHviMv09khwZYDNcyoo@vger.kernel.org
X-Gm-Message-State: AOJu0YwRphr5n3361nR59mz3KT02GH7Pg202XKpUSa/BukDvEut2Jy46
	ksAIeaLI5g9OJ0T5NVwM2kTT6SnU/6qqNe0w+a1gEB5Df6A9IG+dzTRLXmgHaYAtaGVi0PxtMHr
	PNH6f1J5FHXkE7p1DoP+o1iS+2iHyDYjuYK/v3+I8numoSeWHIpieCIET3eTFJ4Q=
X-Received: by 2002:a05:600c:5493:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-432b7508b8amr127838235e9.19.1731363262552;
        Mon, 11 Nov 2024 14:14:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVLiJ0g/s6yUPMim4b3RPUgDEhqfWOalae/b5Xgk//XG5JFwtKRIUcqOjRw8kzwpuRybK1EA==
X-Received: by 2002:a05:600c:5493:b0:42e:75a6:bb60 with SMTP id 5b1f17b1804b1-432b7508b8amr127837945e9.19.1731363262115;
        Mon, 11 Nov 2024 14:14:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa737721sm228937965e9.36.2024.11.11.14.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:14:21 -0800 (PST)
Message-ID: <6fbef654-36e2-4be5-906e-2a648a845278@redhat.com>
Date: Mon, 11 Nov 2024 23:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
To: Vlastimil Babka <vbabka@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 chao.gao@intel.com, pgonda@google.com, thomas.lendacky@amd.com,
 seanjc@google.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, arnd@arndb.de, kees@kernel.org,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, linux-coco@lists.linux.dev
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
 <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
 <ZyzYUOX_r3uWin5f@casper.infradead.org>
 <10ffac79-0dba-4c30-991e-f3ca2b5ff639@redhat.com>
 <ff3174f8-c8b5-4fae-a9d9-87546d37c162@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ff3174f8-c8b5-4fae-a9d9-87546d37c162@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.11.24 12:02, Vlastimil Babka wrote:
> On 11/8/24 18:31, Paolo Bonzini wrote:
>> On 11/7/24 16:10, Matthew Wilcox wrote:
>>> On Thu, Nov 07, 2024 at 02:24:20PM +0530, Shivank Garg wrote:
>>>> The folio allocation path from guest_memfd typically looks like this...
>>>>
>>>> kvm_gmem_get_folio
>>>>     filemap_grab_folio
>>>>       __filemap_get_folio
>>>>         filemap_alloc_folio
>>>>           __folio_alloc_node_noprof
>>>>             -> goes to the buddy allocator
>>>>
>>>> Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.
>>>
>>> It only takes that path if cpuset_do_page_mem_spread() is true.  Is the
>>> real problem that you're trying to solve that cpusets are being used
>>> incorrectly?
>>
>> If it's false it's not very different, it goes to alloc_pages_noprof().
>> Then it respects the process's policy, but the policy is not
>> customizable without mucking with state that is global to the process.
>>
>> Taking a step back: the problem is that a VM can be configured to have
>> multiple guest-side NUMA nodes, each of which will pick memory from the
>> right NUMA node in the host.  Without a per-file operation it's not
>> possible to do this on guest_memfd.  The discussion was whether to use
>> ioctl() or a new system call.  The discussion ended with the idea of
>> posting a *proposal* asking for *comments* as to whether the system call
>> would be useful in general beyond KVM.
>>
>> Commenting on the system call itself I am not sure I like the
>> file_operations entry, though I understand that it's the simplest way to
>> implement this in an RFC series.  It's a bit surprising that fbind() is
>> a total no-op for everything except KVM's guest_memfd.
>>
>> Maybe whatever you pass to fbind() could be stored in the struct file *,
>> and used as the default when creating VMAs; as if every mmap() was
>> followed by an mbind(), except that it also does the right thing with
>> MAP_POPULATE for example.  Or maybe that's a horrible idea?
> 
> mbind() manpage has this:
> 
>         The  specified  policy  will  be  ignored  for  any MAP_SHARED
> mappings in the specified memory range.  Rather the pages will be allocated
> according to the memory policy of the thread that caused the page to be
> allocated. Again, this may not be the thread that called mbind().

I recall discussing that a couple of times in the context of QEMU. I 
have some faint recollection that the manpage is a bit imprecise:

IIRC, hugetlb also ends up using the VMA policy for MAP_SHARED mappings 
during faults (huge_node()->get_vma_policy()) -- but in contrast to 
shmem, it doesn't end up becoming the "shared" policy for the file, used 
when accessed through other VMAs.

> 
> So that seems like we're not very keen on having one user of a file set a
> policy that would affect other users of the file?

For VMs in QEMU we really want to configure the policy once in the main 
process and have all other processes (e.g., vhost-user) not worry about 
that when they mmap() guest memory.

With shmem this works by "shared policy" design (below). For hugetlb, we 
rely on the fact that mbind()+MADV_POPULATE_WRITE allows us to 
preallocate NUMA-aware. So with hugetlb we really preallocate all guest 
RAM to guarantee the NUMA placement.

It would not be the worst idea to have a clean interface to configure 
file-range policies instead of having this weird shmem mbind() behavior 
and the hugetlb hack.

Having that said, other filesystem are rarely used for backing VMs, at 
least in combination with NUMA. So nobody really cared that much for now.

Maybe fbind() would primarily only be useful for in-memory filesystems 
(shmem/hugetlb/guest_memfd).

> 
> Now the next paragraph of the manpage says that shmem is different, and
> guest_memfd is more like shmem than a regular file.
> 
> My conclusion from that is that fbind() might be too broad and we don't want
> this for actual filesystem-backed files? And if it's limited to guest_memfd,
> it shouldn't be an fbind()?

I was just once again diving into how mbind() on shmem is handled. And 
in fact, mbind() will call vma->set_policy() to update the per 
file-range policy. I wonder why we didn't do the same for hugetlb ... 
but of course, hugetlb must be special in any possible way.

Not saying it's the best idea, but as we are talking about mmap support 
of guest_memfd (only allowing to fault in shared/faultable pages), one 
*could* look into implementing mbind()+vma->set_policy() for guest_memfd 
similar to how shmem handles it.

It would require a (temporary) dummy VMA in the worst case (all private 
memory).

It sounds a bit weird, though, to require a VMA to configure this, 
though. But at least it's similar to what shmem does ...

-- 
Cheers,

David / dhildenb


