Return-Path: <linux-fsdevel+bounces-36982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFA9EBA9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AB318857A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451A227573;
	Tue, 10 Dec 2024 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGrYPiMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90168226898
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861127; cv=none; b=TA09oCebUWMdO6XEF4D0X2AUrLbV9RqRvoe1mrJVlNKq0+w9mpKjjgsok1/LuKho5VZ6jdXb7zsmoNlnPfFr5I/DCmn9i3TRk6b8Gz4eah/1UIJifeDcfK5NQN6INOAwFwn8FrayFox4W/719HaKnnl9ifzFGx1QUyZMUjsddZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861127; c=relaxed/simple;
	bh=TTy+cnTsnryXvEPFzasG+65YEXrbE+iRWaJPGjE0KI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kpis9bRD/+6D55IK+cpedKBTdE2sXvhMMjHlveJmvCfJLVuqpCqQhLuVjOGjzz8TiAHfiJBrntzy1HQ5KJw/yRdXPRjyf2sSnQ6KjsAfLGfp2FW/rQBQWX2xNzBy4LMudKTtDguYbE9F1+hwNRIlYWQ59e7k52gGUBHlv8GKlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGrYPiMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733861124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pFFkZ3VZlfueixmWZNduueBtyjekkzH41Zaa8QErBac=;
	b=RGrYPiMlZSdVD6vkgoqb3v4wy2o/4wNGwlEur+cfS//BhG4RsYSqA0Pc19PCiphG2PJ42F
	lvMDJ5sLgr0ccQ9wfXWpvkY0bqkzvevPjiBHGJV9Qwjt8B0gbEYInaWdYvNyXwWllqPjL9
	KSY2hFdkq4gzfWzoZtPBsdJHGJ4eIko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-W-5OhTWONoegEAW9YfU5sw-1; Tue, 10 Dec 2024 15:05:23 -0500
X-MC-Unique: W-5OhTWONoegEAW9YfU5sw-1
X-Mimecast-MFC-AGG-ID: W-5OhTWONoegEAW9YfU5sw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434f3a758dbso25408895e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 12:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861122; x=1734465922;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pFFkZ3VZlfueixmWZNduueBtyjekkzH41Zaa8QErBac=;
        b=OPd8lw3EFPTkvdMyXeFSn4t69tFFHoUfPY1I2RsXZpvnE8QIotFMuWLK9OlZOk17Ti
         X3T42fD0xsiz2Z9Z9Ukf/Sxme2gG6kZshWa7uJXawptF2IM6UivuSTtBXbonLu4WDV/u
         J9IuoYigEXJL7a0ZEt9nyzdKuqSwzSsWxG8OE6cQnMzpQCjoVtW33tMmbSWlsA0fn+1N
         fKWWicl+n/hgB607rtSmVTG60/VhU/GcvJ9CPlM4M88YAeqOOV3qSkaD52kMtAS9dnYX
         /lyN2rSxrPG2jlV7ZZ207E0d2au+GlY9fV8DqJtvPggqG0QI3QUqITaieSmuQmP7OKPJ
         Op7g==
X-Forwarded-Encrypted: i=1; AJvYcCUDAM2PUEngQ/+IBL5YqRjxKzRnPZWbkfDsXuN90Lro2ib64PjmjYvqqhtt2Ki4EWvQNGOVwtSc4G+V9rQD@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuLR8QxrJGjHadCHyfwGKncRmsNWQ6LCK4ZLFzlZAywtlZN0B
	ORRO+yImVzYA5X0s5fq6xlF6AFKQY9faatE2JvSbdYGlIL3RlOjIa7AMWz3Q0y7A13QtojVFeXF
	8NqnCRUmOcnWlQmUU0Ju8leZzN46rlpi9iukk7l+GXnBVVuDe2CCNZpqVJOginNpLvNZA6Chmgw
	==
X-Gm-Gg: ASbGncuWw1awdVpZaV4/gyn8obSLsXGml5kn6lRd8WI+UUbJpveRbOvm7bgw7itm8ru
	FzL0SNDl8gVRQSlD7BhoiLaSE96yfMixXEHJ5a6CTTDvYbmU64mw+oqUgerFE+mEUSf9XehckjV
	DCWCg/8xtxY/ZBtDrASuMdS5TVQGmspj6rcTvyp/T6+H9BYswwxxP5QsKcLKv/2F+X482BC4Y8L
	uytj77uoIGM/EqdfjsVlkmlXMQFkUr8XLy53T10DA0fqaf6kflMsrJYTqPziSQDxPljI0wRkMEG
	HtHGWZLAio+nEWhJ0WAqcBQO5XbiZ4KOxC1omACeeEUxYRP9H0pM34vNDH0aG0rXzMiDl1KU6iR
	seIK1Tw==
X-Received: by 2002:a05:600c:1c01:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-4361c393cb6mr1305195e9.2.1733861121985;
        Tue, 10 Dec 2024 12:05:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQx54egW4eFig7gk+YqIDLvP0RDhsg4Pj/m/z5PX77rimnLqcdsYFQRaluVZJrVHVkvjnIvg==
X-Received: by 2002:a05:600c:1c01:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-4361c393cb6mr1305025e9.2.1733861121603;
        Tue, 10 Dec 2024 12:05:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f3d89b75sm101188805e9.15.2024.12.10.12.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 12:05:20 -0800 (PST)
Message-ID: <3a457ce5-3c5c-4165-996b-f5a46fcda194@redhat.com>
Date: Tue, 10 Dec 2024 21:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v4] ksm: add ksm involvement information for
 each process
To: Andrew Morton <akpm@linux-foundation.org>, xu.xin16@zte.com.cn
Cc: linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20241203192633836RVHhkoK1Amnqjt84D4Ryd@zte.com.cn>
 <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241203165643.729e6c5fe58f59adc7ee098f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 01:56, Andrew Morton wrote:
> On Tue, 3 Dec 2024 19:26:33 +0800 (CST) <xu.xin16@zte.com.cn> wrote:
> 
>> From: xu xin <xu.xin16@zte.com.cn>
>>
>> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
>> KSM_mergeable and KSM_merge_any. It helps administrators to
>> better know the system's KSM behavior at process level.
> 
> It's hard for me to judge the usefulness of this.  Please tell us more:
> usage examples, what actions have been taken using this information, etc.

Seconded.

> 
>> KSM_mergeable: yes/no
>> 	whether any VMAs of the process'mm are currently applicable to KSM.
> 
> Could we simply display VM_MERGEABLE in /proc/<pid>/maps?

We indicate in /proc/<pid>/smaps "mg" for VM_MERGEABLE already.

The "nasty" thing about smaps is that it does all the page table walking 
to gather memory statistics, which can be rather expensive.

I was recently asking myself whether we should have a "cheaper" way to 
obtain such details about mappings. /proc/<pid>/maps is likely 
impossible to extend (similarly display flags) I suspect.



-- 
Cheers,

David / dhildenb


