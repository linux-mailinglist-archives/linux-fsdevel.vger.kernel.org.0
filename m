Return-Path: <linux-fsdevel+bounces-13867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E78874D2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199A41C22CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F0128390;
	Thu,  7 Mar 2024 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2XOefEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B686AC5
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810146; cv=none; b=Zv6q3UjqSMwbdRku3aeQT/bx8EXI7k3YCZ4cyezqfin9dL/mtG1uM7Fpy1ak3QsI3Zi5alXRMsKZ3mokIctnXVBTIFxuPfVDYdGIZCHqE4yHXRCRzuvR1Lu6z2CNCM+RN+BuW+/Tvmuu8Yw+6nkolEC1oYMIsWmMzImBFfLq3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810146; c=relaxed/simple;
	bh=6EvlWT+S0R2V+54Ygt9FEE0KiWIaTf39AZarTMcYy8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YREN6rDcy1D6cVFMa5c01t4U+UY6LmMgJLX2xiPstMS/oM35EYIoWCrsNO+k77Sc6xZ/3uLBvVc1aNLcCcaM6iM5v7LWpvtCPJDCm1Kc64Lor/9jzZ6AdpLg7TUCvAJmSIdYvDrvf6eHgFgmcIL8mASnHrVpPib38Wx/khuBWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2XOefEo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709810143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3BsOQTb/Qz/4Q0ul9t6TVhJi7UErvuV0EjOwbLcAigo=;
	b=U2XOefEoAJN36Maccq3KPYqj3za2iqGD5Jdqh+sqipLVoUX8qDLy0qpYTbCruwvpYauQo0
	0tljCLjdv7e8VCXJPBcuS+dcqvy9l38T0aB+9gpIHrpbEmdsV/rh89KJiJ6R01CAYjNE4i
	tYYY/wFSM2OFnT2PvWUyPeQGA0xTWPk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-ldXc53vKMMmj3k3qXrDnmg-1; Thu, 07 Mar 2024 06:15:42 -0500
X-MC-Unique: ldXc53vKMMmj3k3qXrDnmg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5135a84b942so847079e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 03:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810140; x=1710414940;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BsOQTb/Qz/4Q0ul9t6TVhJi7UErvuV0EjOwbLcAigo=;
        b=IEUnAncnEc+Uqfd1zsR5mNHi+35Hs6ecxF9uEl/sOhPJUHzh9zmUMI9IHF+Lau1c6D
         q3a4hCGNULSJBIQ6pdwqBpwYT1nzfHxgppdUshroL7ToSmNQxtkj8Q7Oknzi7+JEcTJW
         2omrmQICLei6MUmeUnl9Y+ABmIbA4x9KYCpWa/To3diho9P55cAaIIrJQwwloXNXPmG4
         RqvRYAAbS2NACVBXCEvlYKft2U13yHaD9q6G0ogQYaNTfNU5DUmruI+1Nzkx49ck0/M9
         +lXtCxPmuO6v+q4VSQsMrYu5aFKmHe+OzIdOxg/r2KsQ431JRnnalZ7zWN73kybkUDiQ
         o9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZRa9ax4RhGi2JHHCE/OJ07okTSoxEr5jc9BLWeSFukq4Q+Gv3n579/0WKL+ZauSHQrqGjGZeqSQWmtBELkRVAWjiVp3AKoJFJ6SC6HA==
X-Gm-Message-State: AOJu0Yy3Z3TfySJECgmQvBVOrA32Y/rWR4+pVKRgMZ48nlJkMpIp5ks2
	wukNsAZx5rvuKC1keg3IRUjmmoitPbL7mXUbwDQcTHFUTphUMHvZO2pwbo6rwF5deEgoHtbX1AM
	TrB5u7ftl9JslxXlL7pVgUJCHAlqrG2HmS2OHv54UPuJBi1MDV2/axOavWbTkUlo=
X-Received: by 2002:a19:c218:0:b0:513:def:9c8a with SMTP id l24-20020a19c218000000b005130def9c8amr1031579lfc.69.1709810140656;
        Thu, 07 Mar 2024 03:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWiBMQvQsZXYkZpJ9/0SH18KKFWyY/LrnFAr8l9+dL5bmDLAOBPSjdoNpD0tQxR3Xgz6dK4g==
X-Received: by 2002:a19:c218:0:b0:513:def:9c8a with SMTP id l24-20020a19c218000000b005130def9c8amr1031548lfc.69.1709810140173;
        Thu, 07 Mar 2024 03:15:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c74d:6400:4867:4ed0:9726:a0c9? (p200300cbc74d640048674ed09726a0c9.dip0.t-ipconnect.de. [2003:cb:c74d:6400:4867:4ed0:9726:a0c9])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c470c00b00412b4dca795sm2376146wmo.7.2024.03.07.03.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:15:39 -0800 (PST)
Message-ID: <9ebc9faf-0bb0-4409-b93a-5beddfc4929b@redhat.com>
Date: Thu, 7 Mar 2024 12:15:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] [RFC] pagemap.rst: Document write bit
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm <linux-mm@kvack.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 upstream+pagemap@sigma-star.at, adobriyan@gmail.com,
 wangkefeng wang <wangkefeng.wang@huawei.com>,
 ryan roberts <ryan.roberts@arm.com>, hughd@google.com, peterx@redhat.com,
 avagin@google.com, lstoakes@gmail.com, vbabka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 usama anjum <usama.anjum@collabora.com>, Jonathan Corbet <corbet@lwn.net>
References: <20240306232339.29659-1-richard@nod.at>
 <20240306232339.29659-2-richard@nod.at>
 <db29666a-32b8-4bf6-ab13-7de3b09b0da1@redhat.com>
 <861682210.23281.1709809857201.JavaMail.zimbra@nod.at>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <861682210.23281.1709809857201.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.03.24 12:10, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "David Hildenbrand" <david@redhat.com>
>> An: "richard" <richard@nod.at>, "linux-mm" <linux-mm@kvack.org>
>>> +   Bit 58 is useful to detect CoW mappings; however, it does not indicate
>>> +   whether the page mapping is writable or not. If an anonymous mapping is
>>> +   writable but the write bit is not set, it means that the next write access
>>> +   will cause a page fault, and copy-on-write will happen.
>>
>> That is not true.
> 
> Can you please help me correct my obvious misunderstanding?

We'll perform a page copy of an anonymous page only if the page is not 
detected as exclusive to the process.

So a better description could be:

"In an private mapping, having the writable bit clear can indicate that 
next write access will result in copy-on-write during a page fault. Note 
that exclusive anonymous pages can be mapped read-only, and they might 
simply get remapped writable during the next write fault, avoiding a 
page copy."

-- 
Cheers,

David / dhildenb


