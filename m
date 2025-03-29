Return-Path: <linux-fsdevel+bounces-45274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE13A756C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DD016F7A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC61D63F9;
	Sat, 29 Mar 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DET6lKUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED613C0C
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743259402; cv=none; b=QwVmheS1zFPv7k0qOHLGypDNVYgPldMrykzBSxTIeizW+xKE/snR4XIZ2dGAzPiWVwh/7jkLhryQ2bSnn44Bu+MbW/IQyi12TwYCWEbckNNiAvXBsJmys+sqL9KhYcjQKYo3wlU7Ek9AqJCi5uhaBQNFJD9WLTJy0tNULexJsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743259402; c=relaxed/simple;
	bh=g9fcQXALtkcPJhuYWaR8OX4k04wU5YhtWsuDpLpp2kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzQfZknf3U3+/+UocVgBz/ScKxjxmQwYj9l7UwyYL2AwzWNlw+SD9L4B5dyECm13IQYqe2rrbuzUXpc1iQkaFIW/dEuhS1fYR05upL3hCWUBtCGy92o4xJQCLN24bSogyzQJpRYKkFASSI6H9Fu1evePlO6hMGBov0GmcWfu4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DET6lKUn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso492025066b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743259399; x=1743864199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqdXR+bIre7VIAcjzB/ah6JTgv9gzu78gaThKgbwo+U=;
        b=DET6lKUnfD11w8lWTQCYhvit2UoQ9o8mm2RURiTxJxbTLb7dKnuK2tdhTb57PBRa4Q
         A+2oWNROlflqWZNBwiHPcLknbR4IN0Rk8GvzwEZPhpMLnnG2VLvywLJtm3V2bp71dTfn
         HWPbdY3U5mnmrCch7ymNwigAUDWkzYgCuWwQNvDUtFz+z/c6XarDz/Nf+ANXoOoukOH0
         gKUcQ85y65Xg1DnLLhus6ay9juh4vkHtco2dGiHAFpVCQFI+Y30MEW1TsNnam0+6+EUI
         muwpl7JKYew6d/LOhwM5UZyFXpU4geE/bDJasabOgGe76TG/7+rxbTtdFm1TSI4DTrr9
         dqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743259399; x=1743864199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqdXR+bIre7VIAcjzB/ah6JTgv9gzu78gaThKgbwo+U=;
        b=C8teB9pc/z3hS6Kxas60fTXG1x6Pzd3br7wVZ6GYvVzcJR/OKPaQuMRfdxmdkpPGIz
         OdZgZZ4CDOS6PAgBu2r39536LM+LMUbjHEJTZYvnxLQjzL8GyXxJf23QFJOSMqeO4tvW
         wEeWV2/1FCopsRB4Qqs7YlLRanmZch1Db3/3yx2RS+CR3PLVYJsjjIsWpYQ0kC/11Z6Q
         99YfqgzHV7o0nGfAVnD4OsHCmYK9zqNuKbzQd/iTcq+Tj9TVCTzVkbjJMMyjwrxjDT2X
         8W0XwHsM2ixwnIAuP4OsX83ej88rCGgTYCZ4z/ciGHR2S4y/Hz6m5cWpJbAdH299Xi7e
         a9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUgsADQ2ssQpE4bZd1SfjEfC5GnWOoanAFTR3qB29ao2Bt7PnQnvT48nCXLMmIbZLhw5QeEfhEqQbyzgdZ3@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+i7zVzy6zF9EFSKyifuibuDp1EN3zPC4hfcVDOPsEIpsZZnC
	qifIVGP8Rsde3DVyLQdxKi33kxmBBZq81MfZo5AY+alPkCNdKTToLZ/NdACYWhGqblOTdpdUor3
	l3dcFJbKP1p1Tf9fZ8et8oE7EkRU=
X-Gm-Gg: ASbGnctJwfxlqtCmFm3td3q8loZxVF03Omlpsrh6Ri0Ic8OvhTJDCQ5qWTMjhruMC6i
	SZhOVpwVDpRcvSnTGNA60zumhLMcfDi7SRtmIgORSHYCDbVsy4lP1n4GlBTiysBWLslLF3zvsx/
	mrUkwD0HFbAvsS3GyCzYalWmtZrA==
X-Google-Smtp-Source: AGHT+IHdDZAWuqzvxuvsn7EfHXFvEwrGsLfcJVXaKMGU76vNkBr4Bc304FuSIO1luDUZbv7tVkenMe8Tc8+eYFqTp6Q=
X-Received: by 2002:a17:907:72c5:b0:ac7:19f0:aa5a with SMTP id
 a640c23a62f3a-ac738a42b63mr271528866b.27.1743259398384; Sat, 29 Mar 2025
 07:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329143312.1350603-1-amir73il@gmail.com> <20250329143312.1350603-3-amir73il@gmail.com>
