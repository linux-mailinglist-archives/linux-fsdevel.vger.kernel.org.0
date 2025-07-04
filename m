Return-Path: <linux-fsdevel+bounces-53959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EBAF92D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 14:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12F43B9229
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31D2E3B0A;
	Fri,  4 Jul 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehMoiXrC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BA2DE6FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632549; cv=none; b=UpBwAIRqmY+hsul45IcYjtiuQvAFFl8XSy7GQtigNw8TJSOKx5Lmg8LeV+1p+uOz+WeigWTAd16/8byFxLXHcGDl9JYZfNS001r1hqbiH/F88frS5WEFSohqnbubLXER/PqvxJAOBly8X0cpzHUE1yUnR4Lk0G8Xbu8gx4aXdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632549; c=relaxed/simple;
	bh=25hnLgmD5JD2SLFLVs0Zvjx+Ts3wnoYTUpUdsa0GIxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHgaB0ee0zieIQSRyUE0+wH1agRxgzJny3U1lELbz/SviuhNrHaIqUfmWX8AxhuU6VSFQkrzhxGMUlsIJrikD+An1/A7ZqEuHwGT2bc54hpG+Yx2ENl5EuTXjiYiQZJlMLc0UtUe/3jO4altGry9JyYSeF/5wkp4pik1UOSt38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehMoiXrC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751632546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=092ONni6GgjsEVLjubx5R+ZHpI7Bg+FqEWhGmcactVA=;
	b=ehMoiXrCg1n6Q5CLozsEHT63tO0ZQhv4msmD4O8MYdHRgHJ1CzjEG02Z/fZy0yBt8svMbK
	yuSCr/qhKrtDv7uQSqBrPYhmPYxmRgllVF7OR0wA7j6ZspQEzPJbVHPoIFlqH4pKdDElDE
	CaUf4CLMYCfo2jaFdfRXnTnTpL4uLIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-57QvLaU8NwChQgklBXFlnw-1; Fri, 04 Jul 2025 08:35:45 -0400
X-MC-Unique: 57QvLaU8NwChQgklBXFlnw-1
X-Mimecast-MFC-AGG-ID: 57QvLaU8NwChQgklBXFlnw_1751632544
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704cdbso6397515e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 05:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632544; x=1752237344;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=092ONni6GgjsEVLjubx5R+ZHpI7Bg+FqEWhGmcactVA=;
        b=jvqxU2iy0RiRNIbdIzpbWkaPsd2Hp5CSr3JYT2nK4IsGBKHgvBOC98n0bv1WAdhYxk
         FbHV9JMouCuX9nP00/yGDyzjUCSSpC6yi8InNac0Q7xPj1wVo6FHEKBpWAn6xowyWZwp
         r4PdDPuBgFKWOIOV8ddy5dViIySbvXbFYubnIzKo2VdZAnTnkGsj52IqJzMFTkcmUDlQ
         jrvcXP3SasR60wiW+JMy9rNfG32l+obnRbHQofJwph6DUxIMsQ+IHKApq/FF6p8VfqYq
         j48FUg9PG5zC4t9vRbP5DLLsExUsTL321pzNsltPdlgeBlfvS0WfcIdaOZSHRCE+11ra
         mUXg==
X-Gm-Message-State: AOJu0Yw5kfJM5ERCuC0Dhjfl4fChMp4+1SB+koC9/iFCKSMHcUMh18Kn
	6zAIqy0lXQOn7gfbOV69OkNoImzdhM+uBQLJ/ZKQ8AhBe44ChZ/2EMeyC8fh9KUlftfA8KePTvu
	UvCl7eITOP8yxEUtB4r8ikrDZijuCNKsLD2n8KC9Crzi64AtsruwuOki2zaacH1JKlYI=
X-Gm-Gg: ASbGncsUO5nWtK37E31hf2r9lLokFziz/ZagOe1BZ4Kli130m2yYVSq84ro4d1YHmGI
	xvnQcoG0msSb/VKRnqT70XID/F++TLLNMJDMn3KgNB/RpWYF/W2lH90dXSfnQqxpYuoNjLjw7wD
	nuxw2nYawhIaRrcG1tDMPziBYdBxggVk41pwFuSdlGE62UClFr8oET/aa42pCmMnF9pFtHZlK//
	W1rMAII6u7o4I/a6iWs7ezFfCPyiZpe6zDnUtT4kRcqa6Etn7EvpDHmkqtCe8ExkHxLqZRUWNej
	9JsgVgAPEPiMx9F+8kgVokNAL0PFmykgD9V6Dn4VKWm+smY5COylID3qD4BdjBJrTvStE49/pO1
	wiIy6zwlbtlsU75nbnzHK9t0mkENot+RUjBVWNxETXcgjl5Y=
X-Received: by 2002:a05:600c:8b66:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-454b8081d41mr8460255e9.31.1751632543657;
        Fri, 04 Jul 2025 05:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErTBa5kQ8SumR04QDBcjPXzVbwTdbcNh7VPTM5XAyDTtu/9E0cl/JxQwetoX1xmGUyJZOUYg==
X-Received: by 2002:a05:600c:8b66:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-454b8081d41mr8459855e9.31.1751632543195;
        Fri, 04 Jul 2025 05:35:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1698e24sm25307085e9.34.2025.07.04.05.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 05:35:42 -0700 (PDT)
Message-ID: <3e21f165-3ca8-408a-9c95-e4698986cefb@redhat.com>
Date: Fri, 4 Jul 2025 14:35:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: remove BDI_CAP_WRITEBACK_ACCT
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org
References: <20250703164556.1576674-1-joannelkoong@gmail.com>
 <20250703164556.1576674-2-joannelkoong@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250703164556.1576674-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 18:45, Joanne Koong wrote:
> There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
> its own writeback accounting. This commit removes
> BDI_CAP_WRITEBACK_ACCT.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


