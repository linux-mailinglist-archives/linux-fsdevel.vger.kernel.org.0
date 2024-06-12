Return-Path: <linux-fsdevel+bounces-21525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B8F905195
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 13:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CF81C21558
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A516F0FE;
	Wed, 12 Jun 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vIgmHWUh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qH8Tn7kw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vIgmHWUh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qH8Tn7kw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879316D4D3;
	Wed, 12 Jun 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192880; cv=none; b=QKr6t3yPXMPH+QTh5uZRk7fVHvP4HUq0u0JuyBZyY2nhjtiSjzTepy2Se/kg8fj3SCBJznj6p33PqN46Z0poQwAXz0xjupj9dVXrLzebXGdPW4Dzq9+FO3tECVQkGC6DiPBL+xPl1HhAIzPVvedfrtlgCmwCyWCsUtYDRyCbgfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192880; c=relaxed/simple;
	bh=cDsr5sqD9BJyp9/XsRv/vkxxtNf8fK7e4zSapt4WqYc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aTUhNI1DUhJrolBktfgFuxDLvIeBxB2vG6oG6OmH3Uym5Pdqha6XTb6lEkaE4k58J3/8ueNbey1pjNYCxo8UOYAovNpp0UOeTG9IpDiEsfQnWRujuCYUEJ0rz8ATBhXYlKhQb4IHfAWtqwf2pUAz0qx6DK3qc8W2EvXCYxlhGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vIgmHWUh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qH8Tn7kw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vIgmHWUh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qH8Tn7kw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A6405C161;
	Wed, 12 Jun 2024 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718192876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
	b=vIgmHWUhwb6cvZRmqUuWDpP2HqgoxszL/5/EBqAxkQ/j95uG7tqu0Atog10lPDZ5zZa2ep
	Njm9HJb8hwY/mYbiL2n30Yal1Nucl8ozRXYiMjfNHxAct04Xr2dDxIo1H5gEU8Dd4mc+Tz
	tQX+zf2S07LWlgUkXX1r90fC1lQfJa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718192876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
	b=qH8Tn7kwJtS63vuzriQ8mY9AdSKK9PjmHpyFoTFEpACUu+s/4r7sdqQyEVbplQFAZcnuRf
	Gm9ktDAENTcYjUBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vIgmHWUh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qH8Tn7kw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718192876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
	b=vIgmHWUhwb6cvZRmqUuWDpP2HqgoxszL/5/EBqAxkQ/j95uG7tqu0Atog10lPDZ5zZa2ep
	Njm9HJb8hwY/mYbiL2n30Yal1Nucl8ozRXYiMjfNHxAct04Xr2dDxIo1H5gEU8Dd4mc+Tz
	tQX+zf2S07LWlgUkXX1r90fC1lQfJa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718192876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
	b=qH8Tn7kwJtS63vuzriQ8mY9AdSKK9PjmHpyFoTFEpACUu+s/4r7sdqQyEVbplQFAZcnuRf
	Gm9ktDAENTcYjUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81EE41372E;
	Wed, 12 Jun 2024 11:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5PqpCeiKaWZzGgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 11:47:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "James Clark" <james.clark@arm.com>, ltp@lists.linux.it,
 linux-nfs@vger.kernel.org, "LKML" <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
In-reply-to:
 <CAOQ4uxidUYY02xry+y5VpRWfBjCmAt0CnmJ3JbgLTLkZ6nn1sA@mail.gmail.com>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>,
 <CAOQ4uxidUYY02xry+y5VpRWfBjCmAt0CnmJ3JbgLTLkZ6nn1sA@mail.gmail.com>
Date: Wed, 12 Jun 2024 21:47:48 +1000
Message-id: <171819286884.14261.11045203598673536466@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A6405C161
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 12 Jun 2024, Amir Goldstein wrote:
> On Wed, Jun 12, 2024 at 10:10=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
> >
> >
> > When a file is opened and created with open(..., O_CREAT) we get
> > both the CREATE and OPEN fsnotify events and would expect them in that
> > order.   For most filesystems we get them in that order because
> > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > fsnotify_open().
> >
> > However when ->atomic_open is used, the
> >    do_dentry_open() -> fsnotify_open()
> > call happens from finish_open() which is called from the ->atomic_open
> > handler in lookup_open() which is called *before* open_last_lookups()
> > calls fsnotify_create.  So we get the "open" notification before
> > "create" - which is backwards.  ltp testcase inotify02 tests this and
> > reports the inconsistency.
> >
> > This patch lifts the fsnotify_open() call out of do_dentry_open() and
> > places it higher up the call stack.  There are three callers of
> > do_dentry_open().
> >
> > For vfs_open() and kernel_file_open() the fsnotify_open() is placed
> > directly in that caller so there should be no behavioural change.
> >
> > For finish_open() there are two cases:
> >  - finish_open is used in ->atomic_open handlers.  For these we add a
> >    call to fsnotify_open() at the top of do_open() if FMODE_OPENED is
> >    set - which means do_dentry_open() has been called.
> >  - finish_open is used in ->tmpfile() handlers.  For these a similar
> >    call to fsnotify_open() is added to vfs_tmpfile()
>=20
> Any handlers other than ovl_tmpfile()?

