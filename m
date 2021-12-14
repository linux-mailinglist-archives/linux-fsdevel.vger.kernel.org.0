Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA747464B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 16:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhLNPTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 10:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhLNPTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:19:51 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4BFC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 07:19:51 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a14so35504683uak.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M83RIVAuh6Ae0sf+McB6qUxiZZ3btFA3eRciQPJRccA=;
        b=mVbbK05c2Wg0STigtQeM6iFsl9PlJKPHrwi8TZt8YLKQLk5hngS4sDWxYtZZaWUQ5g
         JoUA5Cz0L3ZK83JPK0qJ4VnTGq329xEFMqsiK61LBb0ag1jcM3MXhmq72KtnwhN1Uexx
         IZyYX2NuZUQ+qukSa+QrQIxryZaqA0BoG3CH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M83RIVAuh6Ae0sf+McB6qUxiZZ3btFA3eRciQPJRccA=;
        b=YQW92ejLRHpQiWjuQgIalAIjoT8YLeRMEHbDPGfFHSh38XgVYECFGthIL8hHPlGObW
         B3RTFu5l73VdokdTLQDBmYOoMlMuFH6RB652uJpENioT31F2vbi27HaFsTqrYQkF3wgh
         Ws4c0ISejo9u1oZs9amvzjjf40+g7hEaIWVb8QHAB5oo3bxMpilgJ85s3b7sB3RkEEeu
         vWChaGEKF7+PRj42Vzo1AJYoITamq78LCfPGN68i+PJeVQiXHhWjkPc9EYBDnCpouikW
         Q1iKBqxhHLGQ8kTQLwQa2QCOZ2V9y+XyOuxdz3QIu1qXk56B9Tz+xBz0OEwD8UEv4yxs
         bTVQ==
X-Gm-Message-State: AOAM533klUvfV3rZsLTY6rZeXjLGaJqJ9p86ysh2lbyveh+Fz9Pl1Ps8
        Ee2/QlYekj/msNNr0JRt5qr6gT9hKSVhdgwjHjtxMA==
X-Google-Smtp-Source: ABdhPJxV4vZoAW5Fu1RlXMs9RwOo6grBy9Rt8hLjdofv5hOkDvVzYYfQh8SCBIVQ65Z/65Zw8JwfkJls0P+1ZCbEJRQ=
X-Received: by 2002:ab0:6c44:: with SMTP id q4mr6375328uas.72.1639495190113;
 Tue, 14 Dec 2021 07:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20210813093155.45-1-xieyongji@bytedance.com> <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
 <YbipjJJhkemx2MGn@suse.de>
In-Reply-To: <YbipjJJhkemx2MGn@suse.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Dec 2021 16:19:38 +0100
Message-ID: <CAJfpegsximsc0FrYpaDELnJXmjURQA+-7uY7yZBnMv-Mcuyisw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
To:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
Cc:     Xie Yongji <xieyongji@bytedance.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Dec 2021 at 15:26, Lu=C3=ADs Henriques <lhenriques@suse.de> wrot=
e:
>
> Hi Miklos,
>
> On Mon, Aug 16, 2021 at 02:39:14PM +0200, Miklos Szeredi wrote:
> > On Fri, Aug 13, 2021 at 05:31:55PM +0800, Xie Yongji wrote:
> > > The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> > > set in fuse_finish_open(), which can lead to deadlock in
> > > fuse_launder_page().
> > >
> > > To fix it, this tries to delay calling invalidate_inode_pages2()
> > > until FUSE_NOWRITE is removed.
> >
> > Thanks for the report and the patch.  I think it doesn't make sense to =
delay the
> > invalidate_inode_pages2() call since the inode has been truncated in th=
is case,
> > there's no data worth writing out.
> >
> > This patch replaces the invalidate_inode_pages2() with a truncate_pagec=
ache()
> > call.  This makes sense regardless of FOPEN_KEEP_CACHE or fc->writeback=
 cache,
