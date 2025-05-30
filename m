Return-Path: <linux-fsdevel+bounces-50138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7523AAC87C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6851A1BC12CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FAA1E51FE;
	Fri, 30 May 2025 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei0fgaou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D4186A;
	Fri, 30 May 2025 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582224; cv=none; b=IbzrwODnlERI2XgTy6hPtxXf+XPHPrsGmm1/K2AgtfHxIGYTopC7FGxcnvmPVjgc3DTY5rftreiq74eQes9jNCd4CX5s/6ns6zXMRU1hC93Lvz9Br5dVMNlQaLsFFfpCD0xrhaZZEzQSO57UuNUGtLwn9F1UxiiETMg1k5tZjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582224; c=relaxed/simple;
	bh=6cDxG0+9QuMc3af6H2TLpTYEcXZDVD6F5xlnD/yaVbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsvyXfyX0RH/9TLk2N2a7WVKoXmAvVvO8EV6FRjbcOfYG5B1E+QdLGy+TyZMoAqDJMyms1SP+vM6wSlsjWx9aZbAaFOlUy1bd17S+qEghyJe1NYszXv4ss6RkxLysRiLcXTtvu/XGlEQ86hlqTslJ1vV533msA014oZpU5g4M/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei0fgaou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB32AC4CEE9;
	Fri, 30 May 2025 05:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748582224;
	bh=6cDxG0+9QuMc3af6H2TLpTYEcXZDVD6F5xlnD/yaVbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ei0fgaouIwi5/L9brRgojB3ZmFvnPnoGtN4NM/oXzFIaU2oO5czkYrbaAz1K5PPJq
	 6qIQDvcQHALdLVhJVnlt3jSYuxc1o3MFViFnGUUTnNt+ZuCmzLJ0IZ7Ut/hqhcQk0T
	 6ovngUr7lDHEbrWq7/Yq691hdoSiLXT65xfoqmH6N25VNM3p/yJvmpSxfcx5yylLhd
	 ajf7YkkkJNOuJYWd98uyk7wMVbp3Ec9uM3RFM12QmHY1VRuI3GwIrbzxlhVhL6qspA
	 1AxoofvTr4zOytcN56rKkkjd8VGa2qnxleHqb1Vy6yockiMWQsdneLUJXBSWjYomf9
	 nWssgxZQON77g==
Date: Fri, 30 May 2025 07:17:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, cem@kernel.org, 
	linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <20250530-ahnen-relaxen-917e3bba8e2d@brauner>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <20250529042550.GB8328@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250529042550.GB8328@frogsfrogsfrogs>

On Wed, May 28, 2025 at 09:25:50PM -0700, Darrick J. Wong wrote:
> On Thu, May 29, 2025 at 10:50:01AM +0800, Yafang Shao wrote:
> > Hello,
> > 
> > Recently, we encountered data loss when using XFS on an HDD with bad
> > blocks. After investigation, we determined that the issue was related
> > to writeback errors. The details are as follows:
> > 
> > 1. Process-A writes data to a file using buffered I/O and completes
> > without errors.
> > 2. However, during the writeback of the dirtied pagecache pages, an
> > I/O error occurs, causing the data to fail to reach the disk.
> > 3. Later, the pagecache pages may be reclaimed due to memory pressure,
> > since they are already clean pages.
> > 4. When Process-B reads the same file, it retrieves zeroed data from
> > the bad blocks, as the original data was never successfully written
> > (IOMAP_UNWRITTEN).
> > 
> > We reviewed the related discussion [0] and confirmed that this is a
> > known writeback error issue. While using fsync() after buffered
> > write() could mitigate the problem, this approach is impractical for
> > our services.
> > 
> > Instead, we propose introducing configurable options to notify users
> > of writeback errors immediately and prevent further operations on
> > affected files or disks. Possible solutions include:
> > 
> > - Option A: Immediately shut down the filesystem upon writeback errors.
> > - Option B: Mark the affected file as inaccessible if a writeback error occurs.
> > 
> > These options could be controlled via mount options or sysfs
> > configurations. Both solutions would be preferable to silently
> > returning corrupted data, as they ensure users are aware of disk
> > issues and can take corrective action.
> > 
> > Any suggestions ?
> 
> Option C: report all those write errors (direct and buffered) to a
> daemon and let it figure out what it wants to do:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=health-monitoring_2025-05-21
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=health-monitoring-rust_2025-05-21
> 
> Yes this is a long term option since it involves adding upcalls from the

I hope you don't mean actual usermodehelper upcalls here because we
should not add any new ones. If you just mean a way to call up from a
lower layer than that's obviously fine.

Fwiw, have you considered building this on top of a fanotify extension
instead of inventing your own mechanism for this?

> pagecache/vfs into the filesystem and out through even more XFS code,
> which has to go through its usual rigorous reviews.
> 
> But if there's interest then I could move up the timeline on submitting
> those since I wasn't going to do much with any of that until 2026.
> 
> --D
> 
> > [0] https://lwn.net/Articles/724307/
> > 
> > -- 
> > Regards
> > Yafang

