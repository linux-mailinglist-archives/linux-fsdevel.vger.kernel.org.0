Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A813A48D638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 12:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiAMLAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 06:00:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43674 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiAMLAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:00:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B1A6C1F3D2;
        Thu, 13 Jan 2022 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642071642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ok9d12c/ZKGBPd9SEgjTLHPjfTaL4fiSeM4WmdoQPSk=;
        b=xpXpEW75HBdyU9IqQ1lBtVZ9foIb/iOujcZrNBfi/FD6Kb1W6inyTkhMl9Dqv28ZhZl13e
        v48CjegGxrEEzY19WpJ+R70Ri5nN+1AlOWqypzR5z41/N7vzXdonSJKkfDUaU6AjffJVMd
        GIbH6Fh8QauSQXukVwKwS1KCf4UfC3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642071642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ok9d12c/ZKGBPd9SEgjTLHPjfTaL4fiSeM4WmdoQPSk=;
        b=Dk0DxaFQUr1/3qmmmcBuktrLT209oIElTtYet3etnIdFbcgMwTMKiMkJhMFoYWDAJyX34S
        cmC1HvbBRd/Jr7AA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5CA96A3B83;
        Thu, 13 Jan 2022 11:00:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 138BDA05E2; Thu, 13 Jan 2022 12:00:42 +0100 (CET)
Date:   Thu, 13 Jan 2022 12:00:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        luo penghao <luo.penghao@zte.com.cn>,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH 3/6] ext4: Fix error handling in
 ext4_fc_record_modified_inode()
Message-ID: <20220113110042.ahquxopitdwug7xo@quack3.lan>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
 <4b779e7ac657f94f8680a8944bff191f7474db5b.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b779e7ac657f94f8680a8944bff191f7474db5b.1642044249.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-01-22 08:56:26, Ritesh Harjani wrote:
> Current code does not fully takes care of krealloc() error case,
> which could lead to silent memory corruption or a kernel bug.
> This patch fixes that.
> 
> Also it cleans up some duplicated error handling logic from various functions
> in fast_commit.c file.
> 
> Reported-by: luo penghao <luo.penghao@zte.com.cn>
> Suggested-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 64 ++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5ae8026a0c56..4541c8468c01 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1392,14 +1392,15 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
>  		if (state->fc_modified_inodes[i] == ino)
>  			return 0;
>  	if (state->fc_modified_inodes_used == state->fc_modified_inodes_size) {
> -		state->fc_modified_inodes_size +=
> -			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>  		state->fc_modified_inodes = krealloc(
> -					state->fc_modified_inodes, sizeof(int) *
> -					state->fc_modified_inodes_size,
> -					GFP_KERNEL);
> +				state->fc_modified_inodes,
> +				sizeof(int) * (state->fc_modified_inodes_size +
> +				EXT4_FC_REPLAY_REALLOC_INCREMENT),
> +				GFP_KERNEL);
>  		if (!state->fc_modified_inodes)
>  			return -ENOMEM;
> +		state->fc_modified_inodes_size +=
> +			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>  	}
>  	state->fc_modified_inodes[state->fc_modified_inodes_used++] = ino;
>  	return 0;
> @@ -1431,7 +1432,9 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
>  	}
>  	inode = NULL;
>  
> -	ext4_fc_record_modified_inode(sb, ino);
> +	ret = ext4_fc_record_modified_inode(sb, ino);
> +	if (ret)
> +		goto out;
>  
>  	raw_fc_inode = (struct ext4_inode *)
>  		(val + offsetof(struct ext4_fc_inode, fc_raw_inode));
> @@ -1621,6 +1624,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  	}
>  
>  	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> +	if (ret)
> +		goto out;
>  
>  	start = le32_to_cpu(ex->ee_block);
>  	start_pblk = ext4_ext_pblock(ex);
> @@ -1638,18 +1643,14 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  		map.m_pblk = 0;
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  
> -		if (ret < 0) {
> -			iput(inode);
> -			return 0;
> -		}
> +		if (ret < 0)
> +			goto out;
>  
>  		if (ret == 0) {
>  			/* Range is not mapped */
>  			path = ext4_find_extent(inode, cur, NULL, 0);
> -			if (IS_ERR(path)) {
> -				iput(inode);
> -				return 0;
> -			}
> +			if (IS_ERR(path))
> +				goto out;
>  			memset(&newex, 0, sizeof(newex));
>  			newex.ee_block = cpu_to_le32(cur);
>  			ext4_ext_store_pblock(
> @@ -1663,10 +1664,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			up_write((&EXT4_I(inode)->i_data_sem));
>  			ext4_ext_drop_refs(path);
>  			kfree(path);
> -			if (ret) {
> -				iput(inode);
> -				return 0;
> -			}
> +			if (ret)
> +				goto out;
>  			goto next;
>  		}
>  
> @@ -1679,10 +1678,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
>  					ext4_ext_is_unwritten(ex),
>  					start_pblk + cur - start);
> -			if (ret) {
> -				iput(inode);
> -				return 0;
> -			}
> +			if (ret)
> +				goto out;
>  			/*
>  			 * Mark the old blocks as free since they aren't used
>  			 * anymore. We maintain an array of all the modified
> @@ -1702,10 +1699,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			ext4_ext_is_unwritten(ex), map.m_pblk);
>  		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
>  					ext4_ext_is_unwritten(ex), map.m_pblk);
> -		if (ret) {
> -			iput(inode);
> -			return 0;
> -		}
> +		if (ret)
> +			goto out;
>  		/*
>  		 * We may have split the extent tree while toggling the state.
>  		 * Try to shrink the extent tree now.
> @@ -1717,6 +1712,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  	}
>  	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
>  					sb->s_blocksize_bits);
> +out:
>  	iput(inode);
>  	return 0;
>  }
> @@ -1746,6 +1742,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>  	}
>  
>  	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> +	if (ret)
> +		goto out;
>  
>  	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
>  			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
> @@ -1755,10 +1753,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>  		map.m_len = remaining;
>  
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
> -		if (ret < 0) {
> -			iput(inode);
> -			return 0;
> -		}
> +		if (ret < 0)
> +			goto out;
>  		if (ret > 0) {
>  			remaining -= ret;
>  			cur += ret;
> @@ -1773,15 +1769,13 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>  	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
>  				lrange.fc_lblk + lrange.fc_len - 1);
>  	up_write(&EXT4_I(inode)->i_data_sem);
> -	if (ret) {
> -		iput(inode);
> -		return 0;
> -	}
> +	if (ret)
> +		goto out;
>  	ext4_ext_replay_shrink_inode(inode,
>  		i_size_read(inode) >> sb->s_blocksize_bits);
>  	ext4_mark_inode_dirty(NULL, inode);
> +out:
>  	iput(inode);
> -
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
