Return-Path: <linux-fsdevel+bounces-46806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1FA95373
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1A53B15AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 15:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7561C84B9;
	Mon, 21 Apr 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tVhxywvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5414AD20
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248495; cv=none; b=n3c0nrnWUoWuQkqKFSI7ChqGXzxrGKSpNmRfox6yfCzr6kGzmRxIbyPtE7cyyq4N4vkLRXMcwinNgk5cFwZMN+xINK2SdqltVTFp6bbp2NAPED1la3F76qTjVjy6Vi1SPmXZLmxw2qy9mtq5AaxZ/VrHgjfhLMwmCPyRVukIoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248495; c=relaxed/simple;
	bh=1V6oq1lojH7d0rV00jQuJK1IJECZwCPbCWw/hB0uEqI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mmjrsukn2qQhrQyueDmf/Zag0BEnAunOpSaHi9csxhcUkEMV2kFvqwrDvTufkxTo3qijaWhYt9+XhLhS0YzA6Y8zpWVo8dsypl2vXLSMZzviqeZNYAlb2h7SCFd9jCXP8DXNWpjLP2sXCgmneCCnqpG0yV9LtLijcAJf5n30OWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tVhxywvS; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 11:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745248488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=EdgAAO3qOB3KHRhecFrdNXOlSanyzCRldN0OpfOPbkI=;
	b=tVhxywvStILgtoZluqLHHUWW6a7uFGJTvuFLyOq1KYu++OaaGrywFoVFCY6JfeBfDUhAKe
	nyQsuVS8zTObsZw3taeXLxz2jwjVVyrUiZrUwG0itj8d0UmeLziZ1ghg93JM58dn63nWVv
	2GuIkK5wQf0T5K9NhXsP0azBW3CXo3c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: scheduling while atomic on rc3 - migration + buffer heads
Message-ID: <hdqfrw2zii53qgyqnq33o4takgmvtgihpdeppkcsayn5wrmpyu@o77ad4o5gjlh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

This just popped up in one of my test runs.

Given that it's buffer heads, it has to be the ext4 root filesystem, not
bcachefs.

00465 ========= TEST   lz4_buffered
00465 
00465 WATCHDOG 360
00466 bcachefs (vdb): starting version 1.25: extent_flags opts=errors=panic,compression=lz4
00466 bcachefs (vdb): initializing new filesystem
00466 bcachefs (vdb): going read-write
00466 bcachefs (vdb): marking superblocks
00466 bcachefs (vdb): initializing freespace
00466 bcachefs (vdb): done initializing freespace
00466 bcachefs (vdb): reading snapshots table
00466 bcachefs (vdb): reading snapshots done
00466 bcachefs (vdb): done starting filesystem
00466 starting copy
00515 BUG: sleeping function called from invalid context at mm/util.c:743
00515 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 120, name: kcompactd0
00515 preempt_count: 1, expected: 0
00515 RCU nest depth: 0, expected: 0
00515 1 lock held by kcompactd0/120:
00515  #0: ffffff80c0c558f0 (&mapping->i_private_lock){+.+.}-{3:3}, at: __buffer_migrate_folio+0x114/0x298
00515 Preemption disabled at:
00515 [<ffffffc08025fa84>] __buffer_migrate_folio+0x114/0x298
00515 CPU: 11 UID: 0 PID: 120 Comm: kcompactd0 Not tainted 6.15.0-rc3-ktest-gb2a78fdf7d2f #20530 PREEMPT 
00515 Hardware name: linux,dummy-virt (DT)
00515 Call trace:
00515  show_stack+0x1c/0x30 (C)
00515  dump_stack_lvl+0xb0/0xc0
00515  dump_stack+0x14/0x20
00515  __might_resched+0x180/0x288
00515  folio_mc_copy+0x54/0x98
00515  __migrate_folio.isra.0+0x68/0x168
00515  __buffer_migrate_folio+0x280/0x298
00515  buffer_migrate_folio_norefs+0x18/0x28
00515  migrate_pages_batch+0x94c/0xeb8
00515  migrate_pages_sync+0x84/0x240
00515  migrate_pages+0x284/0x698
00515  compact_zone+0xa40/0x10f8
00515  kcompactd_do_work+0x204/0x498
00515  kcompactd+0x3c4/0x400
00515  kthread+0x13c/0x208
00515  ret_from_fork+0x10/0x20
00518 starting sync
00519 starting rm
00520 ========= FAILED TIMEOUT lz4_buffered in 360s


