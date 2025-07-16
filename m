Return-Path: <linux-fsdevel+bounces-55140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A3B073BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD9503DC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222B2F3634;
	Wed, 16 Jul 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORJW5SIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09A2F19BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662524; cv=none; b=kcWwDowgd3qEcwLAuQrchZ/esFydzAAZvzjklATfu1OYJI3u6Pqwmg76nLwfMuSbn038JZVxTSpbISXQ4V+Hdpvjo2g1gW/DPNLDFThKM0xXOeJJH2UFtoM+nwWq9kRHa7mNNCwFORF5BBqWVI3F67lmmw6SlGFwY6tXFhSqRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662524; c=relaxed/simple;
	bh=t/j835raHd3VaE5W+kUfYlVRw+/b2dX64MqgC9/XWhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYhchnqGpV6NGaWVgYAZlOcJZ7QwlzCy5AWq8npn/xtZQyy2dUvHPY/MF2mWNeUAY6sCHXYytHy2raYNP8+kx9ff0BvtKfQe2wwvrBw2BmL4FeFdqNl03bM3lY2sbl6oK6OozzRFXYr7SlyRIh/rSJsfQ+BdyBL/TGlKiLE+6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORJW5SIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752662521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KZvGvSA7aEFcJN8ESUaEjxX/jyrkl9OEvc1HbXBJCbA=;
	b=ORJW5SIOvqfj7QUIz6GOoquZwEq8OZggRAPQDEkCa1HNv+z6tCVgfQuxFni2z8YgremFdm
	u7GyszaeVXFx75o7HC+PDihzaPYsVnpKRs2HLIKjVaEXDom0ZvTW+kTfa8mUv8zk3lrpRp
	yg35c+DWL9rd1EZ9/z4vvKLSidR3eq4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-K2_Uazi2MXqd1NYu7fY72g-1; Wed, 16 Jul 2025 06:42:00 -0400
X-MC-Unique: K2_Uazi2MXqd1NYu7fY72g-1
X-Mimecast-MFC-AGG-ID: K2_Uazi2MXqd1NYu7fY72g_1752662519
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a579058758so2611444f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 03:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662519; x=1753267319;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZvGvSA7aEFcJN8ESUaEjxX/jyrkl9OEvc1HbXBJCbA=;
        b=BeqDodJUU+nzEzIb2vh+P+sj2WxhjQTh0r8kCeH8wLpR6mmaKdAVDKyrbjO9sWKb1c
         fGySRbrrunt9oCEDRxLfCQUAOcbRTYzSPElpnUK9zoFJhSC29FXukij2m/kWu+QjPr1N
         VjoP7W2yFGY+bueKMYqavgPmaocegJmLpSPhahPgIcP468cJ03VuB8/5grOtDdRoPDsO
         5riqxudBG9MZ/LPgekADYWrjzaMVJAxi271OEu7j38NWX+FFecPcFAnK390vjYI8c1dO
         NowjOYLokudHJYLY7Fs4Ktpdo2mBx3I8zMuWCVJfumsfvMvLH/SmML4JnxjnK+VFgrhQ
         56nA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJ/mObMA1GUsCULneW7dm88yQXyunKfBPw9FhiZiL+ZZYNH7/DdoCe2juyHAqa1dyYueLgXGPeJTu2hDN@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBypFWQdFOWqBgK9tOlrPWydCvIpliSPGMeMjlDhwReJK2ebg
	VgABH9HcUf8u7+0oV1rgo468qsqFIUiX0jNjBQal8kWjCJS+ImIKsQ/JlMvny8IzbsqmLRpxKIw
	0Bvt8QcOwX5IzuKyI6FiAZGNEQ8btv/2u+zK4qrwBsIPgC1G0OVD75zP5Q9re9mCtkqM=
X-Gm-Gg: ASbGncv2OyhLPxLoWP4mBcBCWIAotOWRjqn/Rlv5zxSIZNNlRvErEEtfX3tFlb6F86l
	H0lIJJ1EoEalTMwoKL6FanGwzduPfaAvo9HK8uwkE6Q/HkHJifRgo/IRftlnqTiW/LV7LCIjLen
	yANZ3B+UfuSb8HVu4NgMI5zj89Y+hxCuBlC8qBGwSxt61TwIn+ScRjym9og3EMgFxjVGIoEB573
	m4UHDNKYvZ8V73VlrF17cJh9mfT1Ef9UkJvv0H8Ww80O5ak4AnkFhKq0iKTMGhItk/v6//3xt4C
	E7BNEbgH5R3ypv+u+mhqRvAxHfQ51lP9nXWqNpD54eTBCPnyHX3A365DmhmhpaAjTK1a0e55+Sg
	wplEe9HIjSlgAlxpZ2GNB+YBN/0C8ZFOjnFbld0wSli5DlwokytxIknBdrZdMNQqQs9E=
X-Received: by 2002:a5d:6f15:0:b0:3a5:3b56:974e with SMTP id ffacd0b85a97d-3b60e4c51admr1372869f8f.6.1752662518794;
        Wed, 16 Jul 2025 03:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjjhAa5WDswEwk0O9wV4JS64Gunk3AYrtcQlTaN7TDrrKomRBIYR6DAIAzxO0Qptve83NGNQ==
X-Received: by 2002:a5d:6f15:0:b0:3a5:3b56:974e with SMTP id ffacd0b85a97d-3b60e4c51admr1372841f8f.6.1752662518390;
        Wed, 16 Jul 2025 03:41:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0dbddsm17753487f8f.63.2025.07.16.03.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:41:57 -0700 (PDT)
Message-ID: <13a09edb-4fba-4887-a809-acd0745dc261@redhat.com>
Date: Wed, 16 Jul 2025 12:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250716030557.1547501-1-surenb@google.com>
 <20250716030557.1547501-7-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716030557.1547501-7-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 05:05, Suren Baghdasaryan wrote:
> Back in 2.6 era, last_addr used to be stored in seq_file->version
> variable, which was unsigned long. As a result, sentinels to represent
> gate vma and end of all vmas used unsigned values. In more recent
> kernels we don't used seq_file->version anymore and therefore conversion
> from loff_t into unsigned type is not needed. Similarly, sentinel values
> don't need to be unsigned. Remove type conversion for set_file position
> and change sentinel values to signed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


