Return-Path: <linux-fsdevel+bounces-55740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C51B0E46E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E83BDFDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C4285069;
	Tue, 22 Jul 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCObwCDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58A244679
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214080; cv=none; b=BQIVvD2a+YR1GaOIcU+q7qzoItXKk5PScpVllNEXFcpM083XBDcRWYQ6Vzxwm1tWehP/bTbuCmHRRh1/oc1PAjHTkZjQdJ9QP7ATanlxncpk2eXx/Fk9uc1UAdR6xLHAiKnAh98RxTU0lXcwRra70ohF5+0fmK2n+XJ6xj3Dzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214080; c=relaxed/simple;
	bh=Xf06Ii7Dp/U7cTysoIicuOfxrAypKNqDC57ouQ2O3Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFbWRlR5ANvK08qXk9v6JSZ5Z+oGVZBxx+0aXfDxwtETKRksgoVth53yvhv+AS+xaz0Nw9DXEkW0A6gROGvekgTlPHe2Z3vFmoitJxjjpfFsp26eOsAI3BZqN4yLE1vJCJpLYEeuOsctkaSpMt8UxZwmemtd9ddpo1ZYg6KiNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCObwCDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753214077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJEsJDHhhwgP15Evw5sJRye4NRXtior93RLURfMCjSk=;
	b=CCObwCDjPQX+11BvwXoK8Qq9QY1E1ltgNn4stLCErU164e7EngRk19E0jaFjaEyEUWAed4
	tJ5ecKifmjUTrev942ytivNS4MpHyUsm5gBWSWWAWhSJzJk0CjgDntdHMHWPiA5ec4STBU
	uYTh0nEBmKXB4c9kII4Pu87oR2HmvfE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-EFfTcZy8P3qDMEckBQkXCA-1; Tue, 22 Jul 2025 15:54:34 -0400
X-MC-Unique: EFfTcZy8P3qDMEckBQkXCA-1
X-Mimecast-MFC-AGG-ID: EFfTcZy8P3qDMEckBQkXCA_1753214073
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso52555715e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 12:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753214073; x=1753818873;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hJEsJDHhhwgP15Evw5sJRye4NRXtior93RLURfMCjSk=;
        b=MRm8zj7DoT/HlfVL4O+cwrnrycPkogKzl6YSEJHHwkvsTzisuLtFT9JXw/fUTGSL65
         5HKGwENcepNk5ZUTt/5WzcRTV9krAVYBrMuCavGooUkEYqE+SRWwxl2pSMLiEcPLV8NA
         0cjFL9uWVih+UjwFfU4emX08IP0XNSJpaP/3+cLaf1OWAmANvtpR/5pZ8tXOAWxFLfxw
         Bkj9uHM9qd6A+BdVl2XAx1cUtSCX5f41kJm7U4M9IsUsEtfGs56jwRVOB4EMilxtEO4r
         vvUxT8DzmbaGNS/odiJ0pxf2YG0p8dsKy4XQFAKixsYI20ZSqeGTwidFZkhF0Iu0AYSt
         Dhgg==
X-Forwarded-Encrypted: i=1; AJvYcCU18lm84rVhq1d0dDgHfqnKWncSy2YVJgdkFkIfBHwaueJLaS+Mj10cUMjocEkPByfp8g8/qxcjBMAq32lJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPR2N20hHqAQhrKEsTXoH8akDQd4UCGXtcJgnEkR0Rhzy5yajL
	5KCNY4NHKNdnT2s/C7UvvaOGkC8sgWY7N+iD+3GCRRZ3HCrBV9DZpQhraj0EWRGl5DK5UC77cC3
	cTlVQu9MM+iEOIni3dkIgrPJ3YR/f3VsFhaJDRGHu2qWoEBO1Ovk7fC1SaRkq2ypMJC9OkbimpW
	A9lg==
X-Gm-Gg: ASbGncs2578zqu/bl1xgP62Ark5wNwjiSQNetXgc4uw5R572FBp+smm6A5PO+XP4WTB
	gS1P7PyaWPX/kN6Ir7kAGW8yVBrsSJsYnOTu7msYOwj3Fxe7Qx2MKu8YrjH8Vav2QlYLdN41qlU
	KCpKcoOrxZyGoDZkFOck3Mz5uLtj7/0MKpUajukTbfTtDKu7D1lBxByAfVucD2ArW1b79Opb/p1
	felMAguI9SbEmv6dzMnIh7ib1Pgp4gRuMbKoK/DycHGQvj9EQCFsNQ/LHpB5VU8jPYtABEgs7b6
	kp8WiAV1jpEucY37PxgvuZ9fsbcl1OGay0dsYJEUuaMPGBgZKvtg1zbosPc1XhaKD/Rw4Jt8J6i
	BP/VJriV+vDCmXHjXjYz2RgO/vN/s82TwTSf7Dz3pgK/IY32HdDuIl6r9XN7Zz4ZaP7Y=
X-Received: by 2002:a05:600c:8b09:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-45868c97796mr1266105e9.10.1753214072876;
        Tue, 22 Jul 2025 12:54:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy8bjruloOQcKDEXBOSsxE2UZXnksvKYgU7LFIJ6YJhSijB+BvbfxvrDV+WVoYprggwmv3nA==
X-Received: by 2002:a05:600c:8b09:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-45868c97796mr1265835e9.10.1753214072410;
        Tue, 22 Jul 2025 12:54:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:de00:1efe:3ea4:63ba:1713? (p200300d82f28de001efe3ea463ba1713.dip0.t-ipconnect.de. [2003:d8:2f28:de00:1efe:3ea4:63ba:1713])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48719sm14470065f8f.47.2025.07.22.12.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:54:31 -0700 (PDT)
Message-ID: <551c7f1f-93f2-48ff-ba00-259bb2c391d7@redhat.com>
Date: Tue, 22 Jul 2025 21:54:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] mm: rename huge_zero_page_shrinker to
 huge_zero_folio_shrinker
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250722094215.448132-1-kernel@pankajraghav.com>
 <20250722094215.448132-2-kernel@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250722094215.448132-2-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.07.25 11:42, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> As we already moved from exposing huge_zero_page to huge_zero_folio,
> change the name of the shrinker to reflect that.
> 
> No functional changes.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


