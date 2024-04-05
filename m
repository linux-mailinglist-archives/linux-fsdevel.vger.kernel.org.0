Return-Path: <linux-fsdevel+bounces-16219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F689A463
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFAE282D19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C0172BA8;
	Fri,  5 Apr 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="zbQC4+8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9AD17277F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342737; cv=none; b=EJkvg13l4zsDsrcHiQFom0rkAEkfaKEhNIlawJKlZUII01ojhwLjpqlnZ4cOG1ghYEMTEg/OreZnUNuCaqVawkvK/giznR3xGB/495kevt6U4bGy9teA5aC3zD6letwFKIFFkE6t1EWUOIFEHelK3xq1DOmMIwOf0IKu141jCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342737; c=relaxed/simple;
	bh=/FCPihbWn9eIg+Y0AzTbDJut0QYvSPXzbyDJt8yAYeA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=DU8nTsQBo4OTyo/PLxBAam72cdHOZ70W2YC0lLtm0j6ACpBgMvhHYHn3T4RsKM8u0dJbvv7L+iSd+Au3XhKEGSn+djibrm+OkB/L8pg+fWadnyOb9aNZhD9luPrkkCOllEyss6g1NLwvyPnIx9D+8MZWjUzzIcdviAcO42kb6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=zbQC4+8J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2bfac15c2so15930835ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712342733; x=1712947533; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlBmmeOJnSN3JFYBQXBy/qIRI+48VBuCQo8cLWjg7HM=;
        b=zbQC4+8J+xoqY2Au8D98He/41oHMZY7ZdgvXFYyawz6X0sIXTx76RMGR9oxPKE1bsF
         F335B7zUx9N3Ud3/cAO5hmwQFRY53TIsQl/7geeIFVY88ykZuPyC3RnvKUAsiwOHK1Fn
         JXzRXDkpyMf32jjuSFv6u0ByRn5pX6sdDAHwKseziiVEy4486oipvKYodLrlhPeRYt4f
         W7v65E987Ue6a36B2a85iW8wvD1pHDkk/UmJ1yyvJTmPyPl19szGQVgeNRxfft9kWWjh
         1v1UTIfyFz+f7SvrRyTnbWx7hqqH2aESC+lm7jhTLaLQsFuh4Ab51scxINnL48ryMvr7
         1daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342733; x=1712947533;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlBmmeOJnSN3JFYBQXBy/qIRI+48VBuCQo8cLWjg7HM=;
        b=uDzDM4yk+RiG1BAsWfbFcre7spL/bJk8SGSqqL3Nsj73IEtX2MtKLg3cx4GhXVYQxe
         O4Y+s5z+QJnXp0d7hiqt2aOP9or7Ove4knMOIDZ63DcZSnx5NRoHlzpwBxpVaQ+e1Ic3
         7myoZZWzlNrFaejuAF464CNmaHlJazkMIsTQAndzpmMrxRK+AQPlFRwb3kMLk3v2M3yC
         vPwQF6gxeMaySZpXVfNU7aj2BenjlY51h6JsvL8g2RFdhKTsESS7Eb4H/39cA+RD+/a3
         eNUIxEVCCd6lCxaoUBk9HifZje3B+TK7SQbWMzRkjl86WKhJ6VMnw4Jm+EwQNcjEYcM/
         w5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWqAVFS3HqrfYEOlBrt6viG/IJ8gLeH/E0N3bw905coF30J35Gj57AioLMKL0bmd+OsnZlBtoqF5pXv72eyUm4tplQA/uBPZk1HMmiY3g==
X-Gm-Message-State: AOJu0YwIpeAswxHvH7n82FKp0LS3ytQwk+tQ7FudjHnj4pEcR9eYPdgQ
	Q5PEHAMYzxF4VyzprFukOYYytsRFebqZtqTQS2kQw36crIg9/cOijVg7aeC+sCs=
X-Google-Smtp-Source: AGHT+IGbZFAzIFfYD6auuNZ/ItSPWzflNUulnWZOWfZjCss+4ukyWoI64u0JDm6pfEpH7xCKhF5H2A==
X-Received: by 2002:a17:902:f7c4:b0:1e0:157a:846c with SMTP id h4-20020a170902f7c400b001e0157a846cmr2133198plw.55.1712342733409;
        Fri, 05 Apr 2024 11:45:33 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001dee4a22c2bsm1917775plh.34.2024.04.05.11.45.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:45:32 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9DEBC627-6878-47EA-8404-3185803F262E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_449AFE1A-E6A4-42ED-AAA0-EB3E1B49C7D5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 01/13] fiemap: add physical_length field to extents
