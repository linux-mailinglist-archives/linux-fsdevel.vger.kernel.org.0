Return-Path: <linux-fsdevel+bounces-49816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCBAC32F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBE189638B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBEA1A0711;
	Sun, 25 May 2025 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="omU2obhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52581433A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748161935; cv=none; b=HpaiN+rbXOEYzDr9/TnGCAW8R6prJ3Enj62Z3uNuEJ5Cgouy/YnXmSiRwxbBejXpT/AOE60IEKmW0IUJes1QvMpyaVzeKuYBxozHV5qEiKIyOXlX9OnpD5M+kHKXefWkTxVUFmgkqFvGjmn8/IbEz4mwoQRcIPTa8EYkdri3vSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748161935; c=relaxed/simple;
	bh=B17GLED/Bb3y6cz4uP1qUk558j6xNqKS2eK7PFOO6Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oquCERMtB9dY2WiFXQGBtwFmQuaMrdLzMggIeu9j+h4dcR4v7GoNEr+FICerDRLkrJbIhzESs7C1DoilAkynQuSaHHiNcrPv4zWYDfD5IcBEkDajt/6GmwjNONCGQyd9DdDbjyAYttTeuG0Ds4gsZnTfoNpIoKOQa25/fElI5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=omU2obhG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/ORqtliY0GO5AZsuT8Uu0qPbcfb5HyPScSKJsDOt+Ns=; b=omU2obhGYJOEZx1q0apri/Immb
	cNgEizO8z9+9DNvZ839+dbDwLeIUyFVll9+SkZW07bwXIMkrKpVO1MTMNPpjLK+lF7Hjd+5Yr2IqI
	w6OQJUjBr0qJh1FDTRqRzoixNjPmLxQdVkxAZZlU+IzY28Ss8q9qfyaB6knPtrdasMBVZQQOnLtEF
	tHB9bPzJwfhTnyBX215f00yW8HF9S0Is1cfH2AOF4puTcozL3AbQ09m20mR8Hr0j6gFqlW/rcQ0ll
	tMwNsnZQGhTJThGjGZ7voxnUMAt5ZtBy1axbPmtIbPs3hk/j8nC6/l65E5eoqX3q7ZUZiz61LaL6L
	X4DS2QEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJ6m9-0000000CRht-3EMS;
	Sun, 25 May 2025 08:32:09 +0000
Date: Sun, 25 May 2025 09:32:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250525083209.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

generic/127 with xfstests built on debian-testing (trixie) ends up with
assorted memory corruption; trace below is with CONFIG_DEBUG_PAGEALLOC and
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT and it looks like a double free
somewhere in iomap.  Unfortunately, commit in question is just making
xfs use the infrastructure built in earlier series - not that useful
for isolating the breakage.

[   22.001529] run fstests generic/127 at 2025-05-25 04:13:23
[   35.498573] BUG: Bad page state in process kworker/2:1  pfn:112ce9
[   35.499260] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e 9
[   35.499764] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)
[   35.500302] raw: 800000000000000e dead000000000100 dead000000000122 000000000
[   35.500786] raw: 000000000000003e 0000000000000000 00000000ffffffff 000000000
[   35.501248] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[   35.501624] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs0
[   35.503209] CPU: 2 UID: 0 PID: 85 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ 7
[   35.503211] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.164
[   35.503212] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]
[   35.503279] Call Trace:
[   35.503281]  <TASK>
[   35.503282]  dump_stack_lvl+0x4f/0x60
[   35.503296]  bad_page+0x6f/0x100
[   35.503300]  free_frozen_pages+0x303/0x550
[   35.503301]  iomap_finish_ioend+0xf6/0x380
[   35.503304]  iomap_finish_ioends+0x83/0xc0
[   35.503305]  xfs_end_ioend+0x64/0x140 [xfs]
[   35.503342]  xfs_end_io+0x93/0xc0 [xfs]
[   35.503378]  process_one_work+0x153/0x390
[   35.503382]  worker_thread+0x2ab/0x3b0

It's 4:30am here, so I'm going to leave attempts to actually debug that
thing until tomorrow; I do have a kvm where it's reliably reproduced
within a few minutes, so if anyone comes up with patches, I'll be able
to test them.

Breakage is still present in the current mainline ;-/

