Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB316D14FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 03:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCaBZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCaBZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 21:25:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079EEB72;
        Thu, 30 Mar 2023 18:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7297B82B74;
        Fri, 31 Mar 2023 01:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0BFC433EF;
        Fri, 31 Mar 2023 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680225938;
        bh=hyEQNk4gCLE8LnrQ9ZdJYtZ/9Y5DNSu/BT/9X3D1jpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyPVSQbl3+l9v6zcC5DYacAv7Prc7G1nk6UD3kcY717Q6ByGp0hT+jJk4JURNemoL
         EUsNfiWTPlXladqYrdROsWOIKlr09nDdPYYlcVztdftvWe94aU0D9OAoyIStcEpd4O
         mIxdYQ6tp8XKMoMdijTNOT5r0EEh4V95yecWL3c1htgqbeyKjDP0Pq7pIDaNybIrX3
         Hh653VbYSItnQPTDf+c1bAvM2Q+BR80wEopV83kSFgBFIVo+O11BWNRdkyP0J/nwcP
         hdU/5mPK+iKqXZRhtFkIgBEtDQux7laWaO6c6pe4BeHqCVy1amKMK5ln4oXcxSjRzo
         lJw20Nin24RAA==
Date:   Thu, 30 Mar 2023 18:25:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
Message-ID: <20230331012537.GC4126677@frogsfrogsfrogs>
References: <0000000000003da76805f8021fb5@google.com>
 <20230330012750.GF3223426@dread.disaster.area>
 <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
 <20230330224302.GG3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330224302.GG3223426@dread.disaster.area>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:43:02AM +1100, Dave Chinner wrote:
> On Thu, Mar 30, 2023 at 10:52:37AM +0200, Aleksandr Nogikh wrote:
> > On Thu, Mar 30, 2023 at 3:27 AM 'Dave Chinner' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Tue, Mar 28, 2023 at 09:08:01PM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16f83651c80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1
> > > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/disk-1e760fa3.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmlinux-1e760fa3.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9/bzImage-1e760fa3.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 24101 at fs/xfs/libxfs/xfs_bmap.c:660 xfs_bmap_extents_to_btree+0xe1b/0x1190
> > >
> > > Allocation got an unexpected ENOSPC when it was supposed to have a
> > > valid reservation for the space. Likely because of an inconsistency
> > > that had been induced into the filesystem where superblock space
> > > accounting doesn't exactly match the AG space accounting and/or the
> > > tracked free space.
> > >
> > > Given this is a maliciously corrupted filesystem image, this sort of
> > > warning is expected and there's probably nothing we can do to avoid
> > > it short of a full filesystem verification pass during mount.
> > > That's not a viable solution, so I think we should just ignore
> > > syzbot when it generates this sort of warning....
> > 
> > If it's not a warning about a kernel bug, then WARN_ON should probably
> > be replaced by some more suitable reporting mechanism. Kernel coding
> > style document explicitly says:
> > 
> > "WARN*() must not be used for a condition that is expected to trigger
> > easily, for example, by user space actions.
> 
> That's exactly the case here. It should *never* happen in normal
> production workloads, and it if does then we have the *potential*
> for silent data loss occurring. That's *exactly* the sort of thing
> we should be warning admins about in no uncertain terms.  Also, we
> use WARN_ON_ONCE(), so it's not going to spam the logs.
> 
> syzbot is a malicious program - it is injecting broken stuff into
> the kernel as root to try to trigger situations like this. That
> doesn't make a warning it triggers bad or incorrect - syzbot is
> pertubing tightly coupled structures in a way that makes the
> information shared across those structures inconsistent and
> eventually the code is going to trip over that inconsistency.
> 
> IOWs, once someone has used root permissions to mount a maliciously
> crafted filesystem image, *all bets are off*. The machine is running
> a potentially compromised kernel at this point. Hence it is almost
> guaranteed that at some point the kernel is going to discover things
> are *badly wrong* and start dumping "this should never happen!"
> warnings into the logs. That's what the warnings are supposed to do,
> and the fact that syzbot can trigger them doesn't make the warnings
> wrong.
> 
> > pr_warn_once() is a
> > possible alternative, if you need to notify the user of a problem."
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=1e760fa3596e8c7f08412712c168288b79670d78#n1223
> 
> It is worth remembering that those are guidelines, not enforcable
> rules and any experienced kernel developer will tell you the same
> thing.  We know the guidelines, we know when to apply them, we know
> there are cases that the guidelines simply can't, don't or won't
> cover.

...and perhaps the WARNs that can result from corrupted metadata should
be changed to XFS_IS_CORRUPT() ?

We still get a kernel log about something going wrong, only now the
report doesn't trigger everyone's WARN triggers, and we tell the user to
go run xfs_repair.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
