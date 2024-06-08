Return-Path: <linux-fsdevel+bounces-21280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C490114F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 13:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2885E28293F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A64178378;
	Sat,  8 Jun 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmDGbuM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B514F139;
	Sat,  8 Jun 2024 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717844985; cv=none; b=Zs7DGd94dyRAsAuN1csB3cPrTdpHOxXTP0i3xSGDcPJP8GbTPbgWoxm2BXbAxBquvs5ntH+SIsVjAW8SoFm1BAnN0NwBhr9s364v9UtBMgf0TicRWmoYF9cIDoGZtPRexKK4uu3dKGSPa2XkQYtljvTcxdU3QYubEBcOXas9zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717844985; c=relaxed/simple;
	bh=wowWc9+njfwW5t2kl62DnHQwLj+9w4BlUoe93ce4FPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YvGlhQZs4r4UEIEQ9PL9+QkGYumOqtd8yg2bzzhSM0CQlictCuRTeDYR30Tmq8HfMD0SUFk6MCRPviHsxOsMv4u2FerV04JzzMUFxDhUsRiSwnQUf8DBdCyh+C97uU5i6Ay2TmU6T6fpXGKzxhVbatXdf1cFga0ZPm68SzR0qP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmDGbuM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DB8C2BD11;
	Sat,  8 Jun 2024 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717844984;
	bh=wowWc9+njfwW5t2kl62DnHQwLj+9w4BlUoe93ce4FPI=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=pmDGbuM4AJocyuzzQinMKUnOcJ25HYEm4iYqj5mdmsYFU4bnb97B0ZakyoAjggBA+
	 mQTNrA5010kBF2QnmhLR64tDpjR21izgSvH/IM6G4xiDhMhTWkv59tCGLN1TzKclUX
	 LkBOFrtl2ADj7APSzO+a77IYQg4HBf4nsc8GNegbWnE34fjdCzxhT/9cVg2fC4s3fI
	 /HGMoPtPm6gIYTtaQZaCWqz9LvMazXLy2EJY6z28p5Qm2hHUOY1/2ijC0hvsUCd4Np
	 cNx3pj8BoJn7TB9KN5FZkCXDSvSZlT6zVa6P0xbFyhqqwRL8vMxfS/CEuz108nUdY8
	 U332EgegW8Neg==
Message-ID: <6720af76-6504-4337-99f4-01db93913d0b@kernel.org>
Date: Sat, 8 Jun 2024 19:09:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
To: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <000000000000a66c7705f4578aaa@google.com>
Content-Language: en-US
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 glider@google.com
From: Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000a66c7705f4578aaa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git misc

On 2023/2/10 20:21, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8c89ecf5c13b kmsan: silence -Wmissing-prototypes warnings
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b53fff480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91d3152219aa6b45
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1409f0b3480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c76993480000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fa537cffb53c/disk-8c89ecf5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5b9d03c04a3e/vmlinux-8c89ecf5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/55c166dec3af/bzImage-8c89ecf5.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b234e4e5c704/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com
> 
> =======================================================
> WARNING: The mand mount option has been deprecated and
>           and is ignored by this kernel. Remove the mand
>           option from the mount to silence this warning.
> =======================================================
> =====================================================
> BUG: KMSAN: uninit-value in hfs_ext_read_extent fs/hfs/extent.c:196 [inline]
> BUG: KMSAN: uninit-value in hfs_get_block+0x92d/0x1620 fs/hfs/extent.c:366
>   hfs_ext_read_extent fs/hfs/extent.c:196 [inline]
>   hfs_get_block+0x92d/0x1620 fs/hfs/extent.c:366
>   block_read_full_folio+0x4ff/0x11b0 fs/buffer.c:2271
>   hfs_read_folio+0x55/0x60 fs/hfs/inode.c:39
>   filemap_read_folio+0x148/0x4f0 mm/filemap.c:2426
>   do_read_cache_folio+0x7c8/0xd90 mm/filemap.c:3553
>   do_read_cache_page mm/filemap.c:3595 [inline]
>   read_cache_page+0xfb/0x2f0 mm/filemap.c:3604
>   read_mapping_page include/linux/pagemap.h:755 [inline]
>   hfs_btree_open+0x928/0x1ae0 fs/hfs/btree.c:78
>   hfs_mdb_get+0x260c/0x3000 fs/hfs/mdb.c:204
>   hfs_fill_super+0x1fb1/0x2790 fs/hfs/super.c:406
>   mount_bdev+0x628/0x920 fs/super.c:1359
>   hfs_mount+0xcd/0xe0 fs/hfs/super.c:456
>   legacy_get_tree+0x167/0x2e0 fs/fs_context.c:610
>   vfs_get_tree+0xdc/0x5d0 fs/super.c:1489
>   do_new_mount+0x7a9/0x16f0 fs/namespace.c:3145
>   path_mount+0xf98/0x26a0 fs/namespace.c:3475
>   do_mount fs/namespace.c:3488 [inline]
>   __do_sys_mount fs/namespace.c:3697 [inline]
>   __se_sys_mount+0x919/0x9e0 fs/namespace.c:3674
>   __ia32_sys_mount+0x15b/0x1b0 fs/namespace.c:3674
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
>   do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
>   entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> Uninit was created at:
>   __alloc_pages+0x926/0x10a0 mm/page_alloc.c:5572
>   alloc_pages+0xb4b/0xec0
>   alloc_slab_page mm/slub.c:1851 [inline]
>   allocate_slab mm/slub.c:1998 [inline]
>   new_slab+0x5c5/0x19b0 mm/slub.c:2051
>   ___slab_alloc+0x132b/0x3790 mm/slub.c:3193
>   __slab_alloc mm/slub.c:3292 [inline]
>   __slab_alloc_node mm/slub.c:3345 [inline]
>   slab_alloc_node mm/slub.c:3442 [inline]
>   slab_alloc mm/slub.c:3460 [inline]
>   __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
>   kmem_cache_alloc_lru+0x72f/0xb80 mm/slub.c:3483
>   alloc_inode_sb include/linux/fs.h:3119 [inline]
>   hfs_alloc_inode+0x80/0xf0 fs/hfs/super.c:165
>   alloc_inode+0xad/0x4b0 fs/inode.c:259
>   iget_locked+0x340/0xf80 fs/inode.c:1286
>   hfs_btree_open+0x20d/0x1ae0 fs/hfs/btree.c:38
>   hfs_mdb_get+0x2519/0x3000 fs/hfs/mdb.c:199
>   hfs_fill_super+0x1fb1/0x2790 fs/hfs/super.c:406
>   mount_bdev+0x628/0x920 fs/super.c:1359
>   hfs_mount+0xcd/0xe0 fs/hfs/super.c:456
>   legacy_get_tree+0x167/0x2e0 fs/fs_context.c:610
>   vfs_get_tree+0xdc/0x5d0 fs/super.c:1489
>   do_new_mount+0x7a9/0x16f0 fs/namespace.c:3145
>   path_mount+0xf98/0x26a0 fs/namespace.c:3475
>   do_mount fs/namespace.c:3488 [inline]
>   __do_sys_mount fs/namespace.c:3697 [inline]
>   __se_sys_mount+0x919/0x9e0 fs/namespace.c:3674
>   __ia32_sys_mount+0x15b/0x1b0 fs/namespace.c:3674
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
>   do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
>   entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> CPU: 1 PID: 5015 Comm: syz-executor119 Not tainted 6.2.0-rc7-syzkaller-80760-g8c89ecf5c13b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
> =====================================================
> 


