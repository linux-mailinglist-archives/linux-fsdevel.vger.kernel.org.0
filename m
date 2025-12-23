Return-Path: <linux-fsdevel+bounces-72003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F3CDAD9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A147304248F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97482F7444;
	Tue, 23 Dec 2025 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpcEOuvg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIlXGj29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E252737E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766533463; cv=none; b=oJLbLq/6M6ORe2NGGeX/HVLS6IOadu3Ttk8gn7SlBbWNteMaufnXtiFxF9UTDNFMhFjnvqYJHOXsNV4WNn9b+Za3+1isNrmOCvoyoUrvVrR0fesECPsjEuoU70Fd4egH0suRnATIa5WNyiF/qIVTvi/zXyyxXRzfFT5DmmrtSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766533463; c=relaxed/simple;
	bh=/8kN33I8bA7RCPX+VbXGZd1QkhUHJAOsoieb023EkFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utFH1i+eeZ3C8iR5WAFWxWu4KFdaUkgXrzx+/iybPCzj4z3GyXDl0GjQomVdT5DKRMGRZNvF8XU3cOPrxcTtpHCcnGEEDbtQTTHKWJGxyMOMAhkWwWzcojFMAo+dkctlX+gcKBEUCrFy+5mw2Cx122Sm3QLpeJ3HnKHbAACByGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpcEOuvg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIlXGj29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766533460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATYHY/NQnVWjttH1cUnHv7Cr35FcKdWXAUZQFCTGU6g=;
	b=CpcEOuvgoRXIpsb7Pkhx6DVphzww8XvraOBWY+EykUF+SceFI6ao2/uksWuvEYVtLsGH+s
	zjBHjonrcs1yD+aXNQDyZf7x1B7LpZhePGU2NPfkhI7SAb52W2SZzK5qM9nM+8bt8W+EzG
	NTgN4EakJJYWpt+EACoaZ2lMWNMFSqs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-rFas3-fHNuWmey0FfF9Lyg-1; Tue, 23 Dec 2025 18:44:19 -0500
X-MC-Unique: rFas3-fHNuWmey0FfF9Lyg-1
X-Mimecast-MFC-AGG-ID: rFas3-fHNuWmey0FfF9Lyg_1766533458
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0dabc192eso120197155ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766533458; x=1767138258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATYHY/NQnVWjttH1cUnHv7Cr35FcKdWXAUZQFCTGU6g=;
        b=VIlXGj29v7urgxe2Z2ttd4QkwmjKSlbtqQ+J8kB4RLL5VD1eRv/rMlZ+2NYZr9aBYK
         c7szI0t3nfdDD97uvNZxwBrVHXdOwVmZgyAsDaUxJFYdgV2PWmFpacmBK9rXR/fnz6Gq
         SC5Mg3ArOLOXbjsNijCSJpiDGNWGWwE7RH6GrvTyAwM74sbq8Z5VefTuIE10epxM4h42
         9u+Xi69lzafo5dnyRD51CTQmeNUYQ1nRGVsXDaB9ko63lkTmRJP2mWguC5ULt72QFuu1
         5qRBLAo0KAgpGHeL+aS7ixmtsZNlYyOVDY2ZpsiKQVllFnjOselk9NUwCXXo0dddLwze
         /keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766533458; x=1767138258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATYHY/NQnVWjttH1cUnHv7Cr35FcKdWXAUZQFCTGU6g=;
        b=lnP1BXo8nVL74/8L+nrIxz5gflwjyvyZC5BDClxjVoV2DKaspCO1UejeY8DcMAmIpM
         z2GmvLbz4Eva1vTK6eOCjE7dltgFEIvEkZiqBoORmqe0AjKRC7Bpsl3UGtD69Yga/Rpy
         vPV1T2B7E19OptF7kI63ZtEkJa00481o3zisMBm6qDcGenoLqf7s+Kyl5xPBPj3NX6di
         kbVo2+zoJQ+2SJoCoAwqDKNtb2X4ewMrq4dzKSU5vPhy7fjB0amLKjHDDgUbo8p1abTh
         DBaHfF8X/IxXJ02LloDiXpZIBX7HePfkPf3IcVH578IPNu8nqz4z0HA/lOoMl040lne1
         /cAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMn2Oe5PyFOqmVdrgpbq0qMZlQjpZg82G/nLL0MBmGJbgjJCuZ8c9kf4j16nQ6KW/8x0Ep1pMtoXE2j+IF@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEkdOOb1sLpfwNXdnVWFXzZM/APYjqQZZWxQTdhCJMJWF0x08
	FTHYPPKRuDfGfEFRbWJ2ADTi86LRkGKnK0G6x2xbx0HvZWuG3jIsULiZnP1Rz5exJ0uL45OmSpM
	rZCnOyGe2QlSTuxo2txfs7sfrMPyp4EZ7siGlIuniPbV6V6uQznstsYCdr5xcxghEc/A=
