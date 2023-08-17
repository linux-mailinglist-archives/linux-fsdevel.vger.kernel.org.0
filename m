Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFE577F759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351327AbjHQNLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351340AbjHQNKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D083583
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692277710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmwH07w5fyy3pvNX0bl7s81W4p0ZB0NuiFuXPpkj2yY=;
        b=W5SS806iDNydGtStg56toPXHHmBfg49ZpGd3uSMrjJRV+XO9rX0has3mB2l74iqyCsfm2P
        06xKZ6cZRQWsmAlBDkgMu8DPquo39Aghu2bHslRVMKiQ3mZQgJcxZ3asytfc+wZS5vbxgT
        Eoz+NTbJlEgYy1hvfbkGOz08jnOU9no=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-yf2l3_oFO7SCdjc70L_pQg-1; Thu, 17 Aug 2023 09:02:21 -0400
X-MC-Unique: yf2l3_oFO7SCdjc70L_pQg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe32cab9b7so7532319e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 06:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692277339; x=1692882139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmwH07w5fyy3pvNX0bl7s81W4p0ZB0NuiFuXPpkj2yY=;
        b=KZuCtngu2cxYbEG5wIRaV4NmKTRU3Xdk5N5N+rGluSDEZs1Py+NEnSsPd7LZtQS71Q
         u6f+jYI3aa8p2z6YKCM/z9I/O0Cpwwnd2bmHJRKARF4r49l8uAEzcHY9AbSO+0ZZPHC/
         MhC2h2iAM3Ivwmje62aCnmlP1Z5s28OyZf71N/LeWagbDY+8VCEplFiKQvMoz/AjA5Gc
         aQTdJAhj3zUsQ0rQG9XWgU/Ehl4UyZLBH+IAv3V7VvWHQ025b++DMjbm0jE02NUg57r4
         Fh4wOBgDqqr0aCnXhCpb1ycmc0h6DRdKqxc2uvRc4F5t7EHYSEeeqML8EvMk5zLY4uAd
         jaJw==
X-Gm-Message-State: AOJu0Yxa2HvudWzWT9kDUqf0o0ULkLHGhbo/Z6VT7HKGwGducwh2BVtj
        lJB5oCROnQM2eheTdHtOz12A3Ed7NsKh54zyZbxr/4S4QgjiCCc7xUUfjM46nHyAv399IlJBPsI
        zCMQUiCmbGo9FGqzMkuQYy1/c970i9lf6W9pLLPqedEu5KXCl7A==
X-Received: by 2002:a05:6512:2149:b0:4fc:3756:754e with SMTP id s9-20020a056512214900b004fc3756754emr3620828lfr.56.1692277339114;
        Thu, 17 Aug 2023 06:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF/W240XLQ+e6Phb4JU0Im3xg6glWU3oArtomKJAuH6Nr56XJ4O+HytbRYxjpPEyRvYX5BslhfhJT54YxNc5Y=
X-Received: by 2002:a05:6512:2149:b0:4fc:3756:754e with SMTP id
 s9-20020a056512214900b004fc3756754emr3620800lfr.56.1692277338728; Thu, 17 Aug
 2023 06:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230814211116.3224759-1-aahringo@redhat.com> <20230814211116.3224759-7-aahringo@redhat.com>
 <bd76489a6b0d2f56f4a68d48b3736fcaf5b5119b.camel@kernel.org>
 <CAK-6q+i3oKN3M_kdoQ99hMnzSZyRH1sPdxZ0MQMwp+vSixUhwg@mail.gmail.com> <bb8806020ade39f6db9d209b0a4a34dc4d69bdb8.camel@kernel.org>
