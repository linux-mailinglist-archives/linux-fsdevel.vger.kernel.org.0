Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368E66DF1D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjDLKSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjDLKSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:18:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356474C19;
        Wed, 12 Apr 2023 03:18:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E91851F6E6;
        Wed, 12 Apr 2023 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681294722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmOoVTX9gnkxDiayDDxZ3/kFfYy1jXxF5rFN0OslPTw=;
        b=Sl8f1FB88uVYTGKvQafE7wbnuyk6f/agFZhs8d3xV05EK82NvvFtJfWf2mvoz9w02dfciv
        o6dF9fs7U/L+yOztrkDFCIs9TBHoJuVoPbi4L1kWTho6aXAyDZNQrD+wVDCh/CoHz1O+96
        9+ylqlNLlaTaPq4WzRJE2i/GUYPpaCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681294722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmOoVTX9gnkxDiayDDxZ3/kFfYy1jXxF5rFN0OslPTw=;
        b=6qmzC9hDi+At7IJOlAKpnaTHZLlBildG4atf+bFVwwTrrgCSZgL3zanbacnydQZM67JdB7
        Mg+jhoJUK6nD2fDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8969139EE;
        Wed, 12 Apr 2023 10:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n0hRNIKFNmR4FQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 10:18:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5BB3EA0732; Wed, 12 Apr 2023 12:18:42 +0200 (CEST)
Date:   Wed, 12 Apr 2023 12:18:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com>,
        syzbot <syzbot+aacb82fca60873422114@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in quotactl_fd
Message-ID: <20230412101842.m6vr26eqnfjaftdr@quack3>
References: <000000000000f1a9d205f909f327@google.com>
 <000000000000ee3a3005f909f30a@google.com>
 <20230411-sendung-apokalypse-05af1adb8889@brauner>
 <20230411105542.6dee4qf2tgt5scwx@quack3>
 <20230411-stich-tonart-8da033e58554@brauner>
 <20230411-skandal-global-379ddaf6e66a@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411-skandal-global-379ddaf6e66a@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-04-23 16:01:16, Christian Brauner wrote:
