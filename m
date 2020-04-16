Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF91AB6CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 06:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404467AbgDPE3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 00:29:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:12729 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404389AbgDPE27 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:28:59 -0400
IronPort-SDR: 7SQp4IvJlew/b1fUSbbu5TMOOzrYLqCVcWkXWZ3rPAFOIb+nxRlfyU8yBQrxHzme9DQk0z6+Xq
 SBSsJglwiVew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 21:28:58 -0700
IronPort-SDR: 1g5z3mqT7MPKc5WE8UlYn4auWnJz61lGB4LK3uTGRmkzOPkisju/QyJnL7n4DD3IWRDLMJxNUp
 uJsruy5zF1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="427687659"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 15 Apr 2020 21:28:58 -0700
Date:   Wed, 15 Apr 2020 21:28:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 08/11] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200416042857.GH2309605@iweiny-DESK2.sc.intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-9-ira.weiny@intel.com>
 <20200415085216.GE501@quack2.suse.cz>
 <20200415151832.GQ6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415151832.GQ6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:18:32AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 15, 2020 at 10:52:16AM +0200, Jan Kara wrote:
> > There's a typo in the subject - I_DONTCACNE.
> > 
> > On Tue 14-04-20 23:45:20, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > DAX effective mode changes (setting of S_DAX) require inode eviction.
> > > 
> > > Define a flag which can be set to inform the VFS layer that inodes
> > > should not be cached.  This will expedite the eviction of those nodes
> > > requiring reload.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  include/linux/fs.h | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index a818ced22961..e2db71d150c3 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2151,6 +2151,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> > >   *
> > >   * I_CREATING		New object's inode in the middle of setting up.
> > >   *
> > > + * I_DONTCACHE		Do not cache the inode
> > > + *
> > 
> > Maybe, I'd be more specific here and write: "Evict inode as soon as it is
> > not used anymore"?
> 
> I had the same two comments about the V7 version of this patch...

Sorry I must have missed it.

Done for V9,
Ira

> 
> --D
> 
> > Otherwise the patch looks good to me so feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > Also it would be good to CC Al Viro on this one (and the dentry flag) I
> > guess.
> > 
> > 								Honza
> > 
> > >   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> > >   */
> > >  #define I_DIRTY_SYNC		(1 << 0)
> > > @@ -2173,6 +2175,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
> > >  #define I_WB_SWITCH		(1 << 13)
> > >  #define I_OVL_INUSE		(1 << 14)
> > >  #define I_CREATING		(1 << 15)
> > > +#define I_DONTCACHE		(1 << 16)
> > >  
> > >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> > >  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> > > @@ -3042,7 +3045,8 @@ extern int inode_needs_sync(struct inode *inode);
> > >  extern int generic_delete_inode(struct inode *inode);
> > >  static inline int generic_drop_inode(struct inode *inode)
> > >  {
> > > -	return !inode->i_nlink || inode_unhashed(inode);
> > > +	return !inode->i_nlink || inode_unhashed(inode) ||
> > > +		(inode->i_state & I_DONTCACHE);
> > >  }
> > >  
> > >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> > > -- 
> > > 2.25.1
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
