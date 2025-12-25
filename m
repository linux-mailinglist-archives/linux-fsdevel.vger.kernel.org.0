Return-Path: <linux-fsdevel+bounces-72080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A065ECDD47D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 05:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1581B302A122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3623F42D;
	Thu, 25 Dec 2025 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="nT+xDUMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B9215F7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766635347; cv=none; b=I+LFDisM/1cTyYuofOsHQO0fjEkG7OSJrG3LF4UQhYzeTLeIEOv4zIjK1w4mSzqKSzboJ6QBwDbVT06f+OICeGLg43wtvT5u2SGhehd4w8T1bXEJPlqwxfD08ZyFM5qGM1ttKFu9MM3bB+Y4HRhtxCN88afXBkVLidDBJ1UZiRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766635347; c=relaxed/simple;
	bh=nYqU6zxgPk/qNiPgO4IThHn+KtwJOODMSqihM7UGYfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THuyVbcVpqlOAfu92u/DHAqGa5py7uulXxtaFx6zaIz5s2BEvE9bM+sz1ETyPh0fMlp4lIlRCdu+J7O0kS+4mDIgipTXqKzV+d89g+s/aDeQMhm+MVq1mERekctzUF1oitLcPLgF05mm6dX5f/I1qm2yYWW/IbWoWo0AQeLzeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=nT+xDUMz; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78fc7892214so37316967b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 20:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766635344; x=1767240144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqWWn8IKcWEWWUsA5WL517uii5ea/a/1krkJG2emav8=;
        b=nT+xDUMztcAQOL4J60VrMKwMcDBGxZUtCoxVoVTuff6zK+3JxSSHh/M7+VW+vS7ozR
         Fhwa5jUwk8NSKXk4hSaWOsPbl1OExxp22vwcvlXAbujPwP6xky9k5T9lV0IrK5horgNh
         4EMgocm+pH+nfqjxN54E3umeeezVxGTP7+vJwWa/N9gWKcqaiCnVdzrwzQ2uzOfIRBHk
         A0DxRtiZVBstVW+XxzOllf1gAl06ODBAOVfos9FCl7eC0SsGHvu9HzzfJehk2OdbUvbc
         ZasfOLbBEisC61GfQeTID7fI5nPvGhGjOMwJtRUHbcmjec7rZc1aP0Gec5bZ0X27U4Hn
         tkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766635344; x=1767240144;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqWWn8IKcWEWWUsA5WL517uii5ea/a/1krkJG2emav8=;
        b=kzE35qHTRq1lFQhEIm7TmpD3ayQ2xj0oMDGAw2Vek/Gzyxe8LMC9rwQQTEYG5hOtCR
         dlIsLZl90LlyFXciEHEYTs8ZApPJ5tQ7wUvtdJClkQTZqe0HBGrjPaDo+z8dW0aHdz3Q
         Hfq0Czeg84xSFuVyxEpEF46d8r5l0tt5EkLNDYBcMOVk6GTs+XLd5ZBv+KQmmcC5ZaWr
         eqJKPjCEuZypmoC8Qm2yYfevQ2OdnFHQSy2+n8WPe7KSgG302RkL2gGAW13e4VkYqHtW
         uI8Ga6hQwQ0nCIAfkPuw53RXmH7jRAaHOICvhKHQMQLL1jM63Y/y99ZuslsurQJcseLa
         SGog==
X-Forwarded-Encrypted: i=1; AJvYcCXljIffMsw/NaKk6d43hWwzipnBXunKSkJVE8hBDdzk0tzn+mlEiqTiqOE7ddEBjpuLc4EcMjPJquXAroD9@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZxFyzcqFuFRWBptpM0g8wy2uA92DkfagQdLrj8veK8jH+pEW
	TNic9Bfx1DHyOvf6KYGKQ8E2niQ2M8D8xvo8mx/YbN0MXoZ40gDpS85KzIW/msttmFY=
X-Gm-Gg: AY/fxX6NK/iqtDdNQu2r3GqHOWS3LTIhW1YgvfolOH+lYwBZxI2GnfE5dwlW0VPcmLl
	yiRQVklfFBSsg8xol0t2NjhcTu96tuJOE+G6e+jXZGfPHGjLzNhAfhKD/Ijlpwzj+EIPr9GrCIB
	HHhTGhlkXooVePHsIeS5D9h5/zi25tE1VM3aIfQ6g9BGYi9qlFCJATT2oJWQexWaoPVBQpL/9O2
	WwZp5v+Y6Uo6hC4icGTDBYrzNeJqR0P/XOvPqxP5EH0+VvQ/ygO/9XzyQu9WjNGrSKxTJxok8al
	SGpIx+FhwYJv/XOBUDcPHjLssiVHGfqCy0PKxnq32aaLB17yECboCpZEBZwHFuQrA21MdxjqbHf
	crxpHiSwPs7TMvWv43yZvunuiBTKr6gNFE7aOjucNTxJyJPyy8Hq/8RPn48NW4dNTsF0yQhWjkG
	At8lCWqHbsQjlo7PNFTYMfzarB2SBlzVM5u4MpMqYgML9YdqrXcu0/Lp1wr4v0zMUK8+ZZ/iddX
	mpnQODDQldCwiBLFTFjIWtQux0vXxqAvvM8764sUz0ZkePR
