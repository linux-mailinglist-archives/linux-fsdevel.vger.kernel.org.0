Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB3A474687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 16:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhLNPfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 10:35:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55378 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhLNPfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:35:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60890210EA;
        Tue, 14 Dec 2021 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639496118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uofOO2eG5QspUeR0BGd3fzukE3hD/IhRzbPf+EO4ZSk=;
        b=J/zOBMyXRFYiHA9ruO/rMftqygJPsxR/Gl3H8YzMjWTGWAec28b6l4zGlxOpgqdMQGVs1N
        F9d4HKRFu8gBErnsVo3EkTT0iSbnP/aEdsijGUwQMnUkVzf8SCvqJq00mMb04HcOIoB9pA
        kTBTThIO2hSibLclbuAsrXPTEeJZUZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639496118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uofOO2eG5QspUeR0BGd3fzukE3hD/IhRzbPf+EO4ZSk=;
        b=QNe/gBUkmlDNHSvl/kMGdJmZXVEADovncJN6IeZ7WrsX7fPBZ/PUu9nz++PH4PDRK1pmBd
        peaVoCZhNop15YCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D1DF13EB3;
        Tue, 14 Dec 2021 15:35:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aqf3A7a5uGGYZwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 14 Dec 2021 15:35:18 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b6ae695c;
        Tue, 14 Dec 2021 15:35:15 +0000 (UTC)
Date:   Tue, 14 Dec 2021 15:35:15 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Xie Yongji <xieyongji@bytedance.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
Message-ID: <Ybi5s7bYkEAqEffs@suse.de>
References: <20210813093155.45-1-xieyongji@bytedance.com>
 <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
 <YbipjJJhkemx2MGn@suse.de>
 <CAJfpegsximsc0FrYpaDELnJXmjURQA+-7uY7yZBnMv-Mcuyisw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegsximsc0FrYpaDELnJXmjURQA+-7uY7yZBnMv-Mcuyisw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:19:38PM +0100, Miklos Szeredi wrote:
