Return-Path: <linux-fsdevel+bounces-45447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6340AA77C25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115CF16B0CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856F20409B;
	Tue,  1 Apr 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN6Uq0it"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763A1F930
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514348; cv=none; b=Ko7LGm7x8xxltoh2v0sdlqkGsSPtvRluqK6+3lvg+vHNxw93e5eLSP/u1O0W6kc+R10WdP1c4xC/mJV4st7pgflYfnmz5a7//X7sGSfoDeKVSzByiYxSJn9Wth170YCOlVXbpDdcWXb8kP56s+m6EVkeQuY6XAyfqx86+huCi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514348; c=relaxed/simple;
	bh=Qvd0XAYxzndqupPu8TkrcPdOBwFBHcRov2itHCUaUNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDmNgiFiWV1ncYFIMcdU4t6ZT1mbRo0gZS/ysBiJk05aVs99qtS/2AWzh6sGfNzmvcdgDcUo3xEksoUpqc6AiDrLTiEb0nqw8UNSQLJBtTYLKZlxh6e0Ldb/WVsZxmnVwRUnOP4Ko2w3L1MEleCcXsLlD2x950veWbp+/bU+vhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN6Uq0it; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sJ1EzOeMWUiKJA0f867xhDZEsw0/li5T0Nd7mgeA0bs=;
	b=CN6Uq0itEnViFIUAPWCOhmzcqxlqSW+4ZGF2Bu6DMITlYqNweAUxtNh53zTic4E586jSHb
	EZTL7+DUeOFO/K3WxWl8l3s6fU4tDdJl8267bzO73AwKHC5ErKWEc5o8NdHuFGQhKtvEuL
	h6MxF9CzFkXm1ATG4WRhVtXwe+MWz5k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-5VnAFTSHMn6I-40Yxm6GLQ-1; Tue, 01 Apr 2025 09:32:23 -0400
X-MC-Unique: 5VnAFTSHMn6I-40Yxm6GLQ-1
X-Mimecast-MFC-AGG-ID: 5VnAFTSHMn6I-40Yxm6GLQ_1743514339
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ea256f039so13670755e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514338; x=1744119138;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sJ1EzOeMWUiKJA0f867xhDZEsw0/li5T0Nd7mgeA0bs=;
        b=cPFq+PvQnr54QxZjBLCQ9QI+H/YAPxzw8nLrQrN8wG6tXzv3QJ542/JizY/RWmLLHA
         OUPSduelqNqWQzozLrOR7Nd9T+0l59P61sP4MS8fD/tEBbg6KJfPTrbzakmpR9DFN9KI
         xA6VtdmvBi/cg6BAgy6MEPOvrDEqBWaR3wqgjnwzgeiAgNCuqrMgPdLfLIj4qwFv0v7m
         tKK5t3ELDpWUBQTbq2f9NlxTNPOW6K5B1qUIkgWT1LD14Rp/tx1Ysk73kgsDTTiDdWmc
         zt2dy12mm1S7Pl9I6aIBfcIfvTRvH5UhHALxnysxow+Pr0fepPr1d2mrZF0D2rERMpz1
         K9FQ==
X-Gm-Message-State: AOJu0YyhnyS5akpzH8Kv8U4MpJ7gimwmsAmjMxLHCnOaiyYkxjpJUR9y
	n3DW5f8/HhPXiCjSe/wsvCfAHq2c0UYtaP9bSNnx5mQ7DGXGf4CHPU5dspEMwx7bQ+fgIx5YRRK
	nzihtDcrofcFi+W53uSEIwb/UY/evG7dv+0kKxbu1HmsBcSV+khfWeQyD5PnIdPU=
X-Gm-Gg: ASbGncvTWU3LG/euGh0ALS6gilw6vJ38QKvIfkNj7uWcpcTTKUn9IAqSXEI6zmjlPym
	sMfzehuv5HNxfKY4GB9lrx5JMOXH2W/XwWqnBbw7n1J/CZu3cA8cmAXVDyC82cncDqCa8GS+4TF
	hJmF+FTAjwVO4XNBJSZ6mUq93Pr9mXK5zPUNUQa75+2X6nFQxN4FSq1H5ff/wu06dHWyOhuWeFu
	O32EkHXw2TtiRrEN+5vJjJH+5ZIkW2mCTh01/jcliLOmxFWPDs/jqesRA5ivU6U7VjGcKRKKth/
	3PvZWjL/mRwOODR/rmSBhldJwxaE403+XSff97vbp6QahJ2oj8LpaY4pBmSl40GBsaE3qD45tSL
	7s2ivlRjxgao9HyGOrz2SJ7wBBtn0AWmj90Lsh66j
X-Received: by 2002:a05:600c:4747:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-43db62b726amr104175455e9.23.1743514338539;
        Tue, 01 Apr 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9H0Zs0TAn/KOqN3yRaE82yn6P7LcocO31c/mwIX6D53TADopy6k5fq5SAMG/q8wXKsDUy5g==
X-Received: by 2002:a05:600c:4747:b0:43d:82c:2b23 with SMTP id 5b1f17b1804b1-43db62b726amr104175185e9.23.1743514338180;
        Tue, 01 Apr 2025 06:32:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4d00:6ac5:30d:1611:918f? (p200300cbc7074d006ac5030d1611918f.dip0.t-ipconnect.de. [2003:cb:c707:4d00:6ac5:30d:1611:918f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f84sm156099075e9.25.2025.04.01.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 06:32:17 -0700 (PDT)
Message-ID: <cdca1510-7b8e-4fa0-a3aa-c66ea224f400@redhat.com>
Date: Tue, 1 Apr 2025 15:32:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] migrate: Remove call to ->writepage
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 linux-mm@kvack.org, intel-gfx@lists.freedesktop.org
References: <20250307135414.2987755-1-willy@infradead.org>
 <20250307135414.2987755-7-willy@infradead.org>
 <D8R539L45F9P.3PIKZ5DUGGVS8@nvidia.com>
 <Z-WCMYYQRsrRlikA@casper.infradead.org>
 <D8R80OMV06HN.2MXFKF6L5851V@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D8R80OMV06HN.2MXFKF6L5851V@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.25 18:22, Zi Yan wrote:
> On Thu Mar 27, 2025 at 12:52 PM EDT, Matthew Wilcox wrote:
>> On Thu, Mar 27, 2025 at 11:04:57AM -0400, Zi Yan wrote:
>>> On Fri Mar 7, 2025 at 8:54 AM EST, Matthew Wilcox (Oracle) wrote:
>>>> The writepage callback is going away; filesystems must implement
>>>> migrate_folio or else dirty folios will not be migratable.
>>>
>>> What is the impact of this? Are there any filesystem that has
>>> a_ops->writepage() without migrate_folio()? I wonder if it could make
>>> the un-migratable problem worse[1] when such FS exists.
>>
>> As Christoph and I have been going through filesystems removing their
>> ->writepage operations, we've been careful to add ->migrate_folio
>> callbacks at the same time.  But we haven't fixed any out-of-tree
>> filesystems, and we can't fix the filesystems which will be written in
>> the future.
>>
>> So maybe what we should do is WARN_ON_ONCE() for filesystems which
>> have a ->writepages, but do not have a ->migrate_folio()?
> 
> Sounds good to me.

Agreed, that will also make it clear what our expectation towards 
filesystems is.

-- 
Cheers,

David / dhildenb


