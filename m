Return-Path: <linux-fsdevel+bounces-16226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B189A4D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1501C21444
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18210173321;
	Fri,  5 Apr 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="j1og25Xo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A1172BC8
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345072; cv=none; b=oquHHAETvl8Iy7jAOiAJGZxyZLmq37EPxxdbkAEM24uoJOmNfV0zN/vgm/V+n/9deJlNivM9910R9krRwQZ99BPYg+9MJtujGA0oN67KmPRH6gWbJ681zDDSB2/mteo+ZTu/HnYnn2afbiEWMjPNlgXxX7IV6BuGip/vTixcThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345072; c=relaxed/simple;
	bh=mEICjIS/Xm1y/adtTOt4oAM6pGc6Ltt0L3kruWttndY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=K57xZRJonzCeBRoEhePYS4cvQp2g1qh+r+TKEeMpcDOOsYISY/9VT8Irtzr8dVxTPdsAMus+bMrAil4kAp/JplAStCbI+96azZTm9eihmPFAT3LsXu3nAxa/BiijEptPJA8bmmARH3GIusa+WhvugXNr7JkwVcw1Av8RlCtfMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=j1og25Xo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecff9df447so1122612b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712345069; x=1712949869; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+9PtxohNn5GLyNZPhR1TRelne4uxW9tVbigzA0Hv9E=;
        b=j1og25Xodeh2U61879zqsSgDKsqz9mkJ6Fy4ZiEP/0JfRQOpwWq2BDmvPKvMmZqOv8
         Eoi3xb3nkA+c2J6JCp0O4sx9mnVGe6vjaxwcUm/RkF0u8dtUqyH+qEl8VH2U5F+OsY1w
         lWaJuFsVhtWqEj2VQHceIrnpoSzoraw9BQCRcMMzp9zBSP6Dk6dqGwIbkpFNDOTiWtPh
         wZpkuJFt45E0Gui2Za26smu55yH2HfD41uIbL1mNkf4qQaPOrBNyDYDwPIUnQ8iwniZ/
         nUsRu3NQprpW5sQoQfsPmi1rSb89ENpn1YzCwgDWxYFVtzf5Q89auV+34Tiff2wXWwWS
         0/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712345069; x=1712949869;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+9PtxohNn5GLyNZPhR1TRelne4uxW9tVbigzA0Hv9E=;
        b=fuQG3XTQnjjfKeXs4u18YiwpR3/iB3fTtloG42rcB5zLAFi3GiVAV2B+q8N3Du7nTZ
         BN8F/0layRZYegvL2Sb4LVSyAKYqB5zXKOt2trQbTgp1Rx+vuhTO3/VtzZ7W+ERCqkDn
         eKUKtjYIwBiN+MKmSK1nF6Y2Nm6YP9DRqLuFHOGrc4R8Tt0VC5Zyc5baH1Npw7JK6TPv
         t+eDlv4KMTo295XG1JuuXzYFygpgOverT/yZdxibmFUvUeWcyM4mwX7zG4u5rEsYJ3lC
         C1cJYPu2QiGcKzTib1FkyDW+L+ThWSD31Jq96E9LQtJDDxZOVQS3I0ctIC/8ELzung/Z
         hQhg==
X-Forwarded-Encrypted: i=1; AJvYcCWFi8uCzXulo7OE9PRb/gGVmiYqlAX22KT5gomF9eOsCrQ7k2OEdsM37kOdz2vCcL3dsTG3wBFkKHOjxGM4DLvMqj2sq5VHbipyyI4JFw==
X-Gm-Message-State: AOJu0Ywsx7r669y6P+Pke31H6UZXGS2TaI0HwO3hKQmTLPW2ZqA/gGpF
	IBF9g8UCgpNzQoWr6HdZ93lrmQY8eD+bXDtCjpoAQqJ/Q0BroVoRHqKRtZywSIc=
X-Google-Smtp-Source: AGHT+IHcY4t8f7Jv7XhoB88+cn6keDKBvN0wZ7yOTJw8SS3n/nX7rvkSTIIW/LwD2Rc2EvKdk2G7Hw==
X-Received: by 2002:a05:6a20:dc95:b0:1a3:703c:c7d5 with SMTP id ky21-20020a056a20dc9500b001a3703cc7d5mr2194747pzb.34.1712345069022;
        Fri, 05 Apr 2024 12:24:29 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id fj8-20020a056a003a0800b006ea8af1569asm1872700pfb.73.2024.04.05.12.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:24:28 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <CBF9FEA5-0FD4-44BE-A2DC-54B7E5D1A874@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_23208463-7A57-4687-8755-FF47195EDFA6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 06/13] nilfs2: fiemap: return correct extent physical
 length
