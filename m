Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315F59E4F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiHWOK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 10:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiHWOKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:10:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48F25C339;
        Tue, 23 Aug 2022 04:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9354AB81CDC;
        Tue, 23 Aug 2022 11:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432BDC43470;
        Tue, 23 Aug 2022 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661253699;
        bh=2ao6tXty47TQNKzgsxWeZrE1PND4b4VmDqK7i8pWXi4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KcgeHCCGf2oqVuf5nC36z4oQ7oNV9xDDlGP/Xdlc3Uq5CTPTWJhgGl4h38+sPzx0n
         dcII81dHj7Jv5EedSigcUbMehGSx34w2BkU02KzVzYHoSdyOJVJlJHVZxGRdZd6MhP
         cDlr7/M4/z7lyZLT8Sz2wlsDSb+Rpu3QccHwNOaJa+YsuEEQjtvAk3ynAKtRQJPF81
         NuTMPFzWahrSSjgizhOeGByEHvx0j/SvTBiYUgsC42hJRg1mN295FHm0st9xEVVbnJ
         UIMb1V+D/yRvmo/9zTYppgFQZsofy3+OR313v3J+LpkXn+n2/tSl0vMZihzvgIyXmm
         4pj+ORnLwYLvw==
Message-ID: <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Tue, 23 Aug 2022 07:21:36 -0400
In-Reply-To: <20220822233231.GJ3600936@dread.disaster.area>
References: <20220822133309.86005-1-jlayton@kernel.org>
         <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
         <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
         <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
         <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
         <20220822233231.GJ3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-23 at 09:32 +1000, Dave Chinner wrote:
> On Mon, Aug 22, 2022 at 02:22:20PM -0400, Jeff Layton wrote:
> > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > index 3bfebde5a1a6..524abd372100 100644
> > --- a/include/linux/iversion.h
> > +++ b/include/linux/iversion.h
> > @@ -9,8 +9,8 @@
> >   * ---------------------------
> >   * The change attribute (i_version) is mandated by NFSv4 and is mostly=
 for
> >   * knfsd, but is also used for other purposes (e.g. IMA). The i_versio=
n must
> > - * appear different to observers if there was a change to the inode's =
data or
> > - * metadata since it was last queried.
> > + * appear different to observers if there was an explicit change to th=
e inode's
> > + * data or metadata since it was last queried.
> >   *
> >   * Observers see the i_version as a 64-bit number that never decreases=
. If it
> >   * remains the same since it was last checked, then nothing has change=
d in the
> > @@ -18,6 +18,13 @@
> >   * anything about the nature or magnitude of the changes from the valu=
e, only
> >   * that the inode has changed in some fashion.
> >   *
> > + * Note that atime updates due to reads or similar activity do not rep=
resent
>=20
> What does "or similar activity" mean?
>=20

Some examples:

- readdir() in a directory
- readlink() on symlink
- mmap reads

...basically, things that access data without materially changing it.

> This whole atime vs iversion issue is arising because "or any
> metadata change" was interpretted literally by filesystems to mean
> "any metadata change" without caveats or exclusions. Now you're both
> changing that definition and making things *worse* by adding
> explicit wiggle-room for future changes in behaviour to persistent
> change counter behaviour.
>=20
> iversion is going to be exposed to userspace, so we *can't change
> the definition in future* because behaviour is bound by "changes may
> break userspace apps" constraints. IOWs, we cannot justify changes
> in behaviour with "but there are only in-kernel users" like is being
> done for this change.
>=20
> It's only a matter of time before someone is going to complain about
> the fact that filesystems bump the change counter for internal
> metadata modifications as they make changes to the persistent state
> of data and metadata. These existing behaviours will almost
> certainly causes visible NFS quirks due to unexpected
> iversion bumps.
>=20
> In case you didn't realise, XFS can bump iversion 500+ times for a
> single 1MB write() on a 4kB block size filesytem, and only one of
> them is initial write() system call that copies the data into the
> page cache. The other 500+ are all the extent allocation and
> manipulation transactions that we might run when persisting the data
> to disk tens of seconds later. This is how iversion on XFS has
> behaved for the past decade.
>=20

