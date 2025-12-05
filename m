Return-Path: <linux-fsdevel+bounces-70911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD550CA9318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C44923018413
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48DF2EC55C;
	Fri,  5 Dec 2025 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="UkKWJPfI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637F2DEA8C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964971; cv=none; b=CQFJrgrsbY9ffmIGGQjUmY75Z9wKHt5ErGdZDK4MRo6YYsW8DMfnZifXMddbPQMwFUzcD66mYr69h6+Ol5b/c3pNtbowWFXKt5DxnHsUc3Zx7+GJoALSnaEsGmGXnZ/fctY/FVp9Yzk6dFEvdNW9LS55CQwGLDqGvCz6lFuE0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964971; c=relaxed/simple;
	bh=qcydgZj4b8V9jEa7jueYVrct7nrSjCV4PEqRDHFNwEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFA6R7R6T3EQeMcWjiQaAkMmCeOlJwsrTycUf3kyFdhMfffaEe1zzvRHY5yzVLaTtqK9J+YJ+63t8GzUOcIt6j4gHdjDkq6ZGgWm93GlEoQXMeUSsqUPb8fIf/10C6ibVPkVB6AnlZCA/0PVHZ6vQ/v+HV8/wkRILKmhs9aPrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=UkKWJPfI; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640d790d444so2190517d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1764964963; x=1765569763; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSyeT6/GbNhN7xVKemsLrw+Uoi9s6FunOgP5u56JtJU=;
        b=UkKWJPfI+DmlnI6el6CmHvgMN4fxLSWI4VUuNRNW/RDirjHIPJVof0GUL3C8iYmxkh
         /C7Ps9IPMa/1DlhQtu86A7ZJmuZf1GhIUEypAjhTQsBjwAQwW1PntgrMEQbhpoENXeHN
         VTMHL73sR4BzJ03fUctEaRBw8HpQsFSakLJmMqbET6EEWFCNKYTtF6Kml2lxKgFsmg/k
         XRVAnOpVr7dF56zaPLzuTizGEbFaa/bVdbESmCraoSJO5Hs36gaih7wghzvg3iFd0vom
         E0vZhzks6ZtV5OwmoK0JAYnv6MGNrQ9blyJP13I3S5+rS76bTDXXcLDlD6rdY4yzDxlJ
         1qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764964963; x=1765569763;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSyeT6/GbNhN7xVKemsLrw+Uoi9s6FunOgP5u56JtJU=;
        b=Jdsnyo1TFiEfokHIk+5kofub7jxKNeUfj124aaGAVrmsFocet994FGh936Nj+cPoHX
         eG73HCGeIanLfPg+B57V2cvvDUuInL7SkmlUVIQexY5KNOxb9orxcdxIB6LV/DGv+a3c
         EXYct4thDE1we6oZsJqb/4idD9181f9kKBVm8eWUadHoclDPvmBHS8mcKttyUtroIKO/
         q2e82FcC4KErFndqJ5iAYyaCe0A6CNurxboH5UY3U2+K/MLUGdIH9n6fViohALDqXN6a
         6jEXRUM9r70QcmEgL0g9rnEvcxR4nuhg7QicFrwswp4u1Q6uXIAR6eXu19faHTUqf7fB
         AZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVIxX1HLb9uvxIgmpORiguy6D1Irv8V6R/iSydik27pnbLCp8kpnQW4/EN2j/fQsi367Fs5VnU4u23s7F9@vger.kernel.org
X-Gm-Message-State: AOJu0YxIuVzHJrtSLy0pySLLp8IvcyFs//2YcVX21AjPdDHBh9S20jAO
	+E3UEo0SFzND2VZArms9yPTnfSvi8JK9skqadgkWdzMBaMOHDWOfycZxeWcziCTtOiU=
X-Gm-Gg: ASbGnctEQamXDamiK51yswGYXDnPMLGRMkA2hKM+TWBZLMvmH6ceZygL6k2q/FiDfdT
	MDYVdswSPW2ziY67fu1YTC9pXQulPi6ixPlgujOWeiuoab+TrzbKRKUHWUUa6acHBxy8Aj6r68c
	RxcKfZaJ+cSjfqe5Ve2fZnm5+YqRdefWYr3RjJqb/xkfXzE9/zFd/rtsIccVjK+fSC3fKRKu/q+
	yIjLvkA+cwN8VdrS+VZM1KQGEGNxczK/kkthtGrzjpAhirrAK9EDlIR1jZgzQGxKvHUuyl3vYy7
	25LgHv7MX4ffES2PfYhkUVCw9yKdXVCpNG+0dfdHJwBzI2mJ8aSpIUTOFPWICrz7175htHqWHwD
	bAVqa2NDqeHNK9KPW3ziCZd88DeYBVBLbaBJMG1vm/uYyHN5oFtrN1aBXcROeJ7E2IXTRDThp+G
	IFiFV/EVUILNDpTa593iIC198=