Local filesystems tend to call finish_open_simple() which is a trivial
wrapper around finish_open().
Every .tmpfile handler calls either finish_open() or finish_open_simple().

> This one is a very recent and pretty special case.
> Did open(O_TMPFILE) used to emit an OPEN event before that change?

I believe so, yes.

Thanks,
NeilBrown

>=20
> >
> > With this patch NFSv3 is restored to its previous behaviour (before
> > ->atomic_open support was added) of generating CREATE notifications
> > before OPEN, and NFSv4 now has that same correct ordering that is has
> > not had before.  I haven't tested other filesystems.
> >
> > Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC co=
rrectly.")
> > Reported-by: James Clark <james.clark@arm.com>
> > Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@=
arm.com
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/namei.c |  5 +++++
> >  fs/open.c  | 19 ++++++++++++-------
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 37fb0a8aa09a..057afacc4b60 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
> >         int acc_mode;
> >         int error;
> >
> > +       if (file->f_mode & FMODE_OPENED)
> > +               fsnotify_open(file);
> > +
> >         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> >                 error =3D complete_walk(nd);
> >                 if (error)
> > @@ -3700,6 +3703,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
> >         mode =3D vfs_prepare_mode(idmap, dir, mode, mode, mode);
> >         error =3D dir->i_op->tmpfile(idmap, dir, file, mode);
> >         dput(child);
> > +       if (file->f_mode & FMODE_OPENED)
> > +               fsnotify_open(file);
> >         if (error)
> >                 return error;
> >         /* Don't check for other permissions, the inode was just created =
*/
> > diff --git a/fs/open.c b/fs/open.c
> > index 89cafb572061..970f299c0e77 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1004,11 +1004,6 @@ static int do_dentry_open(struct file *f,
> >                 }
> >         }
> >
> > -       /*
> > -        * Once we return a file with FMODE_OPENED, __fput() will call
> > -        * fsnotify_close(), so we need fsnotify_open() here for symmetry.
> > -        */
> > -       fsnotify_open(f);
> >         return 0;
> >
> >  cleanup_all:
> > @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
> >   */
> >  int vfs_open(const struct path *path, struct file *file)
> >  {
> > +       int ret;
> > +
> >         file->f_path =3D *path;
> > -       return do_dentry_open(file, NULL);
> > +       ret =3D do_dentry_open(file, NULL);
> > +       if (!ret)
> > +               /*
> > +                * Once we return a file with FMODE_OPENED, __fput() will=
 call
> > +                * fsnotify_close(), so we need fsnotify_open() here for =
symmetry.
> > +                */
> > +               fsnotify_open(file);
>=20
> I agree that this change preserves the logic, but (my own) comment
> above is inconsistent with the case of:
>=20
>         if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
>                 return -EINVAL;
>=20
> Which does set FMODE_OPENED, but does not emit an OPEN event.

If I understand correctly, that case doesn't emit an OPEN event before
my patch, but will result in a CLOSE event.
After my patch ... I think it still doesn't emit OPEN.

I wonder if, instead of adding the the fsnotify_open() in do_open(), we
should put it in the\
	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
case of open_last_lookups().

Or maybe it really doesn't hurt to have a CLOSE event without and OPEN.=20
OPEN without CLOSE would be problematic, but the other way around
shouldn't matter....  It feels untidy, but maybe we don't care.

Thanks,
NeilBrown


>=20
> I have a feeling that the comment is correct about the CLOSE event in
> that case, but honestly, I don't think this corner case is that important,
> just maybe the comment needs to be slightly clarified?
>=20
> Thanks,
> Amir.
>=20
> > +       return ret;
> >  }
> >
> >  struct file *dentry_open(const struct path *path, int flags,
> > @@ -1178,7 +1182,8 @@ struct file *kernel_file_open(const struct path *pa=
th, int flags,
> >         if (error) {
> >                 fput(f);
> >                 f =3D ERR_PTR(error);
> > -       }
> > +       } else
> > +               fsnotify_open(f);
> >         return f;
> >  }
> >  EXPORT_SYMBOL_GPL(kernel_file_open);
> > --
> > 2.44.0
> >
>=20


