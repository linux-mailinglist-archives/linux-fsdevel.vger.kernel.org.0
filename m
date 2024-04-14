Return-Path: <linux-fsdevel+bounces-16881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF28A4036
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 06:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975DB1F211DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784118659;
	Sun, 14 Apr 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="azo+8vBK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E21758F
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713068173; cv=none; b=LXYwXve2poW2quMYgo7qr90lNBshbUZp8hgsAQ7RHu4eGh3HewiD4HGeleMONUr9uvGR82tB0E8Mc2xE8yy8lB6m7q2AuwUpdRErQoxQTkaMCYw0c+c8qsWjWzBK4PFtFNCbvMIw6KGpUdacwexYDT5UWtcCzALuoafoUKMR9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713068173; c=relaxed/simple;
	bh=tbT2uwQbheewel6rLTeCmHfhAkQizC2YAsizILFY6EQ=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=UVpdY3YIYyye4RYykGD9jcTWGaHd9fNSMHkUkYNZ2oft8/a8ZeyPRtreHGb36o577j9NV1Rvk4MEbhGB5ziXqhiIp2H+AaRa0iZedB70t7KxoLdsQ+jCLDAZUpQRBdmGvSQqs+G/mYQf3sBiq0Cq+1F0/U0ksWe0YT6hOldRIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=azo+8vBK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3f6f03594so12928825ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 21:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1713068171; x=1713672971; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa9DN/TNLIPv3KV/MuIUgpNXPm0/AK0S91wCcTvt0UA=;
        b=azo+8vBKcQ3sglYT8XakbUmzdq3lw23hX/W6VHOI0MRDweXpPhCFtC+p/U+LkPgXpq
         NgjHgQUV3iDnSOujvzi0SPe6nMwqq7qJrabsLwoH78rG+bkO8AcdUm9og87r+j9lmO9/
         VmSMYqhER/g34mAWt7xFuZN/HtLtA6zMgWxItbwJisdji7+lH0S6f3rSKFiuLzG2nGPv
         b9QLO83gXnNEW1vLrUUwhPmDuY5c7hJcjzmKjiqfiaqdMMHBZz3/sU+dwfnMXvlsXjpW
         BSzJR8RxPDbPcAaxd6ropXmboP8P92kmRoxov5bRgFz6wImes5Mrf8gEayP0zEusNbp0
         kTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713068171; x=1713672971;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa9DN/TNLIPv3KV/MuIUgpNXPm0/AK0S91wCcTvt0UA=;
        b=rmNWZG22wuIOWWb2FQ+ygu1aCQ7OeReP2rT0l/kQ6WEw2ZRH7Z3RxNe8gqqoXjATeO
         tIkc2ltMysPduIJMpSzoqfKSb7lBWrW2gbSi6JrDQfVJ1QSzxgUFfu62WHJSZHDNqkFq
         JAWeHNPXWHRpFruVikHe+8fuC4CSQPcLGe+rD3yVdOZu+l1yrj3Y51DiqU6DLQkJgPvN
         /wVckeghXBqgv/Vpd6kxsdgsDzJ9j28qnFDJICp7lrVQVaWKYdD2FAGvPb3jKWqU4JYh
         sTyGXl5dVGvAGTwVNvN7OJs28I1M0G7XkMY7iWHno+15b2C7v3Jn9FVlQ1G2p2S6XLzW
         yKBA==
X-Forwarded-Encrypted: i=1; AJvYcCVcdM2d750cakOh3+n5NqX5LXaqFgyG0OzuULQp7MlJw03VRv76t6EZyujSWqhJFtGIBwLzQMmgw2fnLwIZAxDRazd0oqwky8EflRMSow==
X-Gm-Message-State: AOJu0Yzx5ta4cHdBqZ6KEi3sTiUaeUc8RFV2PgfQFMMrrtqbqiaBxVwK
	zP5VPpHUWao8UJdRvNImntM6undntjiDZzZOsWudukR/e6R7Qjmfy104W1hpKcY=
