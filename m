Return-Path: <linux-fsdevel+bounces-52871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB218AE7B28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5668F3AEAC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F920285C9F;
	Wed, 25 Jun 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG5ihxhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF62820A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841970; cv=none; b=oskl1mcltPQ8/MCjWkIApt+f0hvrq3UqrLrpI0ke/2K2L3aubAVcDUzrF+f8Djfnv5pS3lo7w3bG73OABNqjOEJfqUkWcQGZUhqDSO1GU7j1FtCHgSYtvwwbce4wSx20CEVyMAwwwGaOa4C+X2iojbZcBGZAx2APHg2DtfuJLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841970; c=relaxed/simple;
	bh=LsTZ1xubIK1r8E3duqAkTIbapbM06jFjZcNgwDipAM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNOIeCzZtJnNBX69FUKgPI8vz+AGKRThpZX3pzPLlgssYZx/7h4nde5JKutHjLvld128Yua640b1WGS4qPgaoxdqgRTj5rzDncERryG/laMtYuWlBN4jIWRWKQOgV2Rk6eLKPz/ER2CELZ0F5mYH7GHSWop8KQqYqtU0QRFKdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG5ihxhP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U3Brvxz8MbiH6XgkZg4KphQbns9ecC7YJ1drbCD647Q=;
	b=JG5ihxhPqv2RVSlgSGK7JPMkVzCrnduftoScSLTC6C9n3fp5A8r1zQnjDv8xMtlgxPHWtN
	LZq0qssEH+ChUQ+UqHUZ3Sezo/IQkZvoVH1D+gF+2SZMZw4TieP85xSlz/xByFlYH9aiqv
	cN1e9hnXJGlKerjAgCGhPDkboCRe1sg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-0V49bYJOOoq98V_cWqJN0Q-1; Wed, 25 Jun 2025 04:59:25 -0400
X-MC-Unique: 0V49bYJOOoq98V_cWqJN0Q-1
X-Mimecast-MFC-AGG-ID: 0V49bYJOOoq98V_cWqJN0Q_1750841964
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so707212f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 01:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841964; x=1751446764;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U3Brvxz8MbiH6XgkZg4KphQbns9ecC7YJ1drbCD647Q=;
        b=Bg/ybDUXqmoj1gZO+e1SQfHGT0RG5jvkQDN6AoXZyb4/wnXfmdgDm/3uk7UK0P1P/d
         L1jZUFKU9q+BuerCK9lCCd/MUcEpAeLBUhobcEuVPOYxR93+MVAXxUqoQkQUj0bYFrbH
         lJx6p1fhCzhaxLOkATDRgTaUeS/tgiVcuTwuRIP2d9yuuWMwth6VemWqXtVK+td/35h4
         +n8ceW2HUwcTJUcII7s5ukV/z0fGv8k3LT+zQTUbkDl1X7obTlH1OyGMEMK2dCVpvO1R
         D3ppHWdE1MDxTgBT+aVvzygg5eHb74o4umUkGA9Y7m/kxTre+buv2TUFqmbQf0hYmI7p
         uDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMOVna5mJR0UGqmG8yYVSuglQWIbZ+OJ+jZPQOuthpdzuD2861lKtokGyCD03LQzkmQSia7tJUW6FHMoHL@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEn69k2DjAzxuM3opsaBf1x9nTX2zuUO6w49jYta/POhvpnRv
	DuaHg8GqugqOXVEaTc8vBMTMgny66JT6x4EWFWdhx7VIYBWkbejMFVQX4kzFmQLGSTkrBxRuYGK
	/7qYFMmqpP51N0kWvAfzHyhcjSS+qaxjRwkCeg27Dgri5Xm0tLz7H2KgoI4jqDt2yphE=
X-Gm-Gg: ASbGncu4hM3dvCpTjMJqh/X5iys1S6hfQR+UfH8CcoO9+EC8w3rsSbdJkvDu3S3Q2qO
	GM0+4BFrUBfJYl/7Qe3AAOqgL+bpCiPtaztczu+w1XrXUm7xti5STGMrioVhHxHzDT6bSdhKmgn
	d5ITjx2DB3+NBKna+VTsaewCs/IgsI43ywBPnRDX93NMvqT7/3g4uBsdeohmZKtCfAEJ9XEhBhQ
	SaQvoC/Gg4qAAx8BcJa8UXiES9NQR/36TieXSc8iRCFs5WoD5+6JN8UDiPn/Tkc8HVxk35G/HPQ
	Ztd+3vkF96S/66WaI8MsRe+UoUYVbnGqJVRL8svUYnODvGeHCTulStYKJIx8Oazy5JprhEC+SO3
	qKM0yMHQslF6esj43lODRqv88IYyzI+Rdxq2kD9Yfk+La
X-Received: by 2002:a05:6000:2006:b0:3a5:52d4:5b39 with SMTP id ffacd0b85a97d-3a6ed5b8f3bmr1356708f8f.8.1750841964490;
        Wed, 25 Jun 2025 01:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmexdG/6iYRK1nINpdDcKN05wfIqOXNxWtd6lTUtsg3Wj5E7wNC+aoN6SEKsHkkqyrPMOE1w==
X-Received: by 2002:a05:6000:2006:b0:3a5:52d4:5b39 with SMTP id ffacd0b85a97d-3a6ed5b8f3bmr1356681f8f.8.1750841964080;
        Wed, 25 Jun 2025 01:59:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810010fsm4044551f8f.74.2025.06.25.01.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:59:23 -0700 (PDT)
Message-ID: <998ab0ce-6f11-4c0b-bc32-38fe2abd74b7@redhat.com>
Date: Wed, 25 Jun 2025 10:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/14] mm/huge_memory: support huge zero folio in
 vmf_insert_folio_pmd()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-7-david@redhat.com>
 <aFuxRv1zYZDjJdYh@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFuxRv1zYZDjJdYh@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 10:20, Oscar Salvador wrote:
> On Tue, Jun 17, 2025 at 05:43:37PM +0200, David Hildenbrand wrote:
>> Just like we do for vmf_insert_page_mkwrite() -> ... ->
>> insert_page_into_pte_locked(), support the huge zero folio.
> 
> It might just be me because I don't have the full context cached, but
> I might have appreciated more info here :-).

I can add something similar to what we have in patch #8, stating that we 
will change it to be special as well soon.

Thanks!

-- 
Cheers,

David / dhildenb


