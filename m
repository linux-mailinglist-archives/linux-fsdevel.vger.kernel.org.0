Return-Path: <linux-fsdevel+bounces-48047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BED38AA910F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11BA7A6DCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4671FF1BE;
	Mon,  5 May 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIuH8fQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF517C21E
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440744; cv=none; b=OBHnMSY0Hk6r5fMqjhVKWPofaS0KovXfKV49t23Y5AU1a6vIu/DQ6wM+2mEl02PR0zCVFmZTxgqTLjXgyp1H4kyL3RS0PnA+PHvRoTjB4G1hXyUUp4H7+wwDvoA5pGGLLGCxL9EaiULxwgec4JaU2An8VmDz0GApN85JpcBvB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440744; c=relaxed/simple;
	bh=dPDk8vp3GZ832m618Pmb5UfJ2sVcRo3SC7Yf8xKJECY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrKGK+8iiD+FryWYEqiHdWLYlj6PdIEkJ9GIyiD8/nZhs2lhjU7+1cHwa1dgTlUv5JD+R6LbYoutsGkDB5tKCZhxponOUHntLfVSzQPP/F4zY2qYA90iHZIRwODYISyaYSv7CR+69fi+Xm2TxbJ3yjvaOVjD3q6mkuE6OxlEM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIuH8fQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746440741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uhA4ifLaOKoc2V5PzkrQF11rjVTTh27khKET9nyYOa0=;
	b=HIuH8fQd8G1CXItjWS8+McyHQTMasQiJrJO1zbf4JLHalPXKmQwJU7jCnJaX+h3A6yFsZL
	7kHQSzGk1Pho26Jni8h8aDi7nwoKyQNZWduhtudpEhmrFle1+dcAuYQv8fxPYjS+9520Oy
	WQcGdVWXaN6edgSb5roXiQQzwbDoALc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-9ieSPttJMxy97piPtX8PCw-1; Mon, 05 May 2025 06:25:40 -0400
X-MC-Unique: 9ieSPttJMxy97piPtX8PCw-1
X-Mimecast-MFC-AGG-ID: 9ieSPttJMxy97piPtX8PCw_1746440738
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ea256f039so32285895e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746440738; x=1747045538;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uhA4ifLaOKoc2V5PzkrQF11rjVTTh27khKET9nyYOa0=;
        b=BUIxYfmjk77kfcWc/jR4cWtXVWPSxLTotUOtRFRYvk25JqIaa1BIHP5s1NDOqx3n06
         f8l8MJFGx6AYlxWxkI2ya2xjG5IE1bLdKGuFSYkV3JEZDNhVXPmQ3GAEgHqsVfa+PO9s
         Yn11ctnT5p4HVPRuocAYvSJDq6fgeXimY0HkxLvtMHM9Z0/aTDi0sZkbLHps7p1nlU0s
         DKr16KjfzjLRYLWrHi6xjfrig4hn5X+370oasHc1cpRNOqRu5YDyc92HxhtGJCRPlf4a
         FYmPbgrICZ8dlGpbT2JocC7xRxP1ZaardGlaCVAmQPtxLmFt8UHSjIXtGkU0k2qsdIPi
         QeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU31K/w84ptxvXuJZkpg76oJTwjHuKOg1MixmETRiU1Sa67ofx4pcUkl04xlchUDxNE47SQnz6YIvW5xvT4@vger.kernel.org
X-Gm-Message-State: AOJu0YwlI09dy64so0zcT7abpCihGikZCxcl+iw2vSPBAp/wejNd4Vkr
	bANbj4ggPlEC7xTiPllOnXdYURGovDuXtDQOEnWyrY8wX38yG3Cvd2ShdZXOHF1D92oBVjmaelv
	XPBzmOf9nGOG8xts33zmiucKoH162CKmI3wn1Yhjaze1mofAqb/o7yPe66+kUjHk=
X-Gm-Gg: ASbGnctkHqguAfSa5dIHEo97Th+xhlvgS4zxQH2diyg9w4Rluj4mc3DhVrz+dW/AAkN
	E0FDCbS2eHuHlSwqFnal7+O+Q9FCf66llOUyYkJYS/yCemyB8oyR8+D7UzpabCFMSfdhcnUx5Wc
	z+x+CMY1/6EY2TklVPYBmFLFl2xaSsJqca83I6ox+5HfzhtZv+jxSiLGddrMtL1yQDT8PVsHo6n
	HnKsbYOW5Lols0IU0qw9ZFmbjoFiVRrTyZbkNC1/GoMJ5fognWpF4DGO7tBR2vQfYLKRrMo6z9y
	TO74AKYVhvrdBIzm9ZhdAvadtrjgvzGd5la/6RyBIR8uy/ekleAXietVj3m0y3KH+li/vtYaB7e
	bvCwfK37VTNVEVpf7MZ26X3KrgL2983I52s/KgW4=
