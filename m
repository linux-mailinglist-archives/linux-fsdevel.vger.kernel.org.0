Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1B4C01CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiBVTIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiBVTIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:08:18 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC215929E;
        Tue, 22 Feb 2022 11:07:52 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9B3877210; Tue, 22 Feb 2022 14:07:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9B3877210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1645556871;
        bh=e6LdvLmNOUpNyuvE+jmLUhatFS/jFx8h0/Y8LiEO7vE=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=wnoQ/kQLPj+AIhnFBPph5T0fT1LTM7zLEtuX+FlKPDYDuuLuiQy8QvUmP/qVGwxMS
         TGlLQa0xL5U9eiSjmFWYgAVS0KQPGASumfCG/Q/9uCSItbT21XY2OrKC+XHz3QcLe7
         1pz4jDkIbCORVjvTDU7lm+pyRKzzFfUbUdfGcL1g=
Date:   Tue, 22 Feb 2022 14:07:51 -0500
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220222190751.GA7766@fieldses.org>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For what it's worth, I applied this to recent upstream (038101e6b2cd)
and fed it through my usual scripts--tests all passed, but I did see
this lockdep warning.

I'm not actually sure what was running at the time--probably just cthon.

--b.

[  142.679891] ======================================================
[  142.680883] WARNING: possible circular locking dependency detected
[  142.681999] 5.17.0-rc5-00005-g64e79f877311 #1778 Not tainted
[  142.682970] ------------------------------------------------------
[  142.684059] test1/4557 is trying to acquire lock:
[  142.684881] ffff888023d85398 (DENTRY_PAR_UPDATE){+.+.}-{0:0}, at: d_lock_update_nested+0x5/0x6a0
[  142.686421] 
               but task is already holding lock:
[  142.687171] ffff88801f618bd0 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x7cb/0x24a0
[  142.689098] 
               which lock already depends on the new lock.

[  142.690045] 
               the existing dependency chain (in reverse order) is:
[  142.691171] 
               -> #1 (&type->i_mutex_dir_key#6){++++}-{3:3}:
[  142.692285]        down_write+0x82/0x130
[  142.692844]        vfs_rmdir+0xbd/0x560
[  142.693351]        do_rmdir+0x33d/0x400
[  142.693830]        __x64_sys_unlinkat+0xaf/0xe0
[  142.694391]        do_syscall_64+0x43/0x90
[  142.694900]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.695609] 
               -> #0 (DENTRY_PAR_UPDATE){+.+.}-{0:0}:
[  142.696357]        __lock_acquire+0x2bfd/0x61b0
[  142.696965]        lock_acquire+0x1a6/0x4b0
[  142.697489]        d_lock_update_nested+0x8d/0x6a0
[  142.698082]        lookup_open.isra.0+0x1305/0x1bf0
[  142.698685]        path_openat+0x833/0x24a0
[  142.699205]        do_filp_open+0x197/0x3c0
[  142.699725]        do_sys_openat2+0xef/0x3d0
[  142.700345]        __x64_sys_creat+0xb4/0xf0
[  142.700915]        do_syscall_64+0x43/0x90
[  142.701431]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.702112] 
               other info that might help us debug this:

[  142.702872]  Possible unsafe locking scenario:

