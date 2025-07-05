Return-Path: <linux-fsdevel+bounces-54000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD1AF9D14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 03:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D72D584911
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 01:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679013AD05;
	Sat,  5 Jul 2025 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPiRSp9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED7013AF2;
	Sat,  5 Jul 2025 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751677877; cv=none; b=B2xdJX3K/+Z+3AgM8dD8Wx3RnE8WueTCoRkhMWzJ7Z2qF7V8FjFw97BIXsPQK0DBwH53CaokZCz9sENlREeos4IdpzSWRH0P8Ua4kLfuR9VaqDWOIu+7RnMjTdvH7C49COttLs8d8SX8J2ZrOkM3aQR9zArbI7QiDj6uqAcIbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751677877; c=relaxed/simple;
	bh=TGLHtQniPFFRkVhKxL21veKIv8ziGCFBrUf3ZmavJfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXXyae6o2SmdDDHMXXC6zsxCXEUDl6vHCsye8CjgcRrcbFDsUWLNMm5dgT9HfiAWO88VTMxLeG1+3OFFSUsX22R3pGNo0o/24BbD2XgKYBGzJ16q5DzEWfm9NPL3FELYYy4wVC3BBZL21Nr/nA4gqLhmDq6QC8V61ONtb4cNAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPiRSp9/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae3a604b43bso223500766b.0;
        Fri, 04 Jul 2025 18:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751677874; x=1752282674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/RMW5ROGAxC4jVB3NK6djzooskyVRPZCJn8BCZVKk8=;
        b=cPiRSp9/SPZJeGtyzgDgmBkoHHB7ww5sw4cMnIa5aIdvGpIcgYYRaXShE8+NELfvIV
         TiaHmQKgtXxDr6qER3wrMnbyCad4jdxqm6shOkOq87LsDqEfVDss2Dra2PTfTIbSxauM
         Eqd+Pjripr+kTW7zC3dpC+49CQ+mSY0qdp8LkKW3Dy9fKcORyhcQUJttxHoafwlrmK8u
         dsTifA97dVHfer75RqPMeZYoRBRhLp+Y7S9Kyaxyzl4s06TBqcqm9TzLXbBRbHQew1Gu
         j+ruUD197ZHcwXQE6s9zRv2T8Lk0jRHPm7+3gdzxRZOuiVCHhzt7pDIBSaQQWLOooXxh
         sEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751677874; x=1752282674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/RMW5ROGAxC4jVB3NK6djzooskyVRPZCJn8BCZVKk8=;
        b=vHQDgM2zlNPjoLBJ6cumbuToqw0MuLNsOEK481vN6/wLYO5VB1khFl+L1Rq8zXC28G
         zBYb3DCfPZWarKQooh4F/WM1jLq9Lal/YJ1bKgmHgNA5HuWqsf3ubaIUlCX4i/Ra/W/7
         Q3kOLQmRFRIn1L9pZyQWWBwz1d51GEltLRaHCCipnNWycbr9p0pwT3OEyzgj2x9TiHyu
         S3F1RHnq3eVUZajrf2SBEK1WWMXBqkQnzyLGflTsju93trew0vXjZjyyR9S6K0JH+Xxn
         Xe/kHO7UaSSCBWXm9CNUPezcECgu77QxYWYfny/I4olgZN7+Tu8nxB9N1Qy3J9wzmzsd
         pllg==
