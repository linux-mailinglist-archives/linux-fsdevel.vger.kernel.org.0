Return-Path: <linux-fsdevel+bounces-59946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DD1B3F789
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7394E3834
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BA2E7F27;
	Tue,  2 Sep 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOCdvZPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BC732F76D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800268; cv=none; b=N5kOu9ZPQgjNMlq3NpfPU6mt7RgpRpQkUNmya7h1tTAjpshBvGI0ESwccxN43yS3ErKslW0uqf2DwwuuR/jlqnrhSAXm3wYmQZkr47h0m/ipNhkeJ+DBLuAg/fGi6bHV0UZ4TJbS5eXsIaz5aA3MFRgqDaKmW6App/JHtblKuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800268; c=relaxed/simple;
	bh=aLBnQ/sWixUeSnRYjB6DD4TPTFZwygIV4Ca20uOgcLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SO6b7zO2LB2yqpHwwJmEEO/9IxlBINLW+Oy0X523kmnrrE1xXL5PwwS+nDZSmUFLDqSAxhd4YOM1SxyXJ4KfHy1Jjasvs3RI/u4b0Rk48B+etKOKtwfIQa4XqfBivXI7X/8jZ5UD2fXEcMvGQk2iYiJIwmP+pIRsnA/RA3J3vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOCdvZPy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iWRs8dmxjkSLC3xxQFUr/zOxuf3XJeRB+0HV6i1wagU=;
	b=cOCdvZPyWgDCWeMzoF5sJlQAJDCJNnmSX8ktlBqwV2/DS/2OwrRAaYiGjUf5BVsoVpU5yZ
	WE+joqBeF46foipZwpYhO6+olSLTQXJA6wflfRpGL0Rm5Y0dyhov9H38kfGcsAEUQhEmrc
	H7v7kPsK7wI/M2naWYlkuct8wfmD3ts=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-tHKlJ4ePO5mWDNRgFCB60w-1; Tue, 02 Sep 2025 04:04:24 -0400
X-MC-Unique: tHKlJ4ePO5mWDNRgFCB60w-1
X-Mimecast-MFC-AGG-ID: tHKlJ4ePO5mWDNRgFCB60w_1756800263
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3cca50781ddso2176558f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 01:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800263; x=1757405063;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWRs8dmxjkSLC3xxQFUr/zOxuf3XJeRB+0HV6i1wagU=;
        b=sasAJnJwpE/TRijtWV8NTs2vh0Vli0CN0jJMHHEObFNgy4yYp0YqlgDL2s/8cFNuRz
         GhLSFKo13+VaGRAYEjMjTL+K2bk3+si8noQiL50+tUpCW3G0cOGq6Yj2aLNyxSVGR7kd
         GhVcdBMFyRv4ktSvb3f2LQ+9zZMhwS6ExGOAd6Gbn6if44SBY+Z6E2HUAgqwEFCzE0pN
         VmRQCQ5lp88ziVeEtcSGho8TVgFEbwhqqyNYzcdtkPLkhmCRMO6s8w/VNKsdeZTjlHQe
         iN3sCsnY0rkKQLaeRaZnChd7dL6lIamOoQo0laPfg9Mevg1IpZ/yDAXQsssiPInJ1m+S
         jwPg==
X-Forwarded-Encrypted: i=1; AJvYcCXjIFmgeQ0aBJd3gjEecAMzuGKzizgvYuiWdcdlCVNXuVpp3129TUCymO7/FJAc9ltEeaonzIfxJXKIRw7B@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMLHNZUg56/aea8nrBB29P49qPnjwjMn2wXijj8slGWqebvqA
	Sp6TavBQTpG6SVl2t6sGwcDT2yaSt5a9TDCQQeEkqFsUlGZF0nOwFV+VFEYT2u47f40EypyMhe4
	WI0tq3MTfg9SYhy36sPi9szMyB71QOXZyAqem3MtZQOPsuWhNxrV2y3vEB1mbtARaq1c=
X-Gm-Gg: ASbGnct9ZR+wltnXQuD6NpgcK+baLnAPnOXVo4k5AsQuFE+NkxqBQIRADVdXDgXw5hV
	5how+8wEDM8t6jEOP+qeawug9mV4mOwwXfpkSWfvH37iACHWqthMpQqgGWNr5igAqCTDgCEeVAj
	9xmFsmI4/4eBAlhCiWPj+huE4miEL+fPkTYcfzMdcnQmIyrkKUdstqcopyDaDFqUowlaXhMbU1u
	aawJOPJeWBvDZR48yLANuDydqN9hfDrkDx2QgTnmXB0X9znGsoBzkpt+DAm1aqB493EXBbgBa8+
	vGcQZTjGfX5IT2NkqFyvsoxADZ2jOtsgIn2FzOS62wxAGvM24GdIQWqd6LqLXSkEVy6LmKJt+qs
	n9LkRr77Rx5N6XMxnUYjdiqAoAFzRsZQ5EEDEn3l9ONn6f7uHXHM5VFaPN1TgsV5Mnug=
X-Received: by 2002:a05:6000:1ace:b0:3c4:bc55:65e1 with SMTP id ffacd0b85a97d-3d1dd434397mr8245295f8f.24.1756800263156;
        Tue, 02 Sep 2025 01:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7tZ84tBomOiZJ2viM4EfuscitGcpK97LthdnhgXpe3SACLWjKyv/xkWV2kN4g7adtuOE+bw==
X-Received: by 2002:a05:6000:1ace:b0:3c4:bc55:65e1 with SMTP id ffacd0b85a97d-3d1dd434397mr8245260f8f.24.1756800262587;
        Tue, 02 Sep 2025 01:04:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab14esm200784145e9.21.2025.09.02.01.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:04:21 -0700 (PDT)
Message-ID: <5529a696-4f6f-4bb9-9bc2-ba5f9f72ec8d@redhat.com>
Date: Tue, 2 Sep 2025 10:04:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] mm, s390: constify mapping related test/getter
 functions
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-7-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901205021.3573313-7-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 22:50, Max Kellermann wrote:
> For improved const-correctness.
> 
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> (Even though seemingly unrelated, this also constifies the pointer
> parameter of mmap_is_legacy() in arch/s390/mm/mmap.c because a copy of
> the function exists in mm/util.c.)
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


