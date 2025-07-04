Return-Path: <linux-fsdevel+bounces-53994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69CAF9CC1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 01:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B0A1CA2589
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 23:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B528F930;
	Fri,  4 Jul 2025 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR3ZOtFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F082372634;
	Fri,  4 Jul 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751672184; cv=none; b=sohoVMTmos5kvqr4zs6iTOIvLzb8cZaS5uMNI44Cr39F1rplD8N4wm3GIehqxN/C0J9GyKr2QJjTcfklzr+XdR3Yrmja4vbYB7NGQF2x5f0uIISilZNERKdMv306VetQ1AX+dk0Ew6goQqCAlTwOzEGFvUBrV/qFY+usbSTsJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751672184; c=relaxed/simple;
	bh=JCpe8NhiKEj2zPnP8azgWkKGslF6NDrVquXo+ef/qfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP/bAsqfn/+FsT9P12iYrvW3hLffNoYLyH/QLGbT3tQ8m+UmPlCf7W374vMvyvxTOq83X0McZb/4PPKxZeAdunkiSERcm9zZwgM3P9bawBUaragpWF4eaX7y4w14r3+YadaS9mpgxQZDfPvfrIYoKk4rdVTEFCMs2vp4inAnYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR3ZOtFF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so1340041a12.3;
        Fri, 04 Jul 2025 16:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751672182; x=1752276982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW4ZkVJLizEOMZlm6FbGon5OHPMCQ+a5mWweGHJG9kk=;
        b=UR3ZOtFFIip9KvC6LIwxX1d/hjGVPqFS6zDHI2JqAOscdBCOki3fHxapF2fl2/F5gP
         1izoSjgLmcWqV9FkeXvenHQyTO34tJtlzJvuNzI0FJh+IJUGqdvCkabeWnXLZ8IRbFx6
         EHNLP/uktsCCmVpgVGubP3U/e/kyC+riSOBKGh8FWIwMvlQK9OuU+4WA57XUo8PsC6ns
         kRFDZTGY150U4IczWh1PGApdhx3swea4bknfI6iWOk//SPpP1rdyIePO2X4xOsa6NfBq
         LDQJqY70gjBGkQQib+HYqDD6ZVtJUSpIMSYW/Cua3leJO5TqPZflGg1ivnF1pY8t8oaH
         jaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751672182; x=1752276982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW4ZkVJLizEOMZlm6FbGon5OHPMCQ+a5mWweGHJG9kk=;
        b=E+KaZKz99D196TI9xyxApHGvjliN22CZSS6qpRRMmgBR/SZJv6pTUb7l6EF21CdngZ
         M3qKw+8KKwApu7aAEL/Kdeusm/xxNrkeVnSzM7j23nKwHHx9Irqn3CZ4+BgH3urVNrq0
         Ip105JSkkAOmCaqJQOTb/PxMlmTQCykEhXWD6gS5JnXCU5cCEbY+5C+EMCK+5a/N+Tdb
         xalcGiz07S+sv7lVpfVlCIVtfQyLNA/h/Hpj+SjgIGOKjAXhP79rWHMIwFLASPzlhRJG
         Pj2bU3AMEV6D/hUThJEuFyidaJA5DkNZB+D2cHECeaaGqjAMXjefSGLAL1fVu0yWSfhj
         wPUw==
X-Forwarded-Encrypted: i=1; AJvYcCUS82RLiXwv5CCHwSxCPU9ZZPn5GhV6dXBPDxBlfcD+P4YVUogvbEEVbiM7WpHcYqK0W431U89PsMc=@vger.kernel.org, AJvYcCVgXSV7MSyIDo89SHthsWIfeLt7ED4JYxFRjkVivORULqMmvT0M/wjC9a105XU3wDdo2h/9C8E3+NXh@vger.kernel.org, AJvYcCW0UuDoSbQuuU3ZtLEHhTnVD86VZNS8xJObgrm/Cv/2rjQoD3Y8HM4F7cwmTujin98u/bbz/J4NfW3RZpW2@vger.kernel.org, AJvYcCWkbPH/iC+HjJV8FLK7HV+hboCR6+V/76biuojxw7aeZajNHdUDvO2MccS6YjK+3RESOo+1nZ344qeScjvupA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0TbDfoQl+02e1eGJIeYtdpwwC6U+Tvlv9JfQihxeMizmrVeXh
	gOTG36DfKyrSfjFrqA+zorpYWdv7m9utJNHnDU4BLxgdF/Y639wIY4vT
