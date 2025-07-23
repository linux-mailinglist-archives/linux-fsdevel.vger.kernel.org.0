Return-Path: <linux-fsdevel+bounces-55874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7548B0F6D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A3166CA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4EA2F235D;
	Wed, 23 Jul 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQOZQ2nT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3172D3ED7;
	Wed, 23 Jul 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283873; cv=none; b=GClUHzXIdvkqN0iBo9jse/OBOQT9OcVOUS7+d39YgB9a4s3bbwJmC5hoTb9VVur0KNsCwR+ed/bFrSerDlqnVSMdYPOga0j6qJMWp3rHgREDBb89joH6sT1rUxgBam2S7+j3rpiQ28tapvl1C2E5WxLkRTIbrHLwHLkhH4iZKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283873; c=relaxed/simple;
	bh=Ixaes8FKV4Rb+WXX5KZ0CpGfJhEIBAjnN1vLyFDrEn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIUA7h/B3HlrsOSw1kNNJp3uj2omEX1TXpZiVQtjG/dsighm4DnLpQ03lBV+9Me6GvGvPdSRhcFq/f7xvxFdkCH/2mwqaN3W9DlcXi1nja7nzlLdoyr4q3NPm2kQ5XuTDMfoSHh5hyLvrJeLErmorq0UsWvFtabpyPpv7/qhSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQOZQ2nT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so27528a12.0;
        Wed, 23 Jul 2025 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753283870; x=1753888670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gPKC7JZf+MdzG97YXA76lpuoAs5GUPeZCgbd0Y90Ds=;
        b=fQOZQ2nTyHh+59g7f4y9++35ZUYmG27FV/0jGoDYIo2uG9kloCRFXkY+L5RIJQNM0I
         RcpzqHAerhMD41YR66CDkUkIMFs00Pbs10wLpjCOhT8+U0mE/ROo0YXkk+TU5PY/HY3a
         GB21qJxe6pCfB92lDNbZfdEYldApQGZW0ezNgKIqxvPLIHUuoHYW/knt3dy7HEv70zOp
         ziPKM1LEszK+C3ndcew5tGCe0u1Q+9LcN5JXumLLpVHNK0vPndWBtLKOIe8ijuZqrKj1
         mswGSJjq882nodnKoASWClopiF9zj/s8WfQf/NnF4NgzHG+O1a/7myIum5hYcmuRU7uc
         1uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753283870; x=1753888670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gPKC7JZf+MdzG97YXA76lpuoAs5GUPeZCgbd0Y90Ds=;
        b=DhL42b/QbK46jBvdNJRVBhi48BEF6vFvw8NF8tRakJXszRV8/ksZ9h9QZIWqjIzT9c
         BAW9j2VQn4977Olurg8yh0ePNCs7PtLjMmy5B6Lcwom5dAucniAvxvsYQfQdDkBcF9Db
         AnfmYWWTl1Ngnjanzz7SQ69Kge3YWhpKrB/94913DkJcMjf0id0n/rjw2yxGieEqqfaI
         b59h4VsIjlcZlc8cQf0TcZGBFN+M8+HZGJko81mhsHItkM0qRvuWnlWqVmJNiZqndUGW
         TqsmrDxT+kGNHGGJl4Ufpujv5qaVhOMiHu8rBSEkXXnyFlJKCGWLXVfHOSXCa72FHKYr
         NUWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrWTJtPbjKHGRhTCqvDnU9hidBlMapnro3BKoLwfcfSAFQo420D2RGXEfRSJqQM4l3eY6T0Df5W7WqeX5X@vger.kernel.org, AJvYcCW4iW0ctXdPX4Oo6d/5ucj0QnnmtW//SkvtHYSUNmzRzYxl7+Djhdcam34pTYeLv3zbThRhZwF5/M6G4y3J@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+hsa6+ZATSLKpDhMqUrMMEyI2bVqAxk+VYBEoDpxPZMdZd/c6
	r4DWR2GWWAWOZnERKTH/S0xVHYK5gvqH2gARgMCtGf5N0o/iJr2b+a0D6qXtWOYKeBti6exU2XB
	M9Qx7I+wzZ3Q5v/AdJsu+uQvwvtORPRoYlEgc8OA=
X-Gm-Gg: ASbGncue4+bPY3RPEGByYPZS5xVJsAinSI/6NlAybmnqSjBS5+kpi9z8+FpTCUrnTUG
	8AYJg7ijePh4ZoXxmxcDH3QETqsqzQ8sF/tmA2Dpo80ekSrAzFc+DLsB/0hp8pdjFf42SsDbWBI
	IyHlcJUrjjJU/HOPR7gZJdJD2whYip361RO95tpMlreb4tWANCMWOSRVMwhD3HNPVGUdiv5I7rC
	icdVfc=
X-Google-Smtp-Source: AGHT+IHOlqkZKaaBfFN+2m4ePisAovYUcCHcpp1efqr2h92vwShNm/G5BmKyTtBmqqQEw9BGg+Gs+ZYYXun3f8pbDHc=
X-Received: by 2002:a17:906:4fd0:b0:ade:44f8:569 with SMTP id
 a640c23a62f3a-af2f8d4b875mr340169466b.42.1753283869817; Wed, 23 Jul 2025
 08:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhiDNWjZXGhE31ZBPC_gUStETh4gyE8WxCRgiefiTCjCg@mail.gmail.com>
 <175314044347.2234665.1726134532379221703@noble.neil.brown.name>
