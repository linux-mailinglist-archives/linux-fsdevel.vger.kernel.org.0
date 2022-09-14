Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73915B7DC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 02:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiINAIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 20:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiINAIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:08:50 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4262A95;
        Tue, 13 Sep 2022 17:08:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 74A4EBCE; Tue, 13 Sep 2022 20:08:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 74A4EBCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1663114128;
        bh=E9WEzEar/6VJErlxq0icil2vqwzUNkdFMHHx75MNPGk=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=gbzbUdAw9tQbApBKPqCcLDaprymqGt1ZMnsxKY2ZvOplS6yqAodJy/iaWkqufRExJ
         fCKIdC9SJKsHpIw5KnLOhMQm2UVX/RKMaTclCJzV7X4HnaBhdJ0wbD9HhMcPI07tFG
         GAxZc03ETKVHcTcXtNtSGu96B8Jx5HwFmjs1fk3Q=
Date:   Tue, 13 Sep 2022 20:08:48 -0400
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20220914000848.GB11958@fieldses.org>
References: <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <20220909154506.GB5674@fieldses.org>
 <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
 <20220910145600.GA347@fieldses.org>
 <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
 <20220913004146.GD3600936@dread.disaster.area>
 <166303374350.30452.17386582960615006566@noble.neil.brown.name>
 <20220913190226.GA11958@fieldses.org>
 <166311116291.20483.960025733349761945@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166311116291.20483.960025733349761945@noble.neil.brown.name>
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

On Wed, Sep 14, 2022 at 09:19:22AM +1000, NeilBrown wrote:
> On Wed, 14 Sep 2022, J. Bruce Fields wrote:
> > On Tue, Sep 13, 2022 at 11:49:03AM +1000, NeilBrown wrote:
> > > Invalidating the client cache on EVERY unmount/mount could impose
> > > unnecessary cost.  Imagine a client that caches a lot of data (several
> > > large files) from a server which is expected to fail-over from one
> > > cluster node to another from time to time.  Adding extra delays to a
> > > fail-over is not likely to be well received.
> > > 
> > > I don't *know* this cost would be unacceptable, and I *would* like to
> > > leave it to the filesystem to decide how to manage its own i_version
> > > values.  So maybe XFS can use the LSN for a salt.  If people notice the
> > > extra cost, they can complain.
> > 
> > I'd expect complaints.
> > 
> > NFS is actually even worse than this: it allows clients to reacquire
> > file locks across server restart and unmount/remount, even though
> > obviously the kernel will do nothing to prevent someone else from
> > locking (or modifying) the file in between.
> 
> I don't understand this comment.  You seem to be implying that changing
> the i_version during a server restart would stop a client from
> reclaiming locks.  Is that correct?

No, sorry, I'm probably being confusing.

I was just saying: we've always depended in a lot of ways on the
assumption that filesystems aren't messed with while nfsd's not running.
You can produce all sorts of incorrect behavior by violating that
assumption.  That tools might fool with unmounted filesystems is just
another such example, and fixing that wouldn't be very high on my list
of priorities.

??

--b.

> I would have thought that the client would largely ignore i_version
> while it has a lock or open or delegation, as these tend to imply some
> degree of exclusive access ("open" being least exclusive).
> 
> Thanks,
> NeilBrown
> 
> 
> > 
> > Administrators are just supposed to know not to allow other applications
> > access to the filesystem until nfsd's started.  It's always been this
> > way.
> > 
> > You can imagine all sorts of measures to prevent that, and if anyone
> > wants to work on ways to prevent people from shooting themselves in the
> > foot here, great.
> > 
> > Just taking away the ability to cache or lock across reboots wouldn't
> > make people happy, though....
> > 
> > --b.
> > 
