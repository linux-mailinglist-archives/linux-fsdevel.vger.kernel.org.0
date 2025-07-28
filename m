Return-Path: <linux-fsdevel+bounces-56112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97154B1329B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 02:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2213F189675D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B73A944;
	Mon, 28 Jul 2025 00:04:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B119EC4;
	Mon, 28 Jul 2025 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753661081; cv=none; b=JR7UEYafMtn9rdW6b2Ve8UTLjy70Ds+9BlM5J+0KxugNzk31FI5MfkLHah5J6NQOnAb/vem8mZBUX7/OYbHsKBLYKWwPI44X7KfligSB/1F3De6HJKUAE1oTiikiyvgQEyVTc4TRiTp4NdlJIMrtAL/TMrkzFbJExchbcwpR6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753661081; c=relaxed/simple;
	bh=G8Rb58x2rWg7QP/HxlU2+gOrfS6A5ThTTPkS1X2x3u0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ir3hMyuvGLkGhbHt0kgxJSAxvh6wElz+6rXE0xi2UJaPHfqoNHTm72qLBVg2/+72X2Iw8lgUCHqFhGO6EUQiZZa5a43CYBI2e4m4+qwpg4b4EjSEjeYfjNnMKtYvie96COoHTx6EfmL2ReiQ5ryF8HJOFLlmvA1l9uLsYyp2OUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ugBLv-003ekj-Lm;
	Mon, 28 Jul 2025 00:04:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v3 3/8] vfs: add ATTR_CTIME_SET flag
In-reply-to: <20250727-nfsd-testing-v3-3-8dc2aafb166d@kernel.org>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>,
 <20250727-nfsd-testing-v3-3-8dc2aafb166d@kernel.org>
Date: Mon, 28 Jul 2025 10:04:28 +1000
Message-id: <175366106815.2234665.13768447223879357240@noble.neil.brown.name>

On Mon, 28 Jul 2025, Jeff Layton wrote:
> When ATTR_ATIME_SET and ATTR_MTIME_SET are set in the ia_valid mask, the
> notify_change() logic takes that to mean that the request should set
> those values explicitly, and not override them with "now".
>=20
> With the advent of delegated timestamps, similar functionality is needed
> for the ctime. Add a ATTR_CTIME_SET flag, and use that to indicate that
> the ctime should be accepted as-is. Also, clean up the if statements to
> eliminate the extra negatives.

I don't feel entirely comfortable with this.  ctime is a fallback for
"has anything changed" - mtime can be changed but ctime is always
reliable, controlled by VFS and FS.

Until now.

I know you aren't exposing this to user-space, but then not doing so
blocks user-space file servers from using this functionality.

I see that you also move vetting of the value out of vfs code and into
nfsd code.  I don't really understand why you did that.  Maybe nfsd has
more information about previous timestamps than the vfs has?

Anyway I would much prefer that ATTR_CTIME_SET could only change the
ctime value to something between the old ctime value and the current
time (inclusive).

Certainly nfsd might impose extra restrictions, but I think that basic
restriction should by in the VFS close to what ATTR_CTIME_SET is
honoured.  What way if someone else finds another use for it some day
they will have to work within the same restriction (or change it
explicitly and try to justify that change).

Lustre has the equivalent of ATTR_CTIME_SET (MFS_ATTR_CTIME_SET and
LA_CTIME) and would want to use it if the server-side code ever landed
upstream.  It appears to just assume the client sent a valid timestamp.
I would rather it were vetted by the VFS.

Thanks,
NeilBrown


>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/attr.c          | 15 +++++++++------
>  include/linux/fs.h |  1 +
>  2 files changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/attr.c b/fs/attr.c
> index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..f0dabd2985989d283a931536a5f=
c53eda366b373 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -463,15 +463,18 @@ int notify_change(struct mnt_idmap *idmap, struct den=
try *dentry,
> =20
>  	now =3D current_time(inode);
> =20
> -	attr->ia_ctime =3D now;
> -	if (!(ia_valid & ATTR_ATIME_SET))
> -		attr->ia_atime =3D now;
> -	else
> +	if (ia_valid & ATTR_ATIME_SET)
>  		attr->ia_atime =3D timestamp_truncate(attr->ia_atime, inode);
> -	if (!(ia_valid & ATTR_MTIME_SET))
> -		attr->ia_mtime =3D now;
>  	else
> +		attr->ia_atime =3D now;
> +	if (ia_valid & ATTR_CTIME_SET)
> +		attr->ia_ctime =3D timestamp_truncate(attr->ia_ctime, inode);
> +	else
> +		attr->ia_ctime =3D now;
> +	if (ia_valid & ATTR_MTIME_SET)
>  		attr->ia_mtime =3D timestamp_truncate(attr->ia_mtime, inode);
> +	else
> +		attr->ia_mtime =3D now;
> =20
>  	if (ia_valid & ATTR_KILL_PRIV) {
>  		error =3D security_inode_need_killpriv(dentry);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 040c0036320fdf87a2379d494ab408a7991875bd..f18f45e88545c39716b917b1378=
fb7248367b41d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -237,6 +237,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t o=
ffset,
>  #define ATTR_ATIME_SET	(1 << 7)
>  #define ATTR_MTIME_SET	(1 << 8)
>  #define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
> +#define ATTR_CTIME_SET	(1 << 10)
>  #define ATTR_KILL_SUID	(1 << 11)
>  #define ATTR_KILL_SGID	(1 << 12)
>  #define ATTR_FILE	(1 << 13)
>=20
> --=20
> 2.50.1
>=20
>=20


