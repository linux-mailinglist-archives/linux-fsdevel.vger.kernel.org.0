Return-Path: <linux-fsdevel+bounces-28789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B396E375
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F750B23AC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89471194AD9;
	Thu,  5 Sep 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="CB27434c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF818F54;
	Thu,  5 Sep 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565760; cv=none; b=QWxWbC64CtsBMXA0cwklnrkTmUXXjhk61KSAYWxHgrx4GfWVJZOmr7czpKMefENROR6wuNDzjJLe0T85hyh8CyuxrUvDcdTNw5z4hHbhATjIgyiuag/JzGn9cVqGr+Mz1ZtVbVDtmFlySXyu6KXUo/+M+bUctsgcEwaefGsG3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565760; c=relaxed/simple;
	bh=R9jV6c9DzRXAzNDj79bLWCXmbUh1PrgeFsfybKFv1S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8fccZophL6/woql93iSoUo/JCgAUSEEBtcdcRlZDH2XBFl+jumKHmOapd/En1ZMQREItHoKE+1fQrhm0e7dMGN7XlSGzTnFOH6ndrIKRWCeQVKEdLS1XiSyAJuxOu/Iad8SOBcaTj2QKVh4naqIytnq+dN9txpuOf8v3/YENVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=CB27434c; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6353B1BF204;
	Thu,  5 Sep 2024 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1725565749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAoDvWukowI9z/kaauSz2C4OPYFuBGznaXYdYnzAxxw=;
	b=CB27434cmHsdWUgJWz+Ozodm3QtL+hlSan+xCDkrbQ+UjpkbeXKqXsa1bJjTbxFbx+xmRR
	l2VyU/J6gXN/Af5REgs6lO4lr/AXYxUiH7VeONgAwmhlTlMPGyExR0gSeH2PqEG7hh4NB3
	t/QJCx4TjfKHgXEixjv/DtyxCph+SlPkUBoxyq5YjNMs6Q8MCnmwCY1UvUHDsm14wj+jyI
	I6COMk0SNFPgO/BOykMuiWPM2MFu5rfQb4YUpyE/hIy8ZMgGG1nIv5wpJuNkQIoccFFo0K
	smVi3rU406EsAxDD76YmBF8RYWLjLEHkbvwediwvlVM9i2hYMn60qFZrXiXmPQ==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  krisman@kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  kernel-dev@igalia.com,  Daniel Rosenberg
 <drosen@google.com>,  smcv@collabora.com,  Christoph Hellwig <hch@lst.de>,
  Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 9/9] docs: tmpfs: Add casefold options
In-Reply-To: <20240905190252.461639-10-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 5 Sep 2024 16:02:52 -0300")
References: <20240905190252.461639-1-andrealmeid@igalia.com>
	<20240905190252.461639-10-andrealmeid@igalia.com>
Date: Thu, 05 Sep 2024 15:48:59 -0400
Message-ID: <87v7z9op90.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
>  Documentation/filesystems/tmpfs.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesyst=
ems/tmpfs.rst
> index 56a26c843dbe..636afd3eaf48 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -241,6 +241,27 @@ So 'mount -t tmpfs -o size=3D10G,nr_inodes=3D10k,mod=
e=3D700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>=20=20
> +tmpfs has the following mounting options for case-insensitive lookups
> support:

lookups->lookup

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
> +Note that this option doesn't enable casefold by default;=20

I think this is fine as is. but if we need a new iteration, could you
perhaps rephrase this to something like:

This option doesn't render the entire filesystem case-insensitive.
One needs to still set the casefold flag per directory, by flipping +F
attribute in an empty directory. Nevertheless, new directories will
inherit the attribute.  The mountpoint itself will cannot be made
case-insensitive.

> +
> +Example::
> +
> +    $ mount -t tmpfs -o casefold=3Dutf8-12.1.0,strict_enconding fs_name =
/mytmpfs

strict_encoding

> +    $ mount -t tmpfs -o casefold fs_name /mytmpfs
> +
>=20=20
>  :Author:
>     Christoph Rohland <cr@sap.com>, 1.12.01
> @@ -250,3 +271,5 @@ RAM/SWAP in 10240 inodes and it is only accessible by=
 root.
>     KOSAKI Motohiro, 16 Mar 2010
>  :Updated:
>     Chris Down, 13 July 2020
> +:Updated:
> +   Andr=C3=A9 Almeida, 23 Aug 2024

--=20
Gabriel Krisman Bertazi

