Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219E416D22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 09:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbhIXHyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbhIXHyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:54:19 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162EFC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 00:52:47 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 66so5121881vsd.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Sep 2021 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSJZmHK0rplfigbPe+OyKXUHoTZu2Oxr/dp2dPbeXZo=;
        b=gzdj3NyHgGcEz58DMDOm/sT9vAZs2CQ3rGsecE3NrrgqEQrFX51p1OawYEUl+SmcFz
         smDK/jFK/w8Ow81y9XEHT5KpxvjVzsquJZf2Z8fUGkkZSBrZ9vstgLEDHQV+cF0XGBAX
         PpU0SEjtJJBfnNM+cnAQf70lv8EZsUQsyDcpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSJZmHK0rplfigbPe+OyKXUHoTZu2Oxr/dp2dPbeXZo=;
        b=0A9PEpIGbYn/9XfCrNlHNO0iHHjERp0AB4+XJiAnFh7ci89bD5GESVyDf0mgNSdX33
         R0nnE33SVHwu6G9OsacvNHT/Qj6KDESZofqSrBzq0ZMvrguJf5t6J/CaxigxGowxwaGL
         /0sjuG4FKBDcun3uVBjI08jd5CW890SylCwkjppFYrxmcJe0vR4Tdc6XeQZlxpAhSOnI
         4W/Oz2/2Y/bdBdiJYbYCXvhrtONLMHbU8u322zly88TvI10aunL/yUD8qI/cWIYuVNn6
         V9H7D5vSM3ODGc5nhI9xsDbDjtNXAveGAgtGo+YONALmvw3q5ofbG53q49B9KxohcSZB
         gpZw==
X-Gm-Message-State: AOAM533EWqI1bKM7OsFhKFerEnw0ptEQaQgwlpI8q7yngtlbL1tjh3UJ
        Hkb3+TRH1VWqArJhsrNHIx5/yA8P6TEqqVPMVSWkzkhSNS8=
X-Google-Smtp-Source: ABdhPJwDpBjRRXRiJacMYJzUYvFonwF3nBGDAW3BV0jqMOOgQDGXDVMWU78DPW/qR7gyp7DE3wLUXlbdkW6EWv3kkCk=
X-Received: by 2002:a05:6102:3c3:: with SMTP id n3mr8041807vsq.19.1632469966191;
 Fri, 24 Sep 2021 00:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
 <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
 <1fabb91167a86990f4723e9036a0e006293518f4.camel@mediatek.com>
 <CAJfpegsOSWZpKHqDNE_B489dGCzLr-RVAhimVOsFkxJwMYmj9A@mail.gmail.com> <07c5f2f1e10671bc462f88717f84aae9ee1e4d2b.camel@mediatek.com>
In-Reply-To: <07c5f2f1e10671bc462f88717f84aae9ee1e4d2b.camel@mediatek.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 24 Sep 2021 09:52:35 +0200
Message-ID: <CAJfpegvAJS=An+hyAshkNcTS8A2TM28V2UP4SYycXUw3awOR+g@mail.gmail.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenguanyou <chenguanyou@xiaomi.com>,
        chenguanyou <chenguanyou9338@gmail.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Sept 2021 at 05:52, Ed Tsai <ed.tsai@mediatek.com> wrote:
