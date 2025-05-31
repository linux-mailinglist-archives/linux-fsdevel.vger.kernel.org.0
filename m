Return-Path: <linux-fsdevel+bounces-50252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEEAC98BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 03:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C382F1BA5E7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99ED1096F;
	Sat, 31 May 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DadsoKWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432F4A08
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748653852; cv=none; b=Ypm8UZ8N9GH+rC4MykIKNcHVQW0hoLkFvuFaJvfxiwrQb8/GVIUssdnIfFKVLcQzGx4IdQCTAa6Fm2exZRthAzN9+uUjtPOdIURHKMYY2wTZASBfkpHxs2rx/ffCHQWoilaDra2yh4tuWlYpMUcbFh17LTNyvze7ITYbpXxHS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748653852; c=relaxed/simple;
	bh=p5YVcFHUA3wZmphtWOQ+7YAEScxdHCW4vnhJUnLSl1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1oSiaa9jWnVW9k78gxKsy0he/JTMOJYQZa5aMd5aMG2PCxBF+LdZ2gFUbJYJr84iYEE05/xCOGyC336S2+XlU6TQCdYtAzzqS+10gnFZxIsp/D2S1RxuqahUnDZJf6fID1img7bBbjHCmTxool8qmtOt0XuOS4xIJw6WDBEB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DadsoKWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB20C4CEEB;
	Sat, 31 May 2025 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748653851;
	bh=p5YVcFHUA3wZmphtWOQ+7YAEScxdHCW4vnhJUnLSl1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DadsoKWDwhBHWbqrINr33oWI4qFezXmABnCs6YJQbnl+hVYi49icPdPRxeqEzO3E5
	 +AvejGG4uetIKVOCTXEpsrX8ovikRppz2gAsNlZXk3F3l7M5BJ3/eq+SVM2dukdPiC
	 sK1otYq7LF5fW7965C9TGjmpAkC0NKlDzOzOJOMMULIoX06whs9JCFdcV3J+0DRAqn
	 5nPVerh1pKSFdVcAIKDPsZzryfzVYfqB5LdqOKNwQJ55k+qaLWm6vf/A6uxcgYlfia
	 zN8M1uQLQZrJUtjW9EWeF3hyY16E+jigl6WQJOQm5n/3HYpHUiZoi56INJgh9BQs9W
	 WQpEKkSGUj/+g==
Date: Fri, 30 May 2025 18:10:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250531011050.GB8286@frogsfrogsfrogs>
References: <20250525083209.GS2023217@ZenIV>
 <20250529015637.GA8286@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529015637.GA8286@frogsfrogsfrogs>

On Wed, May 28, 2025 at 06:56:37PM -0700, Darrick J. Wong wrote:
> On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
> > generic/127 with xfstests built on debian-testing (trixie) ends up with
> > assorted memory corruption; trace below is with CONFIG_DEBUG_PAGEALLOC and
> > CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT and it looks like a double free
> > somewhere in iomap.  Unfortunately, commit in question is just making
> > xfs use the infrastructure built in earlier series - not that useful
> > for isolating the breakage.
> > 
> > [   22.001529] run fstests generic/127 at 2025-05-25 04:13:23
> > [   35.498573] BUG: Bad page state in process kworker/2:1  pfn:112ce9
> > [   35.499260] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e 9
> > [   35.499764] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)
> > [   35.500302] raw: 800000000000000e dead000000000100 dead000000000122 000000000
> > [   35.500786] raw: 000000000000003e 0000000000000000 00000000ffffffff 000000000
> > [   35.501248] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> > [   35.501624] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs0
> > [   35.503209] CPU: 2 UID: 0 PID: 85 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ 7
> > [   35.503211] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.164
> > [   35.503212] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]
> > [   35.503279] Call Trace:
> > [   35.503281]  <TASK>
> > [   35.503282]  dump_stack_lvl+0x4f/0x60
> > [   35.503296]  bad_page+0x6f/0x100
> > [   35.503300]  free_frozen_pages+0x303/0x550
> > [   35.503301]  iomap_finish_ioend+0xf6/0x380
> > [   35.503304]  iomap_finish_ioends+0x83/0xc0
> > [   35.503305]  xfs_end_ioend+0x64/0x140 [xfs]
> > [   35.503342]  xfs_end_io+0x93/0xc0 [xfs]
> > [   35.503378]  process_one_work+0x153/0x390
> > [   35.503382]  worker_thread+0x2ab/0x3b0
> > 
> > It's 4:30am here, so I'm going to leave attempts to actually debug that
> > thing until tomorrow; I do have a kvm where it's reliably reproduced
> > within a few minutes, so if anyone comes up with patches, I'll be able
> > to test them.
> > 
> > Breakage is still present in the current mainline ;-/
> 
> Hey Al,
> 
> Welll this certainly looks like the same report I made a month ago.
> I'll go run 6.15 final (with the #define RWF_DONTCACHE 0) overnight to
> confirm if that makes my problem go away.  If these are one and the same
> bug, then thank you for finding a better reproducer! :)
> 
> https://lore.kernel.org/linux-fsdevel/20250416180837.GN25675@frogsfrogsfrogs/

After a full QA run, 6.15 final passes fstests with flying colors.  So I
guess we now know the culprit.  Will test the new RWF_DONTCACHE fixes
whenever they appear in upstream.

--D

