Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E498749C00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGFMkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFMk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:40:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45CC171A;
        Thu,  6 Jul 2023 05:40:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E04321AF4;
        Thu,  6 Jul 2023 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=noOxSZcOq91/VCWktatlvWENq3YdaDTCODkvdrts+c0=;
        b=P20gvxWOIYdGnEH+KCCgyz0WEXFPIeXpaMPN6gtCM9eVpK7V28swkElJlFIrebzarB8gPQ
        C7Ilq6fI+1rFRH5CvuW4P3oFlJ/kZln435uHHsb+KFq5OMeZWzKeWPH/PPKZdZ9XjoVV/K
        tc+VHnAq8woGSsI0kjsw+e8OMv5kkcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=noOxSZcOq91/VCWktatlvWENq3YdaDTCODkvdrts+c0=;
        b=GHZlQyqyMNi9TXaUCakNTUtVsnhz55K92g5Wt/qRCh8HiG+SXTtEEsIjmwQc7KM7yE79M3
        ACQojyrUokwfcQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50A44138FC;
        Thu,  6 Jul 2023 12:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kkeqEzu2pmT/PQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:40:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D60CAA0707; Thu,  6 Jul 2023 14:40:26 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:40:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 52/92] hugetlbfs: convert to ctime accessor functions
Message-ID: <20230706124026.cmartqjvnc3lfhmj@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-50-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-50-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:17, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hugetlbfs/inode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7b17ccfa039d..93d3bcfd4fc8 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -887,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
>  		i_size_write(inode, offset + len);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>  out:
>  	inode_unlock(inode);
>  	return error;
> @@ -935,7 +935,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
>  		inode->i_mode = S_IFDIR | ctx->mode;
>  		inode->i_uid = ctx->uid;
>  		inode->i_gid = ctx->gid;
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  		inode->i_op = &hugetlbfs_dir_inode_operations;
>  		inode->i_fop = &simple_dir_operations;
>  		/* directory inodes start off with i_nlink == 2 (for "." entry) */
> @@ -979,7 +979,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>  		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
>  				&hugetlbfs_i_mmap_rwsem_key);
>  		inode->i_mapping->a_ops = &hugetlbfs_aops;
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  		inode->i_mapping->private_data = resv_map;
>  		info->seals = F_SEAL_SEAL;
>  		switch (mode & S_IFMT) {
> @@ -1022,7 +1022,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
>  	if (!inode)
>  		return -ENOSPC;
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	d_instantiate(dentry, inode);
>  	dget(dentry);/* Extra count - pin the dentry in core */
>  	return 0;
> @@ -1054,7 +1054,7 @@ static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
>  	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
>  	if (!inode)
>  		return -ENOSPC;
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  	d_tmpfile(file, inode);
>  	return finish_open_simple(file, 0);
>  }
> @@ -1076,7 +1076,7 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
>  		} else
>  			iput(inode);
>  	}
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_set_ctime_current(dir);
>  
>  	return error;
>  }
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
