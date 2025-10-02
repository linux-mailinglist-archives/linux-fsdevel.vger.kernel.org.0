Return-Path: <linux-fsdevel+bounces-63209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF30BB292F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 08:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762B64A4C15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833B271443;
	Thu,  2 Oct 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NspRINoO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE0134CB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384952; cv=none; b=l49oyR9NyzR3c87se0deB3YNVC12EoyFZoOiJ+Ks1TiMVgvH0ej9ZvqeQNbercK1F4eKWVkbJLzz1zwSa5Cz/5j+pBjAoslZsVHCJUryoSIPIljzG2jnoUKK042iqkjZfv8tp17OocSreSjuHfqRJhe7UOiQ5McrWUvRE3gm9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384952; c=relaxed/simple;
	bh=rkN9Es3+qcIWRygTOXVkYxtNJHM/6VLl9mEEVC1G0XI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jedK9U4fhMNHYdUk+taJnWlthjeZgVJYJnp1vmU82jwvbb6FzljqynXjs022OF0LbVLyHqJexr8eQka1XRzwwxKFA+PvNgYzc99Kp2QPlMxuqNWYLuKM8/8phHtg7X9w/efLJoHHoc1XSMT/QEKyVkmWQYcoxplLWo8IWPVyVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NspRINoO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yNaAGZOTCRMb18jkLiSKbtcP23VSG68dZDIG6oV0iNU=; b=NspRINoOI9EVkAK8dOOTpisv0H
	tHT4JE3dqEAsX3iWgrBoSlu2rhnpSbzopt5FVnqmSeQAtBRX6pDTEd1+mKEnFaZ2xR1IwTdg3sZaq
	gPjoOVALmSVAN2pHbQQgNx8BU4xXvEVgfoWPhICKFo5ZzUrrjafGE5IDJd3ZxmOKGFEE0kN37yFbV
	/KquEcrhgnwgcCO1ahZOyZpWQ3MtRU+Qpg52J4rHBsu+w0VUaYrk+339Ksv/iyfHNDKFlasxKwZ0g
	qKYAY+WWSUXSFINNIZJGVVjsW7qB6PcJOJga2B9jrcNbKHpOEmwR4Ikf3mnG+wK+JKkr7W9za9U4n
	PlpFc0Xg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4COb-0000000CPpy-07cI;
	Thu, 02 Oct 2025 06:02:29 +0000
Date: Thu, 2 Oct 2025 07:02:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] pile 4: finish_no_open()
Message-ID: <20251002060228.GJ39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-finish_no_open

for you to fetch changes up to 2944ebee9a96c9d2ddb9c9cb99df6105f2de62ff:

  slightly simplify nfs_atomic_open() (2025-09-16 23:59:38 -0400)

----------------------------------------------------------------
finish_no_open calling conventions change

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (9):
      allow finish_no_open(file, ERR_PTR(-E...))
      9p: simplify v9fs_vfs_atomic_open()
      9p: simplify v9fs_vfs_atomic_open_dotl()
      simplify cifs_atomic_open()
      simplify vboxsf_dir_atomic_open()
      simplify nfs_atomic_open_v23()
      simplify fuse_atomic_open()
      simplify gfs2_atomic_open()
      slightly simplify nfs_atomic_open()

 fs/9p/vfs_inode.c      | 34 ++++++++++++----------------------
 fs/9p/vfs_inode_dotl.c | 15 +++++----------
 fs/fuse/dir.c          | 21 +++++++--------------
 fs/gfs2/inode.c        | 26 +++++++++-----------------
 fs/nfs/dir.c           | 18 +++++-------------
 fs/open.c              | 10 ++++++----
 fs/smb/client/dir.c    |  8 +-------
 fs/vboxsf/dir.c        | 25 +++++++++----------------
 8 files changed, 54 insertions(+), 103 deletions(-)

