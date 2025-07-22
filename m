Return-Path: <linux-fsdevel+bounces-55722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C30B0E3DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A26567990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630C283FF1;
	Tue, 22 Jul 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="B8og0IIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB119CD0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211213; cv=none; b=nZuhGtnJ7Xf3KIrdXyzVhHomQNPomq8YG+U6xXswmzlqIUCLSyC7LkZnVazkVq/8M+dGISFXkFDTot2qz9Crqccd44UYJDgQzZ5XLh1I9UXdaPxqZVllT+15/FqNoD1iXCV3kH3DPWDagYyprycOXPixaBDI8fKLzoPS+j92jAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211213; c=relaxed/simple;
	bh=XkgNOqeuinuA5Mk7YTu58TDMc+OUok+0JFwRFKjQetY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSJuXV2xyBDKBKywPC3FQcHX2SvH7M8cgHRHuZGbKFktuat00vDgAMyFHOTnW/IvEXtGksYODPmiIX+/SFGljAtB3OHZPL8U7t2bFDr6Y7qiZljjXD9PEwJJrpyvp4itel7g8tc02KYg8PA3nidvbBQ0Q2DAdcaNqClIlW+dNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=B8og0IIM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8dc01ffc4aso762560276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753211210; x=1753816010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNrRwgfrTvGU24RYMFx+vtCK7Bks5pGUToQFKmLgYyw=;
        b=B8og0IIM4Ric8O/vn/tjsa069+Gg4S44wftEK8N6JIhVNL/x7djZgXesYwIRgcxmYa
         dBcW99GxPiyS960Fxxz5J/Z0WBtWUWet/RCSLm2WbVnz8/Li0bSjL9s30hQlssjsQi64
         nZhpt8fjHDX9cZaJDncRf8hQGesnjOGYKUDVVSMaAi0a808/QAuVyjCWtNpHQJ52E3zM
         cmvGLar/vQrN8AD2kOc/9vnQue9/TH/ZE++JJ6VxfVlgLGP9AizJjXN3FsGKy7vys5/W
         kn1T3FB3KOprazfYjFKokbne0Hp3H9HEE5oxLhvtFR2+qfxA9ksldte8hfHEF3SAl8vK
         +DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211210; x=1753816010;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNrRwgfrTvGU24RYMFx+vtCK7Bks5pGUToQFKmLgYyw=;
        b=kW5JPjMY2NfS3QjjTTIC4rA6747hEBoGvQk4YqETnZFU06W/ejrXOdIQHxXAl+fSjb
         jKE74CCkZ3stKRE5HNQL10KGmmzg1cOh3f/Q19qqGmW+tRRkljMrXaxXy2yeEm74U0/n
         PrfOJP7rlagQF3GkndtjoFIn28ibIkx0k/eCjpccI3iRwLZ1cj2IPFkUxordnmlt6bR9
         2Zx+YZ/eQMbSpLfm85oSSa2rO9tjHXXK4nQv9BorDLtR9KiA6D+Lqdl2T0aaR5qYAxUC
         mG18PQYNV/qNIMNE1dgcJy25F0y3pBt+wkMWtZ0BlX82joai3odu7+uy80VI0uvDqAzt
         pxPw==
X-Gm-Message-State: AOJu0YzsQMVNtVXh6wxJ4gMU71ZgyNNoi6zKUXtEyb767OF/EIKHH4xE
	Tbk6fyoDVo8MLQVuyZTgmxJqqH1bFv4Uyz1po8O4uiudbhnHzsN9gi1aZmZbHBfYR2hH6SdfAiO
	clRq/
