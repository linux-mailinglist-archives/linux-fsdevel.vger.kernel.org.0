Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644026DD0FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 06:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjDKEfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 00:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDKEfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEDC12B;
        Mon, 10 Apr 2023 21:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F23362123;
        Tue, 11 Apr 2023 04:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE31C433D2;
        Tue, 11 Apr 2023 04:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681187718;
        bh=E/wBeqRAmSZzBMZbuoD0qyUHxPMYBsrnjSvFkne2mJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8GV3jlWRKpxnwGZalPj+RqIUQsDhA7hJMlio/aZK8gRNHKdvM+cY51fIYDebqtM4
         sfgUcaWFGhOObtPueOTw4vpHvej1ONr/x+mb4I2vK/CYf6fcWnoI1a3kb5MKbXvLWO
         2pbxBy1JhGfV/XDAcu5ZFhUfLjkydrAGRHF5wFm/I8U5ymmW6O8Jv4WHwgyQ5Fqo1/
         cn20xRLPzx+Jr4WclZNGK+r8q8VqyZbEcZttV+QUvNL9zun7kCUjhkaxC1Kdz7gwVr
         wh+zR7+92gtl9k4opTKLc9eCRYLYjhDce78RuRn3U8lHsIRWMIXZjAktJmxgsf6ahM
         EC6k+HisxkH9w==
Date:   Mon, 10 Apr 2023 21:35:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+listea0b12829deaef4101fd@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly xfs report
Message-ID: <20230411043517.GC360895@frogsfrogsfrogs>
References: <000000000000529f1805f81b23c2@google.com>
 <20230411013512.GX3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411013512.GX3223426@dread.disaster.area>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:35:12AM +1000, Dave Chinner wrote:
> On Thu, Mar 30, 2023 at 02:58:43AM -0700, syzbot wrote:
> > Hello xfs maintainers/developers,
> > 
> > This is a 30-day syzbot report for the xfs subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/xfs
> > 
> > During the period, 5 new issues were detected and 0 were fixed.
> > In total, 23 issues are still open and 15 have been fixed so far.
> > 
> > Some of the still happening issues:
> > 
> > Crashes Repro Title
> > 327     Yes   INFO: task hung in xlog_grant_head_check
> >               https://syzkaller.appspot.com/bug?extid=568245b88fbaedcb1959
> 
> [  501.289306][ T5098] XFS (loop0): Mounting V4 Filesystem 5e6273b8-2167-42bb-911b-418aa14a1261
> [  501.299015][ T5098] XFS (loop0): Log size 128 blocks too small, minimum size is 2880 blocks
> [  501.307608][ T5098] XFS (loop0): Log size out of supported range.
> [  501.313866][ T5098] XFS (loop0): Continuing onwards, but if log hangs are experienced then please report this message in the bug report.
> 
> Syzbot doing something stupid - syzbot needs to stop testing the
> deprecated and soon to be unsupported v4 filesystem format.
> 
> Invalid.
> 
> > 85      Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
> >               https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
> 
> Bisection result is garbage.
> 
> Looks like a race between dquot shrinker grabbing a dquot buffer to
> write back a dquot and the dquot buffer being reclaimed before it is
> submitted from the delwri list. Something is dropping a buffer
> reference on the floor...
> 
> More investigation needed.
> 
> > 81      Yes   WARNING in xfs_qm_dqget_cache_insert
> >               https://syzkaller.appspot.com/bug?extid=6ae213503fb12e87934f
> 
> That'll be an ENOMEM warning on radix tree insert.
> 
> No big deal, the code cleans up and retries the lookup/insert
> process cleanly. Could just remove the warning.
> 
> Low priority, low severity.
> 
> > 47      Yes   WARNING in xfs_bmapi_convert_delalloc
> >               https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
> 
> Unexpected ENOSPC because syzbot has created a inconsistency between
> superblock counters and the free space btrees.  Warning is expected
> as it indicates user data loss is going to occur, doesn't happen in
> typical production operation, generally requires malicious
> corruption of the filesystem to trigger.
> 
> Not a bug, won't fix.
> 
> > 44      Yes   INFO: task hung in xfs_buf_item_unpin
> >               https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
> 
> Yup, that's a deadlock on the superblock buffer.
> 
> xfs_sync_sb_buf() is called from an ioctl of some kind, gets stuck
> in the log force waiting for iclogs to complete. xfs_sync_sb_buf()
> holds the buffer across the transaction commit, so the sb buffer is
> locked while waiting for the log force.
> 
> At just the wrong time, the filesystem gets shut down:
> 
>   [  484.946965][ T5959] syz-executor360: attempt to access beyond end of device
>   [  484.946965][ T5959] loop0: rw=432129, sector=65536, nr_sectors = 64 limit=65536
>   [  484.950756][   T52] XFS (loop0): log I/O error -5
>   [  484.952017][   T52] XFS (loop0): Filesystem has been shut down due to log error (0x2).
>   [  484.953902][   T52] XFS (loop0): Please unmount the filesystem and rectify the problem(s).
>   [  714.735393][   T28] INFO: task kworker/1:1H:52 blocked for more than 143 seconds.
> 
> And the iclog IO completion tries to unpin and abort all the log
> items in the current checkpoint. One of those is the superblock
> buffer, and because this is an abort:
> 
> [  714.754433][   T28]  xfs_buf_lock+0x264/0xa68
> [  714.755623][   T28]  xfs_buf_item_unpin+0x2c4/0xc18
> [  714.756875][   T28]  xfs_trans_committed_bulk+0x2d8/0x73c
> [  714.758236][   T28]  xlog_cil_committed+0x210/0xef8
> 
> The unpin code tries to lock the buffer to pass it through to IO
> completion to mark it as failed.
> 
> Real deadlock, I think it might be able to occur on any synchronous
> transaction commit that holds a buffer locked across it. No
> immediate fix comes to mind right now. Can only occur on a journal
> IO triggered shutdown, so not somethign that happens typically in
> production systems.

