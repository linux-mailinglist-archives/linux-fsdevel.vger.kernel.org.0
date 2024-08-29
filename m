Return-Path: <linux-fsdevel+bounces-27952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA096505F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C281F22217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347B51BA87B;
	Thu, 29 Aug 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0Pmc6wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E21B5EA2;
	Thu, 29 Aug 2024 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961330; cv=none; b=MwJ9GG+/k0hY1vkE8wXNM3vVMhoSBR7G3/bJmBRu9qAkHhM131dR/u6rxfnhQYVmvfQqe7D1fILVp7uPBZxPSMMHsbqpvpissx9JF2MpFiTX8QiCMRE5Cjc3NocUX+ihtBW/35x+xzYnOUiEAgSyVd/3dvrNGBqwoWWQb6mnTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961330; c=relaxed/simple;
	bh=UaelTzdtU667Q2cdclsLzFYlcAZcY/GNm/jurVzsK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF7lcpkr5+yjTxVrN/vjXZg8n6FLQqwscbxa11dMp9CkoGhZjAJDpdYHCiIfUC/IFwU4fMwdK715SGPIVWJ22lYROcu6cTK+jVzQ1+NuxpC7eXrJvHbEjxG9ANu68aN+HmAEQtZTl+QE3qH1VN25cWwr4qfwI85y8Vv4sBZRIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l0Pmc6wt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UOJvMTiXVivNfu+YcPkv7b/7NsjH5Tkck5WIWz7eg4Y=; b=l0Pmc6wtSADKS+qXWldFe9bXmF
	zPEVe36DQSUMTWKGvOmg90r/k15TAKQSSi+74+/Q0Gi7j3vsw0h9WNehZU5jPgvnnf59/HF6ryYrz
	mG4itYAYmhog77OMMzq23ciI+owHziyb3gzsSVPZzf2hftMz8yHjvFQBcW9NcJugwmzQmyiD6evbA
	l8ZlPwKinV2X1rcEzDxGTm258kjKJXAS2orNyqLo4CglNzA58yDGbJwQTHRhxHMaywwdJY2k3WlTH
	qQRAa9yJoMmz2e6K6xL+u1j/gHHFhVG/19HrVGPR9FGeol5PbZBOvYzY7/FNwovX6dK+zj28H7F6X
	3gtmXH4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjlEk-00000002SwI-1a05;
	Thu, 29 Aug 2024 19:55:18 +0000
Date: Thu, 29 Aug 2024 20:55:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	brauner@kernel.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, hare@suse.de, gost.dev@samsung.com,
	linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	john.g.garry@oracle.com, cl@os.amperecomputing.com,
	p.raghav@samsung.com, ryan.roberts@arm.com,
	David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <ZtDSJuI2hYniMAzv@casper.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com>
 <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>

On Thu, Aug 29, 2024 at 11:46:42AM -0700, Luis Chamberlain wrote:
> With vm debugging however I get more information about the issue:
> 
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: page: refcount:1 mapcount:1 mapping:0000000000000000 index:0x7f589dd7f pfn:0x211d7f
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: memcg:ffff93ba245b8800
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: anon flags: 0x17fffe000020838(uptodate|dirty|lru|owner_2|swapbacked|node=0|zone=2|lastcpupid=0x1ffff)
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: raw: 017fffe000020838 ffffe59008475f88 ffffe59008476008 ffff93ba2abca5b1
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: raw: 00000007f589dd7f 0000000000000000 0000000100000000 ffff93ba245b8800
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: ------------[ cut here ]------------
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: kernel BUG at mm/filemap.c:1509!

This is in folio_unlock().  We're trying to unlock a folio which isn't
locked!

> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CPU: 2 UID: 0 PID: 74 Comm: ksmd Not tainted 6.11.0-rc5-next-20240827 #56
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RIP: 0010:folio_unlock+0x43/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Code: 93 fc ff ff f0 80 30 01 78 06 5b c3 cc cc cc cc 48 89 df 31 f6 5b e9 dc fc ff ff 48 c7 c6 a0 56 49 89 48 89 df e8 2d 03 05 00 <0f> 0b 90 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RSP: 0018:ffffbb1dc02afe38 EFLAGS: 00010246
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RAX: 000000000000003f RBX: ffffe59008475fc0 RCX: 0000000000000000
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000003
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R10: ffffbb1dc02afce0 R11: ffffffff896c3608 R12: ffffe59008475fc0
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: R13: 0000000000000000 R14: ffffe59008470000 R15: ffffffff89f88060
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: FS:  0000000000000000(0000) GS:ffff93c15fc80000(0000) knlGS:0000000000000000
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: CR2: 0000558e368d9c48 CR3: 000000010ca66004 CR4: 0000000000770ef0
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: PKRU: 55555554
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel: Call Trace:
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  <TASK>
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? die+0x32/0x80
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? do_trap+0xd9/0x100
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? do_error_trap+0x6a/0x90
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? exc_invalid_op+0x4c/0x60
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? asm_exc_invalid_op+0x16/0x20
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? folio_unlock+0x43/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ksm_scan_thread+0x175b/0x1d30
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_ksm_scan_thread+0x10/0x10
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  kthread+0xda/0x110
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ret_from_fork+0x2d/0x50
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ? __pfx_kthread+0x10/0x10
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  ret_from_fork_asm+0x1a/0x30
> Aug 29 18:08:22 nvme-xfs-reflink-4k kernel:  </TASK>
[...]
> Looking at the KSM code in context ksm_scan_thread+0x175 is mm/ksm.c routine
> cmp_and_merge_page() on the split case:
> 
>                 } else if (split) {                                             
>                         /*                                                      
>                          * We are here if we tried to merge two pages and       
>                          * failed because they both belonged to the same        
>                          * compound page. We will split the page now, but no    
>                          * merging will take place.                             
>                          * We do not want to add the cost of a full lock; if    
>                          * the page is locked, it is better to skip it and      
>                          * perhaps try again later.                             
>                          */                                                     
>                         if (!trylock_page(page))                                
>                                 return;                                         
>                         split_huge_page(page);                                  
>                         unlock_page(page);                                      

Obviously the page is locked when we call split_huge_page().  There's
an assert inside it.  And the lock bit is _supposed_ to be transferred
to the head page of the page which is being split.  My guess is that
this is messed up somehow; we're perhaps transferring the lock bit to
the wrong page?

