Return-Path: <linux-fsdevel+bounces-46876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6B7A95C39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 04:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E00178C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597BB17B50A;
	Tue, 22 Apr 2025 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guijnS35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B55196
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289593; cv=none; b=poebtAVSjuHF9spD+lnmOi6cnmqvVHQ6JjKIvv9Vdzr/+YP01YVC5TyGH1F8lo09OGr950r9RfvUxdj0H5ASXDf0rbggHSZ4SHirCHSxDxT37c8MiwIUwREaMe4b+6ZTAIx7gAe+g+IPHZZ+o8q5p+DalYYwqYcIjvjfq/YFCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289593; c=relaxed/simple;
	bh=cwtMZfBdpFbRa3t3ORIYA8mpsHP3u8bjDKE5daXQS70=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BYVi6f9/zLBkh06M9Kr5COqnESfY4/n5bu/UASqt5Ms6w8hUn5Q4bJrBtpXcls7/nSpC4PQ0kDyo81ojI4EZxB5zWikNoObcBrJ86j2+LRwG1/FOH4vCu5ZqfXLtgSrGpxx5tx/NCm7MNk3cpAqft57b2X0e7XXZUJ2SoYVGPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guijnS35; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745289590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyDcFYqaztjW8wqaOBmIzVgkhhvkajnReTQLh/Jex40=;
	b=guijnS35msq7d5w9cqv+gWUAvT+gyevdnJ1fdIIp0dI6KT8XXYjbUEeLB8kKQRe1/Ksj3M
	NtklqaSEOv5pAXGQesQNZBo+tiYbSU12Mok1M+FNMZC7AXGsrDVYypIjlbq8Tklv94NjYb
	17sAH9ljNurmyZA2mV8ihk0KYWEsHpw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-8PzEjgoSORGSajBwFJFaNg-1; Mon, 21 Apr 2025 22:39:48 -0400
X-MC-Unique: 8PzEjgoSORGSajBwFJFaNg-1
X-Mimecast-MFC-AGG-ID: 8PzEjgoSORGSajBwFJFaNg_1745289588
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d8fc035433so58205165ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 19:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745289588; x=1745894388;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyDcFYqaztjW8wqaOBmIzVgkhhvkajnReTQLh/Jex40=;
        b=ovPcY2/OmFrkfZY5bA03MYJ3oW9CU91x8+G112AQyg9WU8yOdL8eNc8iRiCHkpvEeX
         dbndXTZ9J1WFh8yplajJuZTDk40XLHAQ5skk+KWowP/5ZWxE8v1Nonm2cxu0F/wxQb1C
         1wlKPcycOQctkhKNpbJ5Em8M/3/mlcrgXbNdTTM2vh56haImy3ek4XnDI9UeOgEqu2wG
         Diiw6caIKGxKX3+8zuK3hcJWY4hbCTYti6o+iA0qBQqFJJ3pTAfRViz8yZL+aR5SM+b7
         CWy3WXwdzdUEWDyBu8badXqBNL2k6qzYnRaUVQ8RlngqUdDfWYKsOnF5R+FKiNEEuELi
         wT1g==
X-Gm-Message-State: AOJu0YwZflAOOCFw53QuWAINoud1+SriOA+AEmD65URNdORFvfwqrAMv
	PMdpXhH6P5di5OX6ffGHedDknnl8obcPbd43FZnRGb5IM2HYBHMda0YUc163LJG5Fn6YqOv3gs6
	TiHlT4M4m2G/Pge+3jR6qLCKmJgVF4d2VzZ+T6+4KrH1ocvkQKn/DiFfeVIjGax4=
X-Gm-Gg: ASbGncsLm0M1MqpCSiE2dLBp4dZJ9RnqCGh93Lwzn3b5HA1OgX38kxME6PHpY9QweN3
	NGAKNB0SeWZsUlLRYbRJ/ZKMVGcGTR/+nPKeyl2BkBhaABZS1y9WhCz1gfPUpC4M/HcEIpoxyUk
	gPVzliUb0ctFyWkl+TDl4g5voX5sT+WBQ7jDG6STlevyWHO+obAKhOydJfx1/avHbSm519fZMZi
	wtyrLFs96xrhO5a+0qzj950dbBbUZZpkTdeZ2GYXH7smPVRvZ8oli+Pu1k/B0zOJ6hNFOyeNnRw
	EHY2C/oo/2dgVjND3t8=
X-Received: by 2002:a05:6e02:144b:b0:3d0:4bce:cfa8 with SMTP id e9e14a558f8ab-3d88eda86a7mr127056815ab.3.1745289587851;
        Mon, 21 Apr 2025 19:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+PgMGlCD9AkAJAGaMvk/H7oo78RUGqiGCD+M4Q/Y7QmJRC4KUtzJGwo9PdoGdwt1N6Wwfxw==
X-Received: by 2002:a05:6e02:144b:b0:3d0:4bce:cfa8 with SMTP id e9e14a558f8ab-3d88eda86a7mr127056665ab.3.1745289587583;
        Mon, 21 Apr 2025 19:39:47 -0700 (PDT)
Received: from [10.0.0.82] ([65.128.104.55])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a37cbb4fsm2100574173.16.2025.04.21.19.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 19:39:47 -0700 (PDT)
Message-ID: <5225e8d5-8807-4e33-8e23-a6d19c7b9f77@redhat.com>
Date: Mon, 21 Apr 2025 21:39:46 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7 V2] f2fs: new mount API conversion
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
 lihongbo22@huawei.com
References: <20250420154647.1233033-1-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250420154647.1233033-1-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 10:24 AM, Eric Sandeen wrote:
> This is a forward-port of Hongbo's original f2fs mount API conversion,
> posted last August at 
> https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/

I'll rebase this onto jaegeuk's dev tree and send a V3.

-Eric


