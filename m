Return-Path: <linux-fsdevel+bounces-49327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A0ABB487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 07:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A8218929AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 05:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D41FF1D8;
	Mon, 19 May 2025 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iaQAU/ef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72A1E8322;
	Mon, 19 May 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634308; cv=none; b=Bg4it2fc5rcUtfDV5FXdSJY5jzzoXVNrnBTBn82SKWbqA+w4klFEqtqPip3foQqf/43QjZNHD5l6M7w0Vdt3dc/mlSwGU1nj5cJqOpBGAUK4AbSs+tG1SdMvgcpP0nKTlOXvdZHroAWN4L65U2K741SlIQjRzsb3p/U/QqkMEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634308; c=relaxed/simple;
	bh=6CcJLoiNBie8gIMenSv7I45HQX4gsy7svoa1ApM84V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFvBacTIN+h3D5RaUAoJ/1Js5cFjZ9lou0zpzoynecfemZ7Ix721/OKPZBRR/MsdvPXxWXNVbu55J4le8QeYecCLYQ6JYpulEMtBnFUY4og0dR7lp+3Ay1PiS9e04ymDafzwpABWPlJ2ZK1RYMelhNlFUOLVtIN2mah9dC6IbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iaQAU/ef; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1747634290;
	bh=QbhOvH42YA0CW+6CFUcthXVUKo1LRCaG/L7a3rPi0uo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=iaQAU/efS5amPIavReKNChk6h4oGmVS7tTKMoU7ihs1GTOZtvWbI1oO3V9//KBna1
	 VtltQd1UlGyddoWAdLtk5VBvUGmUqdBAyP9vps4gDmfI2bqRkd03PGVGcKa2gnmVRn
	 J8BlcniExCu0I3co4U6b6edjEvaMLID0tYZrAO6s=
X-QQ-mid: zesmtpgz9t1747634288tc84d8360
X-QQ-Originating-IP: GglaMseZBGUc4WdCZ6/ysBBpSmdfmH2PDlL81GL2hTg=
Received: from mail-yw1-f182.google.com ( [209.85.128.182])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 13:58:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4176657921267320070
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70cb1e8263bso17387327b3.0;
        Sun, 18 May 2025 22:58:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcaFkX/ynFmpA3bzRT/6/Hs4hkepJcxiy+pmX+YxpUnCx4ujWWOxI1ybsWTR999Ou93Lye5MbP65Zsgord6vhN@vger.kernel.org, AJvYcCX3k7eP000//SDDmyJASmyNbPTIHeM2Fk0toegE0gmKlY45nIRjMrjlrB+9Q3MIlZfbNfJpx+qj6A7DeGic@vger.kernel.org, AJvYcCXqx6H/h6RTKfcLQ/PhsBCduW/FUCuzJlTI3vy7jKFaB8Mx4Y4HEW/4kyPbE3Zrr6W3mCfmwBGswBI4rRFO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9gMI5WRtixwfMmPv4CiUNE7KlXkh5+WH3gSotuHWi6R8naWW
	cCDtwDtmKGu0tGxZsuJ/p6dWSVmQ5GbEwraytxF1NV6FGXLQtZV7xYAHyrYKXnlNTgbW45be7IQ
	UWoM2AvjdW/CTMBVc+vD3WQMAEDMPBHQ=
X-Google-Smtp-Source: AGHT+IEKI1LyAmmWVFV0YxqBG6TDs6apO21h12HhCbqhVWRE/6mxH2FfFUF2tilAhlqEkTmSbJQ93kqYYE2y5dgkpV8=
X-Received: by 2002:a05:690c:7409:b0:6fb:b2c0:71da with SMTP id
 00721157ae682-70cab0e9404mr139629637b3.36.1747634285526; Sun, 18 May 2025
 22:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515073449.346774-2-chenlinxuan@uniontech.com> <CAOQ4uxja322ZuOaHm2rLU1mPsqHsuSbAe=0g5Rc_oh=DmBcn0Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxja322ZuOaHm2rLU1mPsqHsuSbAe=0g5Rc_oh=DmBcn0Q@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Mon, 19 May 2025 13:57:54 +0800
