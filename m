Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFECF1AB2C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 22:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442070AbgDOUf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 16:35:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:47253 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442057AbgDOUfr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:35:47 -0400
IronPort-SDR: v2jzf+uZCIhhwil2OtdLqgKtlqGdIXa/vgh3xh4fWHLxA6IwhKdoPHqVXd/EsfJgErqcLvmFq1
 ZWAgLrv9GNlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 13:35:45 -0700
IronPort-SDR: /55+O5N/UbItG3G97jMjCRmgjrO6760jL2891MlOgBl73B9Ign+1Bxjt8KEJp/URH6OJVIh6Ra
 cVUrFMAToMQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="454056534"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2020 13:35:44 -0700
Date:   Wed, 15 Apr 2020 13:35:44 -0700
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
Subject: Re: [PATCH RFC 3/8] fs/ext4: Disallow encryption if inode is DAX
Message-ID: <20200415203544.GC2309605@iweiny-DESK2.sc.intel.com>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-4-ira.weiny@intel.com>
 <20200415120241.GF6126@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415120241.GF6126@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:02:41PM +0200, Jan Kara wrote:
> On Mon 13-04-20 21:00:25, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Encryption and DAX are incompatible.  Changing the DAX mode due to a
> > change in Encryption mode is wrong without a corresponding
> > address_space_operations update.
> > 
> > Make the 2 options mutually exclusive by returning an error if DAX was
> > set first.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/ext4/super.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 0c7c4adb664e..b14863058115 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1325,7 +1325,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> >  	if (inode->i_ino == EXT4_ROOT_INO)
> >  		return -EPERM;
> >  
> > -	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
> > +	if (WARN_ON_ONCE(IS_DAX(inode)))
> 
> Also here I don't think WARN_ON_ONCE() is warranted once we allow per-inode
> setting of DAX. It will then become a regular error condition...

Removed.
Ira

> 
> 								Honza
> 
> >  		return -EINVAL;
> >  
> >  	res = ext4_convert_inline_data(inode);
> > @@ -1349,10 +1349,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> >  			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
> >  			ext4_clear_inode_state(inode,
> >  					EXT4_STATE_MAY_INLINE_DATA);
> > -			/*
> > -			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
> > -			 * S_DAX may be disabled
> > -			 */
> >  			ext4_set_inode_flags(inode);
> >  		}
> >  		return res;
> > @@ -1376,10 +1372,6 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
> >  				    ctx, len, 0);
> >  	if (!res) {
> >  		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
> > -		/*
> > -		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
> > -		 * S_DAX may be disabled
> > -		 */
> >  		ext4_set_inode_flags(inode);
> >  		res = ext4_mark_inode_dirty(handle, inode);
> >  		if (res)
> > -- 
> > 2.25.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
