Return-Path: <linux-fsdevel+bounces-66560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97877C23C02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92FF188A17D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC470260587;
	Fri, 31 Oct 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ1osqrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607422AE45
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898816; cv=none; b=LwTBdTf9NO8ahdn+WINDHauycn8Z02wWIK9gwxCAiTANEcJ5r62TahAqkJ50NUGt93KGRF9AP+jSajj8no67APr/LbJvRXeZe598X6MRcU7T1C4ysagjXahaxw0pGqA/35z5hvka672QhMNid4ob9rdAquUVlR1md/enbn02rPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898816; c=relaxed/simple;
	bh=DjStNcCklFQFC5J5yune6408twRHTrXW04eNlKeDTps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9OO6Et9wsEgns8tJjNpQoZ/GXZPSTNvRnXWFrVwWVbCQQKC0b0U7xXgPRJQYSfDodwRws0rBGA+i/NeLO+izdXTSSFgmd3SGe7P1MCi+r5Y4UWdGztiOmrJcjtm8oSlDRHT8+QqdnEEC/uvTlFA4gQVpUVBx5Mar1SxPgaBJrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZ1osqrj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761898813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cDgVcdQV2hJI2NPDcWVDicCdli3jcAbg0GKwyVV0rPU=;
	b=iZ1osqrjM2AagptdKR0wLPY4//rBsFj4gb6WjA1BcYf4RVgTIxdUur4VS2D3a9UA4IowcM
	HlfJG9c8ySf2/1gVmJpFBz5d3eYBdox12HpqN5VbOyF9EHeRZKoWWrkFcYYqhhaRhz9V0+
	F6f151cuxDf/TBUqLNYgwQIHLYQApxA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-S6_gHeEtMC2zLk2fips6dw-1; Fri, 31 Oct 2025 04:20:10 -0400
X-MC-Unique: S6_gHeEtMC2zLk2fips6dw-1
X-Mimecast-MFC-AGG-ID: S6_gHeEtMC2zLk2fips6dw_1761898809
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42855d6875fso1181941f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 01:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761898809; x=1762503609;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDgVcdQV2hJI2NPDcWVDicCdli3jcAbg0GKwyVV0rPU=;
        b=Z6mg411XTxOp30vA5RZz9+5sY37IEwn9ZiG3qCmiWgpYP5ovDhdIKqUEJE5JLaQlXU
         9aGmkl5uHMZWAB1Gaz66Qu/W4JgHhilUAx4DBbvpMpA+x0Wt5rYCRLJel6/abFSXwrSZ
         p9XNdqXszN8FkrVSh1qIRypsW7ialEFM5g+ozsgEunpcORflu/3SixdpgD9dmnjOYXKm
         3BxxQHw/ZZ+p93ZYu0cJlNKXLQu6QPsb9CZ9uR+OSFll4R2nVbDac3yvTbtwv41PL12V
         E291cHMMGnMIulDNfwZtLqbGDjfLBwrWlkDeKZ5c0p3aLjJ5+YhpdfsB96G1IgtDRCS5
         cIsw==
X-Forwarded-Encrypted: i=1; AJvYcCVKuCl8b/jLa+4b+e5XW8Z5mgI4TdPrAmaqU+qfgr2226vBrDI8LLc2Ohj7mxqHPE2FiNLmn2wS92DKlzRh@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8sKPS0pJMk6agPsM9j8n79lPjOfzWsNfoN4GlDZhutO2jp6s
	tdMgYUvVAm9RGtndGomkRbpnaD8iY/Bm2sYjeSNkVyKgtnxJOly8MGDSOJ/vnMwLp8ZCQ772lm5
	Ebabxp8eYvru3Lj3UBlRzdrkFVh1Ix7FNYOUQTjedaetA0jjPHp9xRiCNhwPqLxZGvjA=
X-Gm-Gg: ASbGnct37nOZ65S+ZwI5w8Q2RfLYc27ztGEEbW1beUmYd9PlV1e2TAuoKwJV0JMws+D
	YhOfMxpEfE54Hgmc8aQmM9cMX1zrUqtRrgoqtRd1pD9+cMlqWdhYJKuEQxv5APNhUUT8Lsi9Psj
	3/tRe1qULw1KWjimGe7s5Eigcvu2MdEk0PwakP52YUyOGG402BH2i00FcYMjkK00qEGVAvPIoNg
	0F472bZb4Uc4Y9+LWTeePVbZTf16886hxAuChoBQ/uXOYiwuHpFad77fGuR8K9s7aXhjj4uHnS1
	KKRki54IXi2lYuU2vmhuggg00VaZI57hH9a+Egy5giI9meW79C/MLODhxlqbKj5zDAm1Vf6MwH3
	rDrjFeKLcl6/V1PWUHYVtrRkii4nP45Y=
X-Received: by 2002:a05:6000:178c:b0:429:8d0f:ebf with SMTP id ffacd0b85a97d-429bd6b31bamr2108868f8f.42.1761898809118;
        Fri, 31 Oct 2025 01:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtLHunfQFlq8kSDrmkdCLK6e9suDMN6xGjY6xvpAjzPVyIQKf60zAxpxB88JYuxSd2SO07Bw==
X-Received: by 2002:a05:6000:178c:b0:429:8d0f:ebf with SMTP id ffacd0b85a97d-429bd6b31bamr2108844f8f.42.1761898808717;
        Fri, 31 Oct 2025 01:20:08 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f1cf.dip0.t-ipconnect.de. [79.241.241.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f4732sm2190291f8f.43.2025.10.31.01.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:20:08 -0700 (PDT)
Message-ID: <ec843602-63cd-4ce8-8639-51ed49d596cb@redhat.com>
Date: Fri, 31 Oct 2025 09:20:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio
 handling.
To: Zi Yan <ziy@nvidia.com>, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
 nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.25 02:40, Zi Yan wrote:
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
> 
> For soft offline, do not split the large folio if its min_order_for_folio()
> is not 0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
> 
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


