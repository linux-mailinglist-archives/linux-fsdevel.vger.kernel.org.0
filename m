Return-Path: <linux-fsdevel+bounces-21412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077F90394E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F022AB25306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03247179951;
	Tue, 11 Jun 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwlDQo2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48698178CE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103054; cv=none; b=dvOOV71ZDsPF9lsk8RKNUYDzYiFkwN3EcHR4nedO0Zf6+ESchSbZibGjPX8ZFssRJzgb8YjXXb+7fiIFP+zLvuc6ndjnJpTfWePH33NzWY3XMt2ROCtH5mOBqBHlxUnG2jJFQ0ULPxlCvKSd6VR6MxK9hJhkdyYJKJpAV/DHsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103054; c=relaxed/simple;
	bh=gEu3DeLm/Cj4KzSje6vtm9+JuOx5buAoruQTENtwymU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzW9eFj2BZ9hxVVt20LL/trc+6kO1LCf98iXtM9ntziuf8qts6Zm9uNzfgEttU9WmNjIdgHdqEeH//7U/3nEZ6Qz5LCHlN1b7L9MpW8c300mCmTiwPiANnq1x/4ClXLrsFhwJ7q/njvGee/pIXDUdCu64n/I9Vm2eQ1UaANziKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwlDQo2n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718103051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3ysdFsrtDcDxrPLWReLHv5ssrGeZHQvSPRbBF339uAA=;
	b=fwlDQo2n354FCwVJLEo+hK85AsqxtkHoU1/+Oo9HseEAyXc5qr6NAf1PVHK5/YTFza6wxr
	uAuytm9Hlu6JrAPk3mrmNXFfnStpJrhyuhKeAZa+iKmUuaEhvn0uJBllzWzbIqrlCeHGTg
	7NtlRu2KNM1aj+6T51T2nDH1Y8eFfwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-lHEV5U5WMki6Vs__crbjAw-1; Tue, 11 Jun 2024 06:50:50 -0400
X-MC-Unique: lHEV5U5WMki6Vs__crbjAw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42117a61bccso40117035e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 03:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103049; x=1718707849;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ysdFsrtDcDxrPLWReLHv5ssrGeZHQvSPRbBF339uAA=;
        b=sa4Kpd81E/W7ZDeIe90KaetX3ltAXMcidUXqJUYvYndCkMaA7S76GFZmhdEklFJ+hO
         3a7BLRF2+HRzBh3xO/mk3nMRGt2Gdi3NjgvhHL0ByykO+jrR0pyJmuzz7YadgZyAiTO+
         5lE5MTh1DIQBZ5faYsQvB0Riv+3Pt4gwA056tmdqnqKNAYKOFem7mriHbovBWrhnvG1l
         5F4aeWBJhowvxoRP83egpOCYAx/OKd43vg/ZqQJVQzmU37+kieWMyft//56W2vWe/WWD
         QKXo6Q1pdjTg1C5aXCXrwzsIB1NQSJ2AtfVF6nzBk9pVshcZNLPQ26HbaTOGVHLU1Ijf
         XfSg==
X-Forwarded-Encrypted: i=1; AJvYcCWuO2BLYxlUYfMNA/5ayFv3D2tGt6PQEYl/tvLSVOjqw1T+Ai8YvKbnxShGWN/MLMuc43KBLF6hH7cgw713ToxvFZ4+jSXpnSeQ49YcoA==
X-Gm-Message-State: AOJu0YwU5oiEPDvSHJNkmWmDH2/ewD2dYPSSqwndbr8oXGKrcBNA/rmU
	Lll2P4nynlPfM8fli92LShN3Ndf+0x7aaV3QhBgKKAD/s5AMRmzET/bTdBHy44LROKj/dT9CVht
	4/YYqdwgFwefsCao4NatoxnJJwO6d++8lUJNyNVQJsCeofJ3ubdKBOT6I2uF1ASM=
X-Received: by 2002:a5d:5254:0:b0:35f:159e:5ec2 with SMTP id ffacd0b85a97d-35f159e6186mr5609431f8f.39.1718103048817;
        Tue, 11 Jun 2024 03:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXDhdkA/eYdpilHthDuW6/sqyY7YL810c3QO5B5dWAJ2pffJ1e96n0xCMflbdVhb7aOmh/NA==
X-Received: by 2002:a5d:5254:0:b0:35f:159e:5ec2 with SMTP id ffacd0b85a97d-35f159e6186mr5609419f8f.39.1718103048419;
        Tue, 11 Jun 2024 03:50:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d2e73dsm13674969f8f.16.2024.06.11.03.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:50:48 -0700 (PDT)
Message-ID: <2b912e12-8289-4ce8-99bb-103a289a23cb@redhat.com>
Date: Tue, 11 Jun 2024 12:50:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate PM_MMAP_EXCLUSIVE
 without PM_PRESENT
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-3-david@redhat.com>
 <ZmaFxfQX3AVMIVkp@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmaFxfQX3AVMIVkp@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 06:49, Oscar Salvador wrote:
> On Fri, Jun 07, 2024 at 02:23:53PM +0200, David Hildenbrand wrote:
>> Relying on the mapcount for non-present PTEs that reference pages
>> doesn't make any sense: they are not accounted in the mapcount, so
>> page_mapcount() == 1 won't return the result we actually want to know.
>>
>> While we don't check the mapcount for migration entries already, we
>> could end up checking it for swap, hwpoison, device exclusive, ...
>> entries, which we really shouldn't.
>>
>> There is one exception: device private entries, which we consider
>> fake-present (e.g., incremented the mapcount). But we won't care about
>> that for now for PM_MMAP_EXCLUSIVE, because indicating PM_SWAP for them
>> although they are fake-present already sounds suspiciously wrong.
>>
>> Let's never indicate PM_MMAP_EXCLUSIVE without PM_PRESENT.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Forgot to comment on something:
> 
>> @@ -1517,14 +1514,13 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   			if (pmd_swp_uffd_wp(pmd))
>>   				flags |= PM_UFFD_WP;
>>   			VM_BUG_ON(!is_pmd_migration_entry(pmd));
>> -			migration = is_migration_entry(entry);
>>   			page = pfn_swap_entry_to_page(entry);
> 
> We do not really need to get the page anymore here as that is the non-present
> part.
> 
> Then we could get away without checking the flags as only page != NULL
> would mean a present pmd.
> 
> Not that we gain much as this is far from being a hot-path, but just
> saying..

I *think* we still want that for indicating PM_FILE after patch #1.

-- 
Cheers,

David / dhildenb


