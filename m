Return-Path: <linux-fsdevel+bounces-60198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA9DB42A07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0837616A211
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26FB36933D;
	Wed,  3 Sep 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="CEEZrZjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE82D5939
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928142; cv=none; b=DELR4s2etHlti5H/AH56/pmRlE37acPF3rprS1ji3fbvh27nYOqOuXcTB8eMXfvll4hRFoOWSgLp6VWaM2c0VVPUtHFquxlItkGIKc7BKybSQf4vBTzbmUXmWKjGN5rbLQEFk6g7DWrmvIRgBN1qNTT8AzPJ8RyC4WkVDl1ss3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928142; c=relaxed/simple;
	bh=Y/Sk+i72TUxqK/4Qzzax3GXlJ19SZEmkO5k6KP5blkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOA6tpCnfYln6aSP6uq8BL17bnujt9wnQDDtc6f3jx1AqZnUuFHpxC2JtQ0PYJXikU9jh8dN+6lC7VFw8XVNO4P1mZzYcbPEtXBInWNemXIG8z5dTOHTWSUb3P/RIyGPwvHVUvZCS+4KP3Q0DLBw6pXz7cRaXglFmFpF3rqAWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=CEEZrZjO; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e96e5535fcdso1410378276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756928137; x=1757532937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8D/tnmxSB2ehfFK+KujWFrgKovhuHLCbUvU08cjVtzg=;
        b=CEEZrZjOZI7M3bxMy1nekieAKShGXfQkA+WKK3PXMdWRVIA7z3jSL5XwCPqoo0kodK
         18FNNjlASK77/Bl8sIqq8hwNlzx0XEAV2MNLs+7pEKTG2PYEuiqlocA099m8L+hRjpBR
         2z8jFBHhfFRsllfTg76Gaut0MlsxZe5Rc2Hhkn7dO5vtwobcQaYfrBqZCoHekYF+2FG/
         NaFcKz/AMSzgiElZSBltK1BoJ+W2Oi6a8IVXuDUv30mWDFS8G9jJn56zeC2dAWQd1FFZ
         ef5jBgRsqN+WNoNnaC3Q/LWmyJWCkuEuvKZIeBqChXRT1OhU6+hrA4fe88JEiQndFrzu
         ehYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928137; x=1757532937;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D/tnmxSB2ehfFK+KujWFrgKovhuHLCbUvU08cjVtzg=;
        b=X4skv8r7/LYK2brEJFCtWm7XwDQ4f/k3urqzggmU8HfFSPF0rMkEq4f0/E4jaUp164
         og8Gjf6UDGJH3G1Bze4RS8W3a0C+dEquYo4LdOzhmrxm7zhgi/tFq27hz7uyO2X69+ur
         J/QHAjqjEf2xEreknjVwcsB3Ly4UBaY4oKvpgUMgSH6kxg9HEP7/dQJBTo0hBZLSnXVI
         QOmN5F1RgPhYLflp7dm3M4VQoKFqxBASrUMWEK4zKWhfN9bMVJ1VQiFJ4zzj0cpOgL8y
         391iFCa6EeDmbLYlZfEpI6ptQGQkJRTCAewqaAOgV8ILLWwzUEwpn7y3unBgi/NrCU3G
         u6RA==
X-Forwarded-Encrypted: i=1; AJvYcCXuJySUDnSyzfidMuWCFqR9R7LsdDLzD7YNzo3/PAVxVx9j2M9DrfDOhiMZf7b5lmhD7sn3V5Z5ZzH2BC5t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pxgl5dDgcABHzJLElpFgVmTo4SlF/ezDh2z0NXT5oS4jqZHr
	KlfC527WBA5cWkZLkxyJGOBP6AmU/PTeeWfFkCunyBBHeaIZ/nfN9ht+Ma6AqqPrrZs=
X-Gm-Gg: ASbGncucu3QzMX6WBIOZomnCRmv8ErjDrGR2rkfZo4VI+MVK0/NgOq99Oih1yL3ePXi
	VoHaZJVUWTlv1PFPkUCukkLUXvQPu+zsV/RgA2QSfKl+nQjZ1r/A+B1rX3Gmg+89+uYzahUQ4A7
	F7w+dU98ZqQXvH/+B8Vvwy27rFSnVxIw8nSndyNUHwK6FwV3dkGOeQ+0vWRnkGHrkbfhi50ydS/
	lUVoVtc1EBPO9ABnAsdYfMksV65wlX8zADJS/Gp+5lXWw4sbtZxjwQ8I0xpszBL9rYDyBM07xj5
	HYYPFprS7jG+aqymFjBv/KQKaIdQRNG8rwh/+wVi626x0rEGBZjp9RaeYiA6MFlD7n1gYs7V3BF
	qezmnJ/V1SM9yIGt0xd3DRzdEMhPpoQIsumOFLXiYAu/mShbaTyQviQ==
X-Google-Smtp-Source: AGHT+IEJZca1Ca/r/lBnT0L2JPk1mFZvcognUhxrXsJlikHlYsJRkWZqvYxTgsowBH2EUV/WxZq+bg==
X-Received: by 2002:a05:690e:1c0a:b0:5f4:f81b:d70e with SMTP id 956f58d0204a3-6017599ac61mr1100128d50.2.1756928136749;
        Wed, 03 Sep 2025 12:35:36 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:7d3:db1d:2d89:8cf9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a83295acsm15949717b3.23.2025.09.03.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:35:35 -0700 (PDT)
Message-ID: <74db8d6af48f37e655e1efc1abfb3ff34c5e1818.camel@dubeyko.com>
Subject: Re: [PATCH v4] hfs/hfsplus: rework debug output subsystem
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com, Johannes.Thumshirn@wdc.com
Date: Wed, 03 Sep 2025 12:35:34 -0700
In-Reply-To: <1e5601f4-ae07-47dd-84fe-7bc449203dff@vivo.com>
References: <20250814193443.2937813-1-slava@dubeyko.com>
	 <1e5601f4-ae07-47dd-84fe-7bc449203dff@vivo.com>
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

On Wed, 2025-09-03 at 15:58 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 2025/8/15 03:34, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > Currently, HFS/HFS+ has very obsolete and inconvenient
> > debug output subsystem. Also, the code is duplicated
> > in HFS and HFS+ driver. This patch introduces
> > linux/hfs_common.h for gathering common declarations,
> > inline functions, and common short methods. Currently,
> > this file contains only hfs_dbg() function that
> > employs pr_debug() with the goal to print a debug-level
> > messages conditionally.
> >=20
> > So, now, it is possible to enable the debug output
> > by means of:
> >=20
> > echo 'file extent.c +p' > /proc/dynamic_debug/control
> > echo 'func hfsplus_evict_inode +p' > /proc/dynamic_debug/control
> >=20
> > And debug output looks like this:
> >=20
> > hfs: pid 5831:fs/hfs/catalog.c:228 hfs_cat_delete(): delete_cat:
> > 00,48
> > hfs: pid 5831:fs/hfs/extent.c:484 hfs_file_truncate(): truncate:
> > 48, 409600 -> 0
> > hfs: pid 5831:fs/hfs/extent.c:212 hfs_dump_extent():
> > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 78:4
> > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> > hfs: pid 5831:fs/hfs/extent.c:214 hfs_dump_extent():=C2=A0 0:0
> >=20
> > v4
> > Debug messages have been reworked and information about
> > new HFS/HFS+ shared declarations file has been added
> > to MAINTAINERS file.
> >=20
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > ---
> > =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 fs/hfs/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfs/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++++++++--------------
> > =C2=A0 fs/hfs/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> > =C2=A0 fs/hfs/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0 fs/hfs/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++---
> > =C2=A0 fs/hfs/extent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 19 ++++++++++---------
> > =C2=A0 fs/hfs/hfs_fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 33 +--------------------------------
> > =C2=A0 fs/hfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfsplus/attributes.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> > =C2=A0 fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfsplus/bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
10 +++++-----
> > =C2=A0 fs/hfsplus/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 28 ++++++++++++++--------------
> > =C2=A0 fs/hfsplus/brec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 10 +++++-----
> > =C2=A0 fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A0 fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 +++---
> > =C2=A0 fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++=
+++++++++++------------
> > =C2=A0 fs/hfsplus/hfsplus_fs.h=C2=A0=C2=A0=C2=A0 | 35 +----------------=
----------------
> > --
> > =C2=A0 fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 +++++++++++++----
> > =C2=A0 fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
> > =C2=A0 include/linux/hfs_common.h | 20 ++++++++++++++++++++
> > =C2=A0 22 files changed, 125 insertions(+), 156 deletions(-)
> > =C2=A0 create mode 100644 include/linux/hfs_common.h
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fe168477caa4..12ce20812f6c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10793,6 +10793,7 @@ L:	linux-fsdevel@vger.kernel.org
> > =C2=A0 S:	Maintained
> > =C2=A0 F:	Documentation/filesystems/hfs.rst
> > =C2=A0 F:	fs/hfs/
> > +F:	include/linux/hfs_common.h
> > =C2=A0=20
> > =C2=A0 HFSPLUS FILESYSTEM
> > =C2=A0 M:	Viacheslav Dubeyko <slava@dubeyko.com>
> > @@ -10802,6 +10803,7 @@ L:	linux-fsdevel@vger.kernel.org
> > =C2=A0 S:	Maintained
> > =C2=A0 F:	Documentation/filesystems/hfsplus.rst
> > =C2=A0 F:	fs/hfsplus/
> > +F:	include/linux/hfs_common.h
> > =C2=A0=20
> > =C2=A0 HGA FRAMEBUFFER DRIVER
> > =C2=A0 M:	Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> > diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> > index 34e9804e0f36..d23e634657bd 100644
> > --- a/fs/hfs/bfind.c
> > +++ b/fs/hfs/bfind.c
> > @@ -26,7 +26,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0		return -ENOMEM;
> > =C2=A0=C2=A0	fd->search_key =3D ptr;
> > =C2=A0=C2=A0	fd->key =3D ptr + tree->max_key_len + 2;
> > -	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> > +	hfs_dbg("tree: CNID %d, caller %p\n",
>=20
> I'm kinda confused about uppercase and lowercase here.
>=20
> Why use CNID instead of cnid?


I don't see principal difference between uppercase and lowercase.
However, it's abbreviation Catalog Node ID (CNID). So, uppercase looks
like more natural.

>=20
> Since ',' aleardy act as identify for cnid and caller,
> Could we drop ':'?

The ':' point out that we showing info for tree and we have tree's
items further;

tree: CNID 1, caller <some_info_here>

So, it looks pretty not bad for my taste. :) Otherwise, we need to drop
"tree:" completely.

