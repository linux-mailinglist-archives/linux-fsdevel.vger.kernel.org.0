Return-Path: <linux-fsdevel+bounces-37884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7185B9F881C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 23:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F5164E80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761441D86C3;
	Thu, 19 Dec 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGPRVuX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92C2AE96;
	Thu, 19 Dec 2024 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648732; cv=none; b=Vggzzv2d0j4RKX6ZLO01b0M4BVj7KcjDaic6ZqXLY51EUGDsppNWGlHWnWII4pLwiMpfkLQ8qfSEj0iialvPGigPTao07nVxojEvtMo6WrE/BirP9DFfSDXPP1UQ26rH8lyOyEQvMLdCZA3dO+1mx5O8IZstw05NKpTzdAgSMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648732; c=relaxed/simple;
	bh=15i2Yf3WvNbPYR2CeeyGmn0NLChz4hZ9/foJ9BNFIPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ppc3OthRJwwdZiTqjnDPOyHMkZ6lOGZcPKy2ixEUOQEvhzw5VSLrJe5Gv1XVVt6Qobt+gcUCGWnNYq5tLKwaaBbpjg+hzIw1CsM1IR+QzrEuYPOtvz4aQAnoc1N9tEjVy+2PCi+unDT5TZ2AY8x1rF6yRC5amAFGfQxZp8mwf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGPRVuX4; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8f65ef5abso10580276d6.3;
        Thu, 19 Dec 2024 14:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734648730; x=1735253530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp/htC487sqv/1tkg8tsXKWi7Ae2CyTqYDyO16YYE1A=;
        b=XGPRVuX4lrhypKlP4KxFxUccKk9ILf6eYeOfq9D4GWle6esddY6PMYI1xF5JyAfDji
         Wk3bP3QY0j7uyqZV+aDEwyIuNrIsWzKHcBjplUPz09aSMKtbHSO3b+DHQ2TGFbv8HXRK
         eSbrY1re3V0QFG0MXkZPp2jnmpVDPPfIOfAizuifMbDWAQbGNp0HcNdxhVYqvVcpOuzS
         PMihCIxf0RxEadIvfZMSfHQI+PGfkvicGmabDRgPnyc5sDqLMBQ+Fm/BHcVkcIY8M4ir
         s54PZMkZ2CZkcNUGBNUJF2CBGwmzpUv7EXSWZDbYGNPCgPg0+IArCqWsh4CnyL+4PiRr
         lWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734648730; x=1735253530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp/htC487sqv/1tkg8tsXKWi7Ae2CyTqYDyO16YYE1A=;
        b=gZfr6s9vzq0CDI82zuYcJfugzLarhKEWTKiN2rg3IM2x4CY5Zk52zkzXE7BaIr7v6i
         ukhnA5I8VYyrciXF6EkYIrFe6RnsHzspeLLydbRAPqcfSs1mxJx++5Mk5YEf3E7EUDNm
         XY2myu1EBGuAyCd6+GhZJKyn1J5pNAaztQEeoXRLSPydjhd0vre2nBW6dwHu1n0C1Vt7
         FzxmoAwCjhtkDcb3GJprxo9WnGQcQ3hgAR1JSEGLeFDzUKIiVnvnlp3n3MXMCamF2W0Y
         ZML7oVYvxFf7w0FxYyIOczb94pbPmjhtCNb/TXMIefSAEik3uG4DLVerucHr/AvcHU4K
         hYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr4+WhzEgwomp2ithjRCFN5oAG2ss9bz5m22hkijn4Fav86k0+tx7qoPJrHg1L9eIsuouKMCb4x3fqStsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpttvFhn79RbY1YBHcfLY38N1BNf5/jq4DHNf1WQ2difXnBV+
	Y9gO9N02vR5aBtqGedAHQthgHaD+2Vh5hY2JDqHrNlNFhh0lAu9ArEhRt6DcRmi0q2Au+OiPvj/
	MCQ9Xpdw/1OW7EDlqyRfS0D7smDI=
X-Gm-Gg: ASbGnctS3RvjI35ragoyxhrAuG87WWldBa/HKrq63ws+YDW0pBvC8CVqbXvyXqAbrw8
	AQsEU55OE0Txlw5LNYVtaAfCw77rufetmkkJRWrM=
