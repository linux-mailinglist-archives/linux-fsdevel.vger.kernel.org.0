Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DCE1F53BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgFJLox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 07:44:53 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:49996 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgFJLow (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:44:52 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 6B800203BD;
        Wed, 10 Jun 2020 11:44:46 +0000 (UTC)
Date:   Wed, 10 Jun 2020 13:44:41 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     viro@zeniv.linux.org.uk,
        syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in proc_kill_sb
Message-ID: <20200610114441.mw42cph3gmto7gsh@comp-core-i7-2640m-0182e6>
References: <0000000000002d7ca605a7b8b1c5@google.com>
 <10cd85a7-2958-57a8-aa7e-0075194fc788@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10cd85a7-2958-57a8-aa7e-0075194fc788@I-love.SAKURA.ne.jp>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Wed, 10 Jun 2020 11:44:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:23:33PM +0900, Tetsuo Handa wrote:
> On 2020/06/10 19:56, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16e12212100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4abac52934a48af5ff19
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> The report says proc_sb_info(sb) == NULL at proc_kill_sb() which was called via
> fs->kill_sb(s) from deactivate_locked_super(). The console log says that memory
> allocation for proc_sb_info(sb) failed due to memory allocation fault injection.
> 
> [ 1492.052802][ T6840] FAULT_INJECTION: forcing a failure.
> [ 1492.052802][ T6840] name failslab, interval 1, probability 0, space 0, times 0
> [ 1492.077153][ T6840] CPU: 0 PID: 6840 Comm: syz-executor.2 Not tainted 5.7.0-syzkaller #0
> [ 1492.085449][ T6840] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> [ 1492.095511][ T6840] Call Trace:
> [ 1492.098811][ T6840]  dump_stack+0x188/0x20d
> [ 1492.103157][ T6840]  should_fail.cold+0x5/0xa
> [ 1492.107686][ T6840]  ? fault_create_debugfs_attr+0x140/0x140
> [ 1492.107721][ T6840]  ? idr_replace+0xee/0x160
> [ 1492.127210][ T6840]  should_failslab+0x5/0xf
> [ 1492.131638][ T6840]  kmem_cache_alloc_trace+0x2d0/0x7d0
> [ 1492.137020][ T6840]  ? up_write+0x148/0x470
> [ 1492.141367][ T6840]  proc_fill_super+0x79/0x5c0
> [ 1492.146052][ T6840]  ? proc_parse_param+0x8a0/0x8a0
> [ 1492.151092][ T6840]  vfs_get_super+0x12e/0x2d0
> [ 1492.155694][ T6840]  vfs_get_tree+0x89/0x2f0
> [ 1492.160126][ T6840]  do_mount+0x1306/0x1b40
> [ 1492.164467][ T6840]  ? copy_mount_string+0x40/0x40
> [ 1492.169411][ T6840]  ? __might_fault+0x190/0x1d0
> [ 1492.174188][ T6840]  ? _copy_from_user+0x13c/0x1a0
> [ 1492.179138][ T6840]  ? memdup_user+0x7c/0xd0
> [ 1492.183575][ T6840]  __x64_sys_mount+0x18f/0x230
> [ 1492.188351][ T6840]  do_syscall_64+0xf6/0x7d0
> [ 1492.192861][ T6840]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [ 1492.198759][ T6840] RIP: 0033:0x45ca69
> 
> That is, proc_kill_sb() was assuming "s->s_fs_info = fs_info;" is always
> called from proc_fill_super() which is called via fill_super(sb, fc); from
> vfs_get_super().

Yes. If fill_super() fails before filling up fs_info,
deactivate_locked_super() will be called and sb->s_fs_info may be NULL.

-- 
Rgrds, legion

