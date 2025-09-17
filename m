Return-Path: <linux-fsdevel+bounces-62041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA50EB8244A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D7E1C230A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687C3126CC;
	Wed, 17 Sep 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WhCNIFG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4B31159B;
	Wed, 17 Sep 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151462; cv=none; b=ezEgcgK0QaM/oSk4BXyEoniM7oBxdCbs1lehpY6GrF2i0egu9KzKcgQ01j4LCRAiasC+j/eFmTPlszVlTcgmTmsaV+GZLIpOWjPMObVu/SOGjVDcNpNv/xAqr4WkLTQEbesYKz9Cksx6yl27kwgKTZJO0AHjkkbV8yfys9Gns/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151462; c=relaxed/simple;
	bh=YM3yM4l9IIzBxjoiCEQJhj1kpanbeywCkOJ4RX/KfrI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H2Yrnx3GQ3StqgmPAcZSSJo+TI0bjjE+UmWnFCpVsu90dvc7FPd8mrUaJeW14OuM1IXmSnNY93vY2LSjkw4cBo5cDCqoGcA4CMdBRTHY1jiI01NtzwvHDd6OttbVZBnfwwIZXX1/FVq16mwe1paPpRXuwUr5Jp7Aqn682eoIVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WhCNIFG6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jWilkYe7g21NIHIHAtbQPOEBltqSw+Y7j7Ah85sQBEo=; b=WhCNIFG6FNRWmjjbeIaAlRSize
	mEFtXr7zYgvhFggUgkafFM+7xHnRnQR4kG6idh0a3dmfKUwH1sYNGPkw5PUD7AFfrGeoVbwnUQzst
	Vucg+04hBpZh1AZPlNFqmetqW5aO/lhTX+NwGg4b/9X/Rd1fqDFQC7XzaWpeeJN2Fox3m6MhNJUH6
	OGVD9LwLtlWL4yqSjU9q+FwHXNyZUpnzCj+ARo2jF6N7cF8fIbyxfQAngVcIpgPG+3aS1HuRPSOPb
	EAJ0/wFMmd7fzqDa8VynOWqsi37TJ5Xz/FUPy/5hMghpf6hGGZ/wQzYrgeyp0VMf70N4I/MNej30R
	vII67SEQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1VY-0000000AhYr-2WSg;
	Wed, 17 Sep 2025 23:24:16 +0000
Date: Thu, 18 Sep 2025 00:24:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev, Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-nfs@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
	linux-cifs@vger.kernel.org
Subject: [PATCHES] finish_no_open() calling conventions change
Message-ID: <20250917232416.GG39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	finish_no_open() dentry argument has the same conventions as
->lookup() return value - NULL for "use the dentry we expected to open",
pointer to dentry - "consume a reference to this preexisting alias".
What it does not accept is the third variant of ->lookup() - ERR_PTR(err).
Making finish_no_open() accept that as well (returning err in that case)
simplifies life in ->atomic_open(), especially since the "got a preexisting
alias" is exactly the case when we end up with a positive dentry.

	Branch (-rc5-based) is in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.finish_no_open
Individual patches in followups.

	Please, review - if there's no objections, to -next it goes.

	Shortlog:
allow finish_no_open(file, ERR_PTR(-E...))
9p: simplify v9fs_vfs_atomic_open()
9p: simplify v9fs_vfs_atomic_open_dotl()
simplify cifs_atomic_open()
simplify vboxsf_dir_atomic_open()
simplify nfs_atomic_open_v23()
simplify fuse_atomic_open()
simplify gfs2_atomic_open()
slightly simplify nfs_atomic_open()

	Diffstat:
 fs/9p/vfs_inode.c      | 34 ++++++++++++----------------------
 fs/9p/vfs_inode_dotl.c | 15 +++++----------
 fs/fuse/dir.c          | 21 +++++++--------------
 fs/gfs2/inode.c        | 26 +++++++++-----------------
 fs/nfs/dir.c           | 18 +++++-------------
 fs/open.c              | 10 ++++++----
 fs/smb/client/dir.c    |  8 +-------
 fs/vboxsf/dir.c        | 25 +++++++++----------------
 8 files changed, 54 insertions(+), 103 deletions(-)

