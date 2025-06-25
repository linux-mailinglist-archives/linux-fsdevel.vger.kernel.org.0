Return-Path: <linux-fsdevel+bounces-52976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AFFAE905C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74CF189F0FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497F26D4C9;
	Wed, 25 Jun 2025 21:45:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2B26CE0F;
	Wed, 25 Jun 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887929; cv=none; b=rjeRTVF/zcjvDEt7oNLI9YpZR0G5GqVLwOSs0YwuKq85LwGC8LR8Tqh3xlXC7Q78rH43kwDP2yL7peG1xYiGpczyzqfOMu9md3cUMmkB3AKfRxLnP96MdDvvddf9lheKF5zfSYf06eLJcvMfrC4gPumpnZzkPfJ4L6mj2NMliZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887929; c=relaxed/simple;
	bh=xzBP+699j1EQui1oe5SqTa5MCEOF8RKZFkPwrYRlLKw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SM5qGjM9FpvO7MWxhfVwH54R24ZilUdbrDCp78b5Cq0I8v3cPx87VfTlWRbY13OjEA1apepx9kb3NUGcYj3K7+mqcfNOyEK7blbjuQsgXhnoBgP42OAY/XVu448Q/yLVsPuvvB+R5Lf+a3WMgoIVJLyFjSAo0mRG7Ced4IDokLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUXvp-004rxc-5O;
	Wed, 25 Jun 2025 21:45:25 +0000
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
Subject: Re: [PATCH 01/12] ovl: use is_subdir() for testing if one thing is a
 subdir of another
In-reply-to:
 <CAOQ4uxhoVe2g+85C5e=UrGQHyyB=B4OgKcXF3B_puU+5j0mCRQ@mail.gmail.com>
References:
 <>, <CAOQ4uxhoVe2g+85C5e=UrGQHyyB=B4OgKcXF3B_puU+5j0mCRQ@mail.gmail.com>
Date: Thu, 26 Jun 2025 07:45:23 +1000
Message-id: <175088792304.2280845.17292051611230790520@noble.neil.brown.name>

On Thu, 26 Jun 2025, Amir Goldstein wrote:
> On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Rather than using lock_rename(), use the more obvious is_subdir() for
> > ensuring that neither upper nor workdir contain the other.
> > Also be explicit in the comment that the two directories cannot be the
> > same.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/super.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index cf99b276fdfb..db046b0d6a68 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -438,18 +438,12 @@ static int ovl_lower_dir(const char *name, struct p=
ath *path,
> >         return 0;
> >  }
> >
> > -/* Workdir should not be subdir of upperdir and vice versa */
> > +/* Workdir should not be subdir of upperdir and vice versa, and
> > + * they should not be the same.
> > + */
> >  static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperd=
ir)
> >  {
> > -       bool ok =3D false;
> > -
> > -       if (workdir !=3D upperdir) {
> > -               struct dentry *trap =3D lock_rename(workdir, upperdir);
> > -               if (!IS_ERR(trap))
> > -                       unlock_rename(workdir, upperdir);
> > -               ok =3D (trap =3D=3D NULL);
> > -       }
> > -       return ok;
> > +       return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, work=
dir);
>=20
> I am not at ease with this simplification to an unlocked test.
> In the cover letter you wrote that this patch is not like the other patches.
> Is this really necessary for your work?
> If not, please leave it out.

I assume that by "unlocked" you mean that there are two separate calls
to is_subdir() which are not guaranteed to be coherent.  I don't see how
that could be a problem.  The directory hierarchy could certainly change
between the calls, but it could equally change immediately after a fully
locked call, and thereby invalidate the result.  It is not possible to
provide a permanent guarantee that there is never a subdir relationship
between the two.

I don't absolutely need the patch.  I plan for lock_rename() to go away.
It will be replaced by lookup_and_lock_rename() which will lock two
dentries and protect the paths from them to their common ancestor from
any renames.  lookup_and_lock_rename() can be given the two dentries
rather than having it look them up given parents and names.  So it could
be used for this test.  It just seems to me to be unnecessary
complexity.  I will drop it (for now) if you like.

NeilBrown.

