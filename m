Return-Path: <linux-fsdevel+bounces-57816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA98B258D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A8F7229B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3BE190664;
	Thu, 14 Aug 2025 01:13:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EA2FF653;
	Thu, 14 Aug 2025 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134012; cv=none; b=Q9T7IXMFGVX9J6zQG/CyI9FQZRg6UJqItCK0mvLLnJwVe8EG0n2rRL4BJEFplrj7uFt01lhBSY8lUAyccaLkS++hMzTe/0YffMV2Gt16Zrh9fPDaNuysHqlR9MXKzfGr1LqCkSwEboHF3kRRQ1cAnivTcVOqYLG45xvpVjdEgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134012; c=relaxed/simple;
	bh=5v9NdgrIL68h/Zn/HscHqxUBL3WZYUGNHlkxFV453ds=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=L4OEL91qFARV1xNSMyJGK0PDdaeCAKv0PySSFtajWrnaNQtaDqZLGlndkvqiG7JBI3TJUCPNUw1sfAdrNyYEsJGBaBdb7M1q/UFAidCS+AEXRtWu/I2sNKc+rXAq+x1ej1tjc4+uoApL7tgBVZMdpCaHIbutFRD3gBTh0t9trco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umMWx-005h4S-F7;
	Thu, 14 Aug 2025 01:13:25 +0000
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
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Steve French" <sfrench@samba.org>, "Namjae Jeon" <linkinjeon@kernel.org>,
 "Carlos Maiolino" <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, netfs@lists.linux.dev,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] VFS: Change vfs_mkdir() to unlock on failure.
In-reply-to:
 <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
References:
 <>, <CAOQ4uxhU12U8g_EYkUyc4Jdpzjy3hT1hZYB0L1THwvTsti8mTw@mail.gmail.com>
Date: Thu, 14 Aug 2025 11:13:24 +1000
Message-id: <175513400457.2234665.11514455496974675927@noble.neil.brown.name>

On Wed, 13 Aug 2025, Amir Goldstein wrote:
> On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Proposed changes to directory-op locking will lock the dentry rather
> > than the whole directory.  So the dentry will need to be unlocked.
> >
> > vfs_mkdir() consumes the dentry on error, so there will be no dentry to
> > be unlocked.
>=20
> Why does it need to consume the dentry on error?

Because when the recent change was made to have vfs_mkdir() and ->mkdir
handling the fact that the passed-in denty might not be used, that was
the interface that was deemed to be best of all that were considered.


> Why can't it leave the state as is on error and let the caller handle
> its own cleanup?

There are three possible results from vfs_mkdir()
 - the dentry that was passed in has been instantiated
 - a different dentry was already attached to the inode, and it has been
   splice in to the given name
 - there was an error.

In the second case it seems easiest to dput() the original dentry as it
is no longer interesting and that saves the caller from having the test
and maybe dput() - all callers would need identical handling.
It seemed most consistent to always dput() the passed-in dentry if it
wasn't returned.
>=20
> >
> > So this patch changes vfs_mkdir() to unlock on error as well as
> > releasing the dentry.  This requires various other functions in various
> > callers to also unlock on error - particularly in nfsd and overlayfs.
> >
> > At present this results in some clumsy code.  Once the transition to
> > dentry locking is complete the clumsiness will be gone.
> >
> > Callers of vfs_mkdir() in ecrypytfs, nfsd, xfs, cachefiles, and
> > overlayfs are changed to make the new behaviour.
>=20
> I will let Al do the vfs review of this and will speak up on behalf of
> the vfs users of the API
>=20
> One problem with a change like this - subtle change to semantics
> with no function prototype change is that it is a "backporting land mine"
> both AUTOSEL and human can easily not be aware of the subtle
> semantic change in a future time when a fix is being backported
> across this semantic change.
>=20
> Now there was a prototype change in c54b386969a5 ("VFS: Change
> vfs_mkdir() to return the dentry.") in v6.15 not long ago, so (big) if this
> semantic change (or the one that follows it) both get into the 2025 LTS
> kernel, we are in less of a problem, but if they don't, it's kind of a big
> problem for the stability of those subsystems in LTS kernels IMO -
> not being able to use "cleanly applies and build" as an indication to
> "likelihood of a correct backport".

Renaming to vfs_mkdir2() might be justified.  I think we have to change
the interface somehow to enable per-dentry locking, and I don't think a
signature change would be justified.  So maybe a name change is needed.

>=20
> and now onto review of ovl code...
>=20
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 70b8687dc45e..24f7e28b9a4f 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -162,14 +162,18 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
> >         goto out;
> >  }
> >
> > +/* dir will be unlocked on return */
> >  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct dentry *parent,
> > -                              struct dentry *newdentry, struct ovl_cattr=
 *attr)
