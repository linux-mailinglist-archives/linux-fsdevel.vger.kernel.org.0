Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8805B3C47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiIIPpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIIPpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:45:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048067391B;
        Fri,  9 Sep 2022 08:45:07 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 090513EFA; Fri,  9 Sep 2022 11:45:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 090513EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662738307;
        bh=V/DLdRPq1zvs/q2asuE3/COTboZaddvEjKL48nZq+Ag=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=nst+nwaO6YbS4rXF/b6lFwOretBhbDsuXZPoezitk+nlqiztyBadpNSM4FUr7jnwg
         8MJVasi6mMG6bgkD27Rw1rr7K/yhOcWkv0PLxFUO25Jk7I2jBCLUizMlSPpqpB05Pm
         j19t4ySKDY3IIRE1n2ES5Fq9mNY9GKx9BLcF0ZUY=
Date:   Fri, 9 Sep 2022 11:45:06 -0400
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
Message-ID: <20220909154506.GB5674@fieldses.org>
References: <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
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

On Thu, Sep 08, 2022 at 03:07:58PM -0400, Jeff Layton wrote:
> On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
> > On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> > > Yeah, ok. That does make some sense. So we would mix this into the
> > > i_version instead of the ctime when it was available. Preferably, we'd
> > > mix that in when we store the i_version rather than adding it afterward.
> > > 
> > > Ted, how would we access this? Maybe we could just add a new (generic)
> > > super_block field for this that ext4 (and other filesystems) could
> > > populate at mount time?
> > 
> > Couldn't the filesystem just return an ino_version that already includes
> > it?
> > 
> 
> Yes. That's simple if we want to just fold it in during getattr. If we
> want to fold that into the values stored on disk, then I'm a little less
> clear on how that will work.
> 
> Maybe I need a concrete example of how that will work:
> 
> Suppose we have an i_version value X with the previous crash counter
> already factored in that makes it to disk. We hand out a newer version
> X+1 to a client, but that value never makes it to disk.
> 
> The machine crashes and comes back up, and we get a query for i_version
> and it comes back as X. Fine, it's an old version. Now there is a write.
> What do we do to ensure that the new value doesn't collide with X+1? 

I was assuming we could partition i_version's 64 bits somehow: e.g., top
16 bits store the crash counter.  You increment the i_version by: 1)
replacing the top bits by the new crash counter, if it has changed, and
2) incrementing.

Do the numbers work out?  2^16 mounts after unclean shutdowns sounds
like a lot for one filesystem, as does 2^48 changes to a single file,
but people do weird things.  Maybe there's a better partitioning, or
some more flexible way of maintaining an i_version that still allows you
to identify whether a given i_version preceded a crash.

--b.
