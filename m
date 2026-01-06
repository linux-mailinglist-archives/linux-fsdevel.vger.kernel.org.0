Return-Path: <linux-fsdevel+bounces-72514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A56CF8F46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83FFA30402B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0C32E69F;
	Tue,  6 Jan 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFwQSPRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762B326943
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711463; cv=none; b=UwXnPXRNFHa1zVbS9O2n3SETz9sMHnuLjbvFHlXm2h8qjcHwX/DwlfOWK+4mJAKQzn1W5wEjEsmw1XYU8PAw8lHr3idDxeV1mazjKqUBGOZyPqeG2vvC/eyl3CsuH6yxf/FXBbA/wm/+Jf+VxkHh2Ic+VJQ5XnvhHzmf/lp0ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711463; c=relaxed/simple;
	bh=RTEqHiPxVPjrtbkJ03DMabczUyu5+m5/ifpL14LO8f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAMaZ+M8FapxIDzolYWc04YUgua+yOvTDRtcaRLs0dhPW8ZgGtlBWyPu0wFSAavlBBnmHe4J3aRuQ0mpB/68C/+fAVM27tYbSuEGS/DBkWxJYqcUhSuj7XPOG/9FxWFxe4dyk3vRkZG9BzFr40cS0dMPhXmx3+WbTHZhL19KZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFwQSPRx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b725ead5800so152439766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 06:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711459; x=1768316259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiSJ7HFjyiL4zrEuTzf1AnHN35xwm5emfdgSAVRzfuc=;
        b=nFwQSPRxK5YYxarkgxhbrO1OMryYG3pIiy8/peQxGFpytB2IWr+34rIl7NI99+RJO8
         CcuqS8Dw0p34qEBUz7mhM3zMt1hn00MM5KsM9vr6RdRUDoYfFoKAyy6d1iPvK0nVYtn/
         qf2XLoT3jSk/0FMsJ1SNHcNtDSt9LQx+KCfV9W2K2alNIdvfoPM3KtJzf4CQjzs3c/fM
         QBufjLXMJLXtrJKPgYdN7bzajvxaZaR4+iHrDLKDVBGQ3Pj075I1BAHi4x1gjyHkkPbr
         iSuN0p5bNBD1Kd5t4RBn2/y8th0MALO6JryOBHnOUehf3UmQO/i8bfmTrPUZrsKKtmrL
         WGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711459; x=1768316259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xiSJ7HFjyiL4zrEuTzf1AnHN35xwm5emfdgSAVRzfuc=;
        b=V74JLb/ebPsGXrb9EJ7jookt8vcDPUGIJnlanU03pf8zG/1T13kw8TUvfShK0miKqY
         2pepI/OOc8kAmOr27ap8Lv6LkqNXQ/oKDm2C0vtpQMSDFoCIvvPlAhNWScjbqNu/LDFb
         3VHONPf7yIbC4PTYB9AibW71R2FqjoG1mVF13moFezypiIvlxSDJ6/NSUlbvXhxkG8X/
         6+amnD4TcPc8Kx4WJr4KQvGcwMDrHG1icdufAx5wbGj8AxfFkn8Dxg4JXb263BQn3Rn3
         J8Wan79cXpi09Fk+g3negqgUh7fV7KZ1ZL1YI7XzQ9sCbB/2xTxujVzPwkXURByBVqtd
         LCJg==
X-Forwarded-Encrypted: i=1; AJvYcCV1JKEOZGBxmVg92xuRPY12tTZaPJHBa5PC1saFofHTO2gw2sVgOegDC+eLYGHBhxxznK/kY3ok3pO2CR5M@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVhKhL9Z1qv06OA8u83hjNsUpol7a7Z4p3402kOzFxz6Gb+Gy
	gOcwX+OTxCxGn4VcNarCwGrArsOygd2vxLpXF4HNIAkcTsVN88ZRqzn6gNRQ4HFpijANoxvO+eP
	+HmcAXEiAC0wnNGeZt0yEpZ3P3KlGRmg=
