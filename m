Return-Path: <linux-fsdevel+bounces-50611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914DACDEFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD93A73AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D7028FFC9;
	Wed,  4 Jun 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3xPktd4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95628FA90
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043483; cv=none; b=ad5msFt4KykFXpdRgP6wnKsd5+8fy1UWbGm5rsJ/U/lBQSsbOFQgfWsQPPyJFokN57zWGmYBmddzXRCAEjULtF+vlMlS6C/RksMd1qTHBC7fn9iGD+KXr1UDlCNF223UccbaJSGLGzbJB4F4+CMRT8xKchmFYMMjFPabaqewXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043483; c=relaxed/simple;
	bh=v1Ep1ucccoQBByAZCYErl/ukOngwbfZNujIPfr7895U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9hriZzDqwG3Wi1aiFQSxy5apbIuDapyt0ZN35sg1kTJxmwSOAXNCn2V6cjH/id8FnGbBuYYmtSW0yUb86rPkhdxIWCnAoaZorv9Gi7cto6pbyNVD/GYH1BigqsNsTV7qT025TrH7ic4fk4P86/V+Sbix6V5mO0oWo2C+k10VkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3xPktd4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749043480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l0HqXlhl/L2ezUF6gTT9X156Dq0f+cYoad9TrL2Oo3g=;
	b=U3xPktd4mb493NB0I4YVIqwcYG/nW4d9dPEUgfHgJe3BLMwyPYoA64dUjmf/UU+1MxRTRm
	n+co8XGM9/j2HO5Kl1oYbs9ArCj2cGQzEAynq/bofrjEV12x3bYlEMdB2uyuSaM6JQcqZy
	0odsZUgJg8OXjwIxYnW3OIVuTdukiRA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-kX5K9ya-OWuiX2uYO242eA-1; Wed, 04 Jun 2025 09:24:39 -0400
X-MC-Unique: kX5K9ya-OWuiX2uYO242eA-1
X-Mimecast-MFC-AGG-ID: kX5K9ya-OWuiX2uYO242eA_1749043478
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451dda846a0so23338695e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 06:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043478; x=1749648278;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0HqXlhl/L2ezUF6gTT9X156Dq0f+cYoad9TrL2Oo3g=;
        b=faJ2h4PdMaFUoayNxTnZ1hvfd2NACWLBxjzImQM+BIDGpuIS7w/ZPF4TyYcSb8uNfK
         YRwbtk4fQSIVPwZ6mw1x2ds7zDdecfIz7bQ5s1SJwyPGZlFyH4VN1Jvh3cqED9Z4Yn9v
         LwU58cRu5nv3vheYGB5laJnGWYDHmh7Tj6tlJBSx3xk+ij1rM22OWxfUR6OkfGPoxmia
         afWKVLRPTqsSpiaCAC7/Wuh2sLKkdZhE/So0bQ3kQnDCT8+bA1OMjatM278azT4zlXSB
         Iu0M5VQDxihf3asi/Z3euW1b303XMJWlSpMuyx8X4pro8D+EE6Uk22Psr25tnQDGzXsT
         VOCw==
X-Forwarded-Encrypted: i=1; AJvYcCVjA4LrZE0tYCXL/cJ6OvWFn36/kndQKa0jYPcHASaG0pH3hXDldugtjRU5pN2kBuTk+Y/0MrkL3PC9ODHR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jamQ4I+ZpiJK6zG/os4u2JE1ZXCSSOdwAAv2ZDEPiq87Vyjk
	DCwGg7CEy/GqQJ+dDfkTqcUKPv940m4huGTsY8pam0j+9qUq5hnbceU5b3OvYa7uaPZ+PSn6r14
	Lxrd8vdQ662ubuo9O1mKZV8TRmMSHsJzeJ+hGj090MwTOXzw6SN5I1dKPxreYxf6H7m4=
X-Gm-Gg: ASbGnctBh3woM1notUxMjDieqDJjdf7RyRrYPHoy58hjLabx/jSTwTOZnYsjXOKWkwe
	p23/gTiky2jBVSeKdwntuKa6c8duYsS3Pl006TwKaZvPYhfEIbG+Onlo3mkaOJjFr4z+/o99oNp
	EMnQmAwVi0atICGHRX84i/YK45WJCKeQWZ0OJsyavmnBXCI0zPHUwZk/DvUPUsbzeH5uUXxU//l
	5vHp6lDECvHHER+pTIZbusxyVbrrH4OHqxAp4z9q7xTN1HiUuX6z9zcHCcfoABZzdcpvXCYWUzM
	KTc0H5r1bUYF8XQzpTDcbL4bwtdA8QZ8HcPLGcXYzOV96XPoeWNwXJFYgYHdbidHNFI49QNP+Cq
	GKYsaPGfqyBk4grK41L4W/Sj8D3oeQ8iJuD6U3PI=
X-Received: by 2002:a05:600c:1c12:b0:450:d01e:78e1 with SMTP id 5b1f17b1804b1-451f0a9e635mr26402335e9.9.1749043478222;
        Wed, 04 Jun 2025 06:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd2/tBBQLTI+HBmAaYGGCI82okGi/UzuUQ9dQJX1wQTpqDCUh9d9UOm7Jw+PZsFTgsg4Z6pg==
X-Received: by 2002:a05:600c:1c12:b0:450:d01e:78e1 with SMTP id 5b1f17b1804b1-451f0a9e635mr26402115e9.9.1749043477857;
        Wed, 04 Jun 2025 06:24:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf? (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de. [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e3esm198995665e9.22.2025.06.04.06.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 06:24:37 -0700 (PDT)
Message-ID: <7cea73af-f25d-4787-89e6-cb42f5da169b@redhat.com>
Date: Wed, 4 Jun 2025 15:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK, and
 UFFD_FLAGS_SET
To: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-3-9c638c73f047@columbia.edu>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250603-uffd-fixes-v1-3-9c638c73f047@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.25 00:14, Tal Zussman wrote:
> UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET have been unused since they
> were added in commit 932b18e0aec6 ("userfaultfd: linux/userfaultfd_k.h").
> Remove them and the associated BUILD_BUG_ON() checks.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


