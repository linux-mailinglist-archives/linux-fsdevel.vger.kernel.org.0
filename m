Return-Path: <linux-fsdevel+bounces-51026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0D0AD1EBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D458116C2BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA832594B4;
	Mon,  9 Jun 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc4jz1xX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D1254AF0;
	Mon,  9 Jun 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475283; cv=none; b=fQGYSkhvW9YugAYTKEkufZqKmWzWL8qCA7bX93pDZnDaw2OKTI5rJYTGm+in96dCKqElmSZRg+xg4o1hduiDoYoj2vvsqijZqfHxrouuUd8199S6AcRp4Tizzb0qv2fy8yxd4LihgQ+Dag2rOnubOwV8Xr78TMTIB451f9ECXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475283; c=relaxed/simple;
	bh=LGL6lMiRoy1C3r6cGW8Ct+d61FuhityEEXU/wWP08ZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKsRyiGlyLn5mLko0PMbbIub5T7OelvduoOeq+3SOFhzmy1eFs5p3Z43TWJf0pVjBGqAjAjZj8w408Q5itAIhxKkgdwciwieSez5+fQlEjq2H4KDucycCxiC88xpPkKZAhSibb4LT2FsRoGbTpbHQ7fN/B4oWWBiwLHxoVuPhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc4jz1xX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F35AC4CEEB;
	Mon,  9 Jun 2025 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749475282;
	bh=LGL6lMiRoy1C3r6cGW8Ct+d61FuhityEEXU/wWP08ZM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Sc4jz1xXyP3jz5eQLV049uceTTx03om/OMqT7PN9vxR/wp5lrGX/VvAQI1GZxRpGu
	 giKaa9j9QsOmIeTFlm71QV9BqE8Dvut67LbWPk3nAIIsSXwcDT63YMpwVR1ZUG++IK
	 ge4CJIEwbDx5Q8cITBNhSQWnb7x6zs20FfcrYvQKOXjcUENmPxwnrN8K4t9OhVA0MJ
	 YWYNQEurAMP0D3Vzig45u9nO9cl54wArsGXIWylZkBBWNLPrMDrN4LAwhK8Gq+exE9
	 OTpgsyGIfoxjmj++EG7fEpGWG0+prYra35kVaniQ65T/gAxDIr+FghqTliSmtMQV1d
	 dFgzns762DF0Q==
Message-ID: <33c80551bb7e0ac26ef00fe14aa9550df68ed120.camel@kernel.org>
Subject: Re: [PATCH 3/5] coda: use iterate_dir() in coda_readdir()
From: Jeff Layton <jlayton@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>, Jan Kara <jack@suse.cz>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner	 <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Amir Goldstein	 <amir73il@gmail.com>, David
 Howells <dhowells@redhat.com>, Tyler Hicks	 <code@tyhicks.com>, Miklos
 Szeredi <miklos@szeredi.hu>, Carlos Maiolino	 <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, coda@cs.cmu.edu, 	linux-nfs@vger.kernel.org,
 netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Jun 2025 09:21:20 -0400
In-Reply-To: <A70CCC08-E8BE-4655-9158-81754F4F6B35@cs.cmu.edu>
References: <20250608230952.20539-1-neil@brown.name>
	 <20250608230952.20539-4-neil@brown.name>
	 <8f2bf3aed5d7bd005adcdeaa51c02c7aa9ca14ba.camel@kernel.org>
	 <6zirxkpkdrtpcoewopaaotmw4jpjvjmqq4tijudvrpeo4227pi@hyljuie6ngem>
	 <A70CCC08-E8BE-4655-9158-81754F4F6B35@cs.cmu.edu>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-09 at 09:12 -0400, Jan Harkes wrote:
> There are definitely still users of Coda at CMU, I don't track who else u=
ses it, but it cannot be too many for sure.
>=20
> At this point it mostly keeps you honest about little locking details in =
the vfs. There are some tricky details in how the inode mappings are access=
ed and such. I think that  is helpful for overlay and user filesystems like=
 fuse, overlayfs, etc. but Coda is quite small so it is easy to reason abou=
t how it uses these features.
>=20
>=20

The reason I ask is that it's one of the places that we often have to
do odd fixups like this when making changes to core VFS APIs. It's also
not seen any non-collateral changes since 2021. I'm just wondering
whether it's worth it to keep coda in-tree for so few users.

IIRC, it's also the only fs in the kernel that changes its
inode->i_mapping pointer after inode instantiation. If not for coda, we
could probably replace the i_mapping pointer with some macro wizardry
and shrink struct inode by 8 bytes.


> On June 9, 2025 9:00:31 AM EDT, Jan Kara <jack@suse.cz> wrote:
> > On Mon 09-06-25 08:17:15, Jeff Layton wrote:
> > > On Mon, 2025-06-09 at 09:09 +1000, NeilBrown wrote:
> > > > The code in coda_readdir() is nearly identical to iterate_dir().
> > > > Differences are:
> > > >  - iterate_dir() is killable
> > > >  - iterate_dir() adds permission checking and accessing notificatio=
ns
> > > >=20
> > > > I believe these are not harmful for coda so it is best to use
> > > > iterate_dir() directly.  This will allow locking changes without
> > > > touching the code in coda.
> > > >=20
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > ---
> > > >  fs/coda/dir.c | 12 ++----------
> > > >  1 file changed, 2 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> > > > index ab69d8f0cec2..ca9990017265 100644
> > > > --- a/fs/coda/dir.c
> > > > +++ b/fs/coda/dir.c
> > > > @@ -429,17 +429,9 @@ static int coda_readdir(struct file *coda_file=
, struct dir_context *ctx)
> > > >  	cfi =3D coda_ftoc(coda_file);
> > > >  	host_file =3D cfi->cfi_container;
> > > > =20
> > > > -	if (host_file->f_op->iterate_shared) {
> > > > -		struct inode *host_inode =3D file_inode(host_file);
> > > > -		ret =3D -ENOENT;
> > > > -		if (!IS_DEADDIR(host_inode)) {
> > > > -			inode_lock_shared(host_inode);
> > > > -			ret =3D host_file->f_op->iterate_shared(host_file, ctx);
> > > > -			file_accessed(host_file);
> > > > -			inode_unlock_shared(host_inode);
> > > > -		}
> > > > +	ret =3D iterate_dir(host_file, ctx);
> > > > +	if (ret !=3D -ENOTDIR)
> > > >  		return ret;
> > > > -	}
> > > >  	/* Venus: we must read Venus dirents from a file */
> > > >  	return coda_venus_readdir(coda_file, ctx);
> > > >  }
> > >=20
> > >=20
> > > Is it already time for my annual ask of "Who the heck is using coda
> > > these days?" Anyway, this patch looks fine to me.
> > >=20
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Send a patch proposing deprecating it and we might learn that :) Search=
ing
> > the web seems to suggest it is indeed pretty close to dead.
> >=20
> > 								Honza

--=20
Jeff Layton <jlayton@kernel.org>

