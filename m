Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45566D299C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 22:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjCaUqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjCaUqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:46:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4C722210
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 13:46:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u20so15606469pfk.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680295591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvQa5duEFmv21oECF91MpJhqxo4SC69A1svuPHKziuc=;
        b=KhVXzwIWCeYgb1lZI5Yha5mNmFpNFAJqlC0Egm6HvFwWgb8Ki2n4SSpvugRY3D7BkR
         s1fg44MShT6ti7TmbJ79LYprwI882/Fr4a77KAADJnzA4VJR6b1Jgmklh5BBwWFDF1SU
         ZUQ1Nvc4tRsdwUhgNV+GfDF4ysFpvn3hWx25MLLdCX5KuKYS+MCfxG1vlpHbrl2l24Yb
         AknVvu0jfrSD133BhKNQ5ZXlH1faApCoWGgr/6thHtXalF72GX86hiBrI1MKX9eorMiP
         3Oz03NZcqXK+VkTJRCzIYyVJX5+OPHiOzkIm1AhN5j9kldHmGj52qDyl6vTjy+8tAxMI
         7d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680295591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvQa5duEFmv21oECF91MpJhqxo4SC69A1svuPHKziuc=;
        b=8IVMm1UAjBSLnU6ySP8MCG3klTS8fS7BEHYl8Z1rxzsOvqMObze15gBMvQx4LIGv1n
         UHLxvT0WTtm1LKbIVPjnsNujiNJemDFSuCcVcbpc3qI4iv7xzcRnR/yNAPUC01kDQfrG
         4e/grr0MMWj9ysCEFGlYto5UJy5COwkR5y3xUVaVbcuxar33DnobauQJpTq1Y127vPrE
         dHFrC4J9ohlpvp+bJVnJ8Iv8jurqdBYdtBwgPBCgtM8yVPzv6hRY4yC9khZSwG4X/et6
         aEYQk9Hox3gFs+1vVhO72kHy7ZLrc7P9Q7XbqoovxyOYZnhMaxn1laqndJ2VHrlL5y++
         MUUw==
X-Gm-Message-State: AAQBX9c1foFc0FGdDPfWT4YEExAaSzdOio8D18Y1bYV4I0w10BwcIQzL
        tV59MMyJzZAaSRBKq82ZPla7Wg==
X-Google-Smtp-Source: AKy350aw0znO4Oeu3iK9sCJXE4hgEGZz5IvcwXA9QAxhyhMtSSd2RJp67WN+A+KF6JXYg+3wrjWBvQ==
X-Received: by 2002:a62:4ec9:0:b0:575:b783:b6b3 with SMTP id c192-20020a624ec9000000b00575b783b6b3mr25452388pfb.28.1680295590838;
        Fri, 31 Mar 2023 13:46:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id a3-20020a62bd03000000b005abc0d426c4sm2225403pff.54.2023.03.31.13.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:46:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1piLdj-00FUjp-5i; Sat, 01 Apr 2023 07:46:27 +1100
Date:   Sat, 1 Apr 2023 07:46:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
Message-ID: <20230331204627.GH3223426@dread.disaster.area>
References: <0000000000003da76805f8021fb5@google.com>
 <20230330012750.GF3223426@dread.disaster.area>
 <CANp29Y6XNE_wxx1Osa+RrfqOUP9PZhScGnMUDgQ-qqHzYe9KFg@mail.gmail.com>
 <20230330224302.GG3223426@dread.disaster.area>
 <20230331012537.GC4126677@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230331012537.GC4126677@frogsfrogsfrogs>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:25:37PM -0700, Darrick J. Wong wrote:
