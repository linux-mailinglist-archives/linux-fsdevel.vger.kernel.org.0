Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E166ECFCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjDXN4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjDXNzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:55:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C27D9B;
        Mon, 24 Apr 2023 06:55:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B67A21A9F;
        Mon, 24 Apr 2023 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682344499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3mWMagnXa0veZUiDa4m6s8vrBXrRzP4xfcaqQSLTFI=;
        b=Oh6q9yiEi+Zg5Ci4XjrSsmffW144mKBinxBulZ7sINg2CpKKZL1y2Vyfcdxks24OGH1UmF
        KoRT9K5WMLja9qq2hJGI/MnAACpS3s0LRwuZLEnIFThRK2nN3LpXK8DwdBb+ld1TL3dszr
        9BUd4cUvsqVMtfm098JsmOIr6489p94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682344499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n3mWMagnXa0veZUiDa4m6s8vrBXrRzP4xfcaqQSLTFI=;
        b=z3mLUbMHat+ozx+LhzALIze3+Y/LFKDgW43OeTY6C0uPjc25Ux8i05Q3sAzxLiD8ifIHKK
        CpIMsj8RhcQPZABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0922F13780;
        Mon, 24 Apr 2023 13:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MVJIAjOKRmSFLAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Apr 2023 13:54:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 72FE3A0729; Mon, 24 Apr 2023 15:54:57 +0200 (CEST)
Date:   Mon, 24 Apr 2023 15:54:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com>,
        amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KCSAN: data-race in inotify_handle_inode_event /
 inotify_remove_from_idr
Message-ID: <20230424135457.i6lmrznccvwv75up@quack3>
References: <000000000000c2e89505fa108749@google.com>
 <CACT4Y+arm0wqa=GbrTpH4UJrc-OCq3dwvTKa9k-yxoPLtwnbHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+arm0wqa=GbrTpH4UJrc-OCq3dwvTKa9k-yxoPLtwnbHQ@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-04-23 10:27:46, Dmitry Vyukov wrote:
> On Mon, 24 Apr 2023 at 10:09, syzbot
> <syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    622322f53c6d Merge tag 'mips-fixes_6.3_2' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1482ffafc80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4a06d4373fd52f0b2f9c
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/8b5f31d96315/disk-622322f5.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/adca7dc8daae/vmlinux-622322f5.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ed78ddc31ccb/bzImage-622322f5.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com
> 
> If I am reading this correctly, userspace can get wd=-1 as the result
> of this race. Docs say wd must refer to a previously allocated
> descriptor, which is positive. I don't see any mentions of semantics
> of wd=-1.

Yeah, indeed this looks like a possible race when we detach the mark just
while we are generating the event. I'll send a fix.

								Honza

> > ==================================================================
> > BUG: KCSAN: data-race in inotify_handle_inode_event / inotify_remove_from_idr
> >
> > write to 0xffff888104e31368 of 4 bytes by task 3229 on cpu 1:
> >  inotify_remove_from_idr+0x106/0x310 fs/notify/inotify/inotify_user.c:511
> >  inotify_ignored_and_remove_idr+0x34/0x60 fs/notify/inotify/inotify_user.c:532
> >  inotify_freeing_mark+0x1d/0x30 fs/notify/inotify/inotify_fsnotify.c:133
> >  fsnotify_free_mark fs/notify/mark.c:490 [inline]
> >  fsnotify_destroy_mark+0x17a/0x190 fs/notify/mark.c:499
> >  __do_sys_inotify_rm_watch fs/notify/inotify/inotify_user.c:817 [inline]
> >  __se_sys_inotify_rm_watch+0xf7/0x170 fs/notify/inotify/inotify_user.c:794
> >  __x64_sys_inotify_rm_watch+0x31/0x40 fs/notify/inotify/inotify_user.c:794
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > read to 0xffff888104e31368 of 4 bytes by task 3638 on cpu 0:
> >  inotify_handle_inode_event+0x17e/0x2c0 fs/notify/inotify/inotify_fsnotify.c:113
> >  fsnotify_handle_inode_event+0x19b/0x1f0 fs/notify/fsnotify.c:264
> >  fsnotify_handle_event fs/notify/fsnotify.c:316 [inline]
> >  send_to_group fs/notify/fsnotify.c:364 [inline]
> >  fsnotify+0x101c/0x1150 fs/notify/fsnotify.c:570
> >  __fsnotify_parent+0x307/0x480 fs/notify/fsnotify.c:230
> >  fsnotify_parent include/linux/fsnotify.h:77 [inline]
> >  fsnotify_file include/linux/fsnotify.h:99 [inline]
> >  fsnotify_close include/linux/fsnotify.h:341 [inline]
> >  __fput+0x4b0/0x570 fs/file_table.c:307
> >  ____fput+0x15/0x20 fs/file_table.c:349
> >  task_work_run+0x123/0x160 kernel/task_work.c:179
> >  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> >  exit_to_user_mode_loop+0xd1/0xe0 kernel/entry/common.c:171
> >  exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
> >  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
> >  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > value changed: 0x00000060 -> 0xffffffff
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 3638 Comm: syz-executor.0 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c2e89505fa108749%40google.com.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
