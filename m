Return-Path: <linux-fsdevel+bounces-46839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA953A95548
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6C71885978
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E6E1E5B71;
	Mon, 21 Apr 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH66sC6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994EC1DE8A8;
	Mon, 21 Apr 2025 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256423; cv=none; b=b++83+f9KKqueSPfhv/LiHi2LVnLVzE1HlZrEBkraxtkab2rcL9AifSzNgeY/3LXXDGMSzZfmfrG0NfcCvIlskMqYFNiqmcJzWzm5Uh24coTAKFG6KXUE8jk9YuD93IC0NeTEpjhtHlGsOLOhKIoCHZvSOsWgBjKgKDKB72ZWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256423; c=relaxed/simple;
	bh=aQsaCHIxyz5gzrUTjpK7zQ18kiLdHmZy8I1O5Z7GO0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPCTqN8nGQHcj2mNNzHznpufbtiTPLPRz8fV0o/2emKypRZapzPv3HOeGGLZinwmNIEiymtOCnf1rscW6D3CN/cHcVdU1Ato+c/hynrpVeHVg7s5B2yBlGf55NNksMOUGsKJL/D57v1qL6mwGj98pXnLhafaUaHkY1yzTdj1pgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EH66sC6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D005C4CEE4;
	Mon, 21 Apr 2025 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745256423;
	bh=aQsaCHIxyz5gzrUTjpK7zQ18kiLdHmZy8I1O5Z7GO0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EH66sC6GZy9RBUo2HNGiqpTy0NgIbXEfFkGLdkvgZsqC1zQkeyJriQP1w/Q1GRSBC
	 cm6pMjCEPqmrW9T1vOtqXkDqjdrZd1tltF4nLqqEc1y8Qx2Y0D0Va5CK4IzlFehT7H
	 ZRAjGXyM3nhCOZJ1D8una0eOPbIu78Z7zhETUL78hx7UET/uZM/kgfHx/Kzkw7zX/9
	 K7+OUOGWJWta9ZltQrSt5c1H2r6anjmD8/nYuBTKRqPCMumII/Z0o25PmEd+265hAD
	 xdMSMPvGu93a11vnk6g7Y/9xS97t3wuTwL9nH05CKw02VvU+Yi/oW8EgYq3yaXNuEs
	 ZTUM9YJfFqJGA==
Date: Mon, 21 Apr 2025 10:27:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: scheduling while atomic on rc3 - migration + buffer heads
Message-ID: <20250421172702.GB25655@frogsfrogsfrogs>
References: <hdqfrw2zii53qgyqnq33o4takgmvtgihpdeppkcsayn5wrmpyu@o77ad4o5gjlh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hdqfrw2zii53qgyqnq33o4takgmvtgihpdeppkcsayn5wrmpyu@o77ad4o5gjlh>

On Mon, Apr 21, 2025 at 11:14:44AM -0400, Kent Overstreet wrote:
> This just popped up in one of my test runs.
> 
> Given that it's buffer heads, it has to be the ext4 root filesystem, not
> bcachefs.

Wrong.  udev calling libblkid reading the (mounted) bdev to figure out
there's a bcachefs filesystem will still create bufferheads, and
possibly very large ones.

willy's temporary workaround in
https://lore.kernel.org/linux-fsdevel/Z_VwF1MA-R7MgDVG@casper.infradead.org/

shuts all that up enough to move on to triaging the rest of the
bleeding.

--D

> 00465 ========= TEST   lz4_buffered
> 00465 
> 00465 WATCHDOG 360
> 00466 bcachefs (vdb): starting version 1.25: extent_flags opts=errors=panic,compression=lz4
> 00466 bcachefs (vdb): initializing new filesystem
> 00466 bcachefs (vdb): going read-write
> 00466 bcachefs (vdb): marking superblocks
> 00466 bcachefs (vdb): initializing freespace
> 00466 bcachefs (vdb): done initializing freespace
> 00466 bcachefs (vdb): reading snapshots table
> 00466 bcachefs (vdb): reading snapshots done
> 00466 bcachefs (vdb): done starting filesystem
> 00466 starting copy
> 00515 BUG: sleeping function called from invalid context at mm/util.c:743
> 00515 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 120, name: kcompactd0
> 00515 preempt_count: 1, expected: 0
> 00515 RCU nest depth: 0, expected: 0
> 00515 1 lock held by kcompactd0/120:
> 00515  #0: ffffff80c0c558f0 (&mapping->i_private_lock){+.+.}-{3:3}, at: __buffer_migrate_folio+0x114/0x298
> 00515 Preemption disabled at:
> 00515 [<ffffffc08025fa84>] __buffer_migrate_folio+0x114/0x298
> 00515 CPU: 11 UID: 0 PID: 120 Comm: kcompactd0 Not tainted 6.15.0-rc3-ktest-gb2a78fdf7d2f #20530 PREEMPT 
> 00515 Hardware name: linux,dummy-virt (DT)
> 00515 Call trace:
> 00515  show_stack+0x1c/0x30 (C)
> 00515  dump_stack_lvl+0xb0/0xc0
> 00515  dump_stack+0x14/0x20
> 00515  __might_resched+0x180/0x288
> 00515  folio_mc_copy+0x54/0x98
> 00515  __migrate_folio.isra.0+0x68/0x168
> 00515  __buffer_migrate_folio+0x280/0x298
> 00515  buffer_migrate_folio_norefs+0x18/0x28
> 00515  migrate_pages_batch+0x94c/0xeb8
> 00515  migrate_pages_sync+0x84/0x240
> 00515  migrate_pages+0x284/0x698
> 00515  compact_zone+0xa40/0x10f8
> 00515  kcompactd_do_work+0x204/0x498
> 00515  kcompactd+0x3c4/0x400
> 00515  kthread+0x13c/0x208
> 00515  ret_from_fork+0x10/0x20
> 00518 starting sync
> 00519 starting rm
> 00520 ========= FAILED TIMEOUT lz4_buffered in 360s
> 
> 

