Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816EA16FDBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgBZLbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:31:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:43854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBZLbe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:31:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F399AD5C;
        Wed, 26 Feb 2020 11:31:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 52C641E0EA2; Wed, 26 Feb 2020 12:31:30 +0100 (CET)
Date:   Wed, 26 Feb 2020 12:31:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jonathan Halliday <jonathan.halliday@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200226113130.GG10728@quack2.suse.cz>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-8-ira.weiny@intel.com>
 <20200221174449.GB11378@lst.de>
 <20200221224419.GW10776@dread.disaster.area>
 <20200224175603.GE7771@lst.de>
 <20200225000937.GA10776@dread.disaster.area>
 <20200225173633.GA30843@lst.de>
 <x49fteyh313.fsf@segfault.boston.devel.redhat.com>
 <a126276c-d252-6050-b6ee-4d6448d45fac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a126276c-d252-6050-b6ee-4d6448d45fac@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed 26-02-20 09:28:57, Jonathan Halliday wrote:
> I'm a middleware developer, focused on how Java (JVM) workloads can benefit
> from app-direct mode pmem. Initially the target is apps that need a fast
> binary log for fault tolerance: the classic database WAL use case;
> transaction coordination systems; enterprise message bus persistence and
> suchlike. Critically, there are cases where we use log based storage, i.e.
> it's not the strict 'read rarely, only on recovery' model that a classic db
> may have, but more of a 'append only, read many times' event stream model.
> 
> Think of the log oriented data storage as having logical segments (let's
> implement them as files), of which the most recent is being appended to
> (read_write) and the remaining N-1 older segments are full and sealed, so
> effectively immutable (read_only) until discarded. The tail segment needs to
> be in DAX mode for optimal write performance, as the size of the append may
> be sub-block and we don't want the overhead of the kernel call anyhow. So
> that's clearly a good fit for putting on a DAX fs mount and using mmap with
> MAP_SYNC.
> 
> However, we want fast read access into the segments, to retrieve stored
> records. The small access index can be built in volatile RAM (assuming we're
> willing to take the startup overhead of a full file scan at recovery time)
> but the data itself is big and we don't want to move it all off pmem. Which
> means the requirements are now different: we want the O/S cache to pull hot
> data into fast volatile RAM for us, which DAX explicitly won't do.
> Effectively a poor man's 'memory mode' pmem, rather than app-direct mode,
> except here we're using the O/S rather than the hardware memory controller
> to do the cache management for us.
> 
> Currently this requires closing the full (read_write) file, then copying it
> to a non-DAX device and reopening it (read_only) there. Clearly that's
> expensive and rather tedious. Instead, I'd like to close the MAP_SYNC mmap,
> then, leaving the file where it is, reopen it in a mode that will instead go
> via the O/S cache in the traditional manner. Bonus points if I can do it
> over non-overlapping ranges in a file without closing the DAX mode mmap,
> since then the segments are entirely logical instead of needing separate
> physical files.
> 
> I note a comment below regarding a per-directly setting, but don't have the
> background to fully understand what's being suggested. However, I'll note
> here that I can live with a per-directory granularity, as relinking a file
> into a new dir is a constant time operation, whilst the move described above
> isn't. So if a per-directory granularity is easier than a per-file one
> that's fine, though as a person with only passing knowledge of filesystem
> design I don't see how having multiple links to a file can work cleanly in
> that case.

Well, with per-directory setting, relinking the file will not magically
make it stop using DAX. So your situation would be very similar to the
current one, except "copy to non-DAX device" can be replaced by "copy to
non-DAX directory". Maybe the "copy" part could be actually reflink which
would make it faster.

> P.S. I'll cheekily take the opportunity of having your attention to tack on
> one minor gripe about the current system: The only way to know if a mmap
> with MAP_SYNC will work is to try it and catch the error. Which would be
> reasonable if it were free of side effects.  However, the process requires
> first expanding the file to at least the size of the desired map, which is
> done non-atomically i.e. is user visible. There are thus nasty race
> conditions in the cleanup, where after a failed mmap attempt (e.g the device
> doesn't support DAX), we try to shrink the file back to its original size,
> but something else has already opened it at its new, larger size. This is
> not theoretical: I got caught by it whilst adapting some of our middleware
> to use pmem.  Therefore, some way to probe the file path for its capability
> would be nice, much the same as I can e.g. inspect file permissions to (more
> or less) evaluate if I can write it without actually mutating it.  Thanks!

Well, reporting error on mmap(2) is the only way how to avoid
time-to-check-time-to-use races. And these are very important when we are
speaking about data integrity guarantees. So that's not going to change.
But with Ira's patches you could use statx(2) to check whether file at
least supports DAX and so avoid doing mmap check with the side effects in
the common case where it's hopeless... I'd also think that you could
currently do mmap check with the current file size and if it succeeds,
expand the file to the desired size and mmap again. It's not ideal but it
should work.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
