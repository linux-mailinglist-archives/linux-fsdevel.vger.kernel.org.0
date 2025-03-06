Return-Path: <linux-fsdevel+bounces-43315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE16A541F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 06:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017BA1888E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 05:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6419DF48;
	Thu,  6 Mar 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JJ/R+ALg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AF7E9;
	Thu,  6 Mar 2025 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741238035; cv=none; b=lHxW+LRVvmEIP191k0kMSybo7T7v8XftP3LBwRKhYtQH27PswgxAL8uD27NKSLAoT9OOqsXMud+UENud9O8avGsrOSN+5tf4Avh/cvpR83NX2SNbG641bYAlg+Ljh4YPj8oJxL4PReAKzqPQA5ErnlFt2kpHHLkGGfIzdtjdjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741238035; c=relaxed/simple;
	bh=16kpktkKyPQhz+cNLIIt9U7ZBzm4qPeos4gRgcHt9C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8n2bHhGAPH6clLIezMl4gRRArbi/JYxYaLia3M8TWS2srktTTsybl0xsdBy0Cy+Vw1NMAYhJEJMMll0k6AM8kZySC7xTT7VcM3l2Ao/eOdMLYWAetuLEXA9E+Pa1GLj+P1jlA7vlDMTSlyT+M37FEwVEDqS69gptWskCoEEoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JJ/R+ALg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NEJfgh+XvvnRGINoc0QVb2XodgpyZQZqN+ccclfzJ0w=; b=JJ/R+ALgt4V7/6CIaHjEjenK/J
	yJeamRX28M0g+ACc8dT3ygoMAKVNyp9dsNuZDtSDPVbHriw8TOvZkylQlvAw6qjndQ38ShG/msYl0
	ZZ+CHucxnJ8K/Up7SFZSA1WA6bOSKUFAzdIT1rMgxbiWxR4FYsK2/XEKQcy4+Kxur+wa6D7KJxBnF
	cWW5rdlh4iYltz7up2xcPHghvKVdWbXECYx3OSOnbTcKduqagTsMU3i0HFPcN4vjrByXPWnoK++9D
	FJrwOoY4rrpHgD3QdPQIrEHg/gz3EBaNWOd1rGgLPCVg4H34rGBCMq1WwONjm6HImg9j83500di7g
	Uza5B/2w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tq3YN-00000006qdK-1mXd;
	Thu, 06 Mar 2025 05:13:51 +0000
Date: Thu, 6 Mar 2025 05:13:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luka <luka.2016.cs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Message-ID: <Z8kvDz70Wjh5By7c@casper.infradead.org>
References: <CALm_T+2cEDUJvjh6Lv+6Mg9QJxGBVAHu-CY+okQgh-emWa7-1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm_T+2cEDUJvjh6Lv+6Mg9QJxGBVAHu-CY+okQgh-emWa7-1A@mail.gmail.com>

On Thu, Mar 06, 2025 at 10:42:58AM +0800, Luka wrote:
> We fully understand the complexity and importance of Linux kernel
> maintenance, and we would like to share this finding with you for
> further analysis and confirmation of the root cause. Below is a
> summary of the relevant information:

This is the exact same problem I just analysed for you.  Except this
time it's ext4 rather than FAT.

https://lore.kernel.org/linux-mm/Z8kuWyqj8cS-stKA@casper.infradead.org/
for the benefit of the ext4 people who're just finding out about this.

