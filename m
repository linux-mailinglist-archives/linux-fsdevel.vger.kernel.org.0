Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5314423F37A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHGUDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 16:03:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58521 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgHGUDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:03:04 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 077K2sxo017388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Aug 2020 16:02:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2FA1A420263; Fri,  7 Aug 2020 16:02:54 -0400 (EDT)
Date:   Fri, 7 Aug 2020 16:02:54 -0400
From:   tytso@mit.edu
To:     Xianting Tian <xianting_tian@126.com>
Cc:     viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: move buffer_mapped() to proper position
Message-ID: <20200807200254.GY7657@mit.edu>
References: <1596211825-8750-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596211825-8750-1-git-send-email-xianting_tian@126.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, applied, although I rewrote the commit description to make it
be a bit more clearer:

    fs: prevent BUG_ON in submit_bh_wbc()
    
    If a device is hot-removed --- for example, when a physical device is
    unplugged from pcie slot or a nbd device's network is shutdown ---
    this can result in a BUG_ON() crash in submit_bh_wbc().  This is
    because the when the block device dies, the buffer heads will have
    their Buffer_Mapped flag get cleared, leading to the crash in
    submit_bh_wbc.
    
    We had attempted to work around this problem in commit a17712c8
    ("ext4: check superblock mapped prior to committing").  Unfortunately,
    it's still possible to hit the BUG_ON(!buffer_mapped(bh)) if the
    device dies between when the work-around check in ext4_commit_super()
    and when submit_bh_wbh() is finally called:
    
    Code path:
    ext4_commit_super
        judge if 'buffer_mapped(sbh)' is false, return <== commit a17712c8
              lock_buffer(sbh)
              ...
              unlock_buffer(sbh)
                   __sync_dirty_buffer(sbh,...
                        lock_buffer(sbh)
                            judge if 'buffer_mapped(sbh))' is false, return <== added by this patch
                                submit_bh(...,sbh)
                                    submit_bh_wbc(...,sbh,...)
    
    [100722.966497] kernel BUG at fs/buffer.c:3095! <== BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc()
    [100722.966503] invalid opcode: 0000 [#1] SMP
    [100722.966566] task: ffff8817e15a9e40 task.stack: ffffc90024744000
    [100722.966574] RIP: 0010:submit_bh_wbc+0x180/0x190
    [100722.966575] RSP: 0018:ffffc90024747a90 EFLAGS: 00010246
    [100722.966576] RAX: 0000000000620005 RBX: ffff8818a80603a8 RCX: 0000000000000000
    [100722.966576] RDX: ffff8818a80603a8 RSI: 0000000000020800 RDI: 0000000000000001
    [100722.966577] RBP: ffffc90024747ac0 R08: 0000000000000000 R09: ffff88207f94170d
    [100722.966578] R10: 00000000000437c8 R11: 0000000000000001 R12: 0000000000020800
    [100722.966578] R13: 0000000000000001 R14: 000000000bf9a438 R15: ffff88195f333000
    [100722.966580] FS:  00007fa2eee27700(0000) GS:ffff88203d840000(0000) knlGS:0000000000000000
    [100722.966580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [100722.966581] CR2: 0000000000f0b008 CR3: 000000201a622003 CR4: 00000000007606e0
    [100722.966582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [100722.966583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [100722.966583] PKRU: 55555554
    [100722.966583] Call Trace:
    [100722.966588]  __sync_dirty_buffer+0x6e/0xd0
    [100722.966614]  ext4_commit_super+0x1d8/0x290 [ext4]
    [100722.966626]  __ext4_std_error+0x78/0x100 [ext4]
    [100722.966635]  ? __ext4_journal_get_write_access+0xca/0x120 [ext4]
    [100722.966646]  ext4_reserve_inode_write+0x58/0xb0 [ext4]
    [100722.966655]  ? ext4_dirty_inode+0x48/0x70 [ext4]
    [100722.966663]  ext4_mark_inode_dirty+0x53/0x1e0 [ext4]
    [100722.966671]  ? __ext4_journal_start_sb+0x6d/0xf0 [ext4]
    [100722.966679]  ext4_dirty_inode+0x48/0x70 [ext4]
    [100722.966682]  __mark_inode_dirty+0x17f/0x350
    [100722.966686]  generic_update_time+0x87/0xd0
    [100722.966687]  touch_atime+0xa9/0xd0
    [100722.966690]  generic_file_read_iter+0xa09/0xcd0
    [100722.966694]  ? page_cache_tree_insert+0xb0/0xb0
    [100722.966704]  ext4_file_read_iter+0x4a/0x100 [ext4]
    [100722.966707]  ? __inode_security_revalidate+0x4f/0x60
    [100722.966709]  __vfs_read+0xec/0x160
    [100722.966711]  vfs_read+0x8c/0x130
    [100722.966712]  SyS_pread64+0x87/0xb0
    [100722.966716]  do_syscall_64+0x67/0x1b0
    [100722.966719]  entry_SYSCALL64_slow_path+0x25/0x25
    
    To address this, add the check of 'buffer_mapped(bh)' to
    __sync_dirty_buffer().  This also has the benefit of fixing this for
    other file systems.
    
    With this addition, we can drop the workaround in ext4_commit_supper().
    
    [ Commit description rewritten by tytso. ]
    
    Signed-off-by: Xianting Tian <xianting_tian@126.com>
    Link: https://lore.kernel.org/r/1596211825-8750-1-git-send-email-xianting_tian@126.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

							- Ted
