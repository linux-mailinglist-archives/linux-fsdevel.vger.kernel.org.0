Return-Path: <linux-fsdevel+bounces-27018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B595DB83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 06:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD29284236
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEE14A4D8;
	Sat, 24 Aug 2024 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuFQZx+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705D182B4;
	Sat, 24 Aug 2024 04:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724474804; cv=none; b=lCOFc0LfrmuZ6dUX+z9RgvTUhLOeS6e/w5LWLA/drBnWCSfsuCkFoLz5BnIeAh6m0vo6JgVEoeX56x4qujx0d5lss3lscqWhHqRKprU3IVhBgSntUJJNI5phTQpO5DrGvvq6aZJrO3t4MYCKsc4UCeq02RhQaZHgzrX4CNCdPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724474804; c=relaxed/simple;
	bh=s7xdtysKKGZbwDUnaPeYWK3s+KmjLTpVXaCfvp3YpeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgKr5pLNCPJbmsc++ip9H/tSEnc+vEmiqIhM2LTIH1SP6Kxa45p6BtGQJ8tgcKzYId5vMhqpkvRz3bAwgumlvLHuR3ZqyOXwBSYbgo1FKLj1fVb5UnFJjGDU767mmvtW/EmhdY9I408JgXB1p/mhHRg2soxoRl2Vu4mLSAcib88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuFQZx+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF5C32781;
	Sat, 24 Aug 2024 04:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724474804;
	bh=s7xdtysKKGZbwDUnaPeYWK3s+KmjLTpVXaCfvp3YpeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuFQZx+D9EgidxuPZ/uU0kAI6aq9Ze95SAzRK8D/peebcha4jjmBb05kQOP8/5jzS
	 zyE3v/5uPlo/lV2sfNOm1vPEKt/lbdspQVSILJlprqmy9Kc+B2bp3XDFCR8eyWPc9m
	 WFQq7NlSzFWvA4fAMyfs2jaOLbnVRklBgz6EhTgr1Fc6Unxt02FrtV+JHEvqy9L74z
	 kgcK0ucbA88d8BLMTHMKeMXNwXWC68c7GUMxlN35VOll+Ths19HQeMPvSDXlKEp/lx
	 kYH/MjCOsyXDFTGELy/F123Qiy6Awsxmi9QCPl83g1TgGAMRgFjcuB8h3tbi1blYyp
	 MUWEelq7iSmZw==
Date: Fri, 23 Aug 2024 21:46:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: introduce new file range commit ioctls
Message-ID: <20240824044643.GS865349@frogsfrogsfrogs>
References: <172437084258.57211.13522832162579952916.stgit@frogsfrogsfrogs>
 <172437084278.57211.4355071581143024290.stgit@frogsfrogsfrogs>
 <ZsgMRrOBlBwsHBdZ@infradead.org>
 <e167fb368b8a54b0716ae35730ddc61a658f6f6a.camel@kernel.org>
 <20240823174140.GJ865349@frogsfrogsfrogs>
 <ZslTjr9P-2JUKVg7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZslTjr9P-2JUKVg7@infradead.org>

On Fri, Aug 23, 2024 at 08:29:18PM -0700, Christoph Hellwig wrote:
> On Fri, Aug 23, 2024 at 10:41:40AM -0700, Darrick J. Wong wrote:
> > <nod> If these both get merged for 6.12, I think the appropriate port
> > for this patch is to change xfs_ioc_start_commit to do:
> > 
> > 	struct kstat	kstat;
> > 
> > 	fill_mg_cmtime(&kstat, STATX_CTIME | STATX_MTIME, XFS_I(ip2));
> > 	kern_f->file2_ctime		= kstat.ctime.tv_sec;
> > 	kern_f->file2_ctime_nsec	= kstat.ctime.tv_nsec;
> > 	kern_f->file2_mtime		= kstat.mtime.tv_sec;
> > 	kern_f->file2_mtime_nsec	= kstat.mtime.tv_nsec;
> > 
> > instead of open-coding the inode_get_[cm]time calls.  The entire
> > exchangerange feature is still marked experimental, so I didn't think it
> > was worth rebasing my entire dev branch on the multigrain timestamp
> > redux series; we can just fix it later.
> 
> But the commit log could really note this dependency.  This will be
> especially useful for backports, but also for anyone reading through
> code history.

Ok, how about this for a commit message:

"This patch introduces two more new ioctls to manage atomic updates to
file contents -- XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE.  The
commit mechanism here is exactly the same as what XFS_IOC_EXCHANGE_RANGE
does, but with the additional requirement that file2 cannot have changed
since some sampling point.  The start-commit ioctl performs the sampling
of file attributes.

"Note: This patch currently samples i_ctime during START_COMMIT and
checks that it hasn't changed during COMMIT_RANGE.  This isn't entirely
safe in kernels prior to 6.12 because ctime only had coarse grained
granularity and very fast updates could collide with a COMMIT_RANGE.
With the multi-granularity ctime introduced in that release by Jeff
Layton, it's now possible to update ctime such that this does not
happen.

"It is critical, then, that this patch must not be backported to any
kernel that does not support fine-grained file change timestamps."

Will that pass muster?

--D

