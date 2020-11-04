Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E82A64E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 14:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKDNMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 08:12:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:44564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgKDNMj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:12:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73F64AD35;
        Wed,  4 Nov 2020 13:12:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CA341E130F; Wed,  4 Nov 2020 14:12:35 +0100 (CET)
Date:   Wed, 4 Nov 2020 14:12:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Costa Sapuntzakis <costa@purestorage.com>
Cc:     Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+7a4ba6a239b91a126c28@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: BUG: sleeping function called from invalid context in
 ext4_superblock_csum_set
Message-ID: <20201104131235.GD5600@quack2.suse.cz>
References: <000000000000f50cb705b313ed70@google.com>
 <20201102033326.3343-1-hdanton@sina.com>
 <CAABuPhbFbQ+_nwDKXjUngtuS5twU6OqKtNu5xYW-d82JJ3cFuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABuPhbFbQ+_nwDKXjUngtuS5twU6OqKtNu5xYW-d82JJ3cFuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-11-20 09:16:19, Costa Sapuntzakis wrote:
> Jan, does this fixup from Hillf look ok to you?  You originally argued for
> lock_buffer/unlock_buffer.
> 
> I think the problem here is that the ext4 code assumes that
> ext4_commit_super will not sleep if sync == 0 (or at least
> __ext4_grp_locked_error deos). Perhaps there should be a comment on
> ext4_commit_super documenting this constraint.

Hum, right. I forgot about that. The spinlock Hillf suggests kind of works
but it still doesn't quite handle the case where superblock is modified in
parallel from another place (that can still lead to sb checksum mismatch on
next load). When we are going for a more complex solution I'd rather solve
this as well... I'm looking into possible solutions now.

								Honza

