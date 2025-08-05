Return-Path: <linux-fsdevel+bounces-56751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B6B1B3BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0271D3A1AE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188F2737FB;
	Tue,  5 Aug 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ/ktx6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF6270572;
	Tue,  5 Aug 2025 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397996; cv=none; b=gjnVCNrcRlFRRfqEmenDHyvYOUdp1RawH5MvnfBdtbVUhapSCl93cWEd2rsPVCsQR8TCnZjYrzVCtwu3MDYy06IwPZniqRi6AqFsA307eCH9C91G0ZdWETWyh7Ap4sKAYIGp8CToGn0ENZwJKDAG5ZlZAcyMdSERQmGTRvXv0cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397996; c=relaxed/simple;
	bh=c52wsAmzQmMSkV8ky4R5zRMKeoWTxR7tmEk0y82AHHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVnSkMQ7e0w2i0V4pDekJQ+xokMXHQj+BWroCVY1xqxUHuMgyTNJhjtd6UHj5uNl99S498CSWGomG+U6eZE/8BDn1RBVQHtVfL/NGFKwi8H+r1KhEHm8KQNiDHPr+mO3KEp7fewoBbE9R5IcXW/EgmuuFVxVFgN0VEOrvaIFlEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ/ktx6A; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso26364985e9.3;
        Tue, 05 Aug 2025 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397993; x=1755002793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kts85wOR8B785cDY/fcRHxCicRY9ydmXyui8WvGgCiA=;
        b=OZ/ktx6ABivrYuBBfr0+Ogqz2KtZRzqsj289tUXx5Wn6OW9uRXvKGv6TJQRGsoANWK
         MBM7UyU972LwLi/zlURhZHCwRA5zRf561GRb6sLSpVwKg2zFEKxV2Lk6tAfLY1IQD5lY
         3G0VFFC5mk4ONtB4brUjcMTHKGPXQ8tbxJn+QqkmBtcnM1KEuw+SJoKZYDTbqeL67HgZ
         Sy5XMdu56okL0DT7o4yym+XebbWxRhDq6AfnCvvWaBUzphk3c4ZwK2qXx14Ggrh3FijN
         h3lhDjSFIwvHHIlLx5vy0zLTNtdyVMXWim75XgxGuNI6juJxTbaagBz6n0IBTxJG9Ojw
         /Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397993; x=1755002793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kts85wOR8B785cDY/fcRHxCicRY9ydmXyui8WvGgCiA=;
        b=VKwoeXEE2YXIazU22Po7pkGABX6XP0zt18IuVFZbDkRnYtT261so03e6Za+PlJVl79
         yiWOIeIUVeXx8Xpu7tfHMfvzu1vArVkx2jyflDnKuA0ZSPThZoiFyCXzRATo/CKjxbdL
         E9wFYWhedSegQraVAYsKwfeb+qwi1bNctoV86ta6U0TAh7SC+EVr5QNxG74VgZrontgV
         HJLFGxyS90QJswiTzqeA83VzS5pGgDBxBVg1GuI5Sd+qtKx/ZHE2uppWH9iEaUGPlKrj
         VRIFfWfpw6UryUOPVeXM3G+JY1jtxo/i0Gh4bcE92rYFwyGORkM+u2/Iq2TvejtjrBZ+
         CY1g==
X-Forwarded-Encrypted: i=1; AJvYcCWEto07GFOcAc2nzMDiVjXzd8LgRk6OV2UU6k5Rj9nIZzc32CPHf/jvoOU/FvQXLYsDREHvJcNlYX8=@vger.kernel.org, AJvYcCWgj8D1/ESLmjZmtqg/DWucX/Bqmgq8VtXJZ4DB4UxOSAwqMnjOkqfn49qixR1tzbWqHGTWqaP2+8im0b69@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YaH+z/ihQ+BtO4x9lpsB+DaXtZhJ+oRcVs+uHzqS6rUBVKx1
	GjWRvI3YNdCQlrGEQKrRXPJ5fEsRQWEMcxCZmc+lxG8CdLDRcq/QTi3z
X-Gm-Gg: ASbGncumCsmj65BLipDSsRIV5gzG8WMXOBvyw4LmqeV2gz+cQg0hg5cqiDoOwO614mG
	UI7zDReaEwzaRR4m52AlVH82nS+6OZtKpqtpJlgyO4xZoQg1rAod53RXNKteozL566Xs7o7s0Oa
	VuSmNd5OEoWY6qgWzHZ9ZB/e0v+Vply3+8Drw7lkjNkwz3Imo3StiKHygXrQfKignF6HU727K7K
	slNprSqQu3EIvtl/4N4h8fUmGgDQkg6tguEuOT3T6CUnnJFQ55hwxTZaxviHvquKgHMYEir5txQ
	a9NEAbn19urZyOHmH7FXBP4eTp+qnPdCH6nRo5lunxNvlxK6FXmFvc53puuzfzlMMQL5Q8LBqI+
	yh992G1ryY2WiFYPRaxAZ3V05a4fwSCOM1dD1H30s4hlRBi5hRcSNhO/Y+yRH35wXTBs5kkI=
X-Google-Smtp-Source: AGHT+IGbwhKqeLKVbuUBtyRIXnxHc6wmxoB1d3BMQRjaQbajedNiSQ08om9tQBTpc0k2ftB702prvw==
X-Received: by 2002:a05:600c:a46:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-458b6b30363mr102873805e9.18.1754397993088;
        Tue, 05 Aug 2025 05:46:33 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::6:98ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc900606sm66735885e9.15.2025.08.05.05.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:46:32 -0700 (PDT)
Message-ID: <a22beba8-17ae-4c40-88f0-d4027d17fdbc@gmail.com>
Date: Tue, 5 Aug 2025 13:46:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <66c2b413-fa60-476a-b88f-542bbda9c89c@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <66c2b413-fa60-476a-b88f-542bbda9c89c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2025 13:39, David Hildenbrand wrote:
>> +FIXTURE_SETUP(prctl_thp_disable_completely)
>> +{
>> +    if (!thp_available())
>> +        SKIP(return, "Transparent Hugepages not available\n");
>> +
>> +    self->pmdsize = read_pmd_pagesize();
>> +    if (!self->pmdsize)
>> +        SKIP(return, "Unable to read PMD size\n");
>> +
>> +    thp_save_settings();
>> +    thp_read_settings(&self->settings);
>> +    self->settings.thp_enabled = variant->thp_policy;
>> +    self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
> 
> Oh, one more thing: should we set all other sizes also to THP_INHERIT or (for simplicity) THP_NEVER?
> 

hmm do we need to? I am hoping that we should always get the PMD size THP no matter what the policy
for others is in the scenario we have?


