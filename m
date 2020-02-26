Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA41703D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgBZQKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:10:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:25114 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgBZQKF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:10:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 08:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="350419564"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 08:10:04 -0800
Date:   Wed, 26 Feb 2020 08:10:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Halliday <jonathan.halliday@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200226161004.GB22036@iweiny-DESK2.sc.intel.com>
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
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:28:57AM +0000, Jonathan Halliday wrote:
> 
> Hi All
> 
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
> via the O/S cache in the traditional manner.

This patch set implements this capability.

> Bonus points if I can do it
> over non-overlapping ranges in a file without closing the DAX mode mmap,
> since then the segments are entirely logical instead of needing separate
> physical files.

But it is too hard to do so while an mmap is in place so it can't do this.  So
no bonus points...

> 
> I note a comment below regarding a per-directly setting, but don't have the
> background to fully understand what's being suggested. However, I'll note
> here that I can live with a per-directory granularity, as relinking a file
> into a new dir is a constant time operation, whilst the move described above
> isn't. So if a per-directory granularity is easier than a per-file one
> that's fine, though as a person with only passing knowledge of filesystem
> design I don't see how having multiple links to a file can work cleanly in
> that case.

The more I think about it the more I'm not comfortable with a directory option.
soft links and hard links complicate that IMO.  The current inheritance model
is at file creation time and the file sticks with that state (mode).  That is
easy enough and carry's with the file without having the complexity of possibly
looking at the wrong parent directory.

Ira


> 
> Hope that helps.
> 
> Jonathan
> 
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
> 
> 
> 
> On 25/02/2020 19:37, Jeff Moyer wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> > 
> > > And my point is that if we ensure S_DAX can only be checked if there
> > > are no blocks on the file, is is fairly easy to provide the same
> > > guarantee.  And I've not heard any argument that we really need more
> > > flexibility than that.  In fact I think just being able to change it
> > > on the parent directory and inheriting the flag might be more than
> > > plenty, which would lead to a very simple implementation without any
> > > of the crazy overhead in this series.
> > 
> > I know of one user who had at least mentioned it to me, so I cc'd him.
> > Jonathan, can you describe your use case for being able to change a
> > file between dax and non-dax modes?  Or, if I'm misremembering, just
> > correct me?
> > 
> > Thanks!
> > Jeff
> > 
> 
> -- 
> Registered in England and Wales under Company Registration No. 03798903
> Directors: Michael Cunningham, Michael ("Mike") O'Neill, Eric Shander
> 
