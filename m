Return-Path: <linux-fsdevel+bounces-56520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33608B1850F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572421728A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 15:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDF273D8B;
	Fri,  1 Aug 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWNgQyJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2C26E158
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062444; cv=none; b=FR4I9yoqiVmHHUY7g39voXDpNsPs8iORJoYXT/8TxMCCAlee5X3Zkk8F5k9BmFBC/UOL9ijHHJg+avTPKDl7VZeUxTyJwwQ2PyJGiTMzwLq1eFetcSB4JGNIWrsHyuglfb6HhPkopESym1BiTkZTJKcWeA95DhKsI6BtXLGSOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062444; c=relaxed/simple;
	bh=thcdEu99pNDEp9JrPdMGIyb+am9KDemFmiO0S6PEYts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoqqpD1UbJp+bV15p6j5cMwlFUfZ7FvG+67Fwogy8L8C/XEMYZrnuura6oPjlX+TRAp5AC37jhczmty0YzaD2sofGUvj7vuPGIZcHuMzeB3TVUkygxSeGUXG5IFz7dq0MBPcUHpeooWov55hirBNXz0OoNKrnpTzqerRzkBWhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWNgQyJO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754062442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JHgBzHC9Il8/iD1hFbNzn8RBxkEg4S2pBSlpVReUImg=;
	b=SWNgQyJOA+LE8lnScd33KWk83ibALtxaGlXwTkppcTt7D7Nirp0/HSbaSL123+jOajg3GA
	mLDLQCQCrjZZu4BmAAN+xlet7wv5vG90P8+0oxRqUrzKXSEt062Jl2oEnF4ZkmJ45Ll6wD
	VH3scW915x0Tg49IXImu6qkTBjUDQTw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-8NhNo5iSMSCK9Fo6X0Jp9w-1; Fri, 01 Aug 2025 11:34:00 -0400
X-MC-Unique: 8NhNo5iSMSCK9Fo6X0Jp9w-1
X-Mimecast-MFC-AGG-ID: 8NhNo5iSMSCK9Fo6X0Jp9w_1754062440
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4538f375e86so19544905e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 08:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062439; x=1754667239;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JHgBzHC9Il8/iD1hFbNzn8RBxkEg4S2pBSlpVReUImg=;
        b=k4t2ytUbmy7qlFiZzsFgBTzmaVd4LGSlt6gh4DrnTZd+5u2Y2wA3fvJOsl+FSYPJ5L
         vxlpYZ1jlaDRnMEq/w5zq1gVOb5rNVxontI+j4dVFb8abz/KLH7ihFBxahFTY3B1oZQm
         84Xwvzkp6HyIQdttHsHcgUWm6d9ylg6IHrgG/AeqjdrtH38S9B1SYGjDkDEN2zm/XdEI
         nVacdCfl7oMA4gOg49qVSW/CkgOya/2b+if2DCt//dO8M2SYPUzWS8qcg5aFyCWcMfhB
         UzWPUqj8NyS2BXQ5eLteV6zulisVo1tjA5hS/+z+9Q4MLBHGEle7Uc43pRUpZDlgKTt5
         qClQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxtSBllGKiTBBOthH+2doEl1LiOxu2xA8JdjmCsIEFzalm0XfGT5KjcK/RwgPn8wUdPDiDnM9Ccsbk2xmD@vger.kernel.org
X-Gm-Message-State: AOJu0YxjArxCI/wtS+onXhhNJi/Vboj7h6IA/oIrsEas4qLLJ++FrevN
	blpJV4MFwCI4NPn5ZqM4ECHekn8Lo8GxjglZEB7DR5MpCtrsn8cswQxxsM2Rr0rmOaOwEXcHT83
	2bZEeD5XED5sgEBljXS4fYVHvQW+9/F537MdlfAleOvXfRWwVkK1xhN7JyJdLWQ+5sQA=
X-Gm-Gg: ASbGncuISOJsPEWDTQwSoaZhL8c77oXdAF7A58Nav/ZEcohDVPQtdy2wZAwDWU2+BXm
	7PDSVKtVRVabBfr4dxZNlFIk9n1FJAlCFIKNlKBORX2jHGNB2ZE9Kzk8Hg8md9Mr9m7QkfYl5XN
	gXxMUd2Y+zPtLKxttNVCv44U+Ny9Yho2t1bAC2ZRWCkEaskRe4gzR74KarSQFkFAvohGnhIUSlz
	mVnkHUHqZywhi5YxOo5zp8PweGvcquLWNWIuNpeXvftZNj0UVq2JpjucYhaU7vvEaCwxVApdEgA
	+K8arxJw4U/DAk7obzVuDxfUpCnyV0/waEo5sM3LBhkPbrd/sipJUyccbJrZ2h/xZetnL9En0A+
	83oYx/aCBwk9yFa8oAJy16sjgXAHkPw4NTiWyKXJWB/FJ8JWwYfOxSIbDhXrh8r92
X-Received: by 2002:a05:600c:8812:b0:456:2397:817 with SMTP id 5b1f17b1804b1-458930ecbccmr78899275e9.13.1754062439561;
        Fri, 01 Aug 2025 08:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwQY4nbqQJMBDn5fImafjO6gVC20KrAkByKenJ+HrlbIwqOuIdKFnknmS+j6WRtdBcgZGsw==
X-Received: by 2002:a05:600c:8812:b0:456:2397:817 with SMTP id 5b1f17b1804b1-458930ecbccmr78898885e9.13.1754062439134;
        Fri, 01 Aug 2025 08:33:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eb7acsm105359625e9.28.2025.08.01.08.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 08:33:58 -0700 (PDT)
Message-ID: <8368f30f-19dc-4272-bc36-13d6c2377bdb@redhat.com>
Date: Fri, 1 Aug 2025 17:33:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/4] mm: add largest_zero_folio() routine
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com>
 <20250724145001.487878-4-kernel@pankajraghav.com> <87seibr7do.fsf@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <87seibr7do.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 06:30, Ritesh Harjani (IBM) wrote:
> "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:
> 
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Add largest_zero_folio() routine so that huge_zero_folio can be
> 
> [largest]_zero_folio() can sound a bit confusing with largest in it's
> name. Maybe optimal_zero_folio()?

I prefer largest, it clearly documents what you get.

huge vs large is a different discussion that goes back to "huge pages -> 
huge zero page".

-- 
Cheers,

David / dhildenb


