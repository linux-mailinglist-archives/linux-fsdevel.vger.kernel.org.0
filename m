Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CE604E8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiJSRXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 13:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJSRXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:23:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB19F191D7E;
        Wed, 19 Oct 2022 10:23:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92A2E1F962;
        Wed, 19 Oct 2022 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666200220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBLt6q8KXfJFLr7EVMsuPkUznxswdTgkCJUV+ihP7yk=;
        b=i5kB35BR3upviPoVK/txtf5k6fvvZqh97WJbApv7JQ9lgcsCo8iYvqX8WWFKxbhiOrD/U3
        SwGu8H2HAX+kUGQT77uRq35XOlX23pp8Ovw+PO0T50jHiEDeOuvjNvCkTRV9Otkkda5aWc
        mPqGfU9L/JwIcfwOjNf0G6RUD9M2nMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666200220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBLt6q8KXfJFLr7EVMsuPkUznxswdTgkCJUV+ihP7yk=;
        b=mVuAgZonBuN7XivtjSYju4RklCbIycM/QgQkdlxn+eTp5HQ42i8ZI/BLdy0zqD1QhUL2jm
        XNRH/UTFz1PoKyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EC2613A36;
        Wed, 19 Oct 2022 17:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4CwUF5wyUGPUCgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 19 Oct 2022 17:23:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 998CCA06F7; Wed, 19 Oct 2022 19:23:39 +0200 (CEST)
Date:   Wed, 19 Oct 2022 19:23:39 +0200
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
Message-ID: <20221019172339.f5dxek5yjposst5g@quack3>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221017105709.10830-10-jlayton@kernel.org>
 <20221017221433.GT3600936@dread.disaster.area>
 <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
 <20221018134910.v4jim6jyjllykcaf@quack3>
 <28a3d6b9978cf0280961385e28ae52f278d65d92.camel@kernel.org>
 <20221018151721.cl6dbupqjkkivxyf@quack3>
 <fcd35c14353ae859d778a23f80249047819bc4b0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd35c14353ae859d778a23f80249047819bc4b0.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-10-22 13:04:34, Jeff Layton wrote:
> On Tue, 2022-10-18 at 17:17 +0200, Jan Kara wrote:
> > On Tue 18-10-22 10:21:08, Jeff Layton wrote:
> > > On Tue, 2022-10-18 at 15:49 +0200, Jan Kara wrote:
> > > > On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> > > > > On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > > > > > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > > > > > Trond is of the opinion that monotonicity is a hard requirement, and
> > > > > > > that we should not allow filesystems that can't provide that quality to
> > > > > > > report STATX_VERSION at all.  His rationale is that one of the main uses
> > > > > > > for this is for backup applications, and for those a counter that could
> > > > > > > go backward is worse than useless.
> > > > > > 
> > > > > > From the perspective of a backup program doing incremental backups,
> > > > > > an inode with a change counter that has a different value to the
> > > > > > current backup inventory means the file contains different
> > > > > > information than what the current backup inventory holds. Again,
> > > > > > snapshots, rollbacks, etc.
> > > > > > 
> > > > > > Therefore, regardless of whether the change counter has gone
> > > > > > forwards or backwards, the backup program needs to back up this
> > > > > > current version of the file in this backup because it is different
> > > > > > to the inventory copy.  Hence if the backup program fails to back it
> > > > > > up, it will not be creating an exact backup of the user's data at
> > > > > > the point in time the backup is run...
> > > > > > 
> > > > > > Hence I don't see that MONOTONIC is a requirement for backup
> > > > > > programs - they really do have to be able to handle filesystems that
> > > > > > have modifications that move backwards in time as well as forwards...
> > > > > 
> > > > > Rolling backward is not a problem in and of itself. The big issue is
> > > > > that after a crash, we can end up with a change attr seen before the
> > > > > crash that is now associated with a completely different inode state.
> > > > > 
> > > > > The scenario is something like:
> > > > > 
> > > > > - Change attr for an empty file starts at 1
> > > > > 
> > > > > - Write "A" to file, change attr goes to 2
> > > > > 
> > > > > - Read and statx happens (client sees "A" with change attr 2)
> > > > > 
> > > > > - Crash (before last change is logged to disk)
> > > > > 
> > > > > - Machine reboots, inode is empty, change attr back to 1
> > > > > 
> > > > > - Write "B" to file, change attr goes to 2
> > > > > 
> > > > > - Client stat's file, sees change attr 2 and assumes its cache is
> > > > > correct when it isn't (should be "B" not "A" now).
> > > > > 
> > > > > The real danger comes not from the thing going backward, but the fact
> > > > > that it can march forward again after going backward, and then the
> > > > > client can see two different inode states associated with the same
> > > > > change attr value. Jumping all the change attributes forward by a
> > > > > significant amount after a crash should avoid this issue.
> > > > 
> > > > As Dave pointed out, the problem with change attr having the same value for
> > > > a different inode state (after going backwards) holds not only for the
> > > > crashes but also for restore from backups, fs snapshots, device snapshots
> > > > etc. So relying on change attr only looks a bit fragile. It works for the
> > > > common case but the edge cases are awkward and there's no easy way to
> > > > detect you are in the edge case.
> > > > 
> > > 
> > > This is true. In fact in the snapshot case you can't even rely on doing
> > > anything at reboot since you won't necessarily need to reboot to make it
> > > roll backward.
> > > 
> > > Whether that obviates the use of this value altogether, I'm not sure.
> > > 
> > > > So I think any implementation caring about data integrity would have to
> > > > include something like ctime into the picture anyway. Or we could just
> > > > completely give up any idea of monotonicity and on each mount select random
> > > > prime P < 2^64 and instead of doing inc when advancing the change
> > > > attribute, we'd advance it by P. That makes collisions after restore /
> > > > crash fairly unlikely.
> > > 
> > > Part of the goal (at least for NFS) is to avoid unnecessary cache
> > > invalidations.
> > > 
> > > If we just increment it by a particular offset on every reboot, then
> > > every time the server reboots, the clients will invalidate all of their
> > > cached inodes, and proceed to hammer the server with READ calls just as
> > > it's having to populate its own caches from disk.
> > 
> > Note that I didn't propose to increment by offset on every reboot or mount.
> > I have proposed that inode_maybe_inc_iversion() would not increment
> > i_version by 1 (in fact 1 << I_VERSION_QUERIED_SHIFT) but rather by P (or P
> > << I_VERSION_QUERIED_SHIFT) where P is a suitable number randomly selected
> > on filesystem mount.
> > 
> > This will not cause cache invalidation after a clean unmount + remount. It
> > will cause cache invalidation after a crash, snapshot rollback etc., only for
> > inodes where i_version changed. If P is suitably selected (e.g. as being a
> > prime), then the chances of collisions (even after a snapshot rollback) are
> > very low (on the order of 2^(-50) if my piece of envelope calculations are
> > right).
> >
> > So this should nicely deal with all the problems we've spotted so far. But
> > I may be missing something...
> 
> 
> Got it! That makes a lot more sense. Thinking about this some more...
> 
> What sort of range for P would be suitable?
> 
> Every increment would need to be by (shifted) P, so we can't choose too
> large a number. Queries are pretty rare vs. writes though, so that
> mitigates the issue somewhat.

Well, I agree that for large P the counter would wrap earlier. But is that
a problem? Note that if P is a prime (indivisible by 2 is enough), then the
counter would get to already used value still only after 2^63 steps. Thus if
we give up monotonicity and just treat the counter as an opaque cookie, we
do not have to care about wrapping.

Sure given different P is selected for each mount the wrapping argument
does not hold 100% but here comes the advantage of primes - if you have two
different primes P and Q, then a collision means that k*P mod 2^63 = l*Q
mod 2^63 and that holds for exactly one pair k,l from 1..2^63 range. So the
chances of early collision even after selecting a different prime on each
mount are *very* low.

So I think we should select from a relatively large set of primes so that
the chance of randomly selecting the same prime (and thus reissuing the
same change attr for different inode state sometime later) are small.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