Date: Fri, 5 Apr 2024 13:26:37 -0600
In-Reply-To: <bd06389b4c9c33ab1411f2941875f02867b18642.1712126039.git.sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <bd06389b4c9c33ab1411f2941875f02867b18642.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_23208463-7A57-4687-8755-FF47195EDFA6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> fs/nilfs2/inode.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 4d3c347c982b..e3108f2cead7 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1160,7 +1160,7 @@ int nilfs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> {
> 	struct the_nilfs *nilfs =3D inode->i_sb->s_fs_info;
> 	__u64 logical =3D 0, phys =3D 0, size =3D 0;
> -	__u32 flags =3D 0;
> +	__u32 flags =3D FIEMAP_EXTENT_HAS_PHYS_LEN;
>=20
> 	loff_t isize;
> 	sector_t blkoff, end_blkoff;
> 	sector_t delalloc_blkoff;
> @@ -1197,7 +1197,9 @@ int nilfs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 			if (blkoff > end_blkoff)
> 				break;
>=20
> -			flags =3D FIEMAP_EXTENT_MERGED | =
FIEMAP_EXTENT_DELALLOC;
> +			flags =3D FIEMAP_EXTENT_MERGED |
> +				FIEMAP_EXTENT_DELALLOC |
> +				FIEMAP_EXTENT_HAS_PHYS_LEN;

IMHO, rather than setting "flags =3D FIEMAP..." here, it would be better =
to
initialize "flags |=3D FIEMAP_HAS_PHYS_LEN" right after =
fiemap_fill_next_extent()
is called, and use "flags |=3D FIEMAP_EXTENT_MERGED | =
FIEMAP_EXTENT_DELALLOC" here.

That makes it more clear that MERGED|DELALLOC are "add-on" flags beyond =
the
base flags, and if more flags are added in the future (e.g. COMPRESSED) =
then
the flag management will be simpler (more on this below).

> @@ -1261,14 +1263,16 @@ int nilfs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> 						break;
>=20
> 					/* Start another extent */
> -					flags =3D FIEMAP_EXTENT_MERGED;
> +					flags =3D FIEMAP_EXTENT_MERGED |
> +						=
FIEMAP_EXTENT_HAS_PHYS_LEN;

Strictly speaking, this new extent should not have FIEMAP_EXTENT_MERGED =
set,
and start out with only FIEMAP_EXTENT_HAS_PHYS_LEN, since it has not =
actually
been merged with anything.

> 					logical =3D blkoff << blkbits;
> 					phys =3D blkphy << blkbits;
> 					size =3D n << blkbits;
> 				}
> 			} else {
> 				/* Start a new extent */
> -				flags =3D FIEMAP_EXTENT_MERGED;
> +				flags =3D FIEMAP_EXTENT_MERGED |
> +					FIEMAP_EXTENT_HAS_PHYS_LEN;

Then this should be "flags |=3D FIEMAP_EXTENT_MERGED" only once a second
block has been merged into the prior one.

Cheers, Andreas






--Apple-Mail=_23208463-7A57-4687-8755-FF47195EDFA6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQUG0ACgkQcqXauRfM
H+DusBAAjLzaPC76LsfW44HKtdh7+jVJ1aHtau12SOTY37rSSphdiw/F9U6SbJ4b
PwbKUBwhMzFgGjXhyUE8AX8z7CmrggtnVzeRgw8ad+1O6HfDU6ibC1w04XREKgdZ
yVFCaBcijZA3b8POL+pTCS+URpbfc355WbiS1ioIiIa+1KLoBqe83dqfO9PVuS5V
BGUZh1pnUhpVxJOxppQ36NgweFjuEDvG32BpN9+NEZiQFrAj2GHP/QijiQTvNoPd
7noTlgPq8zcbGPPI6HTpVyBz3ZWxYmVQ5ImDZlAOUM4WLUoyVPbUjffKC1Y66ts+
FHQy/PRtvV2ohItJbfCTPTWjgBELQeONHyLnhbRoDYNGYyysyatprSq0TVpEVHN8
gukb731ZJzStKaIHIa+FtyW2DlzCfgPgwxT8LAr57xVPvwUFU/im8OztJdRSERf3
kkEg5t5fJsF+g/NekWV4g3ynWHNmKZ0dn40oanFNjHu6VsZj0Swzj9hOfRzYAm92
yr6hPj1VQY7N5tW90Z7sMiJgFQje8/tunjh2/MEweezooqTQ3hVQrvdRykwR4j00
ATlo/5vssOjOmRVThS0jxaSTSUUcW+nFxaEeJ00Cbm5AoRtLaGmpWBkvCVDqqavm
dKadcnyZvZ4mwK24TlrHA9EgHUCaGvNmEP6WJ4lfnieswdJIj60=
=J11M
-----END PGP SIGNATURE-----

--Apple-Mail=_23208463-7A57-4687-8755-FF47195EDFA6--