>=20
> And let's use %ps so we get func name?
>=20

We can do this.

> [=C2=A0=C2=A0 62.792107] hfs: pid 1023:fs/hfs/bfind.c:52 hfs_find_exit():=
 tree:
> CNID 4, caller 00000000b667808d
> [=C2=A0=C2=A0 62.793808] hfs: pid 1023:fs/hfs/bfind.c:30 hfs_find_init():=
 tree:
> CNID 4, caller hfs_lookup
>=20
> =C2=A0 +	hfs_dbg("tree cnid %d, caller %ps\n",
>=20
>=20
> > =C2=A0=C2=A0		tree->cnid, __builtin_return_address(0));
> > =C2=A0=C2=A0	switch (tree->cnid) {
> > =C2=A0=C2=A0	case HFS_CAT_CNID:
> > @@ -48,7 +48,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
> > =C2=A0 {
> > =C2=A0=C2=A0	hfs_bnode_put(fd->bnode);
> > =C2=A0=C2=A0	kfree(fd->search_key);
> > -	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
> > +	hfs_dbg("tree: CNID %d, caller %p\n",
>=20
> Ditto.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		fd->tree->cnid, __builtin_return_address(0));
> > =C2=A0=C2=A0	mutex_unlock(&fd->tree->tree_lock);
> > =C2=A0=C2=A0	fd->tree =3D NULL;
> > diff --git a/fs/hfs/bitmap.c b/fs/hfs/bitmap.c
> > index 28307bc9ec1e..fae26bd10311 100644
> > --- a/fs/hfs/bitmap.c
> > +++ b/fs/hfs/bitmap.c
> > @@ -158,7 +158,7 @@ u32 hfs_vbm_search_free(struct super_block *sb,
> > u32 goal, u32 *num_bits)
> > =C2=A0=C2=A0		}
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	hfs_dbg(BITMAP, "alloc_bits: %u,%u\n", pos, *num_bits);
> > +	hfs_dbg("RANGE: pos %u, num_bits %u\n", pos, *num_bits);
>=20
> We drop all those:
>=20
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
> -#define DBG_ATTR_MOD	0x00000080
>=20
> Not sure, why we need RANGE...

The [pos, num_bits] sounds like a range. Not?

>=20
> +	hfs_dbg("pos %u, num_bits %u\n", pos, *num_bits);
>=20
> > =C2=A0=C2=A0	HFS_SB(sb)->free_ablocks -=3D *num_bits;
> > =C2=A0=C2=A0	hfs_bitmap_dirty(sb);
> > =C2=A0 out:
> > @@ -200,7 +200,7 @@ int hfs_clear_vbm_bits(struct super_block *sb,
> > u16 start, u16 count)
> > =C2=A0=C2=A0	if (!count)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > -	hfs_dbg(BITMAP, "clear_bits: %u,%u\n", start, count);
> > +	hfs_dbg("RANGE: start %u, count %u\n", start, count);
>=20
> Ditto.

The [pos, num_bits] sounds like a range. Not?

>=20
> > =C2=A0=C2=A0	/* are all of the bits in range? */
> > =C2=A0=C2=A0	if ((start + count) > HFS_SB(sb)->fs_ablocks)
> > =C2=A0=C2=A0		return -2;
> > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > index e8cd1a31f247..b2920a1c6943 100644
> > --- a/fs/hfs/bnode.c
> > +++ b/fs/hfs/bnode.c
> > @@ -200,7 +200,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node,
> > int dst,
> > =C2=A0 {
> > =C2=A0=C2=A0	struct page *src_page, *dst_page;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src,
> > len);
> > +	hfs_dbg("copybytes: dst %u, src %u, len %u\n", dst, src,
> > len);
>=20
> remove 'copybytes:' ?

We can do this.

>=20
> > =C2=A0=C2=A0	if (!len)
> > =C2=A0=C2=A0		return;
> > =C2=A0=20
> > @@ -221,7 +221,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int
> > dst, int src, int len)
> > =C2=A0=C2=A0	struct page *page;
> > =C2=A0=C2=A0	void *ptr;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src,
> > len);
> > +	hfs_dbg("movebytes: dst %u, src %u, len %u\n", dst, src,
> > len);
>=20
> Ditto.

We can do this.

