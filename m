Return-Path: <linux-fsdevel+bounces-68804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A5C667BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0A9CE2927E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538473358DA;
	Mon, 17 Nov 2025 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="x1M+qreF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85E322DA8
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419949; cv=none; b=YnAnqh2OU5dAnO0XHa6DmEn6Xa9UruXQsEeaMdS3p2bdWIALn4MrqGse120TLf7L362Eu3BnroPVExGGKiHV79x+BSyqLmpj4yjiMkpbRc7PnH7XyDU8EV8ilBIYgk93lRBtx+AnXrux0TIesrBsrwnfyF4JPzUS3Rqnq2AYtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419949; c=relaxed/simple;
	bh=135PLNtOebGToyZ+UUh11Kzmk4R3mcVNt8IOmejpYrM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NnaKj2exKroAooQzob2Ik34GnPk7flo1/sMRUHr/gbZuzfaJzXaoCzaQOZDPwGdsn9LrKPRO8QEjqAqK3jne9bby5YQoi0PznW06H3fL2lUdmxN9llF6mHx2vT/h2GhKsu/4V8yp/bPiDZSiUsv0XMsiUCK3TVw+DeAOCTKwU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=x1M+qreF; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640d43060d2so4391004d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 14:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1763419946; x=1764024746; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an916DQIHDk3W9fuc3arQ2uoWAfhqH7iYVTZG6zyEgI=;
        b=x1M+qreFPNfZuuCCqMk/BmQA/+hXcx/uMFka2Z6lkRC75bY25zXXdwQ8k03kweFZFb
         +1SYGrjWoZKHMT3KmMKnoxfY6S1TFWHLW333QIPZHeIi12QArc4Ce6iXKqz0rN+eooSY
         2huh6l0CnkjCt0kbZE0Z83NEsNTE9g/rsP7BhnOeAzXvcjCYJzDx6vEoyopepbbYyskW
         rjNx7doUY8DwdBdH2Kt/CEcc6uL8RBUCz2OZ+zDfbiFIAGbubwtGFwEr2pnzYAbeIKTK
         n7VAhNyRcpLBOuJupBZGBWfDcRzzu17OK5uX8iNU+lwEWuAj6JaKGhX+UzhmVqQrC42e
         Tx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419946; x=1764024746;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=an916DQIHDk3W9fuc3arQ2uoWAfhqH7iYVTZG6zyEgI=;
        b=wOYb1I8JE5V3aexymVv6k/M0TICgeL+NIK/tT3eP3+wB6O699fV5B3EGF0SFOKLREl
         x/M2UdfqXPzCMoNIAh6TYlCzColOxwaM6k0F832Cr/kmeMUv+AZZRWhi5lpQFWOYeCQ5
         u7mD1GpUHRh4iy0FNbRkv5bKAa0AYdj0Lys/tT1037TS4WYty9ckWvHwyY5xFsvuSSyF
         2MvfRx0ej1RosMdwdOX6g22HEAFWwYnTzpmH4Z1j7ltveLuP2Y8o7VPvSts88fHp5uxB
         ETrLz3MyXJ/bsV3Gk1WNutV+qgSSCSbgcDtVhm7a4jn860q1503M83mwnd2bPQGQAMWE
         9Lpg==
X-Forwarded-Encrypted: i=1; AJvYcCUT0dahcvv0ipnMkw1Ncp17Q9M+BSF42A83Zg2GoRb0pRVmAMqiy8kXm02rY8EWgXl11ea+tyaTH2QZ4kda@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAepRS1PfIBZZFult8JZmQ+n6J6owbSlfhTOJKhzgUnoyNkkn
	YUqOlMViYsfcOM+WZ4MUxVmKse1/chottCA21Sd5wJ76TY5JbRfnp2L1I/Z1ozI5ebVEybJMNU4
	IB10l
X-Gm-Gg: ASbGncuepj0N47krMjiztenlc2+lYYjzYGOFeS0XQIzXOCjoID/0k10HGcRekE/wixh
	TiY48RT2wymRx+or7Xt+zV62Wt42XGbBVHs4ZvKoswLB6ws5kdmGGFvWcKUPWdtZ79tagFUWGRD
	XGGNfUNQ4f7BqxGTYZ+DmWg70u+2v5srQ8kcUHNEQtyVDbIjO96/sW72DDp5+OAMkjrP3dD1BQN
	14CoJ2OK9OmI2wcZ3nNxxq9cTitSZF6roed/jvebYsMYkzkYK5YsPElPbxoMszcZ15gPCr3jND5
	S87EBef8wqP2WxQ9b9/yBubMMLIgbEJon1lAktOPedFU0iXLqff8ChK/VudOs7O1J9DQQLoGuVe
	UacvV5vF42W5WdziGAHpweSukVku2HzmEfdmB4UCJOV65k0+x9wtK1aF5TKF6eAB4mrzbmSOBnD
	lEqFgRnjpIwNUpRSsPKthxhpDDrpNpSo9n710bUlK3NFAQDFSv
