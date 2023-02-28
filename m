Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E056A5957
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 13:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjB1MqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 07:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1MqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:46:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC7830191;
        Tue, 28 Feb 2023 04:45:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 388A81FDC7;
        Tue, 28 Feb 2023 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677588357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1c9lYL5Vj6cqW2ZojZ8ohRJiddDMFmGSFykux1gUkWM=;
        b=qQ6ap7JQpb4XyeWDv3Y86Hb/55hUWP/WqbbBgZ4uyAFOI8Tz/TtI+SBPqbREmzfpjhGr0y
        O3vbN3FvLhCgReI7d15awK3MJzB9iYVFKQb5PqgIArfVRgm1rXueIWplTKgBVM/6JwO4SB
        O5iJzs64jYQZRlxXV/f8POfh/phajBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677588357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1c9lYL5Vj6cqW2ZojZ8ohRJiddDMFmGSFykux1gUkWM=;
        b=6JM2YzIdpsX/6eV5OH9xk6CW1cbU0LaW9zNfhSkoNQBZmT10M3HgCMaDTgtwMcVhoM85f0
        qJSKKZKBH8Qp86Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A9011333C;
        Tue, 28 Feb 2023 12:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id by1dCoX3/WPwGQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Feb 2023 12:45:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A5AFFA06F2; Tue, 28 Feb 2023 13:45:56 +0100 (CET)
Date:   Tue, 28 Feb 2023 13:45:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Palash Oswal <oswalpalash@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: KASAN: use-after-free Read in inode_cgwb_move_to_attached
Message-ID: <20230228124556.riiwwskbrh7lxogt@quack3>
References: <CAGyP=7fWFjioc7ok0SZ7kBNh6_MAk1keL4BKPvUNdmpGjnsZOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyP=7fWFjioc7ok0SZ7kBNh6_MAk1keL4BKPvUNdmpGjnsZOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-02-23 21:09:23, Palash Oswal wrote:
> Hello,
> I found the following issue using syzkaller on:
> HEAD commit : e60276b8c11ab4a8be23807bc67b04
> 8cfb937dfa (v6.0.8)
> git tree: stable
> 
> C Reproducer : https://gist.github.com/oswalpalash/bed0eba75def3cdd34a285428e9bcdc4
> Kernel .config :
> https://gist.github.com/oswalpalash/0962c70d774e5ec736a047bba917cecb
> 
> Console log :
> 
> ==================================================================
> BUG: KASAN: use-after-free in __list_del_entry_valid+0xf2/0x110
> Read of size 8 at addr ffff8880273c4358 by task syz-executor.1/6475

