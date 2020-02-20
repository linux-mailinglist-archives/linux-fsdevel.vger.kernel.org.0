Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67A8166586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgBTRyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 12:54:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:45190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgBTRyV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:54:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56EF1AE79;
        Thu, 20 Feb 2020 17:54:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CDCCDA70E; Thu, 20 Feb 2020 18:54:01 +0100 (CET)
Date:   Thu, 20 Feb 2020 18:54:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 00/23] Change readahead API
Message-ID: <20200220175400.GB2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
References: <20200219210103.32400-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:00:39PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This series adds a readahead address_space operation to eventually
> replace the readpages operation.  The key difference is that
> pages are added to the page cache as they are allocated (and
> then looked up by the filesystem) instead of passing them on a
> list to the readpages operation and having the filesystem add
> them to the page cache.  It's a net reduction in code for each
> implementation, more efficient than walking a list, and solves
> the direct-write vs buffered-read problem reported by yu kuai at
> https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/
> 
> The only unconverted filesystems are those which use fscache.
> Their conversion is pending Dave Howells' rewrite which will make the
> conversion substantially easier.
> 
> I want to thank the reviewers; Dave Chinner, John Hubbard and Christoph
> Hellwig have done a marvellous job of providing constructive criticism.
> Eric Biggers pointed out how I'd broken ext4 (which led to a substantial
> change).  I've tried to take it all on board, but I may have missed
> something simply because you've done such a thorough job.
> 
> This series can also be found at
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/tags/readahead_v7
> (I also pushed the readahead_v6 tag there in case anyone wants to diff, and
> they're both based on 5.6-rc2 so they're easy to diff)
> 
> v7:
>  - Now passes an xfstests run on ext4!

On btrfs it still chokes on the first test btrfs/001, with the following
warning, the test is stuck there.

[   21.100922] WARNING: suspicious RCU usage
[   21.103107] 5.6.0-rc2-default+ #996 Not tainted
[   21.105133] -----------------------------
[   21.106864] include/linux/xarray.h:1164 suspicious rcu_dereference_check() usage!
[   21.109948]
[   21.109948] other info that might help us debug this:
[   21.109948]
[   21.113373]
[   21.113373] rcu_scheduler_active = 2, debug_locks = 1
[   21.115801] 4 locks held by umount/793:
[   21.117135]  #0: ffff964a736890e8 (&type->s_umount_key#26){+.+.}, at: deactivate_super+0x2f/0x40
[   21.120188]  #1: ffff964a7347ba68 (&delayed_node->mutex){+.+.}, at: __btrfs_commit_inode_delayed_items+0x44c/0x4e0 [btrfs]
[   21.123042]  #2: ffff964a612fe5c8 (&space_info->groups_sem){++++}, at: find_free_extent+0x27d/0xf00 [btrfs]
[   21.126068]  #3: ffff964a60b93280 (&caching_ctl->mutex){+.+.}, at: btrfs_cache_block_group+0x1f0/0x500 [btrfs]
[   21.129655]
[   21.129655] stack backtrace:
[   21.131943] CPU: 1 PID: 793 Comm: umount Not tainted 5.6.0-rc2-default+ #996
[   21.134164] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   21.138076] Call Trace:
[   21.139441]  dump_stack+0x71/0xa0
[   21.140954]  xas_start+0x1a4/0x240
[   21.142473]  xas_load+0xa/0x50
[   21.143874]  xas_find+0x226/0x280
[   21.145298]  extent_readahead+0xcb/0x4f0 [btrfs]
[   21.146934]  ? mem_cgroup_commit_charge+0x56/0x400
[   21.148654]  ? rcu_read_lock_sched_held+0x5d/0x90
[   21.150382]  ? __add_to_page_cache_locked+0x327/0x380
[   21.152155]  read_pages+0x80/0x1f0
[   21.153531]  page_cache_readahead_unbounded+0x1b7/0x210
[   21.155196]  __load_free_space_cache+0x1c1/0x730 [btrfs]
[   21.157014]  load_free_space_cache+0xb9/0x190 [btrfs]
[   21.158222]  btrfs_cache_block_group+0x1f8/0x500 [btrfs]
[   21.159717]  ? finish_wait+0x90/0x90
[   21.160723]  find_free_extent+0xa17/0xf00 [btrfs]
[   21.161798]  ? kvm_sched_clock_read+0x14/0x30
[   21.163022]  ? sched_clock_cpu+0x10/0x120
[   21.164361]  btrfs_reserve_extent+0x9b/0x180 [btrfs]
[   21.165952]  btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
[   21.167680]  ? __lock_acquire+0x272/0x1320
[   21.169353]  alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
[   21.171313]  __btrfs_cow_block+0x143/0x7a0 [btrfs]
[   21.173080]  btrfs_cow_block+0x15f/0x310 [btrfs]
[   21.174487]  btrfs_search_slot+0x93b/0xf70 [btrfs]
[   21.175940]  btrfs_lookup_inode+0x3a/0xc0 [btrfs]
[   21.177419]  ? __btrfs_commit_inode_delayed_items+0x417/0x4e0 [btrfs]
[   21.179032]  ? __btrfs_commit_inode_delayed_items+0x44c/0x4e0 [btrfs]
[   21.180787]  __btrfs_update_delayed_inode+0x73/0x260 [btrfs]
[   21.182174]  __btrfs_commit_inode_delayed_items+0x46c/0x4e0 [btrfs]
[   21.183907]  ? btrfs_first_delayed_node+0x4c/0x90 [btrfs]
[   21.185204]  __btrfs_run_delayed_items+0x8e/0x140 [btrfs]
[   21.186521]  btrfs_commit_transaction+0x312/0xae0 [btrfs]
[   21.188142]  ? btrfs_attach_transaction_barrier+0x1f/0x50 [btrfs]
[   21.189684]  sync_filesystem+0x6e/0x90
[   21.190878]  generic_shutdown_super+0x22/0x100
[   21.192693]  kill_anon_super+0x14/0x30
[   21.194389]  btrfs_kill_super+0x12/0x20 [btrfs]
[   21.196078]  deactivate_locked_super+0x2c/0x70
[   21.197732]  cleanup_mnt+0x100/0x160
[   21.199033]  task_work_run+0x90/0xc0
[   21.200331]  exit_to_usermode_loop+0x96/0xa0
[   21.201744]  do_syscall_64+0x1df/0x210
[   21.203187]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
