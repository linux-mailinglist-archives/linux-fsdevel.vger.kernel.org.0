Return-Path: <linux-fsdevel+bounces-46504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF13A8A54A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 19:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D4E442F51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C621C188;
	Tue, 15 Apr 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="pN8homO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD12DFA41
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737781; cv=none; b=L0IWW1Byie6/L1NRdd7gW4rx7EWoo/rmmfOIMRDvdHOqd+KgjTYy8UawkNCSOyGa2LaXMToQw3pgqQvb1Mpq0zhYqRjx+NWzkxsyzQnBQF0ZZz6UOTU2dDL/n+cxEMNTnG/h59JuUB25ApemFBdklHtUiiKzzXcQEOOcKiSi+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737781; c=relaxed/simple;
	bh=jGBSqGvM/WhlmhLlUU8M1QCfFHbdqZ1vURvunRbkv6s=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=dfOVM1w14b3J1Ejyjxzh8SjMTR0jC6DsowJ/uacwPTny8wGcEEIALwc+yIVvWwSvzRp54i40S2eHPkTWu8foGjArGopvpXNX0CwV8NW1LTCFgZEoEC1vfaa/VKolR3XdCoaQpqHrB0NUzQkkUYmSTCTLV1VbSXBjfAkFKTIpOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=pN8homO4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c277331eso6317881b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1744737778; x=1745342578; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUe5eCtJCpys3oXpeuk6TzOQskhu8bOjccmowo9E5rI=;
        b=pN8homO4sKBoON1ewkvNFgBgvSH+rEEqtxIBk/1O1oAJp5EzZRXgDQAZioYX1HLbbx
         PKoEYkakH05SJ9wZ2FF4ii/IU/bzbk1t7d82bkXLASndvNi8iqait2IyAnNAjwFTYb4v
         IUDx21F7jxJaa2HZRZES5lWE8qO+eCDrKGg+8Lq9QhlRJZqBfwz0aKMyYT3qz59L9Lbm
         WJueJhOhsTGx1vUrJIcVTQoz6FFpA/cCYIouzp5pMaK2Sc6/Gi4HVu1wcmI4cRKApbU1
         CaDyf/rvvObUYKw23ZX+0ZHxxKIxGk7x/azsVJkcjeYPCv2Xbm64sjXYPwmPyAL2borO
         tv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744737778; x=1745342578;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUe5eCtJCpys3oXpeuk6TzOQskhu8bOjccmowo9E5rI=;
        b=S0GySmF/zO6rc4UfvAXYPVb8wUb/9mD6DJfIyMsR/8y5/MK8i7YsQBY4AWGhgoB4k2
         PFlI3t+yg7PkHBYJkAbGDadeNEGh9e6t836SJwmX5BtaStggzC30SH+CbeY/I3ODFGqc
         1X3t7pJGUw6tDV+93YKvqkWllszIsnRiR6cDe0FmTC0x9YUQEetYQmQ1xWMsGeljjA7k
         9jrOJm2D0vsM5WA6WCyidRmW4JmdyJVCzWpyGkJQfZWH14gTDU61IQLEY0PO4QlTMiHE
         L/bzE+vuTP3tV4Y57H2Wc5Kk+uR8SgmStq9PA7HGLckHvUZrKCE1B7AIvhTd09EwvkCf
         Z8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTUwuqyT6jxnzuvMhAgwA+rAVrGbs6lq5Ze8THNDPeBqRFRouN/5kWmQUEzpLxnrI3btkcnHd6PBo9PT3T@vger.kernel.org
X-Gm-Message-State: AOJu0Yxho9OZn6ZxxmVrv9ajNm5gucGxtxpQf1p3vM+5f8AtMYxYuTiR
	7PkUvJPtzcp3GUGq3gk97WRjecSI4FtGHGavtYGgKhck90+w8aDWfmC7mu/rAic=
X-Gm-Gg: ASbGncuTP6YbFeTllgm9Qj9TGvlek5zO6h58TwXf5p3K+HhxGR4FaVegMA2+BOxm5KE
	bKty+Y40fZWKuHO6k1X84KS5USuLYyihCTeOye64iuzZDYeBCKMbTBw4Coodc4LHkKImcU/K3U+
	fq9xQ3noHKkBaO0CMoE9vhkmQo1hyaI8qlt6bH/g+3OSuPDGeekjV8rZNn1EbDsQA0HFt1CH3Ey
	xPk3mK2q8wHLjo7dI+4GD/VLYRJnjVQv4zW/+2WlcIcnNz/81tqCjyo8pCXexagteqhK8fCWzw9
	/41/cfxfDDLZRCFBSbqcOGUuM34OGbadZSd2Zf0LAq6urAI1QrdMpeooc18dbbQ6iZdrCDbwk2E
	yzXVTA39LotTICQ==
X-Google-Smtp-Source: AGHT+IE4Rtxwvz78g+IBmnF0LE0xlBWKSOm2tYd4DqQsKk202P/mf05Q1LcOGzEaEl0WgRokyGaRJQ==
X-Received: by 2002:a05:6a20:d705:b0:1f3:237b:5997 with SMTP id adf61e73a8af0-203acad47f1mr336617637.14.1744737778009;
        Tue, 15 Apr 2025 10:22:58 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a322184fsm11432017a12.74.2025.04.15.10.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Apr 2025 10:22:56 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <B95C0576-4215-48CF-A398-7B77552A7387@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E255BFD4-8AD2-46E6-A7FC-582314D06408";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: bad things when too many negative dentries in a directory
