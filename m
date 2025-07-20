Return-Path: <linux-fsdevel+bounces-55530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC5B0B6F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CEF3A665A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAB22126B;
	Sun, 20 Jul 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLm3QLX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAD18FDBD;
	Sun, 20 Jul 2025 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029376; cv=none; b=W7+G7rSWoKOqA24Yp/A4sZtWxCGILwlCjhN2pOIMdoJE+OvmxtolSUM8M8dtQiMHHRcRNBVkn64x5XJ96AJBRht0xNbKvb3K2wHoekg3mqb5z+DVNgYPkcNhFNbhis+QgeYP+2dzg9Y2p1O+rDNtI51R/MhHbIGKJ4RMWFTO4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029376; c=relaxed/simple;
	bh=bvrkXmR36adZ41cNSDTbguwL1Foz+xHv842/MR+nR2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NW5moLfww4qXvlS86lWxLp5ocvoPsRK5fBb+uZ50sxkRbFQLeIl39PprB8P2FBKYw7mgFuZmqgMAZagcSK3mia1rUdLRYHFbuF7FiVOZKqzKaCiQBkJnGkHjABrAnD8ywvyacQFmml9ZOqtdNWovTbY8a1ppXL7rQcSuSJHUH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLm3QLX0; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34dde96cbfso171407a12.2;
        Sun, 20 Jul 2025 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753029374; x=1753634174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kfkCmoQKEDkofij+kUTFNmulT0YX5tsOABpETlCkRo=;
        b=jLm3QLX0I1W466YLQHkZZeyccqoWdCQECwSukqoxvMiNClkHz2z6IAic0D3Kjy2qqG
         GOTV7Rxs3+sM+F7Ec5Rq1s7J6ehw0VbMaKu3sG2fCBTphJEAJJjMTjshP+3Xsy37tl3m
         ZqB88aHFBivuW7pIT7Y7e3Mc/jSeyBlR83NKQHo0ILGPdqv2MzUNBVpbXoQE2nCFutRm
         SnccFezp9s/8kimXWo1qqSfg36+na6Z9rE+roJSesglOO4cH0AY8AsyuO9OU2kGsvE9M
         cwTkkmaLJxUsjZayGizKflejyebrSO/rtSyb5n4/JAAXUlptrnSGirUvLS/N6zl1PXg7
         xw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753029374; x=1753634174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kfkCmoQKEDkofij+kUTFNmulT0YX5tsOABpETlCkRo=;
        b=czYyAcTHiyYNo94Ghn6X1EaFuLx+K+mELZWzw+ekFMirKPHVe6ZOXoy0hG4SQ9JCb1
         twxq3I6riYzy27Gw1Jewr5Fb1uoBvY3BIiH8sZZcNGoZSH7B5ZF3bxGjlgfviGT9ABVb
         WKgmV7m2EzjMxmLcaclquu1gJisccgHL+n4WbP4cLX8qbK+nuwn8VSPlwC45bMPYRQ+A
         3SCeJenSziIkW92UPX4cbsVPgCt7HH3x9rVBGmCEFuXfdwOVJO4EtZtbR0yN45NY0syM
         nWUwfG/k5VB93qH9eh5y6Go7pl6gMfOwRilAYDO8qC008gM3Kv00vp0p5+EuSsl5Wu2E
         tF9A==
X-Forwarded-Encrypted: i=1; AJvYcCU6lAVacWyNNinZuO17Z6tL+rqUopUpA5jeIAYoTRST28fB4q4RC5d3vPoUgnZ4RxQJEMEeSDRQkEywYi58sg==@vger.kernel.org, AJvYcCVUHCY551Ebn44KYZ1WuLmyilUPGBzMT/BiMpr+qfyWHOwZ6tlmURn/nlgUg0ObFaoWU//OmX33c/BhK0xU@vger.kernel.org, AJvYcCVd/scAxIXflggE4/TWGcG7//6n1rNol3zfZXXy51cxKokW3gl+HGodJiSQBgIJ7JMWnh8=@vger.kernel.org, AJvYcCX03hCeYS5eSYwxUejuz6tkyp9+P3TnZUeL1mQkMyciIwt7piMhIw5x7DjFG9RyjBDpZHA4O0aMXrYHeVxk@vger.kernel.org, AJvYcCXaSZGll6YjLOnk8FzdvT5u3cP/zgYOpioYoJFRSeoPbOTE1IFgrI9EOqTzCz5A6JmzwJfDzVsMfBAI3e9Gf5m6@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIXfxHN49ug7Ga2QloFn7o8w8PhYT1wP0laKEtyHe7FnhR7UP
	KcAoYqsBw+sV8PxQ755pvjUXlavLZOgkwsJuPHFA0xPnzF9olPsgZA3n295X1W2XwZk9Z61Se5l
	sF2lisbnp60vK14wxwwjz4u5cd8ZjWCo=
X-Gm-Gg: ASbGncs0D9u5kKISP12OsU+mu/+ghPj4KzXazgogv0tmIKZ0Hqis0EGtHODy1Vg/lQn
	FAdVapgbtOw8I91sfq0L4YiWg0bL8ieRRXmCfdYBAABzAuR747bZJOPqXNRFiPfIMkHVOcrETMt
	sOXifVZBJ42ULqWyGb6jDTkzRmswoPJIuJiggrztzxmTb6+hf6vLleh6vZU1sCak+QsfweAn4HD
	HVsw5i/
X-Google-Smtp-Source: AGHT+IH50oSkAuvxv6uZUvE/Ve2TuI3Fxok9m8jWgL04NiDIsbgPX9U+P5yFyAh5qDxK3l4vBipk9lXgFQKQQ9R90bI=
X-Received: by 2002:a17:90a:e18c:b0:311:a314:c2dd with SMTP id
 98e67ed59e1d1-31c9e77394emr9950764a91.4.1753029374267; Sun, 20 Jul 2025
 09:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720065045.2859105-1-hpa@zytor.com> <20250720065045.2859105-2-hpa@zytor.com>
In-Reply-To: <20250720065045.2859105-2-hpa@zytor.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 18:36:01 +0200
X-Gm-Features: Ac12FXzsFbO3wDRf2U_8K-azeesJPixu1ntYI5bLlTM6iCxpMmbGfGJVOtGHyH0
Message-ID: <CANiq72kE5AznnA81sb5S-KVx3VCef20zcMBfbRUO41g3uAtQ+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] compiler_types.h: add "auto" as a macro for "__auto_type"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:52=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> gcc and clang provide the "__auto_type" alias keyword as an extension
> for pre-C23, however, there is no reason to pollute the bulk of the
> source base with this temporary keyword; instead define "auto" as a
> macro unless the compiler is running in C23+ mode.
>
> This macro is added in <linux/compiler_types.h> because that header is
> included in some of the tools headers, wheres <linux/compiler.h> is
> not as it has a bunch of very kernel-specific things in it.

Sounds good. I guess we could need a workaround if someone happened to
invent an attribute which requires using "auto" in it, since it is not
reserved there in C23 AFAIU. So FWIW:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

> + * so it has always been "namespace reserved."

Not sure what this means (could we just say reserved?).

Thanks!

Relatedly, there are some proposed, further changes to `auto` for C2y:

    https://www.open-std.org/jtc1/sc22/WG14/www/docs/n3579.htm

Cheers,
Miguel

