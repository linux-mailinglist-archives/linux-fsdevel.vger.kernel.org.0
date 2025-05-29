Return-Path: <linux-fsdevel+bounces-50107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3FAC8377
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3DA4E4A5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 21:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6151729293B;
	Thu, 29 May 2025 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="xUPRqjAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833222A811
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748553256; cv=none; b=f3osRa5DOmv6iR+bBliLdCeCmHbdXxb8j8/MNL1k+r1aoiJkHhd9cK/23X4PFJvJbpiseq9kyDXxd2BWHhw2GXDXomcuCV/3dbLHCtR/vjcyywqfsTtPuvCTDqpj1Q+jYmd9WCGUTAUcg8s6Z1h+5e6E+Ouo24XMjErhFmotUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748553256; c=relaxed/simple;
	bh=IcWvkHv4EQaW2hd7IC+w6MzT7w6ILDs3isBRTOIkpP8=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Ebty00viTYBwckRsYrqpOop/NjMwbACOFxmcTppGR3JldA+Uv0Alb7CMXCzICZee4wEzBJv1Zr2rgOC401L5L4cCa5jSJAyY3zgwmWcfs77iRICGvsgYGmYXnisLLWtEOHSHNU9jqrfzZCg3ChenfhCx+N2LKMPKD2d5gr2N79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=xUPRqjAK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74019695377so833856b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1748553251; x=1749158051; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k13so8TshT1eDVx+t10ev/4ZziKErXzgHkssataT8+c=;
        b=xUPRqjAKFA1wh6WIda3V42PpS884iIG0GaiS9LQ8ySf1KvnKYzuQ7l2wmjbk180MAL
         Dia+QwJSK/2Yeivj6M2m68O6oJQ+1xSi2sfW0sG0muzbiD121VblZUMwj3ZWmbFml3ZO
         9h5Fxh7lzetYND87Y/ID/SOfli71gtbhobm3g5Hvt0mddtTbaA2ylHGtqwki56akeeBC
         UiwBY1a/P3CeQkz+SdkrnUCaDNUrOgncDmddRUaunoUquPbLo2qMIGrt376Bf4xTQlbo
         r//a3C8gUMmAsSqvzp7/McgOxR2Mo0tCtYkaSmF0tkKZ7DXqvUWgUH9pXevaty0a/HK3
         tojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748553251; x=1749158051;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k13so8TshT1eDVx+t10ev/4ZziKErXzgHkssataT8+c=;
        b=PMaubw48IHfvrw6clzQXZHWTcKmcTMld1gHgY9wRCKsQgJRcOei8a04SmOp5QeFoXE
         7pM28RibMpi8IWz5BGNpu2ESOowyrc9TR4+m1QLUVQZj5VMrCmxG56sxPn2isJ338BWy
         lC2/APq8r4/nksKm8ptQ/2WToIYpLL3srimZmaokl0PyZ0bvtJnz3cEv3PlN0SmoMT5s
         eVXXj8FtkOi707e0ECaZpVwxLobLYCGwbXHy37jBgH08HtgQBwnqNy3Z+hTVz9LdL2tp
         00ojPMMWxpZly25mhzpRCKSSsMa7IYu8CJsx0bbwaxg6+xY646inlV7sQFcA6W15iT/1
         LavA==
X-Forwarded-Encrypted: i=1; AJvYcCVgCCyFrrfhvu/NAlUC72Va5/jz7WrrKsFPFtrdINpTRCGN8/yszXYwrsVFDhtEj5aZYFXb2CFmzuQQA3YW@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVWDi3dctuoXWjmfrSd0343l3/yLtouTgHfoQXwEx94DDliSA
	l58b+prq9WZOK0OOJ2Efi4uCebV0gNmeii1TFAmTZC8t/+4HoGwhOjIaLGxGk6zZGKg=
X-Gm-Gg: ASbGncv8MpWBNbbVtK0+ouHEjhwClrIG1tUiGsPlnCBthjolpI5LS48+Zep72e/KUF4
	nylV22HOuZSInWXs1fOGAwpcLMiLRKaD3wPcGftQKxzHJhT0Q7w/SzjTn3n+5/rL8QE27diXBCS
	UuAsF4XoePYjsAxOh/DorDTgYGIyscyQKD9xP2+mJl/W31xfOlXGsEhX3y+ktuJXbgzaqLAWgGo
	d9Kh02fZy2y+qk7ve6Nbt1D75ebkpIG/3WZswkEgYbFwJTt0XJ/f7dxAW0B0KJQQjDaXwWRwUaW
	CXajYXzmdPa7nBPOZnz0ZbZtDtgcHTfgr27vhXUh/2rQdMxarF+P7D8zDtMjsfArdSxE4RXLWqj
	SId6YMAu9i8RjTu82LLk5skg98PK/gg4AJWI=
X-Google-Smtp-Source: AGHT+IFZXygM8o2ZP8ClV1PZVjKlGcHa0EumKVgCbBI6DcEFEWHU8NMBYlJWcaU3sD+9lQobu1+E2g==
X-Received: by 2002:a05:6a21:3a87:b0:218:bbb:c13c with SMTP id adf61e73a8af0-21ad986aec2mr1399879637.38.1748553251303;
        Thu, 29 May 2025 14:14:11 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe96781sm1764900b3a.29.2025.05.29.14.14.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 May 2025 14:14:10 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <BCCFF489-A00D-4C35-869D-330B17D3E5A3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E2DDAFA0-57A7-415A-98D8-F95A6F923FC8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] add ioctl to query protection info capabilities
