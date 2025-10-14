Return-Path: <linux-fsdevel+bounces-64139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C5BDA1B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C4718825E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E42FFDED;
	Tue, 14 Oct 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxx1j6Yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C12FF66C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452728; cv=none; b=bRyo2XyRRCSKhsw2iQLc2Js3PLgxKgIVRGzYteCe9ex6hc5eHXgrTTOSm+6BZNfKHV5wYKB9G5MRKV3zBrTfMJLXeC2vURjjExkvqbTc7QG4zpVDVjtKNSkuRHcXOXPqRxZojmtH3xUvYEUZFdUk3APo2aXBzfYeFuo8quW1xlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452728; c=relaxed/simple;
	bh=pJWe7byBOlQqnKqLrOYhqKpwXNplJ3Z0iiawGMhWBjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpjDlgXrx7eA24UgSF4I43qPwk0/1dwgtWaakwT37VNhxE/+h7K5Rk9irjRx2mImLdQfo+mgpUTUvfXUJq05BmO/ruHeUv5K4iuYEt/RH+7JzZPW3k17lGQv3LVA5V5aGx8stuJ1W5Z4bJopjunJSf4t0MNPAZ9PROcJOT7fYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxx1j6Yc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760452726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cYeRS6sFSfUzQPJ/HzyrxnFwO5qGv+xZs7JP4gmO3GU=;
	b=cxx1j6YcAjfu+d0gSOM68qhdkocPXotT1GB3eM4/GG+SGM5XtwUj9jhcTJE0pIbNd2k3s5
	SFByDTZm4AkBbRCQXsZn+05TjU394Nmbg7C36yoKeM2n1JBJYIdj7YEokljipRk1WUfC8M
	Ct1LbnP2aPbRK8qxfbxNwZpkP5Xti8E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-UC1kiHOhNHSE4mLKCKK5tQ-1; Tue, 14 Oct 2025 10:38:44 -0400
X-MC-Unique: UC1kiHOhNHSE4mLKCKK5tQ-1
X-Mimecast-MFC-AGG-ID: UC1kiHOhNHSE4mLKCKK5tQ_1760452721
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso34863525e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 07:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452720; x=1761057520;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYeRS6sFSfUzQPJ/HzyrxnFwO5qGv+xZs7JP4gmO3GU=;
        b=Cy9jBIsl8eetidDdrnb8avcoIAQnA+EC2HPtBYMO+2wy8o0f/PIh8EaK40GzOPHcfo
         ywf63EvCYwG/jX6DGSxz+CkKmdSdO6Eo1/lrRJrYm1uhBAqcFDntKUYan/c/8kExfiKb
         u1/Tuf0XZzuGTjOkTLEysjW0K2J1GHysLL8wbdR0lvEF+qU+FOaxHVcfuEOfL/pjuppd
         rdZ8KUnMECHoIxPl0gQlAf8+3WMGGSJo/3lXnz/eVhYA/viFmqUmJhXTj9ICGanYzY0I
         j4eB8huH2WWhfL4SsJ0Lpc8rGlG7ci2ouKpaAhgXaSleF3OfiRU+G7gqPHr1y5NF1Ykv
         jsoA==
X-Forwarded-Encrypted: i=1; AJvYcCUI1nFfNX3Gpdj+IbsxHyfY+svdeSyip1yAnQaWOHMhAHzkxr8C8eL8eAmx0xgNL4vRzrSaIXin8op8Y9CP@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHbbnQL9N6PpvMRBHm2zmKPxWDAfkQwPdcNC36uFyj3nbCzoX
	+DNxoAqn+NU7InSvJUN8zagU1nJuEfVOFJXpoKmr1sYQqLivoTLpGwDBMtwH5cIdnl0BWszLewZ
	k3JSxFOlqDsnOZpU3Hs1SGfdvqYkolUT50VF9HSEvcNxu7pv0GgdJrT8soHg6TbZo5VI=
X-Gm-Gg: ASbGnctjMjh2szbsZ1tZdlLbKPDnONBUgXZ+ffWenP78IoxLbi9Oxd319CeGWCVOQwu
	N9HqhiN0bRuWW1X4qTggHKZ+vhkpwwaAJ/7JrAnnD6oE2MApdR3XwkDOm85q2v2ziDG74RdioTN
	LqihcsmHumoxT55rw9ellNI7oMuSrS0qgKOwuWmh5oEAh0KSx37AAWC0W6SJ1vIH05b6gUuJE4W
	3DAEa3yvOeUKpGrZSUdW+bZagdUdudvJ1t8PRKjNV++QKX86GAU7s/azObtOOH/oE3AIxwbZmgx
	Ayo/EVVJngfVPGh4LoPhpgW55yXX6+l0ey+BCjoM9Zj8FGss8GdIyM6UZxSCctIpJ62dX7ze9A=
	=
X-Received: by 2002:a05:600c:3b07:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-46fa9af84fdmr176220715e9.18.1760452720551;
        Tue, 14 Oct 2025 07:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqAi05EmmQ/BhcD7IJ1mPJ/c7tINcxGNCVLG0i5FW47498X+2N7oVmLZuv/vdT2Tn/vHNVhg==
X-Received: by 2002:a05:600c:3b07:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-46fa9af84fdmr176220455e9.18.1760452720163;
        Tue, 14 Oct 2025 07:38:40 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc1c5227fsm183080505e9.9.2025.10.14.07.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:38:39 -0700 (PDT)
Message-ID: <f9d19f72-58f7-4694-ae18-1d944238a3e7@redhat.com>
Date: Tue, 14 Oct 2025 16:38:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
 <20251014122335.dpyk5advbkioojnm@master>
 <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
 <aO5fCT62gZZw9-wQ@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aO5fCT62gZZw9-wQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 16:32, Matthew Wilcox wrote:
> On Tue, Oct 14, 2025 at 02:59:30PM +0200, David Hildenbrand wrote:
>>> As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
>>> folio yet.
>>
>> We do support partially mapped PUD-sized folios I think, but not anonymous
>> PUD-sized folios.
> 
> I don't think so?  The only mechanism I know of to allocate PUD-sized
> chunks of memory is hugetlb, and that doesn't permit partial mappings.

Greetings from the latest DAX rework :)

-- 
Cheers

David / dhildenb


