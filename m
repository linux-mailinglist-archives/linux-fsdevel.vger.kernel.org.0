Return-Path: <linux-fsdevel+bounces-53862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B45AF84D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B77BA422
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD331E4A9;
	Fri,  4 Jul 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLnITauF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C53595A;
	Fri,  4 Jul 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751588838; cv=none; b=uvP2JaVhx6gMzJtK+8M8Ay2nHVEjE5GYWDo6VCx/39UyrDec5lmg0j70D8B7KfO3aktmTjTE9cRkzU9kc5VLPg3/4TKsjETWC2ZmTv8Hmvk+cvJg1o2qZdvG0J2niXJJtSlyNLxLMpyQMnqpplu/cvjm7SxbkR8ItJzcGXf2liM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751588838; c=relaxed/simple;
	bh=ZiQ9WvbhgrqOMqZuRx3huleB0tjtVkP0ALx19wMz7I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqQKk6Br7hqZ6nN/PEkIiWIuQwCrJYJG52lG7NLCjQVnUog40K2qh3dRCVf4DNu91t/NsCQhNnrvvhqg/BAgiAjPhkyx5VHifjOOsfhidql8uubOeRJMdai3kNbMGZHGOweg1D1ZdCun1lwhvHpP1a/BKc7I/6m3QhY2f6Vil6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLnITauF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74ce477af25so228985b3a.3;
        Thu, 03 Jul 2025 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751588836; x=1752193636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiQ9WvbhgrqOMqZuRx3huleB0tjtVkP0ALx19wMz7I0=;
        b=eLnITauFlD9iK4p71ryCuqXJS7SXyCrn+koHLxhVNiltAq5wgK+Y4THvM6pMW0+Yce
         u0hDfFVzWjCJp+k0JwnJQUIx1s4OvfxA5/n+zYnoXSP2RKsdvKxR5SCKVCPtrndjLbxL
         mT4hjrqSQeNAl/eqKDsATLkzN2HLhCb3DUzWi34FA4zBL6QV7GFjZlZqmi3qwIB3XnOx
         Qye5NMQCWUxPxILGaoDO4NUoEYEvE3NEzckZcQzPnWni+/idpfyJZFjfOyYU1w85vJlo
         Uy/uCG52wZTFNsH2BIfkjFdOu6C8nFEXW1Ou9ZXBLb6CU2He5NjwuQrBbjne0iwA3icj
         jE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751588836; x=1752193636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiQ9WvbhgrqOMqZuRx3huleB0tjtVkP0ALx19wMz7I0=;
        b=G89Ltq9UQ9c1pVWUk8qX/C+OIZzaf5uRdnA93EV013w8IKT+PjVF7bVmDj9srhkFNT
         00XGnIQMb4faUl1k/uXP7JTg9PSW6djptE4CqOKYJI/pmIWmHPUVV4Q/VNH9p1Vhyo7C
         Mlkrc27U8zTnhYWDzGNxzdED3VMEARCvxq4poTFXbeX38dstd/twOwmRv6qm+1inr9GM
         ffvYa8pRo6qEQAjzg62Bg7O4BpxeyKhT8zlYYHInDQc1oKEikvHu1guziKgM4YngHCX3
         8lYxTBg/KvKQGN6vEe4ZQR3mIQhXO5jXwSMeckefUKnKPMtYZhpVYMGm8WD9+Z4rYxUd
         RdbA==
X-Forwarded-Encrypted: i=1; AJvYcCUBWaNM4Z0D+bcIWZyVS/90j1ZvxIu20XtW3ZwWwIOEe1OMrX+CtPcsCA71u0olRVx54Au4QyzqEeo=@vger.kernel.org, AJvYcCVaR6y8bsBHyl/2X7Ob9Ac+oEiYLJJcCv0wryVA/UhczLjCckPrpQW127ZLILp3BBl4a6EP6fBEs8b7AoGYpw==@vger.kernel.org, AJvYcCWWFWE+tRxVpdezW9GXIO+q93uNIh6YNk7zsY5cFCzWVFcQrNVqHWq8TlQsywGcSlfEq0T9XXC+fmZIc3nY@vger.kernel.org, AJvYcCXEwxXC6F+djT7wkgp8J/IcyWbq1s6RFwFWr3Jd3Pvq2es8DGYK5I6uH/I38CEiT+CP7jawBJ/6fOte@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11Q7AKH0rUyk1NYJ+GJ41GPBWdQgPtq6V+e+iWTBkS4rKLrtJ
	/MD3faH/ncrHwM0bOtC1Sbh6c63K3Y4OmRFHk6Otb5QZrxKsxMRiynle
X-Gm-Gg: ASbGncsCyv5U08nMAxBaebCMdgYEgL7FGm/OdKQ1/Fwl2vQUCRxl3vuGob7MnExIiHj
	fbkJ7cJsd4VLTNn7PX2hKqCXXRS80L+pLu8gUxi6psJmW8L8PYNEHGdt3uxxoRPtiCwgF2RRiDc
	f9gIsRH41Bm+9baMoIQzu9Ycul9USKEj3KKjofNxh1ffBExQHOQR8n5XxC+aMfHNqgAVyBWnMn5
	Ks5UEnF+p+hmy5pB3y1XA6h/irzLZgHv2z7tprl+M8TAGr1yU/bg7nycK/oycbAIEdYqhb9wdor
	T5CzlFaSPArQIYEZa2WYap/dol1CGVMSoo4zn5aaLfunf3xl9/lIbkk0YjPIhg==
X-Google-Smtp-Source: AGHT+IGwQCrkWrjApK0htBGSorBdvNkVh5GSO+iYPYY+Kh0DqyqHto9HinLiE593880id3pXNBbbnw==
X-Received: by 2002:a05:6a20:4325:b0:220:9e54:d5cc with SMTP id adf61e73a8af0-225b9b7a66bmr1282824637.31.1751588836070;
        Thu, 03 Jul 2025 17:27:16 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62dd6asm647668a12.64.2025.07.03.17.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 17:27:15 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8A22A4206886; Fri, 04 Jul 2025 07:27:12 +0700 (WIB)
Date: Fri, 4 Jul 2025 07:27:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <aGcf4AhEZTJXbEg3@archie.me>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FhmplPz1+JPluJTh"
Content-Disposition: inline
In-Reply-To: <20250703185032.46568-19-john@groves.net>


--FhmplPz1+JPluJTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 01:50:32PM -0500, John Groves wrote:
> +Requirements 3 and 4 are handled by the user space components, and are
> +largely orthogonal to the functionality of the famfs kernel module.
> +
> +Requirements 3 and 4 cannot be met by conventional fs-dax file systems

"Such requirements, however, cannot be met by ..."

> +(e.g. xfs) because they use write-back metadata; it is not valid to mount
> +such a file system on two hosts from the same in-memory image.
> +

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FhmplPz1+JPluJTh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaGcf3AAKCRD2uYlJVVFO
o7MlAQDFFzY/AyfkzJf6X39RAu80LaEnq2G/NAeqbWbqwX+W8gD6ArnxxAZHvTMc
4pRWe3cIkdvJArMN4f2J8/XM623oTgk=
=0PQj
-----END PGP SIGNATURE-----

--FhmplPz1+JPluJTh--

