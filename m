Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E6602E48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJROV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiJROVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED51F9C2EE;
        Tue, 18 Oct 2022 07:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88413615AE;
        Tue, 18 Oct 2022 14:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B23C433D6;
        Tue, 18 Oct 2022 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666102872;
        bh=55bQHB+WjSBUXWHhVZsz39JliyTH3ce5NbGUN3TOoiM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tr45N7iF0mc2KUeRnM9/A9JhZd7/U22GyrFHvEUutjRjJCh5j0QCmmGK88a6JcXsN
         nbMNqjvE54H5AijupL1GbiE+fXuIo/OL+lWmzdR0WdIX0HPTw89uf7uUSP6dj3Cd3u
         bunQ1S5EVPlBqX1d7pyW6bkWTc5+N1xqieGOiwyAlv/gSZ+7s3ICZzwV52Mnx6xw5i
         QlMUsCeQdO8sEYkRgNDAulTaRiEDnqM17XTMA9HxnFOcKuVCdi3+fbiVvShLN0tVjY
         YCbtm+/blYEIoQnoZCxModsrkU1bSheNwrkkJGYnP5Wlqev2DkJQ5i80qdKjoHLPvv
         p/ee7Equqs9Dw==
Message-ID: <28a3d6b9978cf0280961385e28ae52f278d65d92.camel@kernel.org>
Subject: Re: [RFC PATCH v7 9/9] vfs: expose STATX_VERSION to userland
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, bfields@fieldses.org, brauner@kernel.org,
        fweimer@redhat.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Tue, 18 Oct 2022 10:21:08 -0400
In-Reply-To: <20221018134910.v4jim6jyjllykcaf@quack3>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221017105709.10830-10-jlayton@kernel.org>
         <20221017221433.GT3600936@dread.disaster.area>
         <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
         <20221018134910.v4jim6jyjllykcaf@quack3>
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

On Tue, 2022-10-18 at 15:49 +0200, Jan Kara wrote:
> On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> > On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > > Trond is of the opinion that monotonicity is a hard requirement, an=
d
> > > > that we should not allow filesystems that can't provide that qualit=
y to
> > > > report STATX_VERSION at all.  His rationale is that one of the main=
 uses
> > > > for this is for backup applications, and for those a counter that c=
ould
> > > > go backward is worse than useless.
> > >=20
> > > From the perspective of a backup program doing incremental backups,
> > > an inode with a change counter that has a different value to the
> > > current backup inventory means the file contains different
> > > information than what the current backup inventory holds. Again,
> > > snapshots, rollbacks, etc.
> > >=20
> > > Therefore, regardless of whether the change counter has gone
> > > forwards or backwards, the backup program needs to back up this
> > > current version of the file in this backup because it is different
> > > to the inventory copy.  Hence if the backup program fails to back it
> > > up, it will not be creating an exact backup of the user's data at
> > > the point in time the backup is run...
> > >=20
> > > Hence I don't see that MONOTONIC is a requirement for backup
> > > programs - they really do have to be able to handle filesystems that
> > > have modifications that move backwards in time as well as forwards...
> >=20
> > Rolling backward is not a problem in and of itself. The big issue is
> > that after a crash, we can end up with a change attr seen before the
> > crash that is now associated with a completely different inode state.
> >=20
> > The scenario is something like:
> >=20
> > - Change attr for an empty file starts at 1
> >=20
> > - Write "A" to file, change attr goes to 2
> >=20
> > - Read and statx happens (client sees "A" with change attr 2)
> >=20
> > - Crash (before last change is logged to disk)
> >=20
> > - Machine reboots, inode is empty, change attr back to 1
> >=20
> > - Write "B" to file, change attr goes to 2
> >=20
> > - Client stat's file, sees change attr 2 and assumes its cache is
> > correct when it isn't (should be "B" not "A" now).
> >=20
> > The real danger comes not from the thing going backward, but the fact
> > that it can march forward again after going backward, and then the
> > client can see two different inode states associated with the same
> > change attr value. Jumping all the change attributes forward by a
> > significant amount after a crash should avoid this issue.
>=20
> As Dave pointed out, the problem with change attr having the same value f=
or
> a different inode state (after going backwards) holds not only for the
> crashes but also for restore from backups, fs snapshots, device snapshots
> etc. So relying on change attr only looks a bit fragile. It works for the
> common case but the edge cases are awkward and there's no easy way to
> detect you are in the edge case.
>=20

This is true. In fact in the snapshot case you can't even rely on doing
anything at reboot since you won't necessarily need to reboot to make it
roll backward.

Whether that obviates the use of this value altogether, I'm not sure.

> So I think any implementation caring about data integrity would have to
> include something like ctime into the picture anyway. Or we could just
> completely give up any idea of monotonicity and on each mount select rand=
om
> prime P < 2^64 and instead of doing inc when advancing the change
> attribute, we'd advance it by P. That makes collisions after restore /
> crash fairly unlikely.

Part of the goal (at least for NFS) is to avoid unnecessary cache
invalidations.

If we just increment it by a particular offset on every reboot, then
every time the server reboots, the clients will invalidate all of their
cached inodes, and proceed to hammer the server with READ calls just as
it's having to populate its own caches from disk.

IOW, that will not be good for performance. Doing that after a crash is
also less than ideal, but crashes should (hopefully) be rare enough that
it's not a major issue.

In any case, we need to decide whether and what to present to userland.
There is a lot of disagreement here, and we need to come to a consensus.
I think we have to answer 2 questions:

1/ Is this counter useful enough on its own, without any baked-in
rollback=A0resilience to justify exposing it via statx()?

2/ if the answer above is "yes", then is there any value to the
MONOTONIC flag, given that we can't really do anything about snapshot
rollbacks and the like?

I tend to be in the camp of "let's make the raw counter available and
leave it up to userland to deal with the potential issues". After all,
the c/mtime are still widely used today to detect changes and they have
many of the same problems.

Trying to do anything more elaborate than that will lead to a lot of
extra complexity in the kernel, and make it a lot more difficult for any
filesystem to report this at all.
--=20
Jeff Layton <jlayton@kernel.org>
