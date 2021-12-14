Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95D64744D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhLNO0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 09:26:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46784 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhLNO0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:26:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CBBE212B5;
        Tue, 14 Dec 2021 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639491983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oh+cofUkQkxGwb8Ah8sZvywgu85UI1niOe3rG81MmII=;
        b=oSOmN4FXasdTWMCLZslBgvcojaLLFOxR0OB0//L+s7XWxOjMEJqSgF1QpIxDrAi6IjKzbw
        18GPrEWGwSQmiPfCyxHn+Hf4Lnpp9gjqKkMviZ5DJ8l6BEXqLycJKF/Asz36SMlBea6EXa
        4uzKtbLMTyUW19xuCYYUNsZwIyjuytI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639491983;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oh+cofUkQkxGwb8Ah8sZvywgu85UI1niOe3rG81MmII=;
        b=M2QVP81yP0YHLdvU9RH5Yte136QiYgiV2W++kpuuhk/Ye2x8T+L8EAz3ngwnql1Ri1fYFK
        v1NKRCbnYTtes/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0160C13EA2;
        Tue, 14 Dec 2021 14:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wfrJOI6puGHJRgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 14 Dec 2021 14:26:22 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 08c77c23;
        Tue, 14 Dec 2021 14:26:20 +0000 (UTC)
Date:   Tue, 14 Dec 2021 14:26:20 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Xie Yongji <xieyongji@bytedance.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
Message-ID: <YbipjJJhkemx2MGn@suse.de>
References: <20210813093155.45-1-xieyongji@bytedance.com>
 <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRpcck0FHaH+uxgp@miu.piliscsaba.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

On Mon, Aug 16, 2021 at 02:39:14PM +0200, Miklos Szeredi wrote:
> On Fri, Aug 13, 2021 at 05:31:55PM +0800, Xie Yongji wrote:
> > The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> > set in fuse_finish_open(), which can lead to deadlock in
> > fuse_launder_page().
> > 
> > To fix it, this tries to delay calling invalidate_inode_pages2()
> > until FUSE_NOWRITE is removed.
> 
> Thanks for the report and the patch.  I think it doesn't make sense to delay the
> invalidate_inode_pages2() call since the inode has been truncated in this case,
> there's no data worth writing out.
> 
> This patch replaces the invalidate_inode_pages2() with a truncate_pagecache()
> call.  This makes sense regardless of FOPEN_KEEP_CACHE or fc->writeback cache,
> so do it unconditionally.
> 
> Can you please check out the following patch?

I just saw a bug report where the obvious suspicious commit is this one.
Here's the relevant bits from the kernel log:

