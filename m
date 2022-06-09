Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59012545301
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbiFIRcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbiFIRcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:32:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2972D56F3;
        Thu,  9 Jun 2022 10:32:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F0D3E22024;
        Thu,  9 Jun 2022 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654795923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ck91PtWX6yBhQ4sZXbXKs49E/1QZEM43OfHwV3RWAAE=;
        b=FXeGIc/6Phds3vEHHRSfr1wqrN1UUKTH35QyDvku6zUJ9oy6q/7pexMNpfM54wg4M+q1uR
        sB39pzL4r+1IUh69tV484kEAWEHJWEFpX+lYNbDv5/dgS6Fi+wqX9dqftWLFYK5B8CQspL
        3KSBgcuELkN0R0rqd9a0bkCSkji+z0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654795923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ck91PtWX6yBhQ4sZXbXKs49E/1QZEM43OfHwV3RWAAE=;
        b=mqWoO+V8YXZQGb4cFuKrnG6i3RgqcnBMUMiZCm4eYFPyKM+COoxahatX1ar3AJSoPZouJV
        X/yeJQqASlBW6VCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D7BCF2C141;
        Thu,  9 Jun 2022 17:32:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7B438A0633; Thu,  9 Jun 2022 19:32:03 +0200 (CEST)
Date:   Thu, 9 Jun 2022 19:32:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 1/5] ext2: remove nobh support
Message-ID: <20220609173203.is7vze5fdhx53t3x@quack3.lan>
References: <20220608150451.1432388-1-hch@lst.de>
 <20220608150451.1432388-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608150451.1432388-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 17:04:47, Christoph Hellwig wrote:
