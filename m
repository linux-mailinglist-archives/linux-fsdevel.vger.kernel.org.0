Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C491DE5E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgEVLsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 07:48:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEVLsw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 07:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18949AE41;
        Fri, 22 May 2020 11:48:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7834A1E126B; Fri, 22 May 2020 13:48:48 +0200 (CEST)
Date:   Fri, 22 May 2020 13:48:48 +0200
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
Subject: Re: [PATCH V4 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200522114848.GC14199@quack2.suse.cz>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521191313.261929-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-05-20 12:13:12, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> 
> Set the flag to be user visible and changeable.  Set the flag to be
> inherited.  Allow applications to change the flag at any time with the
> exception of if VERITY or ENCRYPT is set.
> 
> Disallow setting VERITY or ENCRYPT if DAX is set.
> 
> Finally, on regular files, flag the inode to not be cached to facilitate
> changing S_DAX on the next creation of the inode.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

...

> @@ -303,6 +318,16 @@ static int ext4_ioctl_setflags(struct inode *inode,
>  	unsigned int jflag;
>  	struct super_block *sb = inode->i_sb;
>  
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX)) {
> +		if (ext4_test_inode_flag(inode, EXT4_INODE_VERITY) ||
> +		    ext4_test_inode_flag(inode, EXT4_INODE_ENCRYPT) ||
> +		    ext4_test_inode_state(inode,
> +					  EXT4_STATE_VERITY_IN_PROGRESS)) {
> +			err = -EOPNOTSUPP;
> +			goto flags_out;
> +		}
> +	}

The way this check is implemented wouldn't IMO do what we need... It
doesn't check the flags that are being set but just the current inode
state. I think it should rather be:

	if ((flags ^ oldflags) & EXT4_INODE_DAX_FL) {
		...
	}

And perhaps move this to a place in ext4_ioctl_setflags() where we check
other similar conflicts.

And then we should check conflicts with the journal flag as well, as I
mentioned in reply to the first patch. There it is more complicated by the
fact that we should disallow setting of both EXT4_INODE_DAX_FL and
EXT4_JOURNAL_DATA_FL at the same time so the checks will be somewhat more
complicated.

								Honza

> +
>  	/* Is it quota file? Do not allow user to mess with it */
>  	if (ext4_is_quota_file(inode))
>  		goto flags_out;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
