Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E33BFCFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfD3Pf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:35:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52863 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3PfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:35:21 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3UFYnii000575;
        Wed, 1 May 2019 00:34:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Wed, 01 May 2019 00:34:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3UFYiwL000555
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 1 May 2019 00:34:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
 <20190430025501.GB6740@quack2.suse.cz>
 <20190430031144.GG23075@ZenIV.linux.org.uk>
 <20190430130739.GA11224@quack2.suse.cz>
 <20190430131820.GK23075@ZenIV.linux.org.uk>
 <20190430150753.GA14000@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <aa220178-58d8-ffb7-399b-1d04e92e916f@i-love.sakura.ne.jp>
Date:   Wed, 1 May 2019 00:34:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430150753.GA14000@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/05/01 0:07, Jan Kara wrote:
> Ah, right. I've missed that in your patch. So your patch should be really
> fixing the problem. Will you post it officially? Thanks!

I still cannot understand what the problem is.
According to console output,

----------
INFO: task syz-executor274:8097 blocked for more than 143 seconds. 
INFO: task blkid:8099 blocked for more than 143 seconds. 

1 lock held by syz-executor274/8083:
2 locks held by syz-executor274/8097:
 #0: 000000007a5ed526 (&bdev->bd_mutex){+.+.}, at: blkdev_reread_part+0x1f/0x40 block/ioctl.c:192
 #1: 0000000067606e21 (&type->s_umount_key#39){.+.+}, at: __get_super.part.0+0x203/0x2e0 fs/super.c:788
1 lock held by blkid/8099:
 #0: 000000007a5ed526 (&bdev->bd_mutex){+.+.}, at: blkdev_put+0x34/0x560 fs/block_dev.c:1866 
----------

8099 was blocked for too long waiting for 000000007a5ed526 held by 8097.
8097 was blocked for too long waiting for 0000000067606e21 held by somebody.
Since there is nobody else holding 0000000067606e21,
I guessed that the "somebody" which is holding 0000000067606e21 is 8083.

----------
[ 1107.337625][    C1] CPU: 1 PID: 8083 Comm: syz-executor274 Not tainted 5.1.0-rc6+ #89
[ 1107.337631][    C1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[ 1107.337636][    C1] RIP: 0010:debug_lockdep_rcu_enabled.part.0+0xb/0x60
[ 1107.337648][    C1] Code: 5b 5d c3 e8 67 71 e5 ff 0f 1f 80 00 00 00 00 55 48 89 e5 e8 37 ff ff ff 5d c3 0f 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 55 <48> 89 e5 53 65 48 8b 1c 25 00 ee 01 00 48 8d bb 7c 08 00 00 48 89
[ 1107.337652][    C1] RSP: 0018:ffff8880a85274c8 EFLAGS: 00000202
[ 1107.337661][    C1] RAX: dffffc0000000000 RBX: ffff8880a85275d8 RCX: 1ffffffff12bcd63
[ 1107.337666][    C1] RDX: 0000000000000000 RSI: ffffffff870d8f3c RDI: ffff8880a85275e0
[ 1107.337672][    C1] RBP: ffff8880a85274d8 R08: ffff888081e68540 R09: ffffed1015d25bc8
[ 1107.337677][    C1] R10: ffffed1015d25bc7 R11: ffff8880ae92de3b R12: 0000000000000000
[ 1107.337683][    C1] R13: ffff8880a694d640 R14: ffff88809541b942 R15: 0000000000000006
[ 1107.337689][    C1] FS:  0000000000e0b880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
[ 1107.337693][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1107.337699][    C1] CR2: ffffffffff600400 CR3: 0000000092d6f000 CR4: 00000000001406e0
[ 1107.337704][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1107.337710][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1107.337713][    C1] Call Trace:
[ 1107.337717][    C1]  ? debug_lockdep_rcu_enabled+0x71/0xa0
[ 1107.337721][    C1]  xas_descend+0xbf/0x370
[ 1107.337724][    C1]  xas_load+0xef/0x150
[ 1107.337728][    C1]  find_get_entry+0x13d/0x880
[ 1107.337733][    C1]  ? find_get_entries_tag+0xc10/0xc10
[ 1107.337736][    C1]  ? mark_held_locks+0xa4/0xf0
[ 1107.337741][    C1]  ? pagecache_get_page+0x1a8/0x740
[ 1107.337745][    C1]  pagecache_get_page+0x4c/0x740
[ 1107.337749][    C1]  __getblk_gfp+0x27e/0x970
[ 1107.337752][    C1]  __bread_gfp+0x2f/0x300
[ 1107.337756][    C1]  udf_tread+0xf1/0x140
[ 1107.337760][    C1]  udf_read_tagged+0x50/0x530
[ 1107.337764][    C1]  udf_check_anchor_block+0x1ef/0x680
[ 1107.337768][    C1]  ? blkpg_ioctl+0xa90/0xa90
[ 1107.337772][    C1]  ? udf_process_sequence+0x35d0/0x35d0
[ 1107.337776][    C1]  ? submit_bio+0xba/0x480
[ 1107.337780][    C1]  udf_scan_anchors+0x3f4/0x680
[ 1107.337784][    C1]  ? udf_check_anchor_block+0x680/0x680
[ 1107.337789][    C1]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[ 1107.337793][    C1]  ? udf_get_last_session+0x120/0x120
[ 1107.337797][    C1]  udf_load_vrs+0x67f/0xc80
[ 1107.337801][    C1]  ? udf_scan_anchors+0x680/0x680
[ 1107.337805][    C1]  ? udf_bread+0x260/0x260
[ 1107.337809][    C1]  ? lockdep_init_map+0x1be/0x6d0
[ 1107.337813][    C1]  udf_fill_super+0x7d8/0x16d1
[ 1107.337817][    C1]  ? udf_load_vrs+0xc80/0xc80
[ 1107.337820][    C1]  ? vsprintf+0x40/0x40
[ 1107.337824][    C1]  ? set_blocksize+0x2bf/0x340
[ 1107.337829][    C1]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[ 1107.337833][    C1]  mount_bdev+0x307/0x3c0
[ 1107.337837][    C1]  ? udf_load_vrs+0xc80/0xc80
[ 1107.337840][    C1]  udf_mount+0x35/0x40
[ 1107.337844][    C1]  ? udf_get_pblock_meta25+0x3a0/0x3a0
[ 1107.337848][    C1]  legacy_get_tree+0xf2/0x200
[ 1107.337853][    C1]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[ 1107.337857][    C1]  vfs_get_tree+0x123/0x450
[ 1107.337860][    C1]  do_mount+0x1436/0x2c40
[ 1107.337864][    C1]  ? copy_mount_string+0x40/0x40
[ 1107.337868][    C1]  ? _copy_from_user+0xdd/0x150
[ 1107.337873][    C1]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[ 1107.337877][    C1]  ? copy_mount_options+0x280/0x3a0
[ 1107.337881][    C1]  ksys_mount+0xdb/0x150
[ 1107.337885][    C1]  __x64_sys_mount+0xbe/0x150
[ 1107.337889][    C1]  do_syscall_64+0x103/0x610
[ 1107.337893][    C1]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
----------

8083 is doing mount(2) but is not holding 00000000bde6230e (loop_ctl_mutex).
I guessed that something went wrong with 8083 inside __getblk_gfp().
How can loop_ctl_mutex be relevant to this problem?
