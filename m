Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F4605D94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiJTKkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiJTKkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:40:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7B6C74E;
        Thu, 20 Oct 2022 03:40:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4F2921B4B;
        Thu, 20 Oct 2022 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666262400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwE/a6H95V8ROTUwZIoEwT+wVGrjdLINiXvreyvYoDM=;
        b=hRugjiRHkSerjTXAqA2+0FJlVCFNbK2oxI4Bm4DAxMm9OfonJYX/z4CqsblkpIAbIjiCW2
        2kNSSGoJJP8oHXWfcWr6qOd77BJ+rHPFuaJA3le021YpDkr5NYKiOwPephEApQpZqceJ5R
        vqaNJ2bR6yp6GBbT/lZO0ymJhM+Xwe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666262400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwE/a6H95V8ROTUwZIoEwT+wVGrjdLINiXvreyvYoDM=;
        b=XNq0aStld2IOrmdcjGxNp0gVq3NIZ8gDJjXVliB1k2tPl9dZ93yGnN/bRZSUl4CKw/i0Kq
        U9z00G1tnyC2DECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 644E513AF5;
        Thu, 20 Oct 2022 10:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AzV6GIAlUWP3ZAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 20 Oct 2022 10:40:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BDEF6A06F2; Thu, 20 Oct 2022 12:39:52 +0200 (CEST)
Date:   Thu, 20 Oct 2022 12:39:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, bfields@fieldses.org, brauner@kernel.org,
        fweimer@redhat.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v7 9/9] vfs: expose STATX_VERSION to userland
Message-ID: <20221020103952.qvmala6kcaunvqtd@quack3>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bf8cf8b3270cbaa9ab1b2240aecaf6aad61ce9.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-10-22 14:47:48, Jeff Layton wrote:
> On Wed, 2022-10-19 at 19:23 +0200, Jan Kara wrote:
> > On Tue 18-10-22 13:04:34, Jeff Layton wrote:
> > > On Tue, 2022-10-18 at 17:17 +0200, Jan Kara wrote:
> > > > On Tue 18-10-22 10:21:08, Jeff Layton wrote:
> > > > > On Tue, 2022-10-18 at 15:49 +0200, Jan Kara wrote:
> > > > > > On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> > > > > > > On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > > > > > > > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > > > > > > > Trond is of the opinion that monotonicity is a hard requirement, and
> > > > > > > > > that we should not allow filesystems that can't provide that quality to
> > > > > > > > > report STATX_VERSION at all.  His rationale is that one of the main uses
> > > > > > > > > for this is for backup applications, and for those a counter that could
> > > > > > > > > go backward is worse than useless.
> > > > > > > > 
> > > > > > > > From the perspective of a backup program doing incremental backups,
> > > > > > > > an inode with a change counter that has a different value to the
> > > > > > > > current backup inventory means the file contains different
> > > > > > > > information than what the current backup inventory holds. Again,
> > > > > > > > snapshots, rollbacks, etc.
> > > > > > > > 
> > > > > > > > Therefore, regardless of whether the change counter has gone
> > > > > > > > forwards or backwards, the backup program needs to back up this
> > > > > > > > current version of the file in this backup because it is different
> > > > > > > > to the inventory copy.  Hence if the backup program fails to back it
> > > > > > > > up, it will not be creating an exact backup of the user's data at
> > > > > > > > the point in time the backup is run...
> > > > > > > > 
> > > > > > > > Hence I don't see that MONOTONIC is a requirement for backup
> > > > > > > > programs - they really do have to be able to handle filesystems that
> > > > > > > > have modifications that move backwards in time as well as forwards...
> > > > > > > 
> > > > > > > Rolling backward is not a problem in and of itself. The big issue is
> > > > > > > that after a crash, we can end up with a change attr seen before the
> > > > > > > crash that is now associated with a completely different inode state.
> > > > > > > 
> > > > > > > The scenario is something like:
> > > > > > > 
> > > > > > > - Change attr for an empty file starts at 1
> > > > > > > 
> > > > > > > - Write "A" to file, change attr goes to 2
> > > > > > > 
> > > > > > > - Read and statx happens (client sees "A" with change attr 2)
> > > > > > > 
> > > > > > > - Crash (before last change is logged to disk)
> > > > > > > 
> > > > > > > - Machine reboots, inode is empty, change attr back to 1
> > > > > > > 
> > > > > > > - Write "B" to file, change attr goes to 2
> > > > > > > 
> > > > > > > - Client stat's file, sees change attr 2 and assumes its cache is
> > > > > > > correct when it isn't (should be "B" not "A" now).
> > > > > > > 
> > > > > > > The real danger comes not from the thing going backward, but the fact
> > > > > > > that it can march forward again after going backward, and then the
> > > > > > > client can see two different inode states associated with the same
> > > > > > > change attr value. Jumping all the change attributes forward by a
> > > > > > > significant amount after a crash should avoid this issue.
> > > > > > 
> > > > > > As Dave pointed out, the problem with change attr having the same value for
> > > > > > a different inode state (after going backwards) holds not only for the
> > > > > > crashes but also for restore from backups, fs snapshots, device snapshots
> > > > > > etc. So relying on change attr only looks a bit fragile. It works for the
> > > > > > common case but the edge cases are awkward and there's no easy way to
> > > > > > detect you are in the edge case.
> > > > > > 
> > > > > 
> > > > > This is true. In fact in the snapshot case you can't even rely on doing
> > > > > anything at reboot since you won't necessarily need to reboot to make it
> > > > > roll backward.
> > > > > 
> > > > > Whether that obviates the use of this value altogether, I'm not sure.
> > > > > 
> > > > > > So I think any implementation caring about data integrity would have to
> > > > > > include something like ctime into the picture anyway. Or we could just
> > > > > > completely give up any idea of monotonicity and on each mount select random
> > > > > > prime P < 2^64 and instead of doing inc when advancing the change
> > > > > > attribute, we'd advance it by P. That makes collisions after restore /
> > > > > > crash fairly unlikely.
> > > > > 
> > > > > Part of the goal (at least for NFS) is to avoid unnecessary cache
> > > > > invalidations.
> > > > > 
> > > > > If we just increment it by a particular offset on every reboot, then
> > > > > every time the server reboots, the clients will invalidate all of their
> > > > > cached inodes, and proceed to hammer the server with READ calls just as
> > > > > it's having to populate its own caches from disk.
> > > > 
> > > > Note that I didn't propose to increment by offset on every reboot or mount.
> > > > I have proposed that inode_maybe_inc_iversion() would not increment
> > > > i_version by 1 (in fact 1 << I_VERSION_QUERIED_SHIFT) but rather by P (or P
> > > > << I_VERSION_QUERIED_SHIFT) where P is a suitable number randomly selected
> > > > on filesystem mount.
> > > > 
> > > > This will not cause cache invalidation after a clean unmount + remount. It
> > > > will cause cache invalidation after a crash, snapshot rollback etc., only for
> > > > inodes where i_version changed. If P is suitably selected (e.g. as being a
> > > > prime), then the chances of collisions (even after a snapshot rollback) are
> > > > very low (on the order of 2^(-50) if my piece of envelope calculations are
> > > > right).
> > > > 
> > > > So this should nicely deal with all the problems we've spotted so far. But
> > > > I may be missing something...
> > > 
> > > 
> > > Got it! That makes a lot more sense. Thinking about this some more...
> > > 
> > > What sort of range for P would be suitable?
> > > 
> > > Every increment would need to be by (shifted) P, so we can't choose too
> > > large a number. Queries are pretty rare vs. writes though, so that
> > > mitigates the issue somewhat.
> > 
> > Well, I agree that for large P the counter would wrap earlier. But is that
> > a problem? Note that if P is a prime (indivisible by 2 is enough), then the
> > counter would get to already used value still only after 2^63 steps. Thus if
> > we give up monotonicity and just treat the counter as an opaque cookie, we
> > do not have to care about wrapping.
> > 
> > Sure given different P is selected for each mount the wrapping argument
> > does not hold 100% but here comes the advantage of primes - if you have two
> > different primes P and Q, then a collision means that k*P mod 2^63 = l*Q
> > mod 2^63 and that holds for exactly one pair k,l from 1..2^63 range. So the
> > chances of early collision even after selecting a different prime on each
> > mount are *very* low.
> 
> I think we'll have to start avoiding 1 as a value for P if we do this,
> but the rest makes sense.  I like this idea, Jan!

