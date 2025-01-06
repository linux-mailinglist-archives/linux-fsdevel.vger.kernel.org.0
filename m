Return-Path: <linux-fsdevel+bounces-38448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE04A02B7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455A0166562
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553E1DACBB;
	Mon,  6 Jan 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHCfKGrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B0165F1F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178190; cv=none; b=uTULRNHD4NrKKa3FjwCrD3n4kB+WMXPlEvnQh4H1Dm3cJhFlQPClms8pFFeUx7nbiwwYvj1MJP5no4JC1O2+FCXwR37hpzUcYESPAWDMlCGiBI3UAMKYqGDA/FtCK5rt/KFhyl3pmxIMugIyfX/C1oyH8JqEB13DHG2oOiwamb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178190; c=relaxed/simple;
	bh=pjRYLW2M8ATiVu8MdExKBxk6pj9xrLtCQoBwL1iqToU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8XDmRv9pDBOrEREgcklIXTmaTSiszPuKwG+YW6xnlW644FLvs87SXQqPJagYfIx6YQCwhmRA/owM9lQo3MBnbr6gT68EAQxSG37zs8OmMq+lUSmyfxICBXpg2WpPq+rDhlzuhnDwUS40yGXWnOFmpRsS9fYYhcGCeIQkfb0lOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHCfKGrm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736178187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8+TDjby6KE4EMO7ds4q72h8NVWVA/u8ThRfkShnz9I=;
	b=cHCfKGrmDv7WXECG7t5ayVBcnuEZLtvzHFdxbRqFdWNT85Gb45z7+vndKN2o6MmqNXgjiX
	yKH1Y1b5Fb7rUIj4GJcCCGALRfYXbrx1+mULjw34y+fvpUnTuAKADF28MMI4Oq0osUICPs
	fnmbmWFc8SGriJC61h9JctBNdY3KtWw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-nbYvWXQQMmCCD1bamVxK5g-1; Mon, 06 Jan 2025 10:43:06 -0500
X-MC-Unique: nbYvWXQQMmCCD1bamVxK5g-1
X-Mimecast-MFC-AGG-ID: nbYvWXQQMmCCD1bamVxK5g
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa67f18cb95so660665566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 07:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736178185; x=1736782985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8+TDjby6KE4EMO7ds4q72h8NVWVA/u8ThRfkShnz9I=;
        b=hWlh1U/DVldcjiELV2CXzMQar+bWuS8lWZcSizrJGb4KhltqxMh4eG5pkc9eGt330n
         O17WpyZsPKIomkb6nG6sTHH6PTDHzw/Un8dIgFT2hgKFC00ase4QqYyrHyZuwxQvBGkn
         Dg1onZcXDuWC9xcbSIC48MhrNTAG6G64l0WH0v0f0tRfCTQOgGLZ9gkSFsiqcMXB4Gln
         DbuMZ9fQXsDAQsVWq75RYGqHZF/2TLnH+KnGvPuasveBROsJIwLhKwpKffL+wXtf6SPq
         9gQvlwXRDLdNP35Uyz8WlC4aeqyye9BZv/QL/lbv+0qxihqfLNJftmJVglVMnTNmKDAF
         /F0g==
X-Forwarded-Encrypted: i=1; AJvYcCWq6TLwCfi0V2X56gaDtMyPnhoCWXjHU8NkOKHrbPDVjQH2bSQ2uwqdWSkdfrjf3jjlYjVy9cEuk13yofsb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JgLoIXX0LJ4HB/oST7qIjsdPxeN5zzim//sk7p7c2w8hAXH9
	DEYBFLBLs0TGHBD10v+0qldeU2jUlvkcPy2uNZfiPVd/iFZ6J13SlfmvCIkGWaPQwVR04QPqH69
	NeepGew8IPHyIE/S688GMsQxnzozu/7WBBkn9z4H9hv7N2KGud6PJRgyHHigQ3vc=
X-Gm-Gg: ASbGncvsMHjA09kvFUyK34KKtrcYLuwq1mAi8ROLZrGdL9+XNgcw8wVLX6sAF2QSNVG
	HjTLNzFYi45cFlBMd6a2vm0htHOlKlSZEwrB6CaMTNgbg7wuRBvS3k+CHVo6DQUBvLiTTc3W+CX
	JJ6Sumcti9Mey23A1DUkfU5XiO1pEMj8jURpacyG16O7kVIlFiPsvEkWV9CxqghvuztTE8dnzKs
	tNjSmgFZanJqATIwyWuRPyByt8P3OYwaSYxc1TMIwzmRdcbBf2s5VGIhX50hodW9M+yOEForRHY
	8d0okHrEuc4G9IneS7bSVOjT19TnbANelp244vlwMt06K1zyKhwBD5L54uelqynAtnjXwAfgw6g
	AMw6dEoOzaaOIpexSUe39Szk2b55CeUA=
X-Received: by 2002:a17:907:60d0:b0:aab:933c:4125 with SMTP id a640c23a62f3a-aac2702afb5mr5740127966b.10.1736178185492;
        Mon, 06 Jan 2025 07:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoWFIOSEiFHslSxQ8PU0t1ES9RVQ8WPUWcdVI/Jbu6BoiLVlmCy3XsgKJFB9kF05shhAOW7g==
X-Received: by 2002:a17:907:60d0:b0:aab:933c:4125 with SMTP id a640c23a62f3a-aac2702afb5mr5740120566b.10.1736178183924;
        Mon, 06 Jan 2025 07:43:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f218sm23879990a12.26.2025.01.06.07.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 07:43:02 -0800 (PST)
Message-ID: <b1436351-df89-4f57-b394-6cd202d9cb9a@redhat.com>
Date: Mon, 6 Jan 2025 16:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vbox: Enable VBOXGUEST and VBOXSF_FS on ARM64
To: Christian Kujau <lists@nerdbynature.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
References: <7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7384d96c-2a77-39b0-2306-90129bae9342@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6-Jan-25 4:32 PM, Christian Kujau wrote:
> Now that VirtualBox is able to run as a host on arm64 (e.g. the Apple M3 
> processors) we can enable VBOXSF_FS (and in turn VBOXGUEST) for this 
> architecture. Tested with various runs of bonnie++ and dbench on an Apple 
> MacBook Pro with the latest Virtualbox 7.1.4 r165100 installed.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
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


