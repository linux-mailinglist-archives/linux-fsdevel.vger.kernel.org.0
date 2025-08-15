Return-Path: <linux-fsdevel+bounces-58045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E63B28575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 20:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8320EAA8A50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A226304BD7;
	Fri, 15 Aug 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS6inqFM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE6302770
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280882; cv=none; b=Tx8hecYjAYR8sbxQIEgM9kgfxp+f8R8j+fdHAvgNdpdxfyFEY7XfTGE3gwEP8qtzSubxgFZzbqMcB7PmUHAxXfuxPQS2XtpPE/0qmuxWcsD7PY4q+YEhkfeI3WKKvTEX+t7Wt1j8W03psBkwCLyxxXZau7ei6bdPcJC/YjQc3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280882; c=relaxed/simple;
	bh=jU0VG/C9WbDZaoJ2m4pcEuv6CfAI+oDvZSyB3XC+yGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuLWSSWW1txeznRLmJ9KwuQBAIih1HXXfWcBMoy4aelE5IiiTBW5SBH/RphkmnQK5dA3vtQyD9PqMfjuatWpuO7iGUKIUv6s62k0yANgj1KyqG1yB6GfvPozPfri7XGNfVbAJdBftgpZtthTUMjA8d77154ltQtI6J1SuuT16zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS6inqFM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109a95dddso31899111cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755280879; x=1755885679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eicv0MlgVfV4tNn8wjOXqDAerFFe0sF36+d2mA/eqIg=;
        b=TS6inqFMsCVd76lS0TV5+SpabDFfYiAd+oAToEZjndF2+D4L0Pw4Ol7PK3LHyFtomk
         e3mnNhQcp4ABPNOKRUrKT1scPXgbGzx72oHLbqwavtr86lfe7cOTr/6IC/H8X30UXXBb
         4oP2E91VHE/hsjcrEhMt2z7n35DzYpOc6Jll5BEjTZ2bqwkVYuvjMFxSVSrpV9XK6ZVd
         dEU+Apy7/iMzpiep4sQ1Eh3g9KOT0U2VEYPi0Q6qBfi6s5OScm4qsDdBgkevi7KJb0z+
         oZjT9yx5HQw3fkQXsnZBMuBYBKQXGXpqMzpuqfXeGlo++T2oMg5bkMO4Jk2MDHiHjrI+
         5voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755280879; x=1755885679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eicv0MlgVfV4tNn8wjOXqDAerFFe0sF36+d2mA/eqIg=;
        b=KgBBmiTd/wNsxBf8n92GA/tbxo5SsLEWykTgPLV5vyAvDqOSyHcRYcX3pJHURJKExj
         zDMacRmJD6FlcQgZ3EZNGOp30TIMInk3qeXO1j30AyKWGvVvVoGgsRzHZUerjnpm+9gD
         uWFMt3QZni2srNDl9igtFz1C9u/tcTxWWTAcXZgV+8UQU5e2b46s/fDdSngFV9x11l7f
         qRMqw4Tl4NQ7dlNsMxasz7eUkUF8w+gIU4lU3D9qXOA7+Ly/wpLIbzVjdx0xQIBEvDXm
         AjnCeeT6A17K/ooT4hwloMszjB6j2+vwLPXi3RpTxqKSlgZC80UDyTOGJMAzCrPl7X9E
         rdYw==
X-Forwarded-Encrypted: i=1; AJvYcCVDw0kZWWqVKacUdyWQUnpmJvdMGSd8Jqb2DCvvOUhf7htFXg7nViXE8Rrzx0N1suhp+8uQZ/sC2YYuSZce@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOIXf36n4mtyv4uSH3Qu8rlH8Ujxm1Kad8Ebd9wSuiiTVKsMS
	Z0XmU1nPLQTxn5StTLrcL+Pg8F/k2eMVDW2Uebz00V0f65aDmufDlSqLDLMKF8SmWTLb5lS+h+s
	isq9bwvJW3lUlWCKOn8WY77RGBiOPVE8OM9ga
X-Gm-Gg: ASbGncu8jXTjCT4uvsuu+uQIkhGbavvBTqKKQcOAVcss8aFsdHu3k+FgVtJ5OjAYl+0
	esARRkmWnsu1vjSR9eloY7pKrkn2qO2bsgnA44ac063dz2zAGsDqBzOJdFc8Bfl7lEcL/NBFZC2
	IaiMxcZdWznPCKjHbTs112TTsNeiyreqF1GQchK3by5n+cbC1a9kxBnmnZh2RZIbrdMIKJjz760
	tenzw+ihCjYeSiEKI0=
X-Google-Smtp-Source: AGHT+IEoOKNKueCEinrk7C+j867xNbmE42EmIzzMgi/4RBzH9T+qIZYJfsISVlNn+nX4lDMYtbqKPOOrreobRgb+TVQ=
X-Received: by 2002:a05:622a:1189:b0:4af:157e:3823 with SMTP id
 d75a77b69052e-4b11e2cffccmr41539821cf.42.1755280877670; Fri, 15 Aug 2025
 11:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813223521.734817-1-joannelkoong@gmail.com>
 <20250813223521.734817-3-joannelkoong@gmail.com> <20250814182506.GY7942@frogsfrogsfrogs>