X-Gm-Gg: AY/fxX7q/xKbyf3zOquGhJ+5bcJR9+8FcoXbcaKHtwTv4ZuCHn4Wg7Imd814A2sAfAC
	vxf/kdS0Zyi1+mpOgFMNIeRgT/Q06U+1WyKZ8mP/FJib6wpXd3TcmEVQpPYrZjaOV3PhePzFRWD
	ck7K6SkmBE7rcPj/BpbKLB1ztsrpDYpVN8Cs8PNL4SVRDH32rTHEfgzJyiTTkbq44A9kADLdSJ6
	hAqAnzJGrN5bhlUB7kBXtw5EzwaF6ZwBgYUadptFxnkxuYk7IYO5WOuMTz8TkZSbdaYSXExUsXz
	e6TfgK+RQZPNBl8kLBoQWOp/80vF
X-Google-Smtp-Source: AGHT+IECocOvHA9ih8H1AHzcslU8UWVHPC/rsqHbWGyJ/6kVRUZKEXbna14+gJmL4CfLLdfkGZNH0X4nUGJZG2vX00E=
X-Received: by 2002:a17:906:eeca:b0:b73:4b22:19c5 with SMTP id
 a640c23a62f3a-b8426c08dbcmr317509766b.44.1767711458922; Tue, 06 Jan 2026
 06:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106131110.46687-1-linkinjeon@kernel.org> <20260106131110.46687-15-linkinjeon@kernel.org>
In-Reply-To: <20260106131110.46687-15-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Jan 2026 15:57:27 +0100
X-Gm-Features: AQt7F2opw6guqkFfPJcxCe5EsvrKqtQYqmvptSAlMNNzmHuhjQX3ahSkPzDlbMA
Message-ID: <CAOQ4uxg+fWKPjknumG9Ey0ACTGXzx2dfeUbBxAiob4JJdHjw=A@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] MAINTAINERS: update ntfs filesystem entry
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

courtesy CC to @Anton Altaparmakov

On Tue, Jan 6, 2026 at 2:35=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org> =
wrote:
>
> Add myself and Hyunchul Lee as ntfs maintainer.
> Since Anton is already listed in CREDITS, only his outdated information
> is updated here. the web address in the W: field in his entry is no loger

typo: longer

> accessible. Update his CREDITS with the web and emial

typo: email

> address found in
> the ntfs filesystem entry.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  CREDITS     |  4 ++--
>  MAINTAINERS | 11 +++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index 52f4df2cbdd1..4cf780e71775 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
>  S: Belgium
>
>  N: Anton Altaparmakov
> -E: aia21@cantab.net
> -W: http://www-stu.christs.cam.ac.uk/~aia21/
> +E: anton@tuxera.com
> +W: http://www.tuxera.com/
>  D: Author of new NTFS driver, various other kernel hacks.
>  S: Christ's College
>  S: Cambridge CB2 3BU
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8af534cdfd4..adf80c8207f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18647,12 +18647,11 @@ T:    git https://github.com/davejiang/linux.gi=
t
>  F:     drivers/ntb/hw/intel/
>
>  NTFS FILESYSTEM
> -M:     Anton Altaparmakov <anton@tuxera.com>
> -R:     Namjae Jeon <linkinjeon@kernel.org>
> -L:     linux-ntfs-dev@lists.sourceforge.net
> -S:     Supported
> -W:     http://www.tuxera.com/
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
> +M:     Namjae Jeon <linkinjeon@kernel.org>
> +M:     Hyunchul Lee <hyc.lee@gmail.com>
> +L:     linux-fsdevel@vger.kernel.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs=
.git
>  F:     Documentation/filesystems/ntfs.rst
>  F:     fs/ntfs/
>
> --
> 2.25.1
>

