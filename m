Return-Path: <linux-fsdevel+bounces-54245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE5AFCC45
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51095423685
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384922F75B;
	Tue,  8 Jul 2025 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOD4uVAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90E17B402
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981553; cv=none; b=gar77vc6WoHPvu09ix4Uk1O6MudRQ1oQkVSctvixg7tPOTl3m40x9L/VFmnCLPLU6sUAg+G1LzFF6iZdJo3grbVDBVCE/qGcDEIUPKFtVpgs02rEPYPbdaPgZI3RmHS6Kl8l6yuJ8yzKvEYh6i7GEvxU6R+n/iWn4O1jGUj53R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981553; c=relaxed/simple;
	bh=/YL32fXbRHcrdPAWgm8KYyV062UOl83hVC7EN6BjkbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkGG96EuMhQ8SGt1fMngN6voOXENsYLfoEW2nCGwzTivDurGVjfYeB388n0nZx5re1qYDmsulrAV8rlV/2v7H3Is+CNzn6iIRLXorvOn5CWWnV+r1IshNtiqi2Hlj6mQ3w/QhQmOE8JBWYwEEX+8g+gTbEEbYPCeccfBJAiNzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOD4uVAz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso6953560a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751981549; x=1752586349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMT1MiUa0TP0jRcSiOza3V4ZFFSoORg7Titx1fk2HKA=;
        b=EOD4uVAzMsHZaln7VrScOv7M4PrZ8ifn4xBPoOfC7b9vTeFiop+8WLyFVpv2OuMoX/
         a/2V5M1WRzL0K5yUXusXjKYNFoUbthI+uPaIr7JKK23SZVXnASwTk5uCZeHRfUaDISHp
         mETznB3CMw2xkJBUpF6RjwaHIi93vl+8uhWhHJg87c023v3f2ooR5AJFG3xr0cFW1SFn
         oXNJXNValpy4P/Ju8XCvncO82Yv2vtOAAijkpaousquyVC2OWULMCxKMCAG2uyIMAvf6
         qGaf1t4yDyjYq18wSTj3HO46j+WxK86xaE/26RUyVkMce3X5edLNokPmzJMgfmmD328W
         1BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751981549; x=1752586349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMT1MiUa0TP0jRcSiOza3V4ZFFSoORg7Titx1fk2HKA=;
        b=jm+M9lkRuZzKpJhEbcT3Qa5fg+rRhJxhm7KSr/7djwz/2GxjAz9NfLXvtYbPliztTI
         LvTwgSatlmGyEblPMy+6gMmN3WKLiQBotTTdteYAa3yttxNHqSPZCuZT5Qbemy86+PQ5
         PsoK7x+UyjaPiugO4mablAWoOJKtNuKQ84FW+hGySi5Xbe/pTgEAfI1oeYJ7ql8ceLAt
         4+6Imzwo6/Wek52VmSIvbXyiewU3BO2I/n+m2cLW/ZmZ1Cub0VYQSB6KNawefJF44dxw
         cQPXxEUpym8THUDBvER8ne0gvfBeOSOxf6rk0hFcEpgGr0M+rY1jEtiZZ0lNBO+n6xSn
         pyMg==
X-Forwarded-Encrypted: i=1; AJvYcCUC4gHXj6VHoTVW0EjohIxKn+4ITLwQgyqJC8873hN+Hib4hHHh7rF5ihOROQBR4yHRZl7xJVuL2osu/iSw@vger.kernel.org
X-Gm-Message-State: AOJu0YxjaCmcQHdIoW6dK8EUsCQojf1T3YNsFXGKdStxVqiD7yTkPMAy
	j4uwdErE4roKNu/IzxNuETnZmsG8OoxZogVMuxLOUy03i6ssIcOt77qrRfwcwO/QrzxKs2Nwycx
	9yIVWrohhutx8Gh6YChsDOErGBLZ6Qws=
X-Gm-Gg: ASbGncsawc1K9oLWtg33V9D9Oz//Bnie+3R2q+N/YaV9HOI0vxaix6clvtmveIVkpAi
	FltmSDBRM6mI+9qW/lhV+CGR3U0SjlUO9BM/NMr9fZ2+c9cClLXlJWjemXiAWNfJZHpZSUQNOlO
	tRcTEZ3/p9AM9931VjLQjxAmj9Zt8wCpPaY+uKs0MFhEs=