X-Forwarded-Encrypted: i=1; AJvYcCV1nagRVzKq953vujP4kuJY6WzeYWlWkPUB3kUqSMQyaC1mHz9h6u/Mgf11kIjUmpYfnbyU9cOeBWM=@vger.kernel.org, AJvYcCVAIhFTVqFIIvBIBCYQHaP7P+hOtd9yioweH5uPSLHcr371vQGwgViCWZfuDgZlFctFihMdWOoiOCxE@vger.kernel.org, AJvYcCVp0CdYhZb68XflW2zybnj0bV7LprprJzynRa5RVRTn8TyGwC93lpJv34W5KjGRCHv1EKzb5yxL4BB+9XcMYQ==@vger.kernel.org, AJvYcCWS4xzisMDkrSrbe9O452SflMA86cVBOeVyeLonv27TBJkCcXxN5UHXlwkwhcNhyYekrVSMw/qt1hD25S9/@vger.kernel.org
X-Gm-Message-State: AOJu0YxeGkiUi9/bqRxLE1dMv6i1ZY0rmLX3zG8mT6Y27jJdENxA+y9a
	pa81x9oDiVeIWUwNyRIOMCiRmYImMY+q/iq+bl0EbXBrKQDrIYeMaRcLNyexzw==
X-Gm-Gg: ASbGncsPaqQaknQc1HgDB+8driHb8dJaskUzW9JcI9R0W8huEC75+CU8Gx+EskJXlv5
	3yvtE99/4XribAqSUdG1cbUVdM4/IPKXjFMgurJVTXq6AqvnI6eLknM6/LbUp6uctLd6h1Hzl9u
	qVEPZKS2j4oMgfSR/i6YF58zb8PcafR4Zj3XOdwaPYoMiSCR2bXGAFc1gmpQHmrcv55kb4QJE2R
	YAUcI0tkKgErY68JpCXgI+VgCwLmYE2P4J14q6sk/t9IkQM3dLJpqQ1S3cOhFAbKZs4bWVEbMM7
	r44uZUi7tn0c4u2mPyF0AXlo19HAa3xnX13nQ6xuLkk83kYGVlhr+8rWSZvvcVG+resTNjpC
X-Google-Smtp-Source: AGHT+IHUSIHx+BqSNZT+kZlLiCbHuIOKR1i5aqY9CMhhNpFb/R2602F6DzC/dMa+aAfLN+gs6Hk14g==
X-Received: by 2002:a17:907:1b1d:b0:ae3:cb50:2c6b with SMTP id a640c23a62f3a-ae3fbd141camr471008866b.38.1751677873862;
        Fri, 04 Jul 2025 18:11:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac35e0sm263535366b.73.2025.07.04.18.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 18:11:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1F3A241F3D86; Sat, 05 Jul 2025 08:11:05 +0700 (WIB)
Date: Sat, 5 Jul 2025 08:11:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, John Groves <John@groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
Message-ID: <aGh7qBzEJMFf_srS@archie.me>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
 <aGcf4AhEZTJXbEg3@archie.me>
 <87ecuwk83h.fsf@trenco.lwn.net>
 <aGdQM-lcBo6T5Hog@archie.me>
 <aGgkVA81Zms8Xgel@casper.infradead.org>
 <aGhjv37uw3w4nZ2C@archie.me>
 <aGhnFu8C9wVPiXBq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhvcLO43juMxDsjQ"
Content-Disposition: inline
In-Reply-To: <aGhnFu8C9wVPiXBq@casper.infradead.org>


--vhvcLO43juMxDsjQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 05, 2025 at 12:43:18AM +0100, Matthew Wilcox wrote:
> On Sat, Jul 05, 2025 at 06:29:03AM +0700, Bagas Sanjaya wrote:
> > I'm looking for any Sphinx warnings, but if there's none, I check for
> > better wording or improving the docs output.
>=20
> That's appreciated.  Really.  But what you should be looking for is
> unclear or misleading wording.  Not "this should be 'may' instead of
> 'might'".  The review you give is often closer to nitpicking than
> serious review.

Thanks for the tip!

--=20
An old man doll... just what I always wanted! - Clara

--vhvcLO43juMxDsjQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaGh7pQAKCRD2uYlJVVFO
o/GiAP4tesyMBf5QzSsvVBV5gxPDNwesiOtgDt+HtxlS18HLLwD/XWPRGBM1yZhx
4w3Fe2lF6lFmlIekyWjwIMJ0Qkci4A8=
=hztl
-----END PGP SIGNATURE-----

--vhvcLO43juMxDsjQ--