In-Reply-To: <20250329143312.1350603-3-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 29 Mar 2025 15:43:06 +0100
X-Gm-Features: AQ5f1JrWjviBRl0JTnF38MSjl898UhhEZSEseRyaXZn1ky1GFapUuxglMgGlkNg
Message-ID: <CAOQ4uxhf6WPN-MCFy125Ot6fCGM4vTyh25zYC2+4srtOBA_HUg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fs: add support for custom fsx_xflags_mask
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 3:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> With getfsxattrat() syscall, filesystem may use this field to report
> its supported xflags.  Zero mask value means that supported flags are
> not advertized.
>
> With setfsxattrat() syscall, userspace may use this field to declare
> which xflags and fields are being set.  Zero mask value means that
> all known xflags and fields are being set.
>
> Programs that call getfsxattrat() to fill struct fsxattr before calling
> setfsxattrat() will not be affected by this change, but it allows
> programs that call setfsxattrat() without calling getfsxattrat() to make
> changes to some xflags and fields without knowing or changing the values
> of unrelated xflags and fields.
>
> Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@k=
ernel.org/
> Cc: Pali Roh=C3=A1r <pali@kernel.org>
> Cc: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ioctl.c               | 35 +++++++++++++++++++++++++++++------
>  include/linux/fileattr.h |  1 +
>  include/uapi/linux/fs.h  |  3 ++-
>  3 files changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index b19858db4c432..a4838b3e7de90 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -540,10 +540,13 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>
>  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fsx)
>  {
> -       __u32 mask =3D FS_XFALGS_MASK;
> +       /* Filesystem may or may not advertize supported xflags */
> +       __u32 fs_mask =3D fa->fsx_xflags_mask & FS_XFALGS_MASK;
> +       __u32 mask =3D fs_mask ?: FS_XFALGS_MASK;
>
>         memset(fsx, 0, sizeof(struct fsxattr));
>         fsx->fsx_xflags =3D fa->fsx_xflags & mask;
> +       fsx->fsx_xflags_mask =3D fs_mask;
>         fsx->fsx_extsize =3D fa->fsx_extsize;
>         fsx->fsx_nextents =3D fa->fsx_nextents;
>         fsx->fsx_projid =3D fa->fsx_projid;
> @@ -562,6 +565,8 @@ int copy_fsxattr_to_user(const struct fileattr *fa, s=
truct fsxattr __user *ufa)
>         struct fsxattr xfa;
>
>         fileattr_to_fsxattr(fa, &xfa);
> +       /* FS_IOC_FSGETXATTR ioctl does not report supported fsx_xflags_m=
ask */
> +       xfa.fsx_xflags_mask =3D 0;
>
>         if (copy_to_user(ufa, &xfa, sizeof(xfa)))
>                 return -EFAULT;
> @@ -572,16 +577,30 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
>
>  int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa)
>  {
> -       __u32 mask =3D FS_XFALGS_MASK;
> +       /* User may or may not provide custom xflags mask */
> +       __u32 mask =3D fsx->fsx_xflags_mask ?: FS_XFALGS_MASK;
>
> -       if (fsx->fsx_xflags & ~mask)
> +       if ((fsx->fsx_xflags & ~mask) || (mask & ~FS_XFALGS_MASK))
>                 return -EINVAL;
>
>         fileattr_fill_xflags(fa, fsx->fsx_xflags);
>         fa->fsx_xflags &=3D ~FS_XFLAG_RDONLY_MASK;
> -       fa->fsx_extsize =3D fsx->fsx_extsize;
> -       fa->fsx_projid =3D fsx->fsx_projid;
> -       fa->fsx_cowextsize =3D fsx->fsx_cowextsize;
> +       fa->fsx_xflags_mask =3D fsx->fsx_xflags_mask;
> +       /*
> +        * If flags mask is specified, we copy the fields value only if t=
he
> +        * relevant flag is set in the mask.
> +        */
> +       if (!mask || (mask & (FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT)))
> +               fa->fsx_extsize =3D fsx->fsx_extsize;
> +       if (!mask || (mask & FS_XFLAG_COWEXTSIZE))
> +               fa->fsx_cowextsize =3D fsx->fsx_cowextsize;
> +       /*
> +        * To save a mask flag (i.e. FS_XFLAG_PROJID), require setting va=
lues
> +        * of fsx_projid and FS_XFLAG_PROJINHERIT flag values together.
> +        * For a non-directory, FS_XFLAG_PROJINHERIT flag value should be=
 0.
> +        */
> +       if (!mask || (mask & FS_XFLAG_PROJINHERIT))
> +               fa->fsx_projid =3D fsx->fsx_projid;

Sorry, I ended up initializing the mask without a user provided mask
to FS_XFALGS_MASK, so these (!mask ||) conditions are not needed.

Thanks,
Amir.

