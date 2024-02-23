Return-Path: <linux-fsdevel+bounces-12531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D386091F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 04:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371CF285FE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 03:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025CFBE4;
	Fri, 23 Feb 2024 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="gZujQBrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D186DDBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657398; cv=none; b=ns1yaRk76msvPdU8qgIDpglZnEtp7MMqun/w/gT66rdLSoHq9CXKkURuathUGjtk+3/nnUWcUyPQHQ67DFkB6Mo9EGJxoZqnb4AaJQt6Bs9ipHG23g4VLR44WeiQ4ITUyL1CFr7h2IcnO9HIQs9GttoWBOzQRQOzxZ7Twr2UvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657398; c=relaxed/simple;
	bh=IdyE98yA+G44f4aEGVaTuKR+9kGIFzoy8Z9sqTMdNm4=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=fDcSh6m/ezA/MmdVXM9lN/+tNTPKdMh3MFSrslKl+c4qZqYUFTSRsIkeznQr4TOPlLWYVh6duzkrFHWLJoJ7aGWYKfgY2Lym2yhmRZA4ZillFrUAoq6t0/BIswkAZQJ8UHuhbns7MrNjhokyBn5S4FDieTo7GAAi2d5cTI8Gr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=gZujQBrX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29951f5c2e7so369243a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 19:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1708657396; x=1709262196; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRbla0f/Hl6rGJ+ONURsPxKzzUMpoaT/YVrejYpQIh8=;
        b=gZujQBrXzMnjYCRsdY38eTNpVOmPjFm9AAhmR8QFjrSlDdMHg6XvKCvO7eUAJFdyMI
         ql79t3kyRAWj43bzFAgEzOK9pl7xMu7fGE21GpKgLA3jckNWufRqjOQKJlAXbqIszMWA
         8JH2JnoTiL76BnFKLw/LH8VlT+EHf9wTIhKFqYCf8c0ojeUVDinNsObxJqOi4k23X2WR
         YDltk5cOT1kGByrXWQNbIcXpSOAJX6vExcf2iGPURZKUZvJiKDTEnXTb5quuv67bQbqa
         +bA/OCxkX3ccp/J1BnCWDSDC/Y3VZp2z9Ma9025vRFhFwszPeJbFfskxhKTcQ0h9zMY+
         Q1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708657396; x=1709262196;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRbla0f/Hl6rGJ+ONURsPxKzzUMpoaT/YVrejYpQIh8=;
        b=dxnXbJB5FpVZWodACRYiOeQVNG9fd7VJLdVowTDQYMMbqpYhLp1dGpHdiBBdhuPVR2
         J72dtHwPSXE63NRqidqLZ6xRDcccDGxjugJG274pdrGVHbui0Otod8Cuo7SEbHXAahzG
         tjyGG/StsyQ7zg9u/wXHU0P6B7TOC/Z6EiJASxZvbHsxegjVtD8ZET64PaZ7JjiHcjhK
         CvoYdzvsj6yzW0ZQqDZxprtJg5X2lG9Xu+AhGXrd33iQYtGB0kDI/WlovnQCcPp7AGQ6
         yN1j0+aLIBqiDt8+eOhtpYrlHalq673GAY98CJmlAOiF6ZAVlWCHa5S9RZJO/DrwuiVA
         M1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXXwjleP3LtRe5n1bJPvHy2e8yEdhya8BL+ft9Z9nkntuGO+/f52CwhWmXsKULCl8PGVx6EGee6iXytWxHAv/ssvgKM6tM/Jf+SGQVBYA==
X-Gm-Message-State: AOJu0Yx3RTyC7vVKVXJPUwGB6lu8o3SK7uyuC8LdVplJv7gTl4IuM0JL
	nW/D1qQYSGtK/gC2/Wyk+SRSGh2fqJvn4sToa4TItV1P6pgz/JW7LM+Mq0vguzA=
X-Google-Smtp-Source: AGHT+IGJqnlYOapYN19RR+kXIGIG4wNS531YY06c5pt+RcA/HoLkHhJLwaHFhA7xa4Mgo19sRY5rxw==
X-Received: by 2002:a17:90b:2394:b0:29a:6d80:364 with SMTP id mr20-20020a17090b239400b0029a6d800364mr597656pjb.39.1708657395659;
        Thu, 22 Feb 2024 19:03:15 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id nr5-20020a17090b240500b00299fe9c395asm238960pjb.4.2024.02.22.19.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2024 19:03:15 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <1B53E6AF-0EFA-4290-A4CF-CFA7F3BF0E51@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8E84EA68-A783-46F7-8DB7-9FF3874ABA36";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Date: Thu, 22 Feb 2024 20:00:46 -0700
In-Reply-To: <CAF8kJuNt2Vqk0yGkuz7qHAui7tb9B1W6U+SLyTmc6N2ngCU53A@mail.gmail.com>
Cc: David Howells <dhowells@redhat.com>,
 lsf-pc@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