X-Gm-Gg: ASbGncvEi2ReTPmDbcjjI66rvT8Vax+Uwxo/4nP45F9yqKze8nfok+R4Bp7DJp/KiBo
	x194F64yO3ytEt/aK4HSZXJXjudXUcs+ihEALhCr5oYTERPRbQcnKyjmVXuR+hg0nAqmkR6vFX2
	hzDl8KiCHtkw02Z0+2LlVBvQyEpzhYI6Nk9dbuBRnYpvk+wbQbBOmL26e5HEjk9dnDVOaujbu9l
	zbQY90FLkPwvGXr1XAiujzuZqtg0uYoK9/4T9mlp2DBkGLeX4bubUfSaQY03fdyjfzC3F1nt0zN
	UUl91jyu0F09EpCjRcZuzz8s/AJPhrY8Wbc2hdwUMmXbDSCBnFLyOqGKjoLYgF4oOLXyfCbV
X-Google-Smtp-Source: AGHT+IE4IRYdu9IVNI0Qi70rnYU18p+ftbhSiwCIQTDS0BZ3EOaU16ZkHZIPPf80+LxTA19o+gzvyQ==
X-Received: by 2002:a17:90b:3d8d:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31aac52f963mr5107707a91.32.1751672182068;
        Fri, 04 Jul 2025 16:36:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845c4e19sm30681285ad.255.2025.07.04.16.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:36:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D71E34206889; Sat, 05 Jul 2025 06:36:18 +0700 (WIB)
Date: Sat, 5 Jul 2025 06:36:18 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>, John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
Message-ID: <aGhlckJrNJE1Au10@archie.me>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
 <CAOQ4uxj0Q5bnMNyOEA96H9yP=mPoM5LsyzEuKu184cDKaQuJpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PGzdml3OhylUUifk"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj0Q5bnMNyOEA96H9yP=mPoM5LsyzEuKu184cDKaQuJpg@mail.gmail.com>


--PGzdml3OhylUUifk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 10:27:03AM +0200, Amir Goldstein wrote:
> On Thu, Jul 3, 2025 at 8:51=E2=80=AFPM John Groves <John@groves.net> wrot=
e:
> >
> > Add Documentation/filesystems/famfs.rst and update MAINTAINERS
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
> >  Documentation/filesystems/index.rst |   1 +
> >  MAINTAINERS                         |   1 +
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 Documentation/filesystems/famfs.rst
>=20
>=20
> Considering "Documentation: fuse: Consolidate FUSE docs into its own
> subdirectory"
> https://lore.kernel.org/linux-fsdevel/20250612032239.17561-1-bagasdotme@g=
mail.com/
>=20
> I wonder if famfs and virtiofs should be moved into fuse subdir?
> To me it makes more sense, but it's not a clear cut.
>=20

I guess these can stay in their place as-is for now. However, if we later h=
ave
more fuse-based filesystems (at least 3 or 4), placing them in
Documentation/filesystems/fuse-based might make sense (fuse subdir documents
fuse framework itself, though).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--PGzdml3OhylUUifk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaGhlbQAKCRD2uYlJVVFO
o4hrAPwIkZyEF8E7JsHO+OKP5L0TvZjbT8oSivNiKmNfaE5ezAEA2d4o2XYkIwSK
r1OLeL7fnBcdD125WPePOhWuuw5xoAc=
=gU4v
-----END PGP SIGNATURE-----

--PGzdml3OhylUUifk--

