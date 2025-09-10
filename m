Return-Path: <linux-fsdevel+bounces-60730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B37B50BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 04:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD0D3A6F59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03D245019;
	Wed, 10 Sep 2025 02:49:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AA23D7C8
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472590; cv=none; b=IqX2wVK+nLKRrozmGVe6RLWpE9PNUzvvdyvE3vkPyO+aYOBM528xWXI2k/gZxng1gINMmV0G4jcwuzgPDtxoJtIx9LUHDD2VXky20PIqhliKTWdhcAAZQ7R4j7w2a2Q7EXakardaDExTE+gYFN1ZoIhf18k177cXs80cjeYmavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472590; c=relaxed/simple;
	bh=Wrayx8SDsfCmAKOYJm6bNpINi2LmcVQr0dvH+c3eTSw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TAZ5Ij6QDNQ4kWT4CvKrH2FyHWnxhevFOm94Iu7mnPNMIELLuktvoBRm0/GVx9O7SksFgj3uPO1rTxls8JsdcKRuGFrzPBhjprDvWyYau1+w77jpWwvmyvQKum7Qeryyv/QWGhlbz5eT+ldR2nT/W9+ndzYCvVZzOZQwXA4lMHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uwAu1-008tid-0K;
	Wed, 10 Sep 2025 02:49:46 +0000
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v2 5/7] VFS: rename kern_path_locked() and related functions.
In-reply-to:
 <CAOQ4uxhEEVz2KRK-TtS=xjdMbLiOCkT=y66vx8NfzGQOgCZ=MA@mail.gmail.com>
References:
 <>, <CAOQ4uxhEEVz2KRK-TtS=xjdMbLiOCkT=y66vx8NfzGQOgCZ=MA@mail.gmail.com>
Date: Wed, 10 Sep 2025 12:49:46 +1000
Message-id: <175747258648.2850467.12932143214080161367@noble.neil.brown.name>

On Wed, 10 Sep 2025, Amir Goldstein wrote:
> On Tue, Sep 9, 2025 at 6:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > kern_path_locked() is now only used to prepare for removing an object
> > from the filesystem (and that is the only credible reason for wanting a
> > positive locked dentry).  Thus it corresponds to kern_path_create() and
> > so should have a corresponding name.
> >
> > Unfortunately the name "kern_path_create" is somewhat misleading as it
> > doesn't actually create anything.  The recently added
> > simple_start_creating() provides a better pattern I believe.  The
> > "start" can be matched with "end" to bracket the creating or removing.
> >
> > So this patch changes names:
> >
> >  kern_path_locked -> start_removing_path
> >  kern_path_create -> start_creating_path
> >  user_path_create -> start_creating_user_path
> >  user_path_locked_at -> start_removing_user_path_at
> >  done_path_create -> end_creating_path
>=20
> This looks nice.
>=20
> With one comment below fixed feel free to add:
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks.


> > @@ -2770,15 +2771,25 @@ static struct dentry *__kern_path_locked(int dfd,=
 struct filename *name, struct
> >                 return ERR_PTR(error);
> >         if (unlikely(type !=3D LAST_NORM))
> >                 return ERR_PTR(-EINVAL);
>=20
> This abnormal error handling pattern deserves a comment:
>   /* don't fail immediately if it's r/o, at least try to report other error=
s */

Just like in start_creating_path().  Yes, that is fair.  Done.

Thanks,
NeilBrown


>=20
> > +       error =3D mnt_want_write(path->mnt);
> >         inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
> >         d =3D lookup_one_qstr_excl(&last, parent_path.dentry, 0);
> > -       if (IS_ERR(d)) {
> > -               inode_unlock(parent_path.dentry->d_inode);
> > -               return d;
> > -       }
> > +       if (IS_ERR(d))
> > +               goto unlock;
> > +       if (error)
> > +               goto fail;
> >         path->dentry =3D no_free_ptr(parent_path.dentry);
> >         path->mnt =3D no_free_ptr(parent_path.mnt);
> >         return d;
> > +
> > +fail:
> > +       dput(d);
> > +       d =3D ERR_PTR(error);
> > +unlock:
> > +       inode_unlock(parent_path.dentry->d_inode);
> > +       if (!error)
> > +               mnt_drop_write(path->mnt);
> > +       return d;
> >  }