>=20
>=20
> > =C2=A0=C2=A0	if (!len)
> > =C2=A0=C2=A0		return;
> > =C2=A0=20
> > @@ -243,16 +243,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> > =C2=A0=C2=A0	__be32 cnid;
> > =C2=A0=C2=A0	int i, off, key_off;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> > +	hfs_dbg("node_id %d\n", node->this);
> > =C2=A0=C2=A0	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> > -	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> > +	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs
> > %d\n",
> > =C2=A0=C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> > =C2=A0=C2=A0		desc.type, desc.height,
> > be16_to_cpu(desc.num_recs));
> > =C2=A0=20
> > =C2=A0=C2=A0	off =3D node->tree->node_size - 2;
> > =C2=A0=C2=A0	for (i =3D be16_to_cpu(desc.num_recs); i >=3D 0; off -=3D =
2, i--
> > ) {
> > =C2=A0=C2=A0		key_off =3D hfs_bnode_read_u16(node, off);
> > -		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
> > +		hfs_dbg(" key_off %d", key_off);
> > =C2=A0=C2=A0		if (i && node->type =3D=3D HFS_NODE_INDEX) {
> > =C2=A0=C2=A0			int tmp;
> > =C2=A0=20
> > @@ -260,18 +260,18 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> > =C2=A0=C2=A0				tmp =3D (hfs_bnode_read_u8(node,
> > key_off) | 1) + 1;
> > =C2=A0=C2=A0			else
> > =C2=A0=C2=A0				tmp =3D node->tree->max_key_len + 1;
> > -			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
> > -				=C2=A0=C2=A0=C2=A0=C2=A0 tmp, hfs_bnode_read_u8(node,
> > key_off));
> > +			hfs_dbg(" (%d,%d",
> > +				tmp, hfs_bnode_read_u8(node,
> > key_off));
>=20
> Could we describe those information?

I have no idea how to change this. What is your suggestion?

>=20
> > =C2=A0=C2=A0			hfs_bnode_read(node, &cnid, key_off + tmp,
> > 4);
> > -			hfs_dbg_cont(BNODE_MOD, ",%d)",
> > be32_to_cpu(cnid));
> > +			hfs_dbg(", cnid %d)", be32_to_cpu(cnid));
> > =C2=A0=C2=A0		} else if (i && node->type =3D=3D HFS_NODE_LEAF) {
> > =C2=A0=C2=A0			int tmp;
> > =C2=A0=20
> > =C2=A0=C2=A0			tmp =3D hfs_bnode_read_u8(node, key_off);
> > -			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> > +			hfs_dbg(" (%d)", tmp);
>=20
> Ditto.

What is your suggestion?

>=20
> > =C2=A0=C2=A0		}
> > =C2=A0=C2=A0	}
> > -	hfs_dbg_cont(BNODE_MOD, "\n");
> > +	hfs_dbg("\n");
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 void hfs_bnode_unlink(struct hfs_bnode *node)
> > @@ -361,7 +361,7 @@ static struct hfs_bnode
> > *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
> > =C2=A0=C2=A0	node->this =3D cnid;
> > =C2=A0=C2=A0	set_bit(HFS_BNODE_NEW, &node->flags);
> > =C2=A0=C2=A0	atomic_set(&node->refcnt, 1);
> > -	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
> > +	hfs_dbg("cnid %d, node_id %d, refcnt 1\n",
> > =C2=A0=C2=A0		node->tree->cnid, node->this);
> > =C2=A0=C2=A0	init_waitqueue_head(&node->lock_wq);
> > =C2=A0=C2=A0	spin_lock(&tree->hash_lock);
> > @@ -401,7 +401,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct hfs_bnode **p;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
> > +	hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
> > =C2=A0=C2=A0		node->tree->cnid, node->this, atomic_read(&node-
> > >refcnt));
> > =C2=A0=C2=A0	for (p =3D &node->tree->node_hash[hfs_bnode_hash(node-
> > >this)];
> > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 *p && *p !=3D node; p =3D &(*p)->=
next_hash)
> > @@ -546,7 +546,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
> > =C2=A0 {
> > =C2=A0=C2=A0	if (node) {
> > =C2=A0=C2=A0		atomic_inc(&node->refcnt);
> > -		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
> > +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
> > =C2=A0=C2=A0			node->tree->cnid, node->this,
> > =C2=A0=C2=A0			atomic_read(&node->refcnt));
> > =C2=A0=C2=A0	}
> > @@ -559,7 +559,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
> > =C2=A0=C2=A0		struct hfs_btree *tree =3D node->tree;
> > =C2=A0=C2=A0		int i;
> > =C2=A0=20
> > -		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
> > +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
> > =C2=A0=C2=A0			node->tree->cnid, node->this,
> > =C2=A0=C2=A0			atomic_read(&node->refcnt));
> > =C2=A0=C2=A0		BUG_ON(!atomic_read(&node->refcnt));
> > diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> > index 896396554bcc..195405f0ab5c 100644
> > --- a/fs/hfs/brec.c
> > +++ b/fs/hfs/brec.c
> > @@ -94,7 +94,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, int entry_len)
> > =C2=A0=C2=A0	end_rec_off =3D tree->node_size - (node->num_recs + 1) * 2=
;
> > =C2=A0=C2=A0	end_off =3D hfs_bnode_read_u16(node, end_rec_off);
> > =C2=A0=C2=A0	end_rec_off -=3D 2;
> > -	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
> > +	hfs_dbg("RECORD: rec %d, size %d, end_off %d, end_rec_off
> > %d\n",
>=20
>=20
> We drop all those:
>=20
> -#define DBG_BNODE_REFS	0x00000001
> -#define DBG_BNODE_MOD	0x00000002
> -#define DBG_CAT_MOD	0x00000004
> -#define DBG_INODE	0x00000008
> -#define DBG_SUPER	0x00000010
> -#define DBG_EXTENT	0x00000020
> -#define DBG_BITMAP	0x00000040
> -#define DBG_ATTR_MOD	0x00000080
>=20
> Not sure, why we need RECORD...

Because, we shows record's details here. :)

>=20
> +	hfs_dbg("rec %d, size %d, end_off %d, end_rec_off %d\n",
>=20
> > =C2=A0=C2=A0		rec, size, end_off, end_rec_off);
> > =C2=A0=C2=A0	if (size > end_rec_off - end_off) {
> > =C2=A0=C2=A0		if (new_node)
> > @@ -191,7 +191,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> > =C2=A0=C2=A0		mark_inode_dirty(tree->inode);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	hfs_bnode_dump(node);
> > -	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
> > +	hfs_dbg("RECORD: rec %d, len %d\n",
>=20
> Dotto.

Because, we shows record's details here. :)

>=20
> > =C2=A0=C2=A0		fd->record, fd->keylength + fd->entrylength);
> > =C2=A0=C2=A0	if (!--node->num_recs) {
> > =C2=A0=C2=A0		hfs_bnode_unlink(node);
> > @@ -242,7 +242,7 @@ static struct hfs_bnode *hfs_bnode_split(struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0	if (IS_ERR(new_node))
> > =C2=A0=C2=A0		return new_node;
> > =C2=A0=C2=A0	hfs_bnode_get(node);
> > -	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
> > +	hfs_dbg("NODES: this %d, new %d, next %d\n",
>=20
> Dotto.

Because, we shows nodes' details here. :)

>=20
> > =C2=A0=C2=A0		node->this, new_node->this, node->next);
> > =C2=A0=C2=A0	new_node->next =3D node->next;
> > =C2=A0=C2=A0	new_node->prev =3D node->this;
> > @@ -378,7 +378,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0		newkeylen =3D (hfs_bnode_read_u8(node, 14) | 1) + 1;
> > =C2=A0=C2=A0	else
> > =C2=A0=C2=A0		fd->keylength =3D newkeylen =3D tree->max_key_len + 1;
> > -	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
> > +	hfs_dbg("RECORD: rec %d, keylength %d, newkeylen %d\n",
>=20
> Ditto.

Because, we shows record's details here. :)

>=20
> > =C2=A0=C2=A0		rec, fd->keylength, newkeylen);
> > =C2=A0=20
> > =C2=A0=C2=A0	rec_off =3D tree->node_size - (rec + 2) * 2;
> > diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> > index e86e1e235658..9f0f1372a5c3 100644
> > --- a/fs/hfs/btree.c
> > +++ b/fs/hfs/btree.c
> > @@ -364,7 +364,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
> > =C2=A0=C2=A0	u32 nidx;
> > =C2=A0=C2=A0	u8 *data, byte, m;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> > +	hfs_dbg("node_id %u\n", node->this);
>=20
> node id?

We can do this. But I don't see principal difference here.

>=20
> > =C2=A0=C2=A0	tree =3D node->tree;
> > =C2=A0=C2=A0	nidx =3D node->this;
> > =C2=A0=C2=A0	node =3D hfs_bnode_find(tree, 0);
> > diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> > index d63880e7d9d6..28f3fbf586e5 100644
> > --- a/fs/hfs/catalog.c
> > +++ b/fs/hfs/catalog.c
> > @@ -87,7 +87,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir,
> > const struct qstr *str, struct i
> > =C2=A0=C2=A0	int entry_size;
> > =C2=A0=C2=A0	int err;
> > =C2=A0=20
> > -	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
> > +	hfs_dbg("entry: name %s, cnid %u, i_nlink %d\n",
>=20
> 'entry: ' is redundant...

Maybe yes, maybe not. We show entry details here.

>=20
> +	hfs_dbg("name %s, cnid %u, i_nlink %d\n",
>=20
> > =C2=A0=C2=A0		str->name, cnid, inode->i_nlink);
> > =C2=A0=C2=A0	if (dir->i_size >=3D HFS_MAX_VALENCE)
> > =C2=A0=C2=A0		return -ENOSPC;
> > @@ -225,7 +225,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir,
> > const struct qstr *str)
> > =C2=A0=C2=A0	struct hfs_readdir_data *rd;
> > =C2=A0=C2=A0	int res, type;
> > =C2=A0=20
> > -	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name :
> > NULL, cnid);
> > +	hfs_dbg("entry: name %s, cnid %u\n", str ? str->name :
> > NULL, cnid);
>=20
> Ditto.

Maybe yes, maybe not. We show entry details here.

>=20
> > =C2=A0=C2=A0	sb =3D dir->i_sb;
> > =C2=A0=C2=A0	res =3D hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
> > =C2=A0=C2=A0	if (res)
> > @@ -294,7 +294,7 @@ int hfs_cat_move(u32 cnid, struct inode
> > *src_dir, const struct qstr *src_name,
> > =C2=A0=C2=A0	int entry_size, type;
> > =C2=A0=C2=A0	int err;
> > =C2=A0=20
> > -	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
> > +	hfs_dbg("CNID %u - entry1(ino %lu, name %s) - entry2(ino
> > %lu, name %s)\n",
>=20
> hfs_dbg("cnid %u -(ino %lu, name %s) -> (ino %lu, name %s)\n", ?
>=20
> > =C2=A0=C2=A0		cnid, src_dir->i_ino, src_name->name,
> > =C2=A0=C2=A0		dst_dir->i_ino, dst_name->name);
> > =C2=A0=C2=A0	sb =3D src_dir->i_sb;
> > diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> > index 580c62981dbd..c4d6ae796a3c 100644
> > --- a/fs/hfs/extent.c
> > +++ b/fs/hfs/extent.c
> > @@ -209,12 +209,12 @@ static void hfs_dump_extent(struct hfs_extent
> > *extent)
> > =C2=A0 {
> > =C2=A0=C2=A0	int i;
> > =C2=A0=20
> > -	hfs_dbg(EXTENT, "=C2=A0=C2=A0 ");
> > +	hfs_dbg("EXTENT:=C2=A0=C2=A0 ");
>=20
> Uppercase is kinda stange.
>=20

I don't know. It looks natural to me. :)

> +	hfs_dbg("extent:=C2=A0=C2=A0 "); ?
>=20
> > =C2=A0=C2=A0	for (i =3D 0; i < 3; i++)
> > -		hfs_dbg_cont(EXTENT, " %u:%u",
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(extent[i].block),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 be16_to_cpu(extent[i].count));
> > -	hfs_dbg_cont(EXTENT, "\n");
> > +		hfs_dbg(" block %u, count %u",
> > +			be16_to_cpu(extent[i].block),
> > +			be16_to_cpu(extent[i].count));
> > +	hfs_dbg("\n");
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int hfs_add_extent(struct hfs_extent *extent, u16 offset,
> > @@ -411,10 +411,11 @@ int hfs_extend_file(struct inode *inode)
> > =C2=A0=C2=A0		goto out;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino,
> > start, len);
> > +	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino,
> > start, len);
>=20
> ':' -> ',' ?

I used ':' here because start and len is for inode ID. But it is
possible to use ',' too.

>=20
> =C2=A0 +	hfs_dbg("ino %lu, start %u, len %u\n", inode->i_ino, start,
> len);
>=20
> > =C2=A0=C2=A0	if (HFS_I(inode)->alloc_blocks =3D=3D HFS_I(inode)-
> > >first_blocks) {
> > =C2=A0=C2=A0		if (!HFS_I(inode)->first_blocks) {
> > -			hfs_dbg(EXTENT, "first extents\n");
> > +			hfs_dbg("first_extents[0]: start %u, len
> > %u\n",
>=20
>=20
> s/first_extents[0]:/first_extents ?

We show only first extent of the array here.

>=20
> +			hfs_dbg("first_extents start %u, len %u\n",
>=20
> > +				start, len);
> > =C2=A0=C2=A0			/* no extents yet */
> > =C2=A0=C2=A0			HFS_I(inode)->first_extents[0].block =3D
> > cpu_to_be16(start);
> > =C2=A0=C2=A0			HFS_I(inode)->first_extents[0].count =3D
> > cpu_to_be16(len);
> > @@ -456,7 +457,7 @@ int hfs_extend_file(struct inode *inode)
> > =C2=A0=C2=A0	return res;
> > =C2=A0=20
> > =C2=A0 insert_extent:
> > -	hfs_dbg(EXTENT, "insert new extent\n");
> > +	hfs_dbg("insert new extent\n");
> > =C2=A0=C2=A0	res =3D hfs_ext_write_extent(inode);
> > =C2=A0=C2=A0	if (res)
> > =C2=A0=C2=A0		goto out;
> > @@ -481,7 +482,7 @@ void hfs_file_truncate(struct inode *inode)
> > =C2=A0=C2=A0	u32 size;
> > =C2=A0=C2=A0	int res;
> > =C2=A0=20
> > -	hfs_dbg(INODE, "truncate: %lu, %Lu -> %Lu\n",
> > +	hfs_dbg("ino: %lu, phys_size %llu -> i_size %llu\n",
>=20
> +	hfs_dbg("ino %lu, phys size %llu -> %llu\n",=C2=A0=C2=A0=C2=A0 ?
>=20
> > =C2=A0=C2=A0		inode->i_ino, (long long)HFS_I(inode)->phys_size,
> > =C2=A0=C2=A0		inode->i_size);
> > =C2=A0=C2=A0	if (inode->i_size > HFS_I(inode)->phys_size) {
> > diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> > index 7c5a7ecfa246..9fbdd6a86f46 100644
> > --- a/fs/hfs/hfs_fs.h
> > +++ b/fs/hfs/hfs_fs.h
> > @@ -9,12 +9,6 @@
> > =C2=A0 #ifndef _LINUX_HFS_FS_H
> > =C2=A0 #define _LINUX_HFS_FS_H
> > =C2=A0=20
> > -#ifdef pr_fmt
> > -#undef pr_fmt
> > -#endif
> > -
> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > -
> > =C2=A0 #include <linux/slab.h>
> > =C2=A0 #include <linux/types.h>
> > =C2=A0 #include <linux/mutex.h>
> > @@ -24,35 +18,10 @@
> > =C2=A0=20
> > =C2=A0 #include <asm/byteorder.h>
> > =C2=A0 #include <linux/uaccess.h>
> > +#include <linux/hfs_common.h>
>=20
> Alph sort=EF=BC=9F

It's not about alphabetical sorting. It's about dependencies of
declarations. The hfs_common.h should be after any other system related
declarations.

>=20
> #include <asm/byteorder.h>
> +#include <linux/hfs_common.h>
> #include <linux/uaccess.h>
>=20
>=20
> > =C2=A0=20
> > =C2=A0 #include "hfs.h"
> > =C2=A0=20
> > -#define DBG_BNODE_REFS	0x00000001
> > -#define DBG_BNODE_MOD	0x00000002
> > -#define DBG_CAT_MOD	0x00000004
> > -#define DBG_INODE	0x00000008
> > -#define DBG_SUPER	0x00000010
> > -#define DBG_EXTENT	0x00000020
> > -#define DBG_BITMAP	0x00000040
> > -
> > -//#define
> > DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD|DBG_CAT_MOD|DBG_BITMAP)
> > -//#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
> > -//#define
> > DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
> > -#define DBG_MASK	(0)
> > -
> > -#define hfs_dbg(flg, fmt, ...)					\
> > -do {								\
> > -	if (DBG_##flg & DBG_MASK)				\
> > -		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
> > -} while (0)
> > -
> > -#define hfs_dbg_cont(flg, fmt, ...)				\
> > -do {								\
> > -	if (DBG_##flg & DBG_MASK)				\
> > -		pr_cont(fmt, ##__VA_ARGS__);			\
> > -} while (0)
> > -
> > -
> > =C2=A0 /*
> > =C2=A0=C2=A0 * struct hfs_inode_info
> > =C2=A0=C2=A0 *
> > diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> > index bf4cb7e78396..983d537a25be 100644
> > --- a/fs/hfs/inode.c
> > +++ b/fs/hfs/inode.c
> > @@ -241,7 +241,7 @@ void hfs_delete_inode(struct inode *inode)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct super_block *sb =3D inode->i_sb;
> > =C2=A0=20
> > -	hfs_dbg(INODE, "delete_inode: %lu\n", inode->i_ino);
> > +	hfs_dbg("ino: %lu\n", inode->i_ino);
>=20
> remove ':'

We can do it.

>=20
> > =C2=A0=C2=A0	if (S_ISDIR(inode->i_mode)) {
> > =C2=A0=C2=A0		HFS_SB(sb)->folder_count--;
> > =C2=A0=C2=A0		if (HFS_I(inode)->cat_key.ParID =3D=3D
> > cpu_to_be32(HFS_ROOT_CNID))
> > @@ -425,7 +425,7 @@ int hfs_write_inode(struct inode *inode, struct
> > writeback_control *wbc)
> > =C2=A0=C2=A0	hfs_cat_rec rec;
> > =C2=A0=C2=A0	int res;
> > =C2=A0=20
> > -	hfs_dbg(INODE, "hfs_write_inode: %lu\n", inode->i_ino);
> > +	hfs_dbg("ino: %lu\n", inode->i_ino);
>=20
> Ditto.

We can do it.

>=20
> > =C2=A0=C2=A0	res =3D hfs_ext_write_extent(inode);
> > =C2=A0=C2=A0	if (res)
> > =C2=A0=C2=A0		return res;
> > diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
> > index eeebe80c6be4..914a06e48576 100644
> > --- a/fs/hfsplus/attributes.c
> > +++ b/fs/hfsplus/attributes.c
> > @@ -139,7 +139,7 @@ int hfsplus_find_attr(struct super_block *sb,
> > u32 cnid,
> > =C2=A0 {
> > =C2=A0=C2=A0	int err =3D 0;
> > =C2=A0=20
> > -	hfs_dbg(ATTR_MOD, "find_attr: %s,%d\n", name ? name :
> > NULL, cnid);
> > +	hfs_dbg("name %s, cnid %d\n", name ? name : NULL, cnid);
> > =C2=A0=20
> > =C2=A0=C2=A0	if (!HFSPLUS_SB(sb)->attr_tree) {
> > =C2=A0=C2=A0		pr_err("attributes file doesn't exist\n");
> > @@ -201,7 +201,7 @@ int hfsplus_create_attr(struct inode *inode,
> > =C2=A0=C2=A0	int entry_size;
> > =C2=A0=C2=A0	int err;
> > =C2=A0=20
> > -	hfs_dbg(ATTR_MOD, "create_attr: %s,%ld\n",
> > +	hfs_dbg("name %s, ino %ld\n",
> > =C2=A0=C2=A0		name ? name : NULL, inode->i_ino);
> > =C2=A0=20
> > =C2=A0=C2=A0	if (!HFSPLUS_SB(sb)->attr_tree) {
> > @@ -310,7 +310,7 @@ int hfsplus_delete_attr(struct inode *inode,
> > const char *name)
> > =C2=A0=C2=A0	struct super_block *sb =3D inode->i_sb;
> > =C2=A0=C2=A0	struct hfs_find_data fd;
> > =C2=A0=20
> > -	hfs_dbg(ATTR_MOD, "delete_attr: %s,%ld\n",
> > +	hfs_dbg("name %s, ino %ld\n",
> > =C2=A0=C2=A0		name ? name : NULL, inode->i_ino);
> > =C2=A0=20
> > =C2=A0=C2=A0	if (!HFSPLUS_SB(sb)->attr_tree) {
> > @@ -356,7 +356,7 @@ int hfsplus_delete_all_attrs(struct inode *dir,
> > u32 cnid)
> > =C2=A0=C2=A0	int err =3D 0;
> > =C2=A0=C2=A0	struct hfs_find_data fd;
> > =C2=A0=20
> > -	hfs_dbg(ATTR_MOD, "delete_all_attrs: %d\n", cnid);
> > +	hfs_dbg("cnid: %d\n", cnid);
>=20
> Ditto.

We can do it.

>=20
> > =C2=A0=20
> > =C2=A0=C2=A0	if (!HFSPLUS_SB(dir->i_sb)->attr_tree) {
> > =C2=A0=C2=A0		pr_err("attributes file doesn't exist\n");
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index 901e83d65d20..1fe80ced03eb 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -23,7 +23,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0		return -ENOMEM;
> > =C2=A0=C2=A0	fd->search_key =3D ptr;
> > =C2=A0=C2=A0	fd->key =3D ptr + tree->max_key_len + 2;
> > -	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> > +	hfs_dbg("CNID %d, caller %p\n",
>=20
> Ditto.

Please, see my answers above.

>=20
> +=C2=A0	hfs_dbg("cnid %d, caller %ps\n", ?
>=20
> > =C2=A0=C2=A0		tree->cnid, __builtin_return_address(0));
> > =C2=A0=C2=A0	mutex_lock_nested(&tree->tree_lock,
> > =C2=A0=C2=A0			hfsplus_btree_lock_class(tree));
> > @@ -34,7 +34,7 @@ void hfs_find_exit(struct hfs_find_data *fd)
> > =C2=A0 {
> > =C2=A0=C2=A0	hfs_bnode_put(fd->bnode);
> > =C2=A0=C2=A0	kfree(fd->search_key);
> > -	hfs_dbg(BNODE_REFS, "find_exit: %d (%p)\n",
> > +	hfs_dbg("CNID %d, caller %p\n",
>=20
> Reference to hfs.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		fd->tree->cnid, __builtin_return_address(0));
> > =C2=A0=C2=A0	mutex_unlock(&fd->tree->tree_lock);
> > =C2=A0=C2=A0	fd->tree =3D NULL;
> > diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
> > index bd8dcea85588..461dac07d3dd 100644
> > --- a/fs/hfsplus/bitmap.c
> > +++ b/fs/hfsplus/bitmap.c
> > @@ -31,7 +31,7 @@ int hfsplus_block_allocate(struct super_block
> > *sb, u32 size,
> > =C2=A0=C2=A0	if (!len)
> > =C2=A0=C2=A0		return size;
> > =C2=A0=20
> > -	hfs_dbg(BITMAP, "block_allocate: %u,%u,%u\n", size,
> > offset, len);
> > +	hfs_dbg("RANGE: size %u, offset %u, len %u\n", size,
> > offset, len);
>=20
> Reference to hfs.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	mutex_lock(&sbi->alloc_mutex);
> > =C2=A0=C2=A0	mapping =3D sbi->alloc_file->i_mapping;
> > =C2=A0=C2=A0	page =3D read_mapping_page(mapping, offset /
> > PAGE_CACHE_BITS, NULL);
> > @@ -90,14 +90,14 @@ int hfsplus_block_allocate(struct super_block
> > *sb, u32 size,
> > =C2=A0=C2=A0		else
> > =C2=A0=C2=A0			end =3D pptr + ((size + 31) &
> > (PAGE_CACHE_BITS - 1)) / 32;
> > =C2=A0=C2=A0	}
> > -	hfs_dbg(BITMAP, "bitmap full\n");
> > +	hfs_dbg("bitmap full\n");
> > =C2=A0=C2=A0	start =3D size;
> > =C2=A0=C2=A0	goto out;
> > =C2=A0=20
> > =C2=A0 found:
> > =C2=A0=C2=A0	start =3D offset + (curr - pptr) * 32 + i;
> > =C2=A0=C2=A0	if (start >=3D size) {
> > -		hfs_dbg(BITMAP, "bitmap full\n");
> > +		hfs_dbg("bitmap full\n");
> > =C2=A0=C2=A0		goto out;
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	/* do any partial u32 at the start */
> > @@ -155,7 +155,7 @@ int hfsplus_block_allocate(struct super_block
> > *sb, u32 size,
> > =C2=A0=C2=A0	*max =3D offset + (curr - pptr) * 32 + i - start;
> > =C2=A0=C2=A0	sbi->free_blocks -=3D *max;
> > =C2=A0=C2=A0	hfsplus_mark_mdb_dirty(sb);
> > -	hfs_dbg(BITMAP, "-> %u,%u\n", start, *max);
> > +	hfs_dbg("RANGE-> start %u, max %u\n", start, *max);
>=20
>=20
> 'RANGE->' is strange.

Please, see my answers above.

>=20
> > =C2=A0 out:
> > =C2=A0=C2=A0	mutex_unlock(&sbi->alloc_mutex);
> > =C2=A0=C2=A0	return start;
> > @@ -174,7 +174,7 @@ int hfsplus_block_free(struct super_block *sb,
> > u32 offset, u32 count)
> > =C2=A0=C2=A0	if (!count)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > -	hfs_dbg(BITMAP, "block_free: %u,%u\n", offset, count);
> > +	hfs_dbg("RANGE: offset %u, count %u\n", offset, count);
>=20
> remove 'RANGE: '=C2=A0=C2=A0=C2=A0 ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	/* are all of the bits in range? */
> > =C2=A0=C2=A0	if ((offset + count) > sbi->total_blocks)
> > =C2=A0=C2=A0		return -ENOENT;
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 14f4995588ff..bd0153aebeb6 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -214,7 +214,7 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node,
> > int dst,
> > =C2=A0=C2=A0	struct page **src_page, **dst_page;
> > =C2=A0=C2=A0	int l;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src,
> > len);
> > +	hfs_dbg("copybytes: dst %u, src %u, len %u\n", dst, src,
> > len);
>=20
> remove 'copybytes: ' ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	if (!len)
> > =C2=A0=C2=A0		return;
> > =C2=A0=20
> > @@ -272,7 +272,7 @@ void hfs_bnode_move(struct hfs_bnode *node, int
> > dst, int src, int len)
> > =C2=A0=C2=A0	void *src_ptr, *dst_ptr;
> > =C2=A0=C2=A0	int l;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src,
> > len);
> > +	hfs_dbg("movebytes: dst %u, src %u, len %u\n", dst, src,
> > len);
>=20
> Ditto.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	if (!len)
> > =C2=A0=C2=A0		return;
> > =C2=A0=20
> > @@ -392,16 +392,16 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> > =C2=A0=C2=A0	__be32 cnid;
> > =C2=A0=C2=A0	int i, off, key_off;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> > +	hfs_dbg("node_id %d\n", node->this);
> > =C2=A0=C2=A0	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> > -	hfs_dbg(BNODE_MOD, "%d, %d, %d, %d, %d\n",
> > +	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs
> > %d\n",
> > =C2=A0=C2=A0		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
> > =C2=A0=C2=A0		desc.type, desc.height,
> > be16_to_cpu(desc.num_recs));
> > =C2=A0=20
> > =C2=A0=C2=A0	off =3D node->tree->node_size - 2;
> > =C2=A0=C2=A0	for (i =3D be16_to_cpu(desc.num_recs); i >=3D 0; off -=3D =
2, i--
> > ) {
> > =C2=A0=C2=A0		key_off =3D hfs_bnode_read_u16(node, off);
> > -		hfs_dbg(BNODE_MOD, " %d", key_off);
> > +		hfs_dbg(" key_off %d", key_off);
> > =C2=A0=C2=A0		if (i && node->type =3D=3D HFS_NODE_INDEX) {
> > =C2=A0=C2=A0			int tmp;
> > =C2=A0=20
> > @@ -410,17 +410,17 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> > =C2=A0=C2=A0				tmp =3D hfs_bnode_read_u16(node,
> > key_off) + 2;
> > =C2=A0=C2=A0			else
> > =C2=A0=C2=A0				tmp =3D node->tree->max_key_len + 2;
> > -			hfs_dbg_cont(BNODE_MOD, " (%d", tmp);
> > +			hfs_dbg(" (%d", tmp);
>=20
> Could we describe those info ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0			hfs_bnode_read(node, &cnid, key_off + tmp,
> > 4);
> > -			hfs_dbg_cont(BNODE_MOD, ",%d)",
> > be32_to_cpu(cnid));
> > +			hfs_dbg(", cnid %d)", be32_to_cpu(cnid));
> > =C2=A0=C2=A0		} else if (i && node->type =3D=3D HFS_NODE_LEAF) {
> > =C2=A0=C2=A0			int tmp;
> > =C2=A0=20
> > =C2=A0=C2=A0			tmp =3D hfs_bnode_read_u16(node, key_off);
> > -			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> > +			hfs_dbg(" (%d)", tmp);
> > =C2=A0=C2=A0		}
> > =C2=A0=C2=A0	}
> > -	hfs_dbg_cont(BNODE_MOD, "\n");
> > +	hfs_dbg("\n");
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 void hfs_bnode_unlink(struct hfs_bnode *node)
> > @@ -456,7 +456,7 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
> > =C2=A0=20
> > =C2=A0=C2=A0	/* move down? */
> > =C2=A0=C2=A0	if (!node->prev && !node->next)
> > -		hfs_dbg(BNODE_MOD, "hfs_btree_del_level\n");
> > +		hfs_dbg("btree delete level\n");
> > =C2=A0=C2=A0	if (!node->parent) {
> > =C2=A0=C2=A0		tree->root =3D 0;
> > =C2=A0=C2=A0		tree->depth =3D 0;
> > @@ -511,7 +511,7 @@ static struct hfs_bnode
> > *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
> > =C2=A0=C2=A0	node->this =3D cnid;
> > =C2=A0=C2=A0	set_bit(HFS_BNODE_NEW, &node->flags);
> > =C2=A0=C2=A0	atomic_set(&node->refcnt, 1);
> > -	hfs_dbg(BNODE_REFS, "new_node(%d:%d): 1\n",
> > +	hfs_dbg("cnid%d, node_id %d, refcnt 1\n",
>=20
>=20
> add white space?

Yes, we can do it.

>=20
> > =C2=A0=C2=A0		node->tree->cnid, node->this);
> > =C2=A0=C2=A0	init_waitqueue_head(&node->lock_wq);
> > =C2=A0=C2=A0	spin_lock(&tree->hash_lock);
> > @@ -551,7 +551,7 @@ void hfs_bnode_unhash(struct hfs_bnode *node)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct hfs_bnode **p;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_REFS, "remove_node(%d:%d): %d\n",
> > +	hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
> > =C2=A0=C2=A0		node->tree->cnid, node->this, atomic_read(&node-
> > >refcnt));
> > =C2=A0=C2=A0	for (p =3D &node->tree->node_hash[hfs_bnode_hash(node-
> > >this)];
> > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 *p && *p !=3D node; p =3D &(*p)->=
next_hash)
> > @@ -697,7 +697,7 @@ void hfs_bnode_get(struct hfs_bnode *node)
> > =C2=A0 {
> > =C2=A0=C2=A0	if (node) {
> > =C2=A0=C2=A0		atomic_inc(&node->refcnt);
> > -		hfs_dbg(BNODE_REFS, "get_node(%d:%d): %d\n",
> > +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
> > =C2=A0=C2=A0			node->tree->cnid, node->this,
> > =C2=A0=C2=A0			atomic_read(&node->refcnt));
> > =C2=A0=C2=A0	}
> > @@ -710,7 +710,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
> > =C2=A0=C2=A0		struct hfs_btree *tree =3D node->tree;
> > =C2=A0=C2=A0		int i;
> > =C2=A0=20
> > -		hfs_dbg(BNODE_REFS, "put_node(%d:%d): %d\n",
> > +		hfs_dbg("cnid %d, node_id %d, refcnt %d\n",
> > =C2=A0=C2=A0			node->tree->cnid, node->this,
> > =C2=A0=C2=A0			atomic_read(&node->refcnt));
> > =C2=A0=C2=A0		BUG_ON(!atomic_read(&node->refcnt));
> > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > index 1918544a7871..81683eee28c8 100644
> > --- a/fs/hfsplus/brec.c
> > +++ b/fs/hfsplus/brec.c
> > @@ -92,7 +92,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, int entry_len)
> > =C2=A0=C2=A0	end_rec_off =3D tree->node_size - (node->num_recs + 1) * 2=
;
> > =C2=A0=C2=A0	end_off =3D hfs_bnode_read_u16(node, end_rec_off);
> > =C2=A0=C2=A0	end_rec_off -=3D 2;
> > -	hfs_dbg(BNODE_MOD, "insert_rec: %d, %d, %d, %d\n",
> > +	hfs_dbg("RECORD: rec %d, size %d, end_off %d, end_rec_off
> > %d\n",
>=20
> remove 'RECORD: '?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		rec, size, end_off, end_rec_off);
> > =C2=A0=C2=A0	if (size > end_rec_off - end_off) {
> > =C2=A0=C2=A0		if (new_node)
> > @@ -193,7 +193,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
> > =C2=A0=C2=A0		mark_inode_dirty(tree->inode);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	hfs_bnode_dump(node);
> > -	hfs_dbg(BNODE_MOD, "remove_rec: %d, %d\n",
> > +	hfs_dbg("RECORD: rec %d, len %d\n",
>=20
>=20
> Ditto.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		fd->record, fd->keylength + fd->entrylength);
> > =C2=A0=C2=A0	if (!--node->num_recs) {
> > =C2=A0=C2=A0		hfs_bnode_unlink(node);
> > @@ -246,7 +246,7 @@ static struct hfs_bnode *hfs_bnode_split(struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0	if (IS_ERR(new_node))
> > =C2=A0=C2=A0		return new_node;
> > =C2=A0=C2=A0	hfs_bnode_get(node);
> > -	hfs_dbg(BNODE_MOD, "split_nodes: %d - %d - %d\n",
> > +	hfs_dbg("bnodes: this %d - new %d - next %d\n",
>=20
> remove 'bnodes: ' ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		node->this, new_node->this, node->next);
> > =C2=A0=C2=A0	new_node->next =3D node->next;
> > =C2=A0=C2=A0	new_node->prev =3D node->this;
> > @@ -383,7 +383,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0		newkeylen =3D hfs_bnode_read_u16(node, 14) + 2;
> > =C2=A0=C2=A0	else
> > =C2=A0=C2=A0		fd->keylength =3D newkeylen =3D tree->max_key_len + 2;
> > -	hfs_dbg(BNODE_MOD, "update_rec: %d, %d, %d\n",
> > +	hfs_dbg("RECORD: rec %d, keylength %d, newkeylen %d\n",
>=20
>=20
> remove 'RECORD: ' ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		rec, fd->keylength, newkeylen);
> > =C2=A0=20
> > =C2=A0=C2=A0	rec_off =3D tree->node_size - (rec + 2) * 2;
> > @@ -395,7 +395,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> > =C2=A0=C2=A0		end_off =3D hfs_bnode_read_u16(parent, end_rec_off);
> > =C2=A0=C2=A0		if (end_rec_off - end_off < diff) {
> > =C2=A0=20
> > -			hfs_dbg(BNODE_MOD, "splitting index
> > node\n");
> > +			hfs_dbg("splitting index node\n");
> > =C2=A0=C2=A0			fd->bnode =3D parent;
> > =C2=A0=C2=A0			new_node =3D hfs_bnode_split(fd);
> > =C2=A0=C2=A0			if (IS_ERR(new_node))
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 9e1732a2b92a..0583206cde80 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -428,7 +428,7 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> > hfs_btree *tree)
> > =C2=A0=C2=A0		kunmap_local(data);
> > =C2=A0=C2=A0		nidx =3D node->next;
> > =C2=A0=C2=A0		if (!nidx) {
> > -			hfs_dbg(BNODE_MOD, "create new bmap
> > node\n");
> > +			hfs_dbg("create new bmap node\n");
> > =C2=A0=C2=A0			next_node =3D hfs_bmap_new_bmap(node, idx);
> > =C2=A0=C2=A0		} else
> > =C2=A0=C2=A0			next_node =3D hfs_bnode_find(tree, nidx);
> > @@ -454,7 +454,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
> > =C2=A0=C2=A0	u32 nidx;
> > =C2=A0=C2=A0	u8 *data, byte, m;
> > =C2=A0=20
> > -	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> > +	hfs_dbg("node_id %u\n", node->this);
>=20
> node id?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	BUG_ON(!node->this);
> > =C2=A0=C2=A0	tree =3D node->tree;
> > =C2=A0=C2=A0	nidx =3D node->this;
> > diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> > index 1995bafee839..38ecde83bcea 100644
> > --- a/fs/hfsplus/catalog.c
> > +++ b/fs/hfsplus/catalog.c
> > @@ -259,7 +259,7 @@ int hfsplus_create_cat(u32 cnid, struct inode
> > *dir,
> > =C2=A0=C2=A0	int entry_size;
> > =C2=A0=C2=A0	int err;
> > =C2=A0=20
> > -	hfs_dbg(CAT_MOD, "create_cat: %s,%u(%d)\n",
> > +	hfs_dbg("entry: name %s, cnid %u, i_nlink %d\n",
>=20
> remove 'entry: ' ?

Please, see my answers above.

>=20
>=20
> > =C2=A0=C2=A0		str->name, cnid, inode->i_nlink);
> > =C2=A0=C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> > =C2=A0=C2=A0	if (err)
> > @@ -336,7 +336,7 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> > *dir, const struct qstr *str)
> > =C2=A0=C2=A0	int err, off;
> > =C2=A0=C2=A0	u16 type;
> > =C2=A0=20
> > -	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name :
> > NULL, cnid);
> > +	hfs_dbg("entry: name %s, cnid %u\n", str ? str->name :
> > NULL, cnid);
>=20
> Ditto.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> > =C2=A0=C2=A0	if (err)
> > =C2=A0=C2=A0		return err;
> > @@ -441,7 +441,7 @@ int hfsplus_rename_cat(u32 cnid,
> > =C2=A0=C2=A0	int entry_size, type;
> > =C2=A0=C2=A0	int err;
> > =C2=A0=20
> > -	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
> > +	hfs_dbg("entry: cnid %u - ino %lu, name %s - ino %lu, name
> > %s\n",
>=20
> Ditto.

Please, see my answers above.

>=20
> > =C2=A0=C2=A0		cnid, src_dir->i_ino, src_name->name,
> > =C2=A0=C2=A0		dst_dir->i_ino, dst_name->name);
> > =C2=A0=C2=A0	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &src_fd);
> > diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> > index b1699b3c246a..b22b328113e6 100644
> > --- a/fs/hfsplus/extents.c
> > +++ b/fs/hfsplus/extents.c
> > @@ -275,7 +275,7 @@ int hfsplus_get_block(struct inode *inode,
> > sector_t iblock,
> > =C2=A0=C2=A0	mutex_unlock(&hip->extents_lock);
> > =C2=A0=20
> > =C2=A0 done:
> > -	hfs_dbg(EXTENT, "get_block(%lu): %llu - %u\n",
> > +	hfs_dbg("ino(%lu): iblock %llu - dblock %u\n",
>=20
> =C2=A0> +	hfs_dbg("ino %lu, iblock %llu - dblock %u\n", ?
>=20
> > =C2=A0=C2=A0		inode->i_ino, (long long)iblock, dblock);
> > =C2=A0=20
> > =C2=A0=C2=A0	mask =3D (1 << sbi->fs_shift) - 1;
> > @@ -298,12 +298,12 @@ static void hfsplus_dump_extent(struct
> > hfsplus_extent *extent)
> > =C2=A0 {
> > =C2=A0=C2=A0	int i;
> > =C2=A0=20
> > -	hfs_dbg(EXTENT, "=C2=A0=C2=A0 ");
> > +	hfs_dbg("EXTENT=C2=A0=C2=A0 ");
>=20
> extent: ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0	for (i =3D 0; i < 8; i++)
> > -		hfs_dbg_cont(EXTENT, " %u:%u",
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 be32_to_cpu(extent[i].start_block),
> > -			=C2=A0=C2=A0=C2=A0=C2=A0 be32_to_cpu(extent[i].block_count));
> > -	hfs_dbg_cont(EXTENT, "\n");
> > +		hfs_dbg(" start_block %u, block_count%u",
> > +			be32_to_cpu(extent[i].start_block),
> > +			be32_to_cpu(extent[i].block_count));
> > +	hfs_dbg("\n");
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int hfsplus_add_extent(struct hfsplus_extent *extent, u32
> > offset,
> > @@ -360,7 +360,7 @@ static int hfsplus_free_extents(struct
> > super_block *sb,
> > =C2=A0=C2=A0			err =3D hfsplus_block_free(sb, start,
> > count);
> > =C2=A0=C2=A0			if (err) {
> > =C2=A0=C2=A0				pr_err("can't free extent\n");
> > -				hfs_dbg(EXTENT, " start: %u count:
> > %u\n",
> > +				hfs_dbg("EXTENT: start: %u count:
> > %u\n",
>=20
>=20
> convert to pr_err ?

Probably, makes sense.

>=20
> > =C2=A0=C2=A0					start, count);
> > =C2=A0=C2=A0			}
> > =C2=A0=C2=A0			extent->block_count =3D 0;
> > @@ -371,7 +371,7 @@ static int hfsplus_free_extents(struct
> > super_block *sb,
> > =C2=A0=C2=A0			err =3D hfsplus_block_free(sb, start +
> > count, block_nr);
> > =C2=A0=C2=A0			if (err) {
> > =C2=A0=C2=A0				pr_err("can't free extent\n");
> > -				hfs_dbg(EXTENT, " start: %u count:
> > %u\n",
> > +				hfs_dbg("EXTENT: start: %u count:
> > %u\n",
>=20
> remove 'EXTENT:' ?

Please, see my answers above.

>=20
> > =C2=A0=C2=A0					start, count);
> > =C2=A0=C2=A0			}
> > =C2=A0=C2=A0			extent->block_count =3D cpu_to_be32(count);
> > @@ -478,11 +478,12 @@ int hfsplus_file_extend(struct inode *inode,
> > bool zeroout)
> > =C2=A0=C2=A0			goto out;
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	hfs_dbg(EXTENT, "extend %lu: %u,%u\n", inode->i_ino,
> > start, len);
> > +	hfs_dbg("ino %lu: start %u, len %u\n", inode->i_ino,
> > start, len);
>=20
> s/:/,=C2=A0=C2=A0=C2=A0 ?

Please, see my answers above.

>=20
> > =C2=A0=20
> > =C2=A0=C2=A0	if (hip->alloc_blocks <=3D hip->first_blocks) {
> > =C2=A0=C2=A0		if (!hip->first_blocks) {
> > -			hfs_dbg(EXTENT, "first extents\n");
> > +			hfs_dbg("first_extents[0]: start %u, len
> > %u\n",
> > +				start, len);
> > =C2=A0=C2=A0			/* no extents yet */
> > =C2=A0=C2=A0			hip->first_extents[0].start_block =3D
> > cpu_to_be32(start);
> > =C2=A0=C2=A0			hip->first_extents[0].block_count =3D
> > cpu_to_be32(len);
> > @@ -521,7 +522,7 @@ int hfsplus_file_extend(struct inode *inode,
> > bool zeroout)
> > =C2=A0=C2=A0	return res;
> > =C2=A0=20
> > =C2=A0 insert_extent:
> > -	hfs_dbg(EXTENT, "insert new extent\n");
> > +	hfs_dbg("insert new extent\n");
> > =C2=A0=C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> > =C2=A0=C2=A0	if (res)
> > =C2=A0=C2=A0		goto out;
> > @@ -546,7 +547,7 @@ void hfsplus_file_truncate(struct inode *inode)
> > =C2=A0=C2=A0	u32 alloc_cnt, blk_cnt, start;
> > =C2=A0=C2=A0	int res;
> > =C2=A0=20
> > -	hfs_dbg(INODE, "truncate: %lu, %llu -> %llu\n",
> > +	hfs_dbg("ino: %lu, phys_size %llu -> i_size %llu\n",
>=20
> =C2=A0> +	hfs_dbg("ino %lu, phys size %llu -> %llu\n",
>=20
> > =C2=A0=C2=A0		inode->i_ino, (long long)hip->phys_size, inode-
> > >i_size);
> > =C2=A0=20
> > =C2=A0=C2=A0	if (inode->i_size > hip->phys_size) {
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index 96a5c24813dd..34039e2d5417 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -11,47 +11,14 @@
> > =C2=A0 #ifndef _LINUX_HFSPLUS_FS_H
> > =C2=A0 #define _LINUX_HFSPLUS_FS_H
> > =C2=A0=20
> > -#ifdef pr_fmt
> > -#undef pr_fmt
> > -#endif
> > -
> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > -
> > =C2=A0 #include <linux/fs.h>
> > =C2=A0 #include <linux/mutex.h>
> > =C2=A0 #include <linux/buffer_head.h>
> > =C2=A0 #include <linux/blkdev.h>
> > =C2=A0 #include <linux/fs_context.h>
> > +#include <linux/hfs_common.h>
> > =C2=A0 #include "hfsplus_raw.h"
> > =C2=A0=20
> > -#define DBG_BNODE_REFS	0x00000001
> > -#define DBG_BNODE_MOD	0x00000002
> > -#define DBG_CAT_MOD	0x00000004
> > -#define DBG_INODE	0x00000008
> > -#define DBG_SUPER	0x00000010
> > -#define DBG_EXTENT	0x00000020
> > -#define DBG_BITMAP	0x00000040
> > -#define DBG_ATTR_MOD	0x00000080
> > -
> > -#if 0
> > -#define DBG_MASK	(DBG_EXTENT|DBG_INODE|DBG_BNODE_MOD)
> > -#define DBG_MASK	(DBG_BNODE_MOD|DBG_CAT_MOD|DBG_INODE)
> > -#define
> > DBG_MASK	(DBG_CAT_MOD|DBG_BNODE_REFS|DBG_INODE|DBG_EXTENT)
> > -#endif
> > -#define DBG_MASK	(0)
> > -
> > -#define hfs_dbg(flg, fmt, ...)					\
> > -do {								\
> > -	if (DBG_##flg & DBG_MASK)				\
> > -		printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
> > -} while (0)
> > -
> > -#define hfs_dbg_cont(flg, fmt, ...)				\
> > -do {								\
> > -	if (DBG_##flg & DBG_MASK)				\
> > -		pr_cont(fmt, ##__VA_ARGS__);			\
> > -} while (0)
> > -
> > =C2=A0 /* Runtime config options */
> > =C2=A0 #define HFSPLUS_DEF_CR_TYPE=C2=A0=C2=A0=C2=A0 0x3F3F3F3F=C2=A0 /=
* '????' */
> > =C2=A0=20
> > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > index 86351bdc8985..403feb3d7411 100644
> > --- a/fs/hfsplus/super.c
> > +++ b/fs/hfsplus/super.c
> > @@ -150,7 +150,7 @@ static int hfsplus_write_inode(struct inode
> > *inode,
> > =C2=A0 {
> > =C2=A0=C2=A0	int err;
> > =C2=A0=20
> > -	hfs_dbg(INODE, "hfsplus_write_inode: %lu\n", inode-
> > >i_ino);
> > +	hfs_dbg("ino: %lu\n", inode->i_ino);
>=20
> =C2=A0 +	hfs_dbg("ino %lu\n", inode->i_ino);=C2=A0=C2=A0=C2=A0=C2=A0 ?
>=20
> > =C2=A0=20
> > =C2=A0=C2=A0	err =3D hfsplus_ext_write_extent(inode);
> > =C2=A0=C2=A0	if (err)
> > @@ -165,7 +165,7 @@ static int hfsplus_write_inode(struct inode
> > *inode,
> > =C2=A0=20
> > =C2=A0 static void hfsplus_evict_inode(struct inode *inode)
> > =C2=A0 {
> > -	hfs_dbg(INODE, "hfsplus_evict_inode: %lu\n", inode-
> > >i_ino);
> > +	hfs_dbg("ino: %lu\n", inode->i_ino);
>=20
> Ditto.

Please, see my answers above.

Thanks,
Slava.

>=20
> > =C2=A0=C2=A0	truncate_inode_pages_final(&inode->i_data);
> > =C2=A0=C2=A0	clear_inode(inode);
> > =C2=A0=C2=A0	if (HFSPLUS_IS_RSRC(inode)) {
> > @@ -184,7 +184,7 @@ static int hfsplus_sync_fs(struct super_block
> > *sb, int wait)
> > =C2=A0=C2=A0	if (!wait)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > -	hfs_dbg(SUPER, "hfsplus_sync_fs\n");
> > +	hfs_dbg("starting...\n");
> > =C2=A0=20
> > =C2=A0=C2=A0	/*
> > =C2=A0=C2=A0	 * Explicitly write out the special metadata inodes.
> > @@ -215,6 +215,11 @@ static int hfsplus_sync_fs(struct super_block
> > *sb, int wait)
> > =C2=A0=C2=A0	vhdr->folder_count =3D cpu_to_be32(sbi->folder_count);
> > =C2=A0=C2=A0	vhdr->file_count =3D cpu_to_be32(sbi->file_count);
> > =C2=A0=20
> > +	hfs_dbg("free_blocks %u, next_cnid %u, "
> > +		"folder_count %u, file_count %u\n",
> > +		sbi->free_blocks, sbi->next_cnid,
> > +		sbi->folder_count, sbi->file_count);
> > +
> > =C2=A0=C2=A0	if (test_and_clear_bit(HFSPLUS_SB_WRITEBACKUP, &sbi-
> > >flags)) {
> > =C2=A0=C2=A0		memcpy(sbi->s_backup_vhdr, sbi->s_vhdr,
> > sizeof(*sbi->s_vhdr));
> > =C2=A0=C2=A0		write_backup =3D 1;
> > @@ -240,6 +245,8 @@ static int hfsplus_sync_fs(struct super_block
> > *sb, int wait)
> > =C2=A0=C2=A0	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
> > =C2=A0=C2=A0		blkdev_issue_flush(sb->s_bdev);
> > =C2=A0=20
> > +	hfs_dbg("finished: err %d\n", error);
>=20
> =C2=A0 +	hfs_dbg("finished=C2=A0 err %d\n", error);=C2=A0=C2=A0=C2=A0 ?
>=20
> > +
> > =C2=A0=C2=A0	return error;
> > =C2=A0 }
> > =C2=A0=20
> > @@ -288,7 +295,7 @@ static void hfsplus_put_super(struct
> > super_block *sb)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> > =C2=A0=20
> > -	hfs_dbg(SUPER, "hfsplus_put_super\n");
> > +	hfs_dbg("starting...\n");
> > =C2=A0=20
> > =C2=A0=C2=A0	cancel_delayed_work_sync(&sbi->sync_work);
> > =C2=A0=20
> > @@ -310,6 +317,8 @@ static void hfsplus_put_super(struct
> > super_block *sb)
> > =C2=A0=C2=A0	kfree(sbi->s_vhdr_buf);
> > =C2=A0=C2=A0	kfree(sbi->s_backup_vhdr_buf);
> > =C2=A0=C2=A0	call_rcu(&sbi->rcu, delayed_free);
> > +
> > +	hfs_dbg("finished\n");
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static int hfsplus_statfs(struct dentry *dentry, struct kstatfs
> > *buf)
> > diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> > index 18dc3d254d21..f34404798025 100644
> > --- a/fs/hfsplus/xattr.c
> > +++ b/fs/hfsplus/xattr.c
> > @@ -64,7 +64,7 @@ static void hfsplus_init_header_node(struct inode
> > *attr_file,
> > =C2=A0=C2=A0	u32 used_bmp_bytes;
> > =C2=A0=C2=A0	u64 tmp;
> > =C2=A0=20
> > -	hfs_dbg(ATTR_MOD, "init_hdr_attr_file: clump %u, node_size
> > %u\n",
> > +	hfs_dbg("clump %u, node_size %u\n",
> > =C2=A0=C2=A0		clump_size, node_size);
> > =C2=A0=20
> > =C2=A0=C2=A0	/* The end of the node contains list of record offsets */
> > @@ -132,7 +132,7 @@ static int
> > hfsplus_create_attributes_file(struct super_block *sb)
> > =C2=A0=C2=A0	struct page *page;
> > =C2=A0=C2=A0	int old_state =3D HFSPLUS_EMPTY_ATTR_TREE;
> > =C2=A0=20
> > -	hfs_dbg(ATTR_MOD, "create_attr_file: ino %d\n",
> > HFSPLUS_ATTR_CNID);
> > +	hfs_dbg("ino %d\n", HFSPLUS_ATTR_CNID);
> > =C2=A0=20
> > =C2=A0 check_attr_tree_state_again:
> > =C2=A0=C2=A0	switch (atomic_read(&sbi->attr_tree_state)) {
> > diff --git a/include/linux/hfs_common.h
> > b/include/linux/hfs_common.h
> > new file mode 100644
> > index 000000000000..8838ca2f3d08
> > --- /dev/null
> > +++ b/include/linux/hfs_common.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * HFS/HFS+ common definitions, inline functions,
> > + * and shared functionality.
> > + */
> > +
> > +#ifndef _HFS_COMMON_H_
> > +#define _HFS_COMMON_H_
> > +
> > +#ifdef pr_fmt
> > +#undef pr_fmt
> > +#endif
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#define hfs_dbg(fmt,
> > ...)							\
> > +	pr_debug("pid %d:%s:%d %s(): "
> > fmt,					\
> > +		 current->pid, __FILE__, __LINE__, __func__,
> > ##__VA_ARGS__)	\
> > +
> > +#endif /* _HFS_COMMON_H_ */
>=20
> Thx,
> Yangtao

