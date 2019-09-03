Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE23FA6BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfICOoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:44:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfICOoy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:44:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 44E691B4534D18A27ED1;
        Tue,  3 Sep 2019 22:44:51 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 22:44:41 +0800
To:     <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>,
        <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Subject: Possible FS race condition between iterate_dir and d_alloc_parallel
CC:     "zhangyi (F)" <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Message-ID: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
Date:   Tue, 3 Sep 2019 22:44:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We recently encountered an oops(the filesystem is tmpfs)
crash> bt
PID: 108367  TASK: ffff8020d28eda00  CPU: 123  COMMAND: "du"
 #0 [ffff0000ae77b7e0] machine_kexec at ffff00006709d674
 #1 [ffff0000ae77b830] __crash_kexec at ffff000067150354
 #2 [ffff0000ae77b9c0] panic at ffff0000670a9358
 #3 [ffff0000ae77baa0] die at ffff00006708ec98
 #4 [ffff0000ae77bae0] die_kernel_fault at ffff0000670a1c6c
 #5 [ffff0000ae77bb10] __do_kernel_fault at ffff0000670a1924
 #6 [ffff0000ae77bb40] do_translation_fault at ffff0000676bb754
 #7 [ffff0000ae77bb50] do_mem_abort at ffff0000670812e0
 #8 [ffff0000ae77bd50] el1_ia at ffff000067083214
     PC: ffff0000672954c0  [dcache_readdir+216]
     LR: ffff0000672954f8  [dcache_readdir+272]
     SP: ffff0000ae77bd60  PSTATE: 60400009
    X29: ffff0000ae77bd60  X28: ffff8020d28eda00  X27: 0000000000000000
    X26: 0000000000000000  X25: 0000000056000000  X24: ffff80215c854000
    X23: 0000000000000001  X22: ffff8021f2f03290  X21: ffff803f74359698
    X20: ffff803f74359960  X19: ffff0000ae77be30  X18: 0000000000000000
    X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
    X14: 0000000000000000  X13: 0000000000000000  X12: 0000000000000000
    X11: 0000000000000000  X10: ffff8020fee99b18   X9: ffff8020fee99878
     X8: 0000000000a1f3aa   X7: 0000000000000000   X6: ffff00006727d760
     X5: ffffffffffff0073   X4: 0000000315d1d1c6   X3: 000000000000001b
     X2: 00000000ffff803f   X1: 656d616e00676f6c   X0: ffff0000ae77be30
 #9 [ffff0000ae77bd60] dcache_readdir at ffff0000672954bc

The reason is as follows:
Process 1 cat test which is not exist in directory A, process 2 cat test in directory A too.
process 3 create new file in directory B, process 4 ls directory A.

process 1(dirA)                  |process 2(dirA)                            |process 3(dirB)                       |process 4(dirA)
do_last                          |do_last                                    |do_last                               |iterate_dir
  inode_lock_shared              |  inode_lock_shared                        |  inode_lock(dirB)                    |  inode_lock_shared
  lookup_open                    |  lookup_open                              |  lookup_open                         |
    d_alloc_parallel             |    d_alloc_parallel                       |    d_alloc_parallel                  |
      d_alloc(add dtry1 to dirA) |                                           |                                      |
      hlist_bl_lock              |      d_alloc(add dtry2 to dirA)           |                                      |
      hlist_bl_add_head_rcu      |                                           |                                      |  dcache_readdir
      hlist_bl_unlock            |                                           |                                      |    p = &dentry->d_subdirs
                                 |      hlist_bl_lock                        |                                      |    next_positive(dentry, p, 1)
                                 |		hlist_bl_for_each_entry      |                                      |      p = from->next(p is dtry2)
                                 |		hlist_bl_unlock              |                                      |
                                 |		dput                         |                                      |
                                 |		  retain_dentry(dentry) false|                                      |
                                 |		  dentry_kill                |                                      |
                                 |		    spin_trylock(&parent)    |                                      |
                                 |			__dentry_kill        |                                      |
                                 |			  dentry_unlist      |                                      |
                                 |			  dentry_free(dtry2) |                                      |
                                 |                                           |      d_alloc(add dtry2 to dirB)      |
                                 |                                           |      hlist_bl_add_head_rcu           |
                                 |                                           |    dir_inode->i_op->create(new inode)|
                                 |                                           |                                      |      d = list_entry(p, struct dentry, d_child)
                                 |                                           |                                      |      if (!simple_positive(d))-->d belongs to dirB now

lookup_open-->d_in_lookup-->simple_lookup(shmem_dir_inode_operations)-->dentry->d_op = simple_dentry_operations
const struct dentry_operations simple_dentry_operations = {
	.d_delete = always_delete_dentry,
};
retain_dentry will return false


We should use spin_lock(&parent->d_lock) in next_positive. commit ebaaa80e8f20 ("lockless next_positive()") removes spin_lock, is it just for performance optimization?

Or if dput dentry, use inode_lock instead of inode_lock_shared?


