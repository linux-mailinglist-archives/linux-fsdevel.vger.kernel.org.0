Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B951C6DDC59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjDKNkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDKNk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9F193;
        Tue, 11 Apr 2023 06:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF96C62697;
        Tue, 11 Apr 2023 13:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECCAC433D2;
        Tue, 11 Apr 2023 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681220425;
        bh=SM+LW7qNdO+B8rDB+2YprziR2dW3y83RFqB+dq4C/Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bslgj2necammy2+qfFkERZ6Fhz65YMuBVdPL7y7XdW8TIy4wcs8f0Bw336x7EmwXi
         /YkrkEG/6PO68q97yHBl03tE0mecBVDEnfAahipYNtLVuu+Y0jiap3TkhP01SYVmTU
         o91/iiygAW2mMMRrFiB/woHKP+8TfiKs7IL3bxejsz8nIeWqxX7wjRCtr0ojhOXlSj
         P2nxsM57C8KFxD/cWAaHzwydEltNCJQrdI+aYgIWwe+hsjzrGVl2hpMy1nqNKIJWXV
         J7jhb0aYPJLwrkQGzfqeYCuLcN70U082EzpevZnq/5b2d9Ej51AYpZF7t/jUTpsQ0W
         pMk8vhsjFLcbQ==
Date:   Tue, 11 Apr 2023 15:40:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com>,
        syzbot <syzbot+aacb82fca60873422114@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in quotactl_fd
Message-ID: <20230411-stich-tonart-8da033e58554@brauner>
References: <000000000000f1a9d205f909f327@google.com>
 <000000000000ee3a3005f909f30a@google.com>
 <20230411-sendung-apokalypse-05af1adb8889@brauner>
 <20230411105542.6dee4qf2tgt5scwx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411105542.6dee4qf2tgt5scwx@quack3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:55:42PM +0200, Jan Kara wrote:
> On Tue 11-04-23 12:11:52, Christian Brauner wrote:
> > On Mon, Apr 10, 2023 at 11:53:46PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://g..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11798e4bc80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/a02928003efa/disk-0d3eb744.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/7839447005a4/vmlinux-0d3eb744.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/d26ab3184148/bzImage-0d3eb744.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com
> > > 
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0 Not tainted
> > > ------------------------------------------------------
> > > syz-executor.3/11858 is trying to acquire lock:
> > > ffff88802a3bc0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> > > 
> > > but task is already holding lock:
> > > ffff88802a3bc460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990
> > > 
> > > which lock already depends on the new lock.
> > > 
> > > 
> > > the existing dependency chain (in reverse order) is:
> > > 
> > > -> #1 (sb_writers#4){.+.+}-{0:0}:
> > >        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> > >        __sb_start_write include/linux/fs.h:1477 [inline]
> > >        sb_start_write include/linux/fs.h:1552 [inline]
> > >        write_mmp_block+0xc4/0x820 fs/ext4/mmp.c:50
> > >        ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:343
> > >        __ext4_remount fs/ext4/super.c:6543 [inline]
> > >        ext4_reconfigure+0x242b/0x2b60 fs/ext4/super.c:6642
> > >        reconfigure_super+0x40c/0xa30 fs/super.c:956
> > >        vfs_fsconfig_locked fs/fsopen.c:254 [inline]
> > >        __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
> > >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > 
> > > -> #0 (&type->s_umount_key#31){++++}-{3:3}:
> > >        check_prev_add kernel/locking/lockdep.c:3098 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3217 [inline]
> > >        validate_chain kernel/locking/lockdep.c:3832 [inline]
> > >        __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
> > >        lock_acquire kernel/locking/lockdep.c:5669 [inline]
> > >        lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
> > >        down_write+0x92/0x200 kernel/locking/rwsem.c:1573
> > >        __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> > >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > 
> > > other info that might help us debug this:
> > > 
> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(sb_writers#4);
> > >                                lock(&type->s_umount_key#31);
> > >                                lock(sb_writers#4);
> > >   lock(&type->s_umount_key#31);
> > > 
> > >  *** DEADLOCK ***
> > 
> > Hmkay, I understand how this happens, I think:
> > 
> > fsconfig(FSCONFIG_CMD_RECONFIGURE)                      quotactl_fd(Q_QUOTAON/Q_QUOTAOFF/Q_XQUOTAON/Q_XQUOTAOFF)
> > 							-> mnt_want_write(f.file->f_path.mnt);
> > -> down_write(&sb->s_umount);                              -> __sb_start_write(sb, SB_FREEZE_WRITE) 
> > -> reconfigure_super(fc);
> >    -> ext4_multi_mount_protect()
> >       -> __sb_start_write(sb, SB_FREEZE_WRITE)         -> down_write(&sb->s_umount);
> > -> up_write(&sb->s_umount);
> 
> Thanks for having a look!
> 
> > I have to step away from the computer now for a bit but naively it seem
> > that the locking order for quotactl_fd() should be the other way around.
> > 
> > But while I'm here, why does quotactl_fd() take mnt_want_write() but
> > quotactl() doesn't? It seems that if one needs to take it both need to
> > take it.
> 
> Couple of notes here:
> 
> 1) quotactl() handles the filesystem freezing by grabbing the s_umount
> semaphore, checking the superblock freeze state (it cannot change while
> s_umount is held) and proceeding if fs is not frozen. This logic is hidden
> in quotactl_block().
> 
> 2) The proper lock ordering is indeed freeze-protection -> s_umount because
> that is implicitely dictated by how filesystem freezing works. If you grab

Yep.

> s_umount and then try to grab freeze protection, you may effectively wait
> for fs to get unfrozen which cannot happen while s_umount is held as
> thaw_super() needs to grab it.

Yep.

> 
> 3) Hence this could be viewed as ext4 bug that it tries to grab freeze
> protection from remount path. *But* reconfigure_super() actually has:
> 
> 	if (sb->s_writers.frozen != SB_UNFROZEN)
> 		return -EBUSY;

And user_get_super() grabs sb->s_umount which means it's not racy to
check for SB_UNFROZEN. I missed that rushing out the door. :)

> 
> so even ext4 is in fact safe because the filesystem is guaranteed to not be
> frozen during remount. But still we should probably tweak the ext4 code to
> avoid this lockdep warning...

Thanks for that!

Christian
