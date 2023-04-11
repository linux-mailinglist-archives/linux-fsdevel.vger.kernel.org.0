Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0946DD867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDKKzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 06:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDKKzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:55:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0021640D7;
        Tue, 11 Apr 2023 03:55:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD98B21A2E;
        Tue, 11 Apr 2023 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681210543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9Y1+9/URd8NW7LOZ9kK1XWk3bMiok40L8IAsUI6bTs=;
        b=zVW3gYqdFouypTbORdqY7WJPprJoiQArNEMq9fKY/u2PUPSCog8UmfU7DVNKsM3hQ3l87p
        TApT1cLrV/TIyB6JBzEuoq5stmGsffbCj72W61yj7C3nbHH9RBf21dMN1AdzF96+jTaYTC
        f7jg0RRFM9GdfyuyHX6DlvfYCdh2oHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681210543;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I9Y1+9/URd8NW7LOZ9kK1XWk3bMiok40L8IAsUI6bTs=;
        b=4iZf74Ttg67dzg+IONSF9LuslVkehjsbgzjUUdQ4bTa2LTc9sV/Sqvonc2WWdWXg2YCds2
        7ctBegIGaPbUcXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71A7C13519;
        Tue, 11 Apr 2023 10:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T2K1G688NWSnWgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 11 Apr 2023 10:55:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14FEDA0732; Tue, 11 Apr 2023 12:55:42 +0200 (CEST)
Date:   Tue, 11 Apr 2023 12:55:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com>,
        syzbot <syzbot+aacb82fca60873422114@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in quotactl_fd
Message-ID: <20230411105542.6dee4qf2tgt5scwx@quack3>
References: <000000000000f1a9d205f909f327@google.com>
 <000000000000ee3a3005f909f30a@google.com>
 <20230411-sendung-apokalypse-05af1adb8889@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-sendung-apokalypse-05af1adb8889@brauner>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-04-23 12:11:52, Christian Brauner wrote:
