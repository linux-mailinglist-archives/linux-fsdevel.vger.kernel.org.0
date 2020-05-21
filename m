Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB51DCAF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 12:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEUKYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 06:24:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:55580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgEUKYg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 06:24:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6B51ACC3;
        Thu, 21 May 2020 10:24:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4AC971E126F; Thu, 21 May 2020 12:24:34 +0200 (CEST)
Date:   Thu, 21 May 2020 12:24:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/8] fs/ext4: Update ext4_should_use_dax()
Message-ID: <20200521102434.GA17431@quack2.suse.cz>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-5-ira.weiny@intel.com>
 <20200520133728.GD30597@quack2.suse.cz>
 <20200520194050.GF3660833@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520194050.GF3660833@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-05-20 12:40:50, Ira Weiny wrote:
> On Wed, May 20, 2020 at 03:37:28PM +0200, Jan Kara wrote:
> > On Tue 19-05-20 22:57:49, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > S_DAX should only be enabled when the underlying block device supports
> > > dax.
> > > 
> > > Change ext4_should_use_dax() to check for device support prior to the
> > > over riding mount option.
> > > 
> > > While we are at it change the function to ext4_should_enable_dax() as
> > > this better reflects the ask as well as matches xfs.
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ...
> > 
> > > @@ -4412,7 +4410,13 @@ static bool ext4_should_use_dax(struct inode *inode)
> > >  		return false;
> > >  	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
> > >  		return false;
> > > -	return true;
> > > +	if (!bdev_dax_supported(inode->i_sb->s_bdev,
> > > +				inode->i_sb->s_blocksize))
> > > +		return false;
> > > +	if (test_opt(inode->i_sb, DAX_ALWAYS))
> > > +		return true;
> > > +
> > > +	return false;
> > >  }
> > 
> > Now that I think about it - shouldn't we rather cache the result of
> > bdev_dax_supported() in sb on mount and then just check the flag here?
> > Because bdev_dax_supported() isn't exactly cheap (it does a lot of checks
> > and mappings, tries to read from the pmem, ...).
> 
> Sounds reasonable.
> 
> Not sure which flags are appropriate.  So add it here?

Yes, sounds good. Thanks!

								Honza

> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1a3daf2d18ef..0b4db9ce7756 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1979,6 +1979,7 @@ static inline bool ext4_has_incompat_features(struct super_block *sb)
>   */
>  #define EXT4_FLAGS_RESIZING    0
>  #define EXT4_FLAGS_SHUTDOWN    1
> +#define EXT4_FLAGS_BDEV_IS_DAX 2
>  
>  static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
>  {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
