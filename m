Return-Path: <linux-fsdevel+bounces-39981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3515A1A8CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8EF1891D86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB6A154C07;
	Thu, 23 Jan 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQJ6W5af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399114600F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652502; cv=none; b=tW0m4fMdw12mEq1nAmtZHYXq5F4m0e/iUrHRh63hIzhz5KOe9CYtsxryyTmoj4sQ0GnbF0orbpa57VR9Mi8/64VcR5h/v2SDGvhc0kMYB7gHnfrc3DmfQw1O5EuQP0/e9ymHSKci4lup9qYYWxlMRJ+vzyv37yCGuyMor7bn7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652502; c=relaxed/simple;
	bh=/gFpLZDl65Q4NDnF9Dig+R8WSVkyBnkoCoqZsawtiYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg/sIicuDtIvofQ3JKCxuDjrK684As9uGMcW/fa/C8V2nIoRVE+yAJPaYFLAcDV4JyBCNI0NpyAHlRdm5UiT/FgQi0z+RnTqkNEsqM6+1U5vIwSLqSoC40HoqFKKMLy1b66vx339jlK7ZaMg5J2d2nwOkOITGmfdA84UmmBw4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQJ6W5af; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737652499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GrAAS6dzp6KLcahspxU/G2pEEoyi7Z185UjRse404c0=;
	b=HQJ6W5afe7PixlwIzLP0mv50D3FHqQBeWudNukiQLs43Xa3BvOo23vhD5x25FQjLau+W1u
	AV+hAijD1Qek6bwfuP+1GHeAmTf4+qNiLhKxnXIwGri3WNsRJ2vmMsoimNSn2reqaLj5g9
	9YZukcoLWlULFixJ0uFQyafTwCG2nAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-TyjoBNrGNnyYHDHONAS4oA-1; Thu, 23 Jan 2025 12:14:58 -0500
X-MC-Unique: TyjoBNrGNnyYHDHONAS4oA-1
X-Mimecast-MFC-AGG-ID: TyjoBNrGNnyYHDHONAS4oA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385ed79291eso1027228f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 09:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652496; x=1738257296;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GrAAS6dzp6KLcahspxU/G2pEEoyi7Z185UjRse404c0=;
        b=W9ojMWGNLwHlAdY1ezB79FxXktnYjQupyGPE31LoQt/B3TJv+X1Fl/GImArybAY/LM
         qr7rVdpHnzITgPFl+o4iNbl6vRcMbCM4xN/iFFjdib2VwWoTb+uGblewxV3GLylJXKV7
         EdcsXGTFz41EHK/yMEKLJQc1rSKFhbE+jj6mq7UPhJT4+UlVuxMuwUGOTZ/jsB7LWwi2
         wKijphNz0J/Ol1+3EDgBDF4CrWbaVF2YMG/b4RTrExsk+LQisJoyA4Xn+JwxXqPSGAtk
         8Fh2ZITZul5/CESobFi04n71jlkRrOZVEIX0Tyfo+X4Y5gLlXoUTDdlDtqX28FQCedOR
         uqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUIrjKG5sIdYyVuSAYuVUNC/2yh0rYNojy/JQ79tdpmXk4Sh7dbs9aA8+7v350U7aoED6QT9DjSU4NtOmnT@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBWVUdVCP78Jx3wtAUk6KMzF0pCgO6Xoh4RfihSDTjYeurmB0
	QfFmZjTK0ZYaE/s8k2cVKaBvB/a3cA5qglhLXkCd9M7XtzBlHDucgW/sZvAT5Cq6x/JJfoWpRQv
	zfpks0RO+FGDRz5VhyZhzkW/g5CEu1XGNRjxz3330EwaN9rDTjNV6a+ehcy2E1B8=
X-Gm-Gg: ASbGncvckLirsUXNwG060Mjrc/3YZnH/AlPOAm+vYFMYXWr1zmB0vaxsV66YbHrsJJi
	TII9ZZmfi8d0takzwFt2lEZzqh+Ut7gd++/SDTDBojOQLdJ/XHI1DSGmhLc+5v/gIVJGN2ITd0U
	4hGEop2u3WN/TY+e49ypxwpn7YnquIq+qPqix9pk8ma6+ePBYh6ajgdYMPdOrXcdVR7WGLhrms6
	r/TKLBXEYMqa1fdikZdml34VZ4MLHqq++gChZEQssnPG10kWGIeZzvtBXarmVmurd1XURlyKH6L
	j2tUqwoef9NLuG+i6LV7H417CW5GCL8u2nw+hgqjaCRvERlyyE4z8P2RbnW0THWAMtKRmePherv
	ZrkwJzTHZissI4BjJpwLB2Q==
X-Received: by 2002:a05:600c:3546:b0:434:fc5d:179c with SMTP id 5b1f17b1804b1-438b885f8ebmr40904115e9.13.1737652495144;
        Thu, 23 Jan 2025 09:14:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWcCI1p9urcLlTycnSU1l6tI9AgoP0i7/DBoXSqNSG1/VgDz9PX+nsC7+dnj19zmcO0PsqEA==
X-Received: by 2002:a05:600c:3546:b0:434:fc5d:179c with SMTP id 5b1f17b1804b1-438b885f8ebmr40902745e9.13.1737652493288;
        Thu, 23 Jan 2025 09:14:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:b400:e20a:6d03:7ac8:f97d? (p200300cbc70bb400e20a6d037ac8f97d.dip0.t-ipconnect.de. [2003:cb:c70b:b400:e20a:6d03:7ac8:f97d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31898ebsm68535605e9.2.2025.01.23.09.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:14:52 -0800 (PST)
Message-ID: <7a4f8c38-13a1-4a28-b7ce-ad3bb983dd69@redhat.com>
Date: Thu, 23 Jan 2025 18:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd
 operations
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Barry Song <21cnbao@gmail.com>
Cc: lokeshgidra@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
 akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com,
 jannh@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com,
 rppt@kernel.org, ryan.roberts@arm.com, selinux@vger.kernel.org,
 surenb@google.com, timmurray@google.com, willy@infradead.org
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com>
 <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>>           ┌────────────┐TASK_SIZE
>>           │            │
>>           │            │
>>           │            │mmap VOLATILE
>>           ┼────────────┤
>>           │            │
>>           │            │
>>           │            │
>>           │            │
>>           │            │default mmap
>>           │            │
>>           │            │
>>           └────────────┘
>>
>> VMAs in the volatile region are assigned their own volatile_mmap_lock,
>> which is independent of the mmap_lock for the non-volatile region.
>> Additionally, we ensure that no single VMA spans the boundary between
>> the volatile and non-volatile regions. This separation prevents the
>> frequent modifications of a small number of volatile VMAs from blocking
>> other operations on a large number of non-volatile VMAs.
> 
> I think really overall this will be solving one can of worms by introducing
> another can of very large worms in space :P but perhaps I am missing
> details here.

Fully agreed; not a big fan :)

-- 
Cheers,

David / dhildenb


