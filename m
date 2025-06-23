Return-Path: <linux-fsdevel+bounces-52612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8FAAE4858
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E93A2289
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339428ECE0;
	Mon, 23 Jun 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoExpPZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB762874E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691927; cv=none; b=BwmH/PYNtKWXlcVu/IZ7kXFnFksRGTAvNd/xQa8d/dcxwgEV5BSkloz6WpXscsRkXI+gliP4Re4TBgxY0Ag5y3h+lb4QXfWgGzP6eYWK7nUZdJuvhJZVLaX67039QFVuGb7zVqkwZ/iSfDYN1Z13asTvybT5bS76VVIOAU0u4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691927; c=relaxed/simple;
	bh=gJwaVQqUHlErBEsLdXY9w+gTtoIGTFRPTPwWEc+SW5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgCprODFwSi/XvbBavndr8CwuJctnmr9a7QKRC2meVxDZZWvb0yIyOUdtwqSdxV6I3bbPhMn2DDRBNELgD90aw3Gu4C0DDyCsEdB7pqh/y8p5fFLqdEVIR3EnZjPvzkH0uPuBjFDhHaU43N17xL8lpjca13h3wfkjAY1ZvSg00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoExpPZg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750691923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k1wU2T2mz3GllatNW/t8S++3vMHA0TZu7Q4Rti0tFD4=;
	b=NoExpPZgkQroG+X9oYmi+xmYq9HHpHUDJ6Duhu17kKIiouUbfTb3S8T7LwsujER7gjWaYq
	LJw5PKrj/AZaSX+WDlC6JlcDcM1uojGr0NZHguDITPofJWgtsP3W13B3hyaZt28VR6dBdB
	x4VyFAqNExh7BGS2qITLzlcGJSexqNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-Xzs-Fy2QNeGITHnqOo474A-1; Mon, 23 Jun 2025 11:18:42 -0400
X-MC-Unique: Xzs-Fy2QNeGITHnqOo474A-1
X-Mimecast-MFC-AGG-ID: Xzs-Fy2QNeGITHnqOo474A_1750691921
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4535d300d2dso34645805e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691921; x=1751296721;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k1wU2T2mz3GllatNW/t8S++3vMHA0TZu7Q4Rti0tFD4=;
        b=ltJ7x9oTJAZFTCMW1ErVP2+aNJFumYwc08/C0eztsmTYWre/A0IXlxc1AbZ1H20QJR
         eNETPVM+uBm/sh4hQBpMPTf5PExmSn9+FmANhbI4nN51hxag+J/D623Or3GSYVl+zizN
         qvS057dzyxwRIXlkUcmQtrmlYYHcxg5QW27/sz0BF2tGxfXdNWszh2NvT26/9AtfxQS0
         jF6jl/7XcgHfljeiDqgQsZoEgoEf7MIW3ZFpRevlRgNLGyHztDDOC0fCrlb3HZW9SgLP
         Cc52NEBoVanBGuV/G4H9C+ioWPcxUtNjxYGR3Px0HplR+tO6fzfwH9JSBCVpikCKagLG
         FwLw==
X-Forwarded-Encrypted: i=1; AJvYcCX9D0RYflPKPxSFz00uF3hCDfUReNdKWsYpUmDfELB1iKT6Jgz0Qpgtp/rB3lnc7wfjvIhTGC3QZ2J1yt7m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pAhNDH6YC7t7rKz9jgU6beVqt3q3GSz7DpHv8X5VT8b5hJhS
	UhBlfMtwdVwswwH1k6EsmJ1UXXNkGv5P6ywj0e6KqCsPx/h4gJZpLU+E0GfaEUd4al0Gr4bbZhP
	0aJr/tZQrLWpigzCJ2jaZ/c0fe3xMybKD4K5ezcFVUx0yVuNRbJHZ3vFZQJP635kYxnfcKMcjXF
	5X6A==
X-Gm-Gg: ASbGncvqIhX0qAjRy65Ks6idxjavm8yRnZl/a5ANMhMz+xn2UQJMQjEA2HLF83Xa40n
	S/a49eeoI16P1oZVHBk5H5FyLuAXczRE37Oonh+CzrQsYeB/Kqk0ldqenqQNnSgNejrzd5rKbfb
	u39fbV75NWKQ2EnhtxDFolwn+LkAAE3o88IS1E0GYCxB4YieTj8yV9uvS9Mm0cgeVqTcHi1v850
	CGjGcGZ+OX8oqKgTKh2/rMAVR3Z5byFTGRhn12kbPILCbAWLtiQqHV01a7+OvhaOGqYpAKXRfCE
	aEFQL0gdtnBICLCGkMbLf2qnI9eYARZi4inXX7W1LbASrM0AZh+7dYaePaMgTg1rGqCn3vDsphx
	DTKnv151LWP/BC1X5L/Q7QyUy5VZPojJxs6GJdyf76F2N/nLWTg==
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id 5b1f17b1804b1-453653d4544mr115343155e9.7.1750691920935;
        Mon, 23 Jun 2025 08:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH+ZVAZOw0Wpmv/YKR5ciOYY8UdHT8U+JqBcB92kwzEJvnZA+8Jn7mOJ3GReL6tgFcTr6q+g==
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id 5b1f17b1804b1-453653d4544mr115342885e9.7.1750691920486;
        Mon, 23 Jun 2025 08:18:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647071f4sm114418395e9.34.2025.06.23.08.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:18:39 -0700 (PDT)
