Return-Path: <linux-fsdevel+bounces-52873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE5AE7B62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CE01BC802A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4100E288CB2;
	Wed, 25 Jun 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvQLLtbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A92882CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842205; cv=none; b=fUIbGQHDJ8F4EnjWMEB3cLu1jgs9t9UqYOq9bVlG3KJEr9g7+7/cJUPSHopTdEdIVfhy8mEA8yL1S3einmeDIQCApMfMxa4qKWYFMAAPqgtxXT0ayIiHxr7IbJJEfKqAv3rduwhhve6xrO5npYLOYDTOcG3Dgj22Dye7YJjR9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842205; c=relaxed/simple;
	bh=JW2s+9q4qPQQc93v2PMvhmcFWFvDhURahsiJZzoXovw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHg0f0TSLg8IP+lpftILnnDY6nKFR+DT1p49cSNp8eJDs9v3mOgN9VaP/L+ZyNaU2txDrkmmyxLME+tGuZ2yrp0a1HYsKbratND1MnHCa/kLLhTl4L3rp3+41cP60+qCqGBkpop6heDEj1QPkjP+a34gJnvwhDUCb6GZl1EJE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvQLLtbx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750842203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j6SPvABO8EkhAEJk1LKxiZOae6QeSJKDl11RtcagWeI=;
	b=SvQLLtbxxB8PayrnXsNB63zlNLmANeKdFy3/S5ddQiqyOqD/IsjdcYpRtlNZmD6Vb80Kwx
	1CGITJni43sbTWaW7eD6axTQYVFXtgvOxfeej7A1erruQvyeIDDTEkN7cRctM7s6FORQNj
	QFRmRqRd+aqym1VSrVEdNKUEdk0JMXA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-8dRM5yhiNzqWTcGTXEKVOg-1; Wed, 25 Jun 2025 05:03:16 -0400
X-MC-Unique: 8dRM5yhiNzqWTcGTXEKVOg-1
X-Mimecast-MFC-AGG-ID: 8dRM5yhiNzqWTcGTXEKVOg_1750842195
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so706651f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 02:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842195; x=1751446995;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6SPvABO8EkhAEJk1LKxiZOae6QeSJKDl11RtcagWeI=;
        b=fiBU6Sfceri/12ffocUKoc+zbmZfrGGdb36f562DXs1Si4A+bs6i9ukCp4E/e2Y9Or
         ocKc9HTtI7fIEROUqt6p42QeN/NVmtctz/b2pwnl+WOJI8jPp72jcue6pcSKxgpUBvkl
         3AqZY2foGR5YqoiBz6yOO9tNsTcjfQB3pfLVDJPOz8e9YJYgk/ARG3vXwyztvGAuvfe1
         mgwyvpvURvkj66MPH5ZCAjY2kpjKXlpGBi8QlqsGy8iIRyaqY2R7f3RAYEVMfZ/Rh6MQ
         T8sRnE3tLqcMjV9Y844deS9hqa0ekDFgDnj1eRvxDh3kXKutxgCLW4tXQBeby1/JUzXr
         IPJg==
X-Forwarded-Encrypted: i=1; AJvYcCXgiVBUZp4JOllPD+uu/qsfOaGObzabkIFuDZuwFUFJv4kGuGXrV1R9sRi7N6izVEpoH7ogceuALdlDWgk2@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkN7vWWnlW2TRUfSOlCgOsuC/xbgwmOZQDAb9dlRAlNTttkF3
	9LxhEq30YZftNr94xmAui6yKB98fJI8QYXyxSYAfMSWLltpNmXxSLj+TxZFz/DuzZg/EA8aX+7c
	VZtXB5gojS+Sv1yRo6gC4joTOX7V3SyYMOr6XQzEcUuuFEvFVFgIcC/dRGA090pQfaXg=
X-Gm-Gg: ASbGncufXlCcf6Evf8dose6q2bUrEDiI+OkchsDW7u076/Alst2aUEkGBPTJHjq0qa3
	5Cp8+1TkgWGmTbn0/6kBQODS4DF6BZu9xVV63t4vapmSBzujDj9yF8PgllBzvP3XyxA2qqVbv6k
	ezNUAR+tteSJQltttzLIgkA0YpGarrqKdy0DfEER87DyfQIQoqMm+iXUggXzv8gYF9B3emtqGUJ
	oNwrD1+wgmE+8oNmUNsmH/V/65BOadW9BMNK0VqapdctnCnw9tB36y6l4PZMe4R5pEhtv0mibHW
	fqXc4RH5ArTmWocCsz+FtveXsBLTUZiZS4dxERr4k3yHtaUEZbAq8Y6X4FPgVX7zmIR1aDfHfTs
	L31b+qtKlUm3oNUpszCN63SrNC28xVHfHecBs379YATGJ
X-Received: by 2002:a05:6000:2709:b0:3a4:fe9d:1b10 with SMTP id ffacd0b85a97d-3a6ed646c16mr1271832f8f.45.1750842195158;
        Wed, 25 Jun 2025 02:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHazW5nWUfQCM5Vf0SuwnpR0088kA+f/uiZKl6Om44U23eQf/ruKZPkuQodKAJMBqp+4oD7Fw==
X-Received: by 2002:a05:6000:2709:b0:3a4:fe9d:1b10 with SMTP id ffacd0b85a97d-3a6ed646c16mr1271782f8f.45.1750842194712;
        Wed, 25 Jun 2025 02:03:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d342sm4022122f8f.21.2025.06.25.02.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 02:03:14 -0700 (PDT)
Message-ID: <74acb38f-da34-448d-9b73-37433a5e342c@redhat.com>
Date: Wed, 25 Jun 2025 11:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/14] fs/dax: use vmf_insert_folio_pmd() to insert
 the huge zero folio
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <20250617154345.2494405-8-david@redhat.com>
 <cneygxe547b73gcfyjqfgdv2scxjeluwj5cpcsws4gyhx7ejgr@nxkrhie7o2th>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cneygxe547b73gcfyjqfgdv2scxjeluwj5cpcsws4gyhx7ejgr@nxkrhie7o2th>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.06.25 03:16, Alistair Popple wrote:
> On Tue, Jun 17, 2025 at 05:43:38PM +0200, David Hildenbrand wrote:
>> Let's convert to vmf_insert_folio_pmd().
>>
>> In the unlikely case there is already something mapped, we'll now still
>> call trace_dax_pmd_load_hole() and return VM_FAULT_NOPAGE.
>>
>> That should probably be fine, no need to add special cases for that.
> 
> I'm not sure about that. Consider dax_iomap_pmd_fault() -> dax_fault_iter() ->
> dax_pmd_load_hole(). It calls split_huge_pmd() in response to VM_FAULT_FALLBACK
> which will no longer happen, what makes that ok?

My reasoning was that this is the exact same behavior other 
vmf_insert_folio_pmd() users here would result in.

But let me dig into the details.

-- 
Cheers,

David / dhildenb


