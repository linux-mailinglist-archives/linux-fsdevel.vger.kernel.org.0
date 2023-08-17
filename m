Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266D877FE04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 20:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjHQSkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354583AbjHQSkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CC35AC
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692297555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kd4TYVvwU1aUt0kyKry2n2j6BSVfouTESoEkR9Nhxgo=;
        b=JfG3Q8Y4w5raYv8FSoGfED+3QfICjsJaqjwK6K6BPEu/cuEa2YWdWprXGdBS1BT4nL3kJ/
        i1vte6mgbgYZ6ayHa7kT+tdAhjrCs7c+iG1+vYxZ2cGrj3xflE7O/iY6ZlRWigM6nwk2Uc
        vYMpIxo37kXGS4EJtTfPaf5o4QVb5ds=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-h8wVQk83OO6J1OuHRnJKcw-1; Thu, 17 Aug 2023 14:39:13 -0400
X-MC-Unique: h8wVQk83OO6J1OuHRnJKcw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe0e1dfdbaso18978e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 11:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297552; x=1692902352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd4TYVvwU1aUt0kyKry2n2j6BSVfouTESoEkR9Nhxgo=;
        b=UQyDh4kGYzRNcM/JNeV4ZuUhs2GCC6hCrr5/3Y/r/Gu154rwwUxixl5CfHpcusqpDB
         YVGDTo+u5+qjtfsCh/CtCa+lDIIhLO1RbnMbwjdDmy3SwqjC2Zj8EQFBdoc3ZesYjbUJ
         +p4eGpDFEy2Ff7voal5EzpFlCrzm0k5d62GOI9S5bSRTHPPkUXHQKEqEBmAG8DvsR68c
         2INVSkaob0i+zZY28CFf8DJasjAP0VraMsZkc8FnEU2PmXjKx/BlbRosozuNtOOM0uKp
         OkpN76HJwSnu69DrthRTG8RK5zB/iuSihEVe6UwCbpVfgV1KpUh+ZZ/eZ6K5h05OzKmX
         cM9A==
X-Gm-Message-State: AOJu0Yxq7RFfMkcCXKFpW1uxvFn045n+EUzLwi0P+EaMZObsqp+tDyyb
        gP/yvFidq0+uvE+hEid06vVy3vG78vO6r2YtU3T27THdrkWFaheAztZ1t7AxuRP2lGKSz4HMfW+
        oxQPFAMeHp7sa4uEFERq6fol+Scq4Yppuo2IEHhOtLg==
X-Received: by 2002:a19:4359:0:b0:4f8:d385:41bd with SMTP id m25-20020a194359000000b004f8d38541bdmr110682lfj.8.1692297552324;
        Thu, 17 Aug 2023 11:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJHRFT1siW8UZCQGrmU6uj/U7AnLGRKgBpAukshZ1dxmC1RXgn+gE5RQG2Zb/ahcVSaEaUTXYhxNQeTDbt5jg=
X-Received: by 2002:a19:4359:0:b0:4f8:d385:41bd with SMTP id
 m25-20020a194359000000b004f8d38541bdmr110668lfj.8.1692297551910; Thu, 17 Aug
 2023 11:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230814211116.3224759-1-aahringo@redhat.com> <20230814211116.3224759-2-aahringo@redhat.com>
 <c049f33344990f74c2b88cc3279a913f6ff6f498.camel@kernel.org> <350395c8906f46ec4634392adb8a9e3927763ef1.camel@kernel.org>
In-Reply-To: <350395c8906f46ec4634392adb8a9e3927763ef1.camel@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 17 Aug 2023 14:39:00 -0400
Message-ID: <CAK-6q+iB9AWqbe-cJfHi=nRAsdxXQ_KjpZLd4Hsj1VEtj8CNHQ@mail.gmail.com>
Subject: Re: [RFCv2 1/7] lockd: fix race in async lock request handling
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Aug 15, 2023 at 2:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2023-08-15 at 13:49 -0400, Jeff Layton wrote:
> > On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > > This patch fixes a race in async lock request handling between adding
> > > the relevant struct nlm_block to nlm_blocked list after the request w=
as
> > > sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of =
the
> > > nlm_block in the nlm_blocked list. It could be that the async request=
 is
