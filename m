Return-Path: <linux-fsdevel+bounces-57161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99335B1F076
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BAA3A485F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9253289831;
	Fri,  8 Aug 2025 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RqJ3qpwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DA289829
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690066; cv=none; b=hwrmsGewTRIs2hbmy4HCgTT/0r7ArvAHtxA7jIkkotnuBzRE9Aq1CZudunqfISWWpVk2f/4zSiod5Ebvz7ozsx56jb32lN2YuuTRs6XtQrBzsSD5GE9w6R4MAFDd4+NgmH7nOqur6/6R8K/NIvQpN3svXUv9hn/VNY1DeYiV9Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690066; c=relaxed/simple;
	bh=HmRC7lsFYeGZF1wI7voIgyEsHb+t9+/VffmRds6ZKFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQopgD7SaM3EY9Cv2uZQfqxjK3NjMwMTwAWh0iBRpfvlZtNLcVqIzjyiR5NCYhoJ6nW4eum5oyUssb1u/yWXKcqqq5O1vT/b3JSOSa68fCgpb9SgMAqGOLk4/1Vl04Ue3qdZaRgqSndMPrzKa68B6jB4GXJwkRd0UHnjNpRPiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RqJ3qpwt; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-708d90aa8f9so28349097b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1754690063; x=1755294863; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uuJLHWSmv+c0uCdhfds8sX30zDJBMdAP3nmUmnGq3G4=;
        b=RqJ3qpwtg2Q2OI1zhuM6eUUlsWA2qsR/GBcAPvWcM0HNEA02RiINv+U1BMrzzpgM3g
         7waZDSL7ygrwiK2D0a2s4M+Im89gsrw42GPqwwaQRuA4wGL19xvA/a8eIccKho/VhCY/
         BarQ4ec5asQw6Tknop6aDD925ERk2k3urzV7kL6XHg+aAERlTW1u/d42cbnY76aWRIGK
         fJNbY0BxTNJ3FqORPIhQqbLi/FCZVuDj8kw1nxx+/k4ogugvqvZnkKHOM/nMQFkMPL3C
         znfMiDeGNcG/j2kfc0vIj5sHgwFNbVU1o7bpnYFpX0Rij4RC5ggpxyiGU8UcicRhFUkr
         ZIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754690063; x=1755294863;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuJLHWSmv+c0uCdhfds8sX30zDJBMdAP3nmUmnGq3G4=;
        b=fRysr+z2///Ll05m7qeZJnGhITXUEOaJ4m1tBaO+ixRgZ2rcgIe+X+Z63nWkGixLxf
         VyhrdFn3nDRYLEjp7XUrTID1PD0VY2E5vIiH+o7c31c0x+Nbz3RzO2vpxLk3hthrWqFF
         DUwa6MPNcip9Sb6WUDleKKaL9i+kjNN6GVV/D17T9xg6/qIVjqnP48p+kL7qh7k09yiF
         0703NPcnNnVBrFoFPQ6MsM0SaNPNuRG3tNiB4PCe+8i4cMdkFBfT7oAae+l9VFOIcSbk
         fK9UIPT6I3SyjnUXX0iXLrIyo+FBx5EhIquRodpqrZo2SxacxwV/kwUb/Y9Ue2O13xoK
         Dyhw==
X-Gm-Message-State: AOJu0YwOk66OWQs8JhRicSZAcmEQDx6SW3yFhoiP4P+yaLe0hrq5LuEW
	L0C22OsLveHou7PDbpCHJgpcoZqwz5nWkb/A7Fy4OETzt6J79vtnqYKaavD8x7A5v6s=
X-Gm-Gg: ASbGncv5W2dy0lWmY6asHIBiUtjHKyHVCTqlZZzb4f/JNkxm94/RM7YNs7l0oqiwIo/
	gtvexzHx3RLb6ILpP6rtCNCJNQaZWbOflFdDSx2YF5cPF3Cir/jsIZCiIq+YyaxzYhBWYbrVgSh
	cGMhtOf2Ce7FoZ3twyiymg9JtBTst3+W+3faLFd7QBh+JqPZcD7rm5p4sVa1ydNf44vG+/yejTn
	0UPm56212JQ+p7K4TN8oLV6MEg8NZIh+OSa4xwpRCEi943JrSl+eHgAsVrXtfck3p9zMshd4/vE
	i4U+r53g9velAZCLymKRBF8BVYogSU9NZZl+iefCrIQQNXpPJMnOQZLP90rU0fq5dmHK12MaKuA
	2MDCITrZAnv6Jcrk1k8VW9e/HHFU=
X-Google-Smtp-Source: AGHT+IGFwdcaBJd15gRJijednbAA2gVVZNZGPOhhiA1n8CUs1CpXJktDmFI1FJq1FaRdjPHUgnRAiA==
X-Received: by 2002:a05:690c:4c12:b0:71a:1513:236 with SMTP id 00721157ae682-71bf0ef41b9mr57586347b3.40.1754690063156;
        Fri, 08 Aug 2025 14:54:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::3d? ([2600:1700:6476:1430::3d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f5874sm54842917b3.21.2025.08.08.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 14:54:22 -0700 (PDT)
Message-ID: <66f5990f04f4b3d1b53164695ca79c706c36325c.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] hfsplus: abort hfsplus_lookup if name is too long
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 14:54:20 -0700
In-Reply-To: <20250806171132.3402278-3-frank.li@vivo.com>
References: <20250806171132.3402278-1-frank.li@vivo.com>
	 <20250806171132.3402278-3-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 11:11 -0600, Yangtao Li wrote:
> Long file names for hfs is 255 characters.

You already mentioned in another patch that HFS has limitation in 31
symbols. I think this patch requires more explanation why you've
selected hfsplus_lookup().

>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfsplus/dir.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index 876bbb80fb4d..d8fb401e7fdc 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -38,6 +38,9 @@ static struct dentry *hfsplus_lookup(struct inode
> *dir, struct dentry *dentry,
> =C2=A0	u32 cnid, linkid =3D 0;
> =C2=A0	u16 type;
> =C2=A0
> +	if (dentry->d_name.len > HFSPLUS_MAX_STRLEN)
> +		return ERR_PTR(-ENAMETOOLONG);
> +

Are you sure that we really need to abort the hfsplus_lookup()? We
already have the logic that checks the name length. We call
hfsplus_cat_build_key() [1], then hfsplus_asc2uni() [2]. And
hfsplus_asc2uni() checks the maximum name length and it returns -
ENAMETOOLONG [3].

Thanks,
Slava.

> =C2=A0	sb =3D dir->i_sb;
> =C2=A0
> =C2=A0	dentry->d_fsdata =3D NULL;

[1] https://elixir.bootlin.com/linux/v6.16/source/fs/hfsplus/dir.c#L47
[2]
https://elixir.bootlin.com/linux/v6.16/source/fs/hfsplus/catalog.c#L49
[3]
https://elixir.bootlin.com/linux/v6.16/source/fs/hfsplus/unicode.c#L375