In-Reply-To: <175314044347.2234665.1726134532379221703@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 23 Jul 2025 17:17:38 +0200
X-Gm-Features: Ac12FXzcdxg4Rg15dnqNsvXihbN2fYM-x7KJS-B_clDqrFniTtc5T1PxHEBZuN0
Message-ID: <CAOQ4uxgS_wnHQFBmNcVgcCvfxWeEi3Oi_3kEFtSmxNzvZAjUMQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] VFS: introduce dentry_lookup() and friends
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:27=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Mon, 21 Jul 2025, Amir Goldstein wrote:
> > On Mon, Jul 21, 2025 at 10:55=E2=80=AFAM NeilBrown <neil@brown.name> wr=
ote:
> > >
> > > dentry_lookup() combines locking the directory and performing a looku=
p
> > > prior to a change to the directory.
> > > Abstracting this prepares for changing the locking requirements.
> > >
> > > dentry_lookup_noperm() does the same without needing a mnt_idmap and
> > > without checking permissions.  This is useful for internal filesystem
> > > management (e.g.  creating virtual files in response to events) and i=
n
> > > other cases similar to lookup_noperm().
> > >
> > > dentry_lookup_hashed() also does no permissions checking and assumes
> > > that the hash of the name has already been stored in the qstr.
> >
> > That's a very confusing choice of name because _hashed() (to me) sounds
> > like the opposite of d_unhashed() which is not at all the case.
>
> True.  But maybe the confusion what already there.
> You can "d_add()" a dentry and later "d_drop()" the dentry and if the
> dentry isn't between those two operations, then it is "d_unhashed()"
> which leaks out the implementation detail (hash table) for dentry
> lookup. Maybe d_unhashed() should be d_added() with inverted meaning?
>
> There is only one user of this interface outside of namei.c so I could
> unexported to keep the confusion local.  That would mean
> ksmbd_vfs_path_lookup() would hav to use dentry_lookup_noperm() which
> would recalculate the hash which vfs_path_parent_lookup() already
> calculated (and we cannot simply tell it not to bother calculating).
> Actually it already uses lookup_noperm_unlocked() in the
> don't-need-a-lock-branch which recalculates the hash.....
>
> Would making that name static ease your concern?
>
> >
> > > This is useful following filename_parentat().
> > >
> > > These are intended to be paired with done_dentry_lookup() which provi=
des
> > > the inverse of putting the dentry and unlocking.
> > >
> > > Like lookup_one_qstr_excl(), dentry_lookup() returns -ENOENT if
> > > LOOKUP_CREATE was NOT given and the name cannot be found,, and return=
s
> > > -EEXIST if LOOKUP_EXCL WAS given and the name CAN be found.
> > >
> > > These functions replace all uses of lookup_one_qstr_excl() in namei.c
> > > except for those used for rename.
> > >
> > > Some of the variants should possibly be inlines in a header.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c            | 158 ++++++++++++++++++++++++++++++----------=
--
> > >  include/linux/namei.h |   8 ++-
> > >  2 files changed, 119 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 950a0d0d54da..f292df61565a 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -1714,17 +1714,98 @@ struct dentry *lookup_one_qstr_excl(const str=
uct qstr *name,
> > >  }
> > >  EXPORT_SYMBOL(lookup_one_qstr_excl);
> > >
> > > +/**
> > > + * dentry_lookup_hashed - lookup and lock a name prior to dir ops
> > > + * @last: the name in the given directory
> > > + * @base: the directory in which the name is to be found
> > > + * @lookup_flags: %LOOKUP_xxx flags
> > > + *
> > > + * The name is looked up and necessary locks are taken so that
> > > + * the name can be created or removed.
> > > + * The "necessary locks" are currently the inode node lock on @base.
> > > + * The name @last is expected to already have the hash calculated.
> > > + * No permission checks are performed.
> > > + * Returns: the dentry, suitably locked, or an ERR_PTR().
> > > + */
> > > +struct dentry *dentry_lookup_hashed(struct qstr *last,
> > > +                                   struct dentry *base,
> > > +                                   unsigned int lookup_flags)
> > > +{
> > > +       struct dentry *dentry;
> > > +
> > > +       inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
> > > +
> > > +       dentry =3D lookup_one_qstr_excl(last, base, lookup_flags);
> > > +       if (IS_ERR(dentry))
> > > +               inode_unlock(base->d_inode);
> > > +       return dentry;
> > > +}
> > > +EXPORT_SYMBOL(dentry_lookup_hashed);
> >
> > Observation:
> >
> > This part could be factored out of
> > __kern_path_locked()/kern_path_locked_negative()
>
> This patch does exactly that....
>
> >
> > If you do that in patch 2 while introducing done_dentry_lookup() then
> > it also makes
> > a lot of sense to balance the introduced done_dentry_lookup() with the
> > factored out
> > helper __dentry_lookup_locked() or whatever its name is.
>
> I don't think I want a __dentry_lookup_locked().  The lock and the
> lookup need to be tightly connected.
> But maybe I cold introduce dentry_lookup_hashed() in patch 2 ...
> Or maybe call it __dentry_lookup() ??

__dentry_lookup() sounds good to me.

Thanks,
Amir.

