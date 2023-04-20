Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CA6E96BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjDTOPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDTOPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:15:19 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B1358A;
        Thu, 20 Apr 2023 07:15:18 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-440364c90d6so169430e0c.0;
        Thu, 20 Apr 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682000117; x=1684592117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfXT5/UjqAn/aYok60aRQfZSJdZtek6u1RvOESD4I3k=;
        b=MUfmJSGdg517Fitq4tA6PWRDGubuFA80Vg6KUbUzSt7GxUOuvnoj8rBHNd5dlX3JVw
         m3D8aDbA1nxoVlWH50MQUcUsx6KxMuzHoxlj/1qrNzy35kqwF2c0xBlIxNxHBSZ98cdP
         nQxL41XkUdTEhafaviNtGaGYp1u8uWUr1D1iVtF5mJLgBhegwlmRsAhjFwSfeomTsoMQ
         EAm27/bpBVPTsnIAIv/zpR0dL8iDGwaFRzk3tVuMVEwaLwm8Z6W64SfSBMM6ldqF5HAK
         oriOpMSYKWM0DQZuI64E54NlZ2B8GeDSLhZrpPYb7SbqQszdiybNaAAaP+rrjibBjEHZ
         yXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000117; x=1684592117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfXT5/UjqAn/aYok60aRQfZSJdZtek6u1RvOESD4I3k=;
        b=e0OvyAqeXmaXmGeIkvsHKzEIXvp6Rwi0/UJqjNGpT9XQ8mnglt4JnUWfLjnTD9ccol
         7+L5rwAfCJcbfFrRS68n+lWmtBXLgZ7I7QKgStyuOmG40bqt5d3gSYEcx/PQLO/+EcFH
         01eJBUHugC6XI/Lj8DvuMUySoQUfR58PXFLBDa/6WeCfIWp6t7SDVUCqaxdWNlDOObs0
         n86yPP9cf7aD4BtBHO6gI5WdT+zwL2JWK+AIcl6cmhx7ymcE4Bh52+XkC354kPVm0wmJ
         tgNMdIEoTn37Z+krkzbLw4H7ygtScVxfgR1ZbKfDkswiR1Pf5ITO5gOLRDcTvmZZVl4x
         N8zw==
X-Gm-Message-State: AAQBX9cQFrxnBKA/WMFztJz6/1AlvMzRPmS9XxGJfn6U1o89Zv8CIP0Y
        IFkigZaHHIu0sye2DvnT9UJwz3jW/pRl/tmDrFg=
X-Google-Smtp-Source: AKy350ZvbChU1Y6ibKpXvvI147sJ6DbsauyHErkG01i6JtBr5z6tMtytZLsSqTkMpcmPz1JpBeFdgNiJJcrGVAyEjQk=
X-Received: by 2002:a67:c106:0:b0:42e:3b51:2a8a with SMTP id
 d6-20020a67c106000000b0042e3b512a8amr1029341vsj.0.1682000117225; Thu, 20 Apr
 2023 07:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230416060722.1912831-1-amir73il@gmail.com> <20230420131207.dligsga5spbiptje@quack3>
In-Reply-To: <20230420131207.dligsga5spbiptje@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Apr 2023 17:15:05 +0300
Message-ID: <CAOQ4uxiKdg5TMR0J+_3ENKOr+t+K3eU61h0m2Oc1PY1npEONuw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: support watching filesystems and mounts
 inside userns
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
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

On Thu, Apr 20, 2023 at 4:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 16-04-23 09:07:22, Amir Goldstein wrote:
> > An unprivileged user is allowed to create an fanotify group and add
> > inode marks, but not filesystem and mount marks.
> >
> > Add limited support for setting up filesystem and mount marks by an
> > unprivileged user under the following conditions:
> >
> > 1.   User has CAP_SYS_ADMIN in the user ns where the group was created
> > 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
> >      mounted (implies FS_USERNS_MOUNT)
> >   OR (in case setting up a mark mount)
> > 2.b. User has CAP_SYS_ADMIN in the user ns attached to an idmapped moun=
t
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> The patch looks good to me. Just two comments below.
>
> > Christian,
> >
> > You can find this patch, along with FAN_UNMOUNT patches on my github [3=
].
> > Please confirm that this meets your needs for watching container mounts=
.
> >
> > [3] https://github.com/amir73il/linux/commits/fan_unmount
>
> Yeah, it would be good to get ack from Christian that the model you propo=
se
> works for him.
>
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index db3b79b8e901..2c3e123aee14 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1238,6 +1238,7 @@ static struct fsnotify_mark *fanotify_add_new_mar=
k(struct fsnotify_group *group,
> >        * A group with FAN_UNLIMITED_MARKS does not contribute to mark c=
ount
> >        * in the limited groups account.
> >        */
> > +     BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_MARKS));
> >       if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS) &&
> >           !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS)=
)
> >               return ERR_PTR(-ENOSPC);
> ...
> > @@ -1557,21 +1559,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> >               goto out_destroy_group;
> >       }
> >
> > +     BUILD_BUG_ON(!(FANOTIFY_ADMIN_INIT_FLAGS & FAN_UNLIMITED_QUEUE));
> >       if (flags & FAN_UNLIMITED_QUEUE) {
> > -             fd =3D -EPERM;
> > -             if (!capable(CAP_SYS_ADMIN))
> > -                     goto out_destroy_group;
> >               group->max_events =3D UINT_MAX;
> >       } else {
> >               group->max_events =3D fanotify_max_queued_events;
> >       }
> >
> > -     if (flags & FAN_UNLIMITED_MARKS) {
> > -             fd =3D -EPERM;
> > -             if (!capable(CAP_SYS_ADMIN))
> > -                     goto out_destroy_group;
> > -     }
> > -
>
> Perhaps this hunk (plus the BUILD_BUG_ON hunk above) should go into a
> separate patch with a proper changelog?  I was scratching my head over it
> for a while until I've realized it's unrelated cleanup of dead code.
>

Sure. It took me a while to understand it myself, when I re-read it
after two years...

Thanks,
Amir.