Force log, then xfs_ail_push_all_sync()?

It's SETLABEL, who cares how slow it is?

> Low priority, medium severity.
> 
> 
> > 13      Yes   general protection fault in __xfs_free_extent
> >               https://syzkaller.appspot.com/bug?extid=bfbc1eecdfb9b10e5792
> 
> Growfs issue. Looks like a NULL pag, which means the fsbno passed
> to __xfs_free_extent() is invalid. Without looking further, this
> looks like it's a corrupt AGF length or superblock size and this has
> resulted in the calculated fsbno starting beyond the end of the last
> AG that we are about to grow. That means the agno is beyond EOFS,
> xfs_perag_get(agno) ends up NULL, and __xfs_free_extent() goes
> splat.  Likely requires corruption to trigger.
> 
> Low priority, low severity.

I've been wondering for quite a while if the code that creates those
defer items ought to be shutting down the fs if they can't get a perag
to stuff in the intent.  xfs_perag_intent_get seems like a reasonable
place to shut down the fs with a corruption warning if someone feeds in
a totally garbage fsblock range.

> > 5       Yes   KASAN: use-after-free Read in xfs_btree_lookup_get_block
> >               https://syzkaller.appspot.com/bug?extid=7e9494b8b399902e994e
> 
> Recovery of reflink COW extents, we have a corrupted journal
> 
>    [   52.495566][ T5067] XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
>    [   52.599681][ T5067] XFS (loop0): Torn write (CRC failure) detected at log block 0x180. Truncating head block from 0x200.
>    [   52.636680][ T5067] XFS (loop0): Starting recovery (logdev: internal)
> 
> And then it looks to have a UAF on the refcountbt cursor that is
> first initialised in xfs_refcount_recover_cow_leftovers(). Likely
> tripping over a corrupted refcount btree of some kind. Probably one
> for Darrick to look into.

Somehow the bogus refcount level field in the AGF is getting past the
verifiers.  I'll look into this later.

--D

> Low priority, low severity.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
