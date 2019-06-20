Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134D14CFE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 16:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfFTODs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 10:03:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfFTODs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:03:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05638AF85;
        Thu, 20 Jun 2019 14:03:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A12B31E434F; Thu, 20 Jun 2019 16:03:45 +0200 (CEST)
Date:   Thu, 20 Jun 2019 16:03:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] vfs: don't allow most setxattr to immutable files
Message-ID: <20190620140345.GI30243@quack2.suse.cz>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
 <156022840560.3227213.4776913678782966728.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156022840560.3227213.4776913678782966728.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 10-06-19 21:46:45, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> The chattr manpage has this to say about immutable files:
> 
> "A file with the 'i' attribute cannot be modified: it cannot be deleted
> or renamed, no link can be created to this file, most of the file's
> metadata can not be modified, and the file can not be opened in write
> mode."
> 
> However, we don't actually check the immutable flag in the setattr code,
> which means that we can update inode flags and project ids and extent
> size hints on supposedly immutable files.  Therefore, reject setflags
> and fssetxattr calls on an immutable file if the file is immutable and
> will remain that way.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/inode.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index a3757051fd55..adfb458bf533 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2184,6 +2184,17 @@ int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags)
>  	    !capable(CAP_LINUX_IMMUTABLE))
>  		return -EPERM;
>  
> +	/*
> +	 * We aren't allowed to change any other flags if the immutable flag is
> +	 * already set and is not being unset.
> +	 */
> +	if ((oldflags & FS_IMMUTABLE_FL) &&
> +	    (flags & FS_IMMUTABLE_FL)) {
> +		if ((oldflags & ~FS_IMMUTABLE_FL) !=
> +		    (flags & ~FS_IMMUTABLE_FL))

This check looks a bit strange when you've just check FS_IMMUTABLE_FL isn't
changing... Why not just oldflags != flags?

> +	if ((old_fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
> +	    (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)) {
> +		if ((old_fa->fsx_xflags & ~FS_XFLAG_IMMUTABLE) !=
> +		    (fa->fsx_xflags & ~FS_XFLAG_IMMUTABLE))

Ditto here...

> +			return -EPERM;
> +		if (old_fa->fsx_projid != fa->fsx_projid)
> +			return -EPERM;
> +		if ((fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
> +				       FS_XFLAG_EXTSZINHERIT)) &&
> +		    old_fa->fsx_extsize != fa->fsx_extsize)
> +			return -EPERM;
> +		if ((old_fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +		    old_fa->fsx_cowextsize != fa->fsx_cowextsize)
> +			return -EPERM;
> +	}
> +
>  	/* Extent size hints of zero turn off the flags. */
>  	if (fa->fsx_extsize == 0)
>  		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
