Return-Path: <linux-fsdevel+bounces-57772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0765B24FB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3407683A58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CAB285CBD;
	Wed, 13 Aug 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrzK2YPV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E63281352
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102258; cv=none; b=PMo9dESUsQmlDCCTXD8zK3zP83AjnZzi5o5ep9eT5Zhr78TEHJmo+So1CPiTLOgmZFmTFURT2aAN4kLY0y2MEcA/EO4fCo19LB9RNcnC4pTY+JmXgKHIeK9qesLDSyjmqMiN1GB/2t++HdWSKnETlbJBVaEcxo5aiZMcxtmZAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102258; c=relaxed/simple;
	bh=lAIaIoiHaGHhkKONsfva+WiiTONuoKg17dXy+Sf6Zzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urrBWH0kOMa/WpM4Rc+SzZAODZ6ORkQM91Y29OH1E5UswYhf7HEqTaPwar2w8HmBCrlry2y8DjaKyGvy1l2TPoFOa1Tk1EJh8DZDIR7HvCa1luYOrnM6uosV4unSsSmzOhWe3N1JgqvEBeh5mnbLGKJjVd/BrtOJJZt+z0I1PHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrzK2YPV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755102256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lSm78Xf6MmSQdPwF52t8+Op26dEorL18vOLPK46y1KM=;
	b=IrzK2YPVMX/9JJad8+rzvPIh86NZlnaxRzKkZSvgwK/XF7pFuCejicIT1o0zL2sVnPZUx8
	rCcMGfc5crzEIkAjmRaZVyXrrhmbFi5WEsQm+rANwGiuhXbFdKtVu7niEmARFkSBuZs85F
	Virv9UJkK3OxhnGI+P2krBuyx+/peu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Sqhy33mePcitmjCjCq2Q7Q-1; Wed, 13 Aug 2025 12:24:14 -0400
X-MC-Unique: Sqhy33mePcitmjCjCq2Q7Q-1
X-Mimecast-MFC-AGG-ID: Sqhy33mePcitmjCjCq2Q7Q_1755102254
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4595cfed9f4so30556615e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102254; x=1755707054;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lSm78Xf6MmSQdPwF52t8+Op26dEorL18vOLPK46y1KM=;
        b=wp6gR7BO3KU3xth6+4mkFGoBiqYOEujx8x9p/z1b0XBk7zTWPFocT/++DDt46O4+Oq
         dFvixhjWrcOYjN2DYax3yPM3u2KLIYZJu6R1jvH8aKfIAev+BCatUokzSbBRznyrNgR+
         cQ6HKmrdm++Ji8C3V7eE5l5ZAywtZEwRZzAmYYI1JNiz4vACLfhmAABLdUFpuB0OmJl8
         Msk29VTe81/PHHozcxO6j4PrYjcAYuV+u8P8oH7dF/qIGz2yWQ5mzUIzduzu4VlO2g62
         C1pHG5h0E0lp7NYEzIfjxcYc93TnU2UTkRmF2CzsU2AUNmWocTBDPfTDdIxEWKA3X35d
         JZtA==
X-Forwarded-Encrypted: i=1; AJvYcCWNdFcYz1/c6O5r8Lx/giKH+qs6LS1TNM/20kWXxS0EctsyDoUurL2aptnUkVfg/0sa9L/DYpLzgzh0LIJW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywif+9DJXfaMQUZi0qrLj7MUAoo0D8BOSz5qn0PHzU9PpIje7N9
	um5rTkbFrCDMzgj/w06D6KE3lzQQeNbcoHogbMGT6RUU4RDzPLpjnEfRJ28NQLRGZjmnWRA+YFb
	DJl2eSZktfm7fjM7xtJeH05j/tJ5/rkEOyjx1dnNNXj1xhPso2UjBvznFppZULhtTIHU=
X-Gm-Gg: ASbGncs1TcTUZq2/lSSMiN11/BLpWHUHATivsJR9/FWuMN7OFQ1w1T//PCJlpWOpg+i
	Y1M48Ytn4IYAT3/XJlhWckYo3lLSXLygJcOKcBVX9aI072zZ8Dq1iOB9nJbqqMANxPQAzNCpy9f
	+JzEkNzKypvZPY0XeqCAqiAwjon5pDF8T1nl8QACLBegiMnqyHSPzQIrskhO3cpvKGV6aV/xGmJ
	wKD6q5yarttLb0v5rko3amSD7s4f4VHTQ+cInltC1lEZ+SiBRMY52QKoB3z6h3Rk5ZHvsVoKYDZ
	vFK3suOly7GIDyKbQaQhtfhu3Dwp55wk0Uww8Aul/ofwGNj0eglBMjvy2dg0aob1P3/LsqlYuQm
	GhHaT0yCBAAVPAVQu17sw04U5CDclRwlNv4Ttk6WYqIqUF4xpX3kMMnIWEe9kGP6FVP8=
X-Received: by 2002:a05:600c:4f12:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-45a17949c46mr19492215e9.1.1755102253649;
        Wed, 13 Aug 2025 09:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6F2DbaZck9nZoZlO5xU8PFCcMfBHNTCqmXxFrqYn1Ok+rrYGt2my+hYZCl6e7nfy5+/NLhg==
X-Received: by 2002:a05:600c:4f12:b0:456:fc1:c286 with SMTP id 5b1f17b1804b1-45a17949c46mr19491915e9.1.1755102253258;
        Wed, 13 Aug 2025 09:24:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f11:2400:5d0a:b6ec:2ac0:666f? (p200300d82f1124005d0ab6ec2ac0666f.dip0.t-ipconnect.de. [2003:d8:2f11:2400:5d0a:b6ec:2ac0:666f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a5212b2sm8133575e9.16.2025.08.13.09.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 09:24:12 -0700 (PDT)
Message-ID: <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
Date: Wed, 13 Aug 2025 18:24:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-8-usamaarif642@gmail.com>
 <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +
>> +FIXTURE_SETUP(prctl_thp_disable_except_madvise)
>> +{
>> +	if (!thp_available())
>> +		SKIP(return, "Transparent Hugepages not available\n");
>> +
>> +	self->pmdsize = read_pmd_pagesize();
>> +	if (!self->pmdsize)
>> +		SKIP(return, "Unable to read PMD size\n");
>> +
>> +	if (prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED, NULL, NULL))
>> +		SKIP(return, "Unable to set PR_THP_DISABLE_EXCEPT_ADVISED\n");
> 
> This should be a test fail I think, as the only ways this could fail are
> invalid flags, or failure to obtain an mmap write lock.

Running a kernel that does not support it?

We could check the errno to distinguish I guess.

-- 
Cheers,

David / dhildenb


