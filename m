Return-Path: <linux-fsdevel+bounces-50609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD3ACDEDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A61216879E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5328FA80;
	Wed,  4 Jun 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIUbitAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1728EA65
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043182; cv=none; b=ll70fjS751YDvymrWxXLVC1qbFFeqknHHaRm1eF3h4sOC0zW6gWZYBKLyWEsTrfjKsI5rXZcFCgYlEv36zsXBT+c+k4FKiltz0oq/iQglY5xuyo0I/XKMJO0iJEUZj1K0RmVWlwMphEzxaxNU0WFrZbNbJN7K+3v4R/ySbiGrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043182; c=relaxed/simple;
	bh=bBv7kKtPz698obUpmM8o/T8D8HSJkDBTP2nZQaX4/qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgavWwuf64I8E9Ej6abH2Xt/6f2HY+029q530gQfV3+N1SFpOyKbkAOal7I0DFYIT8esTs3w9J+vPAkUG0dfahagAdDQkgMuohE71EaV+BEQDb6GDBpNhSkrQiaA020MwtK2nJQxUzgz1XdbcC/aOMqFIujBk/mq9F+JisBQIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIUbitAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749043179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yi685aC5CqrR/61sFlwzZ6HBvbWgdnrQT0rYDI85PAk=;
	b=KIUbitAAUEcHCMPRs6fzVaP5C/7NzQbBO6sRNqDCKXsaUxDzlAy9r1OMbOdCsNGlAK7N1F
	v285OaPC059U45Zl1H0jgvTQqXyk4Q50GxeUIQ3niZb65JsOa5VJboE7UxlEkbNUlmbkLL
	9f0zv74udXBpyKsYX2YyAfEN21r7kbA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-eCjJIojjOUOb1lTQXRFjZA-1; Wed, 04 Jun 2025 09:19:38 -0400
X-MC-Unique: eCjJIojjOUOb1lTQXRFjZA-1
X-Mimecast-MFC-AGG-ID: eCjJIojjOUOb1lTQXRFjZA_1749043177
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso37398025e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 06:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043177; x=1749647977;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yi685aC5CqrR/61sFlwzZ6HBvbWgdnrQT0rYDI85PAk=;
        b=IQrextKQqmOVBduTGttYcJXG35l+Ie1AC1u6Edvia0rIjUfVxEjzI2DSndfn2kRFNv
         fSUoRYrFTUK/JMMeDGM4BZuNBTnBzaO+/KtvzbL0hyMVbsikXSa/1TcwXzJBK/Fj4Wlh
         o9xjoPP+kvYNMG9Of+hhBpxJxNK7E4bIZe84HRumVgy7aCTSL6i2/HtPah3kUCeT04op
         gReuJl/GpNlUdTZiN6DF5gF2U9hWzAPB17Rmn3JPIE9FtfEa2u8wsUbMBYN8+pH7dmPi
         yYVl3Qt1yeOGN61fXirV6dOG3Bz0g+JGqvrJii6YPpWLpfa5/SzM27ntF9yq7SIrv/el
         LEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNz2BL8u9OxDAnX35YQYGAx1iypURiciueCGBQSkHBIFWQC5mILwE2kBMtW83SKHwRmU/nrKUOUrRCUrFE@vger.kernel.org
X-Gm-Message-State: AOJu0YyaglmTJj5vJ9ZJGu0Jn077TVWb7wZbqh9NtO8dQm+jgasdS/1x
	kdaku8+qmTYABksysg7gLjx+RbZaFzljShA+k4ipRv8VBOeG5FAAGRXDQUcI5dCHIZvBRx1wSiP
	MueZnE1EbSxf2ouXUUuQwy6eqVE80KDxhTqsUMp8zBPNyz0nuSo4B0ipJw8HqFvXyYMA=
X-Gm-Gg: ASbGncs+oOnv5ohfFwMtfwjJXGWJs0WgjoXBXNt83007ldZM9TfUS4CgRUGR7dJaz+G
	CmwIakTBClwqQIYZVtV/199cxJKGaJGZxJfWrGnA2hB3vQCAbJbcDeiMaaW7jevf2hNrGhXhsEY
	H2B7r96a5KnZrSjt5oGgdb5PmUk0aXnVCsVoCB4RVO4vwmIUp1k3qFSNQCXSbj4CcMXnfy+gfFC
	s7A4e7A8eF3yWHFKuvQ5Xmc7uc827i1uq2KvQnBpJuReU6JOQ6jp8zjn8YxwxigM7xccuf9aX4v
	77KJATIzClp65pKIBExNJLGYnX2F4Pp78KXBAHfzMJgsMRP9wEsF0NbWLS8cFAqObbkEKmU5eW8
	vDW3H3Fu5VOnZ+MwJ0nvVNy01CugIKjz1KosqLmak/gQnJsIuXw==
X-Received: by 2002:a05:600c:8289:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-451f0b2e6c3mr21071465e9.25.1749043176814;
        Wed, 04 Jun 2025 06:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy7QaodTgFfDdSvAX72kgMU9zSqScxhzC4fy0RcSCtYfpotJJP4oPdfjuXqIvNkRFSL6q9SQ==
X-Received: by 2002:a05:600c:8289:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-451f0b2e6c3mr21071215e9.25.1749043176474;
        Wed, 04 Jun 2025 06:19:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1afebsm199548075e9.0.2025.06.04.06.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 06:19:36 -0700 (PDT)
Message-ID: <5de3da6b-7c5f-4d40-b3a7-f6a0f5cbc6da@redhat.com>
Date: Wed, 4 Jun 2025 15:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-1-9c638c73f047@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250603-uffd-fixes-v1-1-9c638c73f047@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.25 00:14, Tal Zussman wrote:
> vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
> The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
> allowing VM_DROPPABLE regions to be registered with userfaultfd.
> 
> Additionally, vm_flags is not guaranteed to correspond to the actual
> VMA's flags. Fix this test by checking the VMA's flags directly.
> 
> Link: https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/
> Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   include/linux/userfaultfd_k.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 75342022d144..f3b3d2c9dd5e 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -218,7 +218,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>   {
>   	vm_flags &= __VM_UFFD_FLAGS;
>   
> -	if (vm_flags & VM_DROPPABLE)
> +	if (vma->vm_flags & VM_DROPPABLE)
>   		return false;
>   
>   	if ((vm_flags & VM_UFFD_MINOR) &&

Nice catch!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


