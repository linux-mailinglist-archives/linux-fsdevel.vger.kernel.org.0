Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0895F1B5A57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgDWLTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 07:19:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgDWLTx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:19:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E4E5B0BF;
        Thu, 23 Apr 2020 11:19:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 765051E1293; Thu, 23 Apr 2020 13:19:51 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:19:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 4/5] overlayfs: Check for range bounds before calling
 i_op->fiemap()
Message-ID: <20200423111951.GK3737@quack2.suse.cz>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <39b4bf94f6723831a9798237bb1b4ae14da04d98.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b4bf94f6723831a9798237bb1b4ae14da04d98.1587555962.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23-04-20 16:17:56, Ritesh Harjani wrote:
> Underlying fs may not be able to handle the length in fiemap
> beyond sb->s_maxbytes. So similar to how VFS ioctl does it,
> add fiemap_check_ranges() check in ovl_fiemap() as well
> before calling underlying fs i_op->fiemap() call.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/overlayfs/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Yeah, makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 79e8994e3bc1..9bcd2e96faad 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -455,16 +455,21 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	int err;
>  	struct inode *realinode = ovl_inode_real(inode);
>  	const struct cred *old_cred;
> +	u64 length;
>  
>  	if (!realinode->i_op->fiemap)
>  		return -EOPNOTSUPP;
>  
> +	err = fiemap_check_ranges(realinode->i_sb, start, len, &length);
> +	if (err)
> +		return err;
> +
>  	old_cred = ovl_override_creds(inode->i_sb);
>  
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(realinode->i_mapping);
>  
> -	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
> +	err = realinode->i_op->fiemap(realinode, fieinfo, start, length);
>  	revert_creds(old_cred);
>  
>  	return err;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
