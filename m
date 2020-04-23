Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6231B6A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 01:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgDWXip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 19:38:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:19223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgDWXip (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:38:45 -0400
IronPort-SDR: UsBmFeQ5wYXus9/dg+eHAl5bz/ag+ZHvU5y0MHBdbt3kpLZY8fCdVbgqiy7x02WaCNj8x/9Jfz
 xj6He1zlYZlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 16:38:44 -0700
IronPort-SDR: Ay5kz9diZ69oZHhCrNMcInn+tS8GYQ2LZFIBKiIdKXXft+yMe0sOT0D4/UiGHeVBopF7Fi7Uba
 W1bPhGDfk8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; 
   d="scan'208";a="335158850"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2020 16:38:25 -0700
Date:   Thu, 23 Apr 2020 16:38:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 10/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200423233824.GC4088835@iweiny-DESK2.sc.intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-11-ira.weiny@intel.com>
 <20200423225734.GY27860@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423225734.GY27860@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 08:57:34AM +1000, Dave Chinner wrote:
> On Wed, Apr 22, 2020 at 02:21:01PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DCACHE_DONTCACHE indicates a dentry should not be cached on final
> > dput().
> > 
> > Also add a helper function to mark DCACHE_DONTCACHE on all dentries
> > pointing to a specific inode when that inode is being set I_DONTCACHE.
> > 
> > This facilitates dropping dentry references to inodes sooner which
> > require eviction to swap S_DAX mode.
> > 
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Code looks fine....
> 
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(generic_delete_inode);
> >  
> > +void mark_inode_dontcache(struct inode *inode)
> > +{
> > +	struct dentry *de;
> > +
> > +	spin_lock(&inode->i_lock);
> > +	hlist_for_each_entry(de, &inode->i_dentry, d_u.d_alias) {
> > +		spin_lock(&de->d_lock);
> > +		de->d_flags |= DCACHE_DONTCACHE;
> > +		spin_unlock(&de->d_lock);
> > +	}
> > +	inode->i_state |= I_DONTCACHE;
> > +	spin_unlock(&inode->i_lock);
> > +}
> > +EXPORT_SYMBOL(mark_inode_dontcache);
> 
> Though I suspect that this should be in fs/dcache.c and not
> fs/inode.c. i.e. nothing in fs/inode.c does dentry list walks, but
> there are several cases in the dcache code where inode dentry walks
> are done under the inode lock (e.g. d_find_alias(inode)).
> 
> So perhaps this should be d_mark_dontcache(inode), which also marks
> the inode as I_DONTCACHE so that everything is evicted on last
> reference...

That does follow an existing pattern.

Al?  Any preference?

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
