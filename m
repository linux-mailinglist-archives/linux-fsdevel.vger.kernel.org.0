Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0C21D2C7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 12:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENKVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 06:21:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENKVt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 06:21:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8958B023;
        Thu, 14 May 2020 10:21:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F66F1E12A8; Thu, 14 May 2020 12:21:46 +0200 (CEST)
Date:   Thu, 14 May 2020 12:21:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/9] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200514102146.GD9569@quack2.suse.cz>
References: <20200514065316.2500078-1-ira.weiny@intel.com>
 <20200514065316.2500078-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514065316.2500078-3-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-05-20 23:53:08, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> flag change is wrong without a corresponding address_space_operations
> update.
> 
> Make the 2 options mutually exclusive by returning an error if DAX was
> set first.
> 
> (Setting DAX is already disabled if Verity is set first.)
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Makes sence. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> ---
> Changes:
> 	remove WARN_ON_ONCE
> 	Add documentation for DAX/Verity exclusivity
> ---
>  Documentation/filesystems/ext4/verity.rst | 7 +++++++
>  fs/ext4/verity.c                          | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/filesystems/ext4/verity.rst b/Documentation/filesystems/ext4/verity.rst
> index 3e4c0ee0e068..51ab1aa17e59 100644
> --- a/Documentation/filesystems/ext4/verity.rst
> +++ b/Documentation/filesystems/ext4/verity.rst
> @@ -39,3 +39,10 @@ is encrypted as well as the data itself.
>  
>  Verity files cannot have blocks allocated past the end of the verity
>  metadata.
> +
> +Verity and DAX
> +--------------
> +
> +Verity and DAX are not compatible and attempts to set both of these flags on a
> +file will fail.
> +
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index dc5ec724d889..f05a09fb2ae4 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
>  	handle_t *handle;
>  	int err;
>  
> +	if (IS_DAX(inode))
> +		return -EINVAL;
> +
>  	if (ext4_verity_in_progress(inode))
>  		return -EBUSY;
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
