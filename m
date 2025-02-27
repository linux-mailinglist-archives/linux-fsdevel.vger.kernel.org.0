Return-Path: <linux-fsdevel+bounces-42748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264FA47C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 12:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246D17A2E05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216222CBE3;
	Thu, 27 Feb 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHmsJEzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DB2253A8;
	Thu, 27 Feb 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656112; cv=none; b=cGpdqXDxO7iuNotKuUNI7PtE7Gju5Z0y8WsMSR6qhVOOLbDW3noQTVB3Th3/10ApOKLsS9TCp4IDqM/hwxs5b1neBn8iJoJMrzP6WwLdRi5jSt2IkMq9XanlT5/4ev60/LFVSu7/xYLMgoz4D+g44rpxgTSePkV/hBEQmtSbdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656112; c=relaxed/simple;
	bh=f2zhIojI4Naq7mtH4LGVxFe7wqMNQCsUSDGEZbYfv3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXrzBsrcVH8Wf3HNh2KDSKL/7c7ruz7KO+llNipbbfqbcCFG/SzCmNpz+QqCGL1uNuTXHRbbwN6si/4WtqKAYqu7ZRaNHJjU4utlLxLQDPAid2DKxUBar7T/FKl+FP0NzNCm2Bfc4rXdOtiz1v1hPh/83I5b0jbAPTZOjh3iZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHmsJEzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39177C4CEE4;
	Thu, 27 Feb 2025 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740656111;
	bh=f2zhIojI4Naq7mtH4LGVxFe7wqMNQCsUSDGEZbYfv3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHmsJEzQeJeJG7tScJcX1VhaWytUO0RRE7k2SlPy+jtF8TOIoFRVsk6d/cBdEiLZs
	 DofoE9H61qcheY32zoZdi0bcy+yXFYT035Xx3r/n2hZYeyW0vSKLwrGLihaDOWpZuD
	 EBakHOUwTR3K4bgTDlm/ydk/qBBIj1JNOasqhLfmfO0uJfjDhxrLEzEd6fixlKujRV
	 T+8pvVGnaQqr+loSkdvR2vyKWj4HQ7ykfTazivD3118mHJdL6nlEPX/n0AODsZ9YLl
	 t6yt07oSLhHbjs/QIBcIyvB0upxV2VUN9Fx794u66B4mAxPS0nMeNvJ8OrqXT9l0/X
	 +gHgoXuBVpRQg==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
Date: Thu, 27 Feb 2025 12:34:53 +0100
Message-ID: <20250227-narzissen-haifisch-2bf97aeb50d8@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227013949.536172-2-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de> <20250227013949.536172-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=brauner@kernel.org; h=from:subject:message-id; bh=f2zhIojI4Naq7mtH4LGVxFe7wqMNQCsUSDGEZbYfv3E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf8H36MVdGktGBUeTtOpUDH6Z3nzud3NchrNJcaKAe5 ZFgJ7W+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKvVzP8T0rZ+3L6lG+Sa0r7 t+/ewD2DjzHD5ceFDoeNC1dZSxxTW8Dwm+2dn6h/yOv5e9L3xmv6XD0d7HZuWQZfgadE7vqXKze lcwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 12:32:53 +1100, NeilBrown wrote:
> Some filesystems, such as NFS, cifs, ceph, and fuse, do not have
> complete control of sequencing on the actual filesystem (e.g.  on a
> different server) and may find that the inode created for a mkdir
> request already exists in the icache and dcache by the time the mkdir
> request returns.  For example, if the filesystem is mounted twice the
> directory could be visible on the other mount before it is on the
> original mount, and a pair of name_to_handle_at(), open_by_handle_at()
> calls could instantiate the directory inode with an IS_ROOT() dentry
> before the first mkdir returns.
> 
> [...]

Applied to the vfs-6.15.async.dir branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.async.dir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.async.dir

[1/6] Change inode_operations.mkdir to return struct dentry *
      https://git.kernel.org/vfs/vfs/c/10a5b48c3eeb
[2/6] hostfs: store inode in dentry after mkdir if possible.
      https://git.kernel.org/vfs/vfs/c/28d16ecaa2a8
[3/6] ceph: return the correct dentry on mkdir
      https://git.kernel.org/vfs/vfs/c/948ec6393e44
[4/6] fuse: return correct dentry for ->mkdir
      https://git.kernel.org/vfs/vfs/c/ef04f867aeb2
[5/6] nfs: change mkdir inode_operation to return alternate dentry if needed.
      https://git.kernel.org/vfs/vfs/c/5ca75f993a4a
[6/6] VFS: Change vfs_mkdir() to return the dentry.
      https://git.kernel.org/vfs/vfs/c/9cdf09f608d0

