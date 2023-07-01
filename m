Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7540744A8A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGAQZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAQZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:25:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D107E1710
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jul 2023 09:25:26 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76243a787a7so295107985a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jul 2023 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688228726; x=1690820726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PmEL3RRJQr/GUtTDExFT6os7SixTUtmXUZqcGZvsSc=;
        b=Abuo5t0RY9t7YHsv9GZFyBG/qquvkIjwHtCRnrTpzc0ICeStS6je/jRkNoJNudHnxH
         IOhWRfY0zeuMZMDcBb10k9tfZb34E2H2DDc1+aCjS9LO9/geLJbVE8OHGzII7eO4DHJN
         ZmTKuvGK3pzKZgzns4uaTHTTNAzoIAfqZXpbZQ+5jQd6eLEFRejd37ZPBAW0YsPYuK/d
         GJaTR0NEHDIeT0LiyccZyR3B2Fd5D7tgNimGleppqaOB5wBJZ49L4RzfeSZRmfkw0w34
         JJ/iIHNEaSi7Mw/pjSvcoAqROqOW88Znag9bQWvYHnXbgzBjQfFUQiHj3xHbX0znd5py
         nRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688228726; x=1690820726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PmEL3RRJQr/GUtTDExFT6os7SixTUtmXUZqcGZvsSc=;
        b=DhPH6O6Q39mn9jdhF9Yl8EfyUGuUvs59V3dX7+x4p/ferE8PNukAKhCg2xo3WpQ9wn
         wUuDb05Et3R5Ua6Nc4Sb2gnKLaCC6Hcvd3uY9n6sdKV0t13q8jmxwTcTxFkbPaaelZW6
         ODguFtE5v1d5BhH6a8Dby4n8ixhAUm/0k64TNmO6hT/gXY4JupophaxuXTgSsGK4ywet
         wdKAgJbj5JgF3C3wHX/6qrcPU7xxr7pY6TizpyhH1+t+DnRzPOizcAw70GrBoJFlkQPQ
         JSQVzAgv3WOImGuLuyx0pW/sLqzPwx6TWKcv1jNfD5HpKbce0BRxnDIoUaltbPTD0Cjf
         xIfg==
X-Gm-Message-State: AC+VfDw+1cHvSkL+Wf4QltJ7oXk1955hmvpdCdGq7OsbXvhV+wbwxW8+
        HMSZ3rOAcvdk7na++aGpPitcZXvxgbuSrrBz5DI=
X-Google-Smtp-Source: ACHHUZ7B3MDRLGc8bKQ7MuFvLjz/x144xxrVziz0mqJlH8GDvtWCjc5e+BL07XaarWCc3ywggnAH3/yELPrpHD9v0Bc=
X-Received: by 2002:a05:620a:1728:b0:765:d53e:3352 with SMTP id
 az40-20020a05620a172800b00765d53e3352mr7064836qkb.30.1688228725903; Sat, 01
 Jul 2023 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230629042044.25723-1-amir73il@gmail.com> <20230630-kitzeln-sitzt-c6b4325362e5@brauner>
In-Reply-To: <20230630-kitzeln-sitzt-c6b4325362e5@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Jul 2023 19:25:14 +0300
Message-ID: <CAOQ4uxheb7z=5ricKUz7JduQGVbxNRp-FNrViMtd0Dy6cAgOnQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel internal
 pseudo fs
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:29=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Jun 29, 2023 at 07:20:44AM +0300, Amir Goldstein wrote:
> > Hopefully, nobody is trying to abuse mount/sb marks for watching all
> > anonymous pipes/inodes.
> >
> > I cannot think of a good reason to allow this - it looks like an
> > oversight that dated back to the original fanotify API.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczx=
v2pm@quack3/
> > Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block ma=
rk")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > As discussed, allowing sb/mount mark on anonymous pipes
> > makes no sense and we should not allow it.
> >
> > I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
> > backport to maintained LTS kernels event though this dates back to day =
one
> > with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.
> >
> > The reason this is an RFC and that I have not included also the
> > optimization patch is because we may want to consider banning kernel
> > internal inodes from fanotify and/or inotify altogether.
> >
> > The tricky point in banning anonymous pipes from inotify, which
> > could have existing users (?), but maybe not, so maybe this is
> > something that we need to try out.
> >
> > I think we can easily get away with banning anonymous pipes from
> > fanotify altogeter, but I would not like to get to into a situation
> > where new applications will be written to rely on inotify for
> > functionaly that fanotify is never going to have.
> >
> > Thoughts?
> > Am I over thinking this?
> >
> > Amir.
> >
> >  fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 95d7d8790bc3..8240a3fdbef0 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1622,6 +1622,20 @@ static int fanotify_events_supported(struct fsno=
tify_group *group,
> >           path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM=
)
> >               return -EINVAL;
> >
> > +     /*
> > +      * mount and sb marks are not allowed on kernel internal pseudo f=
s,
> > +      * like pipe_mnt, because that would subscribe to events on all t=
he
> > +      * anonynous pipes in the system.
>
> s/anonynous/anonymous/
>
> > +      *
> > +      * XXX: SB_NOUSER covers all of the internal pseudo fs whose obje=
cts
> > +      * are not exposed to user's mount namespace, but there are other
> > +      * SB_KERNMOUNT fs, like nsfs, debugfs, for which the value of
> > +      * allowing sb and mount mark is questionable.
> > +      */
> > +     if (mark_type !=3D FAN_MARK_INODE &&
> > +         path->mnt->mnt_sb->s_flags & SB_NOUSER)
> > +             return -EINVAL;
>

On second thought, I am not sure about  the EINVAL error code here.
I used the same error code that Jan used for permission events on
proc fs, but the problem is that applications do not have a decent way
to differentiate between
"sb mark not supported by kernel" (i.e. < v4.20) vs.
"sb mark not supported by fs" (the case above)

same for permission events:
"kernel compiled without FANOTIFY_ACCESS_PERMISSIONS" vs.
"permission events not supported by fs" (procfs)

I have looked for other syscalls that react to SB_NOUSER and I've
found that mount also returns EINVAL.

So far, fanotify_mark() and fanotify_init() mostly return EINVAL
for invalid flag combinations (also across the two syscalls),
but not because of the type of object being marked, except for
the special case of procfs and permission events.

mount(2) syscall OTOH, has many documented EINVAL cases
due to the type of source object (e.g. propagation type shared).

I know there is no standard and EINVAL can mean many
different things in syscalls, but I thought that maybe EACCES
would convey more accurately the message:
"The sb/mount of this fs is not accessible for placing a mark".

WDYT? worth changing?
worth changing procfs also?
We don't have that EINVAL for procfs documented in man page btw.

Thanks,
Amir.
