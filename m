Return-Path: <linux-fsdevel+bounces-50783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204ADACF91D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FFD189CA64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C727BF80;
	Thu,  5 Jun 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6wss3j8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C261B87D9
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157607; cv=none; b=QplUjMqR6BRHExwEcY0ggA+sCHDmfPxZjgVWpXmeCX9Bg9oAnXsxoav7UrexYeNvac/ftc6+TNAarybuxgkJoqqaz3Qo8kLk3HeSy6DmISfrXfpbeY2PhMVdCT5+EFKR9GpyxFgkusHDgE2BjUXDNBm1iyJGHr/ECHFEma+GZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157607; c=relaxed/simple;
	bh=IWFTL12W3d29/s71G/pRQ2UpdRAu+A8TalDs+OprTbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fK2shI8qf9stjTK10S5pkEsZSSbteqxQkBIaVg68Avd1+ufjFebyGbFYA1anr1ySpb+Ua0j66dcK7p8h3wVoALQbdgq+A3FzsUvhFXxdxc1Q0f6aY2hEwPkAGjIQRWaCPVdxmk3irmzQHynbLtNRZSu7Nmr8Blf9tHvaFJLUNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6wss3j8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749157605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KsrSkUpql3itSV3/ri1zxMtGV9J2VnAsgTf2vYhM3xo=;
	b=M6wss3j84+ogOP/layNTmKPT7T+8n8W6reDGU5sOssxFQDx0sOsKVviheg9XMiU+Q5ShzT
	PIUGhbHsNr6/tLdlhcQJrynzk5xygIv0jmaHdSw9CG+4jjLc7VTtrUwoErZRDi23s0EDTe
	adhazVEdo6vJabNqlTDP6oWLsHZ8B6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Mst_bjkqMRuRq7DvBL935A-1; Thu, 05 Jun 2025 17:06:43 -0400
X-MC-Unique: Mst_bjkqMRuRq7DvBL935A-1
X-Mimecast-MFC-AGG-ID: Mst_bjkqMRuRq7DvBL935A_1749157603
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so966058f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 14:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749157602; x=1749762402;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsrSkUpql3itSV3/ri1zxMtGV9J2VnAsgTf2vYhM3xo=;
        b=fGRfcyLjapUOVp9HE6w3azjCz1mBHxPyP1byfekJ6xUqBl7O00WOkCdZK0CxWpB/83
         vya+rs5V0gGGAlKx//VE742YGLRWMCQ/5nVUjYkw2kTGbcLJ3h0X1IxQNQl+36yk//Ky
         LovU7T8C8LIW8F/uKU9sNI3b9YBNPddppTBBQbPyz3r8GVIKaqU6GEAp8LMgTfJw+PMf
         xb4k6raS7wJU+ble1h3Sn7DEURhcNm2/rqVgJ0yVBS9HCydI/mBGkFI3nntKYCFrtFBb
         6sOMOUNttCNtaQhVcFbdamZVsSEt8B5bLc3Z5rjF8DGgHRJvhhb4FuMRdK1KwiEKXA3d
         KG6w==
X-Forwarded-Encrypted: i=1; AJvYcCU8GWSboADK1z8gjpEE9hZ0XPvTwI391WgAlERnazC9Y5v1Y5EWfvSdPg8FRb7P/Lqs3idM8Ry4Ntgpw1NY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77MopMG13gwOUlzWPScqrGctvGeAL+8EF4FxKUH3+pYLaXh05
	Qsc8+Mn1IHZ4gSQ6m8ZUQ1JuoJApjByu1qq7kdpP9wSVVy6d7jXkuEumdSA1dKbONgG1h2QyuUk
	9HybQvPQlch7k5/GDkI8OP5eX5F9HyHHCHkp8C/NOTsmqKRzjSiLuJ3Av/AbeuyHCTg0=
X-Gm-Gg: ASbGncvYU5Zztwrkbdj+LxwpwLU/VkzPSm31Xu+iJERGe8FcPDRok1hWESJF3jOKS9k
	f+zstDdzoi/5iKyul2cM9qvEZqb7lMj/LCF+wIh25sgf+3896pOkZhGkRwuZ/artMb2A6Tkcmkq
	XAvaPMIJi9WHDhIKK6w3Z9BCRee6Fp4v/ALKmuVO9Eoa3QMpe4TWYfN+WNx1ltzr7SYuG6Opbd6
	GuX7tsImgglJIGKo3fFawHfsnzMHRzRgsw0Rt1iu8XFXMXVO2p+MheXxhi15A15Qanx3GJCLxVp
	VAlD9BIVhrpaOD8Bns8gOjfCjtli23lk5fdfhdozJCIWosBgY9k6Jw==
X-Received: by 2002:a05:6000:430a:b0:3a4:fcc3:4a14 with SMTP id ffacd0b85a97d-3a531cb0becmr528111f8f.34.1749157602646;
        Thu, 05 Jun 2025 14:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE66VFB4S99TdbaanehyTYCVo34FSkB9+r8xBeGIhBPQc+rl+mKxmTd1eM066L0mrneeEm4/w==
X-Received: by 2002:a05:6000:430a:b0:3a4:fcc3:4a14 with SMTP id ffacd0b85a97d-3a531cb0becmr528089f8f.34.1749157602170;
        Thu, 05 Jun 2025 14:06:42 -0700 (PDT)
Received: from [192.168.3.141] (p4fe0f5ef.dip0.t-ipconnect.de. [79.224.245.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323c08fasm207200f8f.44.2025.06.05.14.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 14:06:40 -0700 (PDT)
Message-ID: <0a1dab1c-80d2-436f-857f-734d95939aec@redhat.com>
Date: Thu, 5 Jun 2025 23:06:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: Peter Xu <peterx@redhat.com>
Cc: Tal Zussman <tz2294@columbia.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli
 <aarcange@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
 <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com> <aEBhqz1UgpP8d9hG@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aEBhqz1UgpP8d9hG@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.06.25 17:09, Peter Xu wrote:
> On Wed, Jun 04, 2025 at 03:23:38PM +0200, David Hildenbrand wrote:
>> On 04.06.25 00:14, Tal Zussman wrote:
>>> Currently, a VMA registered with a uffd can be unregistered through a
>>> different uffd asssociated with the same mm_struct.
>>>
>>> Change this behavior to be stricter by requiring VMAs to be unregistered
>>> through the same uffd they were registered with.
>>>
>>> While at it, correct the comment for the no userfaultfd case. This seems
>>> to be a copy-paste artifact from the analagous userfaultfd_register()
>>> check.
>>
>> I consider it a BUG that should be fixed. Hoping Peter can share his
>> opinion.
> 
> Agree it smells like unintentional, it's just that the man page indeed
> didn't mention what would happen if the userfaultfd isn't the one got
> registered but only requesting them to be "compatible".
> 
> DESCRIPTION
>         Unregister a memory address range from userfaultfd.  The pages in
>         the range must be “compatible” (see UFFDIO_REGISTER(2const)).
> 
> So it sounds still possible if we have existing userapp creating multiple
> userfaultfds (for example, for scalability reasons on using multiple
> queues) to manage its own mm address space, one uffd in charge of a portion
> of VMAs, then it can randomly take one userfaultfd to do unregistrations.
> Such might break.

Not sure if relevant, but consider the following:

an app being controlled by another process using userfaultfd.

The app itself can "escape" uffd control of the other process by simply 
creating a userfaultfd and unregistering VMAs.

-- 
Cheers,

David / dhildenb


