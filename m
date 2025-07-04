Return-Path: <linux-fsdevel+bounces-53975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DBAAF9A0A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4DE5A79B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 17:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DB1FCFF8;
	Fri,  4 Jul 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="kVHFVuE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9414AD2B
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651134; cv=none; b=qVyDaBTzylneFtsee5V09xOv3DWwcEX+FhevBLkCZ8yhowO0xvFCLK30ouMytmwUkxX4G2skojOk4i3W3HG0p4vVuKsCmeGaSPpBbyPJb1E6zMmwSsfWA+dlw7eguEFvKdKubd++m3UrHxUzMWosMrmZRJ+3hBY2S8yOnsHVIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651134; c=relaxed/simple;
	bh=Nqm9M4UJIqwudHAuGH7UYCWuSwRLdeHqz5vOhTfsqY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYmi4Pll6Zj3Pt654t6emueBhI18tJtN97gKgaViw+D/u7bcnIXnFJdB/9fgfSG/TE8TqOZAhNxDFMMp6HX5u3GepooT1D1DUoe771P8kZ7bc0KKCC/23PkZal+e5Vhue2g+wDKCProro2qU0ygukW03FGLORjztwsr1mWWLs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=kVHFVuE8; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso995551276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751651131; x=1752255931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRRTUBR1HhzbPWZOo6ysCxsvxUXtkw1uTBwQrVosYbE=;
        b=kVHFVuE8jGnyzQdWYrL9udFsL0iMBPRmEyadwhxcLNrX6PDfKdNPNT9naBKapb8K8g
         GUylmwYGn6ekk2Mb9/UzFsxXqF8gl/w3kkI/IlNCUlOED4nwDtUvjPGlXg18kcg0h/4C
         ZYrM2SYfJ0u9Oq0Wus3FzUo4WOtaRZoGotJTF6dN5fqhilicNygIRAGZjQHnE0BnS/ZR
         4ELs8MJ868dMBRyOcWpdM0AL4/+DQsH2sP5Y/uhhSRi8IiYb4xj7eZJcLGGzHEgpvs6b
         yc6OpyJmc9XBeu6ayBjQc7rKgG5LAq1PVpOw0iM4MMDb2UMJbmApocNSIOk53fF5qSW+
         0erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751651131; x=1752255931;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRRTUBR1HhzbPWZOo6ysCxsvxUXtkw1uTBwQrVosYbE=;
        b=FKga9+h8DGVMuSQhUY4eQZlC9XxeGIt4LlwcgXQJ6DzYqwO//lP8ZgYxj2cYjue0xZ
         PLkHxKSyZI27BlRPyO1ZXoJ28P/HL2ylQ5xAQFuP1EuOgIzq08OgiyQ7dlULv5eVr+o3
         r/DcrFvAYBiFa8afvC8sKHFa9aamqU7ixaZLomZ/0rG5Nl+0q3XIiN5iu4u08CtixHFj
         hKq332AzraPfwIyyCF1SnrbAQGIERlxdHuq48dJw0Nktfw++n1dPaBG3k1ViyHLf7fLx
         VTdpXgtOmyQqWGWJtc71gc/Pi54S33TEabzqRfXKfEbO8Y82ZgPer7ios86mDFCcMPqa
         oT1A==
X-Forwarded-Encrypted: i=1; AJvYcCUBfzeipD0gRGSWctswcUYJ+8i6Vmsu3y/PK03saBvQw+puUI6U2OhYLfvtbTQpqSBBy0Wok6wX8z4eg2nj@vger.kernel.org
X-Gm-Message-State: AOJu0YxpI/p3WVnECaZIpHr9Wrqm0+sNexzUruVIv1z0a1qluyWbLp2+
	axgrAO/hgEiA0FdiXXJHhryvqNMVq7FICKxB7SD3BP5GTs7jcapvoql0egfGX19f1Ro=
