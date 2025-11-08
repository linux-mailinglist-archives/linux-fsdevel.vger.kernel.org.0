Return-Path: <linux-fsdevel+bounces-67529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16AC42A3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 10:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6610E4E5E66
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2762EC097;
	Sat,  8 Nov 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbCrXJqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8912D29CE
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762593581; cv=none; b=GsxrM8f17w9Y1UZwE2n4NmqHqdSJlV+xg7QEJVheIjDQQ6WUVIfn6435qFp8zskVVxhDBXTyIpbT/W44kuKevyOxh0Ng5AKIrEiAHpzYRoKieSowJWSiTC86iREkdAbJo+N7vQcLSkLHYl/hk9n96iWZVmjQ5o/NDoNV8/fSKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762593581; c=relaxed/simple;
	bh=Y49FEVhEZCj60/+Ylnua7B5NNXsJ25LsdBXGXmWxbi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf+Sfu1a4qPnc9YDFTCNgt5F1AbIkA8v9/0YNwVUeFf1ocPgu30AszpYFhg8UinAoQXbSgxMHsmiwVAL14jYL/NkbxRebEzubMEgmJq7H0G1nxQqv5upIX2OtfC7yVNetEOIoyXFP0ATJzMrxZmwMzFLeQ4z3oAqxgQ9Y7rFHEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbCrXJqp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba507fe592dso951071a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Nov 2025 01:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762593577; x=1763198377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMJJSbsWQXZcDWYlPD+q/sMKmcoPg7XO2KNCJJBRcPk=;
        b=XbCrXJqpU5Fw1gS912IzNS7KgBmBpEzt7BjCmmVFTL8kHJTuGLWxxwgdaXCUg4CV2D
         tKCOjl7wqtFqq2KqtRwQmCQoZ2kxqJrxqAaLSYbI9D+6BC6bJNEbr7E7KTvOL4UqahSf
         w/QgA8EXXBEeLOZgkH/mm2j8/uswIitunMmgBdG766MxnsGJq42mTLMaDjXhzkm/zaEH
         UtlB680jTq7xY0S9vzTnm9oN5yO7Du7xhiUuoHeQloIlgSzi/qSU8H/Y2rUf/XMJj6Bh
         tzv4XdJ7tB0GUfU9Ij+3Tup68eVUiffb9PZoDl640BmypjzahazCqHEiCv+hciS4uHrF
         TsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762593577; x=1763198377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMJJSbsWQXZcDWYlPD+q/sMKmcoPg7XO2KNCJJBRcPk=;
        b=eJtcsQ894hNH1IT7b6JeyhYXGmpbgZcc4Iy07DzX6kgnCgmcJsXsfbXs6H06lAT6Ej
         uapnEI9dipYMZB1r0Kt8s4HRSuwBvXCyraguqH48SL1jCGmO8VEJel7/Akzs/g9czSS4
         6SA9uu1l0uHkjl7kiKbGrXsBJyr8SbIDp8+VOnaTfQ8iuvX/V0Z3fiX5zUAyamCzLBbt
         ePslDWu9S+bDpme65MTnNFNX7y4HXQYmnmtYLSUrrVJeKBfna1oo1xuMrZFOXWluJzkk
         SzJ4ZM91C0ChO+5uOLfUq6S7/QYcDj/o+JAjXG+OAepvjHEozTojV5ctBCeiozOZNWId
         G+4g==
X-Forwarded-Encrypted: i=1; AJvYcCUYiQaYNziXFH4oE+3wIK1vktmMfCTcVYZ77hlON4REgrXa1wC18gNBeiYKrB8qe82OZMITarR3RVVWa54p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/sWAqNK7VYW1xuhD2NFcsTU2DnZfDJybhnXVyG57vFcHfKhiF
	4aS+QXncs1TKKcvUgScHBS9ENU1gan+UNNeUWH0NFRQ8tiPYjYQWwHOL