Yes, 1 is kind of special so we should better avoid it in this scheme.
Especially if we're going to select only smaller primes.

> > So I think we should select from a relatively large set of primes so that
> > the chance of randomly selecting the same prime (and thus reissuing the
> > same change attr for different inode state sometime later) are small.
> > 
> 
> Monotonicity allows you to discard "old" attr updates. For instance,
> sometimes a NFS GETATTR response may be delayed for various reasons. If
> the client sees a change attr that is provably older than one it has
> already seen, it can discard the update. So, there is value in servers
> advertising that property, and NFSv4.2 has a way to do that.
> 
> The Linux NFS client (at least) uses the same trick we do with jiffies
> to handle wrapping for MONOTONIC values. We should be able to advertise
> MONOTONIC as long as the client isn't comparing values that are more
> than ~2^62 apart. 
> 
> Once we start talking about applications storing these values for
> incremental backups, then the time between checks could be very long.
> 
> So, I think we don't want _too_ large a value for P. The big question is
> how many individual change attr increments do we need to account for?
> 
> We have 64 bits total (it's an atomic64_t). We consume the lowest bit
> for the QUERIED flag. That leaves us 63 bits of counter (currently).
> When we increment by a larger value, we're effectively decreasing the
> size of the counter.

Yes, the larger value of P we take the sooner it will wrap which defeats
comparisons attempting to establish any ordering of change cookie values.

> Let's assume a worst case of one increment per microsecond, interleaved
> by queries (so that they have to be real increments). 2^48 microseconds
> is close to 9 years.
> 
> That leaves 15 bits for the P, which is primes from 3..32749. Is that a
> large enough pool of prime numbers?

Well, there are ~3000 primes in this range so that gives you a 1/3000
chance that after a crash, backup restore, snapshot rollback etc. you will
pick the same prime which results in collisions of change cookies and thus
possibility of data corruption. Is that low enough chance? The events I
mention above should be relatively rare but given the number of machines
running this code I would think the collision is bound to happen and the
consequences could be ... unpleasant. That's why I would prefer to pick
primes at least say upto 1m (there are ~78k of those). But that makes
wrapping more frequent (~100 days with 1us update period). Probably still
usable for NFS but not really for backup purposes. So I'm not sure we
should be advertising the values have any ordering.

If the last used value would be persisted (e.g. in the filesystem's
superblock), we could easily make sure the next selected P is different so
in that case we could get away with a smaller set of primes but it would
require filesystem on-disk format changes which has its own drawbacks. But
that would be at least some path forward for providing change cookies that
can be ordered on larger timescales.

> It looks like the kernel already has some infrastructure for handling
> primes in lib/math/prime_numbers.c. We could just select a global P
> value to use on every reboot, or just have filesystems set their own
> (maybe in a new field in the superblock?)

IMO P needs to be selected on each mount to reliably solve the "restore
from backup" and "snapshot rollback" scenarios. I agree it can be a new
field in the VFS part of the superblock so that it is accessible by the
iversion handling code.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
