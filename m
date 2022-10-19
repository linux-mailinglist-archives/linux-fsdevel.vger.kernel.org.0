Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA78604FDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJSSsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJSSsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:48:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E6F1D4DCE;
        Wed, 19 Oct 2022 11:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9884DB82367;
        Wed, 19 Oct 2022 18:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E55C433C1;
        Wed, 19 Oct 2022 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666205272;
        bh=GPpbTre2g5cDF/zcnvgO/KJyQaXL+MdmczIdSGdHW44=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IxsCIq6dqKs0z7CWbFKSMyEjQyIdK+3CpQuAUFMdxyxr21fHUipX9XkCNUiG0TprJ
         8T7QdyaHYaSYy+w3ZvpvjP6NS7//ZSCmaWFuR0I3H9lFRXKRxFZSqRN+n72kuEOdD3
         KFQvybYDT1y9IUAi47FyACp5A1RJoVC0PCAuH2ivSMsOZRgouGp1lmNt2X/Pu9Ea4P
         zGbsalh5ijNnx/m0vS9Hpl5CA6GJ+3lQbMibyXto2HYeoR9xzd76jU9Qf9ScpHifW7
         /bD75CCbg5uKxcykrVVKZ6rwttQ3CBhirxOXJszp7O+E65L7JFWvr93pROCfvJsK7L
         cRDyLVvRnhGZg==
Message-ID: <f9bf8cf8b3270cbaa9ab1b2240aecaf6aad61ce9.camel@kernel.org>
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
Date:   Wed, 19 Oct 2022 14:47:48 -0400
In-Reply-To: <20221019172339.f5dxek5yjposst5g@quack3>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221017105709.10830-10-jlayton@kernel.org>
         <20221017221433.GT3600936@dread.disaster.area>
         <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
         <20221018134910.v4jim6jyjllykcaf@quack3>
         <28a3d6b9978cf0280961385e28ae52f278d65d92.camel@kernel.org>
         <20221018151721.cl6dbupqjkkivxyf@quack3>
         <fcd35c14353ae859d778a23f80249047819bc4b0.camel@kernel.org>
         <20221019172339.f5dxek5yjposst5g@quack3>
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

On Wed, 2022-10-19 at 19:23 +0200, Jan Kara wrote:
> On Tue 18-10-22 13:04:34, Jeff Layton wrote:
> > On Tue, 2022-10-18 at 17:17 +0200, Jan Kara wrote:
> > > On Tue 18-10-22 10:21:08, Jeff Layton wrote:
> > > > On Tue, 2022-10-18 at 15:49 +0200, Jan Kara wrote:
> > > > > On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> > > > > > On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > > > > > > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > > > > > > Trond is of the opinion that monotonicity is a hard require=
ment, and
> > > > > > > > that we should not allow filesystems that can't provide tha=
t quality to
> > > > > > > > report STATX_VERSION at all.  His rationale is that one of =
the main uses
> > > > > > > > for this is for backup applications, and for those a counte=
r that could
> > > > > > > > go backward is worse than useless.
> > > > > > >=20
> > > > > > > From the perspective of a backup program doing incremental ba=
ckups,
> > > > > > > an inode with a change counter that has a different value to =
the
> > > > > > > current backup inventory means the file contains different
> > > > > > > information than what the current backup inventory holds. Aga=
in,
> > > > > > > snapshots, rollbacks, etc.
> > > > > > >=20
> > > > > > > Therefore, regardless of whether the change counter has gone
> > > > > > > forwards or backwards, the backup program needs to back up th=
is
> > > > > > > current version of the file in this backup because it is diff=
erent
> > > > > > > to the inventory copy.  Hence if the backup program fails to =
back it
> > > > > > > up, it will not be creating an exact backup of the user's dat=
a at
> > > > > > > the point in time the backup is run...
> > > > > > >=20
> > > > > > > Hence I don't see that MONOTONIC is a requirement for backup
> > > > > > > programs - they really do have to be able to handle filesyste=
ms that
> > > > > > > have modifications that move backwards in time as well as for=
wards...
> > > > > >=20
> > > > > > Rolling backward is not a problem in and of itself. The big iss=
ue is
> > > > > > that after a crash, we can end up with a change attr seen befor=
e the
> > > > > > crash that is now associated with a completely different inode =
state.
> > > > > >=20
> > > > > > The scenario is something like:
> > > > > >=20
> > > > > > - Change attr for an empty file starts at 1
> > > > > >=20
> > > > > > - Write "A" to file, change attr goes to 2
> > > > > >=20
> > > > > > - Read and statx happens (client sees "A" with change attr 2)
> > > > > >=20
> > > > > > - Crash (before last change is logged to disk)
> > > > > >=20
> > > > > > - Machine reboots, inode is empty, change attr back to 1
> > > > > >=20
> > > > > > - Write "B" to file, change attr goes to 2
> > > > > >=20
> > > > > > - Client stat's file, sees change attr 2 and assumes its cache =
is
> > > > > > correct when it isn't (should be "B" not "A" now).
> > > > > >=20
> > > > > > The real danger comes not from the thing going backward, but th=
e fact
> > > > > > that it can march forward again after going backward, and then =
the
> > > > > > client can see two different inode states associated with the s=
ame
> > > > > > change attr value. Jumping all the change attributes forward by=
 a