X-Google-Smtp-Source: AGHT+IESpwxIKqGgQsFN0OkaHzqVmzmYT/UfrqvS9FukHYvTOuK5NnLjSpYm69kyVG8zhzuDe8GI8A==
X-Received: by 2002:a17:902:dac8:b0:1e4:ad9b:f770 with SMTP id q8-20020a170902dac800b001e4ad9bf770mr8118244plx.23.1713068171024;
        Sat, 13 Apr 2024 21:16:11 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b001d8edfec673sm5342477pls.214.2024.04.13.21.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2024 21:16:10 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <887E261B-3C76-4CD9-867B-5D087051D004@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3417505C-A477-4CF5-8245-C5D2C05FBA72";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Date: Sat, 13 Apr 2024 22:16:07 -0600
In-Reply-To: <20240414021555.GQ2118490@ZenIV>
Cc: Nam Cao <namcao@linutronix.de>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
 <20240414021555.GQ2118490@ZenIV>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_3417505C-A477-4CF5-8245-C5D2C05FBA72
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Apr 13, 2024, at 8:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
>=20
>> As to whether the 0xfffff000 address itself is valid for riscv32 is
>> outside my realm, but given that RAM is cheap it doesn't seem =
unlikely
>> to have 4GB+ of RAM and want to use it all.  The riscv32 might =
consider
>> reserving this page address from allocation to avoid similar issues =
in
>> other parts of the code, as is done with the NULL/0 page address.
>=20
> Not a chance.  *Any* page mapped there is a serious bug on any 32bit
> box.  Recall what ERR_PTR() is...
>=20
> On any architecture the virtual addresses in range (unsigned =
long)-512..
> (unsigned long)-1 must never resolve to valid kernel objects.
> In other words, any kind of wraparound here is asking for an oops on
> attempts to access the elements of buffer - kernel dereference of
> (char *)0xfffff000 on a 32bit box is already a bug.
>=20
> It might be getting an invalid pointer, but arithmetical overflows
> are irrelevant.

The original bug report stated that search_buf =3D 0xfffff000 on entry,
and I'd quoted that at the start of my email:

On Apr 12, 2024, at 8:57 AM, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =
wrote:
> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and =
at
> some point the address wraps to zero, and boom. I doubt that =
0xfffff000
> is a sane address.

Now that you mention ERR_PTR() it definitely makes sense that this last
page HAS to be excluded.

So some other bug is passing the bad pointer to this code before this
error, or the arch is not correctly excluding this page from allocation.

Cheers, Andreas






--Apple-Mail=_3417505C-A477-4CF5-8245-C5D2C05FBA72
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYbWIcACgkQcqXauRfM
H+BZJg//dKG4ukz8K7Y4yBljOWxkY67dgXd7uaHxDtenGyHe/wDSByka2SfF7t2e
/JzZzOv8+cz+CzbgSu/Rtn9SetSmMlTTuOSf1CKvBGECQsDS5leR6fYJvuwou/Kq
14MuYBJUuqyBJ66XEKshi8J1Xr+ABf5dD53iKU+jlMaIRQDyk7dEgZRH9nKgOjLd
YwGGonfkTr2RrqGlvXzr+gSmMwF0RZZ3G+n/i4LAJ1hEGDlfJQczuHwV9lCKnw/S
pzRrd6v3KuA3DnRXa024dQxog1S1tyQSzM+xRtJm3YvU94q+BOt7prfjR7wSxE0U
6GzGSDnvRC5ou1c8BK/TJnzP6NMwCE5pQpXOKPpDmpvdfh7DF22dBCxqewWWCBoO
g4qxPp8Rs1pTCpAnsRteQTJL0QFgBck0H+y4pRIrt+INS8M52InzAHmQuuckXjDF
5pXQDQd8G4CRwDQIziB4H/IfaRNywB6LAZyzvtDAeOzMidUVFg6KQgmEVWxxgIa2
70yZXJH2WCLLi+d9a1sO3Kcyuyl7FVxOYKFgdKDLBzDaMYLU3iaADFN25MG3DLxF
83Y/WWYYQfRwAFAAVsqEVl67iCyGOiQUxiFgOQCDj/qz/l3S2RIPIdNSxQOdFem+
5r+gP1MuGAfM4dsnOhBF844Oh8e9Ot5Bd/ngImDLMcrohjsXB2s=
=rxuh
-----END PGP SIGNATURE-----

--Apple-Mail=_3417505C-A477-4CF5-8245-C5D2C05FBA72--

