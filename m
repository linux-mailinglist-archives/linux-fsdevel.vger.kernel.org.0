Return-Path: <linux-fsdevel+bounces-18099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C798B586F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D34B1C232CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC170CCB;
	Mon, 29 Apr 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES4kUdoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A05479F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393381; cv=none; b=GrTZWkG2nnM/Hl1V5MhYL+/s1x5S61227NoA47A8ey2TeFz+JPmqMgey/ttVsgIO0FAHX+Scj+/eBI++TAv6iWLzEznABdWrRNh/x7PsbBAac/A5RbM3lIEb7EFyyisPEq8CyPI5FPRerOhwue5bU4FfTsjrJ0pBKZ4iyzgMfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393381; c=relaxed/simple;
	bh=pp5z7gcrGnaGwKaBRXi44H/aGhRxYMPaPhglBYowj/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEiRMlrhS1gKxVo0lBMSgCTHkgTZ35ZQl7Z4jLqxKmoc4eYlYmx0k87e9h7xo1ywRgctzQ6Rvjb3GCZcZzrpU22+zUCGkJMXfHZMlJpl0FdiONVvQWRILBb8EBvgZ/qj2azpNdzr208a5EdqPTlOtTAKRLCTQW0e6RpSQ8Tp+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ES4kUdoj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714393378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TXIsKRQbdU0Npd8srku3UtewvoDSpR6hr7lmEACnXD8=;
	b=ES4kUdojtQScTNJl0kCJb/QzWJxinsXQlQMv9UJrvIIW63AWmzKvFp58/0776zcZUD3ptO
	hcDzW05XpFSy17P98OQghXBFXNPuZipmIOH/y333aeaDSQ8dlhYJSr1SwX6KRMrmcifczW
	dCFz7TEC1EIW1giFf28JG5dgcKTY2xA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-XabmC4ZMOs6m9Wi2dKJ_3w-1; Mon, 29 Apr 2024 08:22:57 -0400
X-MC-Unique: XabmC4ZMOs6m9Wi2dKJ_3w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416e58bdc1eso22792255e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 05:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714393376; x=1714998176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXIsKRQbdU0Npd8srku3UtewvoDSpR6hr7lmEACnXD8=;
        b=Zm+0lnhebu3QHx1YNjLPyQJejhGVI8c2seo4bOuZytg8txjhFukSCngc6k9/FtQeLj
         rW6Qw1Bk9CYhhTTE4Y7wPmff1I+WMb1i9uSPKIoL6Y9bJ9ti2Ex0wyLJ+8qeU3ayO3PL
         QREn6mRVFtV39cuOk0VdGUZ/ZfGJ/L5ac0yO7/fwbk+lj2bXpzUA+y5cY8GKmn9VlUNx
         /x8NB3cHWe3bhRS/t9x+ZmLbWoaNrgWaKj3CBC5UWZxq14b4PltD9K4/Noi1bUYUi3z6
         6Gn+PJCsVa1aB/nuGEhPRN3UCFUp/uiB4QYIJcW+nKd17LPPEFpm4XiRSL8fNechwTk+
         f01A==
X-Forwarded-Encrypted: i=1; AJvYcCU6mgOYbOSwfOcBebhcC+IWjaMeB6W0/AjMT7ZzxxcpV+WgHOgbXxM8VWgp4uFHYgLXsEUreXRtiTc0JT52m6VoG567eE+bNhgzueUHWA==
X-Gm-Message-State: AOJu0Yyf1R7X2ddOD2Ehna1OfiC4sTcofbzaqlybvKSSc+8vRwmuOseS
	4g8w3Q5iLY92Zj2oyDWJki1JEmaWv0xVC6wFGVEYbqifwRC8ArMW57bpNgwB7G/52YusEqOkuww
	Ms2/Afu9ScCfXrtPSTe0gTbK8NOEcMhoJbaiFD24HK7w93UBC0jqHDDD4noighXk=
X-Received: by 2002:a05:600c:4751:b0:41b:eaf2:f7da with SMTP id w17-20020a05600c475100b0041beaf2f7damr4897303wmo.6.1714393376141;
        Mon, 29 Apr 2024 05:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF90uy/1yEHJIMmrMP0gsnV07KdzYkWUQDKGA3y/CKgdvIyoY89+KIPJymJ6auPtsfVnfGsmA==
X-Received: by 2002:a05:600c:4751:b0:41b:eaf2:f7da with SMTP id w17-20020a05600c475100b0041beaf2f7damr4897284wmo.6.1714393375688;
        Mon, 29 Apr 2024 05:22:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:e700:f1c5:285b:72a5:d8c8? (p200300d82f26e700f1c5285b72a5d8c8.dip0.t-ipconnect.de. [2003:d8:2f26:e700:f1c5:285b:72a5:d8c8])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0034af40b2efdsm21226594wrs.108.2024.04.29.05.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:22:55 -0700 (PDT)
Message-ID: <cfc6b006-ef6f-4099-b29a-fba30bdbd74d@redhat.com>
Date: Mon, 29 Apr 2024 14:22:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/proc/task_mmu: Fix uffd-wp confusion in
 pagemap_scan_pmd_entry()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240429114104.182890-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 13:41, Ryan Roberts wrote:
> pagemap_scan_pmd_entry() checks if uffd-wp is set on each pte to avoid
> unnecessary if set. However it was previously checking with
> `pte_uffd_wp(ptep_get(pte))` without first confirming that the pte was
> present. It is only valid to call pte_uffd_wp() for present ptes. For
> swap ptes, pte_swp_uffd_wp() must be called because the uffd-wp bit may
> be kept in a different position, depending on the arch.
> 
> This was leading to test failures in the pagemap_ioctl mm selftest, when
> bringing up uffd-wp support on arm64 due to incorrectly interpretting
> the uffd-wp status of migration entries.
> 
> Let's fix this by using the correct check based on pte_present(). While
> we are at it, let's pass the pte to make_uffd_wp_pte() to avoid the
> pointless extra ptep_get() which can't be optimized out due to
> READ_ONCE() on many arches.
> 
> Closes: https://lore.kernel.org/linux-arm-kernel/ZiuyGXt0XWwRgFh9@x1n/
> Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