To: Chris Li <chrisl@kernel.org>
References: <2701740.1706864989@warthog.procyon.org.uk>
 <CAF8kJuNt2Vqk0yGkuz7qHAui7tb9B1W6U+SLyTmc6N2ngCU53A@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_8E84EA68-A783-46F7-8DB7-9FF3874ABA36
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Feb 22, 2024, at 3:45 PM, Chris Li <chrisl@kernel.org> wrote:
>=20
> Hi David,
>=20
> On Fri, Feb 2, 2024 at 1:10=E2=80=AFAM David Howells =
<dhowells@redhat.com> wrote:
>>=20
>> Hi,
>>=20
>> The topic came up in a recent discussion about how to deal with large =
folios
>> when it comes to swap as a swap device is normally considered a =
simple array
>> of PAGE_SIZE-sized elements that can be indexed by a single integer.
>=20
> Sorry for being late for the party. I think I was the one that brought
> this topic up in the online discussion with Will and You. Let me know
> if you are referring to a different discussion.
>=20
>>=20
>> With the advent of large folios, however, we might need to change =
this in
>> order to be better able to swap out a compound page efficiently.  =
Swap
>> fragmentation raises its head, as does the need to potentially save =
multiple
>> indices per folio.  Does swap need to grow more filesystem features?
>=20
> Yes, with a large folio, it is harder to allocate continuous swap
> entries where 4K swap entries are allocated and free all the time. The
> fragmentation will likely make the swap file have very little
> continuous swap entries.

One option would be to reuse the multi-block allocator (mballoc) from
ext4, which has quite efficient power-of-two buddy allocation.  That
would naturally aggregate contiguous pages as they are freed.  Since
the swap partition is not containing anything useful across a remount
there is no need to save allocation bitmaps persistently.

Cheers, Andreas

> We can change that assumption, allow large folio reading and writing
> of discontinued blocks on the block device level. We will likely need
> a file system like kind of the indirection layer to store the location
> of those blocks. In other words, the folio needs to read/write a list
> of io vectors, not just one block.
>=20
>>=20
>> Further to this, we have at least two ways to cache data on =
disk/flash/etc. -
>> swap and fscache - and both want to set aside disk space for their =
operation.
>> Might it be possible to combine the two?
>>=20
>> One thing I want to look at for fscache is the possibility of =
switching from a
>> file-per-object-based approach to a tagged cache more akin to the way =
OpenAFS
>> does things.  In OpenAFS, you have a whole bunch of small files, each
>> containing a single block (e.g. 256K) of data, and an index that maps =
a
>> particular {volume,file,version,block} to one of these files in the =
cache.
>>=20
>> Now, I could also consider holding all the data blocks in a single =
file (or
>> blockdev) - and this might work for swap.  For fscache, I do, =
however, need to
>> have some sort of integrity across reboots that swap does not =
require.
>=20
> The main trade off is the memory usage for the meta data and latency
> of reading and writing.
> The file system has typically a different IO pattern than swap, e.g.
> file reads can be batched and have good locality.
> Where swap is a lot of random location read/write.
>=20
> Current swap using array like swap entry, one of the pros of that is
> just one IO required for one folio.
> The performance gets worse when swap needs to read the metadata first
> to locate the block, then read the block of data in.
> Page fault latency will get longer. That is one of the trade-offs we
> need to consider.
>=20
> Chris
>=20


Cheers, Andreas






--Apple-Mail=_8E84EA68-A783-46F7-8DB7-9FF3874ABA36
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmXYCl4ACgkQcqXauRfM
H+DDDA/9G6tcCC1/Oa1ddLtr9tEvfJ58H2FNe6ZEBrNm16Kavw7WtfDnsXek+Z2Z
AebkBz8PmrXfoSypAwqjH5PnCnU9q65UN0xCBEbPZyi1OnHLorK8X0tGzEkPtJRd
o1f+MQw2poZTPrJYYZIrvWGtk+ifoL1nb0NyjWc4/NHeS6PZHID79wFXtvLudRTJ
itQUPARFM6gQ10uRy44d08KlBQtRBKPPaT34+Ov502+iJxsrs6Abpr03ol9sIsK6
/Dw31dqLgkP1Dg/hiFHQpkDAEsYjn2QIPZZQ/889E++yMYtRxNqp4MQ7bdsnjiRW
gWKtU8EPx3z6PHN0u7s0RipDQmmWT1l3KyfT+meunJvkHNRkGfBSURjUDroAG8yl
lZnK/w9y6GHIp9s0Ho8byn9osgEyoW68HDdgr3Ubfqtw2T/yL0fZtuhcooShmDDL
udyEn4VFlaOsdeF6F2YM9m3ERXsGvzu4Il34rDH4iYWc6Bd5zuCBkCWwpK+Hw9na
li2ykVgDedJzTVmGGITn/FslxmnemMI+btkfX9g+pBqXY3ZgN7d4ud3EUl0u4tyA
BtJSa51D9JXP2e7rRxXTw7MZITOA8O2QODfAquNj9/2oUsH5GTmEfh1Xbda0Ux+T
1wO/SoXrtFx3Cp9QPbroluMe3XeXTNSeTNrxtcM6p21pgmqea8U=
=DMhO
-----END PGP SIGNATURE-----

--Apple-Mail=_8E84EA68-A783-46F7-8DB7-9FF3874ABA36--

