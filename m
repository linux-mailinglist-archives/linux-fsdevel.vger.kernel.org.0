Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65136DA02A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbjDFSqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240279AbjDFSqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA87A83;
        Thu,  6 Apr 2023 11:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A19564B0D;
        Thu,  6 Apr 2023 18:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC39C433EF;
        Thu,  6 Apr 2023 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806769;
        bh=ioBTux9TyKxfDLourbPnWQ5D6ISPpHzr8NS+3yBHlTY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bC0DqFg1Q469ljKPrnDlNud/O/dFS4scOSrf/DNuvFDizr1PmcliZrRe1Z6yUa+rd
         PK7cLno/SNN5bs4YWswe3GmAkXspVORvC3H7VGoI2IU8CwOuyOM2yePHsOpq6UMYWu
         DcSere1OmVCG5DudND7Xbe6CBDbqUJKhu6HCeglWzAThoMa5WMZVe4oF7S8ltv/Q4i
         WHseoGksdyxqHT7MjKTHsEhCjVhuwFxbGHW8PLiFzwI98XVc6f1N+CRJ/bwOEXApOP
         pinKALRl5k/2P+RNaQlPXml7QizG6QBjGwlqohcEF0QNi5sTj8NqGWDVIt3k4oqDl4
         TbW6SlS3fAlAw==
Message-ID: <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Date:   Thu, 06 Apr 2023 14:46:07 -0400
In-Reply-To: <20230406-wasser-zwanzig-791bc0bf416c@brauner>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
         <20230406-diffamieren-langhaarig-87511897e77d@brauner>
         <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
         <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
         <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
         <20230406-wasser-zwanzig-791bc0bf416c@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > On Thu, Apr 6, 2023 at 10:20=E2=80=AFAM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> > > On 4/6/23 10:05, Paul Moore wrote:
> > > > On Thu, Apr 6, 2023 at 6:26=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > > > On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
> > > > > > Overlayfs fails to notify IMA / EVM about file content modifica=
tions
> > > > > > and therefore IMA-appraised files may execute even though their=
 file
> > > > > > signature does not validate against the changed hash of the fil=
e
> > > > > > anymore. To resolve this issue, add a call to integrity_notify_=
change()
> > > > > > to the ovl_release() function to notify the integrity subsystem=
 about
> > > > > > file changes. The set flag triggers the re-evaluation of the fi=
le by
> > > > > > IMA / EVM once the file is accessed again.
> > > > > >=20
> > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > ---
> > > > > >   fs/overlayfs/file.c       |  4 ++++
> > > > > >   include/linux/integrity.h |  6 ++++++
> > > > > >   security/integrity/iint.c | 13 +++++++++++++
> > > > > >   3 files changed, 23 insertions(+)
> > > > > >=20
> > > > > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > > > > index 6011f955436b..19b8f4bcc18c 100644
> > > > > > --- a/fs/overlayfs/file.c
> > > > > > +++ b/fs/overlayfs/file.c
> > > > > > @@ -13,6 +13,7 @@
> > > > > >   #include <linux/security.h>
> > > > > >   #include <linux/mm.h>
> > > > > >   #include <linux/fs.h>
> > > > > > +#include <linux/integrity.h>
> > > > > >   #include "overlayfs.h"
> > > > > >=20
> > > > > >   struct ovl_aio_req {
> > > > > > @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, st=
ruct file *file)
> > > > > >=20
> > > > > >   static int ovl_release(struct inode *inode, struct file *file=
)
> > > > > >   {
> > > > > > +     if (file->f_flags & O_ACCMODE)
> > > > > > +             integrity_notify_change(inode);
> > > > > > +
> > > > > >        fput(file->private_data);
> > > > > >=20
> > > > > >        return 0;
> > > > > > diff --git a/include/linux/integrity.h b/include/linux/integrit=
y.h
> > > > > > index 2ea0f2f65ab6..cefdeccc1619 100644
> > > > > > --- a/include/linux/integrity.h
> > > > > > +++ b/include/linux/integrity.h
> > > > > > @@ -23,6 +23,7 @@ enum integrity_status {
> > > > > >   #ifdef CONFIG_INTEGRITY
> > > > > >   extern struct integrity_iint_cache *integrity_inode_get(struc=
t inode *inode);
> > > > > >   extern void integrity_inode_free(struct inode *inode);
> > > > > > +extern void integrity_notify_change(struct inode *inode);
> > > > >=20
> > > > > I thought we concluded that ima is going to move into the securit=
y hook
> > > > > infrastructure so it seems this should be a proper LSM hook?
> > > >=20
> > > > We are working towards migrating IMA/EVM to the LSM layer, but ther=
e
> > > > are a few things we need to fix/update/remove first; if anyone is
> > > > curious, you can join the LSM list as we've been discussing some of
> > > > these changes this week.  Bug fixes like this should probably remai=
n
> > > > as IMA/EVM calls for the time being, with the understanding that th=
ey
> > > > will migrate over with the rest of IMA/EVM.
> > > >=20
> > > > That said, we should give Mimi a chance to review this patch as it =
is
> > > > possible there is a different/better approach.  A bit of patience m=
ay
> > > > be required as I know Mimi is very busy at the moment.
> > >=20
> > > There may be a better approach actually by increasing the inode's i_v=
ersion,
> > > which then should trigger the appropriate path in ima_check_last_writ=
er().
> >=20
> > I'm not the VFS/inode expert here, but I thought the inode's i_version
> > field was only supposed to be bumped when the inode metadata changed,
> > not necessarily the file contents, right?
> >=20

No. The i_version should change any time there is a "deliberate change"
to the file. That can be to the data or metadata, but it has to be in
response to some sort of deliberate, observable change -- something that
would cause an mtime or ctime change.

In practice, the i_version changes whenever the ctime changes, as
changing the mtime also changes the ctime.

> > That said, overlayfs is a bit different so maybe that's okay, but I
> > think we would need to hear from the VFS folks if this is acceptable.
>=20
> Ccing Jeff for awareness since he did the i_version rework a short time a=
go.
>=20
> The documentation in include/linux/iversion.h states:
>=20
>  * [...] The i_version must
>  * appear larger to observers if there was an explicit change to the inod=
e's
>  * data or metadata since it was last queried.
>=20
> what I'm less sure in all of this is why this is called in ovl_release() =
and
> whether it's correct to increment the overlayfs inode's i_version.
>

Yeah, not sure what's special about doing this on close(). Seems like
someone could just hold the file open to prevent triggering the
remeasurement?

> The change is done to the inode of the copied up/modified file's inode in=
 the
> upper layer. So the i_version should already be incremented when we call =
into
> the upper layer usually via vfs_*() methods.

Correct. As long as IMA is also measuring the upper inode then it seems
like you shouldn't need to do anything special here.

What sort of fs are you using for the upper layer?
--=20
Jeff Layton <jlayton@kernel.org>