X-Google-Smtp-Source: AGHT+IHhiVq8/yOFeK9AbuOjZLq72hCqNydJff8cn/+Ds56MBC9w2Oi23rG3Lnsr50FdVuNICF8rvcl4XDIEGHei4aU=
X-Received: by 2002:a17:907:6d26:b0:ae3:6cc8:e426 with SMTP id
 a640c23a62f3a-ae3fbc336f7mr1592394566b.9.1751981548835; Tue, 08 Jul 2025
 06:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707170704.303772-1-amir73il@gmail.com> <20250707170704.303772-3-amir73il@gmail.com>
 <s2a5tw4bzb43jvqn6tzz4tkn4rllaul6xuukna6yglxh6rw7rj@qd5p47ylgyxm>
In-Reply-To: <s2a5tw4bzb43jvqn6tzz4tkn4rllaul6xuukna6yglxh6rw7rj@qd5p47ylgyxm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Jul 2025 15:32:16 +0200
X-Gm-Features: Ac12FXwuZxR7R3jjIKtkzQMihkgSBlzXrDHKgqsNuGW_X2G7KhcqvBjaKk2RyMg
Message-ID: <CAOQ4uxgtx9v_6-Z+UySmxJ9jD8ptxfd0vtOCVQtRESnDi5J59g@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 1:26=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 07-07-25 19:07:04, Amir Goldstein wrote:
> > The most unlikely watched permission event is FAN_ACCESS_PERM, because
> > at the time that it was introduced there were no evictable ignore mark,
> > so subscribing to FAN_ACCESS_PERM would have incured a very high
> > overhead.
> >
> > Yet, when we set the fmode to FMODE_NOTIFY_HSM(), we never skip trying
> > to send FAN_ACCESS_PERM, which is almost always a waste of cycles.
> >
> > We got to this logic because of bundling open permisson events and acce=
ss
> > permission events in the same category and because FAN_OPEN_PERM is a
> > commonly used event.
> >
> > By open coding fsnotify_open_perm() in fsnotify_open_perm_and_set_mode(=
),
> > we no longer need to regard FAN_OPEN*_PERM when calculating fmode.
> >
> > This leaves the case of having pre-content events and not having access
> > permission events in the object masks a more likely case than the other
> > way around.
> >
> > Rework the fmode macros and code so that their meaning now refers only
> > to hooks on an already open file:
> >
> > - FMODE_NOTIFY_NONE() skip all events
> > - FMODE_NOTIFY_PERM() send all access permission events
>
> I was a bit confused here but AFAIU you mean "send pre-content events and
> FAN_ACCESS_PERM". And perhaps I'd call this macro
> FMODE_NOTIFY_ACCESS_PERM() because that's the only place where it's going
> to be used...

Yes. agree.

>
> > - FMODE_NOTIFY_HSM()  send pre-conent permission events
>                                  ^^^ content
>
>
> Otherwise neat trick, I like it. Some nitty comments below.

Thanks.

>
> > @@ -683,45 +683,70 @@ int fsnotify_open_perm_and_set_mode(struct file *=
file)
> >       }
> >
> >       /*
> > -      * If there are permission event watchers but no pre-content even=
t
> > -      * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate=
 that.
> > +      * OK, there are some permission event watchers. Check if anybody=
 is
> > +      * watching for permission events on *this* file.
> >        */
> > -     if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
> > -         likely(!fsnotify_sb_has_priority_watchers(sb,
> > -                                             FSNOTIFY_PRIO_PRE_CONTENT=
))) {
> > -             file_set_fsnotify_mode(file, FMODE_NONOTIFY |
> > -                                    FMODE_NONOTIFY_PERM);
> > +     mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify=
_mask);
> > +     p_mask =3D fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > +                                      ALL_FSNOTIFY_PERM_EVENTS);
> > +     if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
> > +             parent =3D dget_parent(dentry);
> > +             p_mask |=3D fsnotify_inode_watches_children(d_inode(paren=
t));
> > +             dput(parent);
> > +     }
> > +
> > +     /*
> > +      * Without any access permission events, we only need to call the
> > +      * open perm hook and no further permission hooks on the open fil=
e.
> > +      * That is the common case with Anti-Malware protection service.
> > +      */
> > +     if (likely(!(p_mask & FSNOTIFY_ACCESS_PERM_EVENTS))) {
> > +             file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
> >               goto open_perm;
> >       }
>
> Why is the above if needed? It seems to me all the cases are properly
> handled below already? And they are very cheap to check...
>
> >       /*
> > -      * OK, there are some pre-content watchers. Check if anybody is
> > -      * watching for pre-content events on *this* file.
> > +      * Legacy FAN_ACCESS_PERM events have very high performance overh=
ead,
> > +      * so unlikely to be used in the wild. If they are used there wil=
l be
> > +      * no optimizations at all.
> >        */
> > -     mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify=
_mask);
> > -     if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > -                                  FSNOTIFY_PRE_CONTENT_EVENTS))) {
> > -             /* Enable pre-content events */
> > +     if (unlikely(p_mask & FS_ACCESS_PERM)) {
> > +             /* Enable all permission and pre-content events */
> >               file_set_fsnotify_mode(file, 0);
> >               goto open_perm;
> >       }
> >
> > -     /* Is parent watching for pre-content events on this file? */
> > -     if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
> > -             parent =3D dget_parent(dentry);
> > -             p_mask =3D fsnotify_inode_watches_children(d_inode(parent=
));
> > -             dput(parent);
> > -             if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
> > -                     /* Enable pre-content events */
> > -                     file_set_fsnotify_mode(file, 0);
> > -                     goto open_perm;
> > -             }
> > +     /*
> > +      * Pre-content events are only supported on regular files.
> > +      * If there are pre-content event watchers and no permission acce=
ss
> > +      * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate=
 that.
> > +      * That is the common case with HSM service.
> > +      */
> > +     if (d_is_reg(dentry) && (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
> > +             file_set_fsnotify_mode(file, FMODE_NONOTIFY |
> > +                                          FMODE_NONOTIFY_PERM);
> > +             goto open_perm;
> >       }
> > -     /* Nobody watching for pre-content events from this file */
> > -     file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM=
);
> > +
> > +     /* Nobody watching permission and pre-content events on this file=
 */