X-Gm-Gg: AY/fxX6X4AjaZGqO7xYormX6Mm/UaY65oDVrlBtamHVGGIYpErQ4aV+baDFjITMw2d4
	C3+Q9l37x0NT2Oan68rT+nlDob8NFSiVUJQ1Z7UPbU3OStvU1sRlkFarMYuvhw77HeB3xJNv930
	CXTxoc/Vcxld1dxrZXIZNo7wd8+zUWrnsWJvTtegJalWX5+ezqMIHxfFhjW/O3V0TwttjjkAroD
	9a79sr6nPXfEo+5nF2z/Ai7KoUw2/pQwDSrUOB96BRE9pbMENc75C/TJH2Or/EMRL3GcUf5v2wV
	PnP4s7ahI1NdPwihANeuMYaXvYF7/Z5PMDS3TPg0WI3qXFA1VMdmZzskLfegb57jPj8mGQOsd4/
	b7aMiJyyZjlU=
X-Received: by 2002:a17:902:e785:b0:2a1:47e:1a34 with SMTP id d9443c01a7336-2a2f1f6a1c4mr162159955ad.0.1766533458285;
        Tue, 23 Dec 2025 15:44:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV5T53bI9KkPU9CRutY6p/Ev419keVrVfn0QAl2ZyrODs+H9QO2wxDfhp8EuTrnIplB+ETZg==
X-Received: by 2002:a17:902:e785:b0:2a1:47e:1a34 with SMTP id d9443c01a7336-2a2f1f6a1c4mr162159805ad.0.1766533457951;
        Tue, 23 Dec 2025 15:44:17 -0800 (PST)
Received: from [10.72.112.70] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d6ec6bsm134758765ad.87.2025.12.23.15.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 15:44:17 -0800 (PST)
Message-ID: <bff1133f-d07f-441c-aab4-d0b6b313b7ac@redhat.com>
Date: Wed, 24 Dec 2025 07:44:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ceph: rework co-maintainers list in MAINTAINERS file
To: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
 amarkuze@redhat.com, Slava.Dubeyko@ibm.com, vdubeyko@redhat.com,
 Pavan.Rallabhandi@ibm.com
References: <20251216200005.16281-2-slava@dubeyko.com>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20251216200005.16281-2-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Xiubo Li <xiubli@redhat.com>

On 12/17/25 04:00, Viacheslav Dubeyko wrote:
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> This patch reworks the list of co-mainteainers for
> Ceph file system in MAINTAINERS file.
>
> Fixes: d74d6c0e9895 ("ceph: add bug tracking system info to MAINTAINERS")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..f17933667828 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5801,7 +5801,8 @@ F:	drivers/power/supply/cw2015_battery.c
>   
>   CEPH COMMON CODE (LIBCEPH)
>   M:	Ilya Dryomov <idryomov@gmail.com>
> -M:	Xiubo Li <xiubli@redhat.com>
> +M:	Alex Markuze <amarkuze@redhat.com>
> +M:	Viacheslav Dubeyko <slava@dubeyko.com>
>   L:	ceph-devel@vger.kernel.org
>   S:	Supported
>   W:	http://ceph.com/
> @@ -5812,8 +5813,9 @@ F:	include/linux/crush/
>   F:	net/ceph/
>   
>   CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> -M:	Xiubo Li <xiubli@redhat.com>
>   M:	Ilya Dryomov <idryomov@gmail.com>
> +M:	Alex Markuze <amarkuze@redhat.com>
> +M:	Viacheslav Dubeyko <slava@dubeyko.com>
>   L:	ceph-devel@vger.kernel.org
>   S:	Supported
>   W:	http://ceph.com/


