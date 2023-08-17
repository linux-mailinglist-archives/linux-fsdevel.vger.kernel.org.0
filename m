Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA677F540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350282AbjHQL3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 07:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350286AbjHQL2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23335A6;
        Thu, 17 Aug 2023 04:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB3963A9C;
        Thu, 17 Aug 2023 11:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395D4C433C8;
        Thu, 17 Aug 2023 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692271626;
        bh=9Ojc89bAceI3xd3nVBraloFpYM1DzVIS/nQgf1ocSPA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z9iRVJM57VueMJFBoy+aWwtClCz6bODvBuOPUBoRDfLUeMIUoCfzI1ZUoOv/5wARU
         LTsKZz/bw2ZL44C7P8XmECzCmKsCcQV9dllsUZVFijXwtMyl5Zrzn6mgRXrj25v4/i
         q4CsYTGHLpQdB1mSKPo94twYtKtCIFfHhvMmSAiGHrRM0ox5MbZfDEHCS6rvWPjxxg
         orf2+Rc678STe4b7riNlS0B5aFBlpz4/pgalELQXNmQ1/VrSdvY3A1JprQH/2NP3IP
         kBAVnJM2YUsml625Z1iO4VdBjXLTgUzSdw9kGqdJwgTx/xIhIUzaPYj2iScswdHgh+
         uOSKbQ15nf6lA==
Message-ID: <bb8806020ade39f6db9d209b0a4a34dc4d69bdb8.camel@kernel.org>
Subject: Re: [RFCv2 6/7] dlm: use FL_SLEEP to check if blocking request
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Thu, 17 Aug 2023 07:27:04 -0400
In-Reply-To: <CAK-6q+i3oKN3M_kdoQ99hMnzSZyRH1sPdxZ0MQMwp+vSixUhwg@mail.gmail.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
         <20230814211116.3224759-7-aahringo@redhat.com>
         <bd76489a6b0d2f56f4a68d48b3736fcaf5b5119b.camel@kernel.org>
         <CAK-6q+i3oKN3M_kdoQ99hMnzSZyRH1sPdxZ0MQMwp+vSixUhwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-16 at 21:19 -0400, Alexander Aring wrote:
> Hi,
>=20
> On Wed, Aug 16, 2023 at 9:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Mon, 2023-08-14 at 17:11 -0400, Alexander Aring wrote:
> > > This patch uses the FL_SLEEP flag in struct file_lock to check if it'=
s a
> > > blocking request in case if the request coming from nfs lockd process
> > > indicated by lm_grant() is set.
> > >=20
> > > IF FL_SLEEP is set a asynchronous blocking request is being made and
> > > it's waiting for lm_grant() callback being called to signal the lock =
was
> > > granted. If it's not set a synchronous non-blocking request is being =
made.
> > >=20
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/dlm/plock.c | 38 ++++++++++++++++++++++----------------
> > >  1 file changed, 22 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > > index 0094fa4004cc..524771002a2f 100644
> > > --- a/fs/dlm/plock.c
> > > +++ b/fs/dlm/plock.c
> > > @@ -140,7 +140,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u6=
4 number, struct file *file,
> > >       op->info.optype         =3D DLM_PLOCK_OP_LOCK;
> > >       op->info.pid            =3D fl->fl_pid;
> > >       op->info.ex             =3D (fl->fl_type =3D=3D F_WRLCK);
> > > -     op->info.wait           =3D IS_SETLKW(cmd);
> > >       op->info.fsid           =3D ls->ls_global_id;
> > >       op->info.number         =3D number;
> > >       op->info.start          =3D fl->fl_start;
> > > @@ -148,24 +147,31 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, =
u64 number, struct file *file,
> > >       op->info.owner =3D (__u64)(long)fl->fl_owner;
> > >       /* async handling */
> > >       if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
> > > -             op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS);
> > > -             if (!op_data) {
> > > -                     dlm_release_plock_op(op);
> > > -                     rv =3D -ENOMEM;
> > > -                     goto out;
> > > -             }
> > > +             if (fl->fl_flags & FL_SLEEP) {
> > > +                     op_data =3D kzalloc(sizeof(*op_data), GFP_NOFS)=
;
> > > +                     if (!op_data) {
> > > +                             dlm_release_plock_op(op);
> > > +                             rv =3D -ENOMEM;
> > > +                             goto out;
> > > +                     }
> > >=20
> > > -             op_data->callback =3D fl->fl_lmops->lm_grant;
> > > -             locks_init_lock(&op_data->flc);
> > > -             locks_copy_lock(&op_data->flc, fl);
> > > -             op_data->fl             =3D fl;
> > > -             op_data->file   =3D file;
> > > +                     op->info.wait =3D 1;
> > > +                     op_data->callback =3D fl->fl_lmops->lm_grant;
> > > +                     locks_init_lock(&op_data->flc);
> > > +                     locks_copy_lock(&op_data->flc, fl);
> > > +                     op_data->fl             =3D fl;
> > > +                     op_data->file   =3D file;
> > >=20
> > > -             op->data =3D op_data;
> > > +                     op->data =3D op_data;
> > >=20
> > > -             send_op(op);
> > > -             rv =3D FILE_LOCK_DEFERRED;
> > > -             goto out;
> > > +                     send_op(op);
> > > +                     rv =3D FILE_LOCK_DEFERRED;
> > > +                     goto out;
> >=20
> > A question...we're returning FILE_LOCK_DEFERRED after the DLM request i=
s
> > sent. If it ends up being blocked, what happens? Does it do a lm_grant
> > downcall with -EAGAIN or something as the result?
> >=20
>=20
> no, when info->wait is set then it is a blocked lock request, which
> means lm_grant() will be called when the lock request is granted.
>=20

Ok, that's probably problematic with the current code too. lockd will
time out the block after 7s, so if the lock isn't granted in that time
it'll give up on it.

> >=20
> > > +             } else {
> > > +                     op->info.wait =3D 0;
> > > +             }
> > > +     } else {
> > > +             op->info.wait =3D IS_SETLKW(cmd);
> > >       }
> > >=20
> > >       send_op(op);
> >=20
> > Looks reasonable overall.
> >=20
> > Now that I look, we have quite a number of places in the kernel that
> > seem to check for F_SETLKW, when what they really want is to check
> > FL_SLEEP.
>=20
> Yes, so far I understand FL_SLEEP is F_SETLKW when you get only
> F_SETLK in case of fl->fl_lmops && fl->fl_lmops->lm_grant is true. It
> is confusing but this is how it works... if it's not set we will get
> F_SETLKW and this should imply FL_SLEEP is set.
>=20
>=20

Yeah. Might be good to consider how to make this more consistent across
the kernel.
--=20
Jeff Layton <jlayton@kernel.org>
