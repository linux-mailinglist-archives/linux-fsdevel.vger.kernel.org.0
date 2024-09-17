Return-Path: <linux-fsdevel+bounces-29578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC297AEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B00E1F23A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 10:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB821662F4;
	Tue, 17 Sep 2024 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmAfT/z0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC916D332
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569016; cv=none; b=bkVM6AggUSmge6quO8+WJ9qbZtOKPdjhtQKnxFwiohpA23odiFuJHrRd5taW9Dtyg2MD+ImNHqF1Vq61zYXs3d4YBf4ro1gYfWIyJyewXGS5fMBsN5eoQZoEQiBVBkZ7c1QuCkfTJmj2jhuQ7C/xut8i8YAILLqLZVeCd0I+SCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569016; c=relaxed/simple;
	bh=0DdIOIACxJouS6D8EJbNZKrdg/DugD6ewFSW3HUoiHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWgN9XNZk8Awz7fB4ExW91ZriGBO3ul3oz0HhD0AnqzGA/rdSzg2Q66XcxHPMT/QzBkKjA1tfr71lSiReJobYKeH8+a8FbYZpAvVvZsuts4sHKWAYEGlboOaQvpCEwz7GLKIjoKMsBDFbKAB6zwViaw4QlCXojyaz3PtYhdR4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmAfT/z0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726569013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Il6/yr79hfIqszHcYXe2ZQwVjF0GnV7MWdNXGzD9hFg=;
	b=UmAfT/z0vFbMAGAiMy5PrdJY6uJV2KhCiEDzqsT1stsApeF8XTPIBCr0B8g0JK2ZeyZP1Q
	iLegldb50Aecz3205qg1oFsoDArCuiAZNdCZypkaU26rGPBRWHCxqao+eW/eRbSrNvXHDw
	cZJfmKS/ySjYF3HC3Lc2lvJYtOY+Jq8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-jMmhYQeROLmY-g_POgwprA-1; Tue, 17 Sep 2024 06:30:12 -0400
X-MC-Unique: jMmhYQeROLmY-g_POgwprA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8a9094c973so436689666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 03:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569011; x=1727173811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Il6/yr79hfIqszHcYXe2ZQwVjF0GnV7MWdNXGzD9hFg=;
        b=Za6kC1LZdyUpMe3fVwAvwEjAP80OfEXStJTSCjKYwJFesKwGzZ6zq9H7+h6zvKuBR8
         mBmUGIkWEnRYfeqOgFJKvF6gQmuI89uT/MWFVLL0/u2K8xJzuew/cFQ276NpaQeJQv71
         j/0yKGud28P/ft7CS6awVVBSdP61EpWFY3pP02NXbuRlAsaRtaV2GaJMfK8gRqBDbHkn
         Nr1cuUCvShZfbKDzaMafvFagWFjGzfRYqF+NTVXmfM93UbIgfwpZNsQE4QtHkybmNe9K
         2C0R5thsPhIjOOYEGn3rJJXTkxPon5mgHb4H08t7jq8o8mDk6QjAetVSd+VfXvpy1N/P
         vQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJGN2PBaAVVB5tud6Zs/hRhnYWz3QpWO7Q3hxar0V3lYq2dWlLidkSsfse1o40DtUt4EBgc/rUpffF0AOj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywai4WGbsmNVZLgCFeXIDLy3EKG5xgae96RoP11VAMdu8B+L3uE
	lY9u8t0pWSVG7VKqNiUKP4oXzgnZ0utI60uKYWNgSO60XanfBOYPyIWD5JnSEt+aNTS/oIG4Te6
	33xKHk7q1UAD1nAPVfsBGjGOIykQtXdiDucJxYGJIJRkkFUOQfSHrUzLxQ3IGqq0=
X-Received: by 2002:a50:cc4b:0:b0:5c0:ba23:a544 with SMTP id 4fb4d7f45d1cf-5c413e11a77mr13969645a12.12.1726569010910;
        Tue, 17 Sep 2024 03:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJTwHM98MA2kgkvMOUNXrW8Gsj1Ct1E78OeiAnmCwzZW8pymJVRmDQoeNYuIOrguJT7Sl3Tg==
X-Received: by 2002:a50:cc4b:0:b0:5c0:ba23:a544 with SMTP id 4fb4d7f45d1cf-5c413e11a77mr13969615a12.12.1726569010313;
        Tue, 17 Sep 2024 03:30:10 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e1fsm3704713a12.72.2024.09.17.03.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 03:30:09 -0700 (PDT)
Message-ID: <0419471e-20d5-4db6-ac58-09ae0c0b9c65@redhat.com>
Date: Tue, 17 Sep 2024 12:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] m68k/mm: Change pmd_val()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240917073117.1531207-1-anshuman.khandual@arm.com>
 <20240917073117.1531207-2-anshuman.khandual@arm.com>
 <4ced9211-2bd7-4257-a9fc-32c775ceffef@redhat.com>
 <a35f99b6-1510-443c-bb6f-7e312cbd4f79@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a35f99b6-1510-443c-bb6f-7e312cbd4f79@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>   #if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
>> -typedef struct { unsigned long pmd[16]; } pmd_t;
>> -#define pmd_val(x)     ((&x)->pmd[0])
>> -#define __pmd(x)       ((pmd_t) { { (x) }, })
>> +typedef struct { unsigned long pmd; } pmd_t;
>> +#define pmd_val(x)     ((&x)->pmd)
>> +#define __pmd(x)       ((pmd_t) { (x) } )
>>   #endif
>>
>> So I assume this should be fine
> 
> I think you're implying that taking the address then using arrow operator was
> needed when pmd was an array? I don't really understand that if so? Surely:
> 
>    ((x).pmd[0])
> 
> would have worked too?

I think your right, I guess one suspects that there is more magic to it 
than there actually is ... :)

-- 
Cheers,

David / dhildenb


