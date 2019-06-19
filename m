Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC1D4B3F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfFSIVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 04:21:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:49250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfFSIVp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:21:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 853F1AF30;
        Wed, 19 Jun 2019 08:21:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 502821E0492; Wed, 19 Jun 2019 10:21:41 +0200 (CEST)
Date:   Wed, 19 Jun 2019 10:21:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker
 merged)
Message-ID: <20190619082141.GA32409@quack2.suse.cz>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612230224.GJ14308@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-06-19 09:02:24, Dave Chinner wrote:
> On Wed, Jun 12, 2019 at 12:21:44PM -0400, Kent Overstreet wrote:
> > This would simplify things a lot and eliminate a really nasty corner case - page
> > faults trigger readahead. Even if the buffer and the direct IO don't overlap,
> > readahead can pull in pages that do overlap with the dio.
> 
> Page cache readahead needs to be moved under the filesystem IO
> locks. There was a recent thread about how readahead can race with
> hole punching and other fallocate() operations because page cache
> readahead bypasses the filesystem IO locks used to serialise page
> cache invalidation.
> 
> e.g. Readahead can be directed by userspace via fadvise, so we now
> have file->f_op->fadvise() so that filesystems can lock the inode
> before calling generic_fadvise() such that page cache instantiation
> and readahead dispatch can be serialised against page cache
> invalidation. I have a patch for XFS sitting around somewhere that
> implements the ->fadvise method.
> 
> I think there are some other patches floating around to address the
> other readahead mechanisms to only be done under filesytem IO locks,
> but I haven't had time to dig into it any further. Readahead from
> page faults most definitely needs to be under the MMAPLOCK at
> least so it serialises against fallocate()...

Yes, I have patch to make madvise(MADV_WILLNEED) go through ->fadvise() as
well. I'll post it soon since the rest of the series isn't really dependent
on it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