X-Google-Smtp-Source: AGHT+IGRMz0brz8SSQVM3I7RiL1V4Hu6DujwJaSEOEsezJqEbpFkLoGqHvvlt1OimPK5lskPxEUvsxX2gj6bIjfYbnI=
X-Received: by 2002:a05:6214:449f:b0:6d8:7a7d:1e6b with SMTP id
 6a1803df08f44-6dd2331efc0mr14342636d6.10.1734648730161; Thu, 19 Dec 2024
 14:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com> <20241219175106.GG6160@frogsfrogsfrogs>
In-Reply-To: <20241219175106.GG6160@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Dec 2024 14:51:59 -0800
Message-ID: <CAJnrk1avghdbecZO_fNJjQ3m_1zw=6zsHY8+R0xx7cb2qGNiNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by hugepages
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:51=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Dec 18, 2024 at 01:01:21PM -0800, Joanne Koong wrote:
> > Add support for reads/writes from buffers backed by hugepages.
> > This can be enabled through the '-h' flag. This flag should only be use=
d
> > on systems where THP capabilities are enabled.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 92 insertions(+), 8 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 41933354..3656fd9f 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > +
> >  static struct option longopts[] =3D {
> >       {"replay-ops", required_argument, 0, 256},
> >       {"record-ops", optional_argument, 0, 255},
> > @@ -2883,7 +2935,7 @@ main(int argc, char **argv)
> >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> >
> >       while ((ch =3D getopt_long(argc, argv,
> > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyAB=
D:EFJKHzCILN:OP:RS:UWXZ",
> > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyA=
BD:EFJKHzCILN:OP:RS:UWXZ",
> >                                longopts, NULL)) !=3D EOF)
> >               switch (ch) {
> >               case 'b':
> > @@ -2916,6 +2968,9 @@ main(int argc, char **argv)
> >               case 'g':
> >                       filldata =3D *optarg;
> >                       break;
> > +             case 'h':
> > +                     hugepages =3D 1;
> > +                     break;
> >               case 'i':
> >                       integrity =3D 1;
> >                       logdev =3D strdup(optarg);
> > @@ -3232,12 +3287,41 @@ main(int argc, char **argv)
> >       original_buf =3D (char *) malloc(maxfilelen);
> >       for (i =3D 0; i < maxfilelen; i++)
> >               original_buf[i] =3D random() % 256;
> > -     good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > -     good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > -     memset(good_buf, '\0', maxfilelen);
> > -     temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > -     temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > -     memset(temp_buf, '\0', maxoplen);
> > +     if (hugepages) {
> > +             long hugepage_size;
> > +
> > +             hugepage_size =3D get_hugepage_size();
> > +             if (hugepage_size =3D=3D -1) {
> > +                     prterr("get_hugepage_size()");
> > +                     exit(99);
> > +             }
> > +
> > +             if (writebdy !=3D 1 && writebdy !=3D hugepage_size)
> > +                     prt("ignoring write alignment (since -h is enable=
d)");
> > +
> > +             if (readbdy !=3D 1 && readbdy !=3D hugepage_size)
> > +                     prt("ignoring read alignment (since -h is enabled=
)");
>
> What if readbdy is a multiple of the hugepage size?

Good point, the user could potentially request an alignment that's a
multiple. I'll account for this in v2.

>
> > +             good_buf =3D init_hugepages_buf(maxfilelen, hugepage_size=
);
> > +             if (!good_buf) {
> > +                     prterr("init_hugepages_buf failed for good_buf");
> > +                     exit(100);
> > +             }
>
> Why is it necessary for the good_buf to be backed by a hugepage?
> I thought good_buf was only used to compare file contents?

good_buf is used too as the source buffer for the write in dowrite().


Thanks,
Joanne
>
> --D
>
> > +
> > +             temp_buf =3D init_hugepages_buf(maxoplen, hugepage_size);
> > +             if (!temp_buf) {
> > +                     prterr("init_hugepages_buf failed for temp_buf");
> > +                     exit(101);
> > +             }
> > +     } else {
> > +             good_buf =3D (char *) malloc(maxfilelen + writebdy);
> > +             good_buf =3D round_ptr_up(good_buf, writebdy, 0);
> > +             memset(good_buf, '\0', maxfilelen);
> > +
> > +             temp_buf =3D (char *) malloc(maxoplen + readbdy);
> > +             temp_buf =3D round_ptr_up(temp_buf, readbdy, 0);
> > +             memset(temp_buf, '\0', maxoplen);
> > +     }
> >       if (lite) {     /* zero entire existing file */
> >               ssize_t written;
> >
> > --
> > 2.47.1
> >
> >

