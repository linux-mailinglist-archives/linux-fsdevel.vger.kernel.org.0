Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4245B6533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 03:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiIMBtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 21:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIMBtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:49:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94704F67F;
        Mon, 12 Sep 2022 18:49:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DF9134486;
        Tue, 13 Sep 2022 01:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663033754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XymQaOtV2yV+xCDaTdfh048Uz6sbE2/X7+E4QQCcVdo=;
        b=RJxgi3J1bX3N95U7SNYQj6XFLkLiRRJMmXP5Dcw1rxxL7Pk3SWRoQK1arYpZSZDmyWuLX9
        IkrHNjN7zOhBdypFQOeR0/YlkKLseT6jpWor8TftOvGZ4mOo+dwvQwgeWTi2DbT6PwN0aB
        mepCSbH00VBbO54aU5FzE/mp5XUb7tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663033754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XymQaOtV2yV+xCDaTdfh048Uz6sbE2/X7+E4QQCcVdo=;
        b=nrTqRPioiBIrZ75RcYjeFJfhOVcHGnLXCxYbUvR+CI0TEqBuMDUU2+UZdE0vOmTpYNXUkL
        ChjPBearKW3Oy0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8A02139B3;
        Tue, 13 Sep 2022 01:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dHZ5J5LhH2OyGQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 13 Sep 2022 01:49:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Theodore Ts'o" <tytso@mit.edu>, "Jan Kara" <jack@suse.cz>,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <20220913004146.GD3600936@dread.disaster.area>
References: <YxoIjV50xXKiLdL9@mit.edu>,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>,
 <20220908155605.GD8951@fieldses.org>,
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>,
 <20220908182252.GA18939@fieldses.org>,
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>,
 <20220909154506.GB5674@fieldses.org>,
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>,
 <20220910145600.GA347@fieldses.org>,
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>,
 <20220913004146.GD3600936@dread.disaster.area>
Date:   Tue, 13 Sep 2022 11:49:03 +1000
Message-id: <166303374350.30452.17386582960615006566@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 13 Sep 2022, Dave Chinner wrote:
> On Mon, Sep 12, 2022 at 07:42:16AM -0400, Jeff Layton wrote:
> > On Sat, 2022-09-10 at 10:56 -0400, J. Bruce Fields wrote:
> > > On Fri, Sep 09, 2022 at 12:36:29PM -0400, Jeff Layton wrote:
> > > Our goal is to ensure that after a crash, any *new* i_versions that we
> > > give out or write to disk are larger than any that have previously been
> > > given out.  We can do that by ensuring that they're equal to at least
> > > that old maximum.
> > > 
> > > So think of the 64-bit value we're storing in the superblock as a
> > > ceiling on i_version values across all the filesystem's inodes.  Call it
> > > s_version_max or something.  We also need to know what the maximum was
> > > before the most recent crash.  Call that s_version_max_old.
> > > 
> > > Then we could get correct behavior if we generated i_versions with
> > > something like:
> > > 
> > > 	i_version++;
> > > 	if (i_version < s_version_max_old)
> > > 		i_version = s_version_max_old;
> > > 	if (i_version > s_version_max)
> > > 		s_version_max = i_version + 1;
> > > 
> > > But that last step makes this ludicrously expensive, because for this to
> > > be safe across crashes we need to update that value on disk as well, and
> > > we need to do that frequently.
> > > 
> > > Fortunately, s_version_max doesn't have to be a tight bound at all.  We
> > > can easily just initialize it to, say, 2^40, and only bump it by 2^40 at
> > > a time.  And recognize when we're running up against it way ahead of
> > > time, so we only need to say "here's an updated value, could you please
> > > make sure it gets to disk sometime in the next twenty minutes"?
> > > (Numbers made up.)
> > > 
> > > Sorry, that was way too many words.  But I think something like that
> > > could work, and make it very difficult to hit any hard limits, and
> > > actually not be too complicated??  Unless I missed something.
> > > 
> > 
> > That's not too many words -- I appreciate a good "for dummies"
> > explanation!
> > 
> > A scheme like that could work. It might be hard to do it without a
> > spinlock or something, but maybe that's ok. Thinking more about how we'd
> > implement this in the underlying filesystems:
> > 
> > To do this we'd need 2 64-bit fields in the on-disk and in-memory 
> > superblocks for ext4, xfs and btrfs. On the first mount after a crash,
> > the filesystem would need to bump s_version_max by the significant
> > increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
> > to do that.
> 
> Why only increment on crash? If the filesystem has been unmounted,
> then any cached data is -stale- and must be discarded. e.g. unmount,
> run fsck which cleans up corrupt files but does not modify
> i_version, then mount. Remote caches are now invalid, but i_version
> may not have changed, so we still need the clean unmount-mount cycle
> to invalidate caches.

I disagree.  We do need fsck to cause caches to be invalidated IF IT
FOUND SOMETHING TO REPAIR, but not if the filesystem was truely clean.

> 
> IOWs, what we want is a salted i_version value, with the filesystem
> providing the unique per-mount salt that gets added to the
> externally visible i_version values.

I agree this is a simple approach.  Possible the best.

> 
> If that's the case, the salt doesn't need to be restricted to just
> modifying the upper bits - as long as the salt increments
> substantially and independently to the on-disk inode i_version then
> we just don't care what bits of the superblock salt change from
> mount to mount.
> 
> For XFS we already have a unique 64 bit salt we could use for every
> mount - clean or unclean - and guarantee it is larger for every
> mount. It also gets substantially bumped by fsck, too. It's called a
> Log Sequence Number and we use them to track and strictly order
> every modification we write into the log. This is exactly what is
> needed for a i_version salt, and it's already guaranteed to be
> persistent.

Invalidating the client cache on EVERY unmount/mount could impose
unnecessary cost.  Imagine a client that caches a lot of data (several
large files) from a server which is expected to fail-over from one
cluster node to another from time to time.  Adding extra delays to a
fail-over is not likely to be well received.

I don't *know* this cost would be unacceptable, and I *would* like to
leave it to the filesystem to decide how to manage its own i_version
values.  So maybe XFS can use the LSN for a salt.  If people notice the
extra cost, they can complain.

Thanks,
NeilBrown


> 
> > Would there be a way to ensure that the new s_version_max value has made
> > it to disk?
> 
> Yes, but that's not really relevant to the definition of the salt:
> we don't need to design the filesystem implementation of a
> persistent per-mount salt value. All we need is to define the
> behaviour of the salt (e.g. must always increase across a
> umount/mount cycle) and then you can let the filesystem developers
> worry about how to provide the required salt behaviour and it's
> persistence.
> 
> In the mean time, you can implement the salting and testing it by
> using the system time to seed the superblock salt - that's good
> enough for proof of concept, and as a fallback for filesystems that
> cannot provide the required per-mount salt persistence....
> 
> > Bumping it by a large value and hoping for the best might be
> > ok for most cases, but there are always outliers, so it might be
> > worthwhile to make an i_version increment wait on that if necessary. 
> 
> Nothing should be able to query i_version until the filesystem is
> fully recovered, mounted and the salt has been set. Hence no
> application (kernel or userspace) should ever see an unsalted
> i_version value....
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
