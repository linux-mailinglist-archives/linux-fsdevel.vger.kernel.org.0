Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECDD24EBDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 08:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHWGyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 02:54:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:64468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHWGyP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 02:54:15 -0400
IronPort-SDR: nH2ICmNsAsOXVWXH85bDjkwzluQayNTl8YJRbU3cHTQREeUZGt3TLicbqFF3ChoFFj/uQBYBzY
 KxCS4xmqNYxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9721"; a="143416653"
X-IronPort-AV: E=Sophos;i="5.76,343,1592895600"; 
   d="scan'208";a="143416653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 23:54:15 -0700
IronPort-SDR: yAKzVZKnxtG1XrG//rBh0HhVBuobazBb3eMJ1t0SVyhJPMMJsHGpHS66FsXpDlnjI3yFWpYkZj
 0xMaBbsVeQkQ==
X-IronPort-AV: E=Sophos;i="5.76,343,1592895600"; 
   d="scan'208";a="442804294"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 23:54:14 -0700
Date:   Sat, 22 Aug 2020 23:54:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Hao Li <lihao2018.fnst@cn.fujitsu.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, y-goto@fujitsu.com
Subject: Re: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if
 DCACHE_REFERENCED is set
Message-ID: <20200823065413.GA535011@iweiny-DESK2.sc.intel.com>
References: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
 <20200821174040.GG3142014@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821174040.GG3142014@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:40:41AM -0700, 'Ira Weiny' wrote:
> On Fri, Aug 21, 2020 at 09:59:53AM +0800, Hao Li wrote:
> > Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
> > set from being killed, so the corresponding inode can't be evicted. If
> > the DAX policy of an inode is changed, we can't make policy changing
> > take effects unless dropping caches manually.
> > 
> > This patch fixes this problem and flushes the inode to disk to prepare
> > for evicting it.
> 
> This looks intriguing and I really hope this helps but I don't think this will
> guarantee that the state changes immediately will it?
> 
> Do you have a test case which fails before and passes after?  Perhaps one of
> the new xfstests submitted by Xiao?

Ok I just went back and read your comment before.[1]  Sorry for being a bit
slow on the correlation between this patch and that email.  (BTW, I think it
would have been good to put those examples in the commit message and or
reference that example.)  I'm assuming that with this patch example 2 from [1]
works without a drop_cache _if_ no other task has the file open?

Anyway, with that explanation I think you are correct that this improves the
situation _if_ the only references on the file is controlled by the user and
they have indeed closed all of them.

The code for DCACHE_DONTCACHE as I attempted to write it was that it should
have prevented further caching of the inode such that the inode would evict
sooner.  But it seems you have found a bug/optimization?

In the end, however, if another user (such as a backup running by the admin)
has a reference the DAX change may still be delayed.  So I'm thinking the
documentation should remain largely as is?  But perhaps I am wrong.  Does this
completely remove the need for a drop_caches or only in the example you gave?
Since I'm not a FS expert I'm still not sure.

Regardless, thanks for the fixup!  :-D
Ira

[1] https://lore.kernel.org/linux-xfs/ba98b77e-a806-048a-a0dc-ca585677daf3@cn.fujitsu.com/

> 
> Ira
> 
> > 
> > Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> > ---
> >  fs/dcache.c | 3 ++-
> >  fs/inode.c  | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index ea0485861d93..486c7409dc82 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
> >  	 */
> >  	smp_rmb();
> >  	d_flags = READ_ONCE(dentry->d_flags);
> > -	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
> > +	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
> > +			| DCACHE_DONTCACHE;
> >  
> >  	/* Nothing to do? Dropping the reference was all we needed? */
> >  	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 72c4c347afb7..5218a8aebd7f 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
> >  	}
> >  
> >  	state = inode->i_state;
> > -	if (!drop) {
> > +	if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
> >  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> >  		spin_unlock(&inode->i_lock);
> >  
> > -- 
> > 2.28.0
> > 
> > 
> > 
