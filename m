Return-Path: <linux-fsdevel+bounces-39749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C376BA174ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 00:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F192B16919F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 23:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1941B81C1;
	Mon, 20 Jan 2025 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OoF9juJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U7aIdhKK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OoF9juJQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U7aIdhKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5F2F30;
	Mon, 20 Jan 2025 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737414183; cv=none; b=ddUpwtwk7sDf6aEMRDTDkelaSYDW4/1Nd1G3PGxYqT5l6Iqa97go/jfLntyVSddD1FJOnXetn2TS4dplumGfbYFWO1i2VP2or1rVEQHqFOj6rErHJS2vaRNy7EbxtrnsMM3WVz3kTZB6J8Lf3DmCjE0VpYIB1GEXM0EzcIDiBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737414183; c=relaxed/simple;
	bh=UmHdWqf7mhQRao8Ro1O08vWRPBBghEEG3Wbj02yk9rE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SyeypMrYkf+5mxCWme/zMUoUs0BdFg/dXwgAZM7SF0QXwLrYUnvB0pQoExRimPYC/NCbkS4UGhDUhzHM91Toz6jXH+YzYtc/jFGJkPhE9OxLFm11IaBBvjklCtNTBFpZCFTXH7tYOn2ZavmCnjYInEtu9D6xwbt8JIfc/+C/dzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OoF9juJQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U7aIdhKK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OoF9juJQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U7aIdhKK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A707A211C6;
	Mon, 20 Jan 2025 23:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737414179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr53aNrrG8Hetxi8G7WxJqz9rZjtvNBevtS41fgCU38=;
	b=OoF9juJQVNhz6w1XBLrWB5W2e/d7qumVtKs2E0ral1RYPxQpueM34I7JUEIoOkwSVzvzpT
	0RsGbmloFyidfMoI/udNGEme5+kV6mZm6AwwBJJvcoEpSuarWakj9Quzqnb752nsdUjGJo
	b2l2xNcoMwqGRTXwwJT3tDfRBxIJj/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737414179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr53aNrrG8Hetxi8G7WxJqz9rZjtvNBevtS41fgCU38=;
	b=U7aIdhKKPre475VKhaehScCwqiGB23Iv9pCLtZMek7OS6qaBJppNumWG09E7eUYY3cZZ6q
	gxHRYKJQ+QJgVsCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737414179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr53aNrrG8Hetxi8G7WxJqz9rZjtvNBevtS41fgCU38=;
	b=OoF9juJQVNhz6w1XBLrWB5W2e/d7qumVtKs2E0ral1RYPxQpueM34I7JUEIoOkwSVzvzpT
	0RsGbmloFyidfMoI/udNGEme5+kV6mZm6AwwBJJvcoEpSuarWakj9Quzqnb752nsdUjGJo
	b2l2xNcoMwqGRTXwwJT3tDfRBxIJj/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737414179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr53aNrrG8Hetxi8G7WxJqz9rZjtvNBevtS41fgCU38=;
	b=U7aIdhKKPre475VKhaehScCwqiGB23Iv9pCLtZMek7OS6qaBJppNumWG09E7eUYY3cZZ6q
	gxHRYKJQ+QJgVsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84138139CB;
	Mon, 20 Jan 2025 23:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MTK/DSHWjmdueAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 20 Jan 2025 23:02:57 +0000
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
Cc: "Trond Myklebust" <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
In-reply-to:
 <CAOQ4uxhXuHPsaqzH7SJ-W93dX4ZCJip3CN_P9ZY5f5eb95k6Qg@mail.gmail.com>
References:
 <>, <CAOQ4uxhXuHPsaqzH7SJ-W93dX4ZCJip3CN_P9ZY5f5eb95k6Qg@mail.gmail.com>
