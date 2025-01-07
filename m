Return-Path: <linux-fsdevel+bounces-38584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3DA04405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EFC1887016
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F31F37B8;
	Tue,  7 Jan 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyIQYspd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD51F2C3D
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263018; cv=none; b=LpsZHztx31PtNTYHvPMn6Nh9ClyQ2//QU0qi4G/vI3dnj0cTQGJ6XdeWJh6GPPRLp8npIZWBbMTd1lOSb0jrn/ra805wXi2se8iFi3uzL31kENSjyu7yp5oIgmCaPCBYO3dCo5X8OmWO0AZEOmhl2QSiolYcr7QGLuLhC9/HXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263018; c=relaxed/simple;
	bh=iIMKWVYEenXS4wVT1eUu2GxA6FMq7h3OfVPcY+6NPsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuEP2s2IgmqiNIiSc2kFXnXnxBfrRB8MfI5qh4zyflv/tDrk+WO6hGg08amOARmA1uiEPwujZ0CLSIU4Ct1VzRGAzFGTqGpqSDih9nGQRkz0Givegaqhj1bWaMUULcey7r/R1bR0vfBziPAiNbi1WwOvH3tvwVrogu5KOGgba8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyIQYspd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736263008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma3/zh91C/LiLjTFUq58PsMa7gSqvD7Ef9W+toJutkk=;
	b=NyIQYspdXHSvCirRObdCXYiK4dBEExJYW2UAraJSbb7OSK/FNa0DKMgp4uHXESvcRjvix4
	tlugaPHeRJk5Im4che9RIYrXLIyjcq7T8oO3J40NPCmbK6PRHdrR8zjihpg9SdXuXMqMQ/
	l88e581U4Q9ImOHByaVq4T+QQJ/68mk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-H50nTHm-NjWj_Gc2pCdlSA-1; Tue, 07 Jan 2025 10:16:47 -0500
X-MC-Unique: H50nTHm-NjWj_Gc2pCdlSA-1
X-Mimecast-MFC-AGG-ID: H50nTHm-NjWj_Gc2pCdlSA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38639b4f19cso9854457f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 07:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736263006; x=1736867806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma3/zh91C/LiLjTFUq58PsMa7gSqvD7Ef9W+toJutkk=;
        b=EERg4zJi5HvURWQHRhhHzipfX8xmKxmQ97X6NMcpIgZYSC3v3tcZPM9efd5DCKZiHd
         CNr80/vRDf13/9B7/93cVlweoH4GwgQ2EgORYszdP/3Ao4hbKB+8S1g69SK9FsSymdBf
         0QriJoWcj3XDHTIpQB8fyAmXzy8zu+3AJ/aE9guT1ziB3IU8Qv/fmuuTUobapKVuFmgG
         VcHpcJ4z4g9iFS2wGtQCjBbaJiK1ASljYoZbqCG5AKZ9OWtDhRcXdT4Msb8M3SZ1AY8O
         RqRAY0uHJhjKk4PlhUWLk2xkj2oG3XFu7rc+okMpVMFm39KZTX16IOGkfKeIjiHUUvg5
         CNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9/ljqqIiLgJUgE/hsvYnnaHAf12FgPWMYdqB3KsR+CbnS/B92gznhzhZvS1rbXNywaFNo9PTff0P7RC2Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvFwTu1aQ4MUoN+41cQE4ZktFEXiUkiMc5EaPk4P7LT5T+rKT
	GLudbf1AhEujUk/DBOtIkzlOV4bvuAjs+2UflNyjFsbovMh1BcWX7Z63QS65Q21kKGAzG4OZVmd
	KhCX/pN2V7ZspG0z4uTE9r2EjJdwKXIiqtVwpp0L37fa3a5URuakuR0j4cTGnPVc=
