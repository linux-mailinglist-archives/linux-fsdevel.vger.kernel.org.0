Return-Path: <linux-fsdevel+bounces-56136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0EB13CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F2C1C2080F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993426658A;
	Mon, 28 Jul 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4QBF1X4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4F28373;
	Mon, 28 Jul 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711776; cv=none; b=spQH53B9XfDFcgZ2YZZmxz+KIGNVghIIbx+b7V87hRNbgEQVhkG/KxP++mlguAm+Tk6v857vV8EEbY45E0zt4ZZ24aPcg33R/0KZ46RjTU8GQiWZR39XNLNpLbiHMESO0/p+n4UtLAuY8CkEQ3gPW2W+AOG8bnv3NxouL48qiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711776; c=relaxed/simple;
	bh=1YV4mogc85D1EGuTrpnSP5GZuy9mVT2Bq4ILiO9Pzes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2DaQCj/ydmrOQMLHpo34jG7f8znkCbO9mCqKQBIKQaNtPp5B3RaWm10cfwVTfopnO0TdwPZ7qLbwoCZd+wzlxxG7veb0PnJuDtj2BFWpfD0KD54E4BeSiDNvFd6LD02xvNlLt4wvC30XLAWUmrElPfluou2kJJCF95kJfEWPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4QBF1X4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so47562295e9.3;
        Mon, 28 Jul 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753711773; x=1754316573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AoVJp+PzlmK65Fu6OBPPC9Y7UqzBBQP2JVcFxv3Q7YM=;
        b=J4QBF1X4EQw8Z9S3968GiTSxR1tPcYuXMhCQQ0ihVle0//Zcg478/Le66xSnVpFtom
         kJ/Mpqk/a+x8W9Xl36j0snQ6bow9UgjnP8V1aq/XawFfVADFp541EwINXwBIp7ncGT+w
         wuF3H+e8ebvp9fKZvBlWtGDlcc3Ja1CoTCkm9L9S0Qgj0GnSEmuOT7xo0tWX1G4TZUxk
         VMzfCChZPLG08qZW4kda7lM7f0CFhaX5YuJhun2Fz8C6Kd4oLbditJ2MqXqC95tFRKeN
         9pxJ8dIapvhMxnHpANmXjpj+Y2KF2wa08KWS45gu8ohXBjmIPoTifVGfKEjA8SoIfzdR
         U+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753711773; x=1754316573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoVJp+PzlmK65Fu6OBPPC9Y7UqzBBQP2JVcFxv3Q7YM=;
        b=DvY1x6EQ2tqKi6BwEAUSkxCCQHmP2MVgE2oiMYo/DPJtOoHu2WoDgNlkaebhZeBNhO
         OCOLiYeNPMq8Sa9nbyxMtZ9BeKUGtHtAvd6oH2RhV0bUN9H70XNVeR831JvoLEfYkgOx
         8qHhAqrzXlC/BlImYgQp/IrCEzaF1pC0KiPFDyDzN1a2fcU+3b50G4y20IloqWETyJCc
         X5M9aCTwAcyWvQLes/GqqyQvgKTU/VbnrTxz3+43x8Zz8jMfgi4u5OfFfhCvrDmGcrZ6
         mPKI73XoEev8uB/ZkH4K8asSCmsTusYplbNTzVZmcYzjWrxZ/4Dt2Uk0vZgp2ETvB7cl
         Y+kg==
X-Forwarded-Encrypted: i=1; AJvYcCVeyzSpB6Nhlfu91uwUeWvLDtcq83TP5HQ5h3cMm/S86r+6J+7aU1hz4LJr+nUN/6sEAF+JsVbg2Ps=@vger.kernel.org, AJvYcCVrlmEXODrYbdU26o1F0Bb6unswfefokh45/00dwkF495H1wcsNecbZwTQ48N/yQ4DAbG/ckr+Y3cfUcoNJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDDNShqTFLnzKMqemZdkHZw9NPfz4lRprzttXKu/ch/hMIz5T
	Qc8w8NYuMgjbndH51Q/Kq2peumM5/HKPWqABwN2v+y/+7fPHoB5cMcdN
X-Gm-Gg: ASbGncthFKttq0lVNduY0mtuw/1ta67YZ5ayF1WS29wWojo2GHCUDOLekDB77qhmU7E
	RpAmYCr2MYYYYxEZvyFC6zlDQP3lMAR7WRlu4EtTcHEU4Of9KDpGfkT3WoZJEItSNqB5BFM+5kq
	hwV+Q8SwG8F/clqrdiY6Za10AbJPgkubfu3TYEQcbl7NUFoSdYW6oGRIgTn4oJNZwSeAgFwiufl
	WfsZ3K/9brs6opbQfPHhT3nTiEY8STtZ4FHnjZtmOO5gsWZ1PZC+KWXjiC4eclpWsClaKPWMQ0V
	3uZd16vw2PTRYFbwtIFEE+ZbcwxLJz6nGmjwcDArqXBrEGT41f+BrEEkvLQDjzBMY7yhPWgLMWs
	5rGMXX9iuLg69YWsPd3p+3nack/z6I0qXoWCLsF5SHVHoy1muwSc94+vy3vpK2BDcMxPZ4h5k5P
	VsEWyhOvIwdg==
X-Google-Smtp-Source: AGHT+IG1VpKctfAXo/Ciiy+9lJwSYCznXMT+Foj1yo/y2TScu5H84EeoflD48I1yPNL3rv/8mp6TFA==
X-Received: by 2002:a05:600c:8218:b0:456:1f09:6846 with SMTP id 5b1f17b1804b1-4587655b244mr96594925e9.25.1753711772828;
        Mon, 28 Jul 2025 07:09:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:c75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054f338sm153778935e9.13.2025.07.28.07.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 07:09:32 -0700 (PDT)
Message-ID: <e91c3b2c-b3b1-4271-860b-89c8e0d2e2e9@gmail.com>
Date: Mon, 28 Jul 2025 15:09:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
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
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-3-usamaarif642@gmail.com>
 <e83ac8e3-06fa-4ccb-95e5-4f95ba5aba7b@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e83ac8e3-06fa-4ccb-95e5-4f95ba5aba7b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/07/2025 14:28, David Hildenbrand wrote:
> On 25.07.25 18:22, Usama Arif wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Describing the context through a type is much clearer, and good enough
>> for our case.
>>
>> We have:
>> * smaps handling for showing "THPeligible"
>> * Pagefault handling
>> * khugepaged handling
>> * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case
>>
>> Really, we want to ignore sysfs only when we are forcing a collapse
>> through MADV_COLLAPSE, otherwise we want to enforce.
>>
>> With this change, we immediately know if we are in the forced collapse
>> case, which will be valuable next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Usama Arif <usamaarif642@gmail.com>
> 
> Nit: if you forward patches untouched, make sure to add your SOB as well.
> 

Thanks!

Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Just adding above incase (hopefully) this revision gets into mm-new.
If it doesn't, I will add the sign off in the next revision.

