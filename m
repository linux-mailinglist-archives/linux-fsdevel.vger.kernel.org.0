Return-Path: <linux-fsdevel+bounces-38249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE0B9FE0D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 00:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA041617B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582019ADBA;
	Sun, 29 Dec 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN2hvlZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D38F4A;
	Sun, 29 Dec 2024 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735513548; cv=none; b=eXb/Yt7pFmHK4YHzLgNb/m+YYbzLxA8xH3O4Gu+55nQMpzpJNkLFNutaadMwFwp7jf2ODljmie+poxORvyg1TTdn/1OTuw+GyW2bK5H3Pp2d+vWcU/2pphcsQL6PpcmM+htMEdmpuAx54in3jHfzKLPHkopUyNcPgUM7c9bh+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735513548; c=relaxed/simple;
	bh=3O/1n3JYDGmG/HOS4ufGiJkIai0jxCMwYzXAZmovrNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWzgflj9uMHTq2c2nOPyR+UzkCTdGIOGJffuqV7QcwMXQuos/cKj7hdVm8K6H/oTiM3Cm7Ryh7K6mM3gPYoaemF7RX/4N78j7dYpfnSd8TvY7Jt77eHAr0Agv6zbz1CcAzkYtU7rl+zC0G9e7yqO7iilxyfE7f5mCmzzL9ZxIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN2hvlZC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3c47434eso9375719e87.3;
        Sun, 29 Dec 2024 15:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735513545; x=1736118345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg0gBOstbiPfT/5CIxqA5lZAaBxe9roGqwYSHcuJUK4=;
        b=KN2hvlZC2R8GsA8xFVDA9iyv91GdZteQL0HLSS5vH3waADH68FbAqLEWkodLRsCnyl
         C0StCmwAxzDzEF2VG91s9dAt57GBDLXu19B+b9ElReR7nkhrl7lnQhN7AHLM7aSxzZDQ
         rYhKh8yQA2SX/7zXerbP46eK4uEAfWkwYS4uZVF1LeXnv7g1uPLLRurnjuJz/Ts/nEH+
         3KVWER7tYyEXGja4c1WVoFYpMzJoeHPe4FsUV1U81OKGgUGP8+eg+LZEbE51ysZcI37M
         7kw7fChYavBz5WwSxKpN346ue7XKKz5P9DGqz3XPQDtrTaOc9BxnPwRp+gxVUgEP6IFP
         +etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735513545; x=1736118345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg0gBOstbiPfT/5CIxqA5lZAaBxe9roGqwYSHcuJUK4=;
        b=DEc80AxXkVmn5xtDNv5G86L1fVNZKNdQTsmtOUkMbYIYKzjID4gQ2LJ9CEPLBu/9sy
         8kyxjis32Ms0zqPK16cqYNzU6qA8ST2U0FitPOk0IVa4HDQk/akQB2MNrhBoB4AS3k/r
         YwfoOdcGPYLchuaQ6RygrWsIX/J9PSn2KzGcRTCu7pL9P3IVWameVf3R2pIc7NccCn2a
         ZjzN/LS0PbC2BNS7ijU1fh6ybT5Iwjho/mzkKafqL+uYQTR3URrc2q7tBgzbKNC2RHbT
         VeDIIY7JkD5Wi0QXx60BbKsmCX9iD3g7ty8iOU4/fNfyg3l+lCuhV1iNrZqNQqjRgjeh
         ZYgg==
X-Forwarded-Encrypted: i=1; AJvYcCUxMCuSMQ7/QvQ21M+37eHNfdHoL/wOfIAd++JLmD8l8zIhF+RgXxnNBhGf63oT3uIkDpey0KJQOBQB31QY@vger.kernel.org, AJvYcCVLUxIwhbvb/LVsJpHgyU7x1J1XZrEBPzkrFNQXPrxEEE6kuRi88u84dBvIQJAheQkrzIIOhvQDm+2EHhY/@vger.kernel.org, AJvYcCVM+OKfKwdWJGrIQcGOrBoDNZGFQNd5q24szOS0XRg2CPhVRgL3q35azmoVAlA1JJ7oyXnJXkGI@vger.kernel.org, AJvYcCWBUpp8cpMi8v9F5qFmAEYvrNd66L6WWAtnlAsNo/Oubmt0NdztpBIvivCfzGAuRwJxOXBpq9PsE8Gg@vger.kernel.org, AJvYcCWkRcV0OqbrR7zpFZLKMvVDIRM5xRo8cxCkr/wo0KjfSVLHYVc/+1/qpNfeiFHepV2wNpBaI6mh4jL5k41EJEsmdXxzeHoZ@vger.kernel.org, AJvYcCXCv4YlpjqU9lHFG3rDL/HSVMLyvipHutr03CZ31tam9b7WhaSL+ObeDGPyiFQXe9Sl+yVTWIjKFhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBk1fHzChIdKC2KIf9l4730zbuXu8rSZnctWcqHrVQkv+ihjo
	T3Jd8ade2zH3kDlzLhUpbdxkxApaNHrcKkAyvzKZ+4CKTes6YuGyoW8DQHople2YS9SHpPwedaM
	QKf0KvKx2xX/MrE1Ed3os627ajw==
