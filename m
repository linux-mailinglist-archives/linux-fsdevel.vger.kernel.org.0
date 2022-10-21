Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B16074A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJUKIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUKIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:08:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C2254377;
        Fri, 21 Oct 2022 03:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75A34B82B70;
        Fri, 21 Oct 2022 10:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD70CC433D6;
        Fri, 21 Oct 2022 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666346928;
        bh=2F4dRy5658azcXTDib97tTv5rIuyaUyEY86NPcEOLks=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l7iG//KubJ+3RD2UWVtRORHfEsTPu7FK7d68jThN69NP16jcfx1LpNr10EW+d4Nkp
         5M+qeCr3DcZeyTVOHdn6NXg+2CHqCQqC2YDN253p+gGrw8UVhCDFgrFo0raajWQWec
         zX861hH/GShse06fhfpZUp84A8YC6sYoK5m4TwShC1Kd1AM2PpeDNe8ky7s2bObs03
         1TLnlh1ayA8R1xjXh5k64DQR2hhdGEi7Uw5FFNyOG7DufDyBD2HBVQb996fJIAh+gC
         xLwklZ3XDORpniRhfyUG7puJp+JUwL7CqkIo2oawHOm0c7yEJTKHDQZ1XUYMQ0h0yE
         DUbev1MLY5LFA==
Message-ID: <955ec675bdba32111127866dc8e30ed8372f5806.camel@kernel.org>
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
Date:   Fri, 21 Oct 2022 06:08:44 -0400
In-Reply-To: <20221020103952.qvmala6kcaunvqtd@quack3>
References: <20221017105709.10830-1-jlayton@kernel.org>
         <20221017105709.10830-10-jlayton@kernel.org>
         <20221017221433.GT3600936@dread.disaster.area>
         <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
         <20221018134910.v4jim6jyjllykcaf@quack3>
         <28a3d6b9978cf0280961385e28ae52f278d65d92.camel@kernel.org>
         <20221018151721.cl6dbupqjkkivxyf@quack3>
         <fcd35c14353ae859d778a23f80249047819bc4b0.camel@kernel.org>
         <20221019172339.f5dxek5yjposst5g@quack3>
         <f9bf8cf8b3270cbaa9ab1b2240aecaf6aad61ce9.camel@kernel.org>
         <20221020103952.qvmala6kcaunvqtd@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-10-20 at 12:39 +0200, Jan Kara wrote:
> On Wed 19-10-22 14:47:48, Jeff Layton wrote:
> > On Wed, 2022-10-19 at 19:23 +0200, Jan Kara wrote:
> > > On Tue 18-10-22 13:04:34, Jeff Layton wrote:
> > > > On Tue, 2022-10-18 at 17:17 +0200, Jan Kara wrote:
> > > > > On Tue 18-10-22 10:21:08, Jeff Layton wrote:
> > > > > > On Tue, 2022-10-18 at 15:49 +0200, Jan Kara wrote:
> > > > > > > On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> > > > > > > > On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > > > > > > > > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wro=
te:
> > > > > > > > > > Trond is of the opinion that monotonicity is a hard req=
uirement, and
> > > > > > > > > > that we should not allow filesystems that can't provide=
 that quality to
> > > > > > > > > > report STATX_VERSION at all.  His rationale is that one=
 of the main uses
> > > > > > > > > > for this is for backup applications, and for those a co=
unter that could
> > > > > > > > > > go backward is worse than useless.
> > > > > > > > >=20
> > > > > > > > > From the perspective of a backup program doing incrementa=
l backups,
> > > > > > > > > an inode with a change counter that has a different value=
 to the
> > > > > > > > > current backup inventory means the file contains differen=
t
> > > > > > > > > information than what the current backup inventory holds.=
 Again,
> > > > > > > > > snapshots, rollbacks, etc.
> > > > > > > > >=20
> > > > > > > > > Therefore, regardless of whether the change counter has g=
one
> > > > > > > > > forwards or backwards, the backup program needs to back u=
p this
> > > > > > > > > current version of the file in this backup because it is =
different
> > > > > > > > > to the inventory copy.  Hence if the backup program fails=
 to back it
> > > > > > > > > up, it will not be creating an exact backup of the user's=
 data at
> > > > > > > > > the point in time the backup is run...
> > > > > > > > >=20
> > > > > > > > > Hence I don't see that MONOTONIC is a requirement for bac=
kup
> > > > > > > > > programs - they really do have to be able to handle files=
ystems that
> > > > > > > > > have modifications that move backwards in time as well as=
 forwards...
> > > > > > > >=20
> > > > > > > > Rolling backward is not a problem in and of itself. The big=
 issue is