X-Google-Smtp-Source: AGHT+IHkQFoyYTI/CgnVuJTvIWVlarpWNlSzy+9Hi0lj7OunJvwiUGM0HeXibuz7YuHAqGQbNQdSkw==
X-Received: by 2002:a05:690e:158e:10b0:63f:a89c:46f9 with SMTP id 956f58d0204a3-6444e7a7360mr114496d50.40.1764964963024;
        Fri, 05 Dec 2025 12:02:43 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:828a:4678:b49d:bcef])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f2c404asm2147958d50.11.2025.12.05.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 12:02:42 -0800 (PST)
Message-ID: <a325f0d3778f3d7c0974d558587cddbc0077072c.camel@dubeyko.com>
Subject: Re: [PATCH v1] hfsplus: fix memory leak on mount failure
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Fri, 05 Dec 2025 12:02:40 -0800
In-Reply-To: <20251206000902.71178-1-swarajgaikwad1925@gmail.com>
References: <69326fcf.a70a0220.d98e3.01e5.GAE@google.com>
	 <20251206000902.71178-1-swarajgaikwad1925@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-06 at 00:09 +0000, Swaraj Gaikwad wrote:
> syzbot reported a memory leak in the hfsplus mount path when the
> mount
> fails, which occurs because the fs_context API moves ownership of
> fc->s_fs_info to sb->s_fs_info early in sget_fc().
>=20
> When filesystems are mounted using the new API, the VFS (specifically
> sget_fc) transfers the ownership of the context's s_fs_info (the
> 'sbi'
> struct) to the superblock (sb->s_fs_info) and clears the context
> pointer.
>=20
> If the mount fails after this transfer the VFS calls
> deactivate_locked_super, which invokes the filesystem's kill_sb
> callback. Previously, hfsplus used the generic kill_block_super,
> which
> does not free sb->s_fs_info, resulting in the 'sbi' structure and its
> loaded NLS tables being leaked.
>=20
> Fix this by implementing a filesystem-specific ->kill_sb() that frees
> sb->s_fs_info and its NLS resources before calling
> kill_block_super().
> Also remove the early kfree(sbi) from hfsplus_fill_super()=E2=80=99s erro=
r
> path,
> because the superblock unconditionally owns s_fs_info when using the
> fs_context API.
>=20
> Testing:
> This fix was verified by building the kernel with the .config
> provided
> by the syzkaller reporter and running the reproducer. The reproducer
> now runs successfully without triggering any memory leaks or kernel
> errors.
>=20
> #syz test:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> e69c7c175115
>=20
> Reported-by: syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
> Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
> ---
> =C2=A0fs/hfsplus/super.c | 16 ++++++++++++++--
> =C2=A01 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 16bc4abc67e0..fa7420d08da1 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -629,7 +629,6 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0out_unload_nls:
> =C2=A0	unload_nls(sbi->nls);
> =C2=A0	unload_nls(nls);
> -	kfree(sbi);
> =C2=A0	return err;
> =C2=A0}
>=20
> @@ -688,10 +687,23 @@ static int hfsplus_init_fs_context(struct
> fs_context *fc)
> =C2=A0	return 0;
> =C2=A0}
>=20
> +static void hfsplus_kill_sb(struct super_block *sb)
> +{
> +=C2=A0=C2=A0=C2=A0 struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +
> +=C2=A0=C2=A0=C2=A0 if (sbi) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unload_nls(sbi->nls);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(sbi);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb->s_fs_info =3D NULL;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 kill_block_super(sb);
> +}
> +
> =C2=A0static struct file_system_type hfsplus_fs_type =3D {
> =C2=A0	.owner		=3D THIS_MODULE,
> =C2=A0	.name		=3D "hfsplus",
> -	.kill_sb	=3D kill_block_super,
> +	.kill_sb	=3D hfsplus_kill_sb,
> =C2=A0	.fs_flags	=3D FS_REQUIRES_DEV,
> =C2=A0	.init_fs_context =3D hfsplus_init_fs_context,
> =C2=A0};
>=20
> base-commit: 6bda50f4333fa61c07f04f790fdd4e2c9f4ca610
> --
> 2.52.0

Sorry, but this patch [1] already fixes the issue.

Thanks,
Slava.

[1]
https://lore.kernel.org/linux-fsdevel/20251201222843.82310-3-mehdi.benhadjk=
helifa@gmail.com/