> > so do it unconditionally.
> >
> > Can you please check out the following patch?
>
> I just saw a bug report where the obvious suspicious commit is this one.
> Here's the relevant bits from the kernel log:
>
> [ 3078.008319] BUG: Bad page state in process telegram-deskto  pfn:667339
> [ 3078.008323] page:ffffcf63d99cce40 refcount:1 mapcount:0 mapping:ffff94=
009080d838 index:0x180
> [ 3078.008329] fuse_file_aops [fuse] name:"domecamctl"
> [ 3078.008330] flags: 0x17ffffc0000034(uptodate|lru|active)
> [ 3078.008332] raw: 0017ffffc0000034 dead000000000100 dead000000000122 ff=
ff94009080d838
> [ 3078.008333] raw: 0000000000000180 0000000000000000 00000001ffffffff ff=
ff93fbc7d10000
> [ 3078.008333] page dumped because: page still charged to cgroup
> [ 3078.008334] page->mem_cgroup:ffff93fbc7d10000
> [ 3078.008334] bad because of flags: 0x30(lru|active)
> [ 3078.008335] Modules linked in: <...>
> [ 3078.008388] Supported: Yes
> [ 3078.008390] CPU: 1 PID: 3738 Comm: telegram-deskto Kdump: loaded Not t=
ainted 5.3.18-59.37-default #1 SLE15-SP3
> [ 3078.008390] Hardware name: System manufacturer System Product Name/P8H=
77-M PRO, BIOS 0412 02/08/2012
> [ 3078.008391] Call Trace:
> [ 3078.008397]  dump_stack+0x66/0x8b
> [ 3078.008399]  bad_page+0xc9/0x130
> [ 3078.008401]  free_pcppages_bulk+0x443/0x870
> [ 3078.008403]  free_unref_page_list+0x102/0x180
> [ 3078.008406]  release_pages+0x301/0x400
> [ 3078.008408]  __pagevec_release+0x2b/0x30
> [ 3078.008409]  invalidate_inode_pages2_range+0x4d5/0x550
> [ 3078.008412]  ? finish_wait+0x2f/0x60
> [ 3078.008416]  fuse_finish_open+0x76/0xf0 [fuse]
> [ 3078.008419]  fuse_open_common+0x105/0x110 [fuse]
> [ 3078.008421]  ? fuse_open_common+0x110/0x110 [fuse]
> [ 3078.008424]  do_dentry_open+0x204/0x3a0
> [ 3078.008426]  path_openat+0x2fc/0x1520
> [ 3078.008429]  ? mem_cgroup_commit_charge+0x5f/0x490
> [ 3078.008431]  do_filp_open+0x9b/0x110
> [ 3078.008433]  ? _copy_from_user+0x37/0x60
> [ 3078.008435]  ? kmem_cache_alloc+0x18a/0x270
> [ 3078.008436]  ? do_sys_open+0x1bd/0x260
> [ 3078.008437]  do_sys_open+0x1bd/0x260
> [ 3078.008440]  do_syscall_64+0x5b/0x1e0
> [ 3078.008442]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 3078.008443] RIP: 0033:0x7f841f18b542
> [ 3078.008444] Code: 89 45 b0 eb 93 0f 1f 00 44 89 55 9c e8 67 f5 ff ff 4=
4 8b 55 9c 44 89 e2 4c 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 36 44 89 c7 89 45 9c e8 bb f5 ff ff 8b 45 9c
> [ 3078.008445] RSP: 002b:00007ffdcf69f0e0 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000101
> [ 3078.008446] RAX: ffffffffffffffda RBX: 00007f83ec4950f0 RCX: 00007f841=
f18b542
> [ 3078.008446] RDX: 0000000000080000 RSI: 00007f83ec4950f0 RDI: 00000000f=
fffff9c
> [ 3078.008447] RBP: 00007ffdcf69f150 R08: 0000000000000000 R09: fffffffff=
fffe798
> [ 3078.008448] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000=
0080000
> [ 3078.008448] R13: 00007f83ec4950f0 R14: 00007ffdcf69f170 R15: 00007f83f=
798dcd0
> [ 3078.008449] Disabling lock debugging due to kernel taint
>
> This happens on an openSUSE kernel that contains a backport of commit
> 76224355db75 ("fuse: truncate pagecache on atomic_o_trunc") [1] but
> there's also another report here [2] (seems to be the same issue), for a
> 5.15 (ubuntu) kernel.

The bad page state reminds me of this bug:

712a951025c0 ("fuse: fix page stealing")

and the necessary followup fix:

473441720c86 ("fuse: release pipe buf after last use")

Could be something completely different, I didn't do any analysis.

Thanks,
Miklos
