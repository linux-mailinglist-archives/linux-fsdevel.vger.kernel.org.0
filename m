Return-Path: <linux-fsdevel+bounces-37837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA249F81D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FED5166D41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF319ADA2;
	Thu, 19 Dec 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggzw0vb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916C1537C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629205; cv=none; b=UoXWwTCcBwNZtM7VgvkNlRGrTFHHzRC2pQYHfu7Sj9BmhiUVA6V9/mXdvICeH7xZGMdmN388x2JU3JJrcEXhjvnLDbcrlOAer9Bo9dmwBNtQSMPekKuo5Hl3dsbOAkmdIvkhgD+kWXH10cCe+vZRa84FBQsCvWkgT+YfnnCyM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629205; c=relaxed/simple;
	bh=wSdnzF2ZsEZTsHqYpshz275GNKOQTFVrv7bQEV+ERc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zlr9/pBEgDd5HonbYKXu7WQn7Z3cZzoHehqpUqD2r8QJiVirjmlDNCcFz4vr9oV9fKUDEdJDt9z2tFaQLuiX6rGZQgWUWzGNvzPGrHIFPH+FD4k3libAraMF633dHYdsaV/+dMUONR4ITpcvUSy9jIK351r7L2cToINE96JN+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ggzw0vb4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734629202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ub53tEKKpHaLHLGfmva6TU5Ud7A86uCEkz+GUzGkGRg=;
	b=Ggzw0vb4V8xVG9wtFYC5Ex+nKgwTC+2Z7yiPgFf70TneMWHlpyOHsC9YlAFRgUMpbLAynh
	/q8n5ng7ORcmm/26/ILOj3YohSXRWX1dAtwnEr8CrZM0w8v53C+ATFzbd6yqVA1lXgf5vH
	yq61vCftGFC0TIY380N8NTFJifik2AA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-vbDlGVUKNkGCKwKF-uaNPA-1; Thu, 19 Dec 2024 12:26:41 -0500
X-MC-Unique: vbDlGVUKNkGCKwKF-uaNPA-1
X-Mimecast-MFC-AGG-ID: vbDlGVUKNkGCKwKF-uaNPA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so8636585e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 09:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734629200; x=1735234000;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ub53tEKKpHaLHLGfmva6TU5Ud7A86uCEkz+GUzGkGRg=;
        b=OFbJWOkQkhouH1iqP87bVgzWnww/4mfSRz1GjoxAHvCIDedV7178mMXHSo++nY8Juf
         Oo+8ktonGB2Zi+S9kJv0AASCI//h1QHoAi8sgyOwAPWR3ms8TxrIQMqnDkFIcC0e6zKy
         1byvTps2mJY28bV+9VlcwLLVbqKt/nYBYRIG60xcGcxYJADpptd9i46du0FUV5NPUAI/
         PwPk1SumzQMLNwLA3GyVy9v5UfRITRXUyfDsEvKLy43xv9Z5R7zwbWptps5UGvS3pR2Q
         CdWY8Wj6UzOUil5nmgQFFlaSNux5P0DFdRcecxUKDAC7/sCCsOpuwVnXNmodEYCdwhxy
         Mb6g==
X-Forwarded-Encrypted: i=1; AJvYcCVaAllESJ3+W4DRBcEXKQDAyiTUdIln6mMggluEOyDpeVRqPAU24Dqa/Kc+6LlxLGt5iRN6ifZILNUa3U74@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VNMgh+Enjm1kH7rfo3n5Anp5JMbNl8FXaW1m2CHIzqv+WFII
	K1qfE1R7y+na2gNnXx8SV7hyANfbUQnw+yaBzlc1FwG5nbKMNLPDaRY2q8cYg4Uama4KDNuSxNl
	2bIV4/4kGeVvRL7/KQAY2gZltUvELW6GjA/flfdezBc1NKDj5oexet5T1YmdSLvc=
X-Gm-Gg: ASbGncuR1UNRDMzN/TwfAslExdqAik/UdHkOYSUsY+rh9oSMmTmFC4gQKurxBRU8AGR
	//Dxjf5ao7FhW6Ia9sozrWFyCGNsAGT+faMGLZQfsl5WpQg9im7wRwyvS2mizcZP0qE1+oPixg9
	KPAYTSlWwawexhSaOzN/FqVEe8EERY2ARgX4KPUcjEGPQgVxh8mOK1KyMrJC2Gtt8EM4i1wyjIf
	0oPzvle4kfMiDJvxS/eUWemMMvl6c2XqODJMVaCMHrpJVEzg4pJi5yxY1BAvhRGqOd19zIA6Erz
	5g6lzhWllFtVEhPIPfojzuiZOIN898oy7iWesxgjHEZRfa0p1XxDZ5MFa1XpvRv8kZ92hNVq4Za
	lpu1Ttw==
X-Received: by 2002:a05:600c:5251:b0:434:a10f:9b with SMTP id 5b1f17b1804b1-4365536f03amr77621455e9.14.1734629199850;
        Thu, 19 Dec 2024 09:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCx/KYS5Pg5NMgelVTndJVSDJ5mimCuJ0unXzXJyfKUE5VSlM6AhylRd9pHhmuQ8lqU17F1Q==
X-Received: by 2002:a05:600c:5251:b0:434:a10f:9b with SMTP id 5b1f17b1804b1-4365536f03amr77621255e9.14.1734629199505;
        Thu, 19 Dec 2024 09:26:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b214sm58787145e9.28.2024.12.19.09.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 09:26:38 -0800 (PST)
Message-ID: <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
Date: Thu, 19 Dec 2024 18:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 18:14, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
>> On 19.12.24 17:40, Shakeel Butt wrote:
>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
>>> [...]
>>>>>
>>>>> If you check the code just above this patch, this
>>>>> mapping_writeback_indeterminate() check only happen for pages under
>>>>> writeback which is a temp state. Anyways, fuse folios should not be
>>>>> unmovable for their lifetime but only while under writeback which is
>>>>> same for all fs.
>>>>
>>>> But there, writeback is expected to be a temporary thing, not possibly:
>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
>>>>
>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
>>>> guarantees, and unfortunately, it sounds like this is the case here, unless
>>>> I am missing something important.
>>>>
>>>
>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
>>> the confusion. The writeback state is not indefinite. A proper fuse fs,
>>> like anyother fs, should handle writeback pages appropriately. These
>>> additional checks and skips are for (I think) untrusted fuse servers.
>>
>> Can unprivileged user space provoke this case?
> 
> Let's ask Joanne and other fuse folks about the above question.
> 
> Let's say unprivileged user space can start a untrusted fuse server,
> mount fuse, allocate and dirty a lot of fuse folios (within its dirty
> and memcg limits) and trigger the writeback. To cause pain (through
> fragmentation), it is not clearing the writeback state. Is this the
> scenario you are envisioning?

Yes, for example causing harm on a shared host (containers, ...).

If it cannot happen, we should make it very clear in documentation and 
patch descriptions that it can only cause harm with privileged user 
space, and that this harm can make things like CMA allocations, memory 
onplug, ... fail, which is rather bad and against concepts like 
ZONE_MOVABLE/MIGRATE_CMA.

Although I wonder what would happen if the privileged user space daemon 
crashes  (e.g., OOM killer?) and simply no longer replies to any messages.

-- 
Cheers,

David / dhildenb


