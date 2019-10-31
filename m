Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F19EB48A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 17:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfJaQR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 12:17:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:63414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfJaQR7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:17:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 09:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="351689706"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga004.jf.intel.com with ESMTP; 31 Oct 2019 09:17:58 -0700
Date:   Thu, 31 Oct 2019 09:17:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
Message-ID: <20191031161757.GA14771@iweiny-DESK2.sc.intel.com>
References: <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
 <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
 <20191024073446.GA4614@dread.disaster.area>
 <fb4f8be7-bca6-733a-7f16-ced6557f7108@plexistor.com>
 <20191024213508.GB4614@dread.disaster.area>
 <ab101f90-6ec1-7527-1859-5f6309640cfa@plexistor.com>
 <20191025003603.GE4614@dread.disaster.area>
 <20191025204926.GA26184@iweiny-DESK2.sc.intel.com>
 <20191027221039.GL4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027221039.GL4614@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:10:39AM +1100, Dave Chinner wrote:
> On Fri, Oct 25, 2019 at 01:49:26PM -0700, Ira Weiny wrote:

[snip]

> 
> > Currently this works if I remount the fs or if I use <procfs>/drop_caches like
> > Boaz mentioned.
> 
> drop_caches frees all the dentries that don't have an active
> references before it iterates over inodes, thereby dropping the
> cached reference(s) to the inode that pins it in memory before it
> iterates the inode LRU.
> 
> > Isn't there a way to get xfs to do that on it's own?
> 
> Not reliably. Killing all the dentries doesn't guarantee the inode
> will be reclaimed immediately. The ioctl() itself requires an open
> file reference to the inode, and there's no telling how many other
> references there are to the inode that the filesystem a) can't find,
> and b) even if it can find them, it is illegal to release them.
> 
> IOWs, if you are relying on being able to force eviction of inode
> from the cache for correct operation of a user controlled flag, then
> it's just not going to work.

Agree, I see the difficulty of forcing the effective flag to change in this
path.  However, the only thing I am relying on is that the ioctl will change
the physical flag.

IOW I am proposing that the semantic be that changing the physical flag does
_not_ immediately change the effective flag.  With that clarified up front the
user can adjust accordingly.

After thinking about this more I think there is a strong use case to be able to
change the physical flag on a non-zero length file.  That use case is to be
able to restore files from backups.

Therefore, having the effective flag flip at some later time when the a_ops can
safely be changed (for example a remount/drop_cache event) is beneficial.

I propose the user has no direct control over this event and it is mainly used
to restore files from backups which is mainly an admin operation where a
remount is a reasonable thing to do.

Users direct control of the effective flag is through inheritance.  The user
needs to create the file in a DAX enable dir and they get effective operation
right away.

If in the future we can determine a safe way to trigger the a_ops change we can
add that to the semantic as an alternative for users.

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
