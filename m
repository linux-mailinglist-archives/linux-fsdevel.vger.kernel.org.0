Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897E11A83A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgDNPpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:45:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:40843 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440812AbgDNPpE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:45:04 -0400
IronPort-SDR: QtunTgQ6lzJWG6poeTBxJsSNF1lDilE/txO1AWkwswSGvn577/5YpsW0a1uvWoW/eC767pz7GH
 Az1eXDCv+Qbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 08:45:02 -0700
IronPort-SDR: hWs3uwLatEhjJd86Tkgb0DG3KjHO8EiVpBpI1389CdNYZ1ahFx2g1A5PeXI+W7DudRTWrql2Zl
 PTSG0PQ6wTAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="242030231"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2020 08:45:02 -0700
Date:   Tue, 14 Apr 2020 08:45:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 7/9] fs: Define I_DONTCACNE in VFS layer
Message-ID: <20200414154501.GH1649878@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-8-ira.weiny@intel.com>
 <20200414152630.GE28226@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414152630.GE28226@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:26:30PM +0200, Jan Kara wrote:
> On Sun 12-04-20 22:40:44, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DAX effective mode changes (setting of S_DAX) require inode eviction.
> > 
> > Define a flag which can be set to inform the VFS layer that inodes
> > should not be cached.  This will expedite the eviction of those nodes
> > requiring reload.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> This inode flag will have a limited impact because usually dentry will
> still hold inode reference. So until dentry is evicted, inode stays as
> well.

Agreed but at least this keeps the inode from being cached until that time.

FWIW the ext4 patches seem to have a much longer delay when issuing drop_caches
and I'm not 100% sure why.  I've sent out those patches RFC to get the
discussions started.  I feel like I have missed something there but it does
eventually flip the S_DAX flag.

> So I think we'd need something like DCACHE_DONTCACHE flag as well to
> discard a dentry whenever dentry usecount hits zero (which will be
> generally on last file close). What do you think?

I wanted to do something like this but I was not sure how to trigger the
DCACHE_DONTCACHE on the correct 'parent' dentry.  Can't their be multiple
dentries pointing to the same inode?

In which case, would you need to flag them all?

Ira

> 
> And I'd note that checking for I_DONTCACHE flag in dput() isn't
> straightforward because of locking so that's why I suggest separate dentry
> flag.
> 
> 								Honza
> 
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
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
