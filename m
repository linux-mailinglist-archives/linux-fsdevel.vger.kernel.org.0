Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49C516FE41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBZLxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:53:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36910 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgBZLxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:53:19 -0500
Received: by mail-io1-f67.google.com with SMTP id c17so3033295ioc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 03:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ucFXgVfJz5UdlQYHHNVDzqbiSc+x2bU6o9ORgKn7/n4=;
        b=m9xKKxVLpH36W7SBqMNu0McdTPgqrYTcdvBv82pBBMjfA3/8Xp8xAaQIRm1/Al2CU4
         KAGt9rpsstdhoz9XzvoMZqI8hOq2t75bbdRMH/KhLhcdqkrUdIJT5C+EhxUcl/EjpnQI
         +CUmnROb6pCYhnqfnHKartqXF6FKoUbmwP1e5B3/4Ozb33Onph8Qhoa0YmU/hfH0dsbl
         gcuz/hjGMWI6rrZymx9SYvc8ERbf6xG3kjKAIqBeMNztW727PCKN39aVCXq4Z/1U71B3
         FIwdP+6P5EXp5GlkfiUMENFfjqRIHixqnXh5CAuTf+fB6Yy7/aUoKuXAy2UZ7LdruIkz
         1Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucFXgVfJz5UdlQYHHNVDzqbiSc+x2bU6o9ORgKn7/n4=;
        b=uYZmWBvkfn/t7z5AbZKDxw3uItJ+cpO/b1zPmCiwGsyWaA2I1nrg8KEisHxACLfipf
         i2YUtHQ7N+Cdutadr3ZrJKSQuINf/SZgK03nuuBjqUSuWr1fsHX0sEaHrP4T2pUIzm/y
         EaQ20jpBWqtZ3GB0JlkJIlwD/z5KUM5ZNGUntVOXGNoPMsocIqhkRHPYjgFUfONyh+T+
         AKavyl8lrNi7Esh1T7TZOTT42S6IAnX9/wFym1IVrnWkLHxqQOek7I+IkkJhLkoNpC2o
         HKxU52ri3RXuz6Dbstjcqx7ch2enBVN1XbiXx2d40Tjr6TIKtp6InkF3+Lv/4dYWIKFI
         38Dw==
X-Gm-Message-State: APjAAAUYce017olXyZbT1InAJMF4V0S10u4Mh2LMzcq0+Uww+Gguqp/g
        IwstFa7p/vv33j+cSEGSla6t0kh2kX5sP6fczPhimr6X
X-Google-Smtp-Source: APXvYqxfXRGpmWmHTXmFjxvVQrPZ5ESpGvWwjCdmmpoPJ+ZfaZj4xN3iOF1uq7C68e1Zh/ORQxMJjOHdE/ddYM/4xyU=
X-Received: by 2002:a02:cdd9:: with SMTP id m25mr3650129jap.123.1582717997302;
 Wed, 26 Feb 2020 03:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz>
In-Reply-To: <20200226102354.GE10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 26 Feb 2020 13:53:06 +0200
Message-ID: <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:23 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 17-02-20 15:14:50, Amir Goldstein wrote:
> > For some events, we are going to encode both child and parent fid's,
> > so we need to do a little refactoring of struct fanotify_event and fid
> > helper functions.
> >
> > Move fsid member from struct fanotify_fid out to struct fanotify_event,
> > so we can store fsid once for two encoded fid's (we will only encode
> > parent if it is on the same filesystem).
> >
> > This does not change the size of struct fanotify_event because struct
> > fanotify_fid is still bigger than struct path on 32bit arch and is the
> > same size as struct path (16 bytes) on 64bit arch.
> >
> > Group fh_len and fh_type as struct fanotify_fid_hdr.
> > Pass struct fanotify_fid and struct fanotify_fid_hdr to helpers
> > fanotify_encode_fid() and copy_fid_to_user() instead of passing the
> > containing fanotify_event struct.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > @@ -327,16 +327,18 @@ init: __maybe_unused
> >               event->pid = get_pid(task_pid(current));
> >       else
> >               event->pid = get_pid(task_tgid(current));
> > -     event->fh_len = 0;
> > +     event->fh.len = 0;
> > +     if (fsid)
> > +             event->fsid = *fsid;
> >       if (id && FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
> >               /* Report the event without a file identifier on encode error */
> >               event->fh_type = fanotify_encode_fid(event, id, gfp, fsid);
>                         ^^^^
> This should be event->fh, shouldn't it? I wonder how come 0-day didn't
> catch this...

Maybe 0-day is on vacation...

>
> > +struct fanotify_fid_hdr {
> > +     u8 type;
> > +     u8 len;
> > +};
> > +
> >  struct fanotify_fid {
> > -     __kernel_fsid_t fsid;
> >       union {
> >               unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> >               unsigned char *ext_fh;
> >       };
> >  };
> ...
> > @@ -63,13 +81,13 @@ struct fanotify_event {
> >       u32 mask;
> >       /*
> >        * Those fields are outside fanotify_fid to pack fanotify_event nicely
> > -      * on 64bit arch and to use fh_type as an indication of whether path
> > +      * on 64bit arch and to use fh.type as an indication of whether path
> >        * or fid are used in the union:
> >        * FILEID_ROOT (0) for path, > 0 for fid, FILEID_INVALID for neither.
> >        */
> > -     u8 fh_type;
> > -     u8 fh_len;
> > +     struct fanotify_fid_hdr fh;
> >       u16 pad;
>
> The 'pad' here now looks rather bogus. Let's remove it and leave padding on
> the compiler. It's in-memory struct anyway...

ok.

>
> > +     __kernel_fsid_t fsid;
> >       union {
> >               /*
> >                * We hold ref to this path so it may be dereferenced at any
>
> Here I disagree. IMO 'fsid' should be still part of the union below because
> the "object identification" is either struct path or (fsid + fh). I
> understand that you want to reuse fsid for the other file handle. But then
> I believe it should rather be done like:
>
> struct fanotify_fh {
>         union {
>                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
>                 unsigned char *ext_fh;
>         };
> };
>

This I will do.

> struct fanotify_fid {
>         __kernel_fsid_t fsid;
>         struct fanotify_fh object;
>         struct fanotify_fh dir;
> }
>

object and dir do not end up in the same struct.
object is in fanotify_event
dir is in the extended fanotify_name_event, but I can do:

struct fanotify_fid {
        __kernel_fsid_t fsid;
        struct fanotify_fh fh;
}

 struct fanotify_event {
        struct fsnotify_event fse;
        u32 mask;
        struct fanotify_fid_hdr fh;
        struct fanotify_fid_hdr dfh;
        union {
                struct path path;
                struct fanotify_fid object;
        };
        struct pid *pid;
};

struct fanotify_name_event {
        struct fanotify_event fae;
        struct fanotify_fh  dir;
        struct qstr name;
        unsigned char inline_name[FANOTIFY_INLINE_NAME_LEN];
};



> BTW, is file handle length and type guaranteed to be the same for 'object' and
> 'dir'? Given how filehandles try to be rather opaque sequences of bytes,
> I'm not sure we are safe to assume that...

No and as you can see in the final struct above, we are not assuming that
we are only using safe fsid.

Looking at the final result, do you agree to leave fsid outside of struct
fanotify_fid as I did, or do you still dislike it being outside of the union?

Thanks,
Amir.