> 
> A spinlock won't sleep so fixes the problem.
> 
> An alternative is to move all calls to ext4_commit_super( , 0) outside of
> spinlocks.
> 
> -Costa
> 
> On Sun, Nov 1, 2020 at 7:34 PM Hillf Danton <hdanton@sina.com> wrote:
> 
> > On Sun, 01 Nov 2020 15:24:21 -0800
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    ed8780e3 Merge tag 'x86-urgent-2020-10-27' of git://
> > git.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=174e7b74500000
> > > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=1be40dc0ffa0bea0
> > > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=7a4ba6a239b91a126c28
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the
> > commit:
> > > Reported-by: syzbot+7a4ba6a239b91a126c28@syzkaller.appspotmail.com
> > >
> > > EXT4-fs error (device sda1): mb_free_blocks:1506: group 7, inode 16554:
> > block 229408:freeing already freed block (bit 32); block bitmap corrupt.
> > > BUG: sleeping function called from invalid context at
> > include/linux/buffer_head.h:364
> > > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9864, name:
> > syz-executor.0
> > > 5 locks held by syz-executor.0/9864:
> > >  #0: ffff888015554460 (sb_writers#6){.+.+}-{0:0}, at: sb_start_write
> > include/linux/fs.h:1648 [inline]
> > >  #0: ffff888015554460 (sb_writers#6){.+.+}-{0:0}, at:
> > mnt_want_write+0x3a/0xb0 fs/namespace.c:354
> > >  #1: ffff88801f81d4c8 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at:
> > inode_lock include/linux/fs.h:774 [inline]
> > >  #1: ffff88801f81d4c8 (&sb->s_type->i_mutex_key#9){+.+.}-{3:3}, at:
> > do_truncate+0x125/0x1f0 fs/open.c:62
> > >  #2: ffff88801f81d350 (&ei->i_mmap_sem){++++}-{3:3}, at:
> > ext4_setattr+0xdde/0x1ff0 fs/ext4/inode.c:5415
> > >  #3: ffff88801f81d2b8 (&ei->i_data_sem){++++}-{3:3}, at:
> > ext4_truncate+0x787/0x1420 fs/ext4/inode.c:4246
> > >  #4: ffff88801d7ae1d8 (&bgl->locks[i].lock){+.+.}-{2:2}, at:
> > spin_trylock include/linux/spinlock.h:364 [inline]
> > >  #4: ffff88801d7ae1d8 (&bgl->locks[i].lock){+.+.}-{2:2}, at:
> > ext4_lock_group+0x71/0x240 fs/ext4/ext4.h:3326
> > > Preemption disabled at:
> > > [<0000000000000000>] 0x0
> > > CPU: 2 PID: 9864 Comm: syz-executor.0 Not tainted 5.10.0-rc1-syzkaller #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x107/0x163 lib/dump_stack.c:118
> > >  ___might_sleep.cold+0x1e8/0x22e kernel/sched/core.c:7298
> > >  lock_buffer include/linux/buffer_head.h:364 [inline]
> > >  ext4_superblock_csum_set+0x164/0x3c0 fs/ext4/super.c:301
> > >  ext4_commit_super+0x611/0xc50 fs/ext4/super.c:5536
> > >  __ext4_grp_locked_error+0x4c9/0x570 fs/ext4/super.c:1017
> > >  mb_free_blocks+0xb59/0x15f0 fs/ext4/mballoc.c:1506
> > >  ext4_mb_release_inode_pa.isra.0+0x310/0xca0 fs/ext4/mballoc.c:4177
> > >  ext4_discard_preallocations+0x6c5/0xe90 fs/ext4/mballoc.c:4441
> > >  ext4_truncate+0x791/0x1420 fs/ext4/inode.c:4248
> > >  ext4_setattr+0x133c/0x1ff0 fs/ext4/inode.c:5490
> > >  notify_change+0xb60/0x10a0 fs/attr.c:336
> > >  do_truncate+0x134/0x1f0 fs/open.c:64
> > >  handle_truncate fs/namei.c:2910 [inline]
> > >  do_open fs/namei.c:3256 [inline]
> > >  path_openat+0x2054/0x2730 fs/namei.c:3369
> > >  do_filp_open+0x17e/0x3c0 fs/namei.c:3396
> > >  do_sys_openat2+0x16d/0x420 fs/open.c:1168
> > >  do_sys_open fs/open.c:1184 [inline]
> > >  __do_sys_creat fs/open.c:1258 [inline]
> > >  __se_sys_creat fs/open.c:1252 [inline]
> > >  __x64_sys_creat+0xc9/0x120 fs/open.c:1252
> > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > RIP: 0033:0x45da59
> > > Code: bd b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89
> > f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0
> > ff ff 0f 83 8b b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007fb835092c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> > > RAX: ffffffffffffffda RBX: 00000000006f4da0 RCX: 000000000045da59
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000300
> > > RBP: 00000000004aab8b R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075bf00
> > > R13: 00007fff472d64af R14: 00007fb835073000 R15: 0000000000000003
> > > EXT4-fs error (device sda1): ext4_mb_generate_buddy:802: group 7, block
> > bitmap and bg descriptor inconsistent: 32734 vs 32735 free clusters
> > > EXT4-fs (sda1): pa 00000000af22a596: logic 0, phys. 229408, len 32
> > > EXT4-fs error (device sda1): ext4_mb_release_inode_pa:4186: group 7,
> > free 16, pa_free 15
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > Fix acaa532687cd ("ext4: fix superblock checksum calculation race")
> > by adding a spin lock in ext4 sb and replacing lock_buffer() with it.
> >
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -285,6 +285,8 @@ static int ext4_superblock_csum_verify(s
> >  void ext4_superblock_csum_set(struct super_block *sb)
> >  {
> >         struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> > +       struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +       unsigned long flags;
> >
> >         if (!ext4_has_metadata_csum(sb))
> >                 return;
> > @@ -298,9 +300,9 @@ void ext4_superblock_csum_set(struct sup
> >          *  3) the first thread resumes and finishes its checksum
> > calculation
> >          *     and updates s_checksum with a potentially stale or torn
> > value.
> >          */
> > -       lock_buffer(EXT4_SB(sb)->s_sbh);
> > +       spin_lock_irqsave(&sbi->s_cs_lock, flags);
> >         es->s_checksum = ext4_superblock_csum(sb, es);
> > -       unlock_buffer(EXT4_SB(sb)->s_sbh);
> > +       spin_unlock_irqrestore(&sbi->s_cs_lock, flags);
> >  }
> >
> >  ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2868,6 +2868,7 @@ int ext4_mb_init(struct super_block *sb)
> >                 i++;
> >         } while (i <= sb->s_blocksize_bits + 1);
> >
> > +       spin_lock_init(&sbi->s_cs_lock);
> >         spin_lock_init(&sbi->s_md_lock);
> >         spin_lock_init(&sbi->s_bal_lock);
> >         sbi->s_mb_free_pending = 0;
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1439,6 +1439,7 @@ struct ext4_sb_info {
> >         loff_t s_bitmap_maxbytes;       /* max bytes for bitmap files */
> >         struct buffer_head * s_sbh;     /* Buffer containing the super
> > block */
> >         struct ext4_super_block *s_es;  /* Pointer to the super block in
> > the buffer */
> > +       spinlock_t s_cs_lock;           /* SB checksum lock */
> >         struct buffer_head * __rcu *s_group_desc;
> >         unsigned int s_mount_opt;
> >         unsigned int s_mount_opt2;
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