X-Gmail-Original-Message-ID: <65FB323E429AEE4D+CAC1kPDOyYyvvkJr3yX=j4JE3q-jQwUN7tdkOG55HFjy6wE+DeA@mail.gmail.com>
X-Gm-Features: AX0GCFtX2YiTPTZOUdCLIIDiOzwoVPNZIqwxtNWDa4biFVS0eEgE20nXEdY6Cmk
Message-ID: <CAC1kPDOyYyvvkJr3yX=j4JE3q-jQwUN7tdkOG55HFjy6wE+DeA@mail.gmail.com>
Subject: Re: [PATCH] selftests: Add functional test for the abort file in fusectl
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	wentao@uniontech.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MkbhhZQIFFmG+dELmFObRLimNzc/3CqxCFotx6t6e/ZRwrozwOJQyHjH
	5IjPxFC2hyWzuvj9HSa9CZ+4sOgWPwKLRF3dTezfPpueflKKTDG+Vo7gvIEaHz6xYUhQn5t
	Zp6iFKhjzbUSSLRvkJC8IKqdYos6EbmhBB3QMwmVClRDQy2U+a314WmOw+Zb29qCjH7p/RV
	r3+HcI1UZ3rOithGz3CuwyN3CWITLz9Ry2QY56s6hPEkkn2gJKXC6xDO5n60PmaUQ/1chUl
	GxbsGjOZeV0oceHd7+5UfqNCM2Ogy+cAc4YgmkBC9W9hr/yYoYquRI+AX+bwW3SYDcA6zZ4
	WDWP/AT9F3mCMJXtM16a7oFGnCQINVY9xFgSjXVzZ869AgCQhwCR8PR6sQ4YzTVRdhxl8S0
	My3Wck36M1fCRhmmJkbYnX6Dt14mju13TydsxYG4h5T3DbmTUA+4btR9bPLVflHaG4O0d9Z
	2bkkO0n2ScQlclF8etTfSFshyv7rWiahNbk3GEzLS0TSBHo0HelIfS7NSbUIPGTWoqR0pL/
	DL5jhQEpYobsoRo9jlHKuh4fJysg0zHfNSwmY7Vz+SayYQxyCCOs9wGhs5mrPCMsPhbVkoe
	kYzXGfvAJ2xNmmH/LjgQ5UtR4JiA0ronhFIS72/jkFEqOBaWX4K0oiElHyr/hwAjs0XotXW
	SmSNM+34CuEot5Nf00QEQBID7Me7JtYbpvcYh3fHd6464jWhAdIa5+vdycFnCGju9a6ILF8
	fBksCaE1Cci5cAiC42hjznR69lwsoitoJ2G3v1M1mDs0FzX302XuNzUpO0a08K7jwrIAT5M
	tsRa63QEZKbiI8ZdKmEbum0z2XfeTRUHcGZUUkmNS1ldfOE4GSW++j+TXVAnuPklAAkqplm
	4Nn7KBEAgHj9LXR9mN19luZv2zPuYy/8z5UjB3+6FRWdL+SziK9/LUWUMy1LRvnf6Eit5Hy
	C9jAeufuiQTnNKX+UAkOn4Bgm7KDt2fYj7duHudaeKme84iNz6CVlkSmPRM4AzpYeBLNMeC
	Sqc9S913OFavTXImPeSFaq9BL4H9z3hrqgBZsfxAtb3ClJihQdD9325yDWOzk33eZHHTh1N
	TQFyPj8MEbg
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Thu, May 15, 2025 at 6:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, May 15, 2025 at 9:35=E2=80=AFAM Chen Linxuan <chenlinxuan@unionte=
ch.com> wrote:
> >
> > +       ret =3D read(test_fd, path_buf, sizeof(path_buf));
> > +       ASSERT_LT(ret, 0);
>
> Nice!
> I guess you could also verify errno =3D=3D ENOTCONN or whatever it is
> in this case.

I am currently facing two issues:

1. I am not sure about the exact functions of max_background and
congestion_threshold. I have prepared a patch that adds documentation
for these two fields, which can be found here:
https://lore.kernel.org/all/20250514061703.483505-2-chenlinxuan@uniontech.c=
om/

2. How should I test the "waiting" file? My current idea is to have my
FUSE daemon stay in a state where it does not respond to requests, and
then use some form of inter-process communication (maybe a Unix
socket?) to make it resume working. I am not sure if there is a better
approach.

Thanks,
Chen Linxuan.

