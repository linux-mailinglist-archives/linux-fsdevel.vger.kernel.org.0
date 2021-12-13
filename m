Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69391472150
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 08:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhLMHEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 02:04:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35556 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLMHET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:04:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D09C81F3B0;
        Mon, 13 Dec 2021 07:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639379057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aEqBV9gaFo2wyx1G4xG19C/0b13L1C/hoEvYE9B85GE=;
        b=l/hLlA5w3OBwKRP+sBt/ehoVB3EoaTuRtFJa9WBwUg8DKSN0+dWtXmPaULZ5nea0glf+3i
        /y099EP4z9wGokt1s7ezqdFqw780FOZu/+ajH8HFYxpYwantjdLh91yQrYkA6XOijRd/n1
        sLfk1JR2eSud6NM0G4BZ3LPOJ7i0/y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639379057;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aEqBV9gaFo2wyx1G4xG19C/0b13L1C/hoEvYE9B85GE=;
        b=fbIFNrfIGETnM5AYz2WyO2gy+fZNb61dtNZ2rejU57HQMud9rQbH2LfXezo8Za7bUX9l4C
        gqceDp2a6mOOzNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A220013B51;
        Mon, 13 Dec 2021 07:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0YQoF23wtmFUaQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 07:04:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dave Chinner" <david@fromorbit.com>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Philipp Reisner" <philipp.reisner@linbit.com>,
        "Lars Ellenberg" <lars.ellenberg@linbit.com>,
        "Jan Kara" <jack@suse.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Remove bdi_congested() and wb_congested() and related
 functions
In-reply-to: <20211213050736.GS449541@dread.disaster.area>
References: <163936868317.23860.5037433897004720387.stgit@noble.brown>,
 <163936886727.23860.5245364396572576756.stgit@noble.brown>,
 <20211213050736.GS449541@dread.disaster.area>
Date:   Mon, 13 Dec 2021 18:04:10 +1100
Message-id: <163937905049.22433.10716750573737410875@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Dec 2021, Dave Chinner wrote:
> On Mon, Dec 13, 2021 at 03:14:27PM +1100, NeilBrown wrote:
> > These functions are no longer useful as the only bdis that report
> > congestion are in ceph, fuse, and nfs.  None of those bdis can be the
> > target of the calls in drbd, ext2, nilfs2, or xfs.
> > 
> > Removing the test on bdi_write_contested() in current_may_throttle()
> > could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
> > is set.
> > 
> > So replace the calls by 'false' and simplify the code - and remove the
> > functions.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> ....
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index 631c5a61d89b..22f73b3e888e 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -843,9 +843,6 @@ xfs_buf_readahead_map(
> >  {
> >  	struct xfs_buf		*bp;
> >  
> > -	if (bdi_read_congested(target->bt_bdev->bd_disk->bdi))
> > -		return;
> 
> Ok, but this isn't a "throttle writeback" test here - it's trying to
> avoid having speculative readahead blocking on a full request queue
> instead of just skipping the readahead IO. i.e. prevent readahead
> thrashing and/or adding unnecessary read load when we already have a
> full read queue...
> 
> So what is the replacement for that? We want to skip the entire
> buffer lookup/setup/read overhead if we're likely to block on IO
> submission - is there anything we can use to do this these days?

I don't think there is a concept of a "full read queue" any more.
There are things that can block an IO submission though.
There is allocation of the bio from a mempool, and there is
rq_qos_throttle, and there are probably other places where submission
can block.  I don't think you can tell in advance if a submission is
likely to block.

I think the idea is that the top level of the submission stack should
rate-limit based on the estimated throughput of the stack.  I think
write-back does this.  I don't know about read-ahead.

NeilBrown
