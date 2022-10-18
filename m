Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A04603151
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJRREm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRREj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:04:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A38815FEA;
        Tue, 18 Oct 2022 10:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4D46164C;
        Tue, 18 Oct 2022 17:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E4FC433C1;
        Tue, 18 Oct 2022 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666112677;
        bh=YJWDrMhbcIWisNHk5urAJ3vnDg09Ogirqbnm9W046dc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SrXynS1vVzlKlaYFLs/yUh1M7C0sdbOVl+1mOkH6QGTR58B2rXGOGw15Nf7fJJCTz
         Sl1Ib5IidioiSr/Kn0ReV3fU4R4WaQ7aGFXsJo5nyi5IbVUnBkylKTvqU0OtG3g/+k
         PBctpSkonEd9447ffZRqoHgofe08PJPlIm9vAU/1nVYAUwOC3m9UUFOlfdRj+F812Q
         lFpGkM27qCYp/YY9mb6gfsteRgQMLZtN/m4BlEKlRZYUgzUMbHv4u/9T4/wgNJweEM
         fKvkPOLS2EQ+iU+EI779tui11BnGTKDIVH/3qUaITFbdOul0Sa2XAaX4JsvpzkCNpY
         GRovQtuRDCFzg==
Message-ID: <fcd35c14353ae859d778a23f80249047819bc4b0.camel@kernel.org>
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
Date:   Tue, 18 Oct 2022 13:04:34 -0400
In-Reply-To: <20221018151721.cl6dbupqjkkivxyf@quack3>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221017105709.10830-10-jlayton@kernel.org>
         <20221017221433.GT3600936@dread.disaster.area>
         <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
         <20221018134910.v4jim6jyjllykcaf@quack3>
         <28a3d6b9978cf0280961385e28ae52f278d65d92.camel@kernel.org>
         <20221018151721.cl6dbupqjkkivxyf@quack3>
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

On Tue, 2022-10-18 at 17:17 +0200, Jan Kara wrote:
> On Tue 18-10-22 10:21:08, Jeff Layton wrote:
> > On Tue, 2022-10-18 at 15:49 +0200, Jan Kara wrote:
> > > On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> > > > On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > > > > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > > > > Trond is of the opinion that monotonicity is a hard requirement=
, and
> > > > > > that we should not allow filesystems that can't provide that qu=
ality to
> > > > > > report STATX_VERSION at all.  His rationale is that one of the =
main uses
> > > > > > for this is for backup applications, and for those a counter th=
at could
> > > > > > go backward is worse than useless.
> > > > >=20
> > > > > From the perspective of a backup program doing incremental backup=
s,
> > > > > an inode with a change counter that has a different value to the
> > > > > current backup inventory means the file contains different
> > > > > information than what the current backup inventory holds. Again,
> > > > > snapshots, rollbacks, etc.
> > > > >=20
> > > > > Therefore, regardless of whether the change counter has gone
> > > > > forwards or backwards, the backup program needs to back up this
> > > > > current version of the file in this backup because it is differen=
t
> > > > > to the inventory copy.  Hence if the backup program fails to back=
 it
> > > > > up, it will not be creating an exact backup of the user's data at
> > > > > the point in time the backup is run...
> > > > >=20
> > > > > Hence I don't see that MONOTONIC is a requirement for backup
> > > > > programs - they really do have to be able to handle filesystems t=
hat
> > > > > have modifications that move backwards in time as well as forward=
s...
> > > >=20
> > > > Rolling backward is not a problem in and of itself. The big issue i=
s
> > > > that after a crash, we can end up with a change attr seen before th=
e
> > > > crash that is now associated with a completely different inode stat=
e.
> > > >=20
> > > > The scenario is something like:
> > > >=20
> > > > - Change attr for an empty file starts at 1
> > > >=20
> > > > - Write "A" to file, change attr goes to 2
> > > >=20
> > > > - Read and statx happens (client sees "A" with change attr 2)
> > > >=20
> > > > - Crash (before last change is logged to disk)
> > > >=20
> > > > - Machine reboots, inode is empty, change attr back to 1
> > > >=20
> > > > - Write "B" to file, change attr goes to 2
> > > >=20
> > > > - Client stat's file, sees change attr 2 and assumes its cache is
> > > > correct when it isn't (should be "B" not "A" now).
> > > >=20
> > > > The real danger comes not from the thing going backward, but the fa=
ct
> > > > that it can march forward again after going backward, and then the
> > > > client can see two different inode states associated with the same
> > > > change attr value. Jumping all the change attributes forward by a
> > > > significant amount after a crash should avoid this issue.
> > >=20
> > > As Dave pointed out, the problem with change attr having the same val=
ue for
> > > a different inode state (after going backwards) holds not only for th=
e
> > > crashes but also for restore from backups, fs snapshots, device snaps=
hots
> > > etc. So relying on change attr only looks a bit fragile. It works for=
 the
> > > common case but the edge cases are awkward and there's no easy way to
> > > detect you are in the edge case.
> > >=20
> >=20
> > This is true. In fact in the snapshot case you can't even rely on doing
> > anything at reboot since you won't necessarily need to reboot to make i=
t
> > roll backward.
> >=20
> > Whether that obviates the use of this value altogether, I'm not sure.
> >=20
> > > So I think any implementation caring about data integrity would have =
to
> > > include something like ctime into the picture anyway. Or we could jus=
t
> > > completely give up any idea of monotonicity and on each mount select =
random
> > > prime P < 2^64 and instead of doing inc when advancing the change
> > > attribute, we'd advance it by P. That makes collisions after restore =
/
> > > crash fairly unlikely.
> >=20
> > Part of the goal (at least for NFS) is to avoid unnecessary cache
> > invalidations.
> >=20
> > If we just increment it by a particular offset on every reboot, then
> > every time the server reboots, the clients will invalidate all of their
> > cached inodes, and proceed to hammer the server with READ calls just as
> > it's having to populate its own caches from disk.
>=20
> Note that I didn't propose to increment by offset on every reboot or moun=
t.
> I have proposed that inode_maybe_inc_iversion() would not increment
> i_version by 1 (in fact 1 << I_VERSION_QUERIED_SHIFT) but rather by P (or=
 P
> << I_VERSION_QUERIED_SHIFT) where P is a suitable number randomly selecte=
d
> on filesystem mount.
>=20
> This will not cause cache invalidation after a clean unmount + remount. I=
t
> will cause cache invalidation after a crash, snapshot rollback etc., only=
 for
> inodes where i_version changed. If P is suitably selected (e.g. as being =
a
> prime), then the chances of collisions (even after a snapshot rollback) a=
re
> very low (on the order of 2^(-50) if my piece of envelope calculations ar=
e
> right).
>
> So this should nicely deal with all the problems we've spotted so far. Bu=
t
> I may be missing something...


Got it! That makes a lot more sense. Thinking about this some more...

What sort of range for P would be suitable?

Every increment would need to be by (shifted) P, so we can't choose too
large a number. Queries are pretty rare vs. writes though, so that
mitigates the issue somewhat.

There are 31 primes between 1 and 127. Worst case, we'd still have 2^48
increments before the counter wraps.

Let me think about this some more, but maybe that's good enough to
ensure uniqueness.
--=20
Jeff Layton <jlayton@kernel.org>
