Return-Path: <linux-fsdevel+bounces-68540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00872C5F0D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CC5434F376
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5A2F12AB;
	Fri, 14 Nov 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="vGmXaCF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D616FC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148584; cv=none; b=oid2zk7nPR7EvnnUoZG/uYW00Rp4u7ylHjairb4F9TPI/bOOgpU82SdlCfruLn6aY4uWIzMPGQyZg35zpS5h6bXu7Qa6M7/42iaGSxZ1lyCgq07jcGBUCdvoGkObSsBIeRAjYmhLpc04ytovVn/mTeToFQWz8ETnBMyen304dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148584; c=relaxed/simple;
	bh=f8cflyWmw/b3e6CxivcXLHXGiGPDskFt5YBIt3VK2WU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPGnXPACXOOrLBgo8Y6dNKKsrqJR7bxyyDGaeCEJq1avmPEElQl2j0zq2wAN8YpJD6szxZtWES5+1BI9r2lGGFHVuKrQhqYfCVs5WRike6sgOTfsTzgo0UPbU2fza0qxtz8pY8mTxf25y/ROv9uL6eLfjwlt+TYtW4LoWwO1W/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=vGmXaCF1; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63f9beb2730so1928583d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 11:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1763148582; x=1763753382; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/dMZ10oIjCAaXGaAycFiBASRWWgnEsz1hhCZ1PlDqA=;
        b=vGmXaCF1bXdQTttlGABVJ3bkCjeMUjda0eCD8TDlpi9BcGbIoNsaAClq1riB5hLzru
         HA3fNqp+gfK6/CsnGhesqqflL88hm5j1U395IYJCXCrp6NAoaGJKmzk38sWNFCgaJ5m+
         mXfVkPz/UEu9J845Et9IIlP1NlCpUyxTniNATtEDT79Vl3Pz8n3BQooWYFOsRtih8CjQ
         69tR/8XOtAB1NBVpRPqDINarq7Z/MBkMHdW9U4LVf0YQ8eWbZAaj7iBcYqRR7qJgk5TD
         n6oCx6VUsE3jf1zSLCi3Poouw5Tb8Cou2BW3Y+0td6evbGS9we8v9vRqrx2Czi4OYxey
         J41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763148582; x=1763753382;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/dMZ10oIjCAaXGaAycFiBASRWWgnEsz1hhCZ1PlDqA=;
        b=icQIpZlaESPqsndpLak1QBDDNc8h1InINKEygHPom6JoLP0RKza6wQy8ZHazrsFKZT
         I1kMAFa5I7L/8zeWaB+W3KxtHCJALIbwobgAsk4dfyxJwFg1hu6KjrTb99TO1Y2YIU9+
         G5pzI/z+n+RZzl80Nl6QbIg4An4eQ6VvCWmcpURNpks0dfv6Fv7fDuLXDCNuJI59Cp61
         JFDFK3TXowneDlyzFRI1CEaX9+Gxz0vL69QOA2b3fz3aDTc98JQ3d3cmjLRGULG5/E0D
         gIrsqpyPdIJ6oJvU4ETKtnY2rSWT/GLsLOSYn7JISu9rHyQ55Z/zls7GBVgb6ti6iEVN
         0iJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuZ5FcD4YEtF2kgRKbGMpBMWnY9Gk6uQJjR93FYXNuDWyDwKm6X1Vb3oKaepnUZVQVfxjZGbXzGoVcGThz@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7KomfxaZhSoYbw/3fmK2xcSd3Eh9SAHm7yS0OjEo0TAdRgPR
	lulfCz4SgYxCK5+JMzLL/oMjkIdJeFDq8SJB6rNgVsPQbMfJU/XqyDEyK5Smme7JrWk=
