Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE20877EEA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 03:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347477AbjHQBUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347478AbjHQBUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6332D61
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692235162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdJI8YOWfcspuu/Kis9p/FFOj/Ijn4DHopWgTGqX0p8=;
        b=GpwV0pbe3DxMMYEDc1i3UtgaPnxrkmXNWbPUqcwDu6RMwaBSUDyieaDCy4ICbBHZoGx/LY
        z9CeG6MeLe/Jfn+l3zrqXAY19Q/YtLXk4+WB11ZSTK9mE5v/L23ZNK2UjCwMsUSnAZQFgw
        nEoy17x369SDY/2x/gUXphpUZ5gqRrk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-rdydKOcFPqqYTLgTbgHYLA-1; Wed, 16 Aug 2023 21:19:21 -0400
X-MC-Unique: rdydKOcFPqqYTLgTbgHYLA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-52576448c91so1375513a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 18:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692235160; x=1692839960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdJI8YOWfcspuu/Kis9p/FFOj/Ijn4DHopWgTGqX0p8=;
        b=fiK5fAjntmKSw2KDwziir/ztrrmVas1MIr+plhbfDu5soJexAaNyVVvRtTf93FQe2R
         DdTDGLUrWNlSPytKI2NzWErPtcY3COJ/MG/41+UmeR0XPJjNa1z55Wv3Kpoud8E6vOFR
         pQjudnf48f7Cgnt2+jWzMliuhsIrk+4BRQsu8Mu2eyMFtGym438X+IHYU3ErjW4+ke3G
         6LYV3v2qlWYnc0Auzm7JM4h7jT3WSHBU+iL1wbQ6yD+K786VLC5SJ55yhxvNNI1PAlHH
         49wBBQJf/CgrtNNAli8UBago5UXLwm8HMFCQ6HkyC+w4U6o+9IsoNcMd2MWCyo0dqgzS
         TU0w==
X-Gm-Message-State: AOJu0YwetLNby0NmXLtsDgTWBcYjiIcoTkebuf6TF6CuWbLfV5Y5U7Rf
        IBD4RjkVdkNGWQxZSG4PoZ6OJ/Sq4MtK/6g6e7gJqKxEvMyQ/5M3FtBIdFjzDHPmxu55qNUeR0v
        QWqFN5H60qsmZe2/LfxykPQ3wXEmHQJhsENwCMQh5wA==
X-Received: by 2002:a05:6402:2028:b0:523:b665:e494 with SMTP id ay8-20020a056402202800b00523b665e494mr2705174edb.15.1692235159937;
        Wed, 16 Aug 2023 18:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+3zVWGGEV7pU4ZRS9ZVR7J1WVptyIFU1YawAqPgdGNxY0nrs+srZ1tF1GgXLlWOW6IssVK6QeBhfLu09ErmQ=
X-Received: by 2002:a05:6402:2028:b0:523:b665:e494 with SMTP id
 ay8-20020a056402202800b00523b665e494mr2705166edb.15.1692235159674; Wed, 16
 Aug 2023 18:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230814211116.3224759-1-aahringo@redhat.com> <20230814211116.3224759-7-aahringo@redhat.com>
 <bd76489a6b0d2f56f4a68d48b3736fcaf5b5119b.camel@kernel.org>
In-Reply-To: <bd76489a6b0d2f56f4a68d48b3736fcaf5b5119b.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 16 Aug 2023 21:19:08 -0400
Message-ID: <CAK-6q+i3oKN3M_kdoQ99hMnzSZyRH1sPdxZ0MQMwp+vSixUhwg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Aug 16, 2023 at 9:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > This patch uses the FL_SLEEP flag in struct file_lock to check if it's =
a
> > blocking request in case if the request coming from nfs lockd process
> > indicated by lm_grant() is set.
> >
> > IF FL_SLEEP is set a asynchronous blocking request is being made and
> > it's waiting for lm_grant() callback being called to signal the lock wa=
s
> > granted. If it's not set a synchronous non-blocking request is being ma=
de.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >  fs/dlm/plock.c | 38 ++++++++++++++++++++++----------------
> >  1 file changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > index 0094fa4004cc..524771002a2f 100644
> > --- a/fs/dlm/plock.c
> > +++ b/fs/dlm/plock.c
> > @@ -140,7 +140,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 =
number, struct file *file,
> >       op->info.optype         =3D DLM_PLOCK_OP_LOCK;
> >       op->info.pid            =3D fl->fl_pid;
> >       op->info.ex             =3D (fl->fl_type =3D=3D F_WRLCK);
> > -     op->info.wait           =3D IS_SETLKW(cmd);
> >       op->info.fsid           =3D ls->ls_global_id;
> >       op->info.number         =3D number;
> >       op->info.start          =3D fl->fl_start;
> > @@ -148,24 +147,31 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u6=
4 number, struct file *file,
> >       op->info.owner =3D (__u64)(long)fl->fl_owner;
> >       /* async handling */
> >       if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
> > -             op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> > -             if (!op_data) {
> > -                     dlm_release_plock_op(op);
> > -                     rv =3D -ENOMEM;
> > -                     goto out;
> > -             }
> > +             if (fl->fl_flags & FL_SLEEP) {
> > +                     op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> > +                     if (!op_data) {
> > +                             dlm_release_plock_op(op);
> > +                             rv =3D -ENOMEM;
> > +                             goto out;
> > +                     }
> >
> > -             op_data->callback =3D fl->fl_lmops->lm_grant;
> > -             locks_init_lock(&op_data->flc);
> > -             locks_copy_lock(&op_data->flc, fl);
> > -             op_data->fl             =3D fl;
> > -             op_data->file   =3D file;
> > +                     op->info.wait =3D 1;
> > +                     op_data->callback =3D fl->fl_lmops->lm_grant;
> > +                     locks_init_lock(&op_data->flc);
> > +                     locks_copy_lock(&op_data->flc, fl);
> > +                     op_data->fl             =3D fl;
> > +                     op_data->file   =3D file;
> >
> > -             op->data =3D op_data;
> > +                     op->data =3D op_data;
> >
> > -             send_op(op);
> > -             rv =3D FILE_LOCK_DEFERRED;
> > -             goto out;
> > +                     send_op(op);
> > +                     rv =3D FILE_LOCK_DEFERRED;
> > +                     goto out;
>
> A question...we're returning FILE_LOCK_DEFERRED after the DLM request is
> sent. If it ends up being blocked, what happens? Does it do a lm_grant
> downcall with -EAGAIN or something as the result?
>

no, when info->wait is set then it is a blocked lock request, which
means lm_grant() will be called when the lock request is granted.

>
> > +             } else {
> > +                     op->info.wait =3D 0;
> > +             }
> > +     } else {
> > +             op->info.wait =3D IS_SETLKW(cmd);
> >       }
> >
> >       send_op(op);
>
> Looks reasonable overall.
>
> Now that I look, we have quite a number of places in the kernel that
> seem to check for F_SETLKW, when what they really want is to check
> FL_SLEEP.

Yes, so far I understand FL_SLEEP is F_SETLKW when you get only
F_SETLK in case of fl->fl_lmops && fl->fl_lmops->lm_grant is true. It
is confusing but this is how it works... if it's not set we will get
F_SETLKW and this should imply FL_SLEEP is set.

- Alex

