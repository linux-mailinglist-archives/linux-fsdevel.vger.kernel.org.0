Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779391A6CBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 21:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbgDMToe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 15:44:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:29540 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbgDMToe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:44:34 -0400
IronPort-SDR: Ae2xt0TSgl1+VtNBnJm1r1VQfZsEIvN07r3gehnhzZAmsi2zfYsfM3u8A0Ft3KGcmrI1CQJCtp
 TBS5JqkT5Guw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 12:44:33 -0700
IronPort-SDR: v+q6zP5bKPmHA88y6ZiO81BAf42afIm8n0sGOl7dCToUlDBSth6eGFpgqbf2PNOyTnsccQEh+U
 NlVotKwkBJsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="256275264"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2020 12:44:32 -0700
Date:   Mon, 13 Apr 2020 12:44:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200413194432.GD1649878@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-8-ira.weiny@intel.com>
 <20200413160929.GW6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413160929.GW6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:09:29AM -0700, Darrick J. Wong wrote:
> > Subject: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
> 
> CACNE -> CACHE.
> 
> On Sun, Apr 12, 2020 at 10:40:44PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DAX effective mode changes (setting of S_DAX) require inode eviction.
> > 
> > Define a flag which can be set to inform the VFS layer that inodes
> > should not be cached.  This will expedite the eviction of those nodes
> > requiring reload.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  include/linux/fs.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index a818ced22961..e2db71d150c3 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2151,6 +2151,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >   *
> >   * I_CREATING		New object's inode in the middle of setting up.
> >   *
> > + * I_DONTCACHE		Do not cache the inode
> 
> "Do not cache" is a bit vague, how about:
> 
> "Evict the inode when the last reference is dropped.
> Do not put it on the LRU list."
> 
> Also, shouldn't xfs_ioctl_setattr be setting I_DONTCACHE if someone
> changes FS_XFLAG_DAX (and there are no mount option overrides)?  I don't
> see any user of I_DONTCACHE in this series.
> 
> (Also also, please convert XFS_IDONTCACHE, since it's a straightforward
> conversion...)

AFAICT XFS_IDONTCACHE is not exactly the same because it can be cleared if
someone access' the inode before it is evicted.  Dave mentioned that we could
probably do this but I was not 100% sure if that would change some other
behavior.

I'm happy to remove XFS_IDONTCACHE if we are sure that it will not regress
something in the bulkstat code?  (I don't know exactly what bulkstat does so
I'm not expert here...  Was just doing what seemed safest)

Ira

> 
> --D
> 
> > + *
> >   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> >   */
> >  #define I_DIRTY_SYNC		(1 << 0)
> > @@ -2173,6 +2175,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> >  #define I_WB_SWITCH		(1 << 13)
> >  #define I_OVL_INUSE		(1 << 14)
> >  #define I_CREATING		(1 << 15)
> > +#define I_DONTCACHE		(1 << 16)
> >  
> >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> >  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> > @@ -3042,7 +3045,8 @@ extern int inode_needs_sync(struct inode *inode);
> >  extern int generic_delete_inode(struct inode *inode);
> >  static inline int generic_drop_inode(struct inode *inode)
> >  {
> > -	return !inode->i_nlink || inode_unhashed(inode);
> > +	return !inode->i_nlink || inode_unhashed(inode) ||
> > +		(inode->i_state & I_DONTCACHE);
> >  }
> >  
> >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> > -- 
> > 2.25.1
> > 