In-Reply-To: <bb8806020ade39f6db9d209b0a4a34dc4d69bdb8.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 17 Aug 2023 09:02:06 -0400
Message-ID: <CAK-6q+jNceDDJwJK6as6TKvaRoFaxmuWao=gnbLGjTiwHbywXA@mail.gmail.com>
Subject: Re: [RFCv2 6/7] dlm: use FL_SLEEP to check if blocking request
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Aug 17, 2023 at 7:27=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2023-08-16 at 21:19 -0400, Alexander Aring wrote:
> > Hi,
> >
> > On Wed, Aug 16, 2023 at 9:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > > > This patch uses the FL_SLEEP flag in struct file_lock to check if i=
t's a
> > > > blocking request in case if the request coming from nfs lockd proce=
ss
> > > > indicated by lm_grant() is set.
> > > >
> > > > IF FL_SLEEP is set a asynchronous blocking request is being made an=
d
> > > > it's waiting for lm_grant() callback being called to signal the loc=
k was
> > > > granted. If it's not set a synchronous non-blocking request is bein=
g made.
> > > >
> > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > ---
> > > >  fs/dlm/plock.c | 38 ++++++++++++++++++++++----------------
> > > >  1 file changed, 22 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > > > index 0094fa4004cc..524771002a2f 100644
> > > > --- a/fs/dlm/plock.c
> > > > +++ b/fs/dlm/plock.c
> > > > @@ -140,7 +140,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, =
u64 number, struct file *file,
> > > >       op->info.optype         =3D DLM_PLOCK_OP_LOCK;
> > > >       op->info.pid            =3D fl->fl_pid;
> > > >       op->info.ex             =3D (fl->fl_type =3D=3D F_WRLCK);
> > > > -     op->info.wait           =3D IS_SETLKW(cmd);
> > > >       op->info.fsid           =3D ls->ls_global_id;
> > > >       op->info.number         =3D number;
> > > >       op->info.start          =3D fl->fl_start;
> > > > @@ -148,24 +147,31 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace=
, u64 number, struct file *file,
> > > >       op->info.owner =3D (__u64)(long)fl->fl_owner;
> > > >       /* async handling */
> > > >       if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
> > > > -             op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> > > > -             if (!op_data) {
> > > > -                     dlm_release_plock_op(op);
> > > > -                     rv =3D -ENOMEM;
> > > > -                     goto out;
> > > > -             }
> > > > +             if (fl->fl_flags & FL_SLEEP) {
> > > > +                     op_data =3D kzalloc(sizeof(*op_data), GFP_NOF=
S);
> > > > +                     if (!op_data) {
> > > > +                             dlm_release_plock_op(op);
> > > > +                             rv =3D -ENOMEM;
> > > > +                             goto out;
> > > > +                     }
> > > >
> > > > -             op_data->callback =3D fl->fl_lmops->lm_grant;
> > > > -             locks_init_lock(&op_data->flc);
> > > > -             locks_copy_lock(&op_data->flc, fl);
> > > > -             op_data->fl             =3D fl;
> > > > -             op_data->file   =3D file;
> > > > +                     op->info.wait =3D 1;
> > > > +                     op_data->callback =3D fl->fl_lmops->lm_grant;
> > > > +                     locks_init_lock(&op_data->flc);
> > > > +                     locks_copy_lock(&op_data->flc, fl);
> > > > +                     op_data->fl             =3D fl;
> > > > +                     op_data->file   =3D file;
> > > >
> > > > -             op->data =3D op_data;
> > > > +                     op->data =3D op_data;
> > > >
> > > > -             send_op(op);
> > > > -             rv =3D FILE_LOCK_DEFERRED;
> > > > -             goto out;
> > > > +                     send_op(op);
> > > > +                     rv =3D FILE_LOCK_DEFERRED;
> > > > +                     goto out;
> > >
> > > A question...we're returning FILE_LOCK_DEFERRED after the DLM request=
 is
> > > sent. If it ends up being blocked, what happens? Does it do a lm_gran=
t
> > > downcall with -EAGAIN or something as the result?
> > >
> >
> > no, when info->wait is set then it is a blocked lock request, which
> > means lm_grant() will be called when the lock request is granted.
> >
>
> Ok, that's probably problematic with the current code too. lockd will
> time out the block after 7s, so if the lock isn't granted in that time
> it'll give up on it.
>

that's why blocked lock requests (meaning F_SETLKW, FL_SLEEP is set)
need to use NLM_NEVER? It will never give up on it.

I thought NLM_TIMEOUT is just the polling frequency for doing a
blocked request by doing non-blocking requests. Means trylocks in a
loop with a polling frequency.

> > >
> > > > +             } else {
> > > > +                     op->info.wait =3D 0;
> > > > +             }
> > > > +     } else {
> > > > +             op->info.wait =3D IS_SETLKW(cmd);
> > > >       }
> > > >
> > > >       send_op(op);
> > >
> > > Looks reasonable overall.
> > >
> > > Now that I look, we have quite a number of places in the kernel that
> > > seem to check for F_SETLKW, when what they really want is to check
> > > FL_SLEEP.
> >
> > Yes, so far I understand FL_SLEEP is F_SETLKW when you get only
> > F_SETLK in case of fl->fl_lmops && fl->fl_lmops->lm_grant is true. It
> > is confusing but this is how it works... if it's not set we will get
> > F_SETLKW and this should imply FL_SLEEP is set.
> >
> >
>
> Yeah. Might be good to consider how to make this more consistent across
> the kernel.

ok. I will do some grep and try to find those places.

- Alex

