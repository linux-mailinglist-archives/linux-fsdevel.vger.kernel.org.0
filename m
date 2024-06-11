Return-Path: <linux-fsdevel+bounces-21409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFC90392C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50F91F24ABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883F17B42B;
	Tue, 11 Jun 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Creg/OrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BD17B407
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102733; cv=none; b=eW/JXSxl0dQ0tKJ8g/tnIfmwomKGiBYlP7Emg8JC1sQmbwJmcRRC81wOx0K3TgvEJLFrGs6oCFQgqXMKqXuFp4dBCOkSeyh3/zIwDcaa+kPEByzWTuQRiHFdmShlQ7+CCaOOZI/sskBUYdOHM80lmgpCDSMoYfCGblcWTuRaels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102733; c=relaxed/simple;
	bh=81aQ12LJNT5wUo68VRAaJIJg+Y08vkvRunN59IdJWVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICjqM6xgq8ZR9Tu6bVVzpholN6vs0CMXmpuaKbtPmvSwrbcdrSiSQrxM5xiuEvBrhvBJFzcea6g/Lnqw9OKgEBB2o+Fjc9T5KGdqAYtgkGkyDj4MSTKE+UG9VA/eSgwGkuiR+3faowSL4wFZ4wCDnI5z0tCe3XI9YYW0RJNH2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Creg/OrD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718102730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b56Xo9cU8SJGzlzzEuOUM6veXq1e4lsaNn+mMTgMXNo=;
	b=Creg/OrDb4836KBk4uRxhWx2h3+KNam+ipPLF1/GCgmFUsqjWCiIjonfPYqPKaMgS4MvvH
	URBHo74igfCHRQueO6AQ6G8JJz9dwR4KXSakFCcQVtUO0+1x6ep1lNfH8lapjyIwv4PgR1
	LJHDk+eQ/n4b3XpWtq6/v6mZ801wd98=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-daaVKy8YNSCt8CuXh8Eyrg-1; Tue, 11 Jun 2024 06:45:29 -0400
X-MC-Unique: daaVKy8YNSCt8CuXh8Eyrg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebe4b327a6so7817881fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 03:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102728; x=1718707528;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b56Xo9cU8SJGzlzzEuOUM6veXq1e4lsaNn+mMTgMXNo=;
        b=AjLxvYl4RDC7/qf6Mg7UDbIAqHue9/5OlbUpwapHLkzpilzIFQP0OXLmreDOJh4j36
         2FkIBgsQouh6joNPABw0QZWUHmm1APWwpjVasc4j0vqSmUyim0auMBa9KpfMAEfLNeFC
         GwuzVIeUTdZz3y1cc9/ixwifvnykaEprqCDir0ngLzm5yi7fjBZaT6bzt55sD64dAtM5
         NMLr/5+vpInJSbP77T2mPsD0IsuI050Zlz/k6ftYWGiaEMe4LLwq3LyAmU0BGkUPoa4/
         jRqeey5ZApQ6NmwfMPYO8JuRJ2FH0BWZW+IOvn0dOaV+1ANj6mERAz7Oj1bkqpWBVkmt
         Abmg==
X-Forwarded-Encrypted: i=1; AJvYcCUsUTxdFjxOzdOSDOe486/ktOi7Hlzj8SDKPJlox677NQonJI72qzPSjR44VzS1xAlMPzSahSssSlq018T980c6mRAnOdtNFB9aYfPwxA==
X-Gm-Message-State: AOJu0YyfXlmDhKECHgtx9PYMhRHDZneuS1aIRH3Jk4F447iCOUIt3Lmh
	2vzt5WrBnkNvpeO4Jkcv2AQOIuKW3rjFL9+9uXkzoQGZZbQzpqlPnlvaiseULgRY4bCky9hQHEn
	kMA+QxZaU18SD8nSGOuSDutdplgfzL8TXRTt6/6K2m/aN5r6kKGb91/B2o7EI5P8=
X-Received: by 2002:a2e:95cb:0:b0:2eb:1216:1bb9 with SMTP id 38308e7fff4ca-2eb12161d9dmr60858591fa.19.1718102727840;
        Tue, 11 Jun 2024 03:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjUlDwQt6XADfNCyrepf2O0SucKhyd8S8dEWEIGbCA71G2YroE72/KoE0CQZH2rSQ8sp9IEg==
X-Received: by 2002:a2e:95cb:0:b0:2eb:1216:1bb9 with SMTP id 38308e7fff4ca-2eb12161d9dmr60858341fa.19.1718102726442;
        Tue, 11 Jun 2024 03:45:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e567sm174033245e9.1.2024.06.11.03.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:45:26 -0700 (PDT)
Message-ID: <68292d2d-c1a4-46bf-a3a2-7fa37fe6b4f3@redhat.com>
Date: Tue, 11 Jun 2024 12:45:25 +0200
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
 <ZmaDSQZlAl7Jb-wi@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmaDSQZlAl7Jb-wi@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 06:38, Oscar Salvador wrote:
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
> 
> Alternatively we could use is_pfn_swap_entry?

It's all weird, because only device private fake swp entries are 
fake-present. For these, we might want to use PM_PRESENT, but I don't 
care enough about device private entries to handle that here in a better 
way :)

Indicating PM_SWAP for something that is not swap (migration/poison/...) 
is also a bit weird. But likely nobody cared about that for now: it's 
either present (PM_PRESENT), something else (PM_SWAP), or nothing is 
there (no bit set).

Thanks!

-- 
Cheers,

David / dhildenb