[ 3078.008319] BUG: Bad page state in process telegram-deskto  pfn:667339
[ 3078.008323] page:ffffcf63d99cce40 refcount:1 mapcount:0 mapping:ffff94009080d838 index:0x180
[ 3078.008329] fuse_file_aops [fuse] name:"domecamctl"
[ 3078.008330] flags: 0x17ffffc0000034(uptodate|lru|active)
[ 3078.008332] raw: 0017ffffc0000034 dead000000000100 dead000000000122 ffff94009080d838
[ 3078.008333] raw: 0000000000000180 0000000000000000 00000001ffffffff ffff93fbc7d10000
[ 3078.008333] page dumped because: page still charged to cgroup
[ 3078.008334] page->mem_cgroup:ffff93fbc7d10000
[ 3078.008334] bad because of flags: 0x30(lru|active)
[ 3078.008335] Modules linked in: <...>
[ 3078.008388] Supported: Yes
[ 3078.008390] CPU: 1 PID: 3738 Comm: telegram-deskto Kdump: loaded Not tainted 5.3.18-59.37-default #1 SLE15-SP3
[ 3078.008390] Hardware name: System manufacturer System Product Name/P8H77-M PRO, BIOS 0412 02/08/2012
[ 3078.008391] Call Trace:
[ 3078.008397]  dump_stack+0x66/0x8b
[ 3078.008399]  bad_page+0xc9/0x130
[ 3078.008401]  free_pcppages_bulk+0x443/0x870
[ 3078.008403]  free_unref_page_list+0x102/0x180
[ 3078.008406]  release_pages+0x301/0x400
[ 3078.008408]  __pagevec_release+0x2b/0x30
[ 3078.008409]  invalidate_inode_pages2_range+0x4d5/0x550
[ 3078.008412]  ? finish_wait+0x2f/0x60
[ 3078.008416]  fuse_finish_open+0x76/0xf0 [fuse]
[ 3078.008419]  fuse_open_common+0x105/0x110 [fuse]
[ 3078.008421]  ? fuse_open_common+0x110/0x110 [fuse]
[ 3078.008424]  do_dentry_open+0x204/0x3a0
[ 3078.008426]  path_openat+0x2fc/0x1520
[ 3078.008429]  ? mem_cgroup_commit_charge+0x5f/0x490
[ 3078.008431]  do_filp_open+0x9b/0x110
[ 3078.008433]  ? _copy_from_user+0x37/0x60
[ 3078.008435]  ? kmem_cache_alloc+0x18a/0x270
[ 3078.008436]  ? do_sys_open+0x1bd/0x260
[ 3078.008437]  do_sys_open+0x1bd/0x260
[ 3078.008440]  do_syscall_64+0x5b/0x1e0
[ 3078.008442]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3078.008443] RIP: 0033:0x7f841f18b542
[ 3078.008444] Code: 89 45 b0 eb 93 0f 1f 00 44 89 55 9c e8 67 f5 ff ff 44 8b 55 9c 44 89 e2 4c 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 44 89 c7 89 45 9c e8 bb f5 ff ff 8b 45 9c
[ 3078.008445] RSP: 002b:00007ffdcf69f0e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[ 3078.008446] RAX: ffffffffffffffda RBX: 00007f83ec4950f0 RCX: 00007f841f18b542
[ 3078.008446] RDX: 0000000000080000 RSI: 00007f83ec4950f0 RDI: 00000000ffffff9c
[ 3078.008447] RBP: 00007ffdcf69f150 R08: 0000000000000000 R09: ffffffffffffe798
[ 3078.008448] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080000
[ 3078.008448] R13: 00007f83ec4950f0 R14: 00007ffdcf69f170 R15: 00007f83f798dcd0
[ 3078.008449] Disabling lock debugging due to kernel taint

This happens on an openSUSE kernel that contains a backport of commit
76224355db75 ("fuse: truncate pagecache on atomic_o_trunc") [1] but
there's also another report here [2] (seems to be the same issue), for a
5.15 (ubuntu) kernel.

Any idea about what could be happening here?  Could fuse_launder_page() be
causing this after this commit?  (I initially wondered if
fc->atomic_o_trunc could change between fuse_open_common() and the
fuse_finish_open() but couldn't see how.)

[1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193691
[2] https://bugzilla.kernel.org/show_bug.cgi?id=215309

Cheers,
--
Luís


> Thanks,
> Miklos
> 
> ---
>  fs/fuse/file.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -198,12 +198,11 @@ void fuse_finish_open(struct inode *inod
>  	struct fuse_file *ff = file->private_data;
>  	struct fuse_conn *fc = get_fuse_conn(inode);
>  
> -	if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> -		invalidate_inode_pages2(inode->i_mapping);
>  	if (ff->open_flags & FOPEN_STREAM)
>  		stream_open(inode, file);
>  	else if (ff->open_flags & FOPEN_NONSEEKABLE)
>  		nonseekable_open(inode, file);
> +
>  	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
>  		struct fuse_inode *fi = get_fuse_inode(inode);
>  
> @@ -211,10 +210,14 @@ void fuse_finish_open(struct inode *inod
>  		fi->attr_version = atomic64_inc_return(&fc->attr_version);
>  		i_size_write(inode, 0);
>  		spin_unlock(&fi->lock);
> +		truncate_pagecache(inode, 0);
>  		fuse_invalidate_attr(inode);
>  		if (fc->writeback_cache)
>  			file_update_time(file);
> +	} else if (!(ff->open_flags & FOPEN_KEEP_CACHE)) {
> +		invalidate_inode_pages2(inode->i_mapping);
>  	}
> +
>  	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
>  		fuse_link_write_file(file);
>  }