X-Received: by 2002:a05:600c:a55:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-441c48dbffemr69645875e9.15.1746440738559;
        Mon, 05 May 2025 03:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG46LR3x4BEcojru2BOwZQKtlpbpA9Ti7QJTaZcyFpN/BSfCje5D7I8KCeBJEW2jfM/SOM9Sg==
X-Received: by 2002:a05:600c:a55:b0:43c:fe85:e4ba with SMTP id 5b1f17b1804b1-441c48dbffemr69645575e9.15.1746440738121;
        Mon, 05 May 2025 03:25:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29? (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de. [2003:cb:c73d:2400:3be1:a856:724c:fd29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm132057425e9.8.2025.05.05.03.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 03:25:37 -0700 (PDT)
Message-ID: <d4bfefdf-bd87-4d2e-b7bb-4a11e5d32242@redhat.com>
Date: Mon, 5 May 2025 12:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] mm/readahead: Honour new_order in
 page_cache_ra_order()
To: Jan Kara <jack@suse.cz>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Dave Chinner <david@fromorbit.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-2-ryan.roberts@arm.com>
 <48b4aa79-943b-46bc-ac24-604fdf998566@redhat.com>
 <mhayjykmkxhvnivthdrc2bb3cvqbdesa42puzimx75xfagcnqn@osy4qeiyfxvn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <mhayjykmkxhvnivthdrc2bb3cvqbdesa42puzimx75xfagcnqn@osy4qeiyfxvn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.05.25 12:09, Jan Kara wrote:
> On Mon 05-05-25 11:51:43, David Hildenbrand wrote:
>> On 30.04.25 16:59, Ryan Roberts wrote:
>>> page_cache_ra_order() takes a parameter called new_order, which is
>>> intended to express the preferred order of the folios that will be
>>> allocated for the readahead operation. Most callers indeed call this
>>> with their preferred new order. But page_cache_async_ra() calls it with
>>> the preferred order of the previous readahead request (actually the
>>> order of the folio that had the readahead marker, which may be smaller
>>> when alignment comes into play).
>>>
>>> And despite the parameter name, page_cache_ra_order() always treats it
>>> at the old order, adding 2 to it on entry. As a result, a cold readahead
>>> always starts with order-2 folios.
>>>
>>> Let's fix this behaviour by always passing in the *new* order.
>>>
>>> Worked example:
>>>
>>> Prior to the change, mmaping an 8MB file and touching each page
>>> sequentially, resulted in the following, where we start with order-2
>>> folios for the first 128K then ramp up to order-4 for the next 128K,
>>> then get clamped to order-5 for the rest of the file because pa_pages is
>>> limited to 128K:
>>>
>>> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
>>> -----  ----------  ----------  ---------  -------  -------  -----  -----
>>> FOLIO  0x00000000  0x00004000      16384        0        4      4      2
>>> FOLIO  0x00004000  0x00008000      16384        4        8      4      2
>>> FOLIO  0x00008000  0x0000c000      16384        8       12      4      2
>>> FOLIO  0x0000c000  0x00010000      16384       12       16      4      2
>>> FOLIO  0x00010000  0x00014000      16384       16       20      4      2
>>> FOLIO  0x00014000  0x00018000      16384       20       24      4      2
>>> FOLIO  0x00018000  0x0001c000      16384       24       28      4      2
>>> FOLIO  0x0001c000  0x00020000      16384       28       32      4      2
>>> FOLIO  0x00020000  0x00030000      65536       32       48     16      4
>>> FOLIO  0x00030000  0x00040000      65536       48       64     16      4
>>> FOLIO  0x00040000  0x00060000     131072       64       96     32      5
>>> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
>>> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
>>> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
>>
>> Interesting, I would have thought we'd ramp up earlier.
>>
>>> ...
>>>
>>> After the change, the same operation results in the first 128K being
>>> order-0, then we start ramping up to order-2, -4, and finally get
>>> clamped at order-5:
>>>
>>> TYPE    STARTOFFS     ENDOFFS       SIZE  STARTPG    ENDPG   NRPG  ORDER
>>> -----  ----------  ----------  ---------  -------  -------  -----  -----
>>> FOLIO  0x00000000  0x00001000       4096        0        1      1      0
>>> FOLIO  0x00001000  0x00002000       4096        1        2      1      0
>>> FOLIO  0x00002000  0x00003000       4096        2        3      1      0
>>> FOLIO  0x00003000  0x00004000       4096        3        4      1      0
>>> FOLIO  0x00004000  0x00005000       4096        4        5      1      0
>>> FOLIO  0x00005000  0x00006000       4096        5        6      1      0
>>> FOLIO  0x00006000  0x00007000       4096        6        7      1      0
>>> FOLIO  0x00007000  0x00008000       4096        7        8      1      0
>>> FOLIO  0x00008000  0x00009000       4096        8        9      1      0
>>> FOLIO  0x00009000  0x0000a000       4096        9       10      1      0
>>> FOLIO  0x0000a000  0x0000b000       4096       10       11      1      0
>>> FOLIO  0x0000b000  0x0000c000       4096       11       12      1      0
>>> FOLIO  0x0000c000  0x0000d000       4096       12       13      1      0
>>> FOLIO  0x0000d000  0x0000e000       4096       13       14      1      0
>>> FOLIO  0x0000e000  0x0000f000       4096       14       15      1      0
>>> FOLIO  0x0000f000  0x00010000       4096       15       16      1      0
>>> FOLIO  0x00010000  0x00011000       4096       16       17      1      0
>>> FOLIO  0x00011000  0x00012000       4096       17       18      1      0
>>> FOLIO  0x00012000  0x00013000       4096       18       19      1      0
>>> FOLIO  0x00013000  0x00014000       4096       19       20      1      0
>>> FOLIO  0x00014000  0x00015000       4096       20       21      1      0
>>> FOLIO  0x00015000  0x00016000       4096       21       22      1      0
>>> FOLIO  0x00016000  0x00017000       4096       22       23      1      0
>>> FOLIO  0x00017000  0x00018000       4096       23       24      1      0
>>> FOLIO  0x00018000  0x00019000       4096       24       25      1      0
>>> FOLIO  0x00019000  0x0001a000       4096       25       26      1      0
>>> FOLIO  0x0001a000  0x0001b000       4096       26       27      1      0
>>> FOLIO  0x0001b000  0x0001c000       4096       27       28      1      0
>>> FOLIO  0x0001c000  0x0001d000       4096       28       29      1      0
>>> FOLIO  0x0001d000  0x0001e000       4096       29       30      1      0
>>> FOLIO  0x0001e000  0x0001f000       4096       30       31      1      0
>>> FOLIO  0x0001f000  0x00020000       4096       31       32      1      0
>>> FOLIO  0x00020000  0x00024000      16384       32       36      4      2
>>> FOLIO  0x00024000  0x00028000      16384       36       40      4      2
>>> FOLIO  0x00028000  0x0002c000      16384       40       44      4      2
>>> FOLIO  0x0002c000  0x00030000      16384       44       48      4      2
>>> FOLIO  0x00030000  0x00034000      16384       48       52      4      2
>>> FOLIO  0x00034000  0x00038000      16384       52       56      4      2
>>> FOLIO  0x00038000  0x0003c000      16384       56       60      4      2
>>> FOLIO  0x0003c000  0x00040000      16384       60       64      4      2
>>> FOLIO  0x00040000  0x00050000      65536       64       80     16      4
>>> FOLIO  0x00050000  0x00060000      65536       80       96     16      4
>>> FOLIO  0x00060000  0x00080000     131072       96      128     32      5
>>> FOLIO  0x00080000  0x000a0000     131072      128      160     32      5
>>> FOLIO  0x000a0000  0x000c0000     131072      160      192     32      5
>>> FOLIO  0x000c0000  0x000e0000     131072      192      224     32      5
>>
>> Similar here, do you know why we don't ramp up earlier. Allocating that many
>> order-0 + order-2 pages looks a bit suboptimal to me for a sequential read.
> 
> Note that this is reading through mmap using the mmap readahead code. If
> you use standard read(2), the readahead window starts small as well and
> ramps us along with the desired order so we don't allocate that many small
> order pages in that case.

Ah, thanks for that information! :)

-- 
Cheers,

David / dhildenb


