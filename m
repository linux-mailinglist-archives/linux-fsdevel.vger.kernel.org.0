Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBED6F610A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjECWIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECWIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 18:08:22 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 15:08:20 PDT
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0E83DD
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 15:08:19 -0700 (PDT)
Date:   Wed, 3 May 2023 15:01:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683151305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEe52o0s0vNqN0LkYqOOUs/hbrATnBchTc/XRGaSnAk=;
        b=t/kjj7HN301F9hKxMUMFHnqsn1ebJ04weciwV5AR4GNMOFx76dj+cEviXvKJXPn2GHOwAs
        hrIbKruipx/ci95oj6iMUPW4gbPyiKqZYzZLVUMhwui0wpDdfyDxObj2xJ3V5g2E4oSgDE
        /xTeu5WDhyZJlklXPYIx+7izypTSjes=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        tj@kernel.org, dennis@kernel.org, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, houtao1@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] writeback, cgroup: fix null-ptr-deref write in
 bdi_split_work_to_wbs
Message-ID: <ZFLZw33qCKIYSDMJ@P9FQF9L96D.corp.robot.car>
References: <20230410130826.1492525-1-libaokun1@huawei.com>
 <20230502171701.58465d422e94cf038178dc51@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502171701.58465d422e94cf038178dc51@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 05:17:01PM -0700, Andrew Morton wrote:
> On Mon, 10 Apr 2023 21:08:26 +0800 Baokun Li <libaokun1@huawei.com> wrote:
> 
> > KASAN report null-ptr-deref:
> > ==================================================================
> > BUG: KASAN: null-ptr-deref in bdi_split_work_to_wbs+0x5c5/0x7b0
> > Write of size 8 at addr 0000000000000000 by task sync/943
> > CPU: 5 PID: 943 Comm: sync Tainted: 6.3.0-rc5-next-20230406-dirty #461
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x7f/0xc0
> >  print_report+0x2ba/0x340
> >  kasan_report+0xc4/0x120
> >  kasan_check_range+0x1b7/0x2e0
> >  __kasan_check_write+0x24/0x40
> >  bdi_split_work_to_wbs+0x5c5/0x7b0
> >  sync_inodes_sb+0x195/0x630
> >  sync_inodes_one_sb+0x3a/0x50
> >  iterate_supers+0x106/0x1b0
> >  ksys_sync+0x98/0x160
> > [...]
> > ==================================================================
> > 
> > The race that causes the above issue is as follows:
> > 
> >            cpu1                     cpu2
> > -------------------------|-------------------------
> > inode_switch_wbs
> >  INIT_WORK(&isw->work, inode_switch_wbs_work_fn)
> >  queue_rcu_work(isw_wq, &isw->work)
> >  // queue_work async
> >   inode_switch_wbs_work_fn
> >    wb_put_many(old_wb, nr_switched)
> >     percpu_ref_put_many
> >      ref->data->release(ref)
> >      cgwb_release
> >       queue_work(cgwb_release_wq, &wb->release_work)
> >       // queue_work async
> >        &wb->release_work
> >        cgwb_release_workfn
> >                             ksys_sync
> >                              iterate_supers
> >                               sync_inodes_one_sb
> >                                sync_inodes_sb
> >                                 bdi_split_work_to_wbs
> >                                  kmalloc(sizeof(*work), GFP_ATOMIC)
> >                                  // alloc memory failed
> >         percpu_ref_exit
> >          ref->data = NULL
> >          kfree(data)
> >                                  wb_get(wb)
> >                                   percpu_ref_get(&wb->refcnt)
> >                                    percpu_ref_get_many(ref, 1)
> >                                     atomic_long_add(nr, &ref->data->count)
> >                                      atomic64_add(i, v)
> >                                      // trigger null-ptr-deref
> > 
> > bdi_split_work_to_wbs() traverses &bdi->wb_list to split work into all wbs.
> > If the allocation of new work fails, the on-stack fallback will be used and
> > the reference count of the current wb is increased afterwards. If cgroup
> > writeback membership switches occur before getting the reference count and
> > the current wb is released as old_wd, then calling wb_get() or wb_put()
> > will trigger the null pointer dereference above.
> > 
> > This issue was introduced in v4.3-rc7 (see fix tag1). Both sync_inodes_sb()
> > and __writeback_inodes_sb_nr() calls to bdi_split_work_to_wbs() can trigger
> > this issue. For scenarios called via sync_inodes_sb(), originally commit
> > 7fc5854f8c6e ("writeback: synchronize sync(2) against cgroup writeback
> > membership switches") reduced the possibility of the issue by adding
> > wb_switch_rwsem, but in v5.14-rc1 (see fix tag2) removed the
> > "inode_io_list_del_locked(inode, old_wb)" from inode_switch_wbs_work_fn()
> > so that wb->state contains WB_has_dirty_io, thus old_wb is not skipped
> > when traversing wbs in bdi_split_work_to_wbs(), and the issue becomes
> > easily reproducible again.
> > 
> > To solve this problem, percpu_ref_exit() is called under RCU protection
> > to avoid race between cgwb_release_workfn() and bdi_split_work_to_wbs().
> > Moreover, replace wb_get() with wb_tryget() in bdi_split_work_to_wbs(),
> > and skip the current wb if wb_tryget() fails because the wb has already
> > been shutdown.
> > 
> > Fixes: b817525a4a80 ("writeback: bdi_writeback iteration must not skip dying ones")
> > Fixes: f3b6a6df38aa ("writeback, cgroup: keep list of inodes attached to bdi_writeback")
> 
> Cc Roman for this second commit.

Thanks for the heads up!

The patch looks good to me.
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
