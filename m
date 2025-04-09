Return-Path: <linux-fsdevel+bounces-46032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00768A81A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 03:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5137688746D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F59155753;
	Wed,  9 Apr 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/+a6QJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E94C81;
	Wed,  9 Apr 2025 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744162486; cv=none; b=rXOcZYy1MxHI7/o6AHbMVEvbYVGK9MBH8tm3/uk94wKf8816/bKRUvlTijeDvU7ll01qCdmheoO0vmqp11ybK06BcITukPYyAcOATbAPz6qcfACMCSvKEBa6H7EhhoiTufYMUpoajtC9z+XufO5ZH36Z99E99wyNzjU5NsKPBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744162486; c=relaxed/simple;
	bh=oeG+4HAagfYJR67bmiU5uGwhjpjwSraicPyYZz+OtWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEwYOacRXDg5kyRvKPGTWz6vhOK4IgJPNX5THY9NVPNoaGj4jGllMywEt9xX0tN+n+WstKPHJ35uLA3zo8uiVTsYUAyY0joaT9M+kgSJD85ig7CguJ0MNNhSwj6eG0e1a3YDRrAdQQALj9rdAMip5OgXIctsULo6Sg1dRtJcA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/+a6QJm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736ee709c11so5209487b3a.1;
        Tue, 08 Apr 2025 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744162484; x=1744767284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gWW7mQrB9d+AnX17ft9zAf82G6HqoBmSe5FjNlAnCs=;
        b=l/+a6QJmg/zL0RCobLwv4lMWEmcaTXKWHHbh2/pYW2cbwQ1765bf3rH9R4w5RlMZYR
         8jK2XECpEQW0vJMuE9Dc5bszg61DVbZieq6CeFvtRYwVSktN2WCOu3JMqUn3t0OUNcSl
         B8+jmphv7YJd5dDcM2qyKAfwctqXJjo4jLaPOjj/q5OefnEbZRBZsKmiSxDSBYHG/gEp
         GxeNt7zl4ab4d3/2RqlYlEOFs3GiVlYuvngDoTcQUGKNYxjAZhOjzIHe6k6oSf8GnQ2f
         zmDiLXWb0reajXO4y/Ejc6Xf9WNspQc5H7A4q+0Iwur+Eljo/SUOAmEb2nDBAemEHtYg
         BnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744162484; x=1744767284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gWW7mQrB9d+AnX17ft9zAf82G6HqoBmSe5FjNlAnCs=;
        b=mzz1KysGIJ6NmvaXZikiAj6/u1DHfn9ShYsdp3uEJsZhGrspCYKlY1748h5y7O2TUh
         O1EyIc1KCtBbYbTfJF7aBm+DlOq5FbEdg/fVklu6CrUfTScKgk2U9eXIl/ML4Ukev3WX
         tCaM5cKyWuPob+DSY0tTVF2S4EnR8joNvF8Xqdvx+ODm4tbgFcE6nuCYcvzSQQcnXzox
         EiT+Crm0Mv6YfeDWQTQzO9x2rOwFOuNKDy6d7Fn/8xNsKbbedB09jCIPOczwF2i04TXn
         Q7ddLJSv2QPVOvWOWGfMuDM8ANdry9esMJeALaSGppqimZ3BueB0Xo6evsf+evc1pGb+
         onBw==
X-Forwarded-Encrypted: i=1; AJvYcCWSrFyjRdPz2CFTDkppk+txJ/PrsAsrLQabrZ9EyC31PxD2/wTvkxQcnv1GktCAbvoQxfgXwWxm0JQ=@vger.kernel.org, AJvYcCXcdFQ1o0f5gGR3GAzEudxdg/Karecv8nURghGZOSCiiUpm3gtuqLnjVZsL3Fj2OjjCOnH8Tcxg2buYDyDcKw==@vger.kernel.org, AJvYcCXjC9AVDdoT/tzSP1NM1LlhX4/WIx/CeeqTdFrNbofdkG9bH8kd+21C5UwJbWiNUj5dgnfZxh7V367JoVDr@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLCQYFTaz5XqW5QAM6QQyzqKEoI4vjECHNeG7Pi79R9c1qm9r
	yYCDJXcoZ3SAdYtn/LeTXcZQT9kgC2/Q/DnTiPSiYL7YwyIXdwX0
X-Gm-Gg: ASbGnctZDvt8xHjxy0GOm58XxhgFpV8hjzcQ8Vr0y2M4tD5rackhiAo7Cn/1whijMnt
	zNq7Unr1aPyd7OVY/d0t2af0cR44bYYmPJwnHPx7rlXi1ESNqi+kzR0rW36O2EtXzlk5nNUQkpB
	4N7x+9z7NFIant8Jqa3RifHGCwHi0TP9zRdiIFKnUz7SS5fonCMgXybGEklOSVtWFiLwHvcdl01
	/Hj643Bq0vOAGvrscD1ygk0RwGoN+lQemipCadleN4OBp3AgvDHv0/bkkT2ZDFLMHS1B/1LtCbm
	nEzUHRwc11xUO6d8nPvSTD8appSlf87DT9wglVPo1e9DoBycajmk5Zw=
