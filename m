Return-Path: <linux-fsdevel+bounces-58271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F4AB2BC02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A9152856D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685BA311965;
	Tue, 19 Aug 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbD+nLdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07091255F5E;
	Tue, 19 Aug 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592666; cv=none; b=WWlY1Q0VVT93mrzU50voTLX2r/srHdG/Wz2S8mAGwTsCFhLd5dOu52nm0b9XgnhZCcnZxM+A1hPl8zDbCJpknyLRN0Qcn6OLERVUeqppH4yFGEFOYaY8+NrDZDfBFVMzvQeyzF6JJ2D05s3in34+hBAhX6opg+dRSx7HPPZCIcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592666; c=relaxed/simple;
	bh=ov/SDoBL+KsjXinmNBAv6oD0ygTe84CUkHPGDAYLt90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwi8kncZlyUYUOf8gtiWsB5E9ZuCeXd1ASDAQHq/gP5BKFfXms6rbi6SMWcWLauoGF5H38S6yGq/yxCDxsB8FWZrnfmpFNKnv1T9gL8dvqUpbUWyb7oVp/rxRN+XJWszYJILayioRflH1MEbiJQ+PDNrD+7ElEJDPr7zBzHyU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbD+nLdc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b654241so8938557a12.1;
        Tue, 19 Aug 2025 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755592663; x=1756197463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFsGbO5uv2uZgsEZblgTie/lOV7b8K80hkUH8T7DIVU=;
        b=HbD+nLdciHnzHGLZWK7rd9vx0k0s77RcTGDq8lOzaIT+iDewhaTDddhEYxHG4qw7rh
         B1NvvruURnsOqmVA1Nrf1F/vD87IPKfcqDRejCCUkn8/EM5pXAvxfs2dkF1/mgAxFLQu
         VM7ywV7oxpnn8wnbtOxxabzCMlmaOr7eLRCEPe5OcnHVoaEf3UOMts0s+3HRALMd4Pfp
         yb4bsrne6PJG10xbjRgiovkXGwXUfiASPJt5wIT7ntNnDZj9PqM7y5sbtz30I/c/APfa
         T5o/jXRmXUaSn1qKFliWXSvu/PxggqmeoSApI4UF+nw1FMmgbJetKueGHJO6tXgPflGN
         wZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592663; x=1756197463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFsGbO5uv2uZgsEZblgTie/lOV7b8K80hkUH8T7DIVU=;
        b=GbckA80S61lQ0FmSJ/5ztmHpIFNvst27brsThRMb49dpxu9iCfsk75+TduGDkZiO7W
         J5BNoVoSz6CaoqFg+5Ur7MbIcIFKNR3wnzdlyBSV7BdS0suJpZthcehyu7QmtdMKv9O/
         q4bUe3h9SxlSiyQkFb3sdP4xjDQMQyrk+YEvlzwSNXVnOyY5FFamCSYrSHe6d7fHBvNZ
         +FBFg47TQOcKmfIHn5dUQEIYdlzLY5Ufa0T31ppY8ppv2Ac+97xsW4uOR3HVwjrmvMqD
         9G6MBh8pyZ0J3ZvJydtuumqGMkAOoVoisGAsgrJDApU2SAULiYDBe915thBfod6ll5Rz
         oujg==
X-Forwarded-Encrypted: i=1; AJvYcCUOsiP1464NzzQh3WzreCrFHFnIwQGXVInlAGJWViWbIzJol9/GSq/j2X0d6tf056fcYvxNeMEv/2yT@vger.kernel.org, AJvYcCUXOv5DdF2hpb5lmRczwUv7p3jgU//L/F1NV/iFJ4DOXJPu4sgGvH1eOSqBxQy04Khea4eLMdM1igYlDP9m4A==@vger.kernel.org, AJvYcCV1V4yajExvvO6y3YRNXCe6gi73ZdYXalQC+ovfmVHJpyHMTWSvio3pDQqBwwmFfwppB9uV6y919e8=@vger.kernel.org, AJvYcCV1uynxGQfVPGCeewu+nXUYe6x8Eg5L6Wzot/zf4foycowdbQEC7eaUjXHf9717ldvs+4n4gxDA/XkVCg==@vger.kernel.org, AJvYcCVnG2Vv3oiREGpxvl0SdKVVN1HuZEclV8HHApm/iX7eakfGsJQGFTULqbA52Mt7AozSPWYq/4b353Ft@vger.kernel.org, AJvYcCWOAKHOImEHcKf3Vrl66I4SfDsbrANijYoPN95Oh1TYJ3GSR164mAeX7H8+5X0wx5fwx8bgYgGyOjHfuZh+@vger.kernel.org, AJvYcCXEznR2b3GRPEiHg/61Z9vxqEyTo8L+8ZN63bRJwe90t6aZadX13KIlmfRcmx2zj6PjKLPqmkxDhtan/1jEGA==@vger.kernel.org, AJvYcCXsNJvpXGrtSi6lbopAh993v3NYlL8eI1sc+GzzoeUp3x1T+J6WXzuk6VQFv/onmMdfAzEbI5B5yJ/2@vger.kernel.org
X-Gm-Message-State: AOJu0YxruDJCD/jFhY51OgsbHuZP33F5unKwJfsEhMH+szfytiT5tMZ6
	9rhwkSxir8u+Zdvya9/EM0mRG9fNTtcdeuxcbfEv/Ql/ZodrmyXamr3JKOb/lli5JhyhE+t4eQJ
	xubISonmenC/LpaGSbqMNPwje4LMAA4A=
