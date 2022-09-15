Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC95B9C8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIOOGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 10:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIOOGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:06:48 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D839C1C1;
        Thu, 15 Sep 2022 07:06:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3E7CDA99; Thu, 15 Sep 2022 10:06:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3E7CDA99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1663250804;
        bh=LLHFRFO6j0hm3HnFxTTsR3ywh1o3veH7ecKfWKoG5Bo=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=RnQubsCmjhVbXQbFVtfPj0KCK6Bhc5FRhEHFKQaBiiMurk1EI292SjWwOpq43nZ+L
         xM44/v5REErLDFQM7dKmb6dCp/MuBDq+XiH+0+dbhCAYW9AogNPMQ5kr7kiy1DdAWF
         j7po02iv95tP0IF/xX4z8h+ZSZEb1S66DWrfY01A=
Date:   Thu, 15 Sep 2022 10:06:44 -0400
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
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
Message-ID: <20220915140644.GA15754@fieldses.org>
References: <20220908083326.3xsanzk7hy3ff4qs@quack3>
 <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
 <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
 <20220908182252.GA18939@fieldses.org>
 <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
 <166284799157.30452.4308111193560234334@noble.neil.brown.name>
 <20220912134208.GB9304@fieldses.org>
 <166302447257.30452.6751169887085269140@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166302447257.30452.6751169887085269140@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 09:14:32AM +1000, NeilBrown wrote:
> On Mon, 12 Sep 2022, J. Bruce Fields wrote:
> > On Sun, Sep 11, 2022 at 08:13:11AM +1000, NeilBrown wrote:
> > > On Fri, 09 Sep 2022, Jeff Layton wrote:
> > > > 
> > > > The machine crashes and comes back up, and we get a query for i_version
> > > > and it comes back as X. Fine, it's an old version. Now there is a write.
> > > > What do we do to ensure that the new value doesn't collide with X+1? 
> > > 
> > > (I missed this bit in my earlier reply..)
> > > 
> > > How is it "Fine" to see an old version?
> > > The file could have changed without the version changing.
> > > And I thought one of the goals of the crash-count was to be able to
> > > provide a monotonic change id.
> > 
> > I was still mainly thinking about how to provide reliable close-to-open
> > semantics between NFS clients.  In the case the writer was an NFS
> > client, it wasn't done writing (or it would have COMMITted), so those
> > writes will come in and bump the change attribute soon, and as long as
> > we avoid the small chance of reusing an old change attribute, we're OK,
> > and I think it'd even still be OK to advertise
> > CHANGE_TYPE_IS_MONOTONIC_INCR.
> 
> You seem to be assuming that the client doesn't crash at the same time
> as the server (maybe they are both VMs on a host that lost power...)
> 
> If client A reads and caches, client B writes, the server crashes after
> writing some data (to already allocated space so no inode update needed)
> but before writing the new i_version, then client B crashes.
> When server comes back the i_version will be unchanged but the data has
> changed.  Client A will cache old data indefinitely...

I guess I assume that if all we're promising is close-to-open, then a
client isn't allowed to trust its cache in that situation.  Maybe that's
an overly draconian interpretation of close-to-open.

Also, I'm trying to think about how to improve things incrementally.
Incorporating something like a crash count into the on-disk i_version
fixes some cases without introducing any new ones or regressing
performance after a crash.

If we subsequently wanted to close those remaining holes, I think we'd
need the change attribute increment to be seen as atomic with respect to
its associated change, both to clients and (separately) on disk.  (That
would still allow the change attribute to go backwards after a crash, to
the value it held as of the on-disk state of the file.  I think clients
should be able to deal with that case.)

But, I don't know, maybe a bigger hammer would be OK:

> I think we need to require the filesystem to ensure that the i_version
> is seen to increase shortly after any change becomes visible in the
> file, and no later than the moment when the request that initiated the
> change is acknowledged as being complete.  In the case of an unclean
> restart, any file that is not known to have been unchanged immediately
> before the crash must have i_version increased.
> 
> The simplest implementation is to have an unclean-restart counter and to
> always included this multiplied by some constant X in the reported
> i_version.  The filesystem guarantees to record (e.g.  to journal
> at least) the i_version if it comes close to X more than the previous
> record.  The filesystem gets to choose X.

So the question is whether people can live with invalidating all client
caches after a cache.  I don't know.

> A more complex solution would be to record (similar to the way orphans
> are recorded) any file which is open for write, and to add X to the
> i_version for any "dirty" file still recorded during an unclean
> restart.  This would avoid bumping the i_version for read-only files.

Is that practical?  Working out the performance tradeoffs sounds like a
project.

> There may be other solutions, but we should leave that up to the
> filesystem.  Each filesystem might choose something different.

Sure.

--b.