X-Google-Smtp-Source: AGHT+IG8Y+cwmZ8zjr0cdykEcowVV5K3/d/B9M8WUNdSXDLtJBjo9H1y8Leh6k68q6gPgbRZeOYKOQ==
X-Received: by 2002:a53:b84c:0:b0:640:ddf5:254f with SMTP id 956f58d0204a3-6466a8ac06dmr12338597d50.62.1766635343670;
        Wed, 24 Dec 2025 20:02:23 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:d657:3387:9f65:590a? ([2600:1700:6476:1430:d657:3387:9f65:590a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43790dcsm70987117b3.11.2025.12.24.20.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 20:02:23 -0800 (PST)
Message-ID: <63e3ff1595ebd27e9835ae7057204b7eef0c1254.camel@dubeyko.com>
Subject: Re: [PATCH v2 1/2] hfsplus: skip node 0 in hfs_bmap_alloc
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, zippel@linux-m68k.org, 
	linux-fsdevel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
 frank.li@vivo.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, janak@mpiricsoftware.com, 
	shardulsb08@gmail.com, stable@vger.kernel.org, 
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Date: Wed, 24 Dec 2025 20:02:21 -0800
In-Reply-To: <20251224151347.1861896-2-shardul.b@mpiricsoftware.com>
References: <20251224151347.1861896-1-shardul.b@mpiricsoftware.com>
	 <20251224151347.1861896-2-shardul.b@mpiricsoftware.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-24 at 20:43 +0530, Shardul Bankar wrote:
> Node 0 is the header node in HFS+ B-trees and should always be
> allocated.
> However, if a filesystem image has node 0's bitmap bit unset (e.g.,
> due to
> corruption or a buggy image generator), hfs_bmap_alloc() will find
> node 0
> as free and attempt to allocate it. This causes a conflict because
> node 0
> already exists as the header node, leading to a WARN_ON(1) in
> hfs_bnode_create() when the node is found already hashed.
>=20
> This issue can occur with syzkaller-generated HFS+ images or
> corrupted
> real-world filesystems. Add a guard in hfs_bmap_alloc() to skip node
> 0
> during allocation, providing defense-in-depth against such
> corruption.
>=20
> Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D1c8ff72d0cd8a50dfeaa
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
> =C2=A0v2:
> =C2=A0- Keep the node-0 allocation guard as targeted hardening for
> corrupted images.
> =C2=A0fs/hfsplus/btree.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 229f25dc7c49..60985f449450 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -411,6 +411,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree
> *tree)
> =C2=A0			if (byte !=3D 0xff) {
> =C2=A0				for (m =3D 0x80, i =3D 0; i < 8; m >>=3D
> 1, i++) {
> =C2=A0					if (!(byte & m)) {
> +						/* Skip node 0
> (header node, always allocated) */
> +						if (idx =3D=3D 0 && i =3D=3D
> 0)
> +							continue;

I think that it's not completely correct fix. First of all, we have
bitmap corruption. It means that we need to complain about it and
return error code. Logic cannot continue to work normally because we
cannot rely on bitmap anymore. It could contain multiple corrupted
bits.

Technically speaking, we need to check that bitmap is corrupted when we
create b-trees during mount operation (we can define it for node 0 but
it could be tricky for other nodes). If we have detected the
corruption, then we can recommend to run FSCK tool and we can mount in
READ-ONLY mode.

I think we can check the bitmap when we are trying to open/create not a
new node but already existing in the tree. I mean if we mounted the
volume this b-tree containing several nodes on the volume, we can check
that bitmap contains the set bit for these nodes. And if the bit is not
there, then it's clear sign of bitmap corruption. Currently, I haven't
idea how to check corrupted bits that showing presence of not existing
nodes in the b-tree. But I suppose that we can do some check in
driver's logic. Finally, if we detected corruption, then we should
complain about the corruption. Ideally, it will be good to remount in
READ-ONLY mode.

Does it make sense to you?

Thanks,
Slava.=20

> =C2=A0						idx +=3D i;
> =C2=A0						data[off] |=3D m;
> =C2=A0						set_page_dirty(*page
> p);

