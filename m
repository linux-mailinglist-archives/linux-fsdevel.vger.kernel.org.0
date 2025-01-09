Return-Path: <linux-fsdevel+bounces-38708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D5A06E60
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC973A629A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346C207A0A;
	Thu,  9 Jan 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WegE/ndA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94EF13BC26
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405328; cv=none; b=Nmkab18mCsHjE0pMMr1pyQtPQeo0RQyitiSPtVt0XKW9YPj6x37qsIRmPB/DufDvVeWUYJ48schcI8hWPOb+jcYu9dNHNXqPvSBzXRxttvUVm0VY1/9qJUaKyLA/HROYIpSAqu0v4TSt+t1cmRU1YrOq3jfwv2vlDtXy+JXUl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405328; c=relaxed/simple;
	bh=tVi3MJKUG6GjMSqir73xrg1yGJE+wKteHoRd2QX1iRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LCvtB1WK45NjmQDYyczBhI+gAdzMPpJ/EuJJLtt0Bx3i1KyPFljjJc9Lp13j59SHa+Xtj4JSe1KZ99l41dcV/XqZRnk+SLA1POFgl0fGnEfYseu257oYvh3QyNdvKPgb4g55l8b1QSowKQuRh6ObY78G9tJw7r50CpRiYGqtukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WegE/ndA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736405325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/Qlt22S5/sMdWN5HOf7+LsDds+9xwnAc3AUTlgKTsUM=;
	b=WegE/ndAwSsgUVlE1AcxZRqsWXaNJxa6BOfIxlC3Ln2D09z2ZCFd9hgxiNqGHaNhpJAJjK
	hn7e7e/tzeSC0jM6gcchoq7VgvLrj16h3DxwfT6Y8QvjaMMcFzJvgDt0Kq1FEd2sVwjzNC
	E+eY/b3eFsyUbEeX3YBjGarg9/a5pxc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-aYDcwJjJNtimCpZTqWwM3g-1; Thu, 09 Jan 2025 01:48:43 -0500
X-MC-Unique: aYDcwJjJNtimCpZTqWwM3g-1
X-Mimecast-MFC-AGG-ID: aYDcwJjJNtimCpZTqWwM3g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so260761f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2025 22:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736405322; x=1737010122;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qlt22S5/sMdWN5HOf7+LsDds+9xwnAc3AUTlgKTsUM=;
        b=w3TUkarzkZ375vr9wtQoUVxql2yQPuKMOovUO9rMWGhUfPtjRWIPndcTiPeYEQh/M8
         bBMMNDarCTdru/LRRJnjKA0vmkGu54va/8s4DtZJ+dgzFVEOd90nW9dHtc2/dnny3FG8
         E7SS/yWottxSo3sajU+IUKehICuheN/SKaqDP1rQKQu4dtgbtR/8uM2e5ntDL+6oy+Bf
         nNJId455GPMlLygGWWOSQ5UkkhuRv0KGg6zDvadfdJfG5NElwM+3d9WZmL0ZWJpPdSoW
         R+qfY2y8dxazV5/GZtivqCgUIaZGft4e7Ld7x44gJxwPq/ZPRCOR/an4D98ZkLCIJHX6
         JNAw==
X-Forwarded-Encrypted: i=1; AJvYcCW5IROF7uSXo1L5EmOenNac5UtsN0DLyzMqNGcoxgHUcqOBLoPaWDPL+c7PYsoUa2EIiABRwfk4f8jaG0iC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5KAPHowq9W3norEyEed8KyWFpkI7YUB3OE8OH6dstZanCigK
	xbtoagn42vAGaCnArtRDZwP0acuI5SOFlw93370XEfTfg0Gqk0GLG41jnT0R+aKodbAQYTugvHp
	vEY2hdzodv04X5H/Ed6BudrsT4CV/8Qpn8JvmBXGuNqc+nvJ2AKclBM7TKyJhJy4=
X-Gm-Gg: ASbGncspQwY2tVOhf8FgcyHOhLieDBsisxtuCY20MMRWhZlULDXqL/z5R1u8LoSIIYZ
	ZglF91fIjxmeZ5eIVtZIeK56e62Jsd6b2oBm2nuJpLpeW2QkYhGWa2bbnjZsFfT1ZlvfBbHVetm
	/786/llKjx9P1Pr5PLQFtYvkzag5M14SrIQlUzDANvIR54n0AYfmXAPDpHEFllVy/33WKr3CT3X
	RkGt2OW/xw7cyoonW7DgiWXa3mBBg7H1c1yMJtBhSJltDorFr3eg7Zoj9pa0qoyvUpT04Z+eKBL
	XGsYkbj7
X-Received: by 2002:a5d:584f:0:b0:385:f638:c68a with SMTP id ffacd0b85a97d-38a8730b738mr4687473f8f.30.1736405322520;
        Wed, 08 Jan 2025 22:48:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM0091cYSU5FWNcNmBBlZFp76apRofTPh507IqP+YGRFKH8vEwkP745MJ7sRS7nwLBtBwydA==
X-Received: by 2002:a5d:584f:0:b0:385:f638:c68a with SMTP id ffacd0b85a97d-38a8730b738mr4687457f8f.30.1736405322194;
        Wed, 08 Jan 2025 22:48:42 -0800 (PST)
Received: from [192.168.3.141] (p4ff23e09.dip0.t-ipconnect.de. [79.242.62.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c1d6sm904314f8f.50.2025.01.08.22.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 22:48:40 -0800 (PST)
Message-ID: <d1f03a34-59b1-4f17-bca6-67c934e93b46@redhat.com>
Date: Thu, 9 Jan 2025 07:48:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: fix div by zero in bdi_ratio_from_pages
To: Stefan Roesch <shr@devkernel.io>, willy@infradead.org,
 zzqq0103.hey@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20250109063411.6591-1-shr@devkernel.io>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250109063411.6591-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.01.25 07:34, Stefan Roesch wrote:
> During testing it has been detected, that it is possible to get div by
> zero error in bdi_set_min_bytes. The error is caused by the function
> bdi_ratio_from_pages(). bdi_ratio_from_pages() calls
> global_dirty_limits. If the dirty threshold is 0, the div by zero is
> raised. This can happen if the root user is setting:
> 
> echo 0 > /proc/sys/vm/dirty_ratio
> 
> The following is a test case:
> 
> echo 0 > /proc/sys/vm/dirty_ratio
> cd /sys/class/bdi/<device>
> echo 1 > strict_limit
> echo 8192 > min_bytes
> 
> ==> error is raised.
> 
> The problem is addressed by returning -EINVAL if dirty_ratio or
> dirty_bytes is set to 0.
> 
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/87pll35yd0.fsf@devkernel.io/T/#t
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> 
> ---
> Changes in V3:
> - Used long instead of unsigned long for min_ratio / max_ratio
> 
> Changes in V2:
> - check for -EINVAL in bdi_set_min_bytes()
> - check for -EINVAL in bdi_set_max_bytes()
> ---
>   mm/page-writeback.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index d213ead95675..d9861e42b2bd 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -692,6 +692,8 @@ static unsigned long bdi_ratio_from_pages(unsigned long pages)

Note that I suggested returning "long" here, but it should also work as is.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


