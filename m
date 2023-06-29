Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD12741F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 06:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjF2E3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 00:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjF2E2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:28:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFE1FE8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 21:28:48 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-117-150.bstnma.fios.verizon.net [173.48.117.150])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35T4SdNS028271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 00:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1688012921; bh=G1WywpSC7JbNF3VsEtkgr5IRIuWVWKPrradmgoLImzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hMd79orpIHdr7WocGloof1z2O9ZX12vsq9VbYdJ38vtZvIwjhMjKrgytgMH7FhN3i
         0vxIbMbRlxg5jQtIPcbXHjAxmP2FJ/fEOX252QUk/cxkyY8QyIVgFOVe1oixmKmweb
         tTIJBNjciUDhVqqz0Yn0h9LPl0z5ubaPGaqPOQ35h1xzvVjKduEG2/99IpFfogB7wh
         w1+u4EnnqTfxch4fS3Be9CHidiTlQ9lfzeBpYU18hUGpTTBLKAPxjTyjxLl+rc88uM
         ZNLNYPNatVwV1jRPVvhZfLu/fhUAzlbmLOxNxL6SN1Hgmvaj3lsyVZURI1IPnKAcPE
         zn2pLhc0mGUEQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1168B15C027F; Thu, 29 Jun 2023 00:28:39 -0400 (EDT)
Date:   Thu, 29 Jun 2023 00:28:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+5407ecf3112f882d2ef3@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in __ext4_iget
Message-ID: <20230629042839.GK8954@mit.edu>
References: <000000000000ddfe0405fd7ef847@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ddfe0405fd7ef847@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: fs, reiserfs

On Tue, Jun 06, 2023 at 05:11:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1455f745280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
> dashboard link: https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

The stack traces on this are... intersting.  The use-after free is
coming when ext4_fill_super() tries to get the root inode, via
iget_locked(sb, EXT2_ROOT_INO)

> BUG: KASAN: slab-use-after-free in __ext4_iget+0x2f2/0x3f30 fs/ext4/inode.c:4700
> Read of size 8 at addr ffff888078ca5550 by task syz-executor.5/26112
	...
>  __ext4_iget+0x2f2/0x3f30 fs/ext4/inode.c:4700
>  __ext4_fill_super fs/ext4/super.c:5446 [inline]
>  ext4_fill_super+0x545b/0x6c60 fs/ext4/super.c:5672

However, we are getting back an object which is freed, and which was
originally allocated by reiserfs(!):

> Allocated by task 20729:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
>  slab_alloc_node mm/slub.c:3451 [inline]
>  slab_alloc mm/slub.c:3459 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
>  kmem_cache_alloc_lru+0x11f/0x2e0 mm/slub.c:3482
>  alloc_inode_sb include/linux/fs.h:2705 [inline]
>  reiserfs_alloc_inode+0x2a/0xc0 fs/reiserfs/super.c:642
>  alloc_inode fs/inode.c:260 [inline]
>  iget5_locked+0xa0/0x270 fs/inode.c:1241
>  reiserfs_fill_super+0x12e4/0x2620 fs/reiserfs/super.c:2053
>  mount_bdev+0x2d0/0x3f0 fs/super.c:1380

There is no reproducer, but it seems to be triggering quite frequently
(over once day --- 20 times since June 16, 2023 as of this writing).
I've checked a number of the reports in the Syzkaller dashboard, and
they are all quite similar; somehow ext4 is getting an inode which is
freed, and whose memory was originally allocated by reiserfs.

I'm not sure if this is a reiserfs bug or a core VFS bug, since this
seems to imply that an an old reiserfs inode was left on the
inode_hashtable when a reiserfs file system was unmounted, and then
the struct super was reused and returned for a fresh ext4 mount, and
then when ext4 tried do an iget_locked(), it got the reserifs inode.

That reiserfs inode was either freed and left on the inode_hashtable,
or lifetime of the reiserfs root inode was allowed to last longer than
the reiserfs superblock (maybe someone is playing RCU games?) and so
since it was left on the inode_hashtable, the attempt to free reiserfs
root inode raced with ext4's attempt to fetch the ext4 inode via
iget_locked().

Perhaps one of the VFS or reiserfs maintainers could take a look?

       	       	  	   	      	       - Ted
