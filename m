Return-Path: <linux-fsdevel+bounces-14877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F4A880ECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 10:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159FE1C21CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABD3B79F;
	Wed, 20 Mar 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBVuOqtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB13B794
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927491; cv=none; b=ebAQUbmGH/Lq6k1MZa1nMgMhwWPiONkvaOyvlIH439OolopwLZa5d7sRLdlGtiqIIdev/oJcaj623ddwsKWueunkS9BhvEmAwmPKagvocui8y9VU/gzSA79UyPB/JgipWLvKhFAlJMGv7eEB6+sejjn7AY16Zrvda4c9eTEftWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927491; c=relaxed/simple;
	bh=+BsAM3hrqgVL4mme2ETrwORhjovMsFHib9BoYoepk/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2EGCyoTO6Qo52oaUrvy4JV2gwm5ol3SbuKBK10O7t3h/+1GdJWeqo9q5B2tuO5gRip65vt8XLP/BFb9Vs0RCoIBaRJTvK0UmbkWHEnhmoLx8ttXGRof4E40TvRvioEHHdUWVJmgWdrZ8h2NjcFAyE1U/TGFIROU3zbt8phngSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBVuOqtR; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d458be7fb6so1077544e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710927488; x=1711532288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HormbZjjAz7UYORPFiF8RyXIgTszaSzLY2qPJEN2AbA=;
        b=PBVuOqtRyHGFBAeJleC8WlUstYGDHFrokDcw3IgSgZKGRoJWkwzhm/YJlb1EnjhllR
         v8/VeM46ccfxw7sIwUnzUoMxbKpwpKv/QMO5IIhLyuWKdN4HT9UneFTCDZc69ca7sdXP
         xU/53jFA0CdtSVTYOsV79QiIA6pC7nZ/2bTRvPBjuZ4j5PLustRscJzB5VY+Pn/bP9Ds
         V/JruIYkgeAwbjljyDSh6ZyHJhBsAX4lZXWg6vpZO+cJVsMH0mPuwqPpX1QZfID0vOMG
         koTXX42+NHmsxXHa5KW3FXphUj1urn+tuYCZl36otM24QDQInIPSTdDueZkUNRMa2JbD
         2Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710927488; x=1711532288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HormbZjjAz7UYORPFiF8RyXIgTszaSzLY2qPJEN2AbA=;
        b=je1497P9juvPDT5CGcliHr03/C6yPLpPLcfVEU/yHsUw7iPLfasmSJdRNtORqLNwuI
         adM30XuDRl0ZsxQGM3rO7nufRCDJ47gmVipcCzgZa7eDi4U80K4imZcWZzPiJlxqzgZt
         CYh7hwekKirIKKMY4cx1l0Ditbf27YpmWhfSSBMpOlMl5UnR7bPX10jO6ZH5AU6EO/we
         1uFR67QDcnD2RLSR0DxR6wX2CPaE9PrtjxnZYB3+54urMUw7LmYQ8a4beysuasWJyFW/
         36wMW/sy27oR31ZtWgee5SRdaIFYNwhpW6K7aV2o7osF2w4JW79iaH31J0MaNtHSX4ng
         SGTA==
X-Forwarded-Encrypted: i=1; AJvYcCXBOoK4kcNbmhel5/u3IRZrJRTQgDwoqlcmAEHzZ8ibomxsgM0NsZTKzIYGQ1Ylh4VIQCy1G8/LVGsHGj1j1d2ISfofGdiRa8LEdiWSmQ==
X-Gm-Message-State: AOJu0YxbUOe2by1HPA6mYJUqr4LpOsL2huYwg7JQbYPvRDB/+D62t1MZ
	pcHmVhZbcrZh3aYYepq2ZKlKyDzdPE8YKcPt3pHPSQQTVfUYMcuDCaFXPh2HYqy+ke023KsWyso
	KC2NQpRJe7mTfS8/ZUqLpCl0I4jaBAUwr
X-Google-Smtp-Source: AGHT+IGVTyFWgdrAkK6WISE4g/NrnyPfTGp9hPh9mQWc8m4W4++BmSf98EWxqc5vjbzFejcUwvcICN7T3P6oRr1QySA=
X-Received: by 2002:a05:6122:2505:b0:4d4:14ca:f7d with SMTP id
 cl5-20020a056122250500b004d414ca0f7dmr1173304vkb.15.1710927488573; Wed, 20
 Mar 2024 02:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317184154.1200192-1-amir73il@gmail.com> <20240317184154.1200192-8-amir73il@gmail.com>
 <20240320-einblick-wimmeln-8fba6416c874@brauner>