X-Gm-Gg: ASbGnctqCeeXCPf8nc3MsQvaCD64WfhrBzql1PIWaNHmEzzMjM8TwJY0xcD2RU+dAkq
	PFZe6EzU03KTyrL0GnDyjvAr3EDUu3TgybSSIgo6En4qj6PRNeYxd9cPD8JKZiJWjK/LJbd22DC
	2RyJJz8ozzB9r4AzgQ3ngYbO1FilFv1y0wWdHLmZ08RHiThrifi/+trVIAgQ7ddKq0zwwefxYYx
	PXXlQwcFJkxojsN/5ZfbDxd0BFtTVi+gVk+0M/49y+2V+Y3lEGl2EqyodPHU3N31M8CSj05u/vq
	427NHYqA8HMx8YjXqh+J9YdAkOnCzbZMAO5B6Z21Fkr6ahHwmjfYg6FRgtvvURYD9tm7okiWa7q
	lpDjtSnjCOrZ/Z3u07giyS+DVxCSDrYrduBnM1RVOBZUiqs7Yc+xi/rxg+uDY+2uMMXtwSQ==
X-Google-Smtp-Source: AGHT+IEn/sE6hOTjO9tJda5VfgVU+BKH2F4YuyVHg6w0FevhwE3sckHH4CjS4w11cEPc8Wi2Y8Cjgg==
X-Received: by 2002:a05:6902:460f:b0:e81:e494:eee0 with SMTP id 3f1490d57ef6-e8dc5a25bf8mr501347276.27.1753211210167;
        Tue, 22 Jul 2025 12:06:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83? ([2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce572b2sm3372391276.38.2025.07.22.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:06:49 -0700 (PDT)
Message-ID: <a9296e54612d5f23c4e4acc671916f2f81a03e1f.camel@dubeyko.com>
Subject: Re: [PATCH v4 2/3] hfs: correct superblock flags
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 12:06:48 -0700
In-Reply-To: <20250722071347.1076367-2-frank.li@vivo.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
	 <20250722071347.1076367-2-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 01:13 -0600, Yangtao Li wrote:
> We don't support atime updates of any kind,
> because hfs actually does not have atime.
>=20
> =C2=A0=C2=A0 dirCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of creation}
> =C2=A0=C2=A0 dirMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last modification}
> =C2=A0=C2=A0 dirBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last backup}
>=20
> =C2=A0=C2=A0 filCrDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of creation}
> =C2=A0=C2=A0 filMdDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last modification}
> =C2=A0=C2=A0 filBkDat:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LongInt;=C2=A0=C2=A0=
=C2=A0 {date and time of last backup}
>=20

I have troubles with the current state of the comment. If I am trying
to find dirCrDat, dirMdDat, ..., filBkDat in HFS driver source code,
then I cannot find it. So, I prefer to cite the HFS declaration here:

/* The catalog record for a file */
struct hfs_cat_file {
<skipped>
	__be32 CrDat;			/* The creation date */
	__be32 MdDat;			/* The modified date */
	__be32 BkDat;			/* The last backup date */
<skipped>
} __packed;

/* the catalog record for a directory */
struct hfs_cat_dir {
<skipped>
	__be32 CrDat;			/* The creation date */
	__be32 MdDat;			/* The modification date */
	__be32 BkDat;			/* The last backup date */
<skipped>
} __packed;

I assume that you showing information from HFS specification. So, it
makes sense to mention that you are using the HFS specification details
and, maybe, share more detailed explanation of this. Let's combine HFS
driver declarations and citation of HFS specification.

The rest looks pretty good to me.

Thanks,
Slava.

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v4:
> -add both SB_NODIRATIME and SB_NOATIME flags
> =C2=A0fs/hfs/super.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index fe09c2093a93..417950d388b4 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -331,7 +331,7 @@ static int hfs_fill_super(struct super_block *sb,
> struct fs_context *fc)
> =C2=A0	sbi->sb =3D sb;
> =C2=A0	sb->s_op =3D &hfs_super_operations;
> =C2=A0	sb->s_xattr =3D hfs_xattr_handlers;
> -	sb->s_flags |=3D SB_NODIRATIME;
> +	sb->s_flags |=3D SB_NODIRATIME | SB_NOATIME;
> =C2=A0	mutex_init(&sbi->bitmap_lock);
> =C2=A0
> =C2=A0	res =3D hfs_mdb_get(sb);

