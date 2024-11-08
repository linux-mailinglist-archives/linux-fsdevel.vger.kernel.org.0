Return-Path: <linux-fsdevel+bounces-34029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BABE9C22FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E31C22D44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52000191F8E;
	Fri,  8 Nov 2024 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdQ1Ap0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FB18DF86
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087115; cv=none; b=qBfi1bUryIqNofUlvWzivbFIPx8vFzCjDJjHljsuw86uK8In6ygmwDwVu/E8TejSSXzFmWWEVm7BSuhC/zyb8l9EGk/otP211XV94T26/cVChzHjwnThFMV1UOErddFaidzbRBUuUlP1JqL4DWQinGLt3U/I8F7IW1Bl+hPZYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087115; c=relaxed/simple;
	bh=NJuiGu3PlwZ+2Oktvoo+Y3RvZx0dhbgHrcUsyVpM6Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDNwcwNDt9VtnOMt+5vZ+S8ALMOMlIQMr97tEcqof51/YCbITejzcNx2MFaXNNHXzJTn40jzJ661XCkL79+1u4bdXoR6F1c3+u7x2RN+q4KX+ghXhLuvzphjZOsgJrVeeoczM8uKfU5QRROoAeTACN4ihGictVUL+4bAiEAuv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdQ1Ap0w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731087113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yd4O8mZKu4eBAZvLdoHZhgPng6vXj2+Z+n0AqkWNQHs=;
	b=KdQ1Ap0wTZDuHmfnqJGuyvyWt6zYMYFX0jTMSkINJTOcG0hu34e75yXVHMk/YViyxVp6zQ
	HBnJ7nFy2x66VoexUy0SEbpVyiAwqd7ww0qa30abkJ1Jghm9XikXJIKWaSD7RlYwQr03mH
	NxJfKfOE4N2h3oRg+Cs+TYCnSVh/TMw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-vL8cBYuuPc2_pCgpwUSSJQ-1; Fri, 08 Nov 2024 12:31:52 -0500
X-MC-Unique: vL8cBYuuPc2_pCgpwUSSJQ-1
X-Mimecast-MFC-AGG-ID: vL8cBYuuPc2_pCgpwUSSJQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d563a1af4so1169485f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 09:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087111; x=1731691911;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yd4O8mZKu4eBAZvLdoHZhgPng6vXj2+Z+n0AqkWNQHs=;
        b=PRcm2+4feWEys82Pxx0zIjAkFhU1JKSLP4I5QeoIxOnRmuZlHha02RNXMwzVKwTnIL
         uPaBumxZMlrVxt2NNOTEbaaF4HqpcGupRjrKfNS9sqFA5+YauOQBX4nLf+s+S6VCvUPz
         qozWOHg5shifKt2SgwoELduDTQWyxnkvxeW24i7sttufgxy5eH2+4GKOADlKmdU0wOER
         Y29tXjkI8usXxo7yh8TBOG5o+Y2tP1aiNwhOLYTwL1iP+FxXcdg9V+3HHRLdhSwz6jfx
         QKB2o95eOadIgv20K8lOeZsOcBkAnwGaJbXErS6FtLVrUuoR3YVSQAyeyXRD/JRin/6C
         ibag==
X-Forwarded-Encrypted: i=1; AJvYcCUWM9Fx4210M55KiKV9dbYSkoZ4pF4OEKl2TmOg05C3rqn6LKWO1Z2y2U5rXcwLElryIRQ4Lfr4l5zJNcTI@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGzSQadcyrqHkDMO3pKrhJYVht4BCfZZUzwDRo4kjkTBc+s1M
	xyogs5qdQaQm5sBs1uyZbWwmVLrZ6/Xwn/1xeQKDlobRUBLdk+fWMywcviGz/BKW7QzGiskLRPP
	OhGC3ZcmENvb3mQyJN5mOYfjoy0ww/V1CCh4eAwBzQPy7RoPvDWY1gPRC8dNWAsQ=
X-Received: by 2002:a5d:6d8a:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-381f186d184mr3065636f8f.34.1731087110758;
        Fri, 08 Nov 2024 09:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3QWFDdRozO+PK2MbzpOgYsv6Dill3GhRB3QqEZymzjtGl7Y3z7IR1KySm+lULn51+VPdYsA==
X-Received: by 2002:a5d:6d8a:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-381f186d184mr3065582f8f.34.1731087110333;
        Fri, 08 Nov 2024 09:31:50 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed998e6esm5551930f8f.55.2024.11.08.09.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 09:31:49 -0800 (PST)
Message-ID: <10ffac79-0dba-4c30-991e-f3ca2b5ff639@redhat.com>
Date: Fri, 8 Nov 2024 18:31:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
To: Matthew Wilcox <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 chao.gao@intel.com, pgonda@google.com, thomas.lendacky@amd.com,
 seanjc@google.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, arnd@arndb.de, kees@kernel.org,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, linux-coco@lists.linux.dev,
 Linux API <linux-api@vger.kernel.org>
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
 <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
 <ZyzYUOX_r3uWin5f@casper.infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZyzYUOX_r3uWin5f@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 16:10, Matthew Wilcox wrote:
> On Thu, Nov 07, 2024 at 02:24:20PM +0530, Shivank Garg wrote:
>> The folio allocation path from guest_memfd typically looks like this...
>>
>> kvm_gmem_get_folio
>>    filemap_grab_folio
>>      __filemap_get_folio
>>        filemap_alloc_folio
>>          __folio_alloc_node_noprof
>>            -> goes to the buddy allocator
>>
>> Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.
> 
> It only takes that path if cpuset_do_page_mem_spread() is true.  Is the
> real problem that you're trying to solve that cpusets are being used
> incorrectly?

If it's false it's not very different, it goes to alloc_pages_noprof(). 
Then it respects the process's policy, but the policy is not 
customizable without mucking with state that is global to the process.

Taking a step back: the problem is that a VM can be configured to have 
multiple guest-side NUMA nodes, each of which will pick memory from the 
right NUMA node in the host.  Without a per-file operation it's not 
possible to do this on guest_memfd.  The discussion was whether to use 
ioctl() or a new system call.  The discussion ended with the idea of 
posting a *proposal* asking for *comments* as to whether the system call 
would be useful in general beyond KVM.

Commenting on the system call itself I am not sure I like the 
file_operations entry, though I understand that it's the simplest way to 
implement this in an RFC series.  It's a bit surprising that fbind() is 
a total no-op for everything except KVM's guest_memfd.

Maybe whatever you pass to fbind() could be stored in the struct file *, 
and used as the default when creating VMAs; as if every mmap() was 
followed by an mbind(), except that it also does the right thing with 
MAP_POPULATE for example.  Or maybe that's a horrible idea?

Adding linux-api to get input; original thread is at
https://lore.kernel.org/kvm/20241105164549.154700-1-shivankg@amd.com/.

Paolo

> Backing up, it seems like you want to make a change to the page cache,
> you've had a long discussion with people who aren't the page cache
> maintainer, and you all understand the pros and cons of everything,
> and here you are dumping a solution on me without talking to me, even
> though I was at Plumbers, you didn't find me to tell me I needed to go
> to your talk.
> 
> So you haven't explained a damned thing to me, and I'm annoyed at you.
> Do better.  Starting with your cover letter.
> 