X-Gm-Gg: ASbGncvk6PxLsfjPlvAa/bUigE6ZwgQgE/8iCAP50I9fTZeCobnqqXn+X1xEruckzzx
	cEe0sx8nNZ6TMC1z7UZkEnIa1JCdynUcnn7/1IT0W4qwgOTlfaThQwu0XSoAkAH8MUr/IX0j3Wo
	kg/Jd1whTJMqVqUDyCwyFW8o+Wox0Sya3bQgSUP4H/TJg1nhhdvUL3P9NIWi+os1JK9+7f8K1OS
	J6NijyPAoJiKX7kfsIoKHotcrWcAiPOL/sm5ty5mGgfHrOHtxcPxMUWzTiAmgHwlKeI2RbrbFno
	q4DSK2FjdfCwnySVCjmUrLoTQRqjdJPEiCASQdpVapGWWtI9PRAUJVB3ugiMB7bJjxcGAqmPzlS
	Jx6l5YDr7yyq7mhLEVJRFT0H9JKAClUo=
X-Google-Smtp-Source: AGHT+IHavxdRXfQcFPtCri7JPle6nXppaWnSECfYS7k4+PrbVcT/6JmmoNF/J8UBNVnhAzeOW0UVtw==
X-Received: by 2002:a05:690c:3709:b0:70e:29d2:fba1 with SMTP id 00721157ae682-7166b66f4d6mr36192927b3.23.1751651131297;
        Fri, 04 Jul 2025 10:45:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f030:281a:9e2c:722? ([2600:1700:6476:1430:f030:281a:9e2c:722])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c48ba54sm754640276.43.2025.07.04.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:45:30 -0700 (PDT)
Message-ID: <3c4ac1ab5f7afbbd745f88c595ee1465fc2e9ac6.camel@dubeyko.com>
Subject: Re: [PATCH 3/4] hfsplus: enable uncached buffer io support
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, axboe@kernel.dk,
 aivazian.tigran@gmail.com, 	viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linkinjeon@kernel.org, 	sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, glaubitz@physik.fu-berlin.de, 	shaggy@kernel.org,
 konishi.ryusuke@gmail.com, 	almaz.alexandrovich@paragon-software.com,
 me@bobcopeland.com, 	willy@infradead.org, josef@toxicpanda.com,
 kovalev@altlinux.org, dave@stgolabs.net, 	mhocko@suse.com,
 chentaotao@didiglobal.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, 
	bpf@vger.kernel.org
Date: Fri, 04 Jul 2025 10:45:27 -0700
In-Reply-To: <20250626173023.2702554-4-frank.li@vivo.com>
References: <20250626173023.2702554-1-frank.li@vivo.com>
	 <20250626173023.2702554-4-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAaQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-26 at 11:30 -0600, Yangtao Li wrote:
> Now cont_write_begin() support DONTCACHE mode, let's set
> FOP_DONTCACHE
> flag to enable uncached buffer io support for hfsplus.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfsplus/inode.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 26cc150856b9..b790ffe92019 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -372,6 +372,7 @@ static const struct file_operations
> hfsplus_file_operations =3D {
> =C2=A0	.open		=3D hfsplus_file_open,
> =C2=A0	.release	=3D hfsplus_file_release,
> =C2=A0	.unlocked_ioctl =3D hfsplus_ioctl,
> +	.fop_flags	=3D FOP_DONTCACHE,
> =C2=A0};
> =C2=A0
> =C2=A0struct inode *hfsplus_new_inode(struct super_block *sb, struct inod=
e
> *dir,

The same question for HFS+. Because, it is again old and pretty
obsolete file system. :) The main use-case is simply support the
capability to mount HFS+ volume is created under Mac OS X, for example,
and to access the data there. What is the point to support this feature
in HFS+? Currently, around 200 xfstests fails in HFS/HFS+. We even
cannot test any new functionality properly. And guys reports bugs in
existing functionality. We need to be focused on this right now. Sorry,
HFS/HFS+ is not so good ground for implementing new features. :)
We really need to stabilize the existing functionality right now. And
we have a lot of work yet. :)=20

Thanks,
Slava.=20

