Return-Path: <linux-fsdevel+bounces-50017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A35AC7593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 03:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22659A278E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 01:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B714221F02;
	Thu, 29 May 2025 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIKZRnY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947717C211
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483799; cv=none; b=TGkbuErL0Seeu61sy0ahTak29PAPwbGZWich5jkm1UWKok5+HwUlxTtKFywikeAzUxgs+d/tzba+FXvr7yVaTfVoKPrUpW1zylo7j79Ax5eUR8rHIF8lL4OkYO+VtAsCu9j3NflRzqfar5aByLo1vvQ2ffof+o03LNtEo8DyfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483799; c=relaxed/simple;
	bh=Cdc0wWZjd918WAjaVqHSay6YsIud9Eup5zk1JdHngZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG3mfUihuvfamZ02TogUE8iqQ/H46S4He7WndqBWLda9R8FJIoSIT9UVaFBdzeqmgr4HCeCWpSfnEcb99jFygcMnE7ZNPsDIzsmGSyOguk2hVvkYciPAPAmObhN2fp/fEl83yrVwQYOgy3ibpczp7mduq9HJCb+39vR0fimD1Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIKZRnY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446F2C4CEE3;
	Thu, 29 May 2025 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748483798;
	bh=Cdc0wWZjd918WAjaVqHSay6YsIud9Eup5zk1JdHngZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIKZRnY9yR/P+Ac+WhIEV0r52so8zS9ztlVEMUd9U7mEKOn+iT2LIcMkE8a4AxYWn
	 0QglWqX+XwzHJ/c1dFIRB/1G8m7X0bhP4NOxUHqliQuXFXTUpsiHJTQbKeDSpUSt+E
	 i8in/XpJdW3+Fxeplshcm13Iy1nxyhR5yAY9cbqrIovHzgCkAWNnoeiF7A+yUpasC5
	 /mqV3k4Lv6dV14TY4T7r4veuYPlq1jca71uhtvoaJ7gX+QVPeb58WB0AuaZ9Q4noix
	 b1lbbRRVOzMS55d0BXvB+SoA0/Z7OUjenUa/htRNkHc5y0Nkr+XGjjw+W9X1ZSvkIj
	 PikK9u9+28flA==
Date: Wed, 28 May 2025 18:56:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250529015637.GA8286@frogsfrogsfrogs>
References: <20250525083209.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525083209.GS2023217@ZenIV>

On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
> generic/127 with xfstests built on debian-testing (trixie) ends up with
> assorted memory corruption; trace below is with CONFIG_DEBUG_PAGEALLOC and
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT and it looks like a double free
> somewhere in iomap.  Unfortunately, commit in question is just making
> xfs use the infrastructure built in earlier series - not that useful
> for isolating the breakage.
> 
> [   22.001529] run fstests generic/127 at 2025-05-25 04:13:23
> [   35.498573] BUG: Bad page state in process kworker/2:1  pfn:112ce9
> [   35.499260] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e 9
> [   35.499764] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)
> [   35.500302] raw: 800000000000000e dead000000000100 dead000000000122 000000000
> [   35.500786] raw: 000000000000003e 0000000000000000 00000000ffffffff 000000000
> [   35.501248] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [   35.501624] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs0
> [   35.503209] CPU: 2 UID: 0 PID: 85 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ 7
> [   35.503211] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.164
> [   35.503212] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]
> [   35.503279] Call Trace:
> [   35.503281]  <TASK>
> [   35.503282]  dump_stack_lvl+0x4f/0x60
> [   35.503296]  bad_page+0x6f/0x100
> [   35.503300]  free_frozen_pages+0x303/0x550
> [   35.503301]  iomap_finish_ioend+0xf6/0x380
> [   35.503304]  iomap_finish_ioends+0x83/0xc0
> [   35.503305]  xfs_end_ioend+0x64/0x140 [xfs]
> [   35.503342]  xfs_end_io+0x93/0xc0 [xfs]
> [   35.503378]  process_one_work+0x153/0x390
> [   35.503382]  worker_thread+0x2ab/0x3b0
> 
> It's 4:30am here, so I'm going to leave attempts to actually debug that
> thing until tomorrow; I do have a kvm where it's reliably reproduced
> within a few minutes, so if anyone comes up with patches, I'll be able
> to test them.
> 
> Breakage is still present in the current mainline ;-/

Hey Al,

Welll this certainly looks like the same report I made a month ago.
I'll go run 6.15 final (with the #define RWF_DONTCACHE 0) overnight to
confirm if that makes my problem go away.  If these are one and the same
bug, then thank you for finding a better reproducer! :)

https://lore.kernel.org/linux-fsdevel/20250416180837.GN25675@frogsfrogsfrogs/

--D