[  142.703492]        CPU0                    CPU1
[  142.704115]        ----                    ----
[  142.704704]   lock(&type->i_mutex_dir_key#6);
[  142.705296]                                lock(DENTRY_PAR_UPDATE);
[  142.706065]                                lock(&type->i_mutex_dir_key#6);
[  142.706911]   lock(DENTRY_PAR_UPDATE);
[  142.707382] 
                *** DEADLOCK ***

[  142.707978] 2 locks held by test1/4557:
[  142.708485]  #0: ffff888011ef0438 (sb_writers#14){.+.+}-{0:0}, at: path_openat+0x1408/0x24a0
[  142.709562]  #1: ffff88801f618bd0 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x7cb/0x24a0
[  142.710757] 
               stack backtrace:
[  142.711187] CPU: 0 PID: 4557 Comm: test1 Not tainted 5.17.0-rc5-00005-g64e79f877311 #1778
[  142.712275] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1.fc35 04/01/2014
[  142.713409] Call Trace:
[  142.713717]  <TASK>
[  142.713986]  dump_stack_lvl+0x45/0x59
[  142.714449]  check_noncircular+0x23e/0x2e0
[  142.714960]  ? print_circular_bug+0x450/0x450
[  142.715502]  ? is_dynamic_key+0x1a0/0x1a0
[  142.716061]  ? _raw_spin_unlock_irqrestore+0x38/0x50
[  142.716706]  __lock_acquire+0x2bfd/0x61b0
[  142.717246]  ? do_syscall_64+0x43/0x90
[  142.717712]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.718361]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[  142.719590]  ? mark_lock.part.0+0xe7/0x2e00
[  142.720217]  lock_acquire+0x1a6/0x4b0
[  142.720706]  ? d_lock_update_nested+0x5/0x6a0
[  142.721293]  ? lock_release+0x6d0/0x6d0
[  142.721774]  ? lock_downgrade+0x690/0x690
[  142.722280]  ? do_raw_spin_unlock+0x54/0x220
[  142.722814]  d_lock_update_nested+0x8d/0x6a0
[  142.723350]  ? d_lock_update_nested+0x5/0x6a0
[  142.723959]  ? d_alloc_anon+0x10/0x10
[  142.724443]  ? kfree+0x110/0x250
[  142.724887]  ? lockdep_hardirqs_on+0x79/0x100
[  142.725454]  ? kfree+0x110/0x250
[  142.725859]  ? nfs_lookup+0x55a/0xa80 [nfs]
[  142.726410]  lookup_open.isra.0+0x1305/0x1bf0
[  142.726952]  ? lookup_positive_unlocked+0x80/0x80
[  142.727546]  ? rwsem_down_read_slowpath+0xaa0/0xaa0
[  142.728239]  path_openat+0x833/0x24a0
[  142.728700]  ? path_lookupat+0x6b0/0x6b0
[  142.729233]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[  142.729867]  ? lockdep_hardirqs_on_prepare+0x400/0x400
[  142.730502]  do_filp_open+0x197/0x3c0
[  142.730955]  ? lock_is_held_type+0xd7/0x130
[  142.731477]  ? may_open_dev+0xd0/0xd0
[  142.731994]  ? do_raw_spin_lock+0x11e/0x240
[  142.732545]  ? do_raw_spin_unlock+0x54/0x220
[  142.733115]  ? getname_flags.part.0+0x8e/0x450
[  142.733670]  do_sys_openat2+0xef/0x3d0
[  142.734140]  ? mntput_no_expire+0x10f/0xad0
[  142.734661]  ? build_open_flags+0x450/0x450
[  142.735179]  ? dput+0x30/0xa10
[  142.735565]  __x64_sys_creat+0xb4/0xf0
[  142.736091]  ? __ia32_sys_openat2+0x260/0x260
[  142.736656]  ? syscall_enter_from_user_mode+0x1d/0x50
[  142.737325]  ? lockdep_hardirqs_on+0x79/0x100
[  142.737885]  do_syscall_64+0x43/0x90
[  142.738333]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  142.738959] RIP: 0033:0x7f4c0f358e07
[  142.739408] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 55 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 74 24 0c 48 89 3c 24 e8
[  142.741911] RSP: 002b:00007ffe31b33e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
[  142.742843] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4c0f358e07
[  142.743718] RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 00007ffe31b33e80
[  142.744675] RBP: 00007ffe31b34e90 R08: 0000000000000000 R09: 00007ffe31b33be7
[  142.745589] R10: fffffffffffff934 R11: 0000000000000246 R12: 0000000000401190
[  142.746464] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  142.747343]  </TASK>
