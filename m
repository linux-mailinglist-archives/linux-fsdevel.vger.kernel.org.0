Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90285770EEF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjHEI5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHEI5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:57:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CA244B8;
        Sat,  5 Aug 2023 01:57:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E65A368AA6; Sat,  5 Aug 2023 10:57:03 +0200 (CEST)
Date:   Sat, 5 Aug 2023 10:57:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230805085703.GA30229@lst.de>
References: <00000000000058d58e06020c1cab@google.com> <20230804101408.GA23274@lst.de> <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner> <20230804140201.GA27600@lst.de> <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner> <20230804144343.GA28230@lst.de> <20230804-kurvigen-uninteressant-09d451db7458@brauner> <20230804-auferlegen-esstisch-fdf67276d18c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-auferlegen-esstisch-fdf67276d18c@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:29:37PM +0200, Christian Brauner wrote:
> On Fri, Aug 04, 2023 at 04:49:23PM +0200, Christian Brauner wrote:
> > On Fri, Aug 04, 2023 at 04:43:43PM +0200, Christoph Hellwig wrote:
> > > On Fri, Aug 04, 2023 at 04:36:49PM +0200, Christian Brauner wrote:
> > > > FFS
> > > 
> > > Good spot, this explains the missing dropping of s_umount.
> > > 
> > > But I don't think it's doing the right thing for MTD mount romfs,
> > > we'll need something like this:
> > 
> > I'll fold a fix into Jan's patch.
> 
> Folding:

Btw, we really need to think about reworking how super block freeing
works.  The calling conventions of ->kill_sb are really horrible right
now:

 - every instance of ->kill_sb is supposed to call generic_shutdown_super,
   but the instances can do work before and after it
 - we have a few generic helpers wrapping generic_shutdown_super, but
   they aren't easily combinable for file systems using say MTD and
   block backends.

Pair that with ->put_super also called from generic_shutdown_super
I think we have a major mess.

Here is my rough and not very well thought out idea (having a lot of
backlog and beeing on the way to a family celebreation):

 1) make ->kill_sb optional and default to generic_shutdown_super if
    not provided
 2) add a new ->free_fs_info method that is called at the end of
    generic_shutdown_super to free sb->s_fs_info
    (maybe thing if we should also call this on a failed mount
     for fc_fs_info, but I'm not quite sure about that) and then
     migrate everything that just frees resources over to that
 3) figure out what work really needs to be before
    generic_shutdown_super, and if there is something add a new
    method for it
 4) if we added the new method in 3 figure out if it can also
    take over the job from ->put_super
 5) PROFIT!!! (well, actually remove ->kill_sb).


> 
> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index c59b230d55b4..2b9f3e3c052a 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -583,16 +583,20 @@ static int romfs_init_fs_context(struct fs_context *fc)
>   */
>  static void romfs_kill_sb(struct super_block *sb)
>  {
> +	generic_shutdown_super(sb);
> +
>  #ifdef CONFIG_ROMFS_ON_MTD
>  	if (sb->s_mtd) {
> -		kill_mtd_super(sb);
> -		return;
> +		put_mtd_device(sb->s_mtd);
> +		sb->s_mtd = NULL;
>  	}
>  #endif
>  #ifdef CONFIG_ROMFS_ON_BLOCK
>  	if (sb->s_bdev) {
> -		kill_block_super(sb);
> -		return;
> +		sb->s_bdev->bd_super = NULL;
> +		sync_blockdev(sb->s_bdev);
> +		blkdev_put(sb->s_bdev, sb->s_type);
>  	}
>  #endif
>  }
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 27c6597aa1be..0b6cc8a03b54 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -485,12 +485,17 @@ static void cramfs_kill_sb(struct super_block *sb)
>  {
>         struct cramfs_sb_info *sbi = CRAMFS_SB(sb);
> 
> +       generic_shutdown_super(sb);
> +
>         if (IS_ENABLED(CONFIG_CRAMFS_MTD) && sb->s_mtd) {
>                 if (sbi && sbi->mtd_point_size)
>                         mtd_unpoint(sb->s_mtd, 0, sbi->mtd_point_size);
> -               kill_mtd_super(sb);
> +               put_mtd_device(sb->s_mtd);
> +               sb->s_mtd = NULL;
>         } else if (IS_ENABLED(CONFIG_CRAMFS_BLOCKDEV) && sb->s_bdev) {
> -               kill_block_super(sb);
> +               sb->s_bdev->bd_super = NULL;
> +               sync_blockdev(sb->s_bdev);
> +               blkdev_put(sb->s_bdev, sb->s_type);
>         }
>         kfree(sbi);
>  }
> 
---end quoted text---
