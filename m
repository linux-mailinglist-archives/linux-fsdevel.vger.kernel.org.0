Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515A6602963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 12:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJRKfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 06:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJRKfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CEF7C1BC;
        Tue, 18 Oct 2022 03:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F193461514;
        Tue, 18 Oct 2022 10:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E62C433C1;
        Tue, 18 Oct 2022 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666089318;
        bh=uk+2llSxw5KW7Yz/+41u4KeAVldLmNVnkBrffbF65JU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DCwdGL2rQp3pcs2wApnbM8vvlqVQPxWhPzYImyP+rG6jJUvQy2NydTlyLM0kQcNWA
         Jm7IKs95W9FL6/SuFVKvkclTfRIPPkdu8KexWvBFWvu4UkN3UW7Zicw1piIh5fZNwO
         SxUAOhKuhY5b8F1jDKpvjIwnVlyPNQUxlmQsSVirqK4sqmap5L3HgQZtKxT2lsOhaN
         SvVgS2l+Kc1rKGLrPBomjJX5DJpJKRax9IyzPTFS4rNLUGMcwjOdMnZ06D9SMzVgRC
         FmYYrzPPX4e46esPC1HpiwU5Lc4WVSJImKlWf1b46lu0plmhp/var5O5JaXPlFWSCJ
         Qdpy7SOGsSVYg==
Message-ID: <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
Subject: Re: [RFC PATCH v7 9/9] vfs: expose STATX_VERSION to userland
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Tue, 18 Oct 2022 06:35:14 -0400
In-Reply-To: <20221017221433.GT3600936@dread.disaster.area>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221017105709.10830-10-jlayton@kernel.org>
         <20221017221433.GT3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit inode
> > version attribute. When userland requests STATX_VERSION, copy the
> > value from the kstat struct there, and stop masking off
> > STATX_ATTR_VERSION_MONOTONIC.
>=20
> Can we please make the name more sepcific than "version"? It's way
> too generic and - we already have userspace facing "version" fields
> for inodes that refer to the on-disk format version exposed in
> various UAPIs. It's common for UAPI structures used for file
> operations to have a "version" field that refers to the *UAPI
> structure version* rather than file metadata or data being retrieved
> from the file in question.
>=20
> The need for an explanatory comment like this:
>=20
> > +	__u64	stx_version; /* Inode change attribute */
>=20
> demonstrates it is badly named. If you want it known as an inode
> change attribute, then don't name the variable "version". In
> reality, it really needs to be an opaque cookie, not something
> applications need to decode directly to make sense of.
>=20

Fair enough. I started with this being named stx_change_attr and other
people objected. I then changed to stx_ino_version, but the "_ino"
seemed redundant.

I'm open to suggestions here. Naming things like this is hard.

> > Update the test-statx sample program to output the change attr and
> > MountId.
> >=20
> > Reviewed-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/stat.c                 | 12 +++---------
> >  include/linux/stat.h      |  9 ---------
> >  include/uapi/linux/stat.h |  6 ++++--
> >  samples/vfs/test-statx.c  |  8 ++++++--
> >  4 files changed, 13 insertions(+), 22 deletions(-)
> >=20
> > Posting this as an RFC as we're still trying to sort out what semantics
> > we want to present to userland. In particular, this patch leaves the
> > problem of crash resilience in to userland applications on filesystems
> > that don't report as MONOTONIC.
>=20
> Firstly, if userspace wants to use the change attribute, they are
> going to have to detect crashes themselves anyway because no fs in
> the kernel can set the MONOTONIC flag right now and it may be years
> before kernels/filesystems actually support it in production
> systems.
>=20

We can turn it on today in CephFS, NFS and tmpfs. Maybe also btrfs
(modulo the issue you point out with snapshots, of course).

> But more fundamentally, I think this monotonic increase guarantee is
> completely broken by the presence of snapshots and snapshot
> rollbacks. If you change something, then a while later decide it
> broke (e.g. a production system upgrade went awry) and you roll back
> the filesystem to the pre-upgrade snapshot, then all the change
> counters and m/ctimes are guaranteed to go backwards because they
> will revert to the snapshot values. Maybe the filesystem can bump
> some internal counter for the snapshot when the revert happens, but
> until that is implemented, filesystems that support snapshots and
> rollback can't assert MONOTONIC.
>=20
> And that's worse for other filesystems, because if you put them on
> dm-thinp and roll them back, they are completely unaware of the fact
> that a rollback happened and there's *nothing* the filesystem can do
> about this. Indeed, snapshots are suppose to be done on clean
> filesystems so snapshot images don't require journal recovery, so
> any crash detection put in the filesystem recovery code to guarantee
> MONOTONIC behaviour will be soundly defeated by such block device
> snapshot rollbacks.
>=20
> Hence I think MONOTONIC is completely unworkable for most existing
> filesystems because snapshots and rollbacks completely break the
> underlying assumption MONOTONIC relies on: that filesystem
> modifications always move forwards in both the time and modification
> order dimensions....
>=20
> This means that monotonicity is probably not acheivable by any
> existing filesystem and so should not ever be mentioned in the UAPI.
> I think userspace semantics can be simplified down to "if the change
> cookie does not match exactly, caches are invalid" combined with
> "applications are responsible for detecting temporal discontiguities
> in filesystem presentation at start up (e.g. after a crash, unclean
> shutdown, restoration from backup, snapshot rollback, etc) for
> persistent cache invalidation purposes"....
>=20

I don't think we can make any sort of blanket statement about
monotonicity in the face of snapshots. Restoring a snapshot (or a backup
for that matter) means restoring the filesystem to a particular point in
time in the past. I think it's reasonable to expect that the change
attrs may roll backward in the face of these sorts of events.

> > Trond is of the opinion that monotonicity is a hard requirement, and
> > that we should not allow filesystems that can't provide that quality to
> > report STATX_VERSION at all.  His rationale is that one of the main use=
s
> > for this is for backup applications, and for those a counter that could
> > go backward is worse than useless.
>=20
> From the perspective of a backup program doing incremental backups,
> an inode with a change counter that has a different value to the
> current backup inventory means the file contains different
> information than what the current backup inventory holds. Again,
> snapshots, rollbacks, etc.
>=20
> Therefore, regardless of whether the change counter has gone
> forwards or backwards, the backup program needs to back up this
> current version of the file in this backup because it is different
> to the inventory copy.  Hence if the backup program fails to back it
> up, it will not be creating an exact backup of the user's data at
> the point in time the backup is run...
>=20
> Hence I don't see that MONOTONIC is a requirement for backup
> programs - they really do have to be able to handle filesystems that
> have modifications that move backwards in time as well as forwards...

Rolling backward is not a problem in and of itself. The big issue is
that after a crash, we can end up with a change attr seen before the
crash that is now associated with a completely different inode state.

The scenario is something like:

- Change attr for an empty file starts at 1

- Write "A" to file, change attr goes to 2

- Read and statx happens (client sees "A" with change attr 2)

- Crash (before last change is logged to disk)

- Machine reboots, inode is empty, change attr back to 1

- Write "B" to file, change attr goes to 2

- Client stat's file, sees change attr 2 and assumes its cache is
correct when it isn't (should be "B" not "A" now).

The real danger comes not from the thing going backward, but the fact
that it can march forward again after going backward, and then the
client can see two different inode states associated with the same
change attr value. Jumping all the change attributes forward by a
significant amount after a crash should avoid this issue.
--=20
Jeff Layton <jlayton@kernel.org>
