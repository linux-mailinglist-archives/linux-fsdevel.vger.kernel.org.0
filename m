Return-Path: <linux-fsdevel+bounces-11029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A780585001A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 23:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83D7B2D21F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF341364D9;
	Fri,  9 Feb 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILbjPq7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9911CAF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517892; cv=none; b=uREhK8bcLmWtIt++h68tZKt8HqEOhNCNfiE6JG1xPh9O6P0k4YbtXqWiQYZ6MRj2vnw2SV4jVgZfkNJPf5xeYG+J1YraiOQoMSxIt5x/8mv8DFl5/w4DJnIZB/ovCFLQ9ALrA5KjFT3c3slIvaFn6r1C17d9RlfXN5B3Iw+qlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517892; c=relaxed/simple;
	bh=8p4VEXa0Kgv0eQllxoIvzZUOBBNqsem7R6zEKzU4i+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyMIkwU4Vx4rcSr936mOknScso1L3KL7YUXNZQs4cEvJ7UqtqMkLx/uorTpi15FDOoXbp7ZcTx2poiXMmgXUHj8LHylEBs5Hcq7zU7vil3qMThyMa5EHd5IhSK5XKvVh0e1usuAygssTp/Iu4uz49DxUYdQHl0gyZvnY/nWruyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILbjPq7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707517888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o84G0EeXm0vGHwnJrqDjJuR35i6L4PXjF7UAUJUO5no=;
	b=ILbjPq7T+ucyqkXwoNGiSqoQ77Yk0obbnxblFhLMJoDE7OVUgYppdEl4i7cBTUcqAUe462
	Sx2+7u4lf8zQziNkTVoFoJRkRCLx7CDgeRlcTBXXDkF9FB3Vilbkq+G1zQKxDXbVDWus35
	kjEcGLDrKTnw+VIUsrCQru1PUt0nmpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-psp3SMfnNySs__iII26T_Q-1; Fri, 09 Feb 2024 17:31:27 -0500
X-MC-Unique: psp3SMfnNySs__iII26T_Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4108cbc7ca4so266585e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 14:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517886; x=1708122686;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o84G0EeXm0vGHwnJrqDjJuR35i6L4PXjF7UAUJUO5no=;
        b=USvwBFhTUDaRY/tP0iRVrNTIn/ZKq/JUviNGFoDmx2bnZlG3tGoYo1sqo3uLfXLZmg
         CXR4gq2h1RkbSxHhsrVOwTSGcvUEfkgEWTz/l+tZyhHnYnrZFEeuKrJquUjYuQV7KVqV
         nN9rTheoRO6oTu867LnZa5rbicpAdGLZ2DMT4HHnuYcWQvkkeyn3X6uc8na230cjMON1
         P4zO3QgKpU1WfBnDxyFTPojmDvdvXpcY3ECnajmiAdGqgVaMDjpcRg4GVOtnO6EdLGAf
         t9tNayr8V2a+AyOjozJrEMcNpOHbdRf6I/i+6J9u+gleCamu5/y7LIKzmRpKL3kCYkyy
         pksQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8Vx9PgGqc+b0GaAxn/W7U0EGLa+bVDEtJX8WdWPn6myRbkM/Bf9kVFzthgPeRJr/WaVPIA644Fy6GGBThzc4EE97zrpM6/JvUvc6Dg==
X-Gm-Message-State: AOJu0YyUHixnMllSkURgD6ElkQEAtSwLoIQLMu9gPxQuHiG5g+Fz6eZj
	3ht23u9yFSxddL112v5SAnH3e36iR5q287cM6ObXIMJP+XXvmoMzthlZkgTDtcIszGkwBP8lbfm
	vaOO93pqITQGdikPuhSIld3z18DEvEYukMZOwVRpy2b6oDfaXvIC2Kpbic7ERKIQ=
X-Received: by 2002:a05:600c:511e:b0:410:6dfb:6f25 with SMTP id o30-20020a05600c511e00b004106dfb6f25mr403442wms.0.1707517886319;
        Fri, 09 Feb 2024 14:31:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqvvdbZm3iOppsExvwbOrpna0M6WJoI2+u5jFx2mdU8IlBrJ2UWpAXEPWFdUTY4VYs6r1NEg==
