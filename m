Return-Path: <linux-fsdevel+bounces-46090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E224EA826CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABFF7A8B45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62746263C71;
	Wed,  9 Apr 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FXtdxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E425D8F7;
	Wed,  9 Apr 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206895; cv=none; b=GEw8BqNdUtLgPWWzXEo2cAqKNkX5TtDWT7RvMursZd4z+Dd0F6xKZlhR0cVvn5nDoYZ51X5d2FRQ2pyS0QI50moDCaWSfzwSy50OH40KxgcUCObU95bxvUznFx42Aa+tvlrWeeOntzP9YAYIYw4UOiCcMkaDALZgDDwin7Cbl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206895; c=relaxed/simple;
	bh=l62lfA+qsXO3Hty6YOKap+JHa82eWUyqYR7tITdVoW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdJXNemPPVXkDJTx5VKhyYaHdWwtGpNVlZH/Ul78sqMZoQyJU1cAsm/weaNPe0TNMOKhdNn1MBk+pO8hqY5Ycz5pOL7pc8SfjIXNhLOQGWd6f0USnjQ0SRhdsOeUiyH0qSJQpR2alkzUNZiUT0Y6qR7j3C1Myyy6IA8rLxmKdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/FXtdxm; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736b98acaadso6769342b3a.1;
        Wed, 09 Apr 2025 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744206893; x=1744811693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck5x1Os3XZK/0cyOU2zPrzfxe2MOfnv7kkKaywV0D1M=;
        b=a/FXtdxmzgWgTyhSE7zM7K/wEU34v+F5oImMEWZKlFWLC9xltx/0zgVxNvI42u2CB/
         Y3HqZt8duf3HvRVBzalODJAUIaaGPcQLscVAXFjyAISljqvdp3GQNWNYyu3OOLocOESi
         oamMf+D69sHydttXNuEuOAV0+t0bf+mjszsGRDC7QDL6uUH5mdMS9TSPDrD/I2jz2di3
         sB3QEskHOmVSht+sG9ciu1kdN19tEoVOEPZU9BD7Hs7PSZ8SdZq1COHqc/c1nNPAwelU
         /0fQasQ1nVho0nj6YERyUYuAbiLLx+PYSwFb1kGMiizgR59UNmKWAyb6b18iWvmLtto0
         9Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206893; x=1744811693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck5x1Os3XZK/0cyOU2zPrzfxe2MOfnv7kkKaywV0D1M=;
        b=bsmp/p3dj3FsWcX7872Vn69emyNfy2ntU6OyfLbiqKBtY7qjun8Ogtn7bnk/tFgGBW
         6PoFmA8JTa3wKrg2718oZpFoFM8yxDkOFkncV8SQuvvZiHmo4sDnOeUj3SKb0/11bzlk
         1PZpACoYzREriBd0B6jP3ekTXOKs/EuFQgnWMc/Ts2NM9XclTIlebxRTN6NBZr8u/wKb
         hxjEo84gpfnxHd0kZ0f+P95vB2HPkwYdfdt9Bg+z85hM62pPgKF5IT1Vx6JC70z/tau9
         vM4COTe5Ho6k4U6umHjHiO/cdmBJxjODHRKmz8vxncWlCmi+8evTq2G0s867gG/Qf0Px
         Js5A==
X-Forwarded-Encrypted: i=1; AJvYcCVugcnmzf7UpJfBcyBYt/f9TL3NzjynKVPuR7nU+X2WJEf7K5Ds8ZKI5xVSJrSiw2nTqX8+4sIukaLJ2mV4SQ==@vger.kernel.org, AJvYcCWhwbGGlQIcrJA7onkPyjgD3DiDc8WgZEWE7C3gWygudAcGzhz2zPHZJ7nZEt0zYlrI8ANEQJXOYs0=@vger.kernel.org, AJvYcCXUIHslFNSx2dASn/s8UMvQlz7X4Gg7fO52UMHfUnz8cHbnjYZWVF837azB0qD+FKAYKhaBspAo0ap8VT0O@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAfWeMoZmfIitHkjYsQAtr35cHzIsTRi3BNnzufJ4XPwE9u49
	OCdahCTQ51gwinr1i8SpRZ1my0OApLn9PeOVywZIGiKSdeFjdVtS
X-Gm-Gg: ASbGncstsRiu09GTYYY4GlKnKqomflujBDkUr6c1BOdTL6uurxU83nHO5ifCce2QvLB
	NQO9j65rC3jNNYE90tDnSNP+x1NDLBCE49fVKiZ85/1D5L0ctSQwc6DGO1Uh9B7tnCYggeQlLRp
	7HGLDwzfLG4YJg4O6FO8WZtKg1vgAtFGSSJITFml85nKLfVoT1zxw9sRedTFsG159sN2BhbphXF
	Hh4tXsjOfrB2ZZGhS90Gltks1UZ4KEYrBjWMeJPjxpInzIWmiYx201zvrW1LoseGNEiUNcy+mWD
	GfAMilpfE5zDRC4bki3WFS5fL/GTK+54d8SwzivT
