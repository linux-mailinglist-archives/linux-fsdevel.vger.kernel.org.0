Return-Path: <linux-fsdevel+bounces-25626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE994E545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66817281CEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED21369B4;
	Mon, 12 Aug 2024 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aelmlbfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A854759
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723431586; cv=none; b=I4k5QvCl27XU1qS2j7Dh7z7X8Six5FXAhbIQ5tWvTCObJxm4xq/wQGQOfMS+3J88iNIJttLPXeNvxAfKnwotmBocX3uU7jOrnusT/OolpVEMPijpSIBcTcl5yYXgLOTOcBw9b7OuU/EBhQmEljXZNxprOz5BGKH1YGrOqC9/f9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723431586; c=relaxed/simple;
	bh=KdN7iKiZ6rNGuT7v5F0SFKm080YOC5rpMzdnbInYG2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X9Kux3beq3hsx2/JM5nYhMUjVHXdJ+M8Rkmamm4xD7qsCrlXFSakBlPkTjs2hqH1E1YKrhS9ZxNN2bIT8AemzrFAxHbDRunVldThFsinnUXeM6rMWcsa4eSQwapVmZ4iyPBMKw8xxXqBavMAEsUDOCDK741C5gE3HQb05sPNjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aelmlbfK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nKUHV5hdUCjaT1ql3yVzlnWrzZKBjauRHIo+xiZtulE=; b=aelmlbfKRYH+Az67F7LyCTZ56c
	5JtgbzFzfC2M8hArMsLIOAhCWHujS3G1kR5DIh9Qsn0CvuhSXqcbi89WdiEB8AMs8kMqdZkpwG9FX
	1Ydcx8XOBJkhKBkPHc+9q/NaresB0eGjPFqPGbkMtWQ9WVfHMzJdtCwi87tb9RLnDWQK02x0qA4xF
	0UOeX10OtasLgmB7JJSiGh7FFcVsYw5l6Llk9kpa7VS4+reWVKgc3pLsoe6eW65NA4hQYUF80N7bD
	gcp2sA0oE1a8IZVPWFdPC+1xYnsJpfmQyDHLayEITwpBmLG4+41OXKAO3nZrOBWnCjqYNodM9JiSi
	h+O0FUDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdLHa-00000000xqO-1gbS;
	Mon, 12 Aug 2024 02:59:42 +0000
Date: Mon, 12 Aug 2024 03:59:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [git pull] fix bitmap corruption on close_range(), take 2
Message-ID: <20240812025942.GG13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Variant that deals with that in copy_fd_bitmaps() rather than in dup_fd()
Sat in -next since last week...

The following changes since commit 8aa37bde1a7b645816cda8b80df4753ecf172bf1:

  protect the fetch of ->fd[fd] in do_dup2() from mispredictions (2024-08-01 15:51:57 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 9a2fa1472083580b6c66bdaf291f591e1170123a:

  fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE (2024-08-05 19:23:11 -0400)

----------------------------------------------------------------
fix bitmap corruption on close_range(), take 2

----------------------------------------------------------------
Al Viro (1):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE

 fs/file.c                                       | 30 +++++++++------------
 include/linux/bitmap.h                          | 12 +++++++++
 tools/testing/selftests/core/close_range_test.c | 35 +++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 17 deletions(-)

