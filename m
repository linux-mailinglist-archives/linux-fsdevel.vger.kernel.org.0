Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B99D5F309F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJCNBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJCNBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:01:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D0341999;
        Mon,  3 Oct 2022 06:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7038CE0B9D;
        Mon,  3 Oct 2022 13:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6D4C433D6;
        Mon,  3 Oct 2022 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664802090;
        bh=mmTZgqg6FTmCB5EIX3Cw3VFcZPiIeeisIwOu8wf7Flg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gy2gEyLjXxxCj+YRLcI/UBObyUaFOtu6rsGoTbJkbxYcLSmQbmAsi6DCHZa3QTnal
         y9TV368Td0n+5rDoB8SO9t2CUsupMJhvZRc/Lbeq6y1AmUlKV5SwhGA/WlJ1Wirilo
         12eWfppfGDhxKxOHlXgFlYbdbP0VZaL/288GR6FEMLc4RKpZsu8HTn/iLsZ4HoDLTy
         ZBRptOFbaCgH4Piq9dH59gg9oybcy1H1h9cwsjOqcfmSDUfQRdprZOhw2/2FYni2Gc
         0yJqcSw03Kh8hnclHe6AAxUqRVOXJsBwgqq6A1BrGKZKZmyBHL+/JJXp9rGtqsKlWk
         +wTXnwnmq7Emw==
Message-ID: <df91b9ec61bc49aa5330714e3319dcea2531953b.camel@kernel.org>
Subject: Re: [PATCH v6 8/9] vfs: update times after copying data in
 __generic_file_write_iter
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Mon, 03 Oct 2022 09:01:26 -0400
In-Reply-To: <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com>
References: <20220930111840.10695-1-jlayton@kernel.org>
         <20220930111840.10695-9-jlayton@kernel.org>
         <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-10-02 at 10:08 +0300, Amir Goldstein wrote:
> On Fri, Sep 30, 2022 at 2:30 PM Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > The c/mtime and i_version currently get updated before the data is
> > copied (or a DIO write is issued), which is problematic for NFS.
> >=20
> > READ+GETATTR can race with a write (even a local one) in such a way as
> > to make the client associate the state of the file with the wrong chang=
e
> > attribute. That association can persist indefinitely if the file sees n=
o
> > further changes.
> >=20
> > Move the setting of times to the bottom of the function in
> > __generic_file_write_iter and only update it if something was
> > successfully written.
> >=20
>=20
> This solution is wrong for several reasons:
>=20
> 1. There is still file_update_time() in ->page_mkwrite() so you haven't
>     solved the problem completely

Right. I don't think there is a way to solve the problem vs. mmap.
Userland can write to a writeable mmap'ed page at any time and we'd
never know. We have to specifically carve out mmap as an exception here.
I'll plan to add something to the manpage patch for this.

> 2. The other side of the coin is that post crash state is more likely to =
end
>     up data changes without mtime/ctime change
>=20

Is this really something filesystems rely on? I suppose the danger is
that some cached data gets written to disk before the write returns and
the inode on disk never gets updated.

But...isn't that a danger now? Some of the cached data could get written
out and the updated inode just never makes it to disk before a crash
(AFAIU). I'm not sure that this increases our exposure to that problem.


> If I read the problem description correctly, then a solution that invalid=
ates
> the NFS cache before AND after the write would be acceptable. Right?
> Would an extra i_version bump after the write solve the race?
>=20

I based this patch on Neil's assertion that updating the time before an
operation was pointless if we were going to do it afterward. The NFS
client only really cares about seeing it change after a write.

Doing both would be fine from a correctness standpoint, and in most
cases, the second would be a no-op anyway since a query would have to
race in between the two for that to happen.

FWIW, I think we should update the m/ctime and version at the same time.
If the version changes, then there is always the potential that a timer
tick has occurred. So, that would translate to a second call to
file_update_time in here.

The downside of bumping the times/version both before and after is that
these are hot codepaths, and we'd be adding extra operations there. Even
in the case where nothing has changed, we'd have to call
inode_needs_update_time a second time for every write. Is that worth the
cost?

> > If the time update fails, log a warning once, but don't fail the write.
> > All of the existing callers use update_time functions that don't fail,
> > so we should never trip this.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  mm/filemap.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 15800334147b..72c0ceb75176 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3812,10 +3812,6 @@ ssize_t __generic_file_write_iter(struct kiocb *=
iocb, struct iov_iter *from)
> >         if (err)
> >                 goto out;
> >=20
> > -       err =3D file_update_time(file);
> > -       if (err)
> > -               goto out;
> > -
> >         if (iocb->ki_flags & IOCB_DIRECT) {
> >                 loff_t pos, endbyte;
> >=20
> > @@ -3868,6 +3864,19 @@ ssize_t __generic_file_write_iter(struct kiocb *=
iocb, struct iov_iter *from)
> >                         iocb->ki_pos +=3D written;
> >         }
> >  out:
> > +       if (written > 0) {
> > +               err =3D file_update_time(file);
> > +               /*
> > +                * There isn't much we can do at this point if updating=
 the
> > +                * times fails after a successful write. The times and =
i_version
> > +                * should still be updated in the inode, and it should =
still be
> > +                * marked dirty, so hopefully the next inode update wil=
l catch it.
> > +                * Log a warning once so we have a record that somethin=
g untoward
> > +                * has occurred.
> > +                */
> > +               WARN_ONCE(err, "Failed to update m/ctime after write: %=
ld\n", err);
>=20
> pr_warn_once() please - this is not a programming assertion.
>=20

ACK. I'll change that.

--=20
Jeff Layton <jlayton@kernel.org>