Date: Tue, 21 Jan 2025 10:02:53 +1100
Message-id: <173741417318.22054.17226687272828997971@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 21 Jan 2025, Amir Goldstein wrote:
> On Mon, Jan 20, 2025 at 8:29=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
> >
> > On Mon, 2025-01-20 at 20:14 +0100, Amir Goldstein wrote:
> > > On Mon, Jan 20, 2025 at 7:45=E2=80=AFPM Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > >
> > > > On Mon, 2025-01-20 at 19:21 +0100, Amir Goldstein wrote:
> > > > > On Mon, Jan 20, 2025 at 6:28=E2=80=AFPM Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > >
> > > > > > On Mon, 2025-01-20 at 18:20 +0100, Amir Goldstein wrote:
> > > > > > > v4 client maps NFS4ERR_FILE_OPEN =3D> EBUSY for all operations.
> > > > > > >
> > > > > > > v4 server only maps EBUSY =3D> NFS4ERR_FILE_OPEN for
> > > > > > > rmdir()/unlink()
> > > > > > > although it is also possible to get EBUSY from rename() for
> > > > > > > the
> > > > > > > same
> > > > > > > reason (victim is a local mount point).
> > > > > > >
> > > > > > > Filesystems could return EBUSY for other operations, so just
> > > > > > > map
> > > > > > > it
> > > > > > > in server for all operations.
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Chuck,
> > > > > > >
> > > > > > > I ran into this error with a FUSE filesystem and returns -
> > > > > > > EBUSY
> > > > > > > on
> > > > > > > open,
> > > > > > > but I noticed that vfs can also return EBUSY at least for
> > > > > > > rename().
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Amir.
> > > > > > >
> > > > > > >  fs/nfsd/vfs.c | 10 ++--------
> > > > > > >  1 file changed, 2 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > > > index 29cb7b812d713..a61f99c081894 100644
> > > > > > > --- a/fs/nfsd/vfs.c
> > > > > > > +++ b/fs/nfsd/vfs.c
> > > > > > > @@ -100,6 +100,7 @@ nfserrno (int errno)
> > > > > > >               { nfserr_perm, -ENOKEY },
> > > > > > >               { nfserr_no_grace, -ENOGRACE},
> > > > > > >               { nfserr_io, -EBADMSG },
> > > > > > > +             { nfserr_file_open, -EBUSY},
> > > > > > >       };
> > > > > > >       int     i;
> > > > > > >
> > > > > > > @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp,
> > > > > > > struct
> > > > > > > svc_fh *fhp, int type,
> > > > > > >  out_drop_write:
> > > > > > >       fh_drop_write(fhp);
> > > > > > >  out_nfserr:
> > > > > > > -     if (host_err =3D=3D -EBUSY) {
> > > > > > > -             /* name is mounted-on. There is no perfect
> > > > > > > -              * error status.
> > > > > > > -              */
> > > > > > > -             err =3D nfserr_file_open;
> > > > > > > -     } else {
> > > > > > > -             err =3D nfserrno(host_err);
> > > > > > > -     }
> > > > > > > +     err =3D nfserrno(host_err);
> > > > > > >  out:
> > > > > > >       return err;
> > > > > > >  out_unlock:
> > > > > >
> > > > > > If this is a transient error, then it would seem that
> > > > > > NFS4ERR_DELAY
> > > > > > would be more appropriate.
> > > > >
> > > > > It is not a transient error, not in the case of a fuse file open
> > > > > (it is busy as in locked for as long as it is going to be locked)
> > > > > and not in the case of failure to unlink/rename a local
> > > > > mountpoint.
> > > > > NFS4ERR_DELAY will cause the client to retry for a long time?
> > > > >
> > > > > > NFS4ERR_FILE_OPEN is not supposed to apply
> > > > > > to directories, and so clients would be very confused about how
> > > > > > to
> > > > > > recover if you were to return it in this situation.
> > > > >
> > > > > Do you mean specifically for OPEN command, because commit
> > > > > 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
> > > > > added the NFS4ERR_FILE_OPEN response for directories five years
> > > > > ago and vfs_rmdir can certainly return a non-transient EBUSY.
> > > > >
> > > >
> > > > I'm saying that clients expect NFS4ERR_FILE_OPEN to be returned in
> > > > response to LINK, REMOVE or RENAME only in situations where the
> > > > error
> > > > itself applies to a regular file.
> > >
> > > This is very far from what upstream nfsd code implements (since 2019)
> > > 1. out of the above, only REMOVE returns NFS4ERR_FILE_OPEN
> > > 2. NFS4ERR_FILE_OPEN is not limited to non-dir
> > > 3. NFS4ERR_FILE_OPEN is not limited to silly renamed file -
> > >     it will also be the response for trying to rmdir a mount point
> > >     or trying to unlink a file which is a bind mount point
> >
> > Fair enough. I believe the name given to this kind of server behaviour
> > is "bug".
> >
> > >
> > > > The protocol says that the client can expect this return value to
> > > > mean
> > > > it is dealing with a server with Windows-like semantics that
> > > > doesn't
> > > > allow these particular operations while the file is being held
> > > > open. It
> > > > says nothing about expecting the same behaviour for mountpoints,
> > > > and
> > > > since the latter have a very different life cycle than file open
> > > > state
> > > > does, you should not treat those cases as being the same.
> > >
> > > The two cases are currently indistinguishable in nfsd_unlink(), but
> > > it could check DCACHE_NFSFS_RENAMED flag if we want to
> > > limit NFS4ERR_FILE_OPEN to this specific case - again, this is
> > > upstream code - nothing to do with my patch.
> > >
> > > FWIW, my observed behavior of Linux nfs client for this error
> > > is about 1 second retries and failure with -EBUSY, which is fine
> > > for my use case, but if you think there is a better error to map
> > > EBUSY it's fine with me. nfsv3 maps it to EACCES anyway.
> > >
> > >
> >
> > When doing LINK, RENAME, REMOVE on a mount point, I'd suggest returning
> > NFS4ERR_XDEV, since that is literally a case of trying to perform the
> > operation across a filesystem boundary.
>=20
> I would not recommend doing that. vfs hides those tests in vfs_rename(), etc
> I don't think that nfsd should repeat them for this specialize interpretati=
on,
> because to be clear, this is specially not an EXDEV situation as far as vfs
> is concerned.
>=20
> >
> > Otherwise, since Linux doesn't implement Windows behaviour w.r.t. link,
> > rename or remove, it would seem that NFS4ERR_ACCESS is indeed the most
> > appropriate error, no? It's certainly the right behaviour for
> > sillyrenamed files.
>=20
> If NFS4ERR_ACCESS is acceptable for sillyrenamed files, we can map
> EBUSY to NFS4ERR_ACCESS always and be done with it, but TBH,
> reading the explanation for the chosen error code, I tend to agree with it.
> It is a very nice added benefit for me that the NFS clients get EBUSY when
> the server gets an EBUSY, so I don't see what's the problem with that.

I agreed with it when I wrote it :-) but now I find Trond's argument to
be quite compelling.  Fomr rfc5661:

15.1.4.5.  NFS4ERR_FILE_OPEN (Error Code 10046)

   The operation is not allowed because a file involved in the operation
   is currently open.  Servers may, but are not required to, disallow
   linking-to, removing, or renaming open files.

This doesn't seem to cover "rmdir" of a mountpoint.

However NFS4ERR_XDEV is only permitted for LINK and RENAME, not for
REMOVE, so we cannot use that.

NFS4ERR_ACCESS says "Indicates permission denied" but there is no
permission issue here.

NFS4ERR_INVAL might be ok.  "The arguments for this operation are not
valid for some reason" is suitably vague.

NFS4ERR_NOTEMPTY "An attempt was made to remove a directory that was not
empty." could be argued as it "contains" a mountpoint in some sense.

I'd favour NFS4ERR_INVAL today.  I might change my mind again tomorrow.

NeilBrown

