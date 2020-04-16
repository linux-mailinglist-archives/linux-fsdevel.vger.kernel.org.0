Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE801AB6F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 06:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbgDPEzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 00:55:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:5444 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392050AbgDPEzN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:55:13 -0400
IronPort-SDR: Xe/Yh5tA/rdPb13tcbu9p8/t4nh7R4q7k0FoQOwsYA1ikqg3bOLxe9OgxLCLzQ1ViFPjoobkq9
 8doApZkQwBqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 21:55:12 -0700
IronPort-SDR: pZtd7vRp+1wAfFFUc4dYQhNxwL7ML1BPxtXVmt14bXI9MjzxEXGDgb6vWxttxE6aJuQpPdluMT
 MpBvmjg1273Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="257087980"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2020 21:55:11 -0700
Date:   Wed, 15 Apr 2020 21:55:11 -0700
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
Subject: Re: [PATCH V8 09/11] fs: Introduce DCACHE_DONTCACHE
Message-ID: <20200416045511.GI2309605@iweiny-DESK2.sc.intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-10-ira.weiny@intel.com>
 <20200415090153.GF501@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415090153.GF501@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:01:53AM +0200, Jan Kara wrote:
> On Tue 14-04-20 23:45:21, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DCACHE_DONTCACHE indicates a dentry should not be cached on final
> > dput().
> > 
> > Also add a helper function which will flag I_DONTCACHE as well ad
> > DCACHE_DONTCACHE on all dentries point to a specified inode.
> 
> I think this sentence needs more work :). Like: Also add a helper function
> which will mark the inode with I_DONTCACHE flag and also mark all dentries
> pointing to a specified inode as DCACHE_DONTCACHE.
> 
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V7:
> > 	new patch
> > ---
> >  fs/dcache.c            |  4 ++++
> >  fs/inode.c             | 15 +++++++++++++++
> >  include/linux/dcache.h |  2 ++
> >  include/linux/fs.h     |  1 +
> >  4 files changed, 22 insertions(+)
> 
> ...
> 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 93d9252a00ab..b8b1917a324e 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1526,6 +1526,21 @@ int generic_delete_inode(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(generic_delete_inode);
> >  
> > +void flag_inode_dontcache(struct inode *inode)
> 
> mark_inode_dontcache?

That works.

> 
> > +{
> > +	struct dentry *dent;
> 
> This is really nitpicking but dentry variables are usually called 'de' or
> 'dentry' :)

Easy change.  done.

> 
> > +
> > +	rcu_read_lock();
> 
> I don't think this list is safe to traverse under RCU. E.g.
> dentry_unlink_inode() does hlist_del_init(&dentry->d_u.d_alias). Usually,
> we traverse this list under inode->i_lock protection AFAICS.

Ah...  not sure where I got that.  I thought I found this locked with rcu
somewhere but I obviously got confused.  And I did not even use the rcu version
of the list iterator...  :-(

I'll clean it up, thanks for the review,
Ira

> 
> 								Honza
> 
> > +	hlist_for_each_entry(dent, &inode->i_dentry, d_u.d_alias) {
> > +		spin_lock(&dent->d_lock);
> > +		dent->d_flags |= DCACHE_DONTCACHE;
> > +		spin_unlock(&dent->d_lock);
> > +	}
> > +	rcu_read_unlock();
> > +	inode->i_state |= I_DONTCACHE;
> > +}
> > +EXPORT_SYMBOL(flag_inode_dontcache);
> > +
> >  /*
> >   * Called when we're dropping the last reference
> >   * to an inode.
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