> > > > > > significant amount after a crash should avoid this issue.
> > > > >=20
> > > > > As Dave pointed out, the problem with change attr having the same=
 value for
> > > > > a different inode state (after going backwards) holds not only fo=
r the
> > > > > crashes but also for restore from backups, fs snapshots, device s=
napshots
> > > > > etc. So relying on change attr only looks a bit fragile. It works=
 for the
> > > > > common case but the edge cases are awkward and there's no easy wa=
y to
> > > > > detect you are in the edge case.
> > > > >=20
> > > >=20
> > > > This is true. In fact in the snapshot case you can't even rely on d=
oing
> > > > anything at reboot since you won't necessarily need to reboot to ma=
ke it
> > > > roll backward.
> > > >=20
> > > > Whether that obviates the use of this value altogether, I'm not sur=
e.
> > > >=20
> > > > > So I think any implementation caring about data integrity would h=
ave to
> > > > > include something like ctime into the picture anyway. Or we could=
 just
> > > > > completely give up any idea of monotonicity and on each mount sel=
ect random
> > > > > prime P < 2^64 and instead of doing inc when advancing the change
> > > > > attribute, we'd advance it by P. That makes collisions after rest=
ore /
> > > > > crash fairly unlikely.
> > > >=20
> > > > Part of the goal (at least for NFS) is to avoid unnecessary cache
> > > > invalidations.
> > > >=20
> > > > If we just increment it by a particular offset on every reboot, the=
n
> > > > every time the server reboots, the clients will invalidate all of t=
heir
> > > > cached inodes, and proceed to hammer the server with READ calls jus=
t as
> > > > it's having to populate its own caches from disk.
> > >=20
> > > Note that I didn't propose to increment by offset on every reboot or =
mount.
> > > I have proposed that inode_maybe_inc_iversion() would not increment
> > > i_version by 1 (in fact 1 << I_VERSION_QUERIED_SHIFT) but rather by P=
 (or P
> > > << I_VERSION_QUERIED_SHIFT) where P is a suitable number randomly sel=
ected
> > > on filesystem mount.
> > >=20
> > > This will not cause cache invalidation after a clean unmount + remoun=
t. It
> > > will cause cache invalidation after a crash, snapshot rollback etc., =
only for
> > > inodes where i_version changed. If P is suitably selected (e.g. as be=
ing a
> > > prime), then the chances of collisions (even after a snapshot rollbac=
k) are
> > > very low (on the order of 2^(-50) if my piece of envelope calculation=
s are
> > > right).
> > >=20
> > > So this should nicely deal with all the problems we've spotted so far=
. But
> > > I may be missing something...
> >=20
> >=20
> > Got it! That makes a lot more sense. Thinking about this some more...
> >=20
> > What sort of range for P would be suitable?
> >=20
> > Every increment would need to be by (shifted) P, so we can't choose too
> > large a number. Queries are pretty rare vs. writes though, so that
> > mitigates the issue somewhat.
>=20
> Well, I agree that for large P the counter would wrap earlier. But is tha=
t
> a problem? Note that if P is a prime (indivisible by 2 is enough), then t=
he
> counter would get to already used value still only after 2^63 steps. Thus=
 if
> we give up monotonicity and just treat the counter as an opaque cookie, w=
e
> do not have to care about wrapping.
>=20
> Sure given different P is selected for each mount the wrapping argument
> does not hold 100% but here comes the advantage of primes - if you have t=
wo
> different primes P and Q, then a collision means that k*P mod 2^63 =3D l*=
Q
> mod 2^63 and that holds for exactly one pair k,l from 1..2^63 range. So t=
he
> chances of early collision even after selecting a different prime on each
> mount are *very* low.
>=20

I think we'll have to start avoiding 1 as a value for P if we do this,
but the rest makes sense.  I like this idea, Jan!
=20
> So I think we should select from a relatively large set of primes so that
> the chance of randomly selecting the same prime (and thus reissuing the
> same change attr for different inode state sometime later) are small.
>=20

Monotonicity allows you to discard "old" attr updates. For instance,
sometimes a NFS GETATTR response may be delayed for various reasons. If
the client sees a change attr that is provably older than one it has
already seen, it can discard the update. So, there is value in servers
advertising that property, and NFSv4.2 has a way to do that.

The Linux NFS client (at least) uses the same trick we do with jiffies
to handle wrapping for MONOTONIC values. We should be able to advertise
MONOTONIC as long as the client isn't comparing values that are more
than ~2^62 apart.=20

Once we start talking about applications storing these values for
incremental backups, then the time between checks could be very long.

So, I think we don't want _too_ large a value for P. The big question is
how many individual change attr increments do we need to account for?

We have 64 bits total (it's an atomic64_t). We consume the lowest bit
for the QUERIED flag. That leaves us 63 bits of counter (currently).
When we increment by a larger value, we're effectively decreasing the
size of the counter.

Let's assume a worst case of one increment per microsecond, interleaved
by queries (so that they have to be real increments). 2^48 microseconds
is close to 9 years.

That leaves 15 bits for the P, which is primes from 3..32749. Is that a
large enough pool of prime numbers?

It looks like the kernel already has some infrastructure for handling
primes in lib/math/prime_numbers.c. We could just select a global P
value to use on every reboot, or just have filesystems set their own
(maybe in a new field in the superblock?)
--=20
Jeff Layton <jlayton@kernel.org>
