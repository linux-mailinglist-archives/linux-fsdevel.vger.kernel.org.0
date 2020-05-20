Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6301DB5FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETOLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 10:11:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETOLl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 10:11:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1655AABCE;
        Wed, 20 May 2020 14:11:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 719CE1E126F; Wed, 20 May 2020 16:11:38 +0200 (CEST)
Date:   Wed, 20 May 2020 16:11:38 +0200
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
Subject: Re: [PATCH V3 7/8] fs/ext4: Introduce DAX inode flag
Message-ID: <20200520141138.GE30597@quack2.suse.cz>
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520055753.3733520-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-05-20 22:57:52, ira.weiny@intel.com wrote:
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

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

One comment below:

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5ba65eb0e2ef..be9713e898eb 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1323,6 +1323,9 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
>  	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
>  		return -EINVAL;

AFAIU this check is here so that fscrypt_inherit_context() is able call us
and we can clear S_DAX flag. So can't we rather move this below the
EXT4_INODE_DAX check and change this to

	IS_DAX(inode) && !(inode->i_flags & I_NEW)

? Because as I'm reading the code now, this should never trigger?

>  
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
> +		return -EOPNOTSUPP;
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