X-Received: by 2002:a05:600c:511e:b0:410:6dfb:6f25 with SMTP id o30-20020a05600c511e00b004106dfb6f25mr403438wms.0.1707517885959;
        Fri, 09 Feb 2024 14:31:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCxASgX/kyQYrW21Vn19V46vPe1WbfO3mvHkEC8NUHRjWNCYjfU1KBM5KSkdzZX/SaVNfh+1pFwPED/WHUzBIoN5xTywOAeC/UqhBqDRCI6zkxYQ5+VV3Q1a7FQQwT1vt5X5/kHVQ2dn4SA5PYUqvU+8dXoGRyN7Wok5wYnvf7
Received: from ?IPV6:2003:cb:c718:6800:9d15:2b60:4f57:7998? (p200300cbc71868009d152b604f577998.dip0.t-ipconnect.de. [2003:cb:c718:6800:9d15:2b60:4f57:7998])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b00410727c315fsm1779066wmb.16.2024.02.09.14.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:31:25 -0800 (PST)
Message-ID: <2e7496af-0988-49fb-9582-bf6a94f08198@redhat.com>
Date: Fri, 9 Feb 2024 23:31:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/task_mmu: Add display flag for VM_MAYOVERLAY
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240208084805.1252337-1-anshuman.khandual@arm.com>
 <fb157154-5661-4925-b2c5-7952188b28f5@redhat.com>
 <20240208124035.1c96c256d6e8c65f70b18675@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240208124035.1c96c256d6e8c65f70b18675@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.02.24 21:40, Andrew Morton wrote:
> On Thu, 8 Feb 2024 17:48:26 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.02.24 09:48, Anshuman Khandual wrote:
>>> VM_UFFD_MISSING flag is mutually exclussive with VM_MAYOVERLAY flag as they
>>> both use the same bit position i.e 0x00000200 in the vm_flags. Let's update
>>> show_smap_vma_flags() to display the correct flags depending on CONFIG_MMU.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This applies on v6.8-rc3
>>>
>>>    fs/proc/task_mmu.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 3f78ebbb795f..1c4eb25cfc17 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -681,7 +681,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>>>    		[ilog2(VM_HUGEPAGE)]	= "hg",
>>>    		[ilog2(VM_NOHUGEPAGE)]	= "nh",
>>>    		[ilog2(VM_MERGEABLE)]	= "mg",
>>> +#ifdef CONFIG_MMU
>>>    		[ilog2(VM_UFFD_MISSING)]= "um",
>>> +#else
>>> +		[ilog2(VM_MAYOVERLAY)]	= "ov",
>>> +#endif /* CONFIG_MMU */
>>>    		[ilog2(VM_UFFD_WP)]	= "uw",
>>>    #ifdef CONFIG_ARM64_MTE
>>>    		[ilog2(VM_MTE)]		= "mt",
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I'm thinking
> 
> Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
> Cc: <stable@vger.kernel.org>

I'm having a hard time believing that anybody that runs a !MMU kernel 
would actually care about this bit being exposed as "ov" instead of "uw".

So in my thinking, one could even update 
Documentation/filesystems/proc.rst to just mention that "uw" on !MMU is 
only used for internal purposes.

But now, I actually read what that structure says:

"Don't forget to update Documentation/ on changes."

So, let's look there: Documentation/filesystems/proc.rst

"Note that there is no guarantee that every flag and associated mnemonic 
will be present in all further kernel releases. Things get changed, the 
flags may be vanished or the reverse -- new added. Interpretation of 
their meaning might change in future as well. So each consumer of these 
flags has to follow each specific kernel version for the exact semantic.

This file is only present if the CONFIG_MMU kernel configuration option 
is enabled."

And in fact

$ git grep MMU fs/proc/Makefile
fs/proc/Makefile:proc-$(CONFIG_MMU)     := task_mmu.o


So I rewoke my RB, this patch should be dropped and was never even 
tested unless I am missing something important.

-- 
Cheers,

David / dhildenb


