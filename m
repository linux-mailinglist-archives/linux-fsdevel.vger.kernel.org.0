Return-Path: <linux-fsdevel+bounces-46056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA527A821C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DB34617DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A325D537;
	Wed,  9 Apr 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KehurZTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42A25D21E;
	Wed,  9 Apr 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193447; cv=none; b=t8lTxrxCIFab9cclkSb+5TTsrYevuBk023/GSOvjPc2HGXyJ3dVhzvUL2k6NEuRRxj1d2keJ+BAXgocTolNlwUgtBVX8+iLR9Okzem1jzISHwJY30xMY57cLJe1KK8Ho3UFsTgIeyac24+dYEwmQ9FGw0zQZwHLcVDDltL7s7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193447; c=relaxed/simple;
	bh=hNrJ/ccAQlLCeeRpKoQJKKWsRNyGqVchdeOfcX/ZiDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grt8WeKuKtULQIU1dgPLcTYR4CXtImKrUeydsLz1oIGFWuLVZwT6t7up5UEtFxFD/x3BrKcmiZb6dnAUuSi/IZiPML5NsvRL4n1tpT94nGiVttg53OCnkOLzxJUk2XPEBuqTgX2MunpE2j3Jr2WmVOgpCY+Jj0l+TcUt5KjHqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KehurZTR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-730517040a9so7997502b3a.0;
        Wed, 09 Apr 2025 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744193445; x=1744798245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHa1lD9OM2siXZI+Fk8h37HkF70Jc4GeVcg8Hqzei70=;
        b=KehurZTRFyVmRQSTAD9xxCCuEIa/B6dkluzswbke0+8sZAhPdxBDN3oeswdhlwV8UE
         OQY7Tu4tS3KrF8LzuWvOVZsAu9ha6WB7dh7BQRIrDaGX6SvuzsSO6AYoDAdbMFsCwGiU
         +j6kDHY2ikigxVtAsPCf+AqKgUi8sywdk6Kt504Xmbq1nB96aj8H64FNpdjSIKAsmRji
         mwY4M26Weva+eCYgHUf0xuXc3Gw1NNW23x+aHGM73hH558XaFDKhG5z16w4H8Q1GIRBG
         SiEGH8QfX+s5wAaJlBeOZ16Q3uutEC4gvPNL0W2b49fJ0aEHQe1gPnmS4Z4P3vgEnLzs
         10Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744193445; x=1744798245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHa1lD9OM2siXZI+Fk8h37HkF70Jc4GeVcg8Hqzei70=;
        b=gyDywwsCQMY8gKPdlR53HSzLOqdo8C2I3ovL2Hcu+UGJzGi6vyES2VWtxw+47AEMn3
         newpTZ/U7vYhirT8sclWgyz362ujbvyiYXlWInLY6LF6C5LDrgxNvb2UDr/wUOIKPItl
         XyHHLedZ2V/ZCXQ8/t7nkVhKmZjx8i/CyDRKuhvNX+FQpZ7kF6MEVjhg/UZKbtmtIEQK
         tvJFHAK1x2LFejkppenlbBdvGJhNm1fBu1SmuOOGqVuwJTK/0hbgSAA37DDDmKjUKxsn
         pr4VbUgyG7qSJ3xGlbO30pClpk1+WEhVbrU+DQ+YNXDAnNIX8qcgOqkncJln8U6nSxyK
         8tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh0cH04D0SNFh9sACJB0rIunl11JMRRBZILXM818POczb80FCIQePrxLSAmiU7UJzPsc/2HOLu69k=@vger.kernel.org, AJvYcCWMvww1iF0N4I+z8mC7M+CBYTbD/IM8R46DQrYaRKZUKHpVsdt0QZKB9tHKWakDStIY3MI75zh2jRrEqvv0ag==@vger.kernel.org, AJvYcCWkRe5xaMihd/xpHQrfUNrYUktn9ij1pkWKXgu7OXba+Usi4xd2RCXf9XoJVchxf3p2vJYN7JWnwMb8eArY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Xo7lsyffuNhWPG7ZliAalZch2mslHN8dRg4MXz++J+d3GRSv
	DFWFBY3YI7S+8zT441nbW211oPRkTjSFvuE5nDxXyvtn7gCF1gKj
X-Gm-Gg: ASbGncuOJOZ9L1dhv5h68QqYDXxUMxtm4P8M1a59D6M4HFoCk1Cdt1Btu408+ueId3m
	MrXWwsO0mpqLTeMeT2rfAtjUwuydy4aYFdTU19MXhoBOu+bZDQU8fxJ0fvaECaHnas9QUWO0n2P
	EqvJ6OS3NwU2Wh/l44qvDkJt5OllrAMgdf0abvpFMq0cF0E/+AQGaxBZbxtfpw4bBwuR9vFLkwV
	DFueRiC1v+ZwhaxHPRp0KjF7PBIP2mhQVCyy05VvgoOP9gcZnxbgzJvK7hSV9BdtWYWa39rmCJY
	dA6+NQo8PfC8iaT4pw6ys6bk3kCz4wrogAoXaTnA
