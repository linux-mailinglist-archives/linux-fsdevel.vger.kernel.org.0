Return-Path: <linux-fsdevel+bounces-50913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0FCAD0ECE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A99188D671
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92A20C037;
	Sat,  7 Jun 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5frffjp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC02F3E
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749319147; cv=none; b=OkuMjxaU6UjB3qTUDSzPfnHWbXYzcJqeLk5sk8PeI4okq++YtkJOk+VUp4FSUxE/NP2768q4C1yuzAI8lnQBN4ZJAaagQvrU8Z9t99KIeepdSM9Np5Tf26vBPTAOA35E3m7KK/yMhAaXNSBiWqF+FdxGGak4h67Ua+go3vtMwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749319147; c=relaxed/simple;
	bh=c3OLCpcLRs9jPKX6YL/P3U5btA76bYODG0jomrnpKow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JD0zlcDm/fMMzetzI6nitkdkJaUU5HU+OzXUsk1BWYYt+FtSrDKnB+MdR7Jddo26vHSVTTLxcOLmxdzXR9D42KPtB0DrNkrtTHTUhsVPBxeo2pV20BmIm8ZHJqjz/p1zO6GJC6z4d91lCTRjS849rDzXhJcz55ouyevZL7dw6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5frffjp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749319144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zCyitC2uUhJtc07ZYGkM5rqqD+R23R8ZG1MZEso9NGU=;
	b=L5frffjpjPbCwjUAAgUk9l4jT3oeXCh3WKQuOXjrojf/RLquiVjzx+ZP8kYrmYqHSydJnk
	CSBKzyZ9oruLUi7s8XrJfwTZWSXsWen3nYAR0NDTXrOZ6orhAdBFJiaPmB4MLP1H7QzoVs
	EKGUfqHc4OF3KYXZVwZFDWw5+RnWLjg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-ds-WhW_0M4Gme3GDnxt-JA-1; Sat, 07 Jun 2025 13:59:02 -0400
X-MC-Unique: ds-WhW_0M4Gme3GDnxt-JA-1
X-Mimecast-MFC-AGG-ID: ds-WhW_0M4Gme3GDnxt-JA_1749319141
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d244bfabso24521595e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 10:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749319141; x=1749923941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCyitC2uUhJtc07ZYGkM5rqqD+R23R8ZG1MZEso9NGU=;
        b=KCk8IFt8XqtWS4VPPnKU/rHO6s0stJR3qJuROiDa1VquxsgvG1eKRmnlC5OfQFLf85
         0w+98ZvKf98SsOn4A3tkAXKE8b66gmXbrDEVUVjY1mL2EoPoa0H9I8jA4uiMgqbLfTuT
         Zhmb2F98s/AjAOts9Z9YPKISfxnFWQt7eCl7cwV82eVWAs7M+9C/0C3SFhUKGAxqkGDi
         4NO1iGViuNMDVxIACc9Iwhbdm5hLyXaeGDBTMXsBwntN5PkT6wd+39uFKvpixj7fgrXa
         kyx5fs2WqdbDcTJT5bS7ikaOlZxgl55DrHEeTBTHzoUavoFynGuA55equ3Lku7ij09ex
         VJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCW1uVMybba6mF92qy29t3ETX5gubSossU4mY1ErzScSMA4CKIAKEhdQKPqPSiunwg76Ss0tR0wvUxiurUde@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gTspo/JgErz8xO01kzrHpHaTkr1tlZxAMb6DXMGqd8T4AS/l
	+T3vFd2mf4V+ZumILTemY40rA7+nWknwMA/kQB3ooT6fXm7ZA4q0fiYVsy44wIxMMjy/roWgmd7
	5KyCx7rMBEd5x/6TTA1HudSqymcm5ylHkO8XtKBnmULJLeVflJY77KS5DZon0mpKeGkw=
X-Gm-Gg: ASbGnctkJioglOmyi+rD4Zs36geQdhyWftXYHA6h4G0PfdA4tvWSNq9WlUaCftABHyi
	OelxrrQHcajskrXIcnQppmJW2OjzV/dwYaRYNBLF5mPdt4xKJYU9TitNQfNBssBAsa83VhmfORa
	kOgoD4rA6MdxA23WhtOx4ZfVCCCw62tQxzZZ72zZds6sOoDuV/GJ+uH78YnWJWdUy9i/4Sc5/pb
	vvp64/ymcW2ERJ4gJlwr693nbnB6v4Q+7rVAdd1gM62HTyokpiL0gLSFaIiGX5T74brgcFekdhv
	ZnlCxpzhmhN4XZoZZ3ytNjo1ohwrAlO4U4yodCPQBngOqI+pp3UIyourpVK3KC0oU38Hbx6gLII
	VCO4d3UfGTwmK7K9VeY7/Qh5m6iSOoTw26y+oIdlEESgw
X-Received: by 2002:a05:600c:1986:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4520135618bmr66669585e9.8.1749319141330;
        Sat, 07 Jun 2025 10:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES2jinM7KszDyipSIbZ9eFBb1F0Ocbr6OW9GFOiirbLBd9I0uI7j50qo6ztekZX9O40Pe3Mg==
X-Received: by 2002:a05:600c:1986:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-4520135618bmr66669455e9.8.1749319140905;
        Sat, 07 Jun 2025 10:59:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:9f00:3bce:123:c78a:cc8? (p200300d82f4d9f003bce0123c78a0cc8.dip0.t-ipconnect.de. [2003:d8:2f4d:9f00:3bce:123:c78a:cc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532436668sm5194505f8f.54.2025.06.07.10.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 10:58:59 -0700 (PDT)
Message-ID: <e4d9e46d-37c7-478d-b543-07ac91413e5b@redhat.com>
Date: Sat, 7 Jun 2025 19:58:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /proc/pid/smaps: add mo info for vma in NOMMU system
To: wangfushuai <wangfushuai@baidu.com>, akpm@linux-foundation.org,
 andrii@kernel.org, osalvador@suse.de, Liam.Howlett@Oracle.com,
 christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250607165335.87054-1-wangfushuai@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250607165335.87054-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.25 18:53, wangfushuai wrote:
> Add mo in /proc/[pid]/smaps to indicate vma is marked VM_MAYOVERLAY,
> which means the file mapping may overlay in NOMMU system.
> 
> Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
> Signed-off-by: wangfushuai <wangfushuai@baidu.com>
> ---
>   Documentation/filesystems/proc.rst | 1 +
>   fs/proc/task_mmu.c                 | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2a17865dfe39..d280594656a3 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -609,6 +609,7 @@ encoded manner. The codes are the following:
>       uw    userfaultfd wr-protect tracking
>       ss    shadow/guarded control stack page
>       sl    sealed
> +    mo    may overlay file mapping
>       ==    =======================================
>   
>   Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 27972c0749e7..ad08807847de 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -970,7 +970,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   		[ilog2(VM_HUGEPAGE)]	= "hg",
>   		[ilog2(VM_NOHUGEPAGE)]	= "nh",
>   		[ilog2(VM_MERGEABLE)]	= "mg",
> +#ifdef CONFIG_MMU
>   		[ilog2(VM_UFFD_MISSING)]= "um",
> +#else
> +		[ilog2(VM_MAYOVERLAY)]	= "mo",
> +#endif
>   		[ilog2(VM_UFFD_WP)]	= "uw",
>   #ifdef CONFIG_ARM64_MTE
>   		[ilog2(VM_MTE)]		= "mt",

That is mostly an internal-only flag. Why would we want to expose that 
to user space?

-- 
Cheers,

David / dhildenb