> > > > > > > > that after a crash, we can end up with a change attr seen b=
efore the
> > > > > > > > crash that is now associated with a completely different in=
ode state.
> > > > > > > >=20
> > > > > > > > The scenario is something like:
> > > > > > > >=20
> > > > > > > > - Change attr for an empty file starts at 1
> > > > > > > >=20
> > > > > > > > - Write "A" to file, change attr goes to 2
> > > > > > > >=20
> > > > > > > > - Read and statx happens (client sees "A" with change attr =
2)
> > > > > > > >=20
> > > > > > > > - Crash (before last change is logged to disk)
> > > > > > > >=20
> > > > > > > > - Machine reboots, inode is empty, change attr back to 1
> > > > > > > >=20
> > > > > > > > - Write "B" to file, change attr goes to 2
> > > > > > > >=20
> > > > > > > > - Client stat's file, sees change attr 2 and assumes its ca=
che is
> > > > > > > > correct when it isn't (should be "B" not "A" now).
> > > > > > > >=20
> > > > > > > > The real danger comes not from the thing going backward, bu=
t the fact
> > > > > > > > that it can march forward again after going backward, and t=
hen the
> > > > > > > > client can see two different inode states associated with t=
he same
> > > > > > > > change attr value. Jumping all the change attributes forwar=
d by a
> > > > > > > > significant amount after a crash should avoid this issue.
> > > > > > >=20
> > > > > > > As Dave pointed out, the problem with change attr having the =
same value for
> > > > > > > a different inode state (after going backwards) holds not onl=
y for the
> > > > > > > crashes but also for restore from backups, fs snapshots, devi=
ce snapshots
> > > > > > > etc. So relying on change attr only looks a bit fragile. It w=
orks for the
> > > > > > > common case but the edge cases are awkward and there's no eas=
y way to
> > > > > > > detect you are in the edge case.
> > > > > > >=20
> > > > > >=20
> > > > > > This is true. In fact in the snapshot case you can't even rely =
on doing
> > > > > > anything at reboot since you won't necessarily need to reboot t=
o make it
> > > > > > roll backward.
> > > > > >=20
> > > > > > Whether that obviates the use of this value altogether, I'm not=
 sure.
> > > > > >=20
> > > > > > > So I think any implementation caring about data integrity wou=
ld have to
> > > > > > > include something like ctime into the picture anyway. Or we c=
ould just
> > > > > > > completely give up any idea of monotonicity and on each mount=
 select random
> > > > > > > prime P < 2^64 and instead of doing inc when advancing the ch=
ange
> > > > > > > attribute, we'd advance it by P. That makes collisions after =
restore /
> > > > > > > crash fairly unlikely.
> > > > > >=20
> > > > > > Part of the goal (at least for NFS) is to avoid unnecessary cac=
he
> > > > > > invalidations.
> > > > > >=20
> > > > > > If we just increment it by a particular offset on every reboot,=
 then
> > > > > > every time the server reboots, the clients will invalidate all =
of their
> > > > > > cached inodes, and proceed to hammer the server with READ calls=
 just as
> > > > > > it's having to populate its own caches from disk.
> > > > >=20
> > > > > Note that I didn't propose to increment by offset on every reboot=
 or mount.
> > > > > I have proposed that inode_maybe_inc_iversion() would not increme=
nt
> > > > > i_version by 1 (in fact 1 << I_VERSION_QUERIED_SHIFT) but rather =
by P (or P
> > > > > << I_VERSION_QUERIED_SHIFT) where P is a suitable number randomly=
 selected
> > > > > on filesystem mount.
> > > > >=20
> > > > > This will not cause cache invalidation after a clean unmount + re=
mount. It
> > > > > will cause cache invalidation after a crash, snapshot rollback et=
c., only for
> > > > > inodes where i_version changed. If P is suitably selected (e.g. a=
s being a
> > > > > prime), then the chances of collisions (even after a snapshot rol=
lback) are
> > > > > very low (on the order of 2^(-50) if my piece of envelope calcula=
tions are
> > > > > right).
> > > > >=20
> > > > > So this should nicely deal with all the problems we've spotted so=
 far. But
> > > > > I may be missing something...
> > > >=20
> > > >=20
> > > > Got it! That makes a lot more sense. Thinking about this some more.=
..
> > > >=20
> > > > What sort of range for P would be suitable?
> > > >=20
> > > > Every increment would need to be by (shifted) P, so we can't choose=
 too
> > > > large a number. Queries are pretty rare vs. writes though, so that
> > > > mitigates the issue somewhat.
> > >=20
> > > Well, I agree that for large P the counter would wrap earlier. But is=
 that