X-Gm-Gg: ASbGncvpBWsEBBjjkkA0StQouEAm0JXQxltkBUefigKPT9jGV/XH8/OXTwjLdUoxIRB
	PjjYGJ2AbXIagSoHkdp7nNpgfp5wyGhcC+LwUgDY/S2/VQURId3mA9b+P9PCqJjk2fvLKQIJ3hD
	21CkkF4dSb2Lu+RnifBDDAhXtXkbl6r8BXiK4LsUCbvtxrr65yzraWvcI6ezuY5aLtsaKq8JBMP
	NrXJodwcdFhdvKvJ5M20NDmJASfG3tagNPKfGozD+HCSGB3OEkfMX+820hpccIk79UVf549WcGF
	TYPnjV6vDPd54nA2rghZj87mDGzWWcy/Co8B0QFr2AWLOujJ54lgNc88ry+hyoxWbduz5zirk1S
	6a7l6jE/k97IC4oUYgkXFac+dUgAT+kWNceol+fxZpnca3IDbxts5TqODszyWXFVyIPBoyrlHeO
	1fZwdo34b5+z+hspS/hvQngg2uzQKOxsJq5MbWuYBISGjmgQ==
X-Google-Smtp-Source: AGHT+IH3XdunMYRTGfsWI8AJVDJFxCYnvsy4KAe+RAZ7LPmplVCONqCDB6PgWvgDFyOtmTmHB7HhXw==
X-Received: by 2002:a05:690e:1552:20b0:640:d303:3523 with SMTP id 956f58d0204a3-641e7644822mr3099851d50.50.1763148581648;
        Fri, 14 Nov 2025 11:29:41 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:5f14:f30:8b99:b6dc? ([2600:1700:6476:1430:5f14:f30:8b99:b6dc])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410ea03115sm2030380d50.7.2025.11.14.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:29:40 -0800 (PST)
Message-ID: <a4fee92f0ae18fd66d32c2ffc6cf731d1a4d498d.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: Verify inode mode when loading from disk
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>,
 linux-fsdevel	 <linux-fsdevel@vger.kernel.org>
Date: Fri, 14 Nov 2025 11:29:39 -0800
In-Reply-To: <125c234e-9ffb-4372-bcc4-3a1fbc93825b@I-love.SAKURA.ne.jp>
References: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
	 <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
	 <d089dcbd-0db2-48a1-86b0-0df3589de9cc@I-love.SAKURA.ne.jp>
	 <125c234e-9ffb-4372-bcc4-3a1fbc93825b@I-love.SAKURA.ne.jp>
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

On Sat, 2025-11-15 at 00:35 +0900, Tetsuo Handa wrote:
> Ping?
>=20

You checks the inode->i_mode in the patch. And logical place for this
check is hfsplus_get_perms() method [1] because all mode checks are
made there before assigning to inode->i_mode. So, you simply need to
add this check there and to check the return value of
hfsplus_get_perms() in hfsplus_cat_read_inode().

static void hfsplus_get_perms(struct inode *inode,
		struct hfsplus_perm *perms, int dir)
{
	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(inode->i_sb);
	u16 mode;

	mode =3D be16_to_cpu(perms->mode);

<skipped>

	if (dir) {
		mode =3D mode ? (mode & S_IALLUGO) : (S_IRWXUGO & ~(sbi-
>umask));
		mode |=3D S_IFDIR;
	} else if (!mode)
		mode =3D S_IFREG | ((S_IRUGO|S_IWUGO) & ~(sbi->umask));

<-- You simply can implement your check here.

	inode->i_mode =3D mode;

<skipped>
}

It simple modification from my point of view. And I don't quite follow
to your difficulties to move your check into hfsplus_get_perms().

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v6.18-rc5/source/fs/hfsplus/inode.c#L183

> Now that BFS got
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.fixes&id=3D34ab4c75588c07cca12884f2bf6b0347c7a13872
> =C2=A0,
> HFS+ became the last filesystem that has not come to an answer.
>=20
> On 2025/10/08 20:21, Tetsuo Handa wrote:
> > > As far as I can see, we operate by inode->i_mode here. But if
> > > inode
> > > mode has been corrupted on disk, then we assigned wrong value
> > > before.
> > > And HFS+ has hfsplus_get_perms() method that assigns perms->mode
> > > to
> > > inode->i_mode. So, I think we need to rework hfsplus_get_perms()
> > > for
> > > checking the correctness of inode mode before assigning it to
> > > inode->
> > > i_mode.
> >=20
> > Then, can you give us an authoritative explanation, with historical
> > part
> > fully understood?