> On Mon, Apr 10, 2023 at 11:53:46PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11798e4bc80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a02928003efa/disk-0d3eb744.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/7839447005a4/vmlinux-0d3eb744.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d26ab3184148/bzImage-0d3eb744.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.3/11858 is trying to acquire lock:
> > ffff88802a3bc0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> > 
> > but task is already holding lock:
> > ffff88802a3bc460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (sb_writers#4){.+.+}-{0:0}:
> >        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> >        __sb_start_write include/linux/fs.h:1477 [inline]
> >        sb_start_write include/linux/fs.h:1552 [inline]
> >        write_mmp_block+0xc4/0x820 fs/ext4/mmp.c:50
> >        ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:343
> >        __ext4_remount fs/ext4/super.c:6543 [inline]
> >        ext4_reconfigure+0x242b/0x2b60 fs/ext4/super.c:6642
> >        reconfigure_super+0x40c/0xa30 fs/super.c:956
> >        vfs_fsconfig_locked fs/fsopen.c:254 [inline]
> >        __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > -> #0 (&type->s_umount_key#31){++++}-{3:3}:
> >        check_prev_add kernel/locking/lockdep.c:3098 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3217 [inline]
> >        validate_chain kernel/locking/lockdep.c:3832 [inline]
> >        __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
> >        lock_acquire kernel/locking/lockdep.c:5669 [inline]
> >        lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
> >        down_write+0x92/0x200 kernel/locking/rwsem.c:1573
> >        __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > other info that might help us debug this:
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(sb_writers#4);
> >                                lock(&type->s_umount_key#31);
> >                                lock(sb_writers#4);
> >   lock(&type->s_umount_key#31);
> > 
> >  *** DEADLOCK ***
> 
> Hmkay, I understand how this happens, I think:
> 
> fsconfig(FSCONFIG_CMD_RECONFIGURE)                      quotactl_fd(Q_QUOTAON/Q_QUOTAOFF/Q_XQUOTAON/Q_XQUOTAOFF)
> 							-> mnt_want_write(f.file->f_path.mnt);
> -> down_write(&sb->s_umount);                              -> __sb_start_write(sb, SB_FREEZE_WRITE) 
> -> reconfigure_super(fc);
>    -> ext4_multi_mount_protect()
>       -> __sb_start_write(sb, SB_FREEZE_WRITE)         -> down_write(&sb->s_umount);
> -> up_write(&sb->s_umount);

Thanks for having a look!

> I have to step away from the computer now for a bit but naively it seem
> that the locking order for quotactl_fd() should be the other way around.
> 
> But while I'm here, why does quotactl_fd() take mnt_want_write() but
> quotactl() doesn't? It seems that if one needs to take it both need to
> take it.

Couple of notes here:

1) quotactl() handles the filesystem freezing by grabbing the s_umount
semaphore, checking the superblock freeze state (it cannot change while
s_umount is held) and proceeding if fs is not frozen. This logic is hidden
in quotactl_block().

2) The proper lock ordering is indeed freeze-protection -> s_umount because
that is implicitely dictated by how filesystem freezing works. If you grab
s_umount and then try to grab freeze protection, you may effectively wait
for fs to get unfrozen which cannot happen while s_umount is held as
thaw_super() needs to grab it.

3) Hence this could be viewed as ext4 bug that it tries to grab freeze
protection from remount path. *But* reconfigure_super() actually has:

	if (sb->s_writers.frozen != SB_UNFROZEN)
		return -EBUSY;

so even ext4 is in fact safe because the filesystem is guaranteed to not be
frozen during remount. But still we should probably tweak the ext4 code to
avoid this lockdep warning...

								Honza

> > 1 lock held by syz-executor.3/11858:
> >  #0: ffff88802a3bc460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990
> > 
> > stack backtrace:
> > CPU: 0 PID: 11858 Comm: syz-executor.3 Not tainted 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> >  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
> >  check_prev_add kernel/locking/lockdep.c:3098 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:3217 [inline]
> >  validate_chain kernel/locking/lockdep.c:3832 [inline]
> >  __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
> >  lock_acquire kernel/locking/lockdep.c:5669 [inline]
> >  lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
> >  down_write+0x92/0x200 kernel/locking/rwsem.c:1573
> >  __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f81d2e8c169
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f81d3b29168 EFLAGS: 00000246 ORIG_RAX: 00000000000001bb
> > RAX: ffffffffffffffda RBX: 00007f81d2fabf80 RCX: 00007f81d2e8c169
> > RDX: 0000000000000000 RSI: ffffffff80000300 RDI: 0000000000000003
> > RBP: 00007f81d2ee7ca1 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fffeeb18d7f R14: 00007f81d3b29300 R15: 0000000000022000
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> On Mon, Apr 10, 2023 at 11:53:46PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13965b21c80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
> > dashboard link: https://syzkaller.appspot.com/bug?extid=aacb82fca60873422114
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/1f01c9748997/disk-76f598ba.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b3afb4fc86b9/vmlinux-76f598ba.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/8908040d7a31/bzImage-76f598ba.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+aacb82fca60873422114@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.0/17940 is trying to acquire lock:
> > ffff88802a89e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
> > ffff88802a89e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __se_sys_quotactl_fd+0x2fb/0x440 fs/quota/quota.c:972
> > 
> > but task is already holding lock:
> > ffff88802a89e460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (sb_writers#4){.+.+}-{0:0}:
> >        lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
> >        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> >        __sb_start_write include/linux/fs.h:1477 [inline]
> >        sb_start_write include/linux/fs.h:1552 [inline]
> >        write_mmp_block+0xe5/0x930 fs/ext4/mmp.c:50
> >        ext4_multi_mount_protect+0x364/0x990 fs/ext4/mmp.c:343
> >        __ext4_remount fs/ext4/super.c:6543 [inline]
> >        ext4_reconfigure+0x29a8/0x3280 fs/ext4/super.c:6642
> >        reconfigure_super+0x3c9/0x7c0 fs/super.c:956
> >        vfs_fsconfig_locked fs/fsopen.c:254 [inline]
> >        __do_sys_fsconfig fs/fsopen.c:439 [inline]
> >        __se_sys_fsconfig+0xa29/0xf70 fs/fsopen.c:314
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > -> #0 (&type->s_umount_key#31){++++}-{3:3}:
> >        check_prev_add kernel/locking/lockdep.c:3098 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3217 [inline]
> >        validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
> >        __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
> >        lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
> >        down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
> >        __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
> >        __se_sys_quotactl_fd+0x2fb/0x440 fs/quota/quota.c:972
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > other info that might help us debug this:
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(sb_writers#4);
> >                                lock(&type->s_umount_key#31);
> >                                lock(sb_writers#4);
> >   lock(&type->s_umount_key#31);
> > 
> >  *** DEADLOCK ***
> > 
> > 1 lock held by syz-executor.0/17940:
> >  #0: ffff88802a89e460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
> > 
> > stack backtrace:
> > CPU: 0 PID: 17940 Comm: syz-executor.0 Not tainted 6.3.0-rc5-syzkaller-00022-g76f598ba7d8e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
> >  check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2178
> >  check_prev_add kernel/locking/lockdep.c:3098 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:3217 [inline]
> >  validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3832
> >  __lock_acquire+0x125b/0x1f80 kernel/locking/lockdep.c:5056
> >  lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
> >  down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
> >  __do_sys_quotactl_fd fs/quota/quota.c:999 [inline]
> >  __se_sys_quotactl_fd+0x2fb/0x440 fs/quota/quota.c:972
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7f3c2aa8c169
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f3c2b826168 EFLAGS: 00000246 ORIG_RAX: 00000000000001bb
> > RAX: ffffffffffffffda RBX: 00007f3c2ababf80 RCX: 00007f3c2aa8c169
> > RDX: ffffffffffffffff RSI: ffffffff80000601 RDI: 0000000000000003
> > RBP: 00007f3c2aae7ca1 R08: 0000000000000000 R09: 0000000000000000
> > R10: 00000000200024c0 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffd71f38adf R14: 00007f3c2b826300 R15: 0000000000022000
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
