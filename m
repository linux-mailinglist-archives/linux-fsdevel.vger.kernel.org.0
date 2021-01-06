Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A2EBC93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 11:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAFKlt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 05:41:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbhAFKls (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:41:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C29DDACAF;
        Wed,  6 Jan 2021 10:41:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 78CB61E0812; Wed,  6 Jan 2021 11:41:06 +0100 (CET)
Date:   Wed, 6 Jan 2021 11:41:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH kernel] block: initialize block_device::bd_bdi for
 bdev_cache
Message-ID: <20210106104106.GA29271@quack2.suse.cz>
References: <20210106092900.26595-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106092900.26595-1-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-01-21 20:29:00, Alexey Kardashevskiy wrote:
> This is a workaround to fix a null derefence crash:
> 
> [c00000000b01f840] c00000000b01f880 (unreliable)
> [c00000000b01f880] c000000000769a3c bdev_evict_inode+0x21c/0x370
> [c00000000b01f8c0] c00000000070bacc evict+0x11c/0x230
> [c00000000b01f900] c00000000070c138 iput+0x2a8/0x4a0
> [c00000000b01f970] c0000000006ff030 dentry_unlink_inode+0x220/0x250
> [c00000000b01f9b0] c0000000007001c0 __dentry_kill+0x190/0x320
> [c00000000b01fa00] c000000000701fb8 dput+0x5e8/0x860
> [c00000000b01fa80] c000000000705848 shrink_dcache_for_umount+0x58/0x100
> [c00000000b01fb00] c0000000006cf864 generic_shutdown_super+0x54/0x200
> [c00000000b01fb80] c0000000006cfd48 kill_anon_super+0x38/0x60
> [c00000000b01fbc0] c0000000006d12cc deactivate_locked_super+0xbc/0x110
> [c00000000b01fbf0] c0000000006d13bc deactivate_super+0x9c/0xc0
> [c00000000b01fc20] c00000000071a340 cleanup_mnt+0x1b0/0x250
> [c00000000b01fc80] c000000000278fa8 task_work_run+0xf8/0x180
> [c00000000b01fcd0] c00000000002b4ac do_notify_resume+0x4dc/0x5d0
> [c00000000b01fda0] c00000000004ba0c syscall_exit_prepare+0x28c/0x370
> [c00000000b01fe10] c00000000000e06c system_call_common+0xfc/0x27c
> --- Exception: c00 (System Call) at 0000000010034890
> 
> Is this fixed properly already somewhere? Thanks,
> 
> Fixes: e6cb53827ed6 ("block: initialize struct block_device in bdev_alloc")

I don't think it's fixed anywhere and I've seen the syzbot report and I was
wondering how this can happen when bdev_alloc() initializes bdev->bd_bdi
and it also wasn't clear to me whether bd_bdi is really the only field that
is problematic - if we can get to bdev_evict_inode() without going through
bdev_alloc(), we are probably missing initialization of other fields in
that place as well...

But now I've realized that probably the inode is a root inode for bdev
superblock which is allocated by VFS through new_inode() and thus doesn't
undergo the initialization in bdev_alloc(). And AFAICT the root inode on
bdev superblock can get only to bdev_evict_inode() and bdev_free_inode().
Looking at bdev_evict_inode() the only thing that's used there from struct
block_device is really bd_bdi. bdev_free_inode() will also access
bdev->bd_stats and bdev->bd_meta_info. So we need to at least initialize
these to NULL as well. IMO the most logical place for all these
initializations is in bdev_alloc_inode()...

								Honza

> ---
>  fs/block_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3e5b02f6606c..86fdc28d565e 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -792,8 +792,10 @@ static void bdev_free_inode(struct inode *inode)
>  static void init_once(void *data)
>  {
>  	struct bdev_inode *ei = data;
> +	struct block_device *bdev = &ei->bdev;
>  
>  	inode_init_once(&ei->vfs_inode);
> +	bdev->bd_bdi = &noop_backing_dev_info;
>  }
>  
>  static void bdev_evict_inode(struct inode *inode)
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
