Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD216DB84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 07:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfD2FaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 01:30:17 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39148 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfD2FaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:30:16 -0400
Received: by mail-it1-f195.google.com with SMTP id t200so1811596itf.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2019 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3w9F4L2H1rP9to/5V17qizlCntfJhWuWWDPbePgiLv4=;
        b=lVY8T3bu8WK/L1Laf1KemLAezdD1y965IE5aC9AwIW5kiy85w/2iDLzTOwU3oX/RhT
         QlEey58vw5mYestPJHs5kyZVxQ2bZ8lolLbdx/m2JTgCGEGkbpRlA8HvWzfq4rXl8GPB
         OirBGwaP5TlsQ5aceObQjNG0CQ1pWTBQaKecg0ByIMW+zazzcYuH/QO5DMzi4p8rljOL
         Xh/IfrW+2cOPA+8KELqITYYm9Gcg7WhcDixymtqSNI/SDxMO0HgvMFLQwwncLI3XZvXV
         zi5UYwkslP+awXYATxroxAxeQLIJyLJS3UnfBygJy+i5ujX5HhGfzsx1Z9Lx6VQBeBLz
         SnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3w9F4L2H1rP9to/5V17qizlCntfJhWuWWDPbePgiLv4=;
        b=XCfGanpxyKkPXuDhrYGtdfj/HeKKGxVMAE4DnaNNhQ7gbrgwValj7YFGTg0zni5dPb
         JZhtRrkUP3lWj4JqMw/aL6ycmMDIr/CEoHMqn6DNYInjDnI6rdvaIOogCFdjN0T6yIYw
         pQviWI/E945fQIfN1NfzwfedSd+IQwt/U8m5/DHU/QPn80jp3YiBXURLoIPfY1hGgJMF
         GL0rmUdQF/+bKZyakOxqNlA4PpNyuJrtG/wNjMRDk/gQ8uhY75n6Ao8lxbsr5/DV5bCP
         wsJ7JvFLZmpL4uXZwghWbMrE/fxciGMd8WhIWro3h4V2eGB5UMPqiJgDriJuQ71hf6wF
         tXDg==
X-Gm-Message-State: APjAAAVapbcXOEJy4tWSFgyz1PuNUglt8QE47M8w3hJOSFtDdJR80VIM
        +4ON7Xcq7VMBHW+IyoHTQc5TD6VURluKjuv+fToHdw==
X-Google-Smtp-Source: APXvYqwlFabYJQ1MkECdPw/4DCKLWiNo/pYXBd47oUbJpOWvbVPuV/HywHTo3BiOPpxYH2sZt7061RzznUm8+D+TRdo=
X-Received: by 2002:a24:7c8c:: with SMTP id a134mr15752208itd.144.1556515815493;
 Sun, 28 Apr 2019 22:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <001a113ed5540f411c0568cc8418@google.com> <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
In-Reply-To: <20190428185109.GD23075@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Apr 2019 07:30:03 +0200
Message-ID: <CACT4Y+bN415biwxFPDfZNGkSbTuTUh-+47rJr31MWT-z-LHXmg@mail.gmail.com>
Subject: Re: INFO: task hung in __get_super
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 8:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
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


How useful would it be to see full stacks in such lockdep reports?
Now that we have lib/stackdepot.c that is capable of memorizing large
number of stacks and converting them to a single u32, we could use it
in more debug facilities. I remember +Peter mentioned some problems
with interrupts/reenterancy of stackdepot, but I hope it's resolvable
(at least in some conservative way as we already call stackdepot from
interrupts).
I think ODEBUG facility have the same problem of showing only single
PC in reports for a past stack.
Should I file an issue for this?


> Why do we have loop_func_table->ioctl(), BTW?  All in-tree instances are
> either NULL or return -EINVAL unconditionally.  Considering that the
> caller is
>                 err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
> we could bloody well just get rid of cryptoloop_ioctl() (the only
> non-NULL instance) and get rid of calling lo_simple_ioctl() in
> lo_ioctl() switch's default.
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
> -       return -EINVAL;
> -}
> -
> -static int
>  cryptoloop_release(struct loop_device *lo)
>  {
>         struct crypto_sync_skcipher *tfm = lo->key_data;
> @@ -188,7 +182,6 @@ cryptoloop_release(struct loop_device *lo)
>  static struct loop_func_table cryptoloop_funcs = {
>         .number = LO_CRYPT_CRYPTOAPI,
>         .init = cryptoloop_init,
> -       .ioctl = cryptoloop_ioctl,
>         .transfer = cryptoloop_transfer,
>         .release = cryptoloop_release,
>         .owner = THIS_MODULE
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bf1c61cab8eb..2ec162b80562 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -955,7 +955,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>         lo->lo_flags = lo_flags;
>         lo->lo_backing_file = file;
>         lo->transfer = NULL;
> -       lo->ioctl = NULL;
>         lo->lo_sizelimit = 0;
>         lo->old_gfp_mask = mapping_gfp_mask(mapping);
>         mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
> @@ -1064,7 +1063,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>
>         loop_release_xfer(lo);
>         lo->transfer = NULL;
> -       lo->ioctl = NULL;
>         lo->lo_device = NULL;
>         lo->lo_encryption = NULL;
>         lo->lo_offset = 0;
> @@ -1262,7 +1260,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>         if (!xfer)
>                 xfer = &none_funcs;
>         lo->transfer = xfer->transfer;
> -       lo->ioctl = xfer->ioctl;
>
>         if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
>              (info->lo_flags & LO_FLAGS_AUTOCLEAR))
> @@ -1525,7 +1522,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
>                 err = loop_set_block_size(lo, arg);
>                 break;
>         default:
> -               err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
> +               err = -EINVAL;
>         }
>         mutex_unlock(&loop_ctl_mutex);
>         return err;
> @@ -1567,10 +1564,9 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>         case LOOP_SET_BLOCK_SIZE:
>                 if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
>                         return -EPERM;
> -               /* Fall through */
> +               return lo_simple_ioctl(lo, cmd, arg);
>         default:
> -               err = lo_simple_ioctl(lo, cmd, arg);
> -               break;
> +               return -EINVAL;
>         }
>
>         return err;
> diff --git a/drivers/block/loop.h b/drivers/block/loop.h
> index af75a5ee4094..56a9a0c161d7 100644
> --- a/drivers/block/loop.h
> +++ b/drivers/block/loop.h
> @@ -84,7 +84,6 @@ struct loop_func_table {
>         int (*init)(struct loop_device *, const struct loop_info64 *);
>         /* release is called from loop_unregister_transfer or clr_fd */
>         int (*release)(struct loop_device *);
> -       int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
>         struct module *owner;
>  };
>
