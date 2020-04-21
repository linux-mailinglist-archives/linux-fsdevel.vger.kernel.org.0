Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20D91B31BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDUVPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 17:15:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:56627 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgDUVPz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:55 -0400
IronPort-SDR: l7zdTU6JI+5/skH8yRDJzyY1J6A6LaXGnb45/grQ2PCETZVAG0vXbPH19JRZp03wp1TS3rTCYG
 LbIsR2ayMFfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 14:15:54 -0700
IronPort-SDR: ddiadRnywX6gsEymptcBeSspi/JXDa1bXSdHzolWtcLj8QO+Av62LEnLmlRduCvJ9U3MTu+X1n
 pVrCRowtckyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="247279829"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2020 14:15:53 -0700
Date:   Tue, 21 Apr 2020 14:15:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200421211553.GC3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-10-ira.weiny@intel.com>
 <20200421202519.GC6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421202519.GC6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:25:19PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 21, 2020 at 12:17:51PM -0700, ira.weiny@intel.com wrote:
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
> > 
> > ---

[snip]

> > diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> > index de76f7f60695..3c8f44477804 100644
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -559,7 +559,7 @@ xfs_iget_cache_miss(
> >  	 */
> >  	iflags = XFS_INEW;
> >  	if (flags & XFS_IGET_DONTCACHE)
> > -		VFS_I(ip)->i_state |= I_DONTCACHE;
> > +		mark_inode_dontcache(VFS_I(ip));
> >  	ip->i_udquot = NULL;
> >  	ip->i_gdquot = NULL;
> >  	ip->i_pdquot = NULL;
> > diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> > index c1488cc84fd9..56b1482d9223 100644
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -177,6 +177,8 @@ struct dentry_operations {
> >  
> >  #define DCACHE_REFERENCED		0x00000040 /* Recently used, don't discard. */
> >  
> > +#define DCACHE_DONTCACHE		0x00000080 /* don't cache on final dput() */
> 
> "Purge from memory on final dput()"?

Sounds good to me,
Ira

> 
> --D
> 