> Kernel Version: v6.13.0-rc5
> 
> Kernel Module: mm/page_alloc.c
> 
> ————————————————————————————————————————Call
> Trace——————————————————————————————————————————————————
> 
> WARNING: CPU: 1 PID: 333 at mm/page_alloc.c:4240
> __alloc_pages_slowpath mm/page_alloc.c:4240 [inline]
> WARNING: CPU: 1 PID: 333 at mm/page_alloc.c:4240
> __alloc_pages_noprof+0x1808/0x2040 mm/page_alloc.c:4766
> Modules linked in:
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__alloc_pages_slowpath mm/page_alloc.c:4240 [inline]
> RIP: 0010:__alloc_pages_noprof+0x1808/0x2040 mm/page_alloc.c:4766
> Code: 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0
> 7c 08 84 d2 0f 85 b3 07 00 00 f6 43 2d 08 0f 84 30 ed ff ff 90 <0f> 0b
> 90 e9 27 ed ff ff 44 89 4c 24 38 65 8b 15 c0 89 52 78 89 d2
> RSP: 0018:ffff8880141ee990 EFLAGS: 00010202
> RAX: 0000000000000007 RBX: ffff888012544400 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801254442c
> RBP: 0000000000048c40 R08: 0000000000000801 R09: 00000000000000f7
> R10: 0000000000000000 R11: ffff88813fffdc40 R12: 0000000000000000
> R13: 0000000000000400 R14: 0000000000048c40 R15: 0000000000000000
> FS:  0000555589d15480(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e47d593e61 CR3: 00000000141ce000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  alloc_pages_mpol_noprof+0xda/0x300 mm/mempolicy.c:2269
>  folio_alloc_noprof+0x1e/0x70 mm/mempolicy.c:2355
>  filemap_alloc_folio_noprof+0x2b2/0x2f0 mm/filemap.c:1009
>  __filemap_get_folio+0x16d/0x3d0 mm/filemap.c:1951
>  ext4_mb_load_buddy_gfp+0x42b/0xc00 fs/ext4/mballoc.c:1640
>  ext4_discard_preallocations+0x45c/0xc70 fs/ext4/mballoc.c:5592
>  ext4_clear_inode+0x3d/0x1e0 fs/ext4/super.c:1523
>  ext4_evict_inode+0x1b2/0x1330 fs/ext4/inode.c:323
>  evict+0x337/0x7c0 fs/inode.c:796
>  dispose_list fs/inode.c:845 [inline]
>  prune_icache_sb+0x189/0x290 fs/inode.c:1033
>  super_cache_scan+0x33d/0x510 fs/super.c:223
>  do_shrink_slab mm/shrinker.c:437 [inline]
>  shrink_slab+0x43e/0x930 mm/shrinker.c:664
>  shrink_node_memcgs mm/vmscan.c:5931 [inline]
>  shrink_node+0x4dd/0x15c0 mm/vmscan.c:5970
>  shrink_zones mm/vmscan.c:6215 [inline]
>  do_try_to_free_pages+0x284/0x1160 mm/vmscan.c:6277
>  try_to_free_pages+0x1ee/0x3e0 mm/vmscan.c:6527
>  __perform_reclaim mm/page_alloc.c:3929 [inline]
>  __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
>  __alloc_pages_slowpath mm/page_alloc.c:4382 [inline]
>  __alloc_pages_noprof+0xa48/0x2040 mm/page_alloc.c:4766
>  alloc_pages_bulk_noprof+0x6d6/0xf40 mm/page_alloc.c:4701
>  alloc_pages_bulk_array_mempolicy_noprof+0x1fd/0xcb0 mm/mempolicy.c:2559
>  vm_area_alloc_pages mm/vmalloc.c:3565 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3669 [inline]
>  __vmalloc_node_range_noprof+0x453/0x1170 mm/vmalloc.c:3846
>  __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:3911
>  xt_counters_alloc+0x32/0x60 net/netfilter/x_tables.c:1380
>  __do_replace net/ipv4/netfilter/ip_tables.c:1046 [inline]
>  do_replace net/ipv4/netfilter/ip_tables.c:1141 [inline]
>  do_ipt_set_ctl+0x6d8/0x10d0 net/ipv4/netfilter/ip_tables.c:1635
>  nf_setsockopt+0x7d/0xe0 net/netfilter/nf_sockopt.c:101
>  ip_setsockopt+0xa4/0xc0 net/ipv4/ip_sockglue.c:1424
>  tcp_setsockopt+0x9c/0x100 net/ipv4/tcp.c:4030
>  do_sock_setsockopt+0xd3/0x1a0 net/socket.c:2313
>  __sys_setsockopt+0x105/0x170 net/socket.c:2338
>  __do_sys_setsockopt net/socket.c:2344 [inline]
>  __se_sys_setsockopt net/socket.c:2341 [inline]
>  __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc5c73fa87e
> Code: 0f 1f 40 00 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff
> ff ff eb b1 0f 1f 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 c7 c2 b0
> RSP: 002b:00007ffc1866e9a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00007ffc1866ea30 RCX: 00007fc5c73fa87e
> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 00000000000002d8 R09: 00007ffc1866ef30
> R10: 00007fc5c75c0c60 R11: 0000000000000206 R12: 00007fc5c75c0c00
> R13: 00007ffc1866e9cc R14: 0000000000000000 R15: 00007fc5c75c2dc0
>  </TASK>
> 
> ————————————————————————————————————————Call
> Trace——————————————————————————————————————————————————
> 
> If you need more details or additional test results, please feel free
> to let us know. Thank you so much for your attention! Please don't
> hesitate to reach out if you have any suggestions or need further
> communication.
> 
> Best regards,
> Luka
> 