Date: Thu, 29 May 2025 15:14:07 -0600
In-Reply-To: <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
Cc: Martin Petersen <martin.petersen@oracle.com>,
 jack@suse.cz,
 anuj1072538@gmail.com,
 axboe@kernel.dk,
 viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 hch@infradead.org,
 linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 joshi.k@samsung.com
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_E2DDAFA0-57A7-415A-98D8-F95A6F923FC8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 29, 2025, at 1:12 AM, Anuj Gupta/Anuj Gupta =
<anuj20.g@samsung.com> wrote:
> +/* Protection info capability flags */
> +#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
> +#define	FILE_PI_CAP_REFTAG		(1 << 1)
> +
> +/* Checksum types for Protection Information */
> +#define FS_PI_CSUM_NONE			0
> +#define FS_PI_CSUM_IP			1
> +#define FS_PI_CSUM_CRC			2
> +#define FS_PI_CSUM_CRC64		3
> +
> +/*
> + * struct fs_pi_cap - protection information(PI) capability =
descriptor
> + * @flags:			Bitmask of capability flags
> + * @interval:			Number of bytes of data per PI =
tuple
> + * @csum_type:			Checksum type
> + * @metadata_size:		Size in bytes of the metadata associated =
with each
> interval
> + * @tag_size:			Size of the tag area within the =
tuple
> + * @pi_offset:			Offset of protection information =
tuple within the metadata
> + * @ref_tag_size:		Size in bytes of the reference tag
> + * @storage_tag_size:		Size in bytes of the storage tag
> + * @rsvd:			Reserved for future use
> + */
> +struct fs_pi_cap {
> +	__u32	flags;

Minor nits on the struct.

It would be preferable to have a struct prefix on these fields, like =
"fpc_"
so that tags for "flags" don't return a million different structs.

> +	__u16	interval;
> +	__u8	csum_type;
> +	__u8	tuple_size;
> +	__u8	tag_size;
> +	__u8	pi_offset;
> +	__u8	ref_tag_size;
> +	__u8	storage_tag_size;
> +	__u8	rsvd[4];
> +};

It seems strange to have padding to align this struct to a 20-byte size.
Having 4 bytes of padding is probably insufficient for future expansion
(e.g. just a single int if that was needed), and 20 bytes isn't exactly
a "normal" power-of-two size.

Since ioctls take the size of the struct, you could either remove rsvd
entirely, and use the struct size to "version" the ioctl if it needs to
change (at the cost of consuming more ioctls), or expand the struct to
be large enough to allow proper expansion in the future, like 32 bytes
with fpc_rsvd[24] (using "flags" to indicate the validity of the new =
fields).

>  #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct =
fs_sysfs_path)
> +/* Get protection info capability details */
> +#define FS_IOC_GETPICAP			_IOR('f', 3, struct =
fs_pi_cap)

Note that _IOR('f', 3, int) is already used as EXT4_IOC32_GETVERSION, =
though
this does not strictly conflict because of the different struct size.

At a minimum, FS_IOC_GETPICAP should be declared right after =
FS_IOC_SETFLAGS
_IOR('f', 2,) so that it is clear that _IOR('f', 3,) is used.

However, in Documentation/userspace-api/ioctl/ioctl-number.rst it =
reports
that 'f' 00-1f is reserved for ext4, while 0x15 00-ff is reserved for =
generic
FS_IOC_* ioctls, so that would be the better one to use.  Currently only
_IOR(0x15, 0,) and _IOR(0x15, 1,) are used, so _IOR(0x15, 3) should be =
safe.

Cheers, Andreas






--Apple-Mail=_E2DDAFA0-57A7-415A-98D8-F95A6F923FC8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmg4zh8ACgkQcqXauRfM
H+CuuQ//ReiCU3lVfW3j5pXy+ccxld+vI1SDMkl9snP5GKG5m67fu2dAecS1aodt
erJVStpAPxjFXxAPgB91Q0iB4VcEI2D2U5m44nK44z9SN6jd6Hvw9xs4F+uha/4R
p/Cz/TxFyB53mofFwpFpbZcovOXhHpFK1KKskUk7FsI5oPMOiSyn/6O1u1vwpKKU
GFLIUpg5gH0OHiLrOeZKdbqoHnWBZ5q3QVYRtynpsqIeeJDeNXIY156mOrGhPLus
TAopfeYcq3KvxSvF8Y/f3y1l/85/oC6WXTSDLC5OWzmD20CYldr80PosSJQu0Eip
J4paeOOLF1IcfMsFh7BEPTLegkelaY4eT6+O6cf2E3ZuWiQ7PtYc2Gi9Wt0uTnQG
1PMxgnYjSN8f910RLIOMkU3Oyt9jpz4C16f9sTtGU/m1N4JB43mXOMN4RoKLhMF7
NCt1vnw85VKqrJYqgZwvKfampaTD/BS1mSehGV/Hkn8oD6bunGuC8ccn/RFKoVhA
y5Kx/yq59pksVJzslcIO91kmsW9hm8cbj63S8jnTp5MtDFD9x4SSL88WdMEPDtMe
PS65k464r1UV0DYQIgQvtbQyiWGLJk1MVodBsL9E0WBvYxfPLMLzs2ocZcT9gKVe
LAyupgLpBlI+vMXFMr9x9nL0cEEC5LgmR26L4GSpHmQBxbYCHeg=
=C2e2
-----END PGP SIGNATURE-----

--Apple-Mail=_E2DDAFA0-57A7-415A-98D8-F95A6F923FC8--

