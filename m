Return-Path: <linux-fsdevel+bounces-17125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5878A8300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598AB1C20FD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAA13D53B;
	Wed, 17 Apr 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csh5bW64"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C913CF87
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356298; cv=none; b=NvJg1MtsrB4/o51uSgmyPw5YqGuXoXqWWrhDoC2n1e9wHq9NO0iYrRy20toTIzHhB+Rtqo0uh8zkRLCH+ESMvNgA501laalXCqkiuesekKP/waBpOaI0HIGJwM6hVnxaNk8e0gD5HLwZtpmzgMAR6HLpGmZbaaEcu3s0cDDnRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356298; c=relaxed/simple;
	bh=x+uOmS4px3uisw7WCSJE0PyPJcNxBj0VAokAj5V/jd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBUi7Mz7vHFP8RQ7PU1nu3P2hYxuh9SlaeAaQKe0TInrPLMN9LdJ3cxy3Y0Z0gq/rEsBa53AuzuVvtIFvNXncT71OYIQiH780jgR4QGN8qDx+9q0EwG4Msd0X7Add7etVtdQj9lTJvQNYIrPwz8PIHBfKJJc+8kjYckPgq1p/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csh5bW64; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713356296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Mw1O18gbH7ZpAoJygnjuD6cxPj3U80IsZiWOLT2eTIM=;
	b=csh5bW64IPeH+mQGp5IiDFniLimjDXkRn14efXqFYyXueVUYkVPvaiPnPNSpah6MwsQZjZ
	PK4oWMsPihDSkrfN7Xo1z1Emt2pLi/DsSpkJ8SJihQVexKDsAzrGZZvrp+4JyTnprfrm7G
	hH3nxGJgDFO9pV9Rxm0gMN0gB+Fi1s4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-E5PcaPWCOsuCZ0QXZzO-7g-1; Wed, 17 Apr 2024 08:18:14 -0400
X-MC-Unique: E5PcaPWCOsuCZ0QXZzO-7g-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so7276119276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 05:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713356294; x=1713961094;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw1O18gbH7ZpAoJygnjuD6cxPj3U80IsZiWOLT2eTIM=;
        b=nGNLVG8Zi3rKpDhD26H5+weT+ZimV4X8vF5wJFVXCDfBZ4yD0g49/kc98czNZ+77EI
         ezsdw/N3NmkrbadLvlavV1gS8EZIO4LX2bGSWkcBPrxRNawo9pH2NIp1RiAo2gmOfBp4
         Gpz37KlkBmOWzBN3gkrl6tOU8vD+JV1Foqa4ljwxoe91aKbI7S6VNqAFgLuPZNdJ60KF
         rdyzcxBHVEgBrYlLvNLp7Whg62NJQABj6QPQUm+y6z7ubkcUO6bB3xo4Q50I5igRiLUd
         entf1NX2KP1otaDeim1E123N0r2UvTdmqR2jpFIO8L/UvdRJX1cthQBOVX93twNe2ond
         YWzg==
X-Forwarded-Encrypted: i=1; AJvYcCXtU0EOvXdfASQa2JXxjB0VZGUzwpcKiNWR9VFHMsmu7x/1rwwyOYuclTxW5DO2sWnGhiLVYoKBXXxXfeHmpnyA8+VNYG/av57AkJyygA==
X-Gm-Message-State: AOJu0YzZozWLHEVBs2OLMsI0peLTFrhYNJ1QpAnTyR7aSSknSY0utwlt
	DfK+b+nPDJw2MM9l+7J8k6Iu7uA41XpIf0s++4pVhUsNL30NGVJZdoENBgTlhnszCF+kqm9hhxa
	Eau6x3yFnofou0VuLenDL/KpLBVc9GnhoNhYLVASgsqz8IQpIeve/ZSW6Mtn1snM=
X-Received: by 2002:a25:8141:0:b0:dc6:cbb9:e with SMTP id j1-20020a258141000000b00dc6cbb9000emr14945224ybm.41.1713356294157;
        Wed, 17 Apr 2024 05:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd+ZmfUuFEEA8xWILQJpSD9kj6k2fm0H6n2sACdE/Gv3NryInJq0B2TXKP433mn3U53V+NZQ==
X-Received: by 2002:a25:8141:0:b0:dc6:cbb9:e with SMTP id j1-20020a258141000000b00dc6cbb9000emr14945199ybm.41.1713356293856;
        Wed, 17 Apr 2024 05:18:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2300:653:c844:4858:570f? (p200300cbc74523000653c8444858570f.dip0.t-ipconnect.de. [2003:cb:c745:2300:653:c844:4858:570f])
        by smtp.gmail.com with ESMTPSA id o15-20020a056902010f00b00dc22f4bf808sm2839357ybh.32.2024.04.17.05.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 05:18:13 -0700 (PDT)
Message-ID: <209b1956-a46f-41aa-bec1-cd65484f36cd@redhat.com>
Date: Wed, 17 Apr 2024 14:18:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fs/proc/task_mmu: convert smaps_hugetlb_range() to
 work on folios
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
References: <20240417092313.753919-1-david@redhat.com>
 <20240417092313.753919-3-david@redhat.com>
 <Zh-7_0hDIZKWSDNB@localhost.localdomain>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zh-7_0hDIZKWSDNB@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 14:09, Oscar Salvador wrote:
> On Wed, Apr 17, 2024 at 11:23:13AM +0200, David Hildenbrand wrote:
>> Let's get rid of another page_mapcount() check and simply use
>> folio_likely_mapped_shared(), which is precise for hugetlb folios.
>>
>> While at it, use huge_ptep_get() + pte_page() instead of ptep_get() +
>> vm_normal_page(), just like we do in pagemap_hugetlb_range().
> 
> That is fine because vm_normal_page() tries to be clever about  mappings which
> hugetlb does not support, right?

Right, using vm_normal_page() is even completely bogus. Usually (but not 
always) we have PMDs/PUDs and not PTEs for mapping hugetlb pages -- 
where vm_normal_folio_pmd() would be the right thing to do.

That's also the reason why hugetlb.c has not a single user of 
vm_normal_page() and friends ... it doesn't apply to hugetlb, but likely 
also isn't currently harmful to use it.

-- 
Cheers,

David / dhildenb


