Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846CC38E2D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhEXI4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 04:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhEXI4j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 04:56:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621846509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXP1ICVRdALrxUXsf/z6mZaU8pNPyJpmymmllsZRIGs=;
        b=F3w7GM4icZiUnACFVnJ6d5rP3y7S9oEiydR8fM6SAt9OuhtiyO580UT8kXwp5pFmgbrvmc
        uhLvLPSMJ9G4BKyk6IrCiKgPlpTqrA/gsxvAMtOetVmczCARYEZh1xx8/dxvGjX6zmxS4W
        Iaf3vkwMvYym5kqRENLydAdVrqWuXyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621846509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXP1ICVRdALrxUXsf/z6mZaU8pNPyJpmymmllsZRIGs=;
        b=41IrL3T+qLsrW7C0vlIImptvtNtXIX+Ww/4G+QKYvcC24FpHPTF9byML9CaxU2KOBdulbT
        h6+RDhQ0shRw29DQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85570ABC1;
        Mon, 24 May 2021 08:55:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EA9DD1F2CA2; Mon, 24 May 2021 10:55:08 +0200 (CEST)
Date:   Mon, 24 May 2021 10:55:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     ocfs2-devel@oss.oracle.com, jack@suse.cz,
        joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
Message-ID: <20210524085508.GD32705@quack2.suse.cz>
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521233612.75185-1-junxiao.bi@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-05-21 16:36:12, Junxiao Bi wrote:
> When fallocate punches holes out of inode size, if original isize is in
> the middle of last cluster, then the part from isize to the end of the
> cluster will be zeroed with buffer write, at that time isize is not
> yet updated to match the new size, if writeback is kicked in, it will
> invoke ocfs2_writepage()->block_write_full_page() where the pages out
> of inode size will be dropped. That will cause file corruption. Fix
> this by zero out eof blocks when extending the inode size.
> 
> Running the following command with qemu-image 4.2.1 can get a corrupted
> coverted image file easily.
> 
>     qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>              -O qcow2 -o compat=1.1 $qcow_image.conv
> 
> The usage of fallocate in qemu is like this, it first punches holes out of
> inode size, then extend the inode size.
> 
>     fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
>     fallocate(11, 0, 2276196352, 65536) = 0
> 
> v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
> 
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
> 
> Changes in v2:
> - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
> 
>  fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index f17c3d33fb18..17469fc7b20e 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
>  	return ret;
>  }
>  
> +/*
> + * zero out partial blocks of one cluster.
> + *
> + * start: file offset where zero starts, will be made upper block aligned.
> + * len: it will be trimmed to the end of current cluster if "start + len"
> + *      is bigger than it.

You write this here but ...

> + */
> +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
> +					u64 start, u64 len)
> +{
> +	int ret;
> +	u64 start_block, end_block, nr_blocks;
> +	u64 p_block, offset;
> +	u32 cluster, p_cluster, nr_clusters;
> +	struct super_block *sb = inode->i_sb;
> +	u64 end = ocfs2_align_bytes_to_clusters(sb, start);
> +
> +	if (start + len < end)
> +		end = start + len;

... here you check actually something else and I don't see where else would
the trimming happen.

								Honza

> +
> +	start_block = ocfs2_blocks_for_bytes(sb, start);
> +	end_block = ocfs2_blocks_for_bytes(sb, end);
> +	nr_blocks = end_block - start_block;
> +	if (!nr_blocks)
> +		return 0;
> +
> +	cluster = ocfs2_bytes_to_clusters(sb, start);
> +	ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
> +				&nr_clusters, NULL);
> +	if (ret)
> +		return ret;
> +	if (!p_cluster)
> +		return 0;
> +
> +	offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
> +	p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
> +	return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
> +}
> +
>  /*
>   * Parts of this function taken from xfs_change_file_space()
>   */
> @@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>  {
>  	int ret;
>  	s64 llen;
> -	loff_t size;
> +	loff_t size, orig_isize;
>  	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>  	struct buffer_head *di_bh = NULL;
>  	handle_t *handle;
> @@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>  		goto out_inode_unlock;
>  	}
>  
> +	orig_isize = i_size_read(inode);
>  	switch (sr->l_whence) {
>  	case 0: /*SEEK_SET*/
>  		break;
> @@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>  		sr->l_start += f_pos;
>  		break;
>  	case 2: /*SEEK_END*/
> -		sr->l_start += i_size_read(inode);
> +		sr->l_start += orig_isize;
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>  	default:
>  		ret = -EINVAL;
>  	}
> +
> +	/* zeroout eof blocks in the cluster. */
> +	if (!ret && change_size && orig_isize < size)
> +		ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
> +					size - orig_isize);
>  	up_write(&OCFS2_I(inode)->ip_alloc_sem);
>  	if (ret) {
>  		mlog_errno(ret);
> -- 
> 2.24.3 (Apple Git-128)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
