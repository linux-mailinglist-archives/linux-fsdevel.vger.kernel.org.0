Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA776433F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 03:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjG0BKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 21:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjG0BKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:10:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB3D270D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 18:10:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-115-64.bstnma.fios.verizon.net [173.48.115.64])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36R19kRN030218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 21:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690420190; bh=L/bR0Z4HEoIH+TzQDYVYGBt7h8oQojsp2gmutOuIbRc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=mdn/Mfx72w5RkoRVKOoUmpRXPTBa6Skf94xQ6uoIEMMAO6fWgW1mlIuDIqLH6cSVy
         kxdp3O8uwOK6nJx83AlJ4NKU5PjHv2/kFdSV8mMyXodIdMCLtdEY0bqL5/sfmW+9RE
         GZUyji4xJ6qo3b+c7a1L4JQXqcZy1Ayn2i8m9Y9qjE+5EGzqPBLSsz/FAR7w9fgjyR
         5+YIYmcNwIK4p9+fBxeYe8gfsRmRBGYovIZYqnKeLWCDy/gagBqBpIR/w6v752PFbS
         PSnZfW0EeguC3Y/XOS6Q5dgtmk+86dcIXK5thE4ItC5tJQcwQSizExpXKkgYTj0p+x
         oPUGNYeRGviEQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 92CFF15C04DF; Wed, 26 Jul 2023 21:09:46 -0400 (EDT)
Date:   Wed, 26 Jul 2023 21:09:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+3f6a670108ce43356017@syzkaller.appspotmail.com>,
        agruenba@redhat.com, andersson@kernel.org,
        cluster-devel@redhat.com, eadavis@sina.com,
        konrad.dybcio@linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: use-after-free Read in qd_unlock (2)
Message-ID: <20230727010946.GD30264@mit.edu>
References: <0000000000002b5e2405f14e860f@google.com>
 <0000000000009655cc060165265f@google.com>
 <CANp29Y7UVO8QGJUC-WB=CT_MKJVUzpJ2pH+e6WAcwqX_4FPgpA@mail.gmail.com>
 <CAA8EJpq2Az=8gLyFY7j3D8-P=PUAo6ydmzvvpkcfNQnA0OCEoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpq2Az=8gLyFY7j3D8-P=PUAo6ydmzvvpkcfNQnA0OCEoA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:45:55PM +0300, Dmitry Baryshkov wrote:
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b48111a80000
  ...
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3f6a670108ce43356017

> I highly suspect that the bisect was wrong here. The only thing that
> was changed by the mentioned commit is the device tree for the pretty
> obscure platform, which is not 'Google Compute Engine'.

Yeah, it's not even close.  If you take a look at the bisection log
(which is *always* a good idea before you put any faith in the syzbot
bisection), you'd see the following:

testing commit e1c04510f521e853019afeca2a5991a5ef8d6a5b gcc
compiler: gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
kernel signature: f262f513a4ba5708b69a5fdd8c218746223996a8b2134a22f2916d16f23d01e8
run #0: crashed: unregister_netdevice: waiting for DEV to become free
run #1: crashed: unregister_netdevice: waiting for DEV to become free
run #2: crashed: unregister_netdevice: waiting for DEV to become free
run #3: crashed: unregister_netdevice: waiting for DEV to become free
run #4: crashed: unregister_netdevice: waiting for DEV to become free
run #5: crashed: unregister_netdevice: waiting for DEV to become free
run #6: crashed: unregister_netdevice: waiting for DEV to become free
run #7: crashed: unregister_netdevice: waiting for DEV to become free
run #8: crashed: unregister_netdevice: waiting for DEV to become free

This is *nothing* like the problem reported on the dashboard, which is:

BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: use-after-free in qd_unlock+0x30/0x2d0 fs/gfs2/quota.c:490
Read of size 8 at addr ffff888073997090 by task syz-executor221/5069

where the dereference had a stack trace which looked like this:

 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 qd_unlock+0x30/0x2d0 fs/gfs2/quota.c:490
 gfs2_quota_sync+0x768/0x8b0 fs/gfs2/quota.c:1325
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:650
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867

and the memory was allocated via this stack trace:

 kmem_cache_alloc+0x1b3/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 qd_alloc+0x51/0x250 fs/gfs2/quota.c:216
 gfs2_quota_init+0x7c4/0x10e0 fs/gfs2/quota.c:1415
 gfs2_make_fs_rw+0x48e/0x590 fs/gfs2/super.c:153
 gfs2_fill_super+0x2357/0x2700 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80

(And the memory was freed from an RCU path)

					- Ted