OK, so FAT inode was on writeback list (through inode->i_io_list) when
being freed. This should be fixed by commit 4e3c51f4e805 ("fs: do not
update freeing inode i_io_list"). Can you check please?

								Honza

> 
> CPU: 0 PID: 6475 Comm: syz-executor.1 Not tainted 6.0.8-pasta #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xcd/0x134
>  print_report.cold+0xe5/0x63a
>  kasan_report+0x8a/0x1b0
>  __list_del_entry_valid+0xf2/0x110
>  inode_cgwb_move_to_attached+0x2ee/0x4e0
>  writeback_single_inode+0x3fa/0x510
>  write_inode_now+0x16a/0x1e0
>  blkdev_flush_mapping+0x168/0x220
>  blkdev_put_whole+0xd1/0xf0
>  blkdev_put+0x29b/0x700
>  deactivate_locked_super+0x8c/0xf0
>  deactivate_super+0xad/0xd0
>  cleanup_mnt+0x347/0x4b0
>  task_work_run+0xe0/0x1a0
>  exit_to_user_mode_prepare+0x25d/0x270
>  syscall_exit_to_user_mode+0x19/0x50
>  do_syscall_64+0x42/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f22bd29143b
> Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6
> e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe505103b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f22bd29143b
> RDX: 00007f22bd228a90 RSI: 000000000000000a RDI: 00007ffe50510480
> RBP: 00007ffe50510480 R08: 00007f22bd2fba1f R09: 00007ffe50510240
> R10: 00000000fffffffb R11: 0000000000000246 R12: 00007f22bd2fb9f8
> R13: 00007ffe50511520 R14: 0000555556f4bd90 R15: 0000000000000032
>  </TASK>
> 
> Allocated by task 7810:
>  kasan_save_stack+0x1e/0x40
>  __kasan_slab_alloc+0x85/0xb0
>  kmem_cache_alloc_lru+0x25b/0xfb0
>  fat_alloc_inode+0x23/0x1e0
>  alloc_inode+0x61/0x1e0
>  new_inode_pseudo+0x13/0x80
>  new_inode+0x1b/0x40
>  fat_build_inode+0x146/0x2d0
>  vfat_create+0x249/0x390
>  lookup_open+0x10bc/0x1640
>  path_openat+0xa42/0x2840
>  do_filp_open+0x1ca/0x2a0
>  do_sys_openat2+0x61b/0x990
>  do_sys_open+0xc3/0x140
>  do_syscall_64+0x35/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 16:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_set_free_info+0x20/0x30
>  __kasan_slab_free+0xf5/0x180
>  kmem_cache_free.part.0+0xfc/0x4a0
>  i_callback+0x3f/0x70
>  rcu_core+0x785/0x1720
>  __do_softirq+0x1d0/0x908
> 
> Last potentially related work creation:
>  kasan_save_stack+0x1e/0x40
>  __kasan_record_aux_stack+0x7e/0x90
>  call_rcu+0x99/0x740
>  destroy_inode+0x129/0x1b0
>  iput.part.0+0x5cd/0x800
>  iput+0x58/0x70
>  dentry_unlink_inode+0x2e2/0x4a0
>  __dentry_kill+0x374/0x5e0
>  dput+0x656/0xbe0
>  __fput+0x3cc/0xa90
>  task_work_run+0xe0/0x1a0
>  exit_to_user_mode_prepare+0x25d/0x270
>  syscall_exit_to_user_mode+0x19/0x50
>  do_syscall_64+0x42/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The buggy address belongs to the object at ffff8880273c4080
>  which belongs to the cache fat_inode_cache of size 1488
> The buggy address is located 728 bytes inside of
>  1488-byte region [ffff8880273c4080, ffff8880273c4650)
> 
> The buggy address belongs to the physical page:
> page:ffffea00009cf100 refcount:1 mapcount:0 mapping:0000000000000000
> index:0xffff8880273c4ffe pfn:0x273c4
> flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000200 ffffea00009cf0c8 ffff88801820e450 ffff888103e00e00
> raw: ffff8880273c4ffe ffff8880273c4080 0000000100000002 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Reclaimable, gfp_mask
> 0x242050(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|__GFP_RECLAIMABLE),
> pid 7810, tgid 7808 (syz-executor.1), ts 50543388569, free_ts
> 21285403579
>  prep_new_page+0x2c6/0x350
>  get_page_from_freelist+0xae9/0x3a80
>  __alloc_pages+0x321/0x710
>  cache_grow_begin+0x75/0x360
>  kmem_cache_alloc_lru+0xe72/0xfb0
>  fat_alloc_inode+0x23/0x1e0
>  alloc_inode+0x61/0x1e0
>  new_inode_pseudo+0x13/0x80
>  new_inode+0x1b/0x40
>  fat_fill_super+0x1c37/0x3710
>  mount_bdev+0x34d/0x410
>  legacy_get_tree+0x105/0x220
>  vfs_get_tree+0x89/0x2f0
>  path_mount+0x121b/0x1cb0
>  do_mount+0xf3/0x110
>  __x64_sys_mount+0x18f/0x230
> page last free stack trace:
>  free_pcp_prepare+0x5ab/0xd00
>  free_unref_page+0x19/0x410
>  slab_destroy+0x14/0x50
>  slabs_destroy+0x6a/0x90
>  ___cache_free+0x1e3/0x3b0
>  qlist_free_all+0x51/0x1c0
>  kasan_quarantine_reduce+0x13d/0x180
>  __kasan_slab_alloc+0x97/0xb0
>  kmem_cache_alloc+0x204/0xcc0
>  getname_flags+0xd2/0x5b0
>  vfs_fstatat+0x73/0xb0
>  __do_sys_newlstat+0x8b/0x110
>  do_syscall_64+0x35/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Memory state around the buggy address:
>  ffff8880273c4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880273c4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8880273c4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                     ^
>  ffff8880273c4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880273c4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