X-Gm-Gg: ASbGncsF70L4kVRp+1Y11BSOEpELK/WXZLt7opjqn0YTfGa7Htr34uRsBv8nZV9CoYu
	Kh/bMfkaJtBQUXsqRI2it21F8+a6uRh0ZJRfpYFkpvEAiD4zUBCGo+bY7KCI+O8z8AtRARsnAjX
	xsgo0IsnDxVeJpBaQez86oHvcK+HSVA1AL+mCF8cX82INAvIjqFGA/aaLnlor61wW8LvxSWB8vq
	gDFmCmTrkdS+4XHuNSsdqhukzd6EFlVsUw7Gb98SOur4LTEr5RkC8SEKD6uSCchk9klVEIO/M78
	rkllXt1t0SZ+F/Gbdsctt5+lcbSZPeHPcM3r1Mo7MLRY+v1Pj02VEemCvlv+0dRcTKhLJfVcNY1
	EM2kcvVB17DUrfImhKR0aYN4bBKcSOQY=
X-Received: by 2002:adf:ae01:0:b0:38a:615c:825b with SMTP id ffacd0b85a97d-38a615c8353mr15606227f8f.21.1736263005764;
        Tue, 07 Jan 2025 07:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Eqpa+YyRD8YF7F9Tb5CZKRDg6aF0h++RnF6RkL7nTIJkdzBiIwiqHG0JFE3gBl2fKiBe7w==
X-Received: by 2002:adf:ae01:0:b0:38a:615c:825b with SMTP id ffacd0b85a97d-38a615c8353mr15606194f8f.21.1736263005378;
        Tue, 07 Jan 2025 07:16:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f013946sm2414147366b.136.2025.01.07.07.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:16:44 -0800 (PST)
Message-ID: <7854ef21-0a4f-4afa-a1f7-90e5cec19032@redhat.com>
Date: Tue, 7 Jan 2025 16:16:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vbox: Enable VBOXGUEST and VBOXSF_FS on ARM64
To: Christian Kujau <lists@nerdbynature.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
References: <1c6f68d1-a51a-1c38-2eca-89fa63dc30c6@nerdbynature.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1c6f68d1-a51a-1c38-2eca-89fa63dc30c6@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

On 7-Jan-25 4:01 PM, Christian Kujau wrote:
> Now that VirtualBox is able to run as a host on arm64 (e.g. the Apple M3 
> processors) we can enable VBOXSF_FS (and in turn VBOXGUEST) for this 
> architecture. Tested with various runs of bonnie++ and dbench on an Apple 
> MacBook Pro with the latest Virtualbox 7.1.4 r165100 installed.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thank you for the new version, note that v2 has already been applied
to the vfs tree though.

This is fine, the missing changelog is really not a big deal and
the changelog gets dropped on applying the patch anyways.

So this is all merged up now.

Regards,

Hans




> 
> ---
> v3: version history added, along with Hans' Reviewed-by
> 
> v2: vboxvideo change removed, see:
>     https://lore.kernel.org/lkml/7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de/
> 
> v1: initial version, see:
>     https://lore.kernel.org/lkml/a969298e-0986-470c-9711-703af784d672@redhat.com/
> 
>  drivers/virt/vboxguest/Kconfig | 2 +-
>  fs/vboxsf/Kconfig              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/Kconfig b/drivers/virt/vboxguest/Kconfig
> index cc329887bfae..11b153e7454e 100644
> --- a/drivers/virt/vboxguest/Kconfig
> +++ b/drivers/virt/vboxguest/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VBOXGUEST
>  	tristate "Virtual Box Guest integration support"
> -	depends on X86 && PCI && INPUT
> +	depends on (ARM64 || X86) && PCI && INPUT
>  	help
>  	  This is a driver for the Virtual Box Guest PCI device used in
>  	  Virtual Box virtual machines. Enabling this driver will add
> diff --git a/fs/vboxsf/Kconfig b/fs/vboxsf/Kconfig
> index b84586ae08b3..d4694026db8b 100644
> --- a/fs/vboxsf/Kconfig
> +++ b/fs/vboxsf/Kconfig
> @@ -1,6 +1,6 @@
>  config VBOXSF_FS
>  	tristate "VirtualBox guest shared folder (vboxsf) support"
> -	depends on X86 && VBOXGUEST
> +	depends on (ARM64 || X86) && VBOXGUEST
>  	select NLS
>  	help
>  	  VirtualBox hosts can share folders with guests, this driver
> 


