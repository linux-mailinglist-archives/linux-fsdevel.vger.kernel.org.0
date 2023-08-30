Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90CD78DBD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbjH3Shy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244702AbjH3Nqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A1107;
        Wed, 30 Aug 2023 06:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C4BF62644;
        Wed, 30 Aug 2023 13:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025A4C433C8;
        Wed, 30 Aug 2023 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693403189;
        bh=M3S4ULSzV0rQcR545KOciYQ0SZPxCkvzOHG2fj4EpUw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PDYIPoqyNRkkbiEG4FvBOlh3ObTWvh+pB0ntD7ubfQbfKyHeT5EPRTbGmUD+Drxs8
         IyKToBKbufA8RlMdsq/gM4+Vy2INylYfGJBMLANtZLtZGDav4UjphQpTyOfB4Bna/P
         RQSvkhDyNyhGud9Wz95aypfDCLmqJ8VylPqSUz3E3Hmov/SgfS2VdzUhqAvU4niPiU
         GIB8lcSWQ+u/8dAvGPs0iVuT4PiMYdiXr4b6utnT+vpG7YicV2zv2Kd0nKNBy+OMM/
         M7CSNkKUpBwjayg9fRKRhU69A/khN44OEPmyV7ilf8RKd95sARgpfFCokhw9LMfe5R
         1qljU49WbtFFQ==
Message-ID: <35f7ca6a61b0e90a537badf2bea056b76b75cb12.camel@kernel.org>
Subject: Re: [PATCH 6/7] dlm: use FL_SLEEP to determine blocking vs
 non-blocking
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Date:   Wed, 30 Aug 2023 09:46:26 -0400
In-Reply-To: <CAK-6q+i+j1TUmWGH+fdYHix5TwujH8_kuR5ayUv9h6Ah8OQecQ@mail.gmail.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
         <20230823213352.1971009-7-aahringo@redhat.com>
         <9a8ead64cdd32fdad29cae3aff0bd447f33a32c2.camel@kernel.org>
         <CAK-6q+i+j1TUmWGH+fdYHix5TwujH8_kuR5ayUv9h6Ah8OQecQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-30 at 08:38 -0400, Alexander Aring wrote:
> Hi,
>=20
> On Fri, Aug 25, 2023 at 2:18=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Wed, 2023-08-23 at 17:33 -0400, Alexander Aring wrote:
> > > This patch uses the FL_SLEEP flag in struct file_lock to determine if
> > > the lock request is a blocking or non-blocking request. Before dlm wa=
s
> > > using IS_SETLKW() was being used which is not usable for lock request=
s
> > > coming from lockd when EXPORT_OP_SAFE_ASYNC_LOCK inside the export fl=
ags
> > > is set.
> > >=20
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/dlm/plock.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> > > index 0094fa4004cc..0c6ed5eeb840 100644
> > > --- a/fs/dlm/plock.c
> > > +++ b/fs/dlm/plock.c
> > > @@ -140,7 +140,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u6=
4 number, struct file *file,
> > >       op->info.optype         =3D DLM_PLOCK_OP_LOCK;
> > >       op->info.pid            =3D fl->fl_pid;
> > >       op->info.ex             =3D (fl->fl_type =3D=3D F_WRLCK);
> > > -     op->info.wait           =3D IS_SETLKW(cmd);
> > > +     op->info.wait           =3D !!(fl->fl_flags & FL_SLEEP);
> > >       op->info.fsid           =3D ls->ls_global_id;
> > >       op->info.number         =3D number;
> > >       op->info.start          =3D fl->fl_start;
> >=20
> > Not sure you really need the !!, but ok...
> >=20
>=20
> The wait is a byte value and FL_SLEEP doesn't fit into it, I already
> run into problems with it. I don't think somebody does a if (foo->wait
> =3D=3D 1) but it should be set to 1 or 0.
>=20

AIUI, any halfway decent compiler should take the result of the &, and
implicitly cast that properly to bool. Basically, any value other than 0
should be true.

If the compiler just blindly casts the lowest byte though, then you do
need the double-negative.

> An alternative would be: ((fl->fl_flags & FL_SLEEP) =3D=3D FL_SLEEP). I a=
m
> not sure what the coding style says here. I think it's more important
> what the C standard says about !!(condition), but there are other
> users of this in the Linux kernel. :-/

I don't care too much either way, but my understanding was that you
don't need to do the !! trick in most cases with modern compilers.
--=20
Jeff Layton <jlayton@kernel.org>