> The nobh mode is an obscure feature to save lowlevel for large memory
> 32-bit configurations while trading for much slower performance and
> has been long obsolete.  Remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes, I agree. Let's just rip it out. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/ext2.rst |  2 --
>  fs/ext2/ext2.h                     |  1 -
>  fs/ext2/inode.c                    | 51 ++----------------------------
>  fs/ext2/namei.c                    | 10 ++----
>  fs/ext2/super.c                    |  6 ++--
>  5 files changed, 7 insertions(+), 63 deletions(-)
> 
> diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
> index 154101cf0e4f5..92aae683e16a7 100644
> --- a/Documentation/filesystems/ext2.rst
> +++ b/Documentation/filesystems/ext2.rst
> @@ -59,8 +59,6 @@ acl				Enable POSIX Access Control Lists support
>  				(requires CONFIG_EXT2_FS_POSIX_ACL).
>  noacl				Don't support POSIX ACLs.
>  
> -nobh				Do not attach buffer_heads to file pagecache.
> -
>  quota, usrquota			Enable user disk quota support
>  				(requires CONFIG_QUOTA).
>  
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index d4f306aa5aceb..28de11a22e5f6 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -795,7 +795,6 @@ extern const struct file_operations ext2_file_operations;
>  /* inode.c */
>  extern void ext2_set_file_ops(struct inode *inode);
>  extern const struct address_space_operations ext2_aops;
> -extern const struct address_space_operations ext2_nobh_aops;
>  extern const struct iomap_ops ext2_iomap_ops;
>  
>  /* namei.c */
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 84570c6265aae..2001e784fee11 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -908,25 +908,6 @@ static int ext2_write_end(struct file *file, struct address_space *mapping,
>  	return ret;
>  }
>  
> -static int
> -ext2_nobh_write_begin(struct file *file, struct address_space *mapping,
> -		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
> -{
> -	int ret;
> -
> -	ret = nobh_write_begin(mapping, pos, len, pagep, fsdata,
> -			       ext2_get_block);
> -	if (ret < 0)
> -		ext2_write_failed(mapping, pos + len);
> -	return ret;
> -}
> -
> -static int ext2_nobh_writepage(struct page *page,
> -			struct writeback_control *wbc)
> -{
> -	return nobh_writepage(page, ext2_get_block, wbc);
> -}
> -
>  static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
>  {
>  	return generic_block_bmap(mapping,block,ext2_get_block);
> @@ -978,21 +959,6 @@ const struct address_space_operations ext2_aops = {
>  	.error_remove_page	= generic_error_remove_page,
>  };
>  
> -const struct address_space_operations ext2_nobh_aops = {
> -	.dirty_folio		= block_dirty_folio,
> -	.invalidate_folio	= block_invalidate_folio,
> -	.read_folio		= ext2_read_folio,
> -	.readahead		= ext2_readahead,
> -	.writepage		= ext2_nobh_writepage,
> -	.write_begin		= ext2_nobh_write_begin,
> -	.write_end		= nobh_write_end,
> -	.bmap			= ext2_bmap,
> -	.direct_IO		= ext2_direct_IO,
> -	.writepages		= ext2_writepages,
> -	.migrate_folio		= buffer_migrate_folio,
> -	.error_remove_page	= generic_error_remove_page,
> -};
> -
>  static const struct address_space_operations ext2_dax_aops = {
>  	.writepages		= ext2_dax_writepages,
>  	.direct_IO		= noop_direct_IO,
> @@ -1298,13 +1264,10 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  
>  	inode_dio_wait(inode);
>  
> -	if (IS_DAX(inode)) {
> +	if (IS_DAX(inode))
>  		error = dax_zero_range(inode, newsize,
>  				       PAGE_ALIGN(newsize) - newsize, NULL,
>  				       &ext2_iomap_ops);
> -	} else if (test_opt(inode->i_sb, NOBH))
> -		error = nobh_truncate_page(inode->i_mapping,
> -				newsize, ext2_get_block);
>  	else
>  		error = block_truncate_page(inode->i_mapping,
>  				newsize, ext2_get_block);
> @@ -1396,8 +1359,6 @@ void ext2_set_file_ops(struct inode *inode)
>  	inode->i_fop = &ext2_file_operations;
>  	if (IS_DAX(inode))
>  		inode->i_mapping->a_ops = &ext2_dax_aops;
> -	else if (test_opt(inode->i_sb, NOBH))
> -		inode->i_mapping->a_ops = &ext2_nobh_aops;
>  	else
>  		inode->i_mapping->a_ops = &ext2_aops;
>  }
> @@ -1497,10 +1458,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
>  	} else if (S_ISDIR(inode->i_mode)) {
>  		inode->i_op = &ext2_dir_inode_operations;
>  		inode->i_fop = &ext2_dir_operations;
> -		if (test_opt(inode->i_sb, NOBH))
> -			inode->i_mapping->a_ops = &ext2_nobh_aops;
> -		else
> -			inode->i_mapping->a_ops = &ext2_aops;
> +		inode->i_mapping->a_ops = &ext2_aops;
>  	} else if (S_ISLNK(inode->i_mode)) {
>  		if (ext2_inode_is_fast_symlink(inode)) {
>  			inode->i_link = (char *)ei->i_data;
> @@ -1510,10 +1468,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
>  		} else {
>  			inode->i_op = &ext2_symlink_inode_operations;
>  			inode_nohighmem(inode);
> -			if (test_opt(inode->i_sb, NOBH))
> -				inode->i_mapping->a_ops = &ext2_nobh_aops;
> -			else
> -				inode->i_mapping->a_ops = &ext2_aops;
> +			inode->i_mapping->a_ops = &ext2_aops;
>  		}
>  	} else {
>  		inode->i_op = &ext2_special_inode_operations;
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 5f6b7560eb3f3..5fd9a22d2b70c 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -178,10 +178,7 @@ static int ext2_symlink (struct user_namespace * mnt_userns, struct inode * dir,
>  		/* slow symlink */
>  		inode->i_op = &ext2_symlink_inode_operations;
>  		inode_nohighmem(inode);
> -		if (test_opt(inode->i_sb, NOBH))
> -			inode->i_mapping->a_ops = &ext2_nobh_aops;
> -		else
> -			inode->i_mapping->a_ops = &ext2_aops;
> +		inode->i_mapping->a_ops = &ext2_aops;
>  		err = page_symlink(inode, symname, l);
>  		if (err)
>  			goto out_fail;
> @@ -247,10 +244,7 @@ static int ext2_mkdir(struct user_namespace * mnt_userns,
>  
>  	inode->i_op = &ext2_dir_inode_operations;
>  	inode->i_fop = &ext2_dir_operations;
> -	if (test_opt(inode->i_sb, NOBH))
> -		inode->i_mapping->a_ops = &ext2_nobh_aops;
> -	else
> -		inode->i_mapping->a_ops = &ext2_aops;
> +	inode->i_mapping->a_ops = &ext2_aops;
>  
>  	inode_inc_link_count(inode);
>  
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index f6a19f6d9f6d5..a1c1263c07ab3 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -296,9 +296,6 @@ static int ext2_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",noacl");
>  #endif
>  
> -	if (test_opt(sb, NOBH))
> -		seq_puts(seq, ",nobh");
> -
>  	if (test_opt(sb, USRQUOTA))
>  		seq_puts(seq, ",usrquota");
>  
> @@ -551,7 +548,8 @@ static int parse_options(char *options, struct super_block *sb,
>  			clear_opt (opts->s_mount_opt, OLDALLOC);
>  			break;
>  		case Opt_nobh:
> -			set_opt (opts->s_mount_opt, NOBH);
> +			ext2_msg(sb, KERN_INFO,
> +				"nobh option not supported");
>  			break;
>  #ifdef CONFIG_EXT2_FS_XATTR
>  		case Opt_user_xattr:
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