X-Google-Smtp-Source: AGHT+IFEi7SqRiamwHVaIArODOzildac58F8STHvutYU/t9tuBTrTIgwu0rNZ9BjKuR7FVoLvQ6nVA==
X-Received: by 2002:a05:6a00:2186:b0:736:5dae:6b0d with SMTP id d2e1a72fcca58-73bae4c410bmr4085500b3a.10.1744206893312;
        Wed, 09 Apr 2025 06:54:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d469aesm1368048b3a.50.2025.04.09.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:54:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CBF324236D23; Wed, 09 Apr 2025 20:54:49 +0700 (WIB)
Date: Wed, 9 Apr 2025 20:54:49 +0700
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
Message-ID: <Z_Z8KVgaH-ksEKog@archie.me>
References: <Z_ZHoCgi2BY5lVjN@archie.me>
 <Z_XOr4Ak4S0EOdrw@archie.me>
 <1565252.1744124997@warthog.procyon.org.uk>
 <1657441.1744189529@warthog.procyon.org.uk>
 <1676060.1744205063@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mw29LLaiVHxc5DtG"
Content-Disposition: inline
In-Reply-To: <1676060.1744205063@warthog.procyon.org.uk>


--mw29LLaiVHxc5DtG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 02:24:23PM +0100, David Howells wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > > > > +Further, if a read from the cache fails, the library will ask th=
e filesystem to
> > > > > +do the read instead, renegotiating and retiling the subrequests =
as necessary.
> > > > Read from the filesystem itself or direct read?
> > >=20
> > > I'm not sure what you mean.  Here, I'm talking about read subrequests=
 - i.e. a
> > > subrequest that corresponds to a BIO issued to the cache or a single =
RPC
> > > issued to the server.  Things like DIO and pagecache are at a higher =
level and
> > > not directly exposed to the filesystem.
> > >=20
> > > Maybe I should amend the text to read:
> > >=20
> > > 	Further, if one or more subrequests issued to read from the cache
> > > 	fail, the library will issue them to the filesystem instead,
> > > 	renegotiating and retiling the subrequests as necessary.
> >=20
> > That one sounds better to me.
>=20
> I think I like this better:
>=20
> 	Further, if one or more contiguous cache-read subrequests fail, the
> 	library will pass them to the filesystem to perform instead,
> 	renegotiating and retiling them as necessary to fit with the
> 	filesystem's parameters rather than those of the cache.

I prefer that above too as it is more explicit.

>=20
> > > > > +Netfslib will pin resources on an inode for future writeback (su=
ch as pinning
> > > > > +use of an fscache cookie) when an inode is dirtied.  However, th=
is needs
> > > > > +managing.  Firstly, a function is provided to unpin the writebac=
k in
> > > > inode management?
> > > > > +``->write_inode()``::
> > >=20
> > > Is "inode management" meant to be a suggested insertion or an alterna=
tive for
> > > the subsection title?
> >=20
> > I mean "However, this needs managing the inode (inode management)". Is =
it
> > correct to you?
>=20
> Um.  "However, this needs managing the inode (inode management)" isn't va=
lid
> English and "(inode management)" is superfluous with "managing the inode"=
 also
> in the sentence.
>=20
> How about:
>=20
> 	Netfslib will pin resources on an inode for future writeback (such as pi=
nning
> 	use of an fscache cookie) when an inode is dirtied.  However, this pinni=
ng
> 	needs careful management.  To manage the pinning, the following sequence
> 	occurs:
>=20
> 	 1) An inode state flag ``I_PINNING_NETFS_WB`` is set by netfslib when t=
he
> 	    pinning begins (when a folio is dirtied, for example) if the cache is
> 	    active to stop the cache structures from being discarded and the cac=
he
> 	    space from being culled.  This also prevents re-getting of cache res=
ources
> 	    if the flag is already set.
>=20
> 	 2) This flag then cleared inside the inode lock during inode writeback =
in the
> 	    VM - and the fact that it was set is transferred to ``->unpinned_net=
fs_wb``
> 	    in ``struct writeback_control``.
>=20
> 	 3) If ``->unpinned_netfs_wb`` is now set, the write_inode procedure is =
forced.
>=20
> 	 4) The filesystem's ``->write_inode()`` function is invoked to do the c=
leanup.
>=20
> 	 5) The filesystem invokes netfs to do its cleanup.
>=20
> 	To do the cleanup, netfslib provides a function to do the resource unpin=
ning::
>=20
> 		int netfs_unpin_writeback(struct inode *inode, struct writeback_control=
 *wbc);
>=20
> 	If the filesystem doesn't need to do anything else, this may be set as a=
 its
> 	``.write_inode`` method.
>=20
> 	Further, if an inode is deleted, the filesystem's write_inode method may=
 not
> 	get called, so::
>=20
> 		void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
>=20
> 	must be called from ``->evict_inode()`` *before* ``clear_inode()`` is ca=
lled.
>=20
>=20
> instead?

Oh, that's what you mean. I'm leaning toward that.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mw29LLaiVHxc5DtG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/Z8IgAKCRD2uYlJVVFO
o5HPAQDy1q+hkQLGUz2eIQuYUYZGJRqgXajUmKCcHO/UePy89AEA2vX0c8cV0sWf
wkzObFZq/dAFvmxB5foaGxCw0X9M8Q8=
=RmrE
-----END PGP SIGNATURE-----

--mw29LLaiVHxc5DtG--