X-Google-Smtp-Source: AGHT+IHQAF/RGnL8ythIUl3544itvHiQ4tndYDfavVjoYnzvbTxExsWO+GFwKENdwurwiQE/DaSyOg==
X-Received: by 2002:a05:6a21:9106:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-2015b00f776mr2580775637.42.1744193444326;
        Wed, 09 Apr 2025 03:10:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e4d8e8sm899059b3a.126.2025.04.09.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:10:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A57404236D23; Wed, 09 Apr 2025 17:10:40 +0700 (WIB)
Date: Wed, 9 Apr 2025 17:10:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>, Timothy Day <timday@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>, netfs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Update main API document
Message-ID: <Z_ZHoCgi2BY5lVjN@archie.me>
References: <Z_XOr4Ak4S0EOdrw@archie.me>
 <1565252.1744124997@warthog.procyon.org.uk>
 <1657441.1744189529@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KOQW9OuYN0wKoufu"
Content-Disposition: inline
In-Reply-To: <1657441.1744189529@warthog.procyon.org.uk>


--KOQW9OuYN0wKoufu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 10:05:29AM +0100, David Howells wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > > + * For writeback, it is unknown how much there will be to write unti=
l the
> >                                              "... will be written ..."
> > > +   pagecache is walked, so no limit is set by the library.
>=20
> No, I mean "how much there will be to write" - ie. how much dirty data th=
ere
> is in the pagecache.

OK.

>=20
> > > +Further, if a read from the cache fails, the library will ask the fi=
lesystem to
> > > +do the read instead, renegotiating and retiling the subrequests as n=
ecessary.
> > Read from the filesystem itself or direct read?
>=20
> I'm not sure what you mean.  Here, I'm talking about read subrequests - i=
=2Ee. a
> subrequest that corresponds to a BIO issued to the cache or a single RPC
> issued to the server.  Things like DIO and pagecache are at a higher leve=
l and
> not directly exposed to the filesystem.
>=20
> Maybe I should amend the text to read:
>=20
> 	Further, if one or more subrequests issued to read from the cache
> 	fail, the library will issue them to the filesystem instead,
> 	renegotiating and retiling the subrequests as necessary.

That one sounds better to me.

>=20
> > > +Netfslib will pin resources on an inode for future writeback (such a=
s pinning
> > > +use of an fscache cookie) when an inode is dirtied.  However, this n=
eeds
> > > +managing.  Firstly, a function is provided to unpin the writeback in
> > inode management?
> > > +``->write_inode()``::
>=20
> Is "inode management" meant to be a suggested insertion or an alternative=
 for
> the subsection title?

I mean "However, this needs managing the inode (inode management)". Is it
correct to you?

>=20
> > > -The above fields are the ones the netfs can use.  They are:
> > > +They are:
> > "These fields are, in detail:"
>=20
> It feels unnecessarily repetitive to say "these fields", but "they are" a=
lso
> sounds stilted.  How about I rearrange things a little.
>=20
>     The request structure manages the request as a whole, holding some re=
sources
>     and state on behalf of the filesystem and tracking the collection of =
results::
>=20
> 	    struct netfs_io_request {
> 		    enum netfs_io_origin	origin;
> 		    struct inode		*inode;
> 		    struct address_space	*mapping;
> 		    struct netfs_group	*group;
> 		    struct netfs_io_stream	io_streams[];
> 		    void			*netfs_priv;
> 		    void			*netfs_priv2;
> 		    unsigned long long	start;
> 		    unsigned long long	len;
> 		    unsigned long long	i_size;
> 		    unsigned int		debug_id;
> 		    unsigned long		flags;
> 		    ...
> 	    };
>=20
>     Many of the fields are for internal use, but the fields shown here ar=
e of
>     interest to the filesystem:
>=20
>      * ``origin``
>     ...
>=20
> And then put the bit about wrapping the struct after the field explanatio=
n:
>    =20
>     If the filesystem wants more private data than is afforded by this st=
ructure,
>     then it should wrap it and provide its own allocator.

Looks OK.

>=20
> > > +   This is not permitted to return an error.  In the event of failur=
e,
> > > +   ``netfs_prepare_write_failed()`` must be called.
> > "This method is not permitted to return an error. Instead, in the event=
 of
> > failure, ..."
>=20
> Seems superfluous, but okay.
>=20
> (Btw, can you put a blank line before your "> <snipped>..." to make it ea=
sier
> to go through your reply?)

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--KOQW9OuYN0wKoufu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/ZHlgAKCRD2uYlJVVFO
o3SfAP4ky3mQ4SL3aFrNICEAhPDaiLmNTwZVUKj0hCDGGB4v2gEAu82AiCi2iPt7
KCtYDhPrYatH491Cs2azUBWzbpO+wg8=
=2vDf
-----END PGP SIGNATURE-----

--KOQW9OuYN0wKoufu--

