Return-Path: <linux-fsdevel+bounces-53586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91543AF0864
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 04:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037691C05D9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499F17A2EA;
	Wed,  2 Jul 2025 02:16:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D9FBF6;
	Wed,  2 Jul 2025 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422585; cv=none; b=H+BfGkRjdI67OpKHOcXanTEQnV7tKJkW7JNft0MtJfeIZmEbNyKfrfqTBlAxIdc0xsPpOzNusc7bZ6Q4LzzH4rlbaRswOBSpB8gOx5DlkhFhVxzkUiL6wYId6tKU78SM6bHHZ4OCrvpHm/5zzGz4QnjK2aNRnxPJCgL4c+3hEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422585; c=relaxed/simple;
	bh=KSjOCxH0JSJcefO+vKgYyGtoBcDCM2Dr7rhqNWRzXNA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RPU49RbfNDU20l0C9vSdwb8w3KGexNwHj+ufVLOhg6qAwBCc+GUy++KFg3/XYC8rETVF4rFKS9ZRgQY9PHvUs0ck7x8E8GpJwn3l9jWblJZ9j5ydL9P/joMx7+naNcQ0gFgmGO6G0+ZYxyEQlo5VH7manyKk+ynlza+Jl4XaZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWn1G-00GI4S-JQ;
	Wed, 02 Jul 2025 02:16:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/12] ovl: narrow locking in ovl_rename()
In-reply-to:
 <CAOQ4uxjDK3AJoY-geRLprvSKEW7UopJLY_9WcJ0LjwiKAP29uA@mail.gmail.com>
References:
 <>, <CAOQ4uxjDK3AJoY-geRLprvSKEW7UopJLY_9WcJ0LjwiKAP29uA@mail.gmail.com>
Date: Wed, 02 Jul 2025 12:16:18 +1000
Message-id: <175142257818.565058.8422284947466318667@noble.neil.brown.name>

On Thu, 26 Jun 2025, Amir Goldstein wrote:
> On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Drop the rename lock immediately after the rename, and use
> > ovl_cleanup_unlocked() for cleanup.
> >
> > This makes way for future changes where locks are taken on individual
> > dentries rather than the whole directory.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 2b879d7c386e..5afe17cee305 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1270,9 +1270,10 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
> >                             new_upperdir, newdentry, flags);
> >         if (err)
> >                 goto out_dput;
> > +       unlock_rename(new_upperdir, old_upperdir);
> >
> >         if (cleanup_whiteout)
> > -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> > +               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
> >
> >         if (overwrite && d_inode(new)) {
> >                 if (new_is_dir)
> > @@ -1291,12 +1292,8 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
> >         if (d_inode(new) && ovl_dentry_upper(new))
> >                 ovl_copyattr(d_inode(new));
> >
> > -out_dput:
> >         dput(newdentry);
> > -out_dput_old:
> >         dput(olddentry);
> > -out_unlock:
> > -       unlock_rename(new_upperdir, old_upperdir);
> >  out_revert_creds:
> >         ovl_revert_creds(old_cred);
> >         if (update_nlink)
> > @@ -1307,6 +1304,14 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
> >         dput(opaquedir);
> >         ovl_cache_free(&list);
> >         return err;
> > +
> > +out_dput:
> > +       dput(newdentry);
> > +out_dput_old:
> > +       dput(olddentry);
> > +out_unlock:
> > +       unlock_rename(new_upperdir, old_upperdir);
> > +       goto out_revert_creds;
> >  }
>=20
> Once again, I really do not like the resulting code flow.
> This is a huge function and impossile to follow all condition.
> As a rule of thumb, I think you need to factor out the block of code under
> lock_rename() to avoid those horrible goto mazes.

I'll see what I can do to improve it.

>=20
> The no error case used to do dput(newdentry) and dput(olddentry)
> how come they are gone now?
> what am I missing?

Those dput()s are still there.  I removed the goto labels between them
but not the dput()s themselves.

Thanks,
NeilBrown

>=20
> Thanks,
> Amir.
>=20


