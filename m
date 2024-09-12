Return-Path: <linux-fsdevel+bounces-29201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A7977113
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B281F245AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6C81C1742;
	Thu, 12 Sep 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="Wo2nsJJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5101BC9F1;
	Thu, 12 Sep 2024 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168033; cv=none; b=MtbzfY3PVdrxmfjtp7AQuNzYgJLXi2X+Sjpw6+c/97A1u7sHoM16O4m9MDNpazIlRg7d8WLTvBtIihCxM1XtXgkMzrQLbwnuMxaRI/bIK86AnKLYmJXsBgaQUgOCdWGG1oIKEWIGrDJHZuHUGu6LTXADbqZhlXhk6mjQwdTtUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168033; c=relaxed/simple;
	bh=UGStNfIN5wUAEwVziRWml/vbimsyOvd3nJgESLLdHEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oC3+4yKqEYCqsMIjILCjKBi1HBZyGjMV7QPKs+deo99i6ZnDa339ZrwfANpvvkc8mF2NYG4JIff//sZ485mFnKHKtyprEN9/TozUXVyCIq4ycc5s/bVLX8MnUwzeHsIf3WiGd4RGntUwT7lrOo98qdZuBMaXrw79hp+vJmmukP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=Wo2nsJJJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E289FF802;
	Thu, 12 Sep 2024 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1726168029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fsR65crQj6jY8n1XWEO45jbtZzq9hzUCnTphruNqKI=;
	b=Wo2nsJJJadnGJDDxpCgdDGXlZder1Yayo1gkd5bRNXtjVzeaLYaIquUbOd9GKnCP8Z99Tj
	qS18aEXQhCobKVF+4oPwOgWFvx22UMm+ld5GfGW1AJlZqvN1goFDzczFdUjmvxcHNN1JLv
	Ksd+m+xwR0Tr5EOFneyHb8ZzpdwFlZkilt5/dVNPWXkxjiXbYFPiQJ467REwjcMM6eKTr7
	9DwSaMHJShEo4XQecNpKnjx0mrqQT/PJdFbD5t/IAuBau3Qf7s5icJFCddooVAu0RZGiKr
	kkrsRAVUmlGb0/Ijz04M7W1Gk5lYcF0AJvsUuBIr3cwm+zaEUEJwbPHkpKBzCw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 10/10] docs: tmpfs: Add casefold options
In-Reply-To: <20240911144502.115260-11-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 11 Sep 2024 11:45:02 -0300")
References: <20240911144502.115260-1-andrealmeid@igalia.com>
	<20240911144502.115260-11-andrealmeid@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 12 Sep 2024 15:07:05 -0400
Message-ID: <878qvwlmhy.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Document mounting options for casefold support in tmpfs.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
> - Rewrote note about "this doesn't enable casefold by default" (Krisman)
> ---
>  Documentation/filesystems/tmpfs.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesyst=
ems/tmpfs.rst
> index 56a26c843dbe..f72fcc0baef3 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -241,6 +241,28 @@ So 'mount -t tmpfs -o size=3D10G,nr_inodes=3D10k,mod=
e=3D700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>=20=20
> +tmpfs has the following mounting options for case-insensitive lookup sup=
port:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +casefold          Enable casefold support at this mount point using the =
given
> +                  argument as the encoding standard. Currently only UTF-8
> +                  encodings are supported. If no argument is used, it wi=
ll load
> +                  the latest UTF-8 encoding available.
> +strict_encoding   Enable strict encoding at this mount point (disabled by
> +                  default). In this mode, the filesystem refuses to crea=
te file
> +                  and directory with names containing invalid UTF-8 char=
acters.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +This option doesn't render the entire filesystem case-insensitive. One n=
eeds to
> +still set the casefold flag per directory, by flipping +F attribute in a=
n empty
> +directory. Nevertheless, new directories will inherit the attribute. The

> +mountpoint itself will cannot be made case-insensitive.

s/will//

Other than that:

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

> +
> +Example::
> +
> +    $ mount -t tmpfs -o casefold=3Dutf8-12.1.0,strict_encoding fs_name /=
mytmpfs
> +    $ mount -t tmpfs -o casefold fs_name /mytmpfs
> +
>=20=20
>  :Author:
>     Christoph Rohland <cr@sap.com>, 1.12.01
> @@ -250,3 +272,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by=
 root.
>     KOSAKI Motohiro, 16 Mar 2010
>  :Updated:
>     Chris Down, 13 July 2020
> +:Updated:
> +   Andr=C3=A9 Almeida, 23 Aug 2024

--=20
Gabriel Krisman Bertazi

