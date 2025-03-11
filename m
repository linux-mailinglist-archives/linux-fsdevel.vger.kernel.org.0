Return-Path: <linux-fsdevel+bounces-43690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A700A5BD46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CB81897E63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66030230D0D;
	Tue, 11 Mar 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gqe/NiK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF822D7A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687797; cv=none; b=ItrGhbwGy6Jj7qtiZ9Q78msIzlRbyjYKbeX/UixshIWmo8lejzFSIWhBasSJenVhaPC7XFH/zUlDBsoe9DsfLEzuFrGsPzNMpG2Lqy4bYt3fY/rV6tKCqxv3i+SAconZqynpK3RMGP4xjQK/KT59fts+RsCXvHjHYLJM93kCX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687797; c=relaxed/simple;
	bh=ZR+XCIBQs9+80ifRtPgR+U/OFpGq/zuM7lgT746lhxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mvy6F1A9M3r4ItfJvV8Pff4a/rvIyNIzB3134U8rveLelzZhWG5Dyya6tq40Vt904ZJnkj7B0UknZEXxzoK+tB7llaKsJme9breuxmKvTyU+qx+tyVAdsP13bao5bPqevNH8gBz1jSJy/n8TlH02f3DlPKuXjY4q8ykk5OKDGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gqe/NiK5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYjkd0g01QmPqFmmHmr74WTt10z1qqPixGBi+49Tezc=;
	b=Gqe/NiK51gPuiICF6Ijdj0fYkGxtn1lBUPe22fi8LgVsVayDil5ca4a6ZC9oS2NhlmcI+Z
	HNm8knXF71IARkbhAXEXV4UZmememAmrA8FCMit/TAMwHghb2MlM5I5bwMYxKyKD9bfFdY
	2Y2nK0UAEhr1P4Q4N/Q0yfiYFj2mAUU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-7myi1EWNPNWtgudn72IgKQ-1; Tue, 11 Mar 2025 06:09:53 -0400
X-MC-Unique: 7myi1EWNPNWtgudn72IgKQ-1
X-Mimecast-MFC-AGG-ID: 7myi1EWNPNWtgudn72IgKQ_1741687792
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac287f28514so267966266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 03:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687791; x=1742292591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYjkd0g01QmPqFmmHmr74WTt10z1qqPixGBi+49Tezc=;
        b=U5FIdxsxfeoOK4PK7x7iZKryoxAOBbvsBdgBgrJxJk9QQf8ZyHTBFmn0S5MK0JQC79
         1dHPptNPDCeygU86dzJl7pClvIv0j1PAgpQYD9Qbww1dJHDmZEMtxCNeJcYkviAj3weZ
         zp8nWFSV34Jn7FOSrCYAoV3H68EXkN842bivUFEdeBjmy0gcDS6UeivppBAh/KRcsU53
         NUS2lDP5qYrr0fbDf5ZlQYYh7PJgNWkzNM/uId50AAvdhsNHvq0HOFysGBkA5FH4PiMd
         c23uUecDVsEz0oUrXr2dyisBdrJxZ3R3wKUSWOesWstpGxCIfLUE0/aCHTiEAlFfwec5
         TFFg==
X-Forwarded-Encrypted: i=1; AJvYcCWaYiYiLssyyOK26+hGAfBg6S92+qbnNlDyL+ZGx7Vcr/tMp8cYyBPMzw3u+IqXY0iPDc5qgkrfh9Ldh0uN@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEMF1zO8PcojZJvUfSxtWFSi5ppmoEjpdS9lAB7Ox1EKYgjb0
	LFX/+Z/xNrQSWq9OV+i3IBdoBoTSXE/JS6zDR53YtRvXjv42NNismMZdIEBeAungWZovpcfSb+n
	XB3e3GD4KdwRT85dz0udfV/Hkupno7GNpdzhXmZkwCkuzpsHqBNxyu9n+C2DdSd0G7c2gsM0=
X-Gm-Gg: ASbGncv657c10v3V0VfD6/2aL6/rBXtw1KRQhIa2HLpPFpqIAEpgbwHBp8Gvon62zwv
	Hux2nfspINrsY1keHikjKb4EWqdLN8ejxvVOIUyTf/E0TDt2TtiQ3nTp/WaEu0o3qG7gk76H5CC
	gemxOK9sQl5Bfn+Oumn86L4l5MDtiVud6EO/P0+pAOrEgr7JwUXzoUI4tc1H00deQeIlVpWshOC
	AblFyKHSOpRRtfZJLH/WR/2+NfaeQRxQCktzSTFMOhZeqV0tgZEo2VsNafciaGsZUei2cc0d2/e
	EkCGLUsmDC8g69Ja30FnEUPBSRSO9fhQ5/3yH756ZyceLKJ5l9oADmzQgRjscUk6mVo+AAa8bxm
	BKrb4BGqrCHMFNK7RWmFPUW8QzZiPJyTh0ggpvD28n3JST3bwCkOoRUblzu5/ycDa6A==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr2043899566b.5.1741687791352;
        Tue, 11 Mar 2025 03:09:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOtp2eumlycwdsPaAxaDUlofVKvmeDoy+4Ahh4afVHjwmszC51GixSB4O24V97bjopnGYZwg==
X-Received: by 2002:a17:907:720a:b0:ac1:e881:89aa with SMTP id a640c23a62f3a-ac2525b9c95mr2043896666b.5.1741687790943;
        Tue, 11 Mar 2025 03:09:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac288ffe157sm449727566b.132.2025.03.11.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:09:50 -0700 (PDT)
Message-ID: <7ceea724-4e9e-409e-88fa-0d186096744f@redhat.com>
Date: Tue, 11 Mar 2025 11:09:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vboxsf: Add __nonstring annotations for unterminated
 strings
To: Kees Cook <kees@kernel.org>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250310222530.work.374-kees@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250310222530.work.374-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Mar-25 11:25 PM, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> This effectively reverts the change in 4e7487245abc ("vboxsf: fix building
> with GCC 15"), to add the annotation that has other uses (i.e. warning
> if the string is ever used with C string APIs).
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Brahmajit Das <brahmajit.xyz@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1d94bb784108..0bc96ab6580b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -21,8 +21,7 @@
>  
>  #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
>  
> -static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
> -						       '\375' };
> +static const unsigned char VBSF_MOUNT_SIGNATURE[4] __nonstring = "\000\377\376\375";
>  
>  static int follow_symlinks;
>  module_param(follow_symlinks, int, 0444);


