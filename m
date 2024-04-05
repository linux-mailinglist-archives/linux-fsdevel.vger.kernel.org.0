Return-Path: <linux-fsdevel+bounces-16218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140189A404
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 20:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42BF1C223F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C010F17276E;
	Fri,  5 Apr 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="pDfz/pHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA317167C
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712341097; cv=none; b=HIrMWJCIwqCsr+zEm7UCzWjFUbHtk/t5jY12HagIjUScVvPvnL7RhOo41fVsBYXQHOjnUgsfgfokXLNAeLdblcd9GFnurAa3Cvr3wNWsejUoHpY6BwN+wx4dkgBFtWn3orfIs3ophbWUFFH+j3kyI21PIGhCHMgmAPs2SmFV8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712341097; c=relaxed/simple;
	bh=wdMJhgg03J9ToLHXaFixR/36utzApFawE0KvfzXoqHs=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=kC/GhFghSl3UXJj9jyCC6OVQ4zkzwO4x5iVMiGi+vsq3zb4dc0P0dZLnm0K3IECJzxhzlWcZDBNalbD8ECXHW7lji9AhOiQFAphdtAH0wG12o6foR83wgAqdsfdlaLEEZyLz3plVa3ZLcqkSjSjjjbuPNZgRRiOZJoPZqtF8XWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=pDfz/pHp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1849157a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712341094; x=1712945894; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yt5fFOUcQfwmred9ry2pM1oK9JKeRbA+BTjVzFtQRM=;
        b=pDfz/pHpB9sII143/jXXuhAPupP2d7QqElx2yN6GP5mJZLDzlEq2j3+FkgpvDG8R70
         bByMj5Xf7C/7OBEFOHZJHxMZaAaeKda+7qN4Wqz17N0FoTKvF7NR+2bZhPvLtMV/EOhy
         sGkxkLM1kj/Dnl5jKKvuGakKCPr3uUo4pKbYZMoRn9IpjWhB1qqqSSRqoOx07X/YaMjY
         c3AixXB7DPaoEBUwJUZGapwQnmdKMrBJqoTGe6YglQ6eNqP3C6Cp+2GOJU1Vaq3wOAFN
         ted3ttFSX/T1A1av5p3hdiK9+mzxI4Qd54n3bf7Ybmz3cmSvBuArKYuLL7sZuYgsBIHi
         HNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712341094; x=1712945894;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yt5fFOUcQfwmred9ry2pM1oK9JKeRbA+BTjVzFtQRM=;
        b=cQ1NJB/EMISxaUZUkx4A2dzwcP8mUBdLRjD1o7ZDHmJn9giumcEbQtiHwj68Pspphh
         joDy+o5PT4sFGtJPtQFsUhJ0/b2HgQdfdnPHgbhGD8GbOzre+hGKc+Lp1RPfc6PEkSXK
         XqSvFDaimHf9qhR5Jt5en6xOzn9XgvEORl+iDoKKJ34LuKMzW+7rIX2ZlT6mE8E9+a1t
         xNPc/v1cDF3RbgtBAWb2USTwMhRzESpfh870Xw29uqqC4DLAVMpkoSsoBXTSV0jQiveD
         zbNIl2S9qFhIk9XudMrBx9h5f+1WB846rpkwk8790AgXvnSm4BfNci4MvzQN0v3SVZlR
         Sn0A==
X-Forwarded-Encrypted: i=1; AJvYcCV1NMCHangLTlEiptvGvGcn5YurL9AL9BgHba+l3fkD/OJhchiPqG3I1FtBGvvTXU1t9cSDK4MZ5ORZ7k5bzlCA3b/+CONGNemFyXRH9A==
X-Gm-Message-State: AOJu0YyUseUTLSOTT3cGTXTwSikoxBMFc9oEuhbHUF1u/0YaFIOWOb2+
	a4dp6KI7dcpbEdKMfry4iuYZKcZ/Z3yr4i4Lsra99Hh/xGRyfBs3ADWgD460Zhdm6av4wOdmfqk
	FH38=
X-Google-Smtp-Source: AGHT+IEDn0os+fUgFYATLn+Iq6FZjbfsk3zOmEGVgE/EWJZEoD0wnOYoH0jftB7HpCio2JhiLuD6iA==
X-Received: by 2002:a17:90a:1648:b0:2a1:f455:c3d7 with SMTP id x8-20020a17090a164800b002a1f455c3d7mr2069740pje.16.1712341094316;
        Fri, 05 Apr 2024 11:18:14 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id bb20-20020a17090b009400b002a46d73ebdcsm1525837pjb.46.2024.04.05.11.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:18:13 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <BF24ACE8-3644-4378-8E7A-AFAF82C0CDD3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_700566DC-00D7-4239-B730-9CEAF4C860C8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 00/13] fiemap extension for more physical information