X-Google-Smtp-Source: AGHT+IEQNTUK3R4VwWwtkKzeabEK4XxlQKV2RlQTjRZWiFsaN/YzqzNO3JxCUEfU4r5kpfp/XWabgw==
X-Received: by 2002:a53:c04b:0:10b0:641:f5bc:6971 with SMTP id 956f58d0204a3-641f5bc7387mr6977633d50.77.1763419945916;
        Mon, 17 Nov 2025 14:52:25 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:73e9:650f:9bb3:4bf3? ([2600:1700:6476:1430:73e9:650f:9bb3:4bf3])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e9e9182sm5219161d50.3.2025.11.17.14.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 14:52:25 -0800 (PST)
Message-ID: <eaf1c94b70ba7fdc516c5e10bb821f3e8b9aaa9d.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: Verify inode mode when loading from disk
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>,
 linux-fsdevel	 <linux-fsdevel@vger.kernel.org>
Date: Mon, 17 Nov 2025 14:52:24 -0800
In-Reply-To: <04ded9f9-73fb-496c-bfa5-89c4f5d1d7bb@I-love.SAKURA.ne.jp>
References: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
	 <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
	 <d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp>
	 <125c234e-9ffb-4372-bcc4-3a1fbc93825b@I-love.SAKURA.ne.jp>
	 <a4fee92f0ae18fd66d32c2ffc6cf731d1a4d498d.camel@dubeyko.com>
	 <04ded9f9-73fb-496c-bfa5-89c4f5d1d7bb@I-love.SAKURA.ne.jp>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAabQoVmlhY2hlc2xhdiBEdWJleWtvIDx2ZHViZXlr
 b0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBFXDC2tnzsoLQtrbBDlc2cLfhEB1BQJoVemuAhsBBQkDw
 mcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDlc2cLfhEB1GRwP/1scX5HO9Sk7dRicLD/fxo
 ipwEs+UbeA0/TM8OQfdRI4C/tFBYbQCR7lD05dfq8VsYLEyrgeLqP/iRhabLky8LTaEdwoAqPDc/O
 9HRffx/faJZqkKc1dZryjqS6b8NExhKOVWmDqN357+Cl/H4hT9wnvjCj1YEqXIxSd/2Pc8+yw/KRC
 AP7jtRzXHcc/49Lpz/NU5irScusxy2GLKa5o/13jFK3F1fWX1wsOJF8NlTx3rLtBy4GWHITwkBmu8
 zI4qcJGp7eudI0l4xmIKKQWanEhVdzBm5UnfyLIa7gQ2T48UbxJlWnMhLxMPrxgtC4Kos1G3zovEy
 Ep+fJN7D1pwN9aR36jVKvRsX7V4leIDWGzCdfw1FGWkMUfrRwgIl6i3wgqcCP6r9YSWVQYXdmwdMu
 1RFLC44iF9340S0hw9+30yGP8TWwd1mm8V/+zsdDAFAoAwisi5QLLkQnEsJSgLzJ9daAsE8KjMthv
 hUWHdpiUSjyCpigT+KPl9YunZhyrC1jZXERCDPCQVYgaPt+Xbhdjcem/ykv8UVIDAGVXjuk4OW8la
 nf8SP+uxkTTDKcPHOa5rYRaeNj7T/NClRSd4z6aV3F6pKEJnEGvv/DFMXtSHlbylhyiGKN2Amd0b4
 9jg+DW85oNN7q2UYzYuPwkHsFFq5iyF1QggiwYYTpoVXsw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-15 at 18:18 +0900, Tetsuo Handa wrote:
> syzbot is reporting that S_IFMT bits of inode->i_mode can become
> bogus when
> the S_IFMT bits of the 16bits "mode" field loaded from disk are
> corrupted.
>=20
> According to [1], the permissions field was treated as reserved in
> Mac OS
> 8 and 9. According to [2], the reserved field was explicitly
> initialized
> with 0, and that field must remain 0 as long as reserved. Therefore,
> when
> the "mode" field is not 0 (i.e. no longer reserved), the file must be
> S_IFDIR if dir =3D=3D 1, and the file must be one of
> S_IFREG/S_IFLNK/S_IFCHR/
> S_IFBLK/S_IFIFO/S_IFSOCK if dir =3D=3D 0.
>=20
> Reported-by: syzbot
> <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da440ed0d
> Link:
> https://developer.apple.com/library/archive/technotes/tn/tn1150.html#HFSP=
lusPermissions
> =C2=A0[1]
> Link:
> https://developer.apple.com/library/archive/technotes/tn/tn1150.html#Rese=
rvedAndPadFields
> =C2=A0[2]
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> =C2=A0fs/hfsplus/inode.c | 32 ++++++++++++++++++++++++++++----
> =C2=A01 file changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index b51a411ecd23..e290e417ed3a 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -180,13 +180,29 @@ const struct dentry_operations
> hfsplus_dentry_operations =3D {
> =C2=A0	.d_compare=C2=A0=C2=A0=C2=A0 =3D hfsplus_compare_dentry,
> =C2=A0};
> =C2=A0
> -static void hfsplus_get_perms(struct inode *inode,
> -		struct hfsplus_perm *perms, int dir)
> +static int hfsplus_get_perms(struct inode *inode,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct hfsplus_perm *perms, int dir)
> =C2=A0{
> =C2=A0	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(inode->i_sb);
> =C2=A0	u16 mode;
> =C2=A0
> =C2=A0	mode =3D be16_to_cpu(perms->mode);
> +	if (dir) {
> +		if (mode && !S_ISDIR(mode))
> +			goto bad_type;
> +	} else if (mode) {
> +		switch (mode & S_IFMT) {
> +		case S_IFREG:
> +		case S_IFLNK:
> +		case S_IFCHR:
> +		case S_IFBLK:
> +		case S_IFIFO:
> +		case S_IFSOCK:
> +			break;
> +		default:
> +			goto bad_type;
> +		}
> +	}
> =C2=A0
> =C2=A0	i_uid_write(inode, be32_to_cpu(perms->owner));
> =C2=A0	if ((test_bit(HFSPLUS_SB_UID, &sbi->flags)) ||
> (!i_uid_read(inode) && !mode))
> @@ -212,6 +228,10 @@ static void hfsplus_get_perms(struct inode
> *inode,
> =C2=A0		inode->i_flags |=3D S_APPEND;
> =C2=A0	else
> =C2=A0		inode->i_flags &=3D ~S_APPEND;
> +	return 0;
> +bad_type:
> +	pr_err("invalid file type 0%04o for inode %lu\n", mode,
> inode->i_ino);
> +	return -EIO;
> =C2=A0}
> =C2=A0
> =C2=A0static int hfsplus_file_open(struct inode *inode, struct file *file=
)
> @@ -516,7 +536,9 @@ int hfsplus_cat_read_inode(struct inode *inode,
> struct hfs_find_data *fd)
> =C2=A0		}
> =C2=A0		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
> =C2=A0					sizeof(struct
> hfsplus_cat_folder));
> -		hfsplus_get_perms(inode, &folder->permissions, 1);
> +		res =3D hfsplus_get_perms(inode, &folder->permissions,
> 1);
> +		if (res)
> +			goto out;
> =C2=A0		set_nlink(inode, 1);
> =C2=A0		inode->i_size =3D 2 + be32_to_cpu(folder->valence);
> =C2=A0		inode_set_atime_to_ts(inode, hfsp_mt2ut(folder-
> >access_date));
> @@ -545,7 +567,9 @@ int hfsplus_cat_read_inode(struct inode *inode,
> struct hfs_find_data *fd)
> =C2=A0
> =C2=A0		hfsplus_inode_read_fork(inode,
> HFSPLUS_IS_RSRC(inode) ?
> =C2=A0					&file->rsrc_fork : &file-
> >data_fork);
> -		hfsplus_get_perms(inode, &file->permissions, 0);
> +		res =3D hfsplus_get_perms(inode, &file->permissions,
> 0);
> +		if (res)
> +			goto out;
> =C2=A0		set_nlink(inode, 1);
> =C2=A0		if (S_ISREG(inode->i_mode)) {
> =C2=A0			if (file->permissions.dev)

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


