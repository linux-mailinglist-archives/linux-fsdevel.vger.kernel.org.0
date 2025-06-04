Return-Path: <linux-fsdevel+bounces-50610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7AACDEEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BFC172D7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F15928FA9E;
	Wed,  4 Jun 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELu2/T5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086B31C5D62
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043425; cv=none; b=jKqt9IpCAa/rTyb7pdZyihEBuGdoMtBL5r0v0/5plgFutWZ7A3FMddwTlhiCkpEEohn0OXYQZX/QhKBHJoBbVUrhkjOW7Cxf+WQOzOp+JXF1NxDgDXTY+v42L0h1hw9Hlrr5UCFCxnJdxzneXgAO4YLWsQI2G2GInroE9YJLMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043425; c=relaxed/simple;
	bh=QbkLHxisoYc2AWDpo32sSP+B4kbWnBVqELZ1Z69vVEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oks6rjFPzXiKNVyyal8C3JsQNcc/Dh5sXMJvY7ZuJvv2r1O9kUjZYXKWkJQIuJt+BKMKP6ITLDYwLtB7B1/8xCqNLBYv6RtfSo7he5Sk/H4GNHVfzLGVZwIkvf73HLIoHPUr/60alVv+U7TknRcCp05xJ6uO4hAlmtwZGan6h5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELu2/T5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749043423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xww6rsG/Rs20JT8s4hDiVuCO7S3KnAU+7K5dPc6U7A=;
	b=ELu2/T5X2nR2KzxzG2fP1vcffEzbU3VDXPcQ6YaSvB8Ylak/UHH3HgeMePUjBQszZpK+7F
	vNGf8fi7rgz8IVeb1uff/EG/RE9HCdcOxYsZLUYQ9/GjS5WO91B/+nhIdk/Wx4iCMNT6u9
	Zcu++rHH39T+CeB6QTbEhPqRQym2wgg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-QA9se-omM5-XvJ9zI5AA0w-1; Wed, 04 Jun 2025 09:23:41 -0400
X-MC-Unique: QA9se-omM5-XvJ9zI5AA0w-1
X-Mimecast-MFC-AGG-ID: QA9se-omM5-XvJ9zI5AA0w_1749043421
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-440667e7f92so47671685e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 06:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043421; x=1749648221;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xww6rsG/Rs20JT8s4hDiVuCO7S3KnAU+7K5dPc6U7A=;
        b=xG9gGGwMXMnj+EQ6LWPWNLpJDOG90oNxjW16yl7PKwcK9ng6ChalB6sqJ7b7AY2h8k
         tZnqW3X73fV7fqBciMEhrFaeGhNlhcMILlSfipMOT8AXmHgSyBUYr9IY3zdWlT2sFLHy
         V178QZrQEt//50nhLrorq9k0rGpwGm9nmWkuDnMfgtI4mcAeGtvb+bB7hxw3ON6OSl8X
         9Xp3vvf8gwgW0Y4X11i0+RN3R5x38lnkXIjpWcaQV5QiFNkcgvSzg8/I4W4hsLKKNT5A
         bonvaH8NQ6igYf9OybkEmo2EU5pKLMBeDy7PcDbm74dDyzbo3ahGKU3bQkAZ6pFQdHss
         6CoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1p0hK5W8Eg5TqM7R205dlIUwso1mOD5FIarB1Y8VdUJquxp73CS3E7M8tEr/ZgdHoKgLRVRHKKnKImfc3@vger.kernel.org
X-Gm-Message-State: AOJu0YwwS4D+h7xPSfUOXS3VH3X3EaslwbYjNL0lIDpZDoDV/qXbcKz/
	RCrvlu2p1zs+zY2ZjJnZgLM7R9AdbzENiF1n9EcsXfOzqo0Ix79xVqov/ZxFYlAIJsOR+TKFloD
	TXvFfyt8BTsu6qOQUTsPcFWyZH7WJvx3CorVwpjrEkRzwZuWJhAKM8UqAa/xVUwWigKo=