Date: Fri, 5 Apr 2024 12:20:21 -0600
In-Reply-To: <vf4k3yagvb6vf3vfu7st7uj7asv4zbf5c3b2tef2g2xic5fkvj@olqxfakmkoew>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jonathan Corbet <corbet@lwn.net>,
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
 kernel-team@meta.com,
 djwong@kernel.org
To: Kent Overstreet <kent.overstreet@linux.dev>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <vf4k3yagvb6vf3vfu7st7uj7asv4zbf5c3b2tef2g2xic5fkvj@olqxfakmkoew>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_700566DC-00D7-4239-B730-9CEAF4C860C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 3, 2024, at 12:17 PM, Kent Overstreet <kent.overstreet@linux.dev> =
wrote:
>=20
> On Wed, Apr 03, 2024 at 03:22:41AM -0400, Sweet Tea Dorminy wrote:
>> For many years, various btrfs users have written programs to discover
>> the actual disk space used by files, using root-only interfaces.
>> However, this information is a great fit for fiemap: it is inherently
>> tied to extent information, all filesystems can use it, and the
>> capabilities required for FIEMAP make sense for this additional
>> information also.
>>=20
>> Hence, this patchset adds various additional information to fiemap,
>> and extends filesystems (but not iomap) to return it.  This uses some =
of
>> the reserved padding in the fiemap extent structure, so programs =
unaware
>> of the changes will be unaffected.
>>=20
>> This is based on next-20240403. I've tested the btrfs part of this =
with
>> the standard btrfs testing matrix locally and manually, and done =
minimal
>> testing of the non-btrfs parts.
>>=20
>> I'm unsure whether btrfs should be returning the entire physical =
extent
>> referenced by a particular logical range, or just the part of the
>> physical extent referenced by that range. The v2 thread has a =
discussion
>> of this.
>=20
> I believe there was some talk of using the padding for a device ID, so
> that fiemap could properly support multi device filesystems. Are we =
sure
> this is the best use of those bytes?

The current (pre-patch) fiemap_extent struct is:

struct fiemap_extent {
        __u64 fe_logical;  /* logical offset in bytes for the start of
                            * the extent from the beginning of the file =
*/
        __u64 fe_physical; /* physical offset in bytes for the start
                            * of the extent from the beginning of the =
disk */
        __u64 fe_length;   /* length in bytes for this extent */
        __u64 fe_reserved64[2];
        __u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
        __u32 fe_reserved[3];
};

and this series is only changing fe_reserved64[0] to fe_phys_length.
There was discussion in the past of using "fe_reserved[0]" for the =
device
ID, which is still OK.

Cheers, Andreas






--Apple-Mail=_700566DC-00D7-4239-B730-9CEAF4C860C8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQQOUACgkQcqXauRfM
H+CHWg/+ImmZQ6Nzwva0Efg63ioqP0pS3airRAPWj+bfSnsIXaituGulL3hG2Lt5
IORycBQ5w1uifrkGHdmcpOjoIsPuaQrjAdC700vt5TRhqLojhU6ZnLz/eZMFUSIe
oS0f9OPJPx3vDKBfMBeVTZbrzka94z5Wl0pUohNFSshNfYOrAKyGiBc0KLzpslFo
eQODjM5SpgwhN7Te0Wcpklr8JMQXI5e+QXkAnor25ImqCHB7PPL4BEt40/HS6hH/
MfDLh7WHcatQFHB4prRJrULNDnOSJz+LD2UAu602/s03c2lIEHiVkTb8AATrFE8O
FZvfEdge3gjEXaK1zO1/eNScUgHH8eESBDbWk2ACkU/p7Ip9MS5FgcWXVBxEUoDl
46VkGOuqWFwGgY020Q+Tvo7I6r1+MahDttyCKe34bzu0WB/t19del0moZyHhicgS
oNyZN8rIM5QPmuwi1glNkPi8uL23QLb3frSVmrTflx1GxKBhB+fyN/TQP+42Y1zJ
eBbSWPgWoWHC7u3ULQYA1Mjbi5DUh8dAjwWIJXsFIJwL4oGb54mX/vE2ef9YAHpI
x1p+7ds2vdDYqG2o5UXaI9YPg45kDNVm+/Io5+DXNMKGVH6XIyhr/Uy5dzx6tVHK
CdPBC3K4hWSLU6rlwFhwXJ0d5kc2AuRrcmDi8Q+FzSOHlLyt9zM=
=UxlY
-----END PGP SIGNATURE-----

--Apple-Mail=_700566DC-00D7-4239-B730-9CEAF4C860C8--

