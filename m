Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49EF390BFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEYWPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232129AbhEYWPW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:15:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F38A761019;
        Tue, 25 May 2021 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621980832;
        bh=gN3m3jr0zpW3uBjIUscZ0OUKn0VJlnlUIIIpzIpW9HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tc+axs4ghK1XxAO0iEP9qy0VgFfgmcrUquI8G5+rvnWHWniLsNzsZKdZNJ1ldG+VT
         6nrbHlOXDl5dh7l572t1pa0WroS62LBWyJjJFQyMH+8O73rpELaUqMyOfi5YFX9W+V
         Uh7S8dftq/Ehs3csuqmGD0aojn2ypxTjId5lMt/A7GzOKLjcF766zxXK0GQLjvz/f2
         EWiNQiAbBToLu81W+13a2le/460p3vVNPI1B0rRjaBKa8NlmuPgeUSCWApyuFafccp
         xTFUoWoW1QZRKLzwE9VyvQRMyxzFhSFLbzHeA1U+g2lPdxKu/UC0L1UHbZz7QlNdtj
         /R0EFElgdoNUQ==
Date:   Tue, 25 May 2021 15:13:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Josh Triplett <josh@joshtriplett.org>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <20210525221351.GB202068@locust>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
 <YKntRtEUoxTEFBOM@localhost>
 <B70B57ED-6F11-45CC-B99F-86BBDE36ACA4@dilger.ca>
 <YK1rebI5vZKCeLlp@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK1rebI5vZKCeLlp@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 10:26:17PM +0100, Matthew Wilcox wrote:
> On Tue, May 25, 2021 at 03:13:52PM -0600, Andreas Dilger wrote:
> > Definitely "-o discard" is known to have a measurable performance impact,
> > simply because it ends up sending a lot more requests to the block device,
> > and those requests can be slow/block the queue, depending on underlying
> > storage behavior.
> > 
> > There was a patch pushed recently that targets "-o discard" performance:
> > https://patchwork.ozlabs.org/project/linux-ext4/list/?series=244091
> > that needs a bit more work, but may be worthwhile to test if it improves
> > your workload, and help put some weight behind landing it?
> 
> This all seems very complicated.  I have chosen with my current laptop
> to "short stroke" the drive.  That is, I discarded the entire bdev,
> then partitioned it roughly in half.  The second half has never seen
> any writes.  This effectively achieves the purpose of TRIM/discard;
> there are a lot of unused LBAs, so the underlying flash translation layer
> always has plenty of spare space when it needs to empty an erase block.
> 
> Since the steady state of hard drives is full, I have to type 'make clean'
> in my build trees more often than otherwise and remember to delete iso
> images after i've had them lying around for a year, but I'd rather clean
> up a little more often than get these weird performance glitches.
> 
> And if I really do need half a terabyte of space temporarily, I can
> always choose to use the fallow range for a while, then discard it again.

I just let xfs_scrub run FITRIM on Sundays at 4:30am. ;)

--D
