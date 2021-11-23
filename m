Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42F45AF80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhKWW5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:57:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240159AbhKWW5k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:57:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A7AF60F5D;
        Tue, 23 Nov 2021 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637708071;
        bh=NYkX8UHWeP1OEOzoKcmsOPU82GrKW5S4+IZ7T4iz94Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXMKf7yMwweCOKAzEhfZayDcajvP1O2UdSzRfQBzFDtkQ3b0NxAgePyY/ApKecqJS
         QRl27OUtt8ygRdblDJxy//OCChxugex79UUdvMS9oPEY+UZnvM0n5uyVIcFA+Od7qH
         S9NBv+1Lq4LHL1ydTCM3aS1U3cu0vCnmWNqiAkrtW71TSqXMBfB9Rmco6uRNZ+fTYq
         AAyj38T84Zwq5VWYOhQdTQ72iFh3otPvctyg1hmLpjJEyn1+JrWa3ODOQwQN+ImZVJ
         17HF6GW5sXzvWbqvXiEKycV9D8L76owqYREgiKs6ah7AFzGd2OAahNhBKJ4ki8RsHw
         5IqICgEUzZAUw==
Date:   Tue, 23 Nov 2021 14:54:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 20/29] ext4: cleanup the dax handling in ext4_fill_super
Message-ID: <20211123225430.GN266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-21-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:00AM +0100, Christoph Hellwig wrote:
> Only call fs_dax_get_by_bdev once the sbi has been allocated and remove
> the need for the dax_dev local variable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index eb4df43abd76e..b60401bb1c310 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3879,7 +3879,6 @@ static void ext4_setup_csum_trigger(struct super_block *sb,
>  
>  static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  {
> -	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
>  	char *orig_data = kstrdup(data, GFP_KERNEL);
>  	struct buffer_head *bh, **group_desc;
>  	struct ext4_super_block *es = NULL;
> @@ -3910,12 +3909,12 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	if ((data && !orig_data) || !sbi)
>  		goto out_free_base;
>  
> -	sbi->s_daxdev = dax_dev;
>  	sbi->s_blockgroup_lock =
>  		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
>  	if (!sbi->s_blockgroup_lock)
>  		goto out_free_base;
>  
> +	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
>  	sb->s_fs_info = sbi;
>  	sbi->s_sb = sb;
>  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
> @@ -4300,7 +4299,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		goto failed_mount;
>  	}
>  
> -	if (dax_dev) {
> +	if (sbi->s_daxdev) {
>  		if (blocksize == PAGE_SIZE)
>  			set_bit(EXT4_FLAGS_BDEV_IS_DAX, &sbi->s_ext4_flags);
>  		else
> @@ -5096,10 +5095,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  out_fail:
>  	sb->s_fs_info = NULL;
>  	kfree(sbi->s_blockgroup_lock);
> +	fs_put_dax(sbi->s_daxdev );

Nit: no space before the paren  ^ here.

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  out_free_base:
>  	kfree(sbi);
>  	kfree(orig_data);
> -	fs_put_dax(dax_dev);
>  	return err ? err : ret;
>  }
>  
> -- 
> 2.30.2
> 
