Return-Path: <linux-fsdevel+bounces-57884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EFAB26612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E8F18896AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C882FFDFB;
	Thu, 14 Aug 2025 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxOYGTLK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4F2FE07C
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176363; cv=none; b=PMhsqG4azfMuiLhp0VAG81wTuwffLcnVBw8/T0/cHHJz8GmavNyQDcb117hAD3tyPS1Yte2AA6QL+Qr2RgwR/4WaoRsZtiPFOQ4bmkYtPEkQnp9fhnevQvjFxMz5qpupo2xTFmaljsniyUJi5ArMuPnJU3gN94keg+xD2aSx0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176363; c=relaxed/simple;
	bh=lpcy5pD+EwYOeWX4XiJByNE9Zu6T8tfIZy/8aoPzZWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR/9D0RUiMaV9OMv6WL2yquj8Vt96Ai7ElucyKgXNHsFyKPdpdg8CQEd1mzw6IznNGxNgkoxf6W7ExFmuDO9QPfYQNg+3zQIAzhdSNSdJH6FVDqwfJJnS4mtWpJGeoEftljNpDJSwXRCMBGlAHSWdHy+3+lz2zti+f6vhSYKRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxOYGTLK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755176360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3t0CR39RiS9bo6V+bAaM9oWX90Si1UImEXsrmk0A3lE=;
	b=GxOYGTLKZlwyWjv4VdVti+/5VXNdAbmUgjz/b+vPAn5JsptZpbg50OtLqCfEkYhO/ou/oo
	/0K4CvDZ2VVNOzMCTJHkMXT6JoxujJMADv5CRpsOe8ZgFC1NL3yp/YLmaMYF7XahaeY4UW
	JeaB71ZYasFAvPVtD6lg8qAb+Sl5mis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-7_Y7f2DtPGeKHOo4w4sL3Q-1; Thu, 14 Aug 2025 08:59:17 -0400
X-MC-Unique: 7_Y7f2DtPGeKHOo4w4sL3Q-1
X-Mimecast-MFC-AGG-ID: 7_Y7f2DtPGeKHOo4w4sL3Q_1755176356
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05d8d0so5076135e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176356; x=1755781156;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3t0CR39RiS9bo6V+bAaM9oWX90Si1UImEXsrmk0A3lE=;
        b=qD9Tq0bMvQqeHdpU1ZtcIHyIr7nFcvU863H6jlDqyUfbD9zcaP5Ljik3DMfI3OiTaE
         6zaLSSySVvB3G6zfa6dgEqTPhhxwPTMZqEEA2UXsug22A4m7F8A8ipMWJUT2PWGX4sSF
         FYvgfzxJhw+VwuNo8TQOoi4HhNnE1oW5tO6JD7vgWE/BSKkBHVZu5FeABs8HmwuZk2O9
         lCmSVsc2OZsgBTTpsweyI5HckSdmHdp3QF7K5gCtolKf08UchFmM/8Mmb/DoMltV+fxD
         08f3lcQdqCVC3KHrvKeFWzYbAaD6eOSxX7bOhxHeVeJbqOdKKTI85+e4dppbrK/Zsza/
         prZw==
X-Forwarded-Encrypted: i=1; AJvYcCVUUHuqMhkwgGa0aDZRZDWSU8K3hRKBQiN9neHwkBXU8QfOPXFQi8xO6OcU1oG1YwCuiz/ztWdXk9gJ2r5B@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoHaKXBvK5nEchi0Wu3N6n+Uy/fia/SyKnl6sTkcfS45MidUh
	Qv+Tma4EgMf4QBm7qU0ZopI982BLlJKHSYZYc9koPbUWB28auPu7w9kv9Bb9Ht91aIVhJmk0O4T
	wDB1YlL0SIVyV9HLZDS6eEEO1FGxsNhxjgMYNEBuzb/h3xUeIAolb224dEAA2sTdngeA=
X-Gm-Gg: ASbGnctZKt+MZLC3IkWpNjfaIhgl9b32esiIcMGQm1C1dAb/MWa5riCLQYCclySsHWQ
	whCUy+EwvO+hoCpDl+IrdV+wcuEH3z+ygkScOpw1nWWBcIc/dIym7MRSjx9e1xMudeerV8Wzqvy
	bF9XRnw4lgeg1Hb0MOjKT3FG3erEL/1Snkz3W8JaJZN7oz3OJ2S6aLTI6EkT/jtXQ7IS5LCjkD6
	ixnQwcXUUXo/HyhdoHklYnLPK0cnidWiy/Cb0cIurmE2ksZwPF4Mbkqqcish40Fc0TwfS/MX2EP
	XM6j6WyTe8aQ+/2FStnTYQvlGgFwifuiGWFkm+yyC5s/x19eQezikkOR71qLwdydB0RSEks2Biw
	tgqXSWcSn3aj/wJEHLsdO6t8vX139FzL7fm0eLae3q0+ajofjxwhq2/NleALJLg6fQrU=
X-Received: by 2002:a05:600c:5491:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-45a1faf691bmr4202215e9.4.1755176355892;
        Thu, 14 Aug 2025 05:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCXUPq3MF/2LcfaRa34zIT915GKLnG74JH+H3ePtWgYmrBLGllfjQvCJgjkywipvIy1ObAlA==
X-Received: by 2002:a05:600c:5491:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-45a1faf691bmr4201945e9.4.1755176355455;
        Thu, 14 Aug 2025 05:59:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3e00:9fca:7d89:a265:56f3? (p200300d82f443e009fca7d89a26556f3.dip0.t-ipconnect.de. [2003:d8:2f44:3e00:9fca:7d89:a265:56f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cfed5sm19815875e9.7.2025.08.14.05.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:59:14 -0700 (PDT)
Message-ID: <1387eeb8-fc61-4894-b12f-6cae3ad920bd@redhat.com>
Date: Thu, 14 Aug 2025 14:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
 <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
 <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
 <47e98636-aace-4a42-b6a4-3c63880f394b@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <47e98636-aace-4a42-b6a4-3c63880f394b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 14:09, Mark Brown wrote:
> On Thu, Aug 14, 2025 at 02:00:27PM +0200, David Hildenbrand wrote:
> 
>> Some people (hello :) ) run tests against distro kernels ... shame that
>> prctl just knows one sort of "EINVAL" so we cannot distinguish :(
> 
>> But yeah, maybe one has to be more careful of filtering these failures out
>> then.
> 
> Perhaps this is something that needs considering in the ABI, so
> userspace can reasonably figure out if it failed to configure whatever
> is being configured due to a missing feature (in which case it should
> fall back to not using that feature somehow) or due to it messing
> something else up?  We might be happy with the tests being version
> specific but general userspace should be able to be a bit more robust.

Yeah, the whole prctl() ship has sailed, unfortunately :(

-- 
Cheers

David / dhildenb