> > > a problem? Note that if P is a prime (indivisible by 2 is enough), th=
en the
> > > counter would get to already used value still only after 2^63 steps. =
Thus if
> > > we give up monotonicity and just treat the counter as an opaque cooki=
e, we
> > > do not have to care about wrapping.
> > >=20
> > > Sure given different P is selected for each mount the wrapping argume=
nt
> > > does not hold 100% but here comes the advantage of primes - if you ha=
ve two
> > > different primes P and Q, then a collision means that k*P mod 2^63 =
=3D l*Q
> > > mod 2^63 and that holds for exactly one pair k,l from 1..2^63 range. =
So the
> > > chances of early collision even after selecting a different prime on =
each
> > > mount are *very* low.
> >=20
> > I think we'll have to start avoiding 1 as a value for P if we do this,
> > but the rest makes sense.  I like this idea, Jan!
>=20
> Yes, 1 is kind of special so we should better avoid it in this scheme.
> Especially if we're going to select only smaller primes.
>=20
> > > So I think we should select from a relatively large set of primes so =
that
> > > the chance of randomly selecting the same prime (and thus reissuing t=
he
> > > same change attr for different inode state sometime later) are small.
> > >=20
> >=20
> > Monotonicity allows you to discard "old" attr updates. For instance,
> > sometimes a NFS GETATTR response may be delayed for various reasons. If
> > the client sees a change attr that is provably older than one it has
> > already seen, it can discard the update. So, there is value in servers
> > advertising that property, and NFSv4.2 has a way to do that.
> >=20
> > The Linux NFS client (at least) uses the same trick we do with jiffies
> > to handle wrapping for MONOTONIC values. We should be able to advertise
> > MONOTONIC as long as the client isn't comparing values that are more
> > than ~2^62 apart.=20
> >=20
> > Once we start talking about applications storing these values for
> > incremental backups, then the time between checks could be very long.
> >=20
> > So, I think we don't want _too_ large a value for P. The big question i=
s
> > how many individual change attr increments do we need to account for?
> >=20
> > We have 64 bits total (it's an atomic64_t). We consume the lowest bit
> > for the QUERIED flag. That leaves us 63 bits of counter (currently).
> > When we increment by a larger value, we're effectively decreasing the
> > size of the counter.
>=20
> Yes, the larger value of P we take the sooner it will wrap which defeats
> comparisons attempting to establish any ordering of change cookie values.
>=20
> > Let's assume a worst case of one increment per microsecond, interleaved
> > by queries (so that they have to be real increments). 2^48 microseconds
> > is close to 9 years.
> >=20
> > That leaves 15 bits for the P, which is primes from 3..32749. Is that a
> > large enough pool of prime numbers?
>=20
> Well, there are ~3000 primes in this range so that gives you a 1/3000
> chance that after a crash, backup restore, snapshot rollback etc. you wil=
l
> pick the same prime which results in collisions of change cookies and thu=
s
> possibility of data corruption. Is that low enough chance? The events I
> mention above should be relatively rare but given the number of machines
> running this code I would think the collision is bound to happen and the
> consequences could be ... unpleasant. That's why I would prefer to pick
> primes at least say upto 1m (there are ~78k of those). But that makes
> wrapping more frequent (~100 days with 1us update period). Probably still
> usable for NFS but not really for backup purposes. So I'm not sure we
> should be advertising the values have any ordering.
>=20

Ok. I'll aim for using values between 3 and 1M and see how that looks.
We should be able to tune this to some degree as well.

> If the last used value would be persisted (e.g. in the filesystem's
> superblock), we could easily make sure the next selected P is different s=
o
> in that case we could get away with a smaller set of primes but it would
> require filesystem on-disk format changes which has its own drawbacks. Bu=
t
> that would be at least some path forward for providing change cookies tha=
t
> can be ordered on larger timescales.
>=20

Persisting just the last one might not be sufficient. If the machine
crashes several times then you could still end up re-using the same P
value. i_version is only incremented on changes, so if you're unlucky
and it's only incremented again when the duplicate value of P comes up,
you're back to the same problem. We might want to keep a record of the
last several P values?

OTOH, there is always going to be _some_ way to defeat this. At some
point we just have to decide that a scenario is unlikely enough that we
can ignore it.
=20
> > It looks like the kernel already has some infrastructure for handling
> > primes in lib/math/prime_numbers.c. We could just select a global P
> > value to use on every reboot, or just have filesystems set their own
> > (maybe in a new field in the superblock?)
>=20
> IMO P needs to be selected on each mount to reliably solve the "restore
> from backup" and "snapshot rollback" scenarios. I agree it can be a new
> field in the VFS part of the superblock so that it is accessible by the
> iversion handling code.
>=20

Sounds good. FWIW, I think I'm going to have to approach this in at
least three patchsets:

1) clean up the presentation of the value, and plumb it through struct
kstat (aiming for v6.2 for this part).

2) start incrementing the value after a write in addition to, or instead
of before a write. (I have patches for tmpfs, ext4 and btrfs -- maybe
v6.3?)

3) change the increment to use a prime number we select at mount time to
ward off rollback issues. (still scoping out this part)

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
