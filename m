Return-Path: <linux-fsdevel+bounces-8760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAAF83AB69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B5FB28088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B50B7A70F;
	Wed, 24 Jan 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVdhfrOF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2D7A702;
	Wed, 24 Jan 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105464; cv=none; b=QTE2BBfKAi6CDTU4DdI8NKxRhZzym4PyI5G2Z7QL6EF1GM7jnKhThOt3eNmP70tky3OxTZPwUpzY2I0ELL7+xpM+l4Kv80bnE11Uu01387lesI+C/SIxJ74O29PL2tq3TRCAXRakvtJz/zKxtZjNMj4kcefzomLFlWQDVrbh9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105464; c=relaxed/simple;
	bh=9L8i8MRxTRUovMnf6B3+TaY9uldZPEBNGPy4Z42mzbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOLzB4TvRqwis0H5thPM0hsiCr7OK4yv7tIxSQJORcEwz3ES4WzwEUSMdRnEfR7lLvudM4KPyyrAKle3n13zl8Kd4cFeQWetZX/eOtjIevMHOyxrG4G8NaOWUl6/3SsPwUV7VcLY+h5bT4MPIAfHYFb3K2ZgKUTn41H4Sg4a4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVdhfrOF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21481a3de56so1077094fac.2;
        Wed, 24 Jan 2024 06:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105462; x=1706710262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xnTLTL2SSu5RMv39utUojmUyQtnjJr+CK/qkZj7DKg=;
        b=FVdhfrOFBatCCeZQTPJ8mSWNAf2fnyYlwVy2Ul1Im5TjONatvNd3nVsHLKbGgpwpBt
         hzey21lSer2m48/n1/YfF4gM0UXpwpogSStTsqLoKaGmRph7uPa+gSWkz+aaNTZXdx9v
         jaPMybe1kl0muO/0sz60XIpJLeevM5OiDeI8Whk+QADmXFxEWa01SH3bQkJGcx6FUMhb
         eY++ePAU82RTV89K/hhQHM857Jgr3QQqhwg8PNcpNdLGvSMetCeuzW6R75XIw2Na22QG
         Lat+H3l2/hQpxq1KIb5yodzU2qjq7O14QsJwQxW7ciTgDYWjQpX0wQCgnLpYOBIhOSnT
         YHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105462; x=1706710262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xnTLTL2SSu5RMv39utUojmUyQtnjJr+CK/qkZj7DKg=;
        b=AR6aVWzz1p0mFu/tH4RHcIDhYhZfMm+jInoAk0z0tqqeUqWIEz8AS/KMy+7x32ZOzx
         ocJ/pkzVBJQTGIc7tzWz82jfi7iK8xGZ+il7AoPAilxJnt/NdFtXdLsdeJwoheZ7NQBs
         zQazgUfNlSW6hp/rr6Ql48lO6tyNcLFfZFjdC4poHWaO0YGjf3PZeaqIaore9uK0MMaG
         /GNQP84WvKbl69wnmbqaboNdQ+LWqVcULcEjJdwh87x5qNSzrlErtGjsLB5AEkwOz40l
         84qQchkUHqnCxb3qvvYltLU7+/ECJLW7foQJ37HS8Wtxb1JDol1a2guzkzH+Toysuhv9
         4Cfg==
X-Gm-Message-State: AOJu0Yxnn33uQVVUeT1hvmf9cjpq7qyXDAuYFwiYdvLZJLwsY4aZB5Mr
	R+Jcfarq6x8JUlfYWBiYGDUM5R08lQ0Pq72rmmWDRwLtFR2mE86UgQmOeTdUjEIoY0uWPAyveRt
	iNQXWJh9B4ssFrk8CBeGbZldRRW8hhpRj8u3OQg==
X-Google-Smtp-Source: AGHT+IG9TfD3j0DFTfi1uYZGWP5PaLsWSpYqgym4p+3+gRdC4L7CR6qMM9jCbxA/d6Y6YRCwVXNlWQo0VQ1qeLtd9Vs=
X-Received: by 2002:a05:6870:718f:b0:214:9c65:b969 with SMTP id
 d15-20020a056870718f00b002149c65b969mr1784734oah.6.1706105462338; Wed, 24 Jan
 2024 06:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124113042.44300-1-jefflexu@linux.alibaba.com> <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com>
In-Reply-To: <CAJfpegtkSgRO-24bdnA4xUMFW5vFwSDQ7WkcowNR69zmbRwKqQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jan 2024 16:10:50 +0200
Message-ID: <CAOQ4uxjN6f=M8jjM0-_eysLy8Jx1+r0Dy3MhWHc8f2r7RnEmdQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add support for explicit export disabling
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:17=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 24 Jan 2024 at 12:30, Jingbo Xu <jefflexu@linux.alibaba.com> wrot=
e:
> >
> > open_by_handle_at(2) can fail with -ESTALE with a valid handle returned
> > by a previous name_to_handle_at(2) for evicted fuse inodes, which is
> > especially common when entry_valid_timeout is 0, e.g. when the fuse
> > daemon is in "cache=3Dnone" mode.
> >
> > The time sequence is like:
> >
> >         name_to_handle_at(2)    # succeed
> >         evict fuse inode
> >         open_by_handle_at(2)    # fail
> >
> > The root cause is that, with 0 entry_valid_timeout, the dput() called i=
n
> > name_to_handle_at(2) will trigger iput -> evict(), which will send
> > FUSE_FORGET to the daemon.  The following open_by_handle_at(2) will sen=
d
> > a new FUSE_LOOKUP request upon inode cache miss since the previous inod=
e
> > eviction.  Then the fuse daemon may fail the FUSE_LOOKUP request with
> > -ENOENT as the cached metadata of the requested inode has already been
> > cleaned up during the previous FUSE_FORGET.  The returned -ENOENT is
> > treated as -ESTALE when open_by_handle_at(2) returns.
> >
> > This confuses the application somehow, as open_by_handle_at(2) fails
> > when the previous name_to_handle_at(2) succeeds.  The returned errno is
> > also confusing as the requested file is not deleted and already there.
> > It is reasonable to fail name_to_handle_at(2) early in this case, after
> > which the application can fallback to open(2) to access files.
> >
> > Since this issue typically appears when entry_valid_timeout is 0 which
> > is configured by the fuse daemon, the fuse daemon is the right person t=
o
> > explicitly disable the export when required.
> >
> > Also considering FUSE_EXPORT_SUPPORT actually indicates the support for
> > lookups of "." and "..", and there are existing fuse daemons supporting
> > export without FUSE_EXPORT_SUPPORT set, for compatibility, we add a new
> > INIT flag for such purpose.
>
> This looks good overall.
>
> >
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > ---
> > RFC: https://lore.kernel.org/all/20240123093701.94166-1-jefflexu@linux.=
alibaba.com/
> > ---
> >  fs/fuse/inode.c           | 11 ++++++++++-
> >  include/uapi/linux/fuse.h |  2 ++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 2a6d44f91729..851940c0e930 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1110,6 +1110,11 @@ static struct dentry *fuse_get_parent(struct den=
try *child)
> >         return parent;
> >  }
> >
> > +/* only for fid encoding; no support for file handle */
> > +static const struct export_operations fuse_fid_operations =3D {
>
> Nit: I'd call this fuse_no_export_operations (or something else that
> emphasizes the fact that this is only for encoding and not for full
> export support).

Not that I really care what the name is, but overlayfs already has
ovl_export_fid_operations and the name aspires from AT_HANDLE_FID,
which is already documented in man pages.

How about fuse_export_fid_operations?

Thanks,
Amir.

