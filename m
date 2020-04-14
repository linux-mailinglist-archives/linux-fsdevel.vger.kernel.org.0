Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E21A8401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391205AbgDNP7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:59:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbgDNP7b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:59:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7EE14AC77;
        Tue, 14 Apr 2020 15:59:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED4581E125F; Tue, 14 Apr 2020 17:59:27 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:59:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200414155927.GH28226@quack2.suse.cz>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-8-ira.weiny@intel.com>
 <20200414152630.GE28226@quack2.suse.cz>
 <20200414154501.GH1649878@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414154501.GH1649878@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-04-20 08:45:01, Ira Weiny wrote:
> On Tue, Apr 14, 2020 at 05:26:30PM +0200, Jan Kara wrote:
> > On Sun 12-04-20 22:40:44, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > DAX effective mode changes (setting of S_DAX) require inode eviction.
> > > 
> > > Define a flag which can be set to inform the VFS layer that inodes
> > > should not be cached.  This will expedite the eviction of those nodes
> > > requiring reload.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > This inode flag will have a limited impact because usually dentry will
> > still hold inode reference. So until dentry is evicted, inode stays as
> > well.
> 
> Agreed but at least this keeps the inode from being cached until that time.
> 
> FWIW the ext4 patches seem to have a much longer delay when issuing drop_caches
> and I'm not 100% sure why.  I've sent out those patches RFC to get the
> discussions started.  I feel like I have missed something there but it does
> eventually flip the S_DAX flag.
> 
> > So I think we'd need something like DCACHE_DONTCACHE flag as well to
> > discard a dentry whenever dentry usecount hits zero (which will be
> > generally on last file close). What do you think?
> 
> I wanted to do something like this but I was not sure how to trigger the
> DCACHE_DONTCACHE on the correct 'parent' dentry.  Can't their be multiple
> dentries pointing to the same inode?
> 
> In which case, would you need to flag them all?

There can be multiple dentries in case there are hardlinks. There can be
also multiple entries in case the filesystem is NFS-exported and there are
some disconnected dentries (those will however get discarded automatically
once they are unused). You could actually iterate the list of all dentries
(they are all part of inode->i_dentry list) and mark them all. This would
still miss the case if there are more hardlinks and a dentry for a new link
gets instantiated later but I guess I would not bother with this
cornercase.

								Honza

> > And I'd note that checking for I_DONTCACHE flag in dput() isn't
> > straightforward because of locking so that's why I suggest separate dentry
> > flag.
> > 
> > 								Honza
> > 
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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