Date: Tue, 15 Apr 2025 11:22:53 -0600
In-Reply-To: <e01314df537bced144509a8f5e5d4fa7b6b39057.camel@HansenPartnership.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Miklos Szeredi <miklos@szeredi.hu>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>,
 Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>,
 Ian Kent <raven@themaw.net>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org>
 <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
 <Z_0cDYDi4unWYveL@casper.infradead.org>
 <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>
 <Z_00ahyvcMpbKXoj@casper.infradead.org>
 <e01314df537bced144509a8f5e5d4fa7b6b39057.camel@HansenPartnership.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_E255BFD4-8AD2-46E6-A7FC-582314D06408
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 14, 2025, at 11:58 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Mon, 2025-04-14 at 17:14 +0100, Matthew Wilcox wrote:
> [...]
>>> I got that's what it's doing, and why the negative dentries are
>>> useless since the file name is app specific, I'm just curious why
>>> an app that knows it's the only consumer of a file places it in the
>>> last place it looks rather than the first ... it seems to be
>>> suboptimal and difficult for us to detect heuristically.
>>=20
>> The first two are read only.  One is where the package could have an
>> override, the second is where the local sysadmin could have an
>> override. The third is writable.  It's not entirely insane.
>>=20
>> Another way to solve this would be to notice "hey, this directory
>> only has three entries and umpteen negative entries, let's do the
>> thing that ramfs does to tell the dcache that it knows about all
>> positive entries in this directory and delete all the negative
>> ones".  I forget what flag that is.
>=20
> It's not a flag, it's the dentry operations for pseudo filesystems
> (simple_lookup sets simple_dentry_operations which provides a d_delete
> that always says don't retain).  However, that's really because all
> pseudo filesystems have a complete dentry cache (all visible files =
have
> dentries), so there's no benefit caching negative lookups (and the
> d_delete trick only affects negative dentries because positive ones
> have a non zero refcount).
>=20
> There is a DCACHE_DONTCACHE flag that dumps a dentry (regardless of
> positive or negative) on final dput  I suppose that could be set in
> lookup_open() on negative under some circumstances (open flag, sysctl,
> etc.).

Negative dentries are only useful if there are fewer than the number
of entries in that directory.

If the negative dentry count exceeds the actual entry count, it would
be more efficient to just cache all of the positive dentries and mark
the directory with a "full dentry list" flag that indicates all of the
names are already present in dcache and any miss is authoritative.
In essence that gives an "infinite" negative lookup cache instead of
explicitly storing all of the possible negative entries.

For directories like ~/bin, /usr/bin, /usr/lib64, etc. (or any =
directory)
where negative lookups are frequent, it should be possible to determine
this threshold automatically.  Once the negative dentry count exceeds
the size of the directory by some factor (e.g. directory size / 16,
or the actual entry count if the filesystem knows this, it doesn't have
to be exactly correct) then a readdir could load all of the names to
fully populate the dcache and set the "full dentry list" flag on the
directory would allow dropping all negative dentries in that directory.

The VFS/VM should avoid dropping directories/dentries from cache in this
case, since it is saving more memory (and avoiding filesystem IO) to =
keep
them pinned rather than dropping them from cache.  There might need to =
be
a matching "part of full dentry list" flag on the positive dentries to
avoid dcache shrinking of those entries (which would invalidate the =
premise
that the parent holds all of the possible entries in that directory), if
checking the parent's flag is too expensive.

Cheers, Andreas






--Apple-Mail=_E255BFD4-8AD2-46E6-A7FC-582314D06408
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmf+le4ACgkQcqXauRfM
H+AbtBAAuQ8D9YcDDLTCgH58aiUiGE+ONQvUlJClq+Yf6eLRHESRyWTw3wTXPntC
/9m2s4ENVw1XnFu05wQqCTnhkwrF9VxZemAE05PNQvaX92ujJ7aTGbl62PJaLeQU
rczObufHVv8BAg7PFtt/Ue7bsZqMZYLOIk1ReohTU+CGFsvNqlX5XFNmm3KBmNog
zimBm2zD2QxgseVNqM5hxbMzT0vV786DL+05GOruB3cWHMrdgy0554DUMIlebrk7
GDxbHBk6uvKkuj0UBUoLimEfD4Kb6Fm9GvhBK798P3Hz6MIr/z1nxyHYqS1v3Zqy
0zTpl2hQyDTqYEW9siFp+Ugn/DipZoDfXKCotYCT56YnKFLG7PTNF6/4BPqoaUtH
AOpbPPDZ2GIj6CKC3k5/jfLW7rDizKfGPSEYaKzX7/XJ+HsiBe/KDSoZJnR+HNl9
AAISea2w4kEJs6aEtCBfkliMP+nzVQ0vl2gTSngM4i1UqDzj3l3J47VaaoiAcG12
bmu1fAvkK9XpXp1Z3CjcAp5rMEoJk5/10BPx/loOobAeeafdk4wu8HVwwBoZesTi
Ls7dSfYC498CemLTHcHz1gwGe1Bf6x5UcOTB8Fs8OEbX0fjFjvd3OcT8thwTguAP
hVHZFX3TfbQ0Kr0ke1P/sNtNdY+akJHD19JdzD3wSTJS5Xo796E=
=iG3f
-----END PGP SIGNATURE-----

--Apple-Mail=_E255BFD4-8AD2-46E6-A7FC-582314D06408--

