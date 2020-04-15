Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DF1A9F53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441296AbgDOMI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 08:08:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441289AbgDOMIu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:08:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E6A2FABB2;
        Wed, 15 Apr 2020 12:08:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9FD9B1E1250; Wed, 15 Apr 2020 14:08:46 +0200 (CEST)
Date:   Wed, 15 Apr 2020 14:08:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200415120846.GG6126@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-5-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-04-20 21:00:26, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> 
> Set the flag to be user visible and changeable.  Set the flag to be
> inherited.  Allow applications to change the flag at any time.
> 
> Finally, on regular files, flag the inode to not be cached to facilitate
> changing S_DAX on the next creation of the inode.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/ext4/ext4.h  | 13 +++++++++----
>  fs/ext4/ioctl.c | 21 ++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 61b37a052052..434021fcec88 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -415,13 +415,16 @@ struct flex_groups {
>  #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
>  #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
>  #define EXT4_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
> +
> +#define EXT4_DAX_FL			0x00800000 /* Inode is DAX */
> +

You seem to be using somewhat older kernel... EXT4_EOFBLOCKS_FL doesn't
exist anymore (but still it's good to leave it reserved for some time so
the value you've chosen is OK).

> @@ -813,6 +818,17 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>  	return error;
>  }
>  
> +static void ext4_dax_dontcache(struct inode *inode, unsigned int flags)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	if (S_ISDIR(inode->i_mode))
> +		return;
> +
> +	if ((ei->i_flags ^ flags) == EXT4_DAX_FL)
> +		inode->i_state |= I_DONTCACHE;
> +}
> +

You probably want to use the function you've introduced in the XFS series
here...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