Message-ID: <bada8934-5b94-46f2-b44d-4d75e630a4d6@redhat.com>
Date: Mon, 23 Jun 2025 17:18:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] userfaultfd: remove (VM_)BUG_ON()s
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
 <20250607-uffd-fixes-v2-2-339dafe9a2fe@columbia.edu>
 <b1c61317-a17d-4ca0-88d4-d22e6b536de6@redhat.com>
 <CAKha_soyfjVpjrP9L0UxMwdH9HK5Gy+fin=XyxZt=34JaFUL=g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAKha_soyfjVpjrP9L0UxMwdH9HK5Gy+fin=XyxZt=34JaFUL=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.06.25 01:10, Tal Zussman wrote:
> On Tue, Jun 10, 2025 at 3:26 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.06.25 08:40, Tal Zussman wrote:
>>>
>>>    if (ctx->features & UFFD_FEATURE_SIGBUS)
>>>    goto out;
>>> @@ -411,12 +411,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>    * to be sure not to return SIGBUS erroneously on
>>>    * nowait invocations.
>>>    */
>>> - BUG_ON(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
>>> + VM_WARN_ON_ONCE(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
>>>    #ifdef CONFIG_DEBUG_VM
>>>    if (printk_ratelimit()) {
>>> - printk(KERN_WARNING
>>> -       "FAULT_FLAG_ALLOW_RETRY missing %x\n",
>>> -       vmf->flags);
>>> + pr_warn("FAULT_FLAG_ALLOW_RETRY missing %x\n",
>>> + vmf->flags);
>>
>> You didn't cover that in the patch description.
>>
>> I do wonder if we really still want the dump_stack() here and could
>> simplify to
>>
>> pr_warn_ratelimited().
>>
>> But I recall that the stack was helpful at least once for me (well, I
>> was able to reproduce and could have figured it out differently.).
> 
> I'll include this in the description as well. Given that you found the stack
> helpful before, I'll leave it as-is for now.
> 
>> [...]
>>
>>>    err = uffd_move_lock(mm, dst_start, src_start, &dst_vma, &src_vma);
>>>    if (err)
>>> @@ -1867,9 +1865,9 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>>>    up_read(&ctx->map_changing_lock);
>>>    uffd_move_unlock(dst_vma, src_vma);
>>>    out:
>>> - VM_WARN_ON(moved < 0);
>>> - VM_WARN_ON(err > 0);
>>> - VM_WARN_ON(!moved && !err);
>>> + VM_WARN_ON_ONCE(moved < 0);
>>> + VM_WARN_ON_ONCE(err > 0);
>>> + VM_WARN_ON_ONCE(!moved && !err);
>>>    return moved ? moved : err;
>>
>>
>> Here you convert VM_WARN_ON to VM_WARN_ON_ONCE without stating it in the
>> description (including the why).
> 
> Will update in the description. These checks represent impossible conditions
> and are analogous to the BUG_ON()s in move_pages(), but were added later.
> So instead of BUG_ON(), they use VM_WARN_ON() as a replacement when
> VM_WARN_ON_ONCE() is likely a better fit, as per other conversions.
> 
>>> @@ -1956,9 +1954,9 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
>>>    for_each_vma_range(vmi, vma, end) {
>>>    cond_resched();
>>>
>>> - BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
>>> - BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
>>> -       vma->vm_userfaultfd_ctx.ctx != ctx);
>>> + VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
>>> + VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx &&
>>> + vma->vm_userfaultfd_ctx.ctx != ctx);
>>>    WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
>>
>> Which raises the question, why this here should still be a WARN
> 
> After checking it, it looks like the relevant condition is enforced in the
> registration path, so this can be converted to a debug check. I'll update
> the patch accordingly.

Sorry for the late reply. Yeah, a lot of that probably needs a cleanup.

> 
> However, I think the checks in userfaultfd_register() may be redundant.
> First, it checks !(cur->vm_flags & VM_MAYWRITE). Then, after a hugetlb
> check, it checks
> ((vm_flags & VM_UFFD_WP) && !(cur->vm_flags & VM_MAYWRITE)), which should
> never be hit.

Yes, likely.

> 
> Am I missing something?
> 
> Additionally, the comment above the first !(cur->vm_flags & VM_MAYWRITE)
> check is a bit confusing. It seems to be based on the fact that file-backed
> MAP_SHARED mappings without write permissions will not have VM_MAYWRITE set,
> while MAP_PRIVATE mappings will always(?) have it set, but doesn't say it as
> explicitly. Am I understanding this check correctly?

private anon mappings should always have VM_MAYWRITE. (there is no 
driver to really change that).

For other mappings (MAP_SHARED), VM_MAYWRITE is cleared for R/O files I 
think. VM_MAYWRITE really just tells you that you can do 
mprotect(PROT_WRITE) later, to effectively set VM_WRITE.

So if VM_MAYWRITE is clear, we cannot possibly write to such mappings 
later (not even after mprotect()).

-- 
Cheers,

David / dhildenb