> > +     file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
>
> <snip>
>
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 45fe8f833284..1d54d323d9de 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -205,7 +205,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff=
_t offset,
> >   *
> >   * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
> >   * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) event=
s.
> > - * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content ev=
ents.
> > + * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - .. (excl. pre-content) event=
s.
>                                              ^^ I'd write here "suppress
> FAN_ACCESS_PERM" to be explicit what this is about.

ok.

>
> > @@ -213,10 +213,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, lo=
ff_t offset,
> >  #define FMODE_FSNOTIFY_NONE(mode) \
> >       ((mode & FMODE_FSNOTIFY_MASK) =3D=3D FMODE_NONOTIFY)
> >  #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
> > -#define FMODE_FSNOTIFY_PERM(mode) \
> > +#define FMODE_FSNOTIFY_HSM(mode) \
> >       ((mode & FMODE_FSNOTIFY_MASK) =3D=3D 0 || \
> >        (mode & FMODE_FSNOTIFY_MASK) =3D=3D (FMODE_NONOTIFY | FMODE_NONO=
TIFY_PERM))
> > -#define FMODE_FSNOTIFY_HSM(mode) \
> > +#define FMODE_FSNOTIFY_PERM(mode) \
> >       ((mode & FMODE_FSNOTIFY_MASK) =3D=3D 0)
>
> As mentioned above I'd call this FMODE_FSNOTIFY_ACCESS_PERM().

ok.

>
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index 832d94d783d9..557f9b127960 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -87,14 +87,18 @@
> >  /* Mount namespace events */
> >  #define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
> >
> > +#define FSNOTIFY_OPEN_PERM_EVENTS    (FS_OPEN_PERM | FS_OPEN_EXEC_PERM=
)
> >  /* Content events can be used to inspect file content */
> > -#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM=
 | \
> > +#define FSNOTIFY_CONTENT_PERM_EVENTS (FSNOTIFY_OPEN_PERM_EVENTS | \
> >                                     FS_ACCESS_PERM)
>
> You don't use FSNOTIFY_OPEN_PERM_EVENTS anywhere. If anything I'd drop

Right, I will drop it.

> FSNOTIFY_CONTENT_PERM_EVENTS completely as that has only single use in
> ALL_FSNOTIFY_PERM_EVENTS instead of adding more practically unused define=
s.
>

It is going to be used down the road.
In my followup fa_pre_dir_access patches, I split the dir/file macros:

#define FSNOTIFY_PRE_CONTENT_EVENTS \
                                 (FSNOTIFY_PRE_FILE_CONTENT_EVENTS | \
                                  FSNOTIFY_PRE_DIR_CONTENT_EVENTS)

Because the pre-dir-content events are not applicable ON_CHILD:

#define FS_EVENTS_POSS_ON_CHILD   (FSNOTIFY_CONTENT_PERM_EVENTS | \
                                   FSNOTIFY_PRE_FILE_CONTENT_EVENTS | \

> >  /* Pre-content events can be used to fill file content */
> >  #define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
> >
> >  #define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
> >                                 FSNOTIFY_PRE_CONTENT_EVENTS)
> > +/* Access permission events determine FMODE_NONOTIFY_PERM mode */
> > +#define FSNOTIFY_ACCESS_PERM_EVENTS (FS_ACCESS_PERM | \
> > +                                  FSNOTIFY_PRE_CONTENT_EVENTS)
>
> I don't think this define is needed either so I'd drop it for now...

ok. v2 soon...

Thanks,
Amir.