In-Reply-To: <20240320-einblick-wimmeln-8fba6416c874@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Mar 2024 11:37:57 +0200
Message-ID: <CAOQ4uxgDp-ug4dVGv-wGNFZUX0E93LbR5AsnLBrZfJdrB5WWxg@mail.gmail.com>
Subject: Re: [PATCH 07/10] fsnotify: lazy attach fsnotify_sb_info state to sb
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:47=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sun, Mar 17, 2024 at 08:41:51PM +0200, Amir Goldstein wrote:
> > Define a container struct fsnotify_sb_info to hold per-sb state,
> > including the reference to sb marks connector.
> >
> > Allocate the fsnotify_sb_info state before attaching connector to any
> > object on the sb and free it only when killing sb.
> >
> > This state is going to be used for storing per priority watched objects
> > counters.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fsnotify.c             | 16 +++++++++++++---
> >  fs/notify/fsnotify.h             |  9 ++++++++-
> >  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++++-
> >  include/linux/fs.h               |  8 ++++----
> >  include/linux/fsnotify_backend.h | 17 +++++++++++++++++
> >  5 files changed, 73 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 503e7c75e777..fb3f36bc6ea9 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -89,11 +89,18 @@ static void fsnotify_unmount_inodes(struct super_bl=
ock *sb)
> >
> >  void fsnotify_sb_delete(struct super_block *sb)
> >  {
> > +     struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> > +
> > +     /* Were any marks ever added to any object on this sb? */
> > +     if (!sbinfo)
> > +             return;
> > +
> >       fsnotify_unmount_inodes(sb);
> >       fsnotify_clear_marks_by_sb(sb);
> >       /* Wait for outstanding object references from connectors */
> >       wait_var_event(fsnotify_sb_watched_objects(sb),
> >                      !atomic_long_read(fsnotify_sb_watched_objects(sb))=
);
> > +     kfree(sbinfo);
> >  }
> >
> >  /*
> > @@ -489,6 +496,7 @@ int fsnotify(__u32 mask, const void *data, int data=
_type, struct inode *dir,
> >  {
> >       const struct path *path =3D fsnotify_data_path(data, data_type);
> >       struct super_block *sb =3D fsnotify_data_sb(data, data_type);
> > +     struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> >       struct fsnotify_iter_info iter_info =3D {};
> >       struct mount *mnt =3D NULL;
> >       struct inode *inode2 =3D NULL;
> > @@ -525,7 +533,7 @@ int fsnotify(__u32 mask, const void *data, int data=
_type, struct inode *dir,
> >        * SRCU because we have no references to any objects and do not
> >        * need SRCU to keep them "alive".
> >        */
> > -     if (!sb->s_fsnotify_marks &&
> > +     if ((!sbinfo || !sbinfo->sb_marks) &&
> >           (!mnt || !mnt->mnt_fsnotify_marks) &&
> >           (!inode || !inode->i_fsnotify_marks) &&
> >           (!inode2 || !inode2->i_fsnotify_marks))
> > @@ -552,8 +560,10 @@ int fsnotify(__u32 mask, const void *data, int dat=
a_type, struct inode *dir,
> >
> >       iter_info.srcu_idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> >
> > -     iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =3D
> > -             fsnotify_first_mark(&sb->s_fsnotify_marks);
> > +     if (sbinfo) {
> > +             iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =3D
> > +                     fsnotify_first_mark(&sbinfo->sb_marks);
> > +     }
> >       if (mnt) {
> >               iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =3D
> >                       fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
> > diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> > index 8b73ad45cc71..378f9ec6d64b 100644
> > --- a/fs/notify/fsnotify.h
> > +++ b/fs/notify/fsnotify.h
> > @@ -53,6 +53,13 @@ static inline struct super_block *fsnotify_connector=
_sb(
> >       return fsnotify_object_sb(conn->obj, conn->type);
> >  }
> >
> > +static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *=
sb)
> > +{
> > +     struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> > +
> > +     return sbinfo ? &sbinfo->sb_marks : NULL;
> > +}
> > +
> >  /* destroy all events sitting in this groups notification queue */
> >  extern void fsnotify_flush_notify(struct fsnotify_group *group);
> >
> > @@ -78,7 +85,7 @@ static inline void fsnotify_clear_marks_by_mount(stru=
ct vfsmount *mnt)
> >  /* run the list of all marks associated with sb and destroy them */
> >  static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
> >  {
> > -     fsnotify_destroy_marks(&sb->s_fsnotify_marks);
> > +     fsnotify_destroy_marks(fsnotify_sb_marks(sb));
> >  }
> >
> >  /*
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index 0b703f9e6344..db053e0e218d 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -105,7 +105,7 @@ static fsnotify_connp_t *fsnotify_object_connp(void=
 *obj, int obj_type)
> >       case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
> >               return &real_mount(obj)->mnt_fsnotify_marks;
> >       case FSNOTIFY_OBJ_TYPE_SB:
> > -             return &((struct super_block *)obj)->s_fsnotify_marks;
> > +             return fsnotify_sb_marks(obj);
> >       default:
> >               return NULL;
> >       }
> > @@ -568,6 +568,26 @@ int fsnotify_compare_groups(struct fsnotify_group =
*a, struct fsnotify_group *b)
> >       return -1;
> >  }
> >
> > +static int fsnotify_attach_info_to_sb(struct super_block *sb)
> > +{
> > +     struct fsnotify_sb_info *sbinfo;
> > +
> > +     /* sb info is freed on fsnotify_sb_delete() */
> > +     sbinfo =3D kzalloc(sizeof(*sbinfo), GFP_KERNEL);
> > +     if (!sbinfo)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * cmpxchg() provides the barrier so that callers of fsnotify_sb_=
info()
> > +      * will observe an initialized structure
> > +      */
> > +     if (cmpxchg(&sb->s_fsnotify_info, NULL, sbinfo)) {
> > +             /* Someone else created sbinfo for us */
> > +             kfree(sbinfo);
> > +     }
>
> Alternatively, you could consider using wait_var_event() to let
> concurrent attachers wait for s_fsnotify_info to be initialized using a
> sentinel value to indicate that the caller should wait. But not sure if
> it's worth it.

Not worth it IMO. Adding watches is an extremely rare event
in the grand picture.

Thanks,
Amir.

