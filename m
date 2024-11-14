Return-Path: <linux-fsdevel+bounces-34723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3D39C80EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 03:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DEFB253BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AFE1E633E;
	Thu, 14 Nov 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qNZ3yF5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6321CCEE7;
	Thu, 14 Nov 2024 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552051; cv=none; b=nJy6RKi+4JbyB5JyHB0AIubLrBoI07NLL/f+Ha0XvYhl7pBH6psvJSTPifpB2TEFst+BMJH3F5ka0+b6OC/UILk4H9jA0F4qj7ZRgtYZfuN7Zui+Jnl8sjtGqetSzcJ0iJDbzt32SEXjIYCDIOsievGZN3CJJzh5FetOaRtuX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552051; c=relaxed/simple;
	bh=KafjAakylY3J8FJsVVaTP3z+NQbszhR/D/z3tsI5ZcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmUCVRrmRr73GAuqjji538pEeIVboVJW6yWvmRRmoY+q9yBlpjI4bmGXPKmK0htxPxCHE2UTt/6YukoBFSsIXV9sGxw1erBmKLhUv39jMgvXQkj9Eb5N38Qbp6S60UWFaT8olp46qY9Uj5y7sm3LJhLbZ9YvCCshEvREPAlnK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qNZ3yF5J; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731552039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3INPqlJYk2MKmai6id/n+AD4qOthwVqEzY7l/dg9Gls=;
	b=qNZ3yF5J8G6wJx63dIGaHqAoxVK5e1BSOKwg9qRpuP8xB7y8OKYoEvHdp/B7XvFQS8HAuxVuMYr01N4BeLXVI9dAdJkhfwlXGfJy1hQCgmTlEeL4FJf5vuB4COs53Fmp1p+VVY41gEcHl08Nqfae3uOKBxTqR1nxQqnn2satCnE=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJMgPnT_1731552038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 10:40:39 +0800
Message-ID: <388badcf-a27e-4a24-b10a-1e43b701e93e@linux.alibaba.com>
Date: Thu, 14 Nov 2024 10:40:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: check file before running readpage
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
References: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
 <20241114020417.3524632-1-lizhi.xu@windriver.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114020417.3524632-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/14 10:04, Lizhi Xu wrote:
> syzbot reported a null-ptr-deref in fuse_read_args_fill. [1]
> 
> About this case, calltrace is:
> erofs_read_superblock()->
>    erofs_read_metabuf()->
>      erofs_bread()->
>        read_mapping_folio()->
>          do_read_cache_folio()->
>            filemap_read_folio()->
>              fuse_read_folio()->
>                fuse_do_readpage()->
>                  fuse_read_args_fill()
> 
> erofs_bread() calls read_mapping_folio() passing NULL file, which causes a
> NULL pointer dereference in fuse_read_args_fill.
> To avoid this issue, need to add a check for file in fuse_read_folio().
> 
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
> CPU: 3 UID: 0 PID: 5947 Comm: syz-executor314 Not tainted 6.12.0-rc5-syzkaller-00044-gc1e939a21eb1 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:fuse_read_args_fill fs/fuse/file.c:631 [inline]
> RIP: 0010:fuse_do_readpage+0x276/0x640 fs/fuse/file.c:880
> Code: e8 9f c7 91 fe 8b 44 24 10 89 44 24 78 41 89 c4 e8 8f c7 91 fe 48 8d 7b 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1d 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
> RSP: 0018:ffffc90006a0f820 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82fbb4c9
> RDX: 000000000000000c RSI: ffffffff82fbb4f1 RDI: 0000000000000060
> RBP: 0000000000000000 R08: 0000000000000007 R09: 7fffffffffffffff
> R10: 0000000000000fff R11: ffffffff961d4b88 R12: 0000000000001000
> R13: ffff8880382b8000 R14: ffff888025153780 R15: ffffc90006a0f8b8
> FS:  00007f7583f3d6c0(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000240 CR3: 0000000030d30000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   fuse_read_folio+0xb0/0x100 fs/fuse/file.c:905
>   filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2367
>   do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3825
>   read_mapping_folio include/linux/pagemap.h:1011 [inline]
>   erofs_bread+0x34d/0x7e0 fs/erofs/data.c:41
>   erofs_read_superblock fs/erofs/super.c:281 [inline]
>   erofs_fc_fill_super+0x2b9/0x2500 fs/erofs/super.c:625
>   vfs_get_super fs/super.c:1280 [inline]
>   get_tree_nodev+0xda/0x190 fs/super.c:1299
>   erofs_fc_get_tree+0x1fe/0x2e0 fs/erofs/super.c:723
>   vfs_get_tree+0x8f/0x380 fs/super.c:1800
>   do_new_mount fs/namespace.c:3507 [inline]
>   path_mount+0x14e6/0x1f20 fs/namespace.c:3834
>   do_mount fs/namespace.c:3847 [inline]
>   __do_sys_mount fs/namespace.c:4057 [inline]
>   __se_sys_mount fs/namespace.c:4034 [inline]
>   __x64_sys_mount+0x294/0x320 fs/namespace.c:4034
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Reported-and-tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Most filesystems (except for some network fses and FUSE)
won't use `file` at all and as documented in
https://docs.kernel.org/filesystems/vfs.html

But I will pass in `file` for this issue instead in order
to support use cases over FUSE, other than just bail out
like this.

Thanks,
Gao Xiang

