Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9DEEE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 04:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfD3CzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 22:55:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729803AbfD3CzH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:55:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFE52ACBC;
        Tue, 30 Apr 2019 02:55:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 81BE81E3BEC; Tue, 30 Apr 2019 04:55:01 +0200 (CEST)
Date:   Tue, 30 Apr 2019 04:55:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190430025501.GB6740@quack2.suse.cz>
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428185109.GD23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 28-04-19 19:51:09, Al Viro wrote:
> On Sun, Apr 28, 2019 at 11:14:06AM -0700, syzbot wrote:
> >  down_read+0x49/0x90 kernel/locking/rwsem.c:26
> >  __get_super.part.0+0x203/0x2e0 fs/super.c:788
> >  __get_super include/linux/spinlock.h:329 [inline]
> >  get_super+0x2e/0x50 fs/super.c:817
> >  fsync_bdev+0x19/0xd0 fs/block_dev.c:525
> >  invalidate_partition+0x36/0x60 block/genhd.c:1581
> >  drop_partitions block/partition-generic.c:443 [inline]
> >  rescan_partitions+0xef/0xa20 block/partition-generic.c:516
> >  __blkdev_reread_part+0x1a2/0x230 block/ioctl.c:173
> >  blkdev_reread_part+0x27/0x40 block/ioctl.c:193
> >  loop_reread_partitions+0x1c/0x40 drivers/block/loop.c:633
> >  loop_set_status+0xe57/0x1380 drivers/block/loop.c:1296
> >  loop_set_status64+0xc2/0x120 drivers/block/loop.c:1416
> >  lo_ioctl+0x8fc/0x2150 drivers/block/loop.c:1559
> >  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
> >  blkdev_ioctl+0x6f2/0x1d10 block/ioctl.c:605
> >  block_ioctl+0xee/0x130 fs/block_dev.c:1933
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:509 [inline]
> >  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
> >  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
> >  __do_sys_ioctl fs/ioctl.c:720 [inline]
> >  __se_sys_ioctl fs/ioctl.c:718 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
> >  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> ioctl(..., BLKRRPART) blocked on ->s_umount in __get_super().
> The trouble is, the only things holding ->s_umount appears to be
> these:
> 
> > 2 locks held by syz-executor274/11716:
> >  #0: 00000000a19e2025 (&type->s_umount_key#38/1){+.+.}, at:
> > alloc_super+0x158/0x890 fs/super.c:228
> >  #1: 00000000bde6230e (loop_ctl_mutex){+.+.}, at: lo_simple_ioctl
> > drivers/block/loop.c:1514 [inline]
> >  #1: 00000000bde6230e (loop_ctl_mutex){+.+.}, at: lo_ioctl+0x266/0x2150
> > drivers/block/loop.c:1572
> 
> > 2 locks held by syz-executor274/11717:
> >  #0: 00000000e185c083 (&type->s_umount_key#38/1){+.+.}, at:
> > alloc_super+0x158/0x890 fs/super.c:228
> >  #1: 00000000bde6230e (loop_ctl_mutex){+.+.}, at: lo_simple_ioctl
> > drivers/block/loop.c:1514 [inline]
> >  #1: 00000000bde6230e (loop_ctl_mutex){+.+.}, at: lo_ioctl+0x266/0x2150
> > drivers/block/loop.c:1572
> 
> ... and that's bollocks.  ->s_umount held there is that on freshly allocated
> superblock.  It *MUST* be in mount(2); no other syscall should be able to
> call alloc_super() in the first place.  So what the hell is that doing
> trying to call lo_ioctl() inside mount(2)?  Something like isofs attempting
> cdrom ioctls on the underlying device?

Actually UDF also calls CDROMMULTISESSION ioctl during mount. So I could
see how we get to lo_simple_ioctl() and indeed that would acquire
loop_ctl_mutex under s_umount which is the other way around than in
BLKRRPART ioctl. 

> Why do we have loop_func_table->ioctl(), BTW?  All in-tree instances are
> either NULL or return -EINVAL unconditionally.  Considering that the
> caller is
>                 err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
> we could bloody well just get rid of cryptoloop_ioctl() (the only
> non-NULL instance) and get rid of calling lo_simple_ioctl() in
> lo_ioctl() switch's default.

Yeah, you're right. And if we push the patch a bit further to not take
loop_ctl_mutex for invalid ioctl number, that would fix the problem. I
can send a fix.

								Honza

> 
> Something like this:
> 
> diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
> index 254ee7d54e91..f16468a562f5 100644
> --- a/drivers/block/cryptoloop.c
> +++ b/drivers/block/cryptoloop.c
> @@ -167,12 +167,6 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>  }
>  
>  static int
> -cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
> -{
> -	return -EINVAL;
> -}
> -
> -static int
>  cryptoloop_release(struct loop_device *lo)
>  {
>  	struct crypto_sync_skcipher *tfm = lo->key_data;
> @@ -188,7 +182,6 @@ cryptoloop_release(struct loop_device *lo)
>  static struct loop_func_table cryptoloop_funcs = {
>  	.number = LO_CRYPT_CRYPTOAPI,
>  	.init = cryptoloop_init,
> -	.ioctl = cryptoloop_ioctl,
>  	.transfer = cryptoloop_transfer,
>  	.release = cryptoloop_release,
>  	.owner = THIS_MODULE
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bf1c61cab8eb..2ec162b80562 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -955,7 +955,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	lo->lo_flags = lo_flags;
>  	lo->lo_backing_file = file;
>  	lo->transfer = NULL;
> -	lo->ioctl = NULL;
>  	lo->lo_sizelimit = 0;
>  	lo->old_gfp_mask = mapping_gfp_mask(mapping);
>  	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> @@ -1064,7 +1063,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  
>  	loop_release_xfer(lo);
>  	lo->transfer = NULL;
> -	lo->ioctl = NULL;
>  	lo->lo_device = NULL;
>  	lo->lo_encryption = NULL;
>  	lo->lo_offset = 0;
> @@ -1262,7 +1260,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	if (!xfer)
>  		xfer = &none_funcs;
>  	lo->transfer = xfer->transfer;
> -	lo->ioctl = xfer->ioctl;
>  
>  	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
>  	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
> @@ -1525,7 +1522,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
>  		err = loop_set_block_size(lo, arg);
>  		break;
>  	default:
> -		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
> +		err = -EINVAL;
>  	}
>  	mutex_unlock(&loop_ctl_mutex);
>  	return err;
> @@ -1567,10 +1564,9 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  	case LOOP_SET_BLOCK_SIZE:
>  		if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> -		/* Fall through */
> +		return lo_simple_ioctl(lo, cmd, arg);
>  	default:
> -		err = lo_simple_ioctl(lo, cmd, arg);
> -		break;
> +		return -EINVAL;
>  	}
>  
>  	return err;
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index af75a5ee4094..56a9a0c161d7 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -84,7 +84,6 @@ struct loop_func_table {
>  	int (*init)(struct loop_device *, const struct loop_info64 *); 
>  	/* release is called from loop_unregister_transfer or clr_fd */
>  	int (*release)(struct loop_device *); 
> -	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
>  	struct module *owner;
>  }; 
>  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
