Return-Path: <linux-fsdevel+bounces-38363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D8BA00A05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 14:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9E0163D22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BA51F9F4F;
	Fri,  3 Jan 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DplbHVXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C63145B3F;
	Fri,  3 Jan 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912164; cv=none; b=eh0IDNDegUEoC0od+E/jYQ8YCqVl0itDacaHpYDkw4K6kxNN5a2SOd2SNeCvoQkdJv2vcvpzM0zHDu8ZHe/zqJnSri7UUDol25h/m1wCyKbjQVlP1s7z8xH4f4AuSX3CLAmNPxUUd+eMn84wc+JxG/JxhRD/asV77CebNBaqF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912164; c=relaxed/simple;
	bh=wXxm1GIY5h12x2uvw69+6aNeFaQADdJOk1bRHIcb61A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcGOYaOW6ib7ZapxwubOteMBk/s9002wiHBscQyETrY365eVmOvVsCwvdz85OPY7xp1VrD3UjveHQsNvgm4YrqX4c4BmvfJsMe5Y3xPiPAj2bmbjRZSeGN87RVrAqO5sjqqXubaj2Og16yGvhi9dv3s42uLpleq5s9IiSm4rGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DplbHVXE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9mF7t6NmWUf0oub/sbaixYjiY8as59cuzFbTBqyhaoQ=; b=DplbHVXE16QDN6CXFxnusaX3gr
	4um33md0b12GUJrDpvsGFaXTYZzZ231GhZas0D4SfJTyunEQVLIBXLaz1G7lZj5ek/XKQgkuEb+Ng
	g/XjcNOXYSy0NH9OZQYzFRTuC8VKcbvRxwpaTg+W4zSxVJmDmbZwmZaIoQbV/TY2vtAXfA7LXqIx3
	DwaDPxYicFuJUXdDqtZ+XGejpZ2hAxxaOSuZXqXFgcqDTQd51qALaqy17MPNKcI6MtKCPpZ7BiVC9
	Jwc/zj3PB396UTNsRb/phWFysCF0yfLaLyzjNAUp4wgfRCdfPhHKwSSlB/oJlOSftPRpLHARgOUx8
	2pANyPVg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tTi3B-00000005v2F-2Gla;
	Fri, 03 Jan 2025 13:49:17 +0000
Date: Fri, 3 Jan 2025 13:49:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: cheung wall <zzqq0103.hey@gmail.com>, Stefan Roesch <shr@devkernel.io>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: "divide error in bdi_set_min_bytes" in Linux kernel version
 6.13.0-rc2
Message-ID: <Z3fq3VLthzzmsYd9@casper.infradead.org>
References: <CAKHoSAsMYWOYfqw6h74cEzucg1vGZaY4ShT3e35NnX2v_Ro04w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAsMYWOYfqw6h74cEzucg1vGZaY4ShT3e35NnX2v_Ro04w@mail.gmail.com>

On Fri, Jan 03, 2025 at 03:25:01PM +0800, cheung wall wrote:
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 6.13.0-rc2. This issue was discovered using our
> custom vulnerability discovery tool.

Your tool would be more useful if you told us what it was doing.
I suspect it's writing a very small value into the min_bytes pseudo-file.
Since that's something only root can do, this isn't a vulnerability.
This is a very annoying conversation to keep having with people who
write their own custom "vulnerability discovery tools".

That said, we could do better here.  Stefan, you wrote this code.

> RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
> RIP: 0010:bdi_ratio_from_pages mm/page-writeback.c:695 [inline]
> RIP: 0010:bdi_set_min_bytes+0x9f/0x1d0 mm/page-writeback.c:799
> Code: ff 48 39 d8 0f 82 3b 01 00 00 e8 ac fd e7 ff 48 69 db 40 42 0f
> 00 48 8d 74 24 40 48 8d 7c 24 20 e8 c6 f1 ff ff 31 d2 48 89 d8 <48> f7
> 74 24 40 48 89 c3 3d 40 42 0f 00 0f 87 08 01 00 00 e8 79 fd
> RSP: 0018:ffff88810a5f7b60 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9c9ef057
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88810a5f7ab8
> RBP: 1ffff110214bef6c R08: 0000000000000000 R09: fffffbfff4081c7b
> R10: ffffffffa040e3df R11: 0000000000032001 R12: ffff888105c65000
> R13: dffffc0000000000 R14: ffff888105c65000 R15: ffff888105c65800
> FS: 00007fdfc7c37580(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055adcdc786c8 CR3: 0000000104128000 CR4: 0000000000350ef0
> Call Trace:
> <TASK>
> min_bytes_store+0xba/0x120 mm/backing-dev.c:385
> dev_attr_store+0x58/0x80 drivers/base/core.c:2439
> sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
> kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
> new_sync_write fs/read_write.c:586 [inline]
> vfs_write+0x51e/0xc80 fs/read_write.c:679
> ksys_write+0x110/0x200 fs/read_write.c:731
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdfc7b4d513
> Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
> 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> RSP: 002b:00007ffe7796ae28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000055adcdc766c0 RCX: 00007fdfc7b4d513
> RDX: 0000000000000002 RSI: 000055adcdc766c0 RDI: 0000000000000001
> RBP: 0000000000000002 R08: 000055adcdc766c0 R09: 00007fdfc7c30be0
> R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000000
> 
> ------------[ cut here end]------------
> 
> Root Cause:
> 
> The crash is caused by a division by zero error within the Linux
> kernel's page-writeback subsystem. Specifically, the bdi_set_min_bytes
> function attempts to calculate a ratio using bdi_ratio_from_pages,
> which internally calls div64_u64. During this calculation, a
> denominator value unexpectedly becomes zero, likely due to improper
> handling or validation of input data provided through the sysfs
> interface during the min_bytes_store operation. This erroneous zero
> value leads to a divide error exception when the kernel tries to
> perform the division. The issue occurs while processing a sysfs write
> operation (min_bytes_store), suggesting that invalid or uninitialized
> data supplied through sysfs triggers the faulty calculation,
> ultimately causing the kernel to crash.
> 
> Thank you for your time and attention.
> 
> Best regards
> 
> Wall

