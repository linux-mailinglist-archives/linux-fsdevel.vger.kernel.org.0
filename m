Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EDB5B4723
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 16:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIJO4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIJO4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:56:04 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591684456E;
        Sat, 10 Sep 2022 07:56:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7A3F43EFA; Sat, 10 Sep 2022 10:56:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7A3F43EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662821760;
        bh=SZQMh41faq8WqGYzUFVzpKRgs2k+w1RihYT0eZKjmNw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=XSX6urCEYdL6eAYLc1M3PQv5M4EI5GwWXAJHQaMPIZBqQWV6qikNLF4U57+B1YZCa
         qmEyx+b+5XPnbZXnIkZ2/iPOZbuOdkq6+hsAvdzAXkPsqqR0z1CWlJYAvBgQ0LvoYY
         BhArks9aKF7f9+Fk2qxsrXox3FsJX6AwrfMRkil0=
Date:   Sat, 10 Sep 2022 10:56:00 -0400
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220910145600.GA347@fieldses.org>
References: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:36:29PM -0400, Jeff Layton wrote:
> On Fri, 2022-09-09 at 11:45 -0400, J. Bruce Fields wrote:
> > On Thu, Sep 08, 2022 at 03:07:58PM -0400, Jeff Layton wrote:
> > > On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
> > > > On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> > > > > Yeah, ok. That does make some sense. So we would mix this into the
> > > > > i_version instead of the ctime when it was available. Preferably, we'd
> > > > > mix that in when we store the i_version rather than adding it afterward.
> > > > > 
> > > > > Ted, how would we access this? Maybe we could just add a new (generic)
> > > > > super_block field for this that ext4 (and other filesystems) could
> > > > > populate at mount time?
> > > > 
> > > > Couldn't the filesystem just return an ino_version that already includes
> > > > it?
> > > > 
> > > 
> > > Yes. That's simple if we want to just fold it in during getattr. If we
> > > want to fold that into the values stored on disk, then I'm a little less
> > > clear on how that will work.
> > > 
> > > Maybe I need a concrete example of how that will work:
> > > 
> > > Suppose we have an i_version value X with the previous crash counter
> > > already factored in that makes it to disk. We hand out a newer version
> > > X+1 to a client, but that value never makes it to disk.
> > > 
> > > The machine crashes and comes back up, and we get a query for i_version
> > > and it comes back as X. Fine, it's an old version. Now there is a write.
> > > What do we do to ensure that the new value doesn't collide with X+1? 
> > 
> > I was assuming we could partition i_version's 64 bits somehow: e.g., top
> > 16 bits store the crash counter.  You increment the i_version by: 1)
> > replacing the top bits by the new crash counter, if it has changed, and
> > 2) incrementing.
> > 
> > Do the numbers work out?  2^16 mounts after unclean shutdowns sounds
> > like a lot for one filesystem, as does 2^48 changes to a single file,
> > but people do weird things.  Maybe there's a better partitioning, or
> > some more flexible way of maintaining an i_version that still allows you
> > to identify whether a given i_version preceded a crash.
> > 
> 
> We consume one bit to keep track of the "seen" flag, so it would be a
> 16+47 split. I assume that we'd also reset the version counter to 0 when
> the crash counter changes? Maybe that doesn't matter as long as we don't
> overflow into the crash counter.
> 
> I'm not sure we can get away with 16 bits for the crash counter, as
> it'll leave us subject to the version counter wrapping after a long
> uptimes. 
> 
> If you increment a counter every nanosecond, how long until that counter
> wraps? With 63 bits, that's 292 years (and change). With 16+47 bits,
> that's less than two days. An 8+55 split would give us ~416 days which
> seems a bit more reasonable?

Though now it's starting to seem a little limiting to allow only 2^8
mounts after unclean shutdowns.

Another way to think of it might be: multiply that 8-bit crash counter
by 2^48, and think of it as a 64-bit value that we believe (based on
practical limits on how many times you can modify a single file) is
gauranteed to be larger than any i_version that we gave out before the
most recent crash.

Our goal is to ensure that after a crash, any *new* i_versions that we
give out or write to disk are larger than any that have previously been
given out.  We can do that by ensuring that they're equal to at least
that old maximum.

So think of the 64-bit value we're storing in the superblock as a
ceiling on i_version values across all the filesystem's inodes.  Call it
s_version_max or something.  We also need to know what the maximum was
before the most recent crash.  Call that s_version_max_old.

Then we could get correct behavior if we generated i_versions with
something like:

	i_version++;
	if (i_version < s_version_max_old)
		i_version = s_version_max_old;
	if (i_version > s_version_max)
		s_version_max = i_version + 1;

But that last step makes this ludicrously expensive, because for this to
be safe across crashes we need to update that value on disk as well, and
we need to do that frequently.

Fortunately, s_version_max doesn't have to be a tight bound at all.  We
can easily just initialize it to, say, 2^40, and only bump it by 2^40 at
a time.  And recognize when we're running up against it way ahead of
time, so we only need to say "here's an updated value, could you please
make sure it gets to disk sometime in the next twenty minutes"?
(Numbers made up.)

Sorry, that was way too many words.  But I think something like that
could work, and make it very difficult to hit any hard limits, and
actually not be too complicated??  Unless I missed something.

--b.