Bumping the change count multiple times internally for a single change
is not a problem. From the comments in iversion.h:

 * Observers see the i_version as a 64-bit number that never decreases. If =
it
 * remains the same since it was last checked, then nothing has changed in =
the
 * inode. If it's different then something has changed. Observers cannot in=
fer
 * anything about the nature or magnitude of the changes from the value, on=
ly
 * that the inode has changed in some fashion.

Bumping it once or multiple times still conforms to how we have this
defined.

> Right now, both ext4 and XFS conform to the exact definition that is
> in this file. Trond has outlines that NFS wants iversion to behave
> exactly like c/mtime changes, but that is fundamentally different to
> how both ext4 and XFS have implemented the persistent change
> counters.
>=20
> IOWs, if we are going to start randomly excluding specific metadata
> from the iversion API, then we need a full definition of exactly
> what operations are supposed to trigger an iversion bump.
> API-design-by-application-deficiency-whack-a-mole is not appropriate
> for persistent structures, nor is it appropriate for information
> that is going to be exposed to userspace via the kernel ABI.
>=20
> Therefore, before we change behaviour in the filesystems or expose
> it to userspace, we need to define *exactly* what changes are
> covered by iversion. Once we have that definition, then we can
> modify the filesytems appropriately to follow the required
> definition and only change the persistent iversion counter when the
> definition says we should change it.
>=20
> While Trond's description is a useful definition from the
> application perspective - and I'm not opposed to making it behave
> like that (i.e. iversion only bumped with c/mtime changes) - it
> requires a fundamentally different implementation in filesystems.
>=20
> We must no longer capture *every metadata change* as we are
> currently doing as per the current specification, and instead only
> capture *application metadata changes* only.  i.e.  we are going to
> need an on-disk format change of some kind because the two
> behaviours are not compatible.
>=20
> Further, if iversion is going to be extended to userspace, we most
> definitely need to decouple it from our internal "change on every
> metadata change" behaviour. We change how we persist metadata to
> disk over time and if we don't abstract that away from the
> persistent change counter we expose to userspace then this will lead
> to random user visible changes in iversion behaviour in future.
>=20
> Any way I look at it, we're at the point where filesystems now need
> a real, fixed definition of what changes require an iversion bump
> and which don't. The other option is that move the iversion bumping
> completely up into the VFS where it happens consistently for every
> filesystem whether they persist it or not. We also need a set of
> test code for fstests that check that iversion performs as expected
> and to the specification that the VFS defines for statx.
>=20

I have an initial test for this that we can also build on on later. It
does require the patch to add support for STATX_INO_VERSION however.

> Either way we chose, one of these options are the only way that we
> will end up with a consistent implementation of a change counter
> across all the filesystems. And, quite frankly, that's exactly is
> needed if we are going to present this information to userspace
> forever more.
>=20

I agree that we need a real definition of what changes should be
represented in this value. My intent was to add that to the statx
manpage once we had gotten a little further along, but it won't hurt to
hash that out first.

I do not intend to exhaustively list all possible activities that should
and shouldn't update the i_version. It's as difficult to put together a
comprehensive list of what activities should and shouldn't change the
i_version as it is to list what activities should and shouldn't cause
the mtime/ctime/atime to change. The list is also going to constantly
change as our interfaces change.

What may be best is to just define this value in terms of how timestamps
get updated, since POSIX already specifies that. Section 4.9 in the
POSIX spec discusses file time updates:

    https://pubs.opengroup.org/onlinepubs/9699919799/

It says:

"Each function or utility in POSIX.1-2017 that reads or writes data
(even if the data does not change) or performs an operation to change
file status (even if the file status does not change) indicates which of
the appropriate timestamps shall be marked for update."

So, we can refer to that and simply say:

"If the function updates the mtime or ctime on the inode, then the
i_version should be incremented. If only the atime is being updated,
then the i_version should not be incremented. The exception to this rule
is explicit atime updates via utimes() or similar mechanism, which
should result in the i_version being incremented."

--=20
Jeff Layton <jlayton@kernel.org>