X-Gm-Gg: ASbGncteTYMNpDmpqGuR1AexQr+DoByUrp9/DDYcXkjCtOZ4QYs/TsqXHrZZE+A42mO
	SdVey9y1gIskC4K6Uc4f6E3YTjMCnDbYlgOmQOeXNnlrAgb0uxCSymHWPxyqVceIJrSvukbksne
	FkSKIBGZpmqVbCr4iZc8pLCYX70VXwuB5CCHfkaBCxpJSdkMleplQ/NFgFIq2Hw4RqelQaQdIbw
	gZH9z4zfqM+uvhfHOts7ICH9l206QJIeyR+t41z2fcXSRvz8u8j7xqHOuhEIQXY68kVWpaB7kxX
	y4Y8ee8tH1C7Z+fn7ddGY2eP+VQTyThABjRoWuORvG4nLmB4on3gbUvlFDvbeFewzB39B6k0PJ/
	c9FHpwgNAeNqPzMNLONUfLUwr4VgN2ScKu1+W7Z1nWXTgx3WCx/9QwpkTfhCWHjfLZxAxgVn/2p
	FPjBtFQiG+KoQ=
X-Google-Smtp-Source: AGHT+IGxcceL/cUmEO7hnoApXfEFPAPpQerRMJTCvaDgcasBmFqwVjXcVlI2/yGLIfmLK+orIB3gUw==
X-Received: by 2002:a17:902:da84:b0:292:fc65:3584 with SMTP id d9443c01a7336-297e56f9b21mr24987685ad.50.1762593577039;
        Sat, 08 Nov 2025 01:19:37 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c6b3sm82791745ad.24.2025.11.08.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 01:19:35 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 77412400200B; Sat, 08 Nov 2025 16:19:33 +0700 (WIB)
Date: Sat, 8 Nov 2025 16:19:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Chris Mason <clm@fb.com>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Hans de Goede <hansg@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	NeilBrown <neilb@ownmail.net>, linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
	ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	gfs2@lists.linux.dev, linux-um@lists.infradead.org,
	linux-mm@kvack.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] vfs: remove the excl argument from the ->create()
 inode_operation
Message-ID: <aQ8LJfKC0R-4ehLU@archie.me>
References: <20251107-create-excl-v2-1-f678165d7f3f@kernel.org>
 <aQ7fOmknHIxcxuha@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hTQgJTXrd9+JcPiP"
Content-Disposition: inline
In-Reply-To: <aQ7fOmknHIxcxuha@codewreck.org>


--hTQgJTXrd9+JcPiP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2025 at 03:12:10PM +0900, Dominique Martinet wrote:
> Jeff Layton wrote on Fri, Nov 07, 2025 at 10:05:03AM -0500:
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesyst=
ems/vfs.rst
> > index 4f13b01e42eb5e2ad9d60cbbce7e47d09ad831e6..7a55e491e0c87a0d18909bd=
181754d6d68318059 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -505,7 +505,10 @@ otherwise noted.
> >  	if you want to support regular files.  The dentry you get should
> >  	not have an inode (i.e. it should be a negative dentry).  Here
> >  	you will probably call d_instantiate() with the dentry and the
> > -	newly created inode
> > +        newly created inode. This operation should always provide O_EX=
CL
>=20
> This and the block below change halfway from tab (old text) to spaces
> (your patch)
>=20
> Looks like the file has a few space-indented sections though so it won't
> be the first if that goes in as is, the html-rendering doesn't seem to
> care :)

FYI: I'm using Vim. My important settings (in ~/.vimrc) are:

```
set nojoinspaces
set textwidth=3D0
set backspace=3D2
```

However, ftplugin override these for each file type, so you have to essenti=
ally
"fork" the relevant ftplugin file for each type if you want for your settin=
gs
to take precedence. For example, in case of reST, copy
/usr/share/vim/vim91/ftplugin/rst.vim to ~/.vim/ftplugin/rst and override t=
he
already defined options there:

```
=2E..
" keep tabs as-is
setlocal comments=3Dfb:.. commentstring=3D..\ %s noexpandtab
=2E..
if exists("g:rst_style") && g:rst_style !=3D 0
    setlocal noexpandtab shiftwidth=3D8 softtabstop=3D0 tabstop=3D8
endif
=2E..
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--hTQgJTXrd9+JcPiP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ8LHwAKCRD2uYlJVVFO
o2WVAPsFBRuUsYfWxAnWROgP/61sBqVYDc/UsPimcXm5dJJfgQD9ESTXpfxlpefS
VKeWBneX6svZYShHE5RzrbcYO+G5GA0=
=gW2v
-----END PGP SIGNATURE-----

--hTQgJTXrd9+JcPiP--