> > +                              struct dentry *newdentry_arg, struct ovl_c=
attr *attr)
> >  {
> >         struct inode *dir =3D parent->d_inode;
> > +       struct dentry *newdentry __free(dentry_lookup) =3D newdentry_arg;
> >         int err;
> >
> > -       if (IS_ERR(newdentry))
> > +       if (IS_ERR(newdentry)) {
> > +               inode_unlock(dir);
> >                 return newdentry;
> > +       }
> >
> >         err =3D -ESTALE;
> >         if (newdentry->d_inode)
> > @@ -213,12 +217,9 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct dentry *parent,
> >                 err =3D -EIO;
> >         }
> >  out:
> > -       if (err) {
> > -               if (!IS_ERR(newdentry))
> > -                       dput(newdentry);
> > +       if (err)
> >                 return ERR_PTR(err);
> > -       }
> > -       return newdentry;
> > +       return dget(newdentry);
> >  }
> >
> >  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
> > @@ -228,7 +229,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
> >         inode_lock(workdir->d_inode);
> >         ret =3D ovl_create_real(ofs, workdir,
> >                               ovl_lookup_temp(ofs, workdir), attr);
> > -       inode_unlock(workdir->d_inode);
>=20
> Things like that putting local code out of balance make my life as
> maintainer very hard.

I understand.  By the end of the change this is no longer unbalanced.
Keeping the code perfect at each step while making each step coherent
enough to be reviewed is a challenge.


>=20
> I prefer that you leave the explicit dir unlock in the callers until the ti=
me
> that you change the create() API not require holding the dir lock.
>=20
> I don't even understand how you changed the call semantics to an ovl
> function that creates a directory or non-directory when your patch only
> changes mkdir semantics, but I don't want to know, because even if this
> works and I cannot easily understand how, then I do not want the confusing
> semantics in ovl code.
>=20
> I think you should be able to scope ovl_lookup_temp() with
> dentry_lookup*() { } done_dentry_lookup() and use whichever semantics
> you like about dir lock inside the helpers, as long as ovl code looks and f=
eels
> balanced.
>=20
> >         return ret;
> >  }
> >
> > @@ -336,7 +336,6 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
> >                                     ovl_lookup_upper(ofs, dentry->d_name.=
name,
> >                                                      upperdir, dentry->d_=
name.len),
> >                                     attr);
> > -       inode_unlock(udir);
> >         if (IS_ERR(newdentry))
> >                 return PTR_ERR(newdentry);
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index 4f84abaa0d68..238c26142318 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -250,6 +250,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_=
fs *ofs,
> >
> >         ret =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> >         pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZE=
RO(ret));
> > +       /* Note: dir will have been unlocked on failure */
> >         return ret;
> >  }
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index df85a76597e9..5a4b0a05139c 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -328,11 +328,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
> >                 }
> >
> >                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > -               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 if (IS_ERR(work))
> >                         goto out_err;
> >
> > +               dget(work); /* Need to return this */
> > +
> > +               done_dentry_lookup(work);
>=20
> Another weird example.
> I would expect that dentry_lookup*()/done_dentry_lookup()
> would be introduced to users in the same commit, so the code
> always remains balanced.
>=20
> All in all, I think you should drop this patch from the series altogether
> and drop dir unlock from callers only later after they have been
> converted to use the new API.
>=20
> Am I misunderstanding something that prevents you from doing that?

I think I tried delaying the vfs_mkdir() change and stumbled.
The problem involved done_path_create(). e.g. dev_mkdir() calls=20
  kern_path_create()
  vfs_mkdir()
  done_path_create()

Changing semantics of vfs_mkdir() necessitated a corresponding change in
done_path_create() and doing that necessitated prep elsewhere.
init_mkdir and ksmbd_vfs_mkdir follow the same pattern.

Maybe I could temporarily introduce a done_path_create_mkdir() for
those.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


