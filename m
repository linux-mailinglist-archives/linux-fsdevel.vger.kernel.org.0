Return-Path: <linux-fsdevel+bounces-50023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA50AC771D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5F54E6E58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 04:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D62512F1;
	Thu, 29 May 2025 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQEroKRC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4D35957;
	Thu, 29 May 2025 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492751; cv=none; b=M9RDErYS7B8hyaXR/iqacBZg3Q+Px8zoIeC0MZ9tXbwb6MPjsY/R5eTdCgqbdY8IiSCDyuqwK6JojXndP1YnV43IoDAWspzMHFUH1OYn4pqZ9dIxYyXI4cWulNykpt1UcYVqe2jHiCcsd+pT2LAMjMyxcKpAEu8wvRr1Qd53a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492751; c=relaxed/simple;
	bh=paDT7aS9nNhANhq81iCXOFpnZdrfvbF+DWL2xz0lLxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDISQxzQPj9/FAGVzUdtPllxxVrIROSlArx6pM90d/RGkSmafgGrYiFSXh04e0mtUFOXHQXVMdGW3nFhsRNVpq/+ykc3gzZ8x+cTJGwLAcfkIe5L/L9VQhlyGI7EY2sfPqzdo2W1YhwTrzja/bpNPDA+GCIqcYj9RNa8lF/iUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQEroKRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ACBC4CEEA;
	Thu, 29 May 2025 04:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748492750;
	bh=paDT7aS9nNhANhq81iCXOFpnZdrfvbF+DWL2xz0lLxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQEroKRCXBzevd4wnQBkdVpOzpnh9CZrhGmfIuD9lVG4xjzrqqkDT3sdeccUCMWX7
	 Hg1fZnmrAE7UcPLwVw9Z+GzGNch95RiT6t3xKEU5pUhEj3QCd9AXTwHmxWGCVH0pLv
	 cYEBOSrjBP01kwriEtSKIZ7zJs3yDv1nLYysiMT/ECgwmsy36VcTPtt/ZVYKwQ7lHz
	 CSE5qyZOejOKoy6rypmmkGF9dMDn9FnH3/SrpP58lqEbVRjU90SWIIsYS7CqV+YjOJ
	 G2z9RJTrwWPFCg7vZnciLmNyfTGoxMG0xvrbkl9JRBKRk9UWk1KLfpAFS4ybCdbG1s
	 k7m1R3f8bSAYg==
Date: Wed, 28 May 2025 21:25:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <20250529042550.GB8328@frogsfrogsfrogs>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>

On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> Hello,
> 
> Recently, we encountered data loss when using XFS on an HDD with bad
> blocks. After investigation, we determined that the issue was related
> to writeback errors. The details are as follows:
> 
> 1. Process-A writes data to a file using buffered I/O and completes
> without errors.
> 2. However, during the writeback of the dirtied pagecache pages, an
> I/O error occurs, causing the data to fail to reach the disk.
> 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> since they are already clean pages.
> 4. When Process-B reads the same file, it retrieves zeroed data from
> the bad blocks, as the original data was never successfully written
> (IOMAP_UNWRITTEN).
> 
> We reviewed the related discussion [0] and confirmed that this is a
> known writeback error issue. While using fsync() after buffered
> write() could mitigate the problem, this approach is impractical for
> our services.
> 
> Instead, we propose introducing configurable options to notify users
> of writeback errors immediately and prevent further operations on
> affected files or disks. Possible solutions include:
> 
> - Option A: Immediately shut down the filesystem upon writeback errors.
> - Option B: Mark the affected file as inaccessible if a writeback error occurs.
> 
> These options could be controlled via mount options or sysfs
> configurations. Both solutions would be preferable to silently
> returning corrupted data, as they ensure users are aware of disk
> issues and can take corrective action.
> 
> Any suggestions ?

Option C: report all those write errors (direct and buffered) to a
daemon and let it figure out what it wants to do:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring_2025-05-21
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring-rust_2025-05-21

Yes this is a long term option since it involves adding upcalls from the
pagecache/vfs into the filesystem and out through even more XFS code,
which has to go through its usual rigorous reviews.

But if there's interest then I could move up the timeline on submitting
those since I wasn't going to do much with any of that until 2026.

--D

> [0] https://lwn.net/Articles/724307/
> 
> -- 
> Regards
> Yafang