X-Gm-Gg: ASbGncvFAVpBL5pKgjzSv6iuPA5cXcHN+/N7ZTj6EkZD8iMLb5APF9OCikGtMQI2hYq
	pLgLv1Xu5BJGtCmRKTWUMKILZyPHumeCnMuQe3PiU27N9ipAprtnt5xaFN/1KshaCZ2d1jamWR0
	c4YtJ2RlYB2ItzQnxEYYa3hR1WsSYnW/Z6/6pVvL8lw+Wh0O7ZGLKF3vwXr6fPN5A9CeAcJZJhp
	dZn3/w=
X-Google-Smtp-Source: AGHT+IFPkGLsERbAFWtJMeBST+thbMymAyNwr9qtEZC9tmGauxnR7YuwZ/KcrAjTg48I0n7BxxoUhzcNK86fTEQQ3U8=
X-Received: by 2002:a05:6402:2110:b0:61a:8956:80da with SMTP id
 4fb4d7f45d1cf-61a89568752mr355544a12.17.1755592662958; Tue, 19 Aug 2025
 01:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjFPOZe004Cv+tT=NyQg2JOY6MOYQniSjaefVcg+3s-Kg@mail.gmail.com>
 <175555395905.2234665.9441673384189011517@noble.neil.brown.name>
In-Reply-To: <175555395905.2234665.9441673384189011517@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Aug 2025 10:37:30 +0200
X-Gm-Features: Ac12FXy8T19V7sCZ2PjPpODnDn2SH0EuiMx3-E257rrZ7RxWX_LLM7LKSQroU_c
Message-ID: <CAOQ4uxjh1RmAEWV22V_tdazOGxekmKUy6bdu13OhtoXboT3neg@mail.gmail.com>
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 11:53=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Mon, 18 Aug 2025, Amir Goldstein wrote:
> > On Wed, Aug 13, 2025 at 1:53=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > A few callers operate on a dentry which they already have - unlike th=
e
> > > normal case where a lookup proceeds an operation.
> > >
> > > For these callers dentry_lookup_continue() is provided where other
> > > callers would use dentry_lookup().  The call will fail if, after the
> > > lock was gained, the child is no longer a child of the given parent.
> > >
> > > There are a couple of callers that want to lock a dentry in whatever
> > > its current parent is.  For these a NULL parent can be passed, in whi=
ch
> > > case ->d_parent is used.  In this case the call cannot fail.
> > >
> > > The idea behind the name is that the actual lookup occurred some time
> > > ago, and now we are continuing with an operation on the dentry.
> > >
> > > When the operation completes done_dentry_lookup() must be called.  An
> > > extra reference is taken when the dentry_lookup_continue() call succe=
eds
> > > and will be dropped by done_dentry_lookup().
> > >
> > > This will be used in smb/server, ecryptfs, and overlayfs, each of whi=
ch
> > > have their own lock_parent() or parent_lock() or similar; and a few
> > > other places which lock the parent but don't check if the parent is
> > > still correct (often because rename isn't supported so parent cannot =
be
> > > incorrect).
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/namei.h |  2 ++
> > >  2 files changed, 41 insertions(+)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 7af9b464886a..df21b6fa5a0e 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct m=
nt_idmap *idmap,
> > >  }
> > >  EXPORT_SYMBOL(dentry_lookup_killable);
> > >
> > > +/**
> > > + * dentry_lookup_continue: lock a dentry if it is still in the given=
 parent, prior to dir ops
> > > + * @child: the dentry to lock
> > > + * @parent: the dentry of the assumed parent
> > > + *
> > > + * The child is locked - currently by taking i_rwsem on the parent -=
 to
> > > + * prepare for create/remove operations.  If the given parent is not
> > > + * %NULL and is no longer the parent of the dentry after the lock is
> > > + * gained, the lock is released and the call fails (returns
> > > + * ERR_PTR(-EINVAL).
> > > + *
> > > + * On success a reference to the child is taken and returned.  The l=
ock
> > > + * and reference must both be dropped by done_dentry_lookup() after =
the
> > > + * operation completes.
> > > + */
> > > +struct dentry *dentry_lookup_continue(struct dentry *child,
> > > +                                     struct dentry *parent)
> > > +{
> > > +       struct dentry *p =3D parent;
> > > +
> > > +again:
> > > +       if (!parent)
> > > +               p =3D dget_parent(child);
> > > +       inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
> > > +       if (child->d_parent !=3D p) {
> >
> > || d_unhashed(child))
> >
> > ;)
>
> As you say!
>
> >
> > and what about silly renames? are those also d_unhashed()?
>
> With NFS it is not unhashed (i.e.  it is still hashed, but with a
> different name).  I haven't checked AFS.
>
> But does it matter?  As long as it has the right parent and is not
> unhashed, it is a suitable dentry to pass to vfs_unlink() etc.
>
> If this race happened with NFS then ovl could try to remove the .nfsXXX
> file and would get ETXBUSY due to DCACH_NFSFS_RENAMED.  I don't think
> this is a problem.
>

Not a problem IMO.

FYI, ovl does not accept NFS as a valid upper fs
on account of ->d_revalidate() and no RENAME_WHITEOUT support.

        if (ovl_dentry_remote(ofs->workdir) &&
            (!d_type || !rename_whiteout || ofs->noxattr)) {
                pr_err("upper fs missing required features.\n");
                err =3D -EINVAL;
                goto out;
        }

> If we really wanted to be sure the name hadn't changed we could do a
> lookup and check that the same dentry is returned.
>
> OVL is by nature exposed to possible races if something else tried to
> modify the upper directory tree.  I don't think it needs to provide
> perfect semantics in that case, it only needs to fail-safe.  I think
> this recent change is enough to be safe in the face of concurrent
> unlinks.

<nod>

Thanks,
Amir.