X-Gm-Gg: ASbGncsZJADHnDrF6ZvLN/OZZVbXzv9E/TaY/FWTgvI06GxRmYdnI7g+llC3j5Ml+XO
	dihgVQoiewFG3jqmCQqcvmdMqhO9e/DcpausjGw==
X-Google-Smtp-Source: AGHT+IEqt5j8jsdpOLwCDaRHScqgd6KbKAOWycEuMfIL3JIo/6bnO8p8bFE/88tfVUmxNoyeU1ENzzZ00bSHOpuSCp4=
X-Received: by 2002:a05:6512:e89:b0:540:2201:57d2 with SMTP id
 2adb3069b0e04-5422956f2c8mr12005165e87.49.1735513544454; Sun, 29 Dec 2024
 15:05:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228145746.2783627-1-yukaixiong@huawei.com> <20241228145746.2783627-14-yukaixiong@huawei.com>
In-Reply-To: <20241228145746.2783627-14-yukaixiong@huawei.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 29 Dec 2024 18:05:32 -0500
Message-ID: <CAMzpN2hf-CFpO6x58aDK_FX_6C2MBKh1g7PdV4Y=ypaeUNVfRw@mail.gmail.com>
Subject: Re: [PATCH v4 -next 13/15] x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kees@kernel.org, j.granados@samsung.com, 
	willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, 
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com, 
	souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com, 
	pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, yang@os.amperecomputing.com, zev@bewilderbeest.net, 
	serge@hallyn.com, vegard.nossum@oracle.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 10:17=E2=80=AFAM Kaixiong Yu <yukaixiong@huawei.com=
> wrote:
>
> When CONFIG_X86_32 is defined and CONFIG_UML is not defined,
> vdso_enabled belongs to arch/x86/entry/vdso/vdso32-setup.c.
> So, move it into its own file.
>
> Before this patch, vdso_enabled was allowed to be set to
> a value exceeding 1 on x86_32 architecture. After this patch is
> applied, vdso_enabled is not permitted to set the value more than 1.
> It does not matter, because according to the function load_vdso32(),
> only vdso_enabled is set to 1, VDSO would be enabled. Other values
> all mean "disabled". The same limitation could be seen in the
> function vdso32_setup().
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v4:
>  - const qualify struct ctl_table vdso_table
> ---
> ---
>  arch/x86/entry/vdso/vdso32-setup.c | 16 +++++++++++-----
>  kernel/sysctl.c                    |  8 +-------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vds=
o32-setup.c
> index 76e4e74f35b5..f71625f99bf9 100644
> --- a/arch/x86/entry/vdso/vdso32-setup.c
> +++ b/arch/x86/entry/vdso/vdso32-setup.c
> @@ -51,15 +51,17 @@ __setup("vdso32=3D", vdso32_setup);
>  __setup_param("vdso=3D", vdso_setup, vdso32_setup, 0);
>  #endif
>
> -#ifdef CONFIG_X86_64
>
>  #ifdef CONFIG_SYSCTL
> -/* Register vsyscall32 into the ABI table */
>  #include <linux/sysctl.h>
>
> -static struct ctl_table abi_table2[] =3D {
> +static const struct ctl_table vdso_table[] =3D {
>         {
> +#ifdef CONFIG_X86_64
>                 .procname       =3D "vsyscall32",
> +#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))

vdso32-setup,.c is not used when building UML, so this can be reduced
to "#else".

> +               .procname       =3D "vdso_enabled",
> +#endif
>                 .data           =3D &vdso32_enabled,
>                 .maxlen         =3D sizeof(int),
>                 .mode           =3D 0644,
> @@ -71,10 +73,14 @@ static struct ctl_table abi_table2[] =3D {
>
>  static __init int ia32_binfmt_init(void)
>  {
> -       register_sysctl("abi", abi_table2);
> +#ifdef CONFIG_X86_64
> +       /* Register vsyscall32 into the ABI table */
> +       register_sysctl("abi", vdso_table);
> +#elif (defined(CONFIG_X86_32) && !defined(CONFIG_UML))

Same as above.



> +       register_sysctl_init("vm", vdso_table);
> +#endif
>         return 0;
>  }
>  __initcall(ia32_binfmt_init);
>  #endif /* CONFIG_SYSCTL */
>
> -#endif /* CONFIG_X86_64 */


Brian Gerst

