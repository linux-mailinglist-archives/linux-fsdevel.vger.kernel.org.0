Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5291DB528
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETNhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 09:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETNhb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 09:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32221B249;
        Wed, 20 May 2020 13:37:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B3B231E126F; Wed, 20 May 2020 15:37:28 +0200 (CEST)
Date:   Wed, 20 May 2020 15:37:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/8] fs/ext4: Update ext4_should_use_dax()
Message-ID: <20200520133728.GD30597@quack2.suse.cz>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520055753.3733520-5-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-05-20 22:57:49, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> S_DAX should only be enabled when the underlying block device supports
> dax.
> 
> Change ext4_should_use_dax() to check for device support prior to the
> over riding mount option.
> 
> While we are at it change the function to ext4_should_enable_dax() as
> this better reflects the ask as well as matches xfs.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

...

> @@ -4412,7 +4410,13 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY))
>  		return false;
> -	return true;
> +	if (!bdev_dax_supported(inode->i_sb->s_bdev,
> +				inode->i_sb->s_blocksize))
> +		return false;
> +	if (test_opt(inode->i_sb, DAX_ALWAYS))
> +		return true;
> +
> +	return false;
>  }

Now that I think about it - shouldn't we rather cache the result of
bdev_dax_supported() in sb on mount and then just check the flag here?
Because bdev_dax_supported() isn't exactly cheap (it does a lot of checks
and mappings, tries to read from the pmem, ...).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