X-Gm-Gg: ASbGnctUtlEnuftiZ2c0RblNAwYSw6dkCcr14eOD5QMI/xjOxrjKvxst+Mn6iR8Q8kO
	VlAF8RQ0M3h1GQWQe6yCEhe3+05X/pDzmfcuFzNDBcp8NIb5LLtC9ycQE7AGRPmN+bkR8zzg9Ut
	oMaW1pmSPbMk0peQTrZJodL3srY0FL5WlHU7Yzgc/u31rpWGrWi4mlJOjdrJLcIxXRJQ3hv1cjQ
	VoEhqTbu2px/f2WC/ijViJybUOGNL07ybBkc50QtT6xvunnmnd9iQeS/IgRV98XQUNMfYAClJSM
	UmxYA1oaWuxh6e6j+FkaREO7Go23m9EzfVYdQ2dgyLCOO3eHQaEGBRfyPdoo/adpcRhsIH4Vbuf
	dyQhM/EPZfB2W+Xhlh+UoKzTsnxXzRFg7Yb25gyI=
X-Received: by 2002:a05:600c:35d4:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-451f0a63602mr24381215e9.2.1749043420598;
        Wed, 04 Jun 2025 06:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt1y4qRpeycuYRvcBiJBXWsI8Xumomuv0jyE3q2dCGUmvlFOrwHFLD+Jf3Br7pU3KswUcwzA==
X-Received: by 2002:a05:600c:35d4:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-451f0a63602mr24380875e9.2.1749043420071;
        Wed, 04 Jun 2025 06:23:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b92bsm21434591f8f.9.2025.06.04.06.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 06:23:39 -0700 (PDT)
Message-ID: <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
Date: Wed, 4 Jun 2025 15:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.25 00:14, Tal Zussman wrote:
> Currently, a VMA registered with a uffd can be unregistered through a
> different uffd asssociated with the same mm_struct.
> 
> Change this behavior to be stricter by requiring VMAs to be unregistered
> through the same uffd they were registered with.
> 
> While at it, correct the comment for the no userfaultfd case. This seems
> to be a copy-paste artifact from the analagous userfaultfd_register()
> check.

I consider it a BUG that should be fixed. Hoping Peter can share his 
opinion.

> 
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   fs/userfaultfd.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 22f4bf956ba1..9289e30b24c4 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>   		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
>   			goto out_unlock;
>   
> +		/*
> +		 * Check that this vma isn't already owned by a different
> +		 * userfaultfd. This provides for more strict behavior by
> +		 * preventing a VMA registered with a userfaultfd from being
> +		 * unregistered through a different userfaultfd.
> +		 */
> +		if (cur->vm_userfaultfd_ctx.ctx &&
> +		    cur->vm_userfaultfd_ctx.ctx != ctx)
> +			goto out_unlock;

So we allow !cur->vm_userfaultfd_ctx.ctx to allow unregistering when 
there was nothing registered.

A bit weird to set "found = true" in that case. Maybe it's fine, just 
raising it ...

> +
>   		found = true;
>   	} for_each_vma_range(vmi, cur, end);
>   	BUG_ON(!found);
> @@ -1491,10 +1501,11 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>   		cond_resched();
>   
>   		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
> +		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
> +		       vma->vm_userfaultfd_ctx.ctx != ctx);
>   

No new BUG_ON please. VM_WARN_ON_ONCE() if we really care. After all, we 
checked this above ...

>   		/*
> -		 * Nothing to do: this vma is already registered into this
> -		 * userfaultfd and with the right tracking mode too.
> +		 * Nothing to do: this vma is not registered with userfaultfd.
>   		 */
>   		if (!vma->vm_userfaultfd_ctx.ctx)
>   			goto skip;
> 


-- 
Cheers,

David / dhildenb