>
> On Wed, 2021-08-18 at 17:24 +0800, Miklos Szeredi wrote:
> > On Tue, 13 Jul 2021 at 04:42, Ed Tsai <ed.tsai@mediatek.com> wrote:
> > >
> > > On Tue, 2021-06-08 at 17:30 +0200, Miklos Szeredi wrote:
> > > > On Thu, 3 Jun 2021 at 14:52, chenguanyou <
> > > > chenguanyou9338@gmail.com>
> > > > wrote:
> > > > >
> > > > > ABA deadlock
> > > > >
> > > > > PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"
> > > > > 0 [ffffff802d16b400] __switch_to at ffffff8008086a4c
> > > > > 1 [ffffff802d16b470] __schedule at ffffff80091ffe58
> > > > > 2 [ffffff802d16b4d0] schedule at ffffff8009200348
> > > > > 3 [ffffff802d16b4f0] bit_wait at ffffff8009201098
> > > > > 4 [ffffff802d16b510] __wait_on_bit at ffffff8009200a34
> > > > > 5 [ffffff802d16b5b0] inode_wait_for_writeback at
> > > > > ffffff800830e1e8
> > > > > 6 [ffffff802d16b5e0] evict at ffffff80082fb15c
> > > > > 7 [ffffff802d16b620] iput at ffffff80082f9270
> > > > > 8 [ffffff802d16b680] dentry_unlink_inode at ffffff80082f4c90
> > > > > 9 [ffffff802d16b6a0] __dentry_kill at ffffff80082f1710
> > > > > 10 [ffffff802d16b6d0] shrink_dentry_list at ffffff80082f1c34
> > > > > 11 [ffffff802d16b750] prune_dcache_sb at ffffff80082f18a8
> > > > > 12 [ffffff802d16b770] super_cache_scan at ffffff80082d55ac
> > > > > 13 [ffffff802d16b860] shrink_slab at ffffff8008266170
> > > > > 14 [ffffff802d16b900] shrink_node at ffffff800826b420
> > > > > 15 [ffffff802d16b980] do_try_to_free_pages at ffffff8008268460
> > > > > 16 [ffffff802d16ba60] try_to_free_pages at ffffff80082680d0
> > > > > 17 [ffffff802d16bbe0] __alloc_pages_nodemask at
> > > > > ffffff8008256514
> > > > > 18 [ffffff802d16bc60] fuse_copy_fill at ffffff8008438268
> > > > > 19 [ffffff802d16bd00] fuse_dev_do_read at ffffff8008437654
> > > > > 20 [ffffff802d16bdc0] fuse_dev_splice_read at ffffff8008436f40
> > > > > 21 [ffffff802d16be60] sys_splice at ffffff8008315d18
> > > > > 22 [ffffff802d16bff0] __sys_trace at ffffff8008084014
> > > > >
> > > > > PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND:
> > > > > "kworker/u16:8"
> > > > > 0 [ffffff802e793650] __switch_to at ffffff8008086a4c
> > > > > 1 [ffffff802e7936c0] __schedule at ffffff80091ffe58
> > > > > 2 [ffffff802e793720] schedule at ffffff8009200348
> > > > > 3 [ffffff802e793770] __fuse_request_send at ffffff8008435760
> > > > > 4 [ffffff802e7937b0] fuse_simple_request at ffffff8008435b14
> > > > > 5 [ffffff802e793930] fuse_flush_times at ffffff800843a7a0
> > > > > 6 [ffffff802e793950] fuse_write_inode at ffffff800843e4dc
> > > > > 7 [ffffff802e793980] __writeback_single_inode at
> > > > > ffffff8008312740
> > > > > 8 [ffffff802e793aa0] writeback_sb_inodes at ffffff80083117e4
> > > > > 9 [ffffff802e793b00] __writeback_inodes_wb at ffffff8008311d98
> > > > > 10 [ffffff802e793c00] wb_writeback at ffffff8008310cfc
> > > > > 11 [ffffff802e793d00] wb_workfn at ffffff800830e4a8
> > > > > 12 [ffffff802e793d90] process_one_work at ffffff80080e4fac
> > > > > 13 [ffffff802e793e00] worker_thread at ffffff80080e5670
> > > > > 14 [ffffff802e793e60] kthread at ffffff80080eb650
> > > >
> > > > The issue is real.
> > > >
> > > > The fix, however, is not the right one.  The fundamental problem
> > > > is
> > > > that fuse_write_inode() blocks on a request to userspace.
> > > >
> > > > This is the same issue that fuse_writepage/fuse_writepages
> > > > face.  In
> > > > that case the solution was to copy the page contents to a
> > > > temporary
> > > > buffer and return immediately as if the writeback already
> > > > completed.
> > > >
> > > > Something similar needs to be done here: send the FUSE_SETATTR
> > > > request
> > > > asynchronously and return immediately from
> > > > fuse_write_inode().  The
> > > > tricky part is to make sure that multiple time updates for the
> > > > same
> > > > inode aren't mixed up...
> > > >
> > > > Thanks,
> > > > Miklos
> > >
> > > Dear Szeredi,
> > >
> > > Writeback thread calls fuse_write_inode() and wait for user Daemon
> > > to
> > > complete this write inode request. The user daemon will
> > > alloc_page()
> > > after taking this request, and a deadlock could happen when we try
> > > to
> > > shrink dentry list under memory pressure.
> > >
> > > We (Mediatek) glad to work on this issue for mainline and also LTS.
> > > So
> > > another problem is that we should not change the protocol or
> > > feature
> > > for stable kernel.
> > >
> > > Use GFP_NOFS | __GFP_HIGHMEM can really avoid this by skip the
> > > dentry
> > > shirnker. It works but degrade the alloc_page success rate. In a
> > > more
> > > fundamental way, we could cache the contents and return
> > > immediately.
> > > But how to ensure the request will be done successfully, e.g.,
> > > always
> > > retry if it fails from daemon.
> >
> > Key is where the the dirty metadata is flushed.  To prevent deadlock
> > it must not be flushed from memory reclaim, so must make sure that it
> > is flushed on close(2) and munmap(2) and not dirtied after that.
> >
> > I'm working on this currently and hope to get it ready for the next
> > merge window.
> >
> > Thanks,
> > Miklos
>
> Hi Miklos,
>
> I'm not sure whether it has already been resolved in mainline.
> If it still WIP, please cc me on future emails.

Hi,

This is taking a bit longer, unfortunately, but I already have
something in testing and currently cleaning it up for review.  Hope to
post a series today or early next week.

Thanks,
Miklos
