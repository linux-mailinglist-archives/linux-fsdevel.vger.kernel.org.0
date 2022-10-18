Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E72602D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiJRNtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 09:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJRNtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:49:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5CCF1AA;
        Tue, 18 Oct 2022 06:49:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F07E20802;
        Tue, 18 Oct 2022 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666100950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMwxr+Oz3KInXQcPe4Qmdr0nrPXTQW3wC4Yi95Kd59Q=;
        b=1qlciLI1a831qiIJk895gHyfoZVOq8RD604OqQCDz4YPjZK5yiPNMdoUudwmq7Hy5joP1S
        kaOAMCxtps7I9K5afdOYAbkGP7aX3YaQ7OPm1MDbXcMptkLdT3OWlLXjl06WVBfmB1Vwgj
        282NZpFQv1LIQi4iV68cy8cL0+TMH2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666100950;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMwxr+Oz3KInXQcPe4Qmdr0nrPXTQW3wC4Yi95Kd59Q=;
        b=I76cujcFTWIYufxjoUkCDZjfQxe5GvtQjKJg1yzBQfKRhvwzLzJNFJGgC22tszrDOebbHp
        Gg8TOyAW9No1J5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F21113480;
        Tue, 18 Oct 2022 13:49:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n+fmItauTmOXKAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 18 Oct 2022 13:49:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1FE5AA06EE; Tue, 18 Oct 2022 15:49:10 +0200 (CEST)
Date:   Tue, 18 Oct 2022 15:49:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v7 9/9] vfs: expose STATX_VERSION to userland
Message-ID: <20221018134910.v4jim6jyjllykcaf@quack3>
References: <20221017105709.10830-1-jlayton@kernel.org>
 <20221017105709.10830-10-jlayton@kernel.org>
 <20221017221433.GT3600936@dread.disaster.area>
 <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e01f88bcde1b7963e504e0fd9cfb27495eb03ca.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-10-22 06:35:14, Jeff Layton wrote:
> On Tue, 2022-10-18 at 09:14 +1100, Dave Chinner wrote:
> > On Mon, Oct 17, 2022 at 06:57:09AM -0400, Jeff Layton wrote:
> > > Trond is of the opinion that monotonicity is a hard requirement, and
> > > that we should not allow filesystems that can't provide that quality to
> > > report STATX_VERSION at all.  His rationale is that one of the main uses
> > > for this is for backup applications, and for those a counter that could
> > > go backward is worse than useless.
> > 
> > From the perspective of a backup program doing incremental backups,
> > an inode with a change counter that has a different value to the
> > current backup inventory means the file contains different
> > information than what the current backup inventory holds. Again,
> > snapshots, rollbacks, etc.
> > 
> > Therefore, regardless of whether the change counter has gone
> > forwards or backwards, the backup program needs to back up this
> > current version of the file in this backup because it is different
> > to the inventory copy.  Hence if the backup program fails to back it
> > up, it will not be creating an exact backup of the user's data at
> > the point in time the backup is run...
> > 
> > Hence I don't see that MONOTONIC is a requirement for backup
> > programs - they really do have to be able to handle filesystems that
> > have modifications that move backwards in time as well as forwards...
> 
> Rolling backward is not a problem in and of itself. The big issue is
> that after a crash, we can end up with a change attr seen before the
> crash that is now associated with a completely different inode state.
> 
> The scenario is something like:
> 
> - Change attr for an empty file starts at 1
> 
> - Write "A" to file, change attr goes to 2
> 
> - Read and statx happens (client sees "A" with change attr 2)
> 
> - Crash (before last change is logged to disk)
> 
> - Machine reboots, inode is empty, change attr back to 1
> 
> - Write "B" to file, change attr goes to 2
> 
> - Client stat's file, sees change attr 2 and assumes its cache is
> correct when it isn't (should be "B" not "A" now).
> 
> The real danger comes not from the thing going backward, but the fact
> that it can march forward again after going backward, and then the
> client can see two different inode states associated with the same
> change attr value. Jumping all the change attributes forward by a
> significant amount after a crash should avoid this issue.

As Dave pointed out, the problem with change attr having the same value for
a different inode state (after going backwards) holds not only for the
crashes but also for restore from backups, fs snapshots, device snapshots
etc. So relying on change attr only looks a bit fragile. It works for the
common case but the edge cases are awkward and there's no easy way to
detect you are in the edge case.

So I think any implementation caring about data integrity would have to
include something like ctime into the picture anyway. Or we could just
completely give up any idea of monotonicity and on each mount select random
prime P < 2^64 and instead of doing inc when advancing the change
attribute, we'd advance it by P. That makes collisions after restore /
crash fairly unlikely.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
