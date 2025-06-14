Return-Path: <linux-fsdevel+bounces-51650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EA7AD9A4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2691E17CD5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACA1DE3DB;
	Sat, 14 Jun 2025 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uUfeStW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049F78F2B
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880856; cv=none; b=bYQMMahmdHTFykSx7lldv0GrJiGiij803I9sBdh/FbNYHtTaQBdt+dlRfGdbdO7mHcmYYRcK+TF8Y0lvgZOx/yqYw0wj6opw16HpwTwI+Vw5x48vDItiTDctJnl0I1u902KLasvKr15qxCEsb4/GmKGvSY9lKKv/T1VnEAACNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880856; c=relaxed/simple;
	bh=b9z9w3PTdtUGUtawr0ocT5z3TwhISVIPynAAVlgfFJw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VTbzkAoWyRE3+bo9U26t4CWg+qkc6LQWPKBJCTsrmdo6VAefcl5pYyGBo3+oLzb6SRoSQ0jOpmj2ypB9uVlh4rq1bWoFqQKOvdlkhW265ySU75wVsO+ZrQshIRBp+khohJKsTtKPnegIydE7c3HDWFwfmBIvQZ+eM6prNAuGAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uUfeStW/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=R0iFuKX2CD/jEHTwSLz/yN1F6M1FFDVoz/XJI+Jub6I=; b=uUfeStW/1ze8Yf+mZMu2Fktg6R
	B9N03SuonTKvBTAK71DVaUddABbITR5gRcLJU4YrUGDSebyz8oz7S2oficTt+4XiIAWACF7XB0zVG
	F+HkgCSFfZd8ukat5sR9IgcngClZnyOBOEyGy3LXbLsgF9irzHtP3e3eftpPiYIunbWm711kUEJzg
	8nwWzMo8QSE+pjGtWsuk3zxrXNlFENhG6X88os039hl52vHwZ417pHva/CPttTCoSenQ7DdftOAIj
	epxTqJ+n5SgGANRho4otWJiJTG3xgskZzfFuzcnssfOJ7vJpx98KNtSrcSKXYaiEG7+ywSR5TNl0r
	CDaYAeFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJwg-000000021hk-2ZFR;
	Sat, 14 Jun 2025 06:00:50 +0000
Date: Sat, 14 Jun 2025 07:00:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Subject: [PATCHES][RFC][CFT] simple_recursive_removal() work
Message-ID: <20250614060050.GB1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[another part of tree-in-dcache pile pulled into a separate branch]

	Removing subtrees of kernel filesystems is done in quite a few
places; unfortunately, it's easy to get wrong.	A number of open-coded
attempts are out there, with varying amount of bogosities.

	simple_recursive_removal() had been introduced for doing that with
all precautions needed; it does an equivalent of rm -rf, with sufficient
locking, eviction of anything mounted on top of the subtree, etc.

	The series below converts a bunch of open-coded instances
to using that.  It's v6.16-rc1-based, lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.simple_recursive_removal
Individual patches in followups.

The first commit is shared with work.rpc_pipe (and several other branches);
the rest has not been posted yet.  If there's no objections, into -next
it goes...

Shortlog:
Al Viro(8)
      simple_recursive_removal(): saner interaction with fsnotify
      add locked_recursive_removal()
      spufs: switch to locked_recursive_removal()
      binfmt_misc: switch to locked_recursive_removal()
      pstore: switch to locked_recursive_removal()
      fuse_ctl: use simple_recursive_removal()
      kill binderfs_remove_file()
      functionfs, gadgetfs: use simple_recursive_removal()

Diffstat:
 arch/powerpc/platforms/cell/spufs/inode.c | 49 ++++++-------------------------
 drivers/android/binder.c                  |  2 +-
 drivers/android/binder_internal.h         |  2 --
 drivers/android/binderfs.c                | 15 ----------
 drivers/usb/gadget/function/f_fs.c        |  3 +-
 drivers/usb/gadget/legacy/inode.c         |  7 +----
 fs/binfmt_misc.c                          | 40 +------------------------
 fs/fuse/control.c                         | 30 ++++++++-----------
 fs/fuse/fuse_i.h                          |  6 ----
 fs/libfs.c                                | 29 +++++++++++++-----
 fs/pstore/inode.c                         |  3 +-
 include/linux/fs.h                        |  2 ++
 12 files changed, 50 insertions(+), 138 deletions(-)

