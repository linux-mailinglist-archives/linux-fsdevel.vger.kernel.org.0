Return-Path: <linux-fsdevel+bounces-31061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4B29917FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B73A28530D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DEA158D63;
	Sat,  5 Oct 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMShhU6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9C9158A09;
	Sat,  5 Oct 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143593; cv=none; b=Bhb55cFMbwNCrm7vqTuFP/GlYHGWTYhWXSfQIz35/TASpwrnnqD91VJ42tQkfk86NuAD7TWP9R25UkrjuA4dgICrBJmyF7VIq1r3VVTnWTrFz/TL/adp3OeOZ+xSR/aJ+6skwAShtYCI0pnC7uMLwUQKV68nv4KQAeRNfht5NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143593; c=relaxed/simple;
	bh=L8yA4MWWFugj2tkno+UxsF9dbyscX58UWixAtmtGuvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huwlrq1SIa34pdkUos/6BDAW1uhzRikIMFWNkK+ESoh/br6BW9tLAduCzk4GAP0ItWSu1ja1gV7Y1boxm1zODTjZ7bnF6iEmaLDhsnbFL8wUBNrXp/P883r0LODSGw9qIiCu6gZXxK5xLXJZrai5wfYGDeRs3uQ4zODw9VIYE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMShhU6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D5CC4CEC2;
	Sat,  5 Oct 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728143593;
	bh=L8yA4MWWFugj2tkno+UxsF9dbyscX58UWixAtmtGuvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMShhU6+RI37DS/wkC04l5P/MA2CRfyHrQAzJocKo+ba7cwbZlVCJq/U2UkK+N/zH
	 DS+gTLfbzNy1T6Yj8OH+XlxFWuNlFHLN911QOVyv4oCfWfxiDWX3cFTV2YHpysLzOy
	 9AgCC1coKVx+nn8Zy96oRIHRvv7WLMD8yC7co6rjp5XubQ3O5elzQB2U/tKo5JE5Yu
	 5OWHGI8+iEh0HvyS34KN+FYjgEyMAzNT5rLgI6V4+pBZOkq5Z+aQv9cyjbFQtp1IdH
	 BuNd6pvF5gVJ8TaOzbL7vsviXaon4/co0TctuvFg10OJj2ZWVAI5ZzJzdaW2gNuH7q
	 NVsk34mEGZZqA==
Date: Sat, 5 Oct 2024 08:53:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v4
Message-ID: <20241005155312.GM21853@frogsfrogsfrogs>
References: <20240924074115.1797231-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>

On Tue, Sep 24, 2024 at 09:40:42AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is another fallout from the zoned XFS work, which stresses the XFS
> COW I/O path very heavily.  It affects normal I/O to reflinked files as
> well, but is very hard to hit there.
> 
> The main problem here is that we only punch out delalloc reservations
> from the data fork, but COW I/O places delalloc extents into the COW
> fork, which means that it won't get punched out forshort writes.
> 
> [Sorry for the rapid fire repost, but as we're down to comment changes
>  and the series has been fully reviewed except for the trivial
>  refactoring patch at the beginning I'd like to get it out before being
>  semi-offline for a few days]

Hmmm so I tried applying this series, but now I get this splat:

[  217.170122] run fstests xfs/574 at 2024-10-04 16:36:30
[  218.248617] XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[  219.030068] XFS (sda4): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[  219.032253] XFS (sda4): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[  219.034749] XFS (sda4): Mounting V5 Filesystem 9de8b32b-dada-468a-b83b-f2c702031b67
[  219.073377] XFS (sda4): Ending clean mount
[  219.076260] XFS (sda4): Quotacheck needed: Please wait.
[  219.083160] XFS (sda4): Quotacheck: Done.
[  219.116532] XFS (sda4): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[  306.312461] INFO: task fsstress:27661 blocked for more than 61 seconds.
[  306.342904]       Not tainted 6.12.0-rc1-djwx #rc1
[  306.344066] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  306.345961] task:fsstress        state:D stack:11464 pid:27661 tgid:27661 ppid:1      flags:0x00004004
[  306.348070] Call Trace:
[  306.348722]  <TASK>
[  306.349177]  __schedule+0x419/0x14c0
[  306.350024]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  306.351305]  schedule+0x2c/0x110
[  306.352082]  schedule_preempt_disabled+0x18/0x30
[  306.353183]  rwsem_down_write_slowpath+0x2a8/0x6a0
[  306.354229]  ? filemap_add_folio+0xc5/0xf0
[  306.355160]  down_write+0x6e/0x70
[  306.355953]  xfs_buffered_write_iomap_end+0xcf/0x130 [xfs 05abef6fe7019e4129a0560dad36f86c40f3b541]
[  306.358115]  iomap_iter+0x78/0x2f0
[  306.358974]  iomap_file_unshare+0x82/0x290
[  306.359935]  xfs_reflink_unshare+0xf4/0x170 [xfs 05abef6fe7019e4129a0560dad36f86c40f3b541]
[  306.361787]  xfs_file_fallocate+0x13f/0x430 [xfs 05abef6fe7019e4129a0560dad36f86c40f3b541]
[  306.364005]  vfs_fallocate+0x110/0x320
[  306.364984]  __x64_sys_fallocate+0x42/0x70
[  306.365999]  do_syscall_64+0x47/0x100
[  306.366974]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  306.368228] RIP: 0033:0x7f893d3b2cb3
[  306.369064] RSP: 002b:00007ffd32c796d8 EFLAGS: 00000202 ORIG_RAX: 000000000000011d
[  306.370650] RAX: ffffffffffffffda RBX: 000000000000131e RCX: 00007f893d3b2cb3
[  306.372183] RDX: 000000000002eb27 RSI: 0000000000000041 RDI: 0000000000000005
[  306.373940] RBP: 0000000000000041 R08: 000000000000005f R09: 0000000000000078
[  306.375365] R10: 00000000000b0483 R11: 0000000000000202 R12: 0000000000000005
[  306.376763] R13: 000000000002eb27 R14: 0000000000000000 R15: 00000000000b0483
[  306.378174]  </TASK>

I think this series needs to assert that the invalidatelock is held
(instead of taking it) for the IOMAP_UNSHARE case too, since UNSHARE is
called from fallocate, which has already taken the MMAPLOCK.

--D

> Changes since v3:
>  - improve two comments
> 
> Changes since v2:
>  - drop the patches already merged and rebased to latest Linus' tree
>  - moved taking invalidate_lock from iomap to the caller to avoid a
>    too complicated locking protocol
>  - better document the xfs_file_write_zero_eof return value
>  - fix a commit log typo
> 
> Changes since v1:
>  - move the already reviewed iomap prep changes to the beginning in case
>    Christian wants to take them ASAP
>  - take the invalidate_lock for post-EOF zeroing so that we have a
>    consistent locking pattern for zeroing.
> 
> Diffstat:
>  Documentation/filesystems/iomap/operations.rst |    2 
>  fs/iomap/buffered-io.c                         |  111 ++++++-------------
>  fs/xfs/xfs_aops.c                              |    4 
>  fs/xfs/xfs_bmap_util.c                         |   10 +
>  fs/xfs/xfs_bmap_util.h                         |    2 
>  fs/xfs/xfs_file.c                              |  146 +++++++++++++++----------
>  fs/xfs/xfs_iomap.c                             |   65 +++++++----
>  include/linux/iomap.h                          |   20 ++-
>  8 files changed, 196 insertions(+), 164 deletions(-)
> 

