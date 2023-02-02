Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806A687C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 12:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjBBL1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 06:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBBL1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:27:45 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62E89FB4;
        Thu,  2 Feb 2023 03:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=wO45tFiNsL2/EuY48fCKGkPR7KT7t+2GynA6GE3W9PY=; b=KIlb4/+t+a1XC3ChU3fLUCJcuF
        25A3CB2TJ+2GKiGsD8vHABpd+0HCWRtOV1GEiuhid4TMvz0VVW7PKavrnJ0EtDpCooRigNU3WeWco
        DMXhItRi1rZJX9JjzSOtXz/PnAZjfyeK9zngG2BJobBM+lm8pYiXnGKzkUCf6Crp8aigIVEHUK1MN
        TpqZ28DEq6Ju4ekg/7VmzZ8FuPnlXqTeYNVwnFUNXgt2b1tX2aRqqcKr8zsXQkUh9roMD21lud+vo
        1T0rzb1nzHXkMYD7jkLCVW4JLS/wNoHp8G6YyM47CniyaU5b4xs58FWw+7QEcAEqvaJauF3lDKlJ9
        8O473845AWDMYZHl9fcyUxPOHxV9hGpWGPvZznnszCEpP2C+LxahX5ZF/gIEODvgqP9qS40LEz/UW
        rzlY+UtRs/65HueGyqxDuFL1i/pZM+ctQisqS2vgmFlRq6/vBFREhA10z9UodYoS61gomG1dgLUAw
        EenoLVhpPsTgfmK3SOGj08/1E4vsFrunWVjaU+fme6NQfg1kLobSctsNWNNXjOdMERCrnFrWDqshK
        CK2fEOyndBzyzcxM2iOabIjhEFJ3o3lNcWSPonqPV6lF2qyEQMDwGBT8AZma6I2MS+PaU94q/JIDd
        Mt0MXSomPmWYnT5ayvYvIeDDxW0okTnMF8jf85GBo=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: Re: [PATCH v3 00/11] Performance fixes for 9p filesystem
Date:   Thu, 02 Feb 2023 12:27:37 +0100
Message-ID: <2302787.WOG5zRkYfl@silver>
In-Reply-To: <20230124023834.106339-1-ericvh@kernel.org>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20230124023834.106339-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, January 24, 2023 3:38:23 AM CET Eric Van Hensbergen wrote:
> This is the third version of a patch series which adds a number
> of features to improve read/write performance in the 9p filesystem.
> Mostly it focuses on fixing caching to help utilize the recently
> increased MSIZE limits and also fixes some problematic behavior
> within the writeback code.
> 
> All together, these show roughly 10x speed increases on simple
> file transfers.  Future patch sets will improve cache consistency
> and directory caching.
> 
> These patches are also available on github:
> https://github.com/v9fs/linux/tree/ericvh/for-next
> and on kernel.org:
> https://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
> 
> Tested against qemu, cpu, and diod with fsx, dbench, and some
> simple benchmarks.

Looks like this needs more work.

I only had a glimpse on your patches yet, but made some tests by doing
compilations on guest on top of a 9p root fs [1], msize=500k. Under that
scenario:

* loose: this is suprisingly the only mode where I can see some performance
increase, over "loose" on master it compiled ~5% faster, but I also got some
misbehaviours on guest.

* writeahead: no performance results, as compilation already aborts when
trying to detect a compiler. I had to restore a previous snapshot to repair
things after this test.

* readahead: significant performance drop. In comparison to "loose" on master
compilation takes 6 times longer with "readahead". There are some severe
misbehaviours on guest as well, and after boot I get this warning:

[    5.782846] folio expected an open fid inode->i_private=0000000000000000
[    5.786641] WARNING: CPU: 0 PID: 321 at fs/9p/vfs_addr.c:174 v9fs_vfs_write_folio_locked (fs/9p/vfs_addr.c:174 (discriminator 3)) 9p
[    5.792496] Modules linked in: ppdev(E) bochs(E) sg(E) drm_vram_helper(E) joydev(E) evdev(E) drm_kms_helper(E) serio_raw(E) drm_ttm_helper(E) pcsp)
[    5.816806] CPU: 0 PID: 321 Comm: chown Tainted: G            E      6.2.0-rc6+ #61
[    5.821694] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[    5.827362] RIP: 0010:v9fs_vfs_write_folio_locked (fs/9p/vfs_addr.c:174 (discriminator 3)) 9p

Code starting with the faulting instruction
===========================================
        ...
[    5.835360] RSP: 0018:ffffc900007d3a38 EFLAGS: 00010282
[    5.836982] RAX: 0000000000000000 RBX: ffff888106c86680 RCX: 0000000000000000
[    5.838877] RDX: 0000000000000001 RSI: ffffffff821eb1e6 RDI: 00000000ffffffff
[    5.841179] RBP: ffffea0004279300 R08: 0000000000000000 R09: 00000000ffffefff
[    5.843039] R10: ffffc900007d38e8 R11: ffffffff824bede8 R12: 0000000000000000
[    5.844850] R13: 00000000ffffffea R14: 0000000000000014 R15: 0000000000000014
[    5.846366] FS:  00007fd0fc4a0580(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[    5.848250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.849386] CR2: 00007fd0fc38f4f0 CR3: 0000000100302000 CR4: 00000000000006f0
[    5.850824] Call Trace:
[    5.851622]  <TASK>
[    5.852052] v9fs_vfs_writepage (fs/9p/vfs_addr.c:207) 9p
[    5.852841] __writepage (mm/page-writeback.c:2537) 
[    5.853438] write_cache_pages (mm/page-writeback.c:2473) 
[    5.854205] ? __pfx___writepage (mm/page-writeback.c:2535) 
[    5.855309] ? delete_node (lib/radix-tree.c:575) 
[    5.856122] ? radix_tree_delete_item (lib/radix-tree.c:1432) 
[    5.857101] do_writepages (mm/page-writeback.c:2564 mm/page-writeback.c:2552 mm/page-writeback.c:2583) 
[    5.857954] ? radix_tree_delete_item (lib/radix-tree.c:1432) 
[    5.859103] filemap_fdatawrite_wbc (mm/filemap.c:389 mm/filemap.c:378) 
[    5.860043] __filemap_fdatawrite_range (mm/filemap.c:422) 
[    5.861050] filemap_write_and_wait_range (mm/filemap.c:682 mm/filemap.c:665) 
[    5.862132] v9fs_vfs_setattr_dotl (./include/linux/pagemap.h:60 fs/9p/vfs_inode_dotl.c:583) 9p
[    5.863312] notify_change (fs/attr.c:486) 
[    5.864043] ? chown_common (fs/open.c:736) 
[    5.864793] chown_common (fs/open.c:736) 
[    5.865538] ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5737 kernel/sched/core.c:5734 kernel/sched/core.c:5762) 
[    5.866420] do_fchownat (fs/open.c:768) 
[    5.867419] __x64_sys_fchownat (fs/open.c:782 fs/open.c:779 fs/open.c:779) 
[    5.868319] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[    5.869116] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[    5.871008] RIP: 0033:0x7fd0fc3b7b9a

Best regards,
Christian Schoenebeck

[1] https://wiki.qemu.org/Documentation/9p_root_fs