> On Tue, Apr 11, 2023 at 03:40:25PM +0200, Christian Brauner wrote:
> > On Tue, Apr 11, 2023 at 12:55:42PM +0200, Jan Kara wrote:
> > > On Tue 11-04-23 12:11:52, Christian Brauner wrote:
> > > > On Mon, Apr 10, 2023 at 11:53:46PM -0700, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot found the following issue on:
> > > > > 
> > > > > HEAD commit:    0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://g..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11798e4bc80000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > 
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > 
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/a02928003efa/disk-0d3eb744.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/7839447005a4/vmlinux-0d3eb744.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/d26ab3184148/bzImage-0d3eb744.xz
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+cdcd444e4d3a256ada13@syzkaller.appspotmail.com
> > > > > 
> > > > > ======================================================
> > > > > WARNING: possible circular locking dependency detected
> > > > > 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0 Not tainted
> > > > > ------------------------------------------------------
> > > > > syz-executor.3/11858 is trying to acquire lock:
> > > > > ffff88802a3bc0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> > > > > 
> > > > > but task is already holding lock:
> > > > > ffff88802a3bc460 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_quotactl_fd+0xd3/0x3f0 fs/quota/quota.c:990
> > > > > 
> > > > > which lock already depends on the new lock.
> > > > > 
> > > > > 
> > > > > the existing dependency chain (in reverse order) is:
> > > > > 
> > > > > -> #1 (sb_writers#4){.+.+}-{0:0}:
> > > > >        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> > > > >        __sb_start_write include/linux/fs.h:1477 [inline]
> > > > >        sb_start_write include/linux/fs.h:1552 [inline]
> > > > >        write_mmp_block+0xc4/0x820 fs/ext4/mmp.c:50
> > > > >        ext4_multi_mount_protect+0x50d/0xac0 fs/ext4/mmp.c:343
> > > > >        __ext4_remount fs/ext4/super.c:6543 [inline]
> > > > >        ext4_reconfigure+0x242b/0x2b60 fs/ext4/super.c:6642
> > > > >        reconfigure_super+0x40c/0xa30 fs/super.c:956
> > > > >        vfs_fsconfig_locked fs/fsopen.c:254 [inline]
> > > > >        __do_sys_fsconfig+0xa3a/0xc20 fs/fsopen.c:439
> > > > >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > > > >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > 
> > > > > -> #0 (&type->s_umount_key#31){++++}-{3:3}:
> > > > >        check_prev_add kernel/locking/lockdep.c:3098 [inline]
> > > > >        check_prevs_add kernel/locking/lockdep.c:3217 [inline]
> > > > >        validate_chain kernel/locking/lockdep.c:3832 [inline]
> > > > >        __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
> > > > >        lock_acquire kernel/locking/lockdep.c:5669 [inline]
> > > > >        lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
> > > > >        down_write+0x92/0x200 kernel/locking/rwsem.c:1573
> > > > >        __do_sys_quotactl_fd+0x174/0x3f0 fs/quota/quota.c:997
> > > > >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > >        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> > > > >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > 
> > > > > other info that might help us debug this:
> > > > > 
> > > > >  Possible unsafe locking scenario:
> > > > > 
> > > > >        CPU0                    CPU1
> > > > >        ----                    ----
> > > > >   lock(sb_writers#4);
> > > > >                                lock(&type->s_umount_key#31);
> > > > >                                lock(sb_writers#4);
> > > > >   lock(&type->s_umount_key#31);
> > > > > 
> > > > >  *** DEADLOCK ***
> > > > 
> > > > Hmkay, I understand how this happens, I think:
> > > > 
> > > > fsconfig(FSCONFIG_CMD_RECONFIGURE)                      quotactl_fd(Q_QUOTAON/Q_QUOTAOFF/Q_XQUOTAON/Q_XQUOTAOFF)
> > > > 							-> mnt_want_write(f.file->f_path.mnt);
> > > > -> down_write(&sb->s_umount);                              -> __sb_start_write(sb, SB_FREEZE_WRITE) 
> > > > -> reconfigure_super(fc);
> > > >    -> ext4_multi_mount_protect()
> > > >       -> __sb_start_write(sb, SB_FREEZE_WRITE)         -> down_write(&sb->s_umount);
> > > > -> up_write(&sb->s_umount);
> > > 
> > > Thanks for having a look!
> > > 
> > > > I have to step away from the computer now for a bit but naively it seem
> > > > that the locking order for quotactl_fd() should be the other way around.
> > > > 
> > > > But while I'm here, why does quotactl_fd() take mnt_want_write() but
> > > > quotactl() doesn't? It seems that if one needs to take it both need to
> > > > take it.
> > > 
> > > Couple of notes here:
> > > 
> > > 1) quotactl() handles the filesystem freezing by grabbing the s_umount
> > > semaphore, checking the superblock freeze state (it cannot change while
> > > s_umount is held) and proceeding if fs is not frozen. This logic is hidden
> > > in quotactl_block().
> > > 
> > > 2) The proper lock ordering is indeed freeze-protection -> s_umount because
> > > that is implicitely dictated by how filesystem freezing works. If you grab
> > 
> > Yep.
> 
> One final thought about this. quotactl() and quotactl_fd() could do the
> same thing though, right? quotactl() could just be made to use the same
> locking scheme as quotactl_fd(). Not saying it has to, but the code
> would probably be easier to understand/maintain if both would use the same.

Yes, that would be nice. But quotactl(2) gets a block device as an
argument, needs to translate that to a superblock (user_get_super()) and
only then we could use sb_start_write() to protect from fs freezing - but
we already hold s_umount from user_get_super() so we can't do that due to
lock ordering. That's why handling the freeze protection is so contrived in
quotactl(2). We used to have variant of user_get_super() that guaranteed
returning thawed superblock but Christoph didn't like it and only quota
code was using it so stuff got opencoded in the quota code instead (see
commit 60b498852bf2 ("fs: remove get_super_thawed and
get_super_exclusive_thawed").

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
