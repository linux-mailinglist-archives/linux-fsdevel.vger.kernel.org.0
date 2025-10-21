Return-Path: <linux-fsdevel+bounces-64958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BB1BF772C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06568188B0D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0F3446C2;
	Tue, 21 Oct 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqB7YlrC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C32EE60F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061386; cv=none; b=DsD6O+SeUyqLlX1WD2GDhxN4x3LPjTS+lyGNe7YkqkdkhWxpqdkHckfyS5dB3tJl0Lk47rW27VEGKHNEEWQFfHZqu4FfnKkiQ9Zyq94CILdZsKQ7owJdjM5/Ch0+bWlsi3dx+RtzgVxNOcH/emLngTUKqI6+Zf0ZR4d7Jorw2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061386; c=relaxed/simple;
	bh=N21AliblMPWaA0AUzxTZ6Nv7AA/MfaFCoxuvbrLNL1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3v7/lO9OsF0kRbgbW/fldWCE/o/F/bDoGH6GoMT4rria/HwN5LnV6lin/6OjC5e1/Eg+hiSTxQJhbwcKv969aQt6kHc68ikfz8mGGWV3pXetA/626ms8wiC0ye6oktPbqIMCEcgu1CdKAfn3R5oNCI4RqtrJvqL7QbdNFBM8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqB7YlrC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jNcno7kT0irEzub8Roey9W2mYI7FYUplQutZ5yVhFdg=;
	b=HqB7YlrCqA1MsqMgsYtmlIsfr11pnb4uno/Vgsj593Jj7PTT5B1FtroDN5E7laWxACaR/G
	jiGLhxXxWsABAYPl/7wlRPsI8nH0jDEe7SLS3vV9xEwX3Nmg0yGXJ1Vc0DkJ93bh7qcYPB
	4gAH9n7XuukXglgmGSRmvtweBpokagk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-EazApKcYO2-zXmK7OdcPgQ-1; Tue, 21 Oct 2025 11:42:57 -0400
X-MC-Unique: EazApKcYO2-zXmK7OdcPgQ-1
X-Mimecast-MFC-AGG-ID: EazApKcYO2-zXmK7OdcPgQ_1761061376
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so19775395e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061376; x=1761666176;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNcno7kT0irEzub8Roey9W2mYI7FYUplQutZ5yVhFdg=;
        b=ZAI8/l967gOku0zEujAaxvF9Il6xgrGUSCeeAWut8H6kQHnmiQgyUaIEm3CP/JDaXu
         0HAJ1SRl/VqvT1Vku8yEif0KN4T1KOJjWHqYT0wkg7QQAaaGGBhzOAfm+/3eJYIahK9W
         7ZAYnEDAS5wMYolAXTH5f+yIZgMJ1fF1ABIbUM+dm3tJIxM81f7v1Bft26BzoLDiTS6N
         HCWYh/2xni4zXia63gNSZ1wos7D6rs+bTRIWWhD6CTdxzQ+dxia+O8+cnZrQuhuFMJEQ
         FFxO0KiyuzCeRlK38WvUXSYt0thmmq1M9pudqlr5Lgeam/xvYYLS084bL8XmlQqBIBEQ
         sXAg==
X-Forwarded-Encrypted: i=1; AJvYcCX+AB/soskUjHaa3uDR7XFryMPlyeEUbrJkhwGFy9CLTKtEUOz4u6QDW0r7ZLNnW2Qqyz/9EMSdzZFyEVUN@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGBHGxosoDd17Xcdlc2jpGWW/eHpAjSfwXUGgCyO51tdPka6s
	XwCvVU3AVl9zJ9LPU+zq1q5tH5NcVSJCWt+vP/X6/qYsuAMM7sZb/EIXQ6wohZipgrAd3zywU/0
	gkFgVDOqJZNGPJj8SeBvtXk8WHqps4qLRn7BsNikUXihxq0dE4f8c8IiPf1/NuynxeK8=
X-Gm-Gg: ASbGncv9Uhy6J46JnjfRgR/IjBXOOg90eWTq20qeOoFV42JT7csFHctvfTFDZhBJrP5
	BEAdwrP13+LwMjBg+cfk6KqjPhgS/2Li0RIKBLpBV8gls6xaBNWXklLLHG1K05JqocnG1Gn/0cl
	PtESD/GFrVhHREU8/Kjxyxv6Dp8HT2uroMGlrEOTfHOVKW+F6JlScX+Dgc6C14Q/KxNwNSskR8Z
	YUsepi94XgxUzMziO7tsbfMaHnzMyEJLpwqlH9T9TT+GeiANSEICOHLa8OyKaNcb61LzazqG8N9
	FHowmomdPuAnCxLAA96iOAP7DtlErCceKjfdRySyS113PRWuWcOKswmDTLhqCv97ZbgkLMr0Sjd
	fBop0Tyewmtx1QSJn/Qx2tM0fur/QM+KDBwQbE3etNN2dG4yGbyEXYx8g2SqW3GBual71OX8KgZ
	E3dYo744F3lAWpnXts0QOIUe/ToEg=
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-4711791fa34mr125576305e9.40.1761061376003;
        Tue, 21 Oct 2025 08:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAXCpx0sJcyJNfRiKm2dYACcXvFmWjsvuh2uNond6HHIL7tB74zy8IJxnnZIUjSnynaOrehQ==
X-Received: by 2002:a05:600c:870b:b0:46f:b42e:e366 with SMTP id 5b1f17b1804b1-4711791fa34mr125575985e9.40.1761061375574;
        Tue, 21 Oct 2025 08:42:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm232749515e9.0.2025.10.21.08.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:42:55 -0700 (PDT)
Message-ID: <88f8477b-5898-4d7e-8583-9d769a34645f@redhat.com>
Date: Tue, 21 Oct 2025 17:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20251017013630.139907-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251017013630.139907-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 03:36, Zi Yan wrote:
> Page cache folios from a file system that support large block size (LBS)
> can have minimal folio order greater than 0, thus a high order folio might
> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> folio in minimum folio order chunks") bumps the target order of
> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> This causes confusion for some split_huge_page*() callers like memory
> failure handling code, since they expect after-split folios all have
> order-0 when split succeeds but in reality get min_order_for_split() order
> folios and give warnings.
> 
> Fix it by failing a split if the folio cannot be split to the target order.
> Rename try_folio_split() to try_folio_split_to_order() to reflect the added
> new_order parameter. Remove its unused list parameter.
> 
> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> also tries to poison all memory. The non split LBS folios take more memory
> than the test anticipated, leading to OOM. The patch fixed the kernel
> warning and the test needs some change to avoid OOM.]
> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> ---

With Lorenzos comments addressed, this looks good to me, thanks for 
taking care of this!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


