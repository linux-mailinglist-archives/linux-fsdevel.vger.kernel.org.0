Return-Path: <linux-fsdevel+bounces-18302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8068B6AD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 08:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9677028132D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 06:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35C3A29A;
	Tue, 30 Apr 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbCASJSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4D199AD;
	Tue, 30 Apr 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459598; cv=none; b=c86ZgY58G+Dtd2QmmspOkKWY8QYkXHe5i99gFlpyNo8CzLwZitBl/muujLoh2I5uaJzY4mPAvOC8fqXCcL85+KE0aBwUe1LrLtNmFQxYbfOhkAoiKVNH3p7S8vOvfnobMpcC3W/t1hAbyBmmvlZ1d+KBPn3wBAkGscFMoSxmUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459598; c=relaxed/simple;
	bh=BJHpOQBTYl2CusEmnHRWz9TzqP85OwFTue5pk4Z5ba4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IILD+880TMzR5nNFg49TS8IzkmGcBIJgOP8fz6Wks6av+MTnl0jXYIa6Dy2MNWPJBPLU7IssRKs6Gie4i/hgK7AB4YXHadyH1rU7XgAY6115x1OAoe68Lrk/XnF1krOv14x7d3L+GZuQGXCV2tSvYFnmXGxqw1twDTDtDCKYOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbCASJSV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso3302938b3a.1;
        Mon, 29 Apr 2024 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714459596; x=1715064396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hCjGa0cyR+5KjlfrnK0wTPM9nmlXBCTQii4J3Gjgfc=;
        b=VbCASJSVR7mb4y03jimQHsulDrXI5KKfUAYE9NqwPP3eN30bLLtYe5SwRPGmwgOwzx
         sbNidX+3Qjdk2nbAPdq5aWH9tvB/syvXMuJh+inTn0SxqkrfMUcmXRfJgdYozExoB0Us
         u2MWO22kxzVewCVqex1IXS6eiYAOqdxDG0Q3VZRLUrRhUY3+HtlNC5lV4RU3imtv0UCU
         K35VtwMwrVPVE0MU4ah0LP9ScnhwAqrhnlsf3gX/QBbZBQ8Plw0h3bbSSLGSR5vvaInl
         fVAHqL1/Re9q2yu641IWURD8vGuHjJt04QfS8J+ZIZrnbS+HgL99oWDoB9Iz60zdazO/
         siSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714459596; x=1715064396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hCjGa0cyR+5KjlfrnK0wTPM9nmlXBCTQii4J3Gjgfc=;
        b=xMYLfx1UOKuxps1PuSM1eRtIQyGA3TkSoMUiWEGqzK4Cl4Gz9cpwT54vNl8QWg+gJp
         WTAQbjsaUhTkhUK4vRJGK/g0bISQLh2Ma5gaz1kNf1xcmDsFnXva/LgVN9/qsTX6k0YZ
         8OI8BTdmhend2gjOswqbXV05Z8W5ll0yejZ9eEL+um9Bn2gSNdhFO9VWcDyGeISwuQXc
         GEqfhPNuTgFy2GCaAY23rZzgOmXqOV6/lt3yHGYlvXq70IyEUn/MWKKxxppH2oFjs/P8
         kbi+mt5Icc46MvSjvBLU85TKiS3MDdaYf6E+1pI+dXbxH9BxYL/dUYTFpG8iKu/cFwek
         5B+A==
X-Forwarded-Encrypted: i=1; AJvYcCUc7URIviLquADjEI1w3mynFsx59wXKufdixx6LHBl6o2eY7YsPYLUVhvAi9xS7ZmLsI5ib4ietB7OL9Ouujc6lwL5NWDfTM1oe183+5wtrCvXuAubzqoZJ0kNJL+Z5+8YM+MNgcuL5Zz9VZIl/gRsDQzdCkTI0T3pXERl+8w8CkHyQZoqp/hs7n3B7bFwIN6hpKEA4XVgjv9b13900MPo8yw==
X-Gm-Message-State: AOJu0YxSLg5iausCRyfV932p6jezrW75rCuej0PU4lp4RFy/MhlBQLt7
	f3WnQtfpNmgnZuiy5Bm4tijJfDL2Zk3NUxNusOrT7y0DbUrhMDlv
X-Google-Smtp-Source: AGHT+IHZptiykpZhYjFmG4OGGymocqD+APs98M8NEhYGo1chm3Kg5U9XPh+dOTwbEH1pATR3JSfM+A==
X-Received: by 2002:a05:6a20:de96:b0:1aa:7097:49e2 with SMTP id la22-20020a056a20de9600b001aa709749e2mr12942263pzb.50.1714459596260;
        Mon, 29 Apr 2024 23:46:36 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001e556734814sm21511890plf.134.2024.04.29.23.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:46:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 64E1318462BA1; Tue, 30 Apr 2024 13:46:32 +0700 (WIB)
Date: Tue, 30 Apr 2024 13:46:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: John Groves <John@groves.net>, Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Linux CXL <linux-cxl@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux NVIDMM <nvdimm@lists.linux.dev>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: John Groves <jgroves@micron.com>, john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
	gregory.price@memverge.com, Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>
Subject: Re: [RFC PATCH v2 01/12] famfs: Introduce famfs documentation
Message-ID: <ZjCTyOvpBDBuCg5i@archie.me>
References: <cover.1714409084.git.john@groves.net>
 <0270b3e2d4c6511990978479771598ad62cf2ddd.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crT4BUp9nHuKakh4"
Content-Disposition: inline
In-Reply-To: <0270b3e2d4c6511990978479771598ad62cf2ddd.1714409084.git.john@groves.net>


--crT4BUp9nHuKakh4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:04:17PM -0500, John Groves wrote:
> * Introduce Documentation/filesystems/famfs.rst into the Documentation
>   tree and filesystems index
> * Add famfs famfs.rst to the filesystems doc index
> * Add famfs' ioctl opcodes to ioctl-number.rst
> * Update MAINTAINERS FILE
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--crT4BUp9nHuKakh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjCTwwAKCRD2uYlJVVFO
o6cyAP9LSH332uDKE+seiJLwDjMnIq+YE0884MKXbf8SHc2gdQEArqUm84vOu682
HXx1CyZQ45bTEfyOQgYNRg/+bNbzpw8=
=+4jA
-----END PGP SIGNATURE-----

--crT4BUp9nHuKakh4--