In-Reply-To: <20250814182506.GY7942@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 Aug 2025 11:01:06 -0700
X-Gm-Features: Ac12FXxtHQ7zQEkazfEYhRIDGEvTJpqRsFA4G1k-_tGE4apsgwf9M7geiuFXWFo
Message-ID: <CAJnrk1ayHG=yg+ZXYNsohi0AcPjXQ=iwLKgthg3Wx7zLOfW4RQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: fix fuseblk i_blkbits for iomap partial writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:25=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Aug 13, 2025 at 03:35:21PM -0700, Joanne Koong wrote:
> > On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT which means
> > any iomap partial writes will mark the entire folio as uptodate. Howeve=
r
> > fuseblk filesystems work differently and allow the blocksize to be less
> > than the page size. As such, this may lead to data corruption if fusebl=
k
> > sets its blocksize to less than the page size, uses the writeback cache=
,
> > and does a partial write, then a read and the read happens before the
> > write has undergone writeback, since the folio will not be marked
> > uptodate from the partial write so the read will read in the entire
> > folio from disk, which will overwrite the partial write.
> >
> > The long-term solution for this, which will also be needed for fuse to
> > enable large folios with the writeback cache on, is to have fuse also
> > use iomap for folio reads, but until that is done, the cleanest
> > workaround is to use the page size for fuseblk's internal kernel inode
> > blksize/blkbits values while maintaining current behavior for stat().
> >
> > This was verified using ntfs-3g:
> > $ sudo mkfs.ntfs -f -c 512 /dev/vdd1
> > $ sudo ntfs-3g /dev/vdd1 ~/fuseblk
> > $ stat ~/fuseblk/hi.txt
> > IO Block: 512
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")
> > ---
> >  fs/fuse/dir.c    |  2 +-
> >  fs/fuse/fuse_i.h |  8 ++++++++
> >  fs/fuse/inode.c  | 13 ++++++++++++-
> >  3 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index db44d05c8d02..a6aa16422c30 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -975,6 +975,14 @@ struct fuse_conn {
> >               /* Request timeout (in jiffies). 0 =3D no timeout */
> >               unsigned int req_timeout;
> >       } timeout;
> > +
> > +     /*
> > +      * This is a workaround until fuse uses iomap for reads.
> > +      * For fuseblk servers, this represents the blocksize passed in a=
t
> > +      * mount time and for regular fuse servers, this is equivalent to
> > +      * inode->i_blkbits.
> > +      */
> > +     unsigned char blkbits;
>
> uint8_t, since the value is an integer quantity, not a character.

Ohh interesting, I copied this directly from the sb->s_blocksize_bits
type, which in the super_block struct gets defined as an unsigned
char. Your point makes sense to me though, I'll make this change and
send out v3!
>
> >  };
> >
> >  /*
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 3bfd83469d9f..7ddfd2b3cc9c 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -292,7 +292,7 @@ void fuse_change_attributes_common(struct inode *in=
ode, struct fuse_attr *attr,
> >       if (attr->blksize)
> >               fi->cached_i_blkbits =3D ilog2(attr->blksize);
> >       else
> > -             fi->cached_i_blkbits =3D inode->i_sb->s_blocksize_bits;
> > +             fi->cached_i_blkbits =3D fc->blkbits;
> >
> >       /*
> >        * Don't set the sticky bit in i_mode, unless we want the VFS
> > @@ -1810,10 +1810,21 @@ int fuse_fill_super_common(struct super_block *=
sb, struct fuse_fs_context *ctx)
> >               err =3D -EINVAL;
> >               if (!sb_set_blocksize(sb, ctx->blksize))
> >                       goto err;
> > +             /*
> > +              * This is a workaround until fuse hooks into iomap for r=
eads.
> > +              * Use PAGE_SIZE for the blocksize else if the writeback =
cache
> > +              * is enabled, buffered writes go through iomap and a rea=
d may
> > +              * overwrite partially written data if blocksize < PAGE_S=
IZE
> > +              */
> > +             fc->blkbits =3D sb->s_blocksize_bits;
> > +             if (ctx->blksize !=3D PAGE_SIZE &&
> > +                 !sb_set_blocksize(sb, PAGE_SIZE))
> > +                     goto err;
> >  #endif
> >       } else {
> >               sb->s_blocksize =3D PAGE_SIZE;
> >               sb->s_blocksize_bits =3D PAGE_SHIFT;
> > +             fc->blkbits =3D sb->s_blocksize_bits;
> >       }
>
> Heh. :)
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>

Thanks for reviewing this patchset!

> (How long until readahead? ;))

Haha I have readahead in the same patchset as read, planning to send
that out in 2 weeks after I'm back from PTO :D

>
> --D
>
> >       sb->s_subtype =3D ctx->subtype;
> > --
> > 2.47.3
> >
> >

