Return-Path: <linux-fsdevel+bounces-56743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA717B1B331
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14566180F02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70326FA58;
	Tue,  5 Aug 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TU5YsPbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2D248F51
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396226; cv=none; b=QzG5XYWXfWFKaOR6Zokr8Dgm+nuA1eGQ1Ww2TasP+IU/EOg8H3REulBH7sfUAx93K67gpY4g98IrCgadpugZRRfBaxHV/bEFY14ORkMiWhRJiR1jcazQwXG20rq+9YOzZdr9DQFms5e7eak+EpBJzdqj1MRIuN2cfZKZI/g5hQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396226; c=relaxed/simple;
	bh=Sc0MxiMy1EvxaKJuID6F83bz6E1qgx5bjiAYdaCLoi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV9O0vjTrDiFwKMc8l102CfdUI+l4ResLmPg1GzYJIf8gg48muMOrAH0MsQ6S6ADcL3nHYWk2SNaNGIqtEthi0q85UnLS7apwkSLkjfUmsTpuSzQmwxYeiJsdJVYbuFodUEGRGd1H4gRoQIW5j3BgUIk/gHBVRp1iHBG9HjgXys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TU5YsPbY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754396223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hnpdZY3v1kEaD9q23EVotFIxNBvlTwoCxf5DTi1K58o=;
	b=TU5YsPbYgLbMy8CqN/zcqzPQ7KqD9nj1a2MNzDZsyQ8ePPwqWPcMaziWoKQzJC0H+t9hhF
	jGEUPUSxGHynocEsmjNBpH5AcLLSWmxKy5Fe3p3a72uOQzXQQtuG7g4tbAaC2UhGHRb7lf
	ioZf29AzrkRALvGN4e+gah/1MTncJbM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-rHHuZ7DbOX-v17V2e4MgcQ-1; Tue, 05 Aug 2025 08:17:02 -0400
X-MC-Unique: rHHuZ7DbOX-v17V2e4MgcQ-1
X-Mimecast-MFC-AGG-ID: rHHuZ7DbOX-v17V2e4MgcQ_1754396221
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459dde02e38so8646115e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 05:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396221; x=1755001021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hnpdZY3v1kEaD9q23EVotFIxNBvlTwoCxf5DTi1K58o=;
        b=nqgltpYeTOsejlS2YjTNHF/4Rbjkr6yizvSNJpleHRIPFhdRprJLEfM1Jpo/HKAose
         PzzJNcc3XlRIMWStII8vQNbsKmJySo43VrEfQWqOHtV7PmsnhzM0AiMKtTznDH5kqqr8
         Sdk+8xCdnEsRRVuUT+98lpQ1LhEU2xw6QkzTZzgy34eLIEFuRauy0hmJqcRRf/Y5wJfb
         9cV21tjNLweuipsg4ldnYIsAaOXeNAqRYPyh9M4s2UiOf65KMndB7Muqyze58yUXoWk3
         WxbernDx5oxAyuA3mZ8AmZ1eQpc7GbsrYe9dhhl4vISRIycLrXtOCdJU09D8XABwofJT
         nqyw==
X-Gm-Message-State: AOJu0Ywn/G3faaiHHo0Q6UOFtWcSAc23HsTPxNM48VHd5ezQbJHtu9gX
	n785SM8+Q9ZNvgBZSCD8ILc+6hYh6JPJegDV4XlXQOUREWrnpb4sL09JcMPilx9S+T2MoWmYAuF
	sJRZ+24MX3X0QJQvsMMgjxjPA/e4TT0wn1HX/MJs9/erRsNCx2W/PfnJEjNDI2hmN1LM=
X-Gm-Gg: ASbGnctBn4bcYYCbOzz3kvc844Wk/dZKx4qjn4ayxDXwDYwzCte7qJSCsIswWJBp3yn
	Pu8oOXQgJVcsliDwCcoEG9uAJlYxua9CFzBTLKLW0IWdQUJicalAnFzNOcbvfFqARonKRAnPeLm
	+/8RXAdc1+1LTN57po2+5/jgiLWJj8culPb09sa2pO/lSC9Znwnt3EnMK5gWtfLhqI0quuPJFRJ
	1IzPJNPPPXuWwJfVIJTubeoEajoAYn4wTFm4LPYrm6sr2oQRcGLlgg7ObMTj4UufaUs3iX5k1e6
	IP6UwwuQeNIVL8ODnMcntGYlGI8BqG8ITK64h2CYKmKQ21c9Ys93SZoEstL7a7jVrV3eYcyLoQk
	mOJN/qzCjX0igvSpHkjOYOJ0axSKacsUYWPvcGtWSlVkmqECe6H5RAefJC1izrrfE/es=
X-Received: by 2002:a05:600c:a4b:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-458b69ddcc4mr99532115e9.9.1754396221153;
        Tue, 05 Aug 2025 05:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrqOQ8A8qIGLA2mvtZF2b3QEhwpenSBEb9wQuyaM/Fmf5K8F5vu/aZnLwJYmcbo9s9KE3dZQ==
X-Received: by 2002:a05:600c:a4b:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-458b69ddcc4mr99531735e9.9.1754396220689;
        Tue, 05 Aug 2025 05:17:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2b:b200:607d:d3d2:3271:1be0? (p200300d82f2bb200607dd3d232711be0.dip0.t-ipconnect.de. [2003:d8:2f2b:b200:607d:d3d2:3271:1be0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e471sm1481245e9.26.2025.08.05.05.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 05:17:00 -0700 (PDT)
Message-ID: <7cb06105-f2d3-40e9-94ae-3d497b9d8730@redhat.com>
Date: Tue, 5 Aug 2025 14:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Donet Tom <donettom@linux.ibm.com>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-6-usamaarif642@gmail.com>
 <eec7e868-a61f-41ed-a8ef-7ff80548089f@redhat.com>
 <2c795230-5885-4a1a-a0f9-c8352b9e7738@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <2c795230-5885-4a1a-a0f9-c8352b9e7738@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Nothing else jumped at me
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
> 
> Thanks!
> 
> I will wait a few days and see if it has made it into mm-new and rebase and send the next revision.

Will only happen next week, after the merge windows is closed. @Donet, 
are you planning on re-submitting you series?

-- 
Cheers,

David / dhildenb


