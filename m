Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40143751E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 12:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhEFKDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 06:03:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:56822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhEFKDD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 06:03:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86A7BB17F;
        Thu,  6 May 2021 10:02:01 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 139b4b61;
        Thu, 6 May 2021 10:03:32 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: 9p: fscache duplicate cookie
Date:   Thu, 06 May 2021 11:03:31 +0100
Message-ID: <87czu45gcs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

I've been seeing fscache complaining about duplicate cookies in 9p:

 FS-Cache: Duplicate cookie detected
 FS-Cache: O-cookie c=00000000ba929e80 [p=000000002e706df1 fl=226 nc=0 na=1]
 FS-Cache: O-cookie d=0000000000000000 n=0000000000000000
 FS-Cache: O-key=[8] '0312710100000000'
 FS-Cache: N-cookie c=00000000274050fe [p=000000002e706df1 fl=2 nc=0 na=1]
 FS-Cache: N-cookie d=0000000037368b65 n=000000004047ed1f
 FS-Cache: N-key=[8] '0312710100000000'

It's quite easy to reproduce in my environment by running xfstests using
the virtme scripts to boot a test kernel.  A quick look seems to indicate
the warning comes from the v9fs_vfs_atomic_open_dotl() path:

[  383.688975]  __fscache_acquire_cookie+0xd1/0x2d0
[  383.688983]  v9fs_cache_inode_get_cookie.part.0+0xd1/0x100
[  383.688988]  ? v9fs_vfs_link+0x160/0x160
[  383.688994]  v9fs_inode_from_fid_dotl+0x141/0x180 
[  383.688998]  v9fs_vfs_lookup.part.0+0x1ab/0x1f0
[  383.689003]  ? v9fs_vfs_create+0x80/0x80 
[  383.689007]  v9fs_vfs_atomic_open_dotl+0x14f/0x4f0 
[  383.689011]  ? do_raw_spin_unlock+0xa3/0x130
[  383.689016]  ? v9fs_inode_from_fid_dotl+0x180/0x180
[  383.689021]  ? __d_lookup_rcu+0x270/0x270
[  383.689029]  ? down_read+0x13b/0x2c0
[  383.689044]  ? rwsem_down_read_slowpath+0x5b0/0x5b0
[  383.689052]  ? __d_lookup+0xb7/0x220
[  383.689059]  path_openat+0xb33/0x15a0
[  383.689068]  ? path_lookupat.isra.0+0x230/0x230
[  383.689073]  ? orc_find.part.0+0x200/0x200
[  383.689078]  ? ftrace_ops_trampoline+0x51/0x80
[  383.689083]  ? __kernel_text_address+0xe/0x30
[  383.689087]  ? unwind_get_return_address+0x2f/0x50
[  383.689091]  ? set_syscall_user_dispatch+0xb0/0xb0
[  383.689096]  ? arch_stack_walk+0x9e/0xf0
[  383.689101]  do_filp_open+0x136/0x1c0
[  383.689105]  ? may_open_dev+0x50/0x50
[  383.689109]  ? simple_attr_release+0x30/0x30
[  383.689113]  ? do_raw_spin_lock+0x119/0x1d0
[  383.689116]  ? rwlock_bug.part.0+0x60/0x60
[  383.689119]  ? do_raw_spin_unlock+0xa3/0x130
[  383.689123]  ? _raw_spin_unlock+0xa/0x10
[  383.689128]  ? alloc_fd+0x12e/0x290
[  383.689132]  do_sys_openat2+0x2f6/0x420
[  383.689137]  ? file_open_root+0x200/0x200
[  383.689141]  ? rwsem_wake.isra.0+0x100/0x100
[  383.689146]  do_sys_open+0x8a/0xe0
[  383.689150]  ? filp_open+0x50/0x50
[  383.689153]  ? asm_exc_page_fault+0x8/0x30
[  383.689156]  ? __x64_sys_openat+0x3e/0x60
[  383.689159]  do_syscall_64+0x45/0x80
[  383.689163]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Is this a know issue?

Cheers,
-- 
Luis