> > > completed before the nlm_block was added to the list. This would end
> > > in a -ENOENT and a kernel log message of "lockd: grant for unknown
> > > block".
> > >
> > > To solve this issue we add the nlm_block before the vfs_lock_file() c=
all
> > > to be sure it has been added when a possible nlmsvc_grant_deferred() =
is
> > > called. If the vfs_lock_file() results in an case when it wouldn't be
> > > added to nlm_blocked list, the nlm_block struct will be removed from
> > > this list again.
> > >
> > > The introducing of the new B_PENDING_CALLBACK nlm_block flag will han=
dle
> > > async lock requests on a pending lock requests as a retry on the call=
er
> > > level to hit the -EAGAIN case.
> > >
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c          | 100 ++++++++++++++++++++++++++--------=
--
> > >  include/linux/lockd/lockd.h |   2 +
> > >  2 files changed, 74 insertions(+), 28 deletions(-)
> > >
> > >
>
> [...]
>
> > > diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.=
h
> > > index f42594a9efe0..91f55458f5fc 100644
> > > --- a/include/linux/lockd/lockd.h
> > > +++ b/include/linux/lockd/lockd.h
> > > @@ -185,10 +185,12 @@ struct nlm_block {
> > >     struct nlm_file *       b_file;         /* file in question */
> > >     struct cache_req *      b_cache_req;    /* deferred request handl=
ing */
> > >     struct cache_deferred_req * b_deferred_req
> > > +   struct mutex            b_cb_mutex;     /* callback mutex */
> >
> > There is no mention at all of this new mutex in the changelog or
> > comments. It's not at all clear to me what this is intended to protect.
> > In general, with lockd being a single-threaded service, we want to avoi=
d
> > sleeping locks. This will need some clear justification.
> >
> > At a glance, it looks like you're trying to use this to hold
> > B_PENDING_CALLBACK steady while a lock request is being handled. That
> > suggests that you're using this mutex to serialize access to a section
> > of code and not one or more specific data structures. We usually like t=
o
> > avoid that sort of thing, since locks that protect arbitrary sections o=
f
> > code become difficult to work with over time.
> >
> > I'm going to go out on a limb here though and suggest that there is
> > probably a way to solve this problem that doesn't involve adding new
> > locks.
> >
> > >     unsigned int            b_flags;        /* block flags */
> > >  #define B_QUEUED           1       /* lock queued */
> > >  #define B_GOT_CALLBACK             2       /* got lock or conflictin=
g lock */
> > >  #define B_TIMED_OUT                4       /* filesystem too slow to=
 respond */
> > > +#define B_PENDING_CALLBACK 8       /* pending callback for lock requ=
est */
> > >  };
> > >
> > >  /*
> >
> > Do we need this new flag at all? It seems redundant. If we have a block
> > on the list, then it is sort of by definition "pending callback". If
> > it's not on the list anymore, then it's not. No?
> >
>
> Do we need anything more than a patch along these lines? Note that this
> is untested, so RFC:
>
> ---------------------8<-----------------------
>
> [RFC PATCH] lockd: alternate fix for race between deferred lock and grant
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/svclock.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..e9a84363c26e 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -446,6 +446,8 @@ nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct=
 nlm_block *block)
>
>         block->b_flags |=3D B_QUEUED;
>
> +       /* FIXME: remove and reinsert w/o dropping spinlock */
> +       nlmsvc_remove_block(block);
>         nlmsvc_insert_block(block, NLM_TIMEOUT);
>

a insert should just be okay, because there is an atomic switch if
it's already part of nlm_blocked and it will just update the timeout
of nlm_block in the list and it's order (because nlm_blocked is kind
of sorted according their timeouts in nlm_blocked).

>         block->b_cache_req =3D &rqstp->rq_chandle;
> @@ -535,6 +537,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>         if (!wait)
>                 lock->fl.fl_flags &=3D ~FL_SLEEP;
>         mode =3D lock_to_openmode(&lock->fl);
> +
> +       /* Append to list of blocked */
> +       nlmsvc_insert_block(block, NLM_NEVER);
>         error =3D vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, N=
ULL);
>         lock->fl.fl_flags &=3D ~FL_SLEEP;
>
> @@ -542,6 +547,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>         switch (error) {
>                 case 0:
>                         ret =3D nlm_granted;
> +                       nlmsvc_remove_block(block);
>                         goto out;
>                 case -EAGAIN:
>                         /*
> @@ -552,6 +558,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>                         if (wait)
>                                 break;
>                         ret =3D async_block ? nlm_lck_blocked : nlm_lck_d=
enied;
> +                       nlmsvc_remove_block(block);
>                         goto out;
>                 case FILE_LOCK_DEFERRED:
>                         if (wait)
> @@ -570,8 +577,6 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>
>         ret =3D nlm_lck_blocked;
>
> -       /* Append to list of blocked */
> -       nlmsvc_insert_block(block, NLM_NEVER);

ok. I will try to start with that.

- Alex