X-Google-Smtp-Source: AGHT+IE3yPMa/eAyrcIcKnygKFejo73k37164uoaXWheqCJIVO7kLvZ6j6r+yahYkE1fLzUTtnx2sQ==
X-Received: by 2002:a05:6a00:1484:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-73bae4b3d15mr1532729b3a.8.1744162483721;
        Tue, 08 Apr 2025 18:34:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b108sm55039b3a.19.2025.04.08.18.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:34:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0FFEF4236D23; Wed, 09 Apr 2025 08:34:39 +0700 (WIB)
Date: Wed, 9 Apr 2025 08:34:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>, Timothy Day <timday@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>, netfs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Update main API document
Message-ID: <Z_XOr4Ak4S0EOdrw@archie.me>
References: <1565252.1744124997@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxzS9cWmxd0BSJ70"
Content-Disposition: inline
In-Reply-To: <1565252.1744124997@warthog.procyon.org.uk>


--cxzS9cWmxd0BSJ70
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 04:09:57PM +0100, David Howells wrote:
> + * For writeback, it is unknown how much there will be to write until the
                                             "... will be written ..."
> +   pagecache is walked, so no limit is set by the library.
> <snipped>...
> +Further, if a read from the cache fails, the library will ask the filesy=
stem to
> +do the read instead, renegotiating and retiling the subrequests as neces=
sary.
Read from the filesystem itself or direct read?

> +When writeback occurs, folios that are so marked will only be written to=
 the
> +cache and not to the server.  Writeback handles mixed cache-only writes =
and
> +server-and-cache writes by using two streams, sending one to the cache a=
nd one
> +to the server.  The server stream will have gaps in it corresponding to =
those
"... and another to the server."
> +folios.
> +
> <snipped>...
> +Netfslib will pin resources on an inode for future writeback (such as pi=
nning
> +use of an fscache cookie) when an inode is dirtied.  However, this needs
> +managing.  Firstly, a function is provided to unpin the writeback in
inode management?
> +``->write_inode()``::
> =20
> <snipped>...
> +The fields generally of interest to a filesystem are::
> =20
>  	struct netfs_io_request {
> +		enum netfs_io_origin	origin;
>  		struct inode		*inode;
>  		struct address_space	*mapping;
> -		struct netfs_cache_resources cache_resources;
> +		struct netfs_group	*group;
> +		struct netfs_io_stream	io_streams[];
>  		void			*netfs_priv;
> -		loff_t			start;
> -		size_t			len;
> -		loff_t			i_size;
> -		const struct netfs_request_ops *netfs_ops;
> +		void			*netfs_priv2;
> +		unsigned long long	start;
> +		unsigned long long	len;
> +		unsigned long long	i_size;
>  		unsigned int		debug_id;
> +		unsigned long		flags;
>  		...
>  	};
> =20
> -The above fields are the ones the netfs can use.  They are:
> +They are:
"These fields are, in detail:"
> <snipped>...
> +The stream struct looks like::
"The stream struct is defined as::"
> +
> +	struct netfs_io_stream {
> +		unsigned char		stream_nr;
> +		bool			avail;
> +		size_t			sreq_max_len;
> +		unsigned int		sreq_max_segs;
> +		unsigned int		submit_extendable_to;
> +		...
> +	};
> +
> <snipped>...
> +The table starts with a pair of optional pointers to memory pools from w=
hich
> +requests and subrequests can be allocated.  If these are not given, netf=
slib
> +has default pools that it will use.  If the filesystem wraps the netfs s=
tructs
                     "... it will use instead."
> +in its own larger structs, then it will need to use its own pools.  Netf=
slib
> +will allocate directly from the pools.
> =20
> <snipped>...
> +   This is not permitted to return an error.  In the event of failure,
> +   ``netfs_prepare_write_failed()`` must be called.
"This method is not permitted to return an error. Instead, in the event of
failure, ..."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cxzS9cWmxd0BSJ70
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/XOqgAKCRD2uYlJVVFO
oxwDAQCIp2Z67CrtkEI2vxhnwb/3m5aDgDDO7eFv+9qsvmRlTQD9GbhobtuuelYe
u6w0SgAN6bt+eNQLl6cm97wW0cB66A8=
=TxHk
-----END PGP SIGNATURE-----

--cxzS9cWmxd0BSJ70--