> On Tue, 14 Dec 2021 at 15:26, Luís Henriques <lhenriques@suse.de> wrote:
> >
> > Hi Miklos,
> >
> > On Mon, Aug 16, 2021 at 02:39:14PM +0200, Miklos Szeredi wrote:
> > > On Fri, Aug 13, 2021 at 05:31:55PM +0800, Xie Yongji wrote:
> > > > The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> > > > set in fuse_finish_open(), which can lead to deadlock in
> > > > fuse_launder_page().
> > > >
> > > > To fix it, this tries to delay calling invalidate_inode_pages2()
> > > > until FUSE_NOWRITE is removed.
> > >
> > > Thanks for the report and the patch.  I think it doesn't make sense to delay the
> > > invalidate_inode_pages2() call since the inode has been truncated in this case,
> > > there's no data worth writing out.
> > >
> > > This patch replaces the invalidate_inode_pages2() with a truncate_pagecache()
> > > call.  This makes sense regardless of FOPEN_KEEP_CACHE or fc->writeback cache,
> > > so do it unconditionally.
> > >
> > > Can you please check out the following patch?
> >
> > I just saw a bug report where the obvious suspicious commit is this one.
> > Here's the relevant bits from the kernel log:
> >
> > [ 3078.008319] BUG: Bad page state in process telegram-deskto  pfn:667339
> > [ 3078.008323] page:ffffcf63d99cce40 refcount:1 mapcount:0 mapping:ffff94009080d838 index:0x180
> > [ 3078.008329] fuse_file_aops [fuse] name:"domecamctl"
> > [ 3078.008330] flags: 0x17ffffc0000034(uptodate|lru|active)
> > [ 3078.008332] raw: 0017ffffc0000034 dead000000000100 dead000000000122 ffff94009080d838
> > [ 3078.008333] raw: 0000000000000180 0000000000000000 00000001ffffffff ffff93fbc7d10000
> > [ 3078.008333] page dumped because: page still charged to cgroup
> > [ 3078.008334] page->mem_cgroup:ffff93fbc7d10000
> > [ 3078.008334] bad because of flags: 0x30(lru|active)
> > [ 3078.008335] Modules linked in: <...>
> > [ 3078.008388] Supported: Yes
> > [ 3078.008390] CPU: 1 PID: 3738 Comm: telegram-deskto Kdump: loaded Not tainted 5.3.18-59.37-default #1 SLE15-SP3
> > [ 3078.008390] Hardware name: System manufacturer System Product Name/P8H77-M PRO, BIOS 0412 02/08/2012
> > [ 3078.008391] Call Trace:
> > [ 3078.008397]  dump_stack+0x66/0x8b
> > [ 3078.008399]  bad_page+0xc9/0x130
> > [ 3078.008401]  free_pcppages_bulk+0x443/0x870
> > [ 3078.008403]  free_unref_page_list+0x102/0x180
> > [ 3078.008406]  release_pages+0x301/0x400
> > [ 3078.008408]  __pagevec_release+0x2b/0x30
> > [ 3078.008409]  invalidate_inode_pages2_range+0x4d5/0x550
> > [ 3078.008412]  ? finish_wait+0x2f/0x60
> > [ 3078.008416]  fuse_finish_open+0x76/0xf0 [fuse]
> > [ 3078.008419]  fuse_open_common+0x105/0x110 [fuse]
> > [ 3078.008421]  ? fuse_open_common+0x110/0x110 [fuse]
> > [ 3078.008424]  do_dentry_open+0x204/0x3a0
> > [ 3078.008426]  path_openat+0x2fc/0x1520
> > [ 3078.008429]  ? mem_cgroup_commit_charge+0x5f/0x490
> > [ 3078.008431]  do_filp_open+0x9b/0x110
> > [ 3078.008433]  ? _copy_from_user+0x37/0x60
> > [ 3078.008435]  ? kmem_cache_alloc+0x18a/0x270
> > [ 3078.008436]  ? do_sys_open+0x1bd/0x260
> > [ 3078.008437]  do_sys_open+0x1bd/0x260
> > [ 3078.008440]  do_syscall_64+0x5b/0x1e0
> > [ 3078.008442]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [ 3078.008443] RIP: 0033:0x7f841f18b542
> > [ 3078.008444] Code: 89 45 b0 eb 93 0f 1f 00 44 89 55 9c e8 67 f5 ff ff 44 8b 55 9c 44 89 e2 4c 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 44 89 c7 89 45 9c e8 bb f5 ff ff 8b 45 9c
> > [ 3078.008445] RSP: 002b:00007ffdcf69f0e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> > [ 3078.008446] RAX: ffffffffffffffda RBX: 00007f83ec4950f0 RCX: 00007f841f18b542
> > [ 3078.008446] RDX: 0000000000080000 RSI: 00007f83ec4950f0 RDI: 00000000ffffff9c
> > [ 3078.008447] RBP: 00007ffdcf69f150 R08: 0000000000000000 R09: ffffffffffffe798
> > [ 3078.008448] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080000
> > [ 3078.008448] R13: 00007f83ec4950f0 R14: 00007ffdcf69f170 R15: 00007f83f798dcd0
> > [ 3078.008449] Disabling lock debugging due to kernel taint
> >
> > This happens on an openSUSE kernel that contains a backport of commit
> > 76224355db75 ("fuse: truncate pagecache on atomic_o_trunc") [1] but
> > there's also another report here [2] (seems to be the same issue), for a
> > 5.15 (ubuntu) kernel.
> 
> The bad page state reminds me of this bug:
> 
> 712a951025c0 ("fuse: fix page stealing")
> 
> and the necessary followup fix:
> 
> 473441720c86 ("fuse: release pipe buf after last use")
> 
> Could be something completely different, I didn't do any analysis.

Ah, these commits are in 5.16, so it could be it.  I'll have a closer look
and see if the reporter is happy to test them.  Thanks for the hint.

Cheers,
--
Luís