Date: Fri, 5 Apr 2024 12:47:40 -0600
In-Reply-To: <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>
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
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <1ba5bfccccbf4ff792f178268badde056797d0c4.1712126039.git.sweettea-kernel@dorminy.me>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_449AFE1A-E6A4-42ED-AAA0-EB3E1B49C7D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>=20
> Some filesystems support compressed extents which have a larger =
logical
> size than physical, and for those filesystems, it can be useful for
> userspace to know how much space those extents actually use. For
> instance, the compsize [1] tool for btrfs currently uses =
btrfs-internal,
> root-only ioctl to find the actual disk space used by a file; it would
> be better and more useful for this information to require fewer
> privileges and to be usable on more filesystems. Therefore, use one of
> the padding u64s in the fiemap extent structure to return the actual
> physical length; and, for now, return this as equal to the logical
> length.
>=20
> [1] https://github.com/kilobyte/compsize
>=20
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> Documentation/filesystems/fiemap.rst | 28 +++++++++++++++++-------
> fs/ioctl.c                           |  3 ++-
> include/uapi/linux/fiemap.h          | 32 ++++++++++++++++++++++------
> 3 files changed, 47 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/filesystems/fiemap.rst =
b/Documentation/filesystems/fiemap.rst
> index 93fc96f760aa..c2bfa107c8d7 100644
> --- a/Documentation/filesystems/fiemap.rst
> +++ b/Documentation/filesystems/fiemap.rst
> @@ -80,14 +80,24 @@ Each extent is described by a single fiemap_extent =
structure as
> returned in fm_extents::
>=20
>     struct fiemap_extent {
> -	    __u64	fe_logical;  /* logical offset in bytes for the =
start of
> -				* the extent */
> -	    __u64	fe_physical; /* physical offset in bytes for the =
start
> -				* of the extent */
> -	    __u64	fe_length;   /* length in bytes for the extent =
*/
> -	    __u64	fe_reserved64[2];
> -	    __u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this =
extent */
> -	    __u32	fe_reserved[3];
> +            /*
> +             * logical offset in bytes for the start of
> +             * the extent from the beginning of the file
> +             */
> +            __u64 fe_logical;
> +            /*
> +             * physical offset in bytes for the start
> +             * of the extent from the beginning of the disk
> +             */
> +            __u64 fe_physical;
> +            /* logical length in bytes for this extent */
> +            __u64 fe_logical_length;
> +            /* physical length in bytes for this extent */
> +            __u64 fe_physical_length;
> +            __u64 fe_reserved64[1];
> +            /* FIEMAP_EXTENT_* flags for this extent */
> +            __u32 fe_flags;
> +            __u32 fe_reserved[3];
>     };
>=20
> All offsets and lengths are in bytes and mirror those on disk.  It is =
valid
> @@ -175,6 +185,8 @@ FIEMAP_EXTENT_MERGED
>   userspace would be highly inefficient, the kernel will try to merge =
most
>   adjacent blocks into 'extents'.
>=20
> +FIEMAP_EXTENT_HAS_PHYS_LEN
> +  This will be set if the file system populated the physical length =
field.
>=20
> VFS -> File System Implementation
> ---------------------------------
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 661b46125669..8afd32e1a27a 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -138,7 +138,8 @@ int fiemap_fill_next_extent(struct =
fiemap_extent_info *fieinfo, u64 logical,
> 	memset(&extent, 0, sizeof(extent));
> 	extent.fe_logical =3D logical;
> 	extent.fe_physical =3D phys;
> -	extent.fe_length =3D len;
> +	extent.fe_logical_length =3D len;
> +	extent.fe_physical_length =3D len;

I think Jan mentioned this already, and I agree, that fe_physical_length =
should
be left =3D 0 initially, and be set only when FIEMAP_EXTENT_HAS_PHYS_LEN =
is set
(either explicitly passed from the filesystem, OR possibly set =
internally by
the common fiemap code along with FIEMAP_EXTENT_HAS_PHYS_LEN if the =
filesystem
didn't set this flag itself.

I don't think it makes sense to set fe_physical length in this patch =
before
FIEMAP_EXTENT_HAS_PHYS_LEN is set, nor in the later filesystem-specific =
patches
that are passing "0" for the physical length instead of "len".

Cheers, Andreas

> 	extent.fe_flags =3D flags;
>=20
> 	dest +=3D fieinfo->fi_extents_mapped;
> diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
> index 24ca0c00cae3..3079159b8e94 100644
> --- a/include/uapi/linux/fiemap.h
> +++ b/include/uapi/linux/fiemap.h
> @@ -14,14 +14,30 @@
>=20
> #include <linux/types.h>
>=20
> +/*
> + * For backward compatibility, where the member of the struct was =
called
> + * fe_length instead of fe_logical_length.
> + */
> +#define fe_length fe_logical_length
> +
> struct fiemap_extent {
> -	__u64 fe_logical;  /* logical offset in bytes for the start of
> -			    * the extent from the beginning of the file =
*/
> -	__u64 fe_physical; /* physical offset in bytes for the start
> -			    * of the extent from the beginning of the =
disk */
> -	__u64 fe_length;   /* length in bytes for this extent */
> -	__u64 fe_reserved64[2];
> -	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
> +	/*
> +	 * logical offset in bytes for the start of
> +	 * the extent from the beginning of the file
> +	 */
> +	__u64 fe_logical;
> +	/*
> +	 * physical offset in bytes for the start
> +	 * of the extent from the beginning of the disk
> +	 */
> +	__u64 fe_physical;
> +	/* logical length in bytes for this extent */
> +	__u64 fe_logical_length;
> +	/* physical length in bytes for this extent */
> +	__u64 fe_physical_length;
> +	__u64 fe_reserved64[1];
> +	/* FIEMAP_EXTENT_* flags for this extent */
> +	__u32 fe_flags;
> 	__u32 fe_reserved[3];
> };
>=20
> @@ -66,5 +82,7 @@ struct fiemap {
> 						    * merged for =
efficiency. */
> #define FIEMAP_EXTENT_SHARED		0x00002000 /* Space shared with =
other
> 						    * files. */
> +#define FIEMAP_EXTENT_HAS_PHYS_LEN	0x00004000 /* Physical length is =
valid
> +						    * and set by FS. */
>=20
> #endif /* _UAPI_LINUX_FIEMAP_H */
> --
> 2.43.0
>=20
>=20


Cheers, Andreas






--Apple-Mail=_449AFE1A-E6A4-42ED-AAA0-EB3E1B49C7D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQR00ACgkQcqXauRfM
H+BtVRAAjZSyrxYwIWwtfdIIQWHYjf6ABCujS/GGHL4Uf2MsKs8EKlrFCLyrIFvU
gUk3Gq7XiJiXFwGCRjkfqd3JJ5wM3qXqtYDdJuSmXcwJerX2ElqpA6eqWTWgYTIw
qZPxhCDfXMCafhx/EWLdyCECXz5Xl2j0VXnpi3zY9bmqhr3iEwJjGoSMlauA4FXr
lNdmoj2w5OWpJzavyEJ52EKh4wjkCVkV9D4wfEspjkTQb6JgjcDAM1l+xlVTzjDV
LDdRos8z5zL/5g+E6s7voG4gJwy1hxKEn6NnOozrmqRTJoED7MXrMIQwqaeqvpJC
myMk/UhK2M9dQ6j3yXlqagQsA9vydCGXT4/8eRoMR4xrXPXX26ATsMu73jn/GSH1
vJYrEgEOCsuj6D6V1gXmZWR3aVerd6rXfJ3RsO1rHEF8UJeH/3oBRCK9+yEScvll
iVb9F6PZX43Dcz3D2Daf/pFd8yMxuGfbNYx7cx8iEQp/pTHzE2D+gAmG12TSheTr
QYnDvHK/ZdDj037ev0dzLeUjkRNvC0eBwEhfflTtLQq9kSGymsfkQZ2XJUlubgdh
MDtTTHjZEXD6F4ClYkCJObs7rE/UB7UCPOii/yTJZUy6Siy7s3MUq14JBTm0zemw
HDpcDScFCVogyOsXETtVeraxVRg8+DdJAYA925VZ7vcP3uv026k=
=lDtd
-----END PGP SIGNATURE-----

--Apple-Mail=_449AFE1A-E6A4-42ED-AAA0-EB3E1B49C7D5--

