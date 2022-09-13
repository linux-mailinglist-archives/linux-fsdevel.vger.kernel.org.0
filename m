Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407E5B649B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 02:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIMAl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 20:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIMAlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:41:55 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCC114F6BF;
        Mon, 12 Sep 2022 17:41:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-149-49.pa.vic.optusnet.com.au [49.186.149.49])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6A9D862E08B;
        Tue, 13 Sep 2022 10:41:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oXtzm-007333-72; Tue, 13 Sep 2022 10:41:46 +1000
Date:   Tue, 13 Sep 2022 10:41:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220913004146.GD3600936@dread.disaster.area>
References: <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
 <20220910145600.GA347@fieldses.org>
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=631fd1d0
        a=XTRC1Ovx3SkpaCW1YxGVGA==:117 a=XTRC1Ovx3SkpaCW1YxGVGA==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=XrC1z_faGCYUbmieGBEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 07:42:16AM -0400, Jeff Layton wrote:
> On Sat, 2022-09-10 at 10:56 -0400, J. Bruce Fields wrote:
> > On Fri, Sep 09, 2022 at 12:36:29PM -0400, Jeff Layton wrote:
> > Our goal is to ensure that after a crash, any *new* i_versions that we
> > give out or write to disk are larger than any that have previously been
> > given out.  We can do that by ensuring that they're equal to at least
> > that old maximum.
> > 
> > So think of the 64-bit value we're storing in the superblock as a
> > ceiling on i_version values across all the filesystem's inodes.  Call it
> > s_version_max or something.  We also need to know what the maximum was
> > before the most recent crash.  Call that s_version_max_old.
> > 
> > Then we could get correct behavior if we generated i_versions with
> > something like:
> > 
> > 	i_version++;
> > 	if (i_version < s_version_max_old)
> > 		i_version = s_version_max_old;
> > 	if (i_version > s_version_max)
> > 		s_version_max = i_version + 1;
> > 
> > But that last step makes this ludicrously expensive, because for this to
> > be safe across crashes we need to update that value on disk as well, and
> > we need to do that frequently.
> > 
> > Fortunately, s_version_max doesn't have to be a tight bound at all.  We
> > can easily just initialize it to, say, 2^40, and only bump it by 2^40 at
> > a time.  And recognize when we're running up against it way ahead of
> > time, so we only need to say "here's an updated value, could you please
> > make sure it gets to disk sometime in the next twenty minutes"?
> > (Numbers made up.)
> > 
> > Sorry, that was way too many words.  But I think something like that
> > could work, and make it very difficult to hit any hard limits, and
> > actually not be too complicated??  Unless I missed something.
> > 
> 
> That's not too many words -- I appreciate a good "for dummies"
> explanation!
> 
> A scheme like that could work. It might be hard to do it without a
> spinlock or something, but maybe that's ok. Thinking more about how we'd
> implement this in the underlying filesystems:
> 
> To do this we'd need 2 64-bit fields in the on-disk and in-memory 
> superblocks for ext4, xfs and btrfs. On the first mount after a crash,
> the filesystem would need to bump s_version_max by the significant
> increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
> to do that.

Why only increment on crash? If the filesystem has been unmounted,
then any cached data is -stale- and must be discarded. e.g. unmount,
run fsck which cleans up corrupt files but does not modify
i_version, then mount. Remote caches are now invalid, but i_version
may not have changed, so we still need the clean unmount-mount cycle
to invalidate caches.

IOWs, what we want is a salted i_version value, with the filesystem
providing the unique per-mount salt that gets added to the
externally visible i_version values.

If that's the case, the salt doesn't need to be restricted to just
modifying the upper bits - as long as the salt increments
substantially and independently to the on-disk inode i_version then
we just don't care what bits of the superblock salt change from
mount to mount.

For XFS we already have a unique 64 bit salt we could use for every
mount - clean or unclean - and guarantee it is larger for every
mount. It also gets substantially bumped by fsck, too. It's called a
Log Sequence Number and we use them to track and strictly order
every modification we write into the log. This is exactly what is
needed for a i_version salt, and it's already guaranteed to be
persistent.

> Would there be a way to ensure that the new s_version_max value has made
> it to disk?

Yes, but that's not really relevant to the definition of the salt:
we don't need to design the filesystem implementation of a
persistent per-mount salt value. All we need is to define the
behaviour of the salt (e.g. must always increase across a
umount/mount cycle) and then you can let the filesystem developers
worry about how to provide the required salt behaviour and it's
persistence.

In the mean time, you can implement the salting and testing it by
using the system time to seed the superblock salt - that's good
enough for proof of concept, and as a fallback for filesystems that
cannot provide the required per-mount salt persistence....

> Bumping it by a large value and hoping for the best might be
> ok for most cases, but there are always outliers, so it might be
> worthwhile to make an i_version increment wait on that if necessary. 

Nothing should be able to query i_version until the filesystem is
fully recovered, mounted and the salt has been set. Hence no
application (kernel or userspace) should ever see an unsalted
i_version value....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
