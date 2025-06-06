Return-Path: <linux-fsdevel+bounces-50876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F95AD0A24
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FC73B3B46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688423D2AC;
	Fri,  6 Jun 2025 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="pfMKRyN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886C23C513
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749251091; cv=none; b=eAn7EGpBFuKtx3c0VhpHwEu6bHvofT/zCfMeGV+5Z0BkJnOhkBmlucbuqjzARJfK2510KJloHVefUZV8NUp6t1tTADpPdgiiIJNtuIONkma+z6NhHpb2z7236SPQTNw6nhhzZEYO77Q1XX2xHos++HWddytZu//8BuzeLinHgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749251091; c=relaxed/simple;
	bh=8v1w/rx8QmKrM2H8CLoFMfy02CLFbjc7d7XobF+yimM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGPbZ8X0wuVxRN7nmrwnyM70by1PeDsbfJGQBc/AZcJAQYuQiOtt47tRl2KR+8NoFGhtfA0Id+acT/Aek2md7/jR/s/jlsdz9onMvc/kVWE3BoCqlRJU1/ISNLwD2CDIzm4js3JzZxK8Q7+uHkJdpfLZz7kRPCkgf571oTsOCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=pfMKRyN1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23602481460so11748855ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749251088; x=1749855888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uhme8POsgTIWZEfbXCMl9ex2ivqucnoJucp3kGTV+kI=;
        b=pfMKRyN1f+7gh1H/HAJrCnaYTyBc0qjI4+AD1e8JAwO+2eMEcypx8Ctu0hXR6M+jZf
         HED/MQrkQSAvVs3Omz3ktNbz0SO8WKcnMcOhIfO9tLEG3GzpqxJaG0TgMfkldl5+eFAa
         wvwP2aJkw9pOSNcvkP+/2P3iLFBkta59XbwSLuW2GJM4zeUFKgTMaOZ87LGiIZylqMsl
         AOF0g+FnFhhUempN2SYFtPudNC0ONNVWqzFplN7BHtCtARLh339h7WNTmXxVqEEmZgbZ
         D40hbNoX6hkQlSeEaGxoZajQTp3/Sp/VFvNJ7rLaZHjTgdZ7nsVvD3yroQDFCkMK25VA
         jKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749251088; x=1749855888;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhme8POsgTIWZEfbXCMl9ex2ivqucnoJucp3kGTV+kI=;
        b=Tst+xdsKwpA/vua+XwbUR+tw5ptnZtoLsKSdJ1fBTkeMRrmN7C9WQx/ikgTJ6JaVeJ
         UjAODvUp+znKhHBqbm2TekQxUW6PEn51roMfpVDRj+YnY9qpczGODoop6ZFVc9T2BLxN
         nFfxllKZqc4+nH/iC+Qov7TKPRck98TGfTuF/sbDZtLRop4wh3rVSf7y+FqGCLDnmLl7
         H1kfH8SWrUToeTvgIAJjASOc+bz6gVMcpMhvmO1lYU7gq7garLuMFIs9Z3tErkWs9WwJ
         bmectFNKDg3ur2BHrF5A/7mBc4DYPLrN7k3tNbc8OvZe81pL0PJFqly+fqWtPzwKrYZK
         SEpw==
X-Gm-Message-State: AOJu0YxpPcKBwlHZAN/S9343H7s2DAxrrn5m4N++feOj3Q1yd22WEPeX
	nAXRh4UEqlAdnTMUHcfFTuybPGIl2bLzi5wnHeNSm4kiTKQrtXVUQso43MKgW5+HuVc=
X-Gm-Gg: ASbGncsBQHsiGkMY2IaioOWvacHwr5YI1ZNWKSGYA3it7xpatRVIUCzC3ZO6rp21V6d
	LMpBNiLf76F5lwnpwrny8kLTTSOCkVMaFZ+R+e0CFI5ttgprJX8pzJ8IQiBhaEL3tLUmhrODUbc
	SDbo6TyLR5C8Hru4bIp/u/w0mCbZ15Q0PDjPIgPuoNJh4oHxgboN+USovOKGXbAEonduQefRhUy
	PlLXz9g0CoQ6L9ya9RKcz+yGrTdmPl52YjcIyD9W5rpe2CXrqXtm0kHo3lEXdni2V1qaqGkrW/L
	ugTuvxdLiUgA5xuAvsYyiFWym4CZ4FjJ2j5axTmk/NXFN0c8sj4OKpB5yUIPpHQKIYdcBGOksgk
	pT7v8flK17PF+vsFnPYw8
X-Google-Smtp-Source: AGHT+IFgrQDB6Nn2l+X/T0PcUGKKD0lTBhZasahpqZTWKrGawO0uowh230qpq/ePsvzA78EQxD38ig==
X-Received: by 2002:a17:902:d483:b0:234:9052:2be6 with SMTP id d9443c01a7336-23601d73edamr73967025ad.41.1749251088003;
        Fri, 06 Jun 2025 16:04:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:77a3:4e60:32de:3fd? ([2600:1700:6476:1430:77a3:4e60:32de:3fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603406916sm17406875ad.169.2025.06.06.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:04:47 -0700 (PDT)
Message-ID: <415dae31e51263864612eadfc5ce5699575ad2d8.camel@dubeyko.com>
Subject: Re:  [PATCH 1/2] hfsplus: make splice write available again
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, Viacheslav
 Dubeyko <Slava.Dubeyko@ibm.com>,  "frank.li@vivo.com"	 <frank.li@vivo.com>,
 "glaubitz@physik.fu-berlin.de"	 <glaubitz@physik.fu-berlin.de>,
 "viro@zeniv.linux.org.uk"	 <viro@zeniv.linux.org.uk>, "kees@kernel.org"
 <kees@kernel.org>
Date: Fri, 06 Jun 2025 16:04:46 -0700
In-Reply-To: <fa46baccde906c7e52b1d84264d284be1072ffcf.camel@ibm.com>
References: <20250529140033.2296791-1-frank.li@vivo.com>
	 <fa46baccde906c7e52b1d84264d284be1072ffcf.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian,

Could you please pick up the patch?

Thanks,
Slava.

On Thu, 2025-05-29 at 18:27 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2025-05-29 at 08:00 -0600, Yangtao Li wrote:
> > Since 5.10, splice() or sendfile() return EINVAL. This was
> > caused by commit 36e2c7421f02 ("fs: don't allow splice read/write
> > without explicit ops").
> >=20
> > This patch initializes the splice_write field in file_operations,
> > like
> > most file systems do, to restore the functionality.
> >=20
> > Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without
> > explicit ops")
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> > =C2=A0fs/hfsplus/inode.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> > index f331e9574217..c85b5802ec0f 100644
> > --- a/fs/hfsplus/inode.c
> > +++ b/fs/hfsplus/inode.c
> > @@ -368,6 +368,7 @@ static const struct file_operations
> > hfsplus_file_operations =3D {
> > =C2=A0	.write_iter	=3D generic_file_write_iter,
> > =C2=A0	.mmap		=3D generic_file_mmap,
> > =C2=A0	.splice_read	=3D filemap_splice_read,
> > +	.splice_write	=3D iter_file_splice_write,
> > =C2=A0	.fsync		=3D hfsplus_file_fsync,
> > =C2=A0	.open		=3D hfsplus_file_open,
> > =C2=A0	.release	=3D hfsplus_file_release,
>=20
> Makes sense.
>=20
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>=20
> Thanks,
> Slava.