> On Fri, Mar 31, 2023 at 09:43:02AM +1100, Dave Chinner wrote:
> > On Thu, Mar 30, 2023 at 10:52:37AM +0200, Aleksandr Nogikh wrote:
> > > On Thu, Mar 30, 2023 at 3:27 AM 'Dave Chinner' via syzkaller-bugs
> > > <syzkaller-bugs@googlegroups.com> wrote:
> > > >
> > > > On Tue, Mar 28, 2023 at 09:08:01PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16f83651c80000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1
> > > > > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/disk-1e760fa3.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmlinux-1e760fa3.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9/bzImage-1e760fa3.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > WARNING: CPU: 1 PID: 24101 at fs/xfs/libxfs/xfs_bmap.c:660 xfs_bmap_extents_to_btree+0xe1b/0x1190
> > > >
> > > > Allocation got an unexpected ENOSPC when it was supposed to have a
> > > > valid reservation for the space. Likely because of an inconsistency
> > > > that had been induced into the filesystem where superblock space
> > > > accounting doesn't exactly match the AG space accounting and/or the
> > > > tracked free space.
> > > >
> > > > Given this is a maliciously corrupted filesystem image, this sort of
> > > > warning is expected and there's probably nothing we can do to avoid
> > > > it short of a full filesystem verification pass during mount.
> > > > That's not a viable solution, so I think we should just ignore
> > > > syzbot when it generates this sort of warning....
> > > 
> > > If it's not a warning about a kernel bug, then WARN_ON should probably
> > > be replaced by some more suitable reporting mechanism. Kernel coding
> > > style document explicitly says:
> > > 
> > > "WARN*() must not be used for a condition that is expected to trigger
> > > easily, for example, by user space actions.
> > 
> > That's exactly the case here. It should *never* happen in normal
> > production workloads, and it if does then we have the *potential*
> > for silent data loss occurring. That's *exactly* the sort of thing
> > we should be warning admins about in no uncertain terms.  Also, we
> > use WARN_ON_ONCE(), so it's not going to spam the logs.
> > 
> > syzbot is a malicious program - it is injecting broken stuff into
> > the kernel as root to try to trigger situations like this. That
> > doesn't make a warning it triggers bad or incorrect - syzbot is
> > pertubing tightly coupled structures in a way that makes the
> > information shared across those structures inconsistent and
> > eventually the code is going to trip over that inconsistency.
> > 
> > IOWs, once someone has used root permissions to mount a maliciously
> > crafted filesystem image, *all bets are off*. The machine is running
> > a potentially compromised kernel at this point. Hence it is almost
> > guaranteed that at some point the kernel is going to discover things
> > are *badly wrong* and start dumping "this should never happen!"
> > warnings into the logs. That's what the warnings are supposed to do,
> > and the fact that syzbot can trigger them doesn't make the warnings
> > wrong.
> > 
> > > pr_warn_once() is a
> > > possible alternative, if you need to notify the user of a problem."
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=1e760fa3596e8c7f08412712c168288b79670d78#n1223
> > 
> > It is worth remembering that those are guidelines, not enforcable
> > rules and any experienced kernel developer will tell you the same
> > thing.  We know the guidelines, we know when to apply them, we know
> > there are cases that the guidelines simply can't, don't or won't
> > cover.
> 
> ...and perhaps the WARNs that can result from corrupted metadata should
> be changed to XFS_IS_CORRUPT() ?

Well, I think in the case it isn't -corrupt- metadata, more the case
that there is an inconsistency between different structures that are
internally consistent.

e.g. remove a free space extent from the freespace tree without
removing the space from the global free space counters.  Now
delalloc reservation is allowed by the global counters, but when we
got to allocate the extent - or the bmap btree block to index it -
we fail the allocation because the free space btrees are empty.

The allocation structures are not internally inconsistent or
corrupt, so it's done the right thing by returning ENOSPC. The
global counters are not obviously inconsistent or corrupt, either.
So it can be triggered by just the right sort of corruption at
exactly the right time (i.e at 100% ENOSPC), but the chances of this
convoluted set of circumstances happening in production systems is
pretty much infintesimal.

> We still get a kernel log about something going wrong, only now the
> report doesn't trigger everyone's WARN triggers, and we tell the user to
> go run xfs_repair.

I think that is exactly the wrong thing to do.

We have a history of this WARN firing as a result of software bugs
in XFS - typically a transaction space reservation or allocation
parameter setup issue - in which case a WARN_ON_ONCE is more
appropriate here than declaring the filesystem corrupt.

That's the bottom line - this specific WARN has been placed because
it is an indicator of a bug in the code, not because it is something
that occurs because of filesystem corruption. The WARN is an
indicator that the bug needs to be reported, not simply put back on
the user to clean up the mess and continue on blissfully unaware
that they tripped over a kernel bug rather than some nebulous,
unexplainable corruption.

syzbot being able to trip over it by corrupting the fs in just the
right way doesn't mean we should change it - syzbot is a malicious
attacker, not a production workload, and I really don't think we
should be changing warnings that we actually want users to report
just to shut up syzbot.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
