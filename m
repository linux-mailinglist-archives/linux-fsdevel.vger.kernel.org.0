Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49C15EF6C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiI2Nkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiI2Nku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:40:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8E11F125;
        Thu, 29 Sep 2022 06:40:47 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664458844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfK0YUkL249AWAAyslMOpYKFXD2PGYqlQiJvKTj2JcU=;
        b=RnQ9jroE/zKLkHoiGgt9TCjuOMfW3M4iqg28nlA35p1Cg5BRCwM90OQqCPcQb7QzCuC8jJ
        qZ/Ffiwv7GLkVZ2XiY9r7lOm/RRIA8vEhd27FoxJGpHkgHgVIWI0W1Ump23P0d/lfIfuRW
        NgDvCb7QIdp1RFRjKq4aMUs4zUIypXgYb8mHtLe79fARswVa/Fs827eX+M8fmeH68pdbHO
        uXF/o+a00ni5aREApfbsB4HJWaTaH+Va5PoCsCU482F4tDAZ0+pb4LDGSO/MQXfTRKHZTG
        ZNyb1QJkE7JnY+78JAi4S6Z1WVIC8ae4mbAG6hg2rgIwPegmAOFC8LEQ9jwLDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664458845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfK0YUkL249AWAAyslMOpYKFXD2PGYqlQiJvKTj2JcU=;
        b=YStHJoALb8Yto97vU6ifmSvzJ6vAOIqwr7SVNeSh1voP4qKNNFL9YDJAGeAsBt7p4ADG7o
        w0UPEQc42YWSWTDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     syzbot <syzbot+dfcc5f4da15868df7d4d@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] inconsistent lock state in kmem_cache_alloc
Message-ID: <YzWgW1stzX6Rwsyi@linutronix.de>
References: <00000000000074b50005e997178a@google.com>
 <edef9f69-4b29-4c00-8c1a-67c4b8f36af0@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <edef9f69-4b29-4c00-8c1a-67c4b8f36af0@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-09-29 15:24:22 [+0200], Vlastimil Babka wrote:
> I'm not fully sure what this report means but I assume it's because there=
's
> a GFP_KERNEL kmalloc() allocation from softirq context? Should it perhaps
> use memalloc_nofs_save() at some well defined point?

my guess is
=E2=80=A6
> > Call Trace:
> >  <IRQ>
=E2=80=A6
> >  __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
> >  fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4688
> >  might_alloc include/linux/sched/mm.h:271 [inline]
> >  slab_pre_alloc_hook mm/slab.h:700 [inline]
> >  slab_alloc mm/slab.c:3278 [inline]
> >  __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
> >  kmem_cache_alloc+0x39/0x520 mm/slab.c:3491
> >  fanotify_alloc_fid_event fs/notify/fanotify/fanotify.c:580 [inline]
> >  fanotify_alloc_event fs/notify/fanotify/fanotify.c:813 [inline]

this sets GFP to GFP_KERNEL_ACCOUNT + (__GFP_NOFAIL ||
__GFP_RETRY_MAYFAIL) which contains GFP_KERNEL and

> >  fanotify_handle_event+0x1130/0x3f40 fs/notify/fanotify/fanotify.c:948
> >  send_to_group fs/notify/fsnotify.c:360 [inline]
> >  fsnotify+0xafb/0x1680 fs/notify/fsnotify.c:570
> >  __fsnotify_parent+0x62f/0xa60 fs/notify/fsnotify.c:230
> >  fsnotify_parent include/linux/fsnotify.h:77 [inline]
> >  fsnotify_file include/linux/fsnotify.h:99 [inline]
> >  fsnotify_access include/linux/fsnotify.h:309 [inline]
> >  __io_complete_rw_common+0x485/0x720 io_uring/rw.c:195
> >  io_complete_rw+0x1a/0x1f0 io_uring/rw.c:228
> >  iomap_dio_complete_work fs/iomap/direct-io.c:144 [inline]
> >  iomap_dio_bio_end_io+0x438/0x5e0 fs/iomap/direct-io.c:178
> >  bio_endio+0x5f9/0x780 block/bio.c:1564
> >  req_bio_endio block/blk-mq.c:695 [inline]
> >  blk_update_request+0x3fc/0x1300 block/blk-mq.c:825
> >  scsi_end_request+0x7a/0x9a0 drivers/scsi/scsi_lib.c:541
> >  scsi_io_completion+0x173/0x1f70 drivers/scsi/scsi_lib.c:971
> >  scsi_complete+0x122/0x3b0 drivers/scsi/scsi_lib.c:1438
> >  blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1022
> >  __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
> >  invoke_softirq kernel/softirq.c:445 [inline]
> >  __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
> >  irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
> >  common_interrupt+0xa9/0xc0 arch/x86/kernel/irq.c:240
> >  </IRQ>
=E2=80=A6

we originate from softirq we can't use GFP_KERNEL. This also noted here:

> > BUG: sleeping function called from invalid context at include/linux/sch=
ed/mm.h:274
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper=
/1
> > preempt_count: 101, expected: 0
> > RCU nest depth: 0, expected: 0
> > INFO: lockdep is turned off.
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.0.0-rc6-syzkaller-00321-g10=
5a36f3694e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 08/26/2022
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9892
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  slab_pre_alloc_hook mm/slab.h:700 [inline]
> >  slab_alloc mm/slab.c:3278 [inline]
> >  __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
> >  kmem_cache_alloc+0x381/0x520 mm/slab.c:3491
> >  fanotify_alloc_fid_event fs/notify/fanotify/fanotify.c:580 [inline]
> >  fanotify_alloc_event fs/notify/fanotify/fanotify.c:813 [inline]
> >  fanotify_handle_event+0x1130/0x3f40 fs/notify/fanotify/fanotify.c:948

So either the caller needs to be put into task-context or
fanotify_alloc_event() needs something like

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index cd7d09a569fff..9f6c5813f7a93 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -710,7 +710,7 @@ static struct fanotify_event *fanotify_alloc_event(
 				__kernel_fsid_t *fsid, u32 match_mask)
 {
 	struct fanotify_event *event =3D NULL;
-	gfp_t gfp =3D GFP_KERNEL_ACCOUNT;
+	gfp_t gfp =3D GFP_ATOMIC | __GFP_ACCOUNT;
 	unsigned int fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct inode *id =3D fanotify_fid_inode(mask, data, data_type, dir,
 					      fid_mode);

Sebastian
