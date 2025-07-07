Return-Path: <linux-fsdevel+bounces-54098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47896AFB319
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5426C7AA47D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A229AB1B;
	Mon,  7 Jul 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISSpJg5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0C28934F;
	Mon,  7 Jul 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890821; cv=none; b=PkHMyvJjb9spwbc+EpUPHV5u90DG2dia4fWcpbAzx/oeA5u+QS1RgrGiItoq7SqTLQa2XxPP+y6uEq96VQLdd56xHWuMDBXu/pAmWJcyCKGvUIj4NTPp9Wuzb7q3zE+q6xbcikz9b70S/Zg8ID3t5AQlYscFzm4roz5jRP8tGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890821; c=relaxed/simple;
	bh=YBKnvsjqKJkgQxIJi5eKkQo8SmEOvYc5/hH8xPlHkgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwztDkIxZyAKMedIK8c+hYlGw7MHXXGh4OMzxDNGd4z9ijWiGMqalXE/tDVXeIKZSG/Eg5SPUyCcCzNu2CMcxfPvjPVHBRWJx3N7XtKoevp3IREUuJJQApHIgzc+hYdHIYGciUetX7OBTO6tEU3HdNN2CP4Y5fzNVU1N0f9AAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISSpJg5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A5C4CEE3;
	Mon,  7 Jul 2025 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751890821;
	bh=YBKnvsjqKJkgQxIJi5eKkQo8SmEOvYc5/hH8xPlHkgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISSpJg5tlIzsSQsXQ8gX3Z1nW/kI83ld12R3trjiBTEvZlkLBULRmS4ElLfRkIGZI
	 77BHSwBWpoDAOjvS549BQSs8enR+mLVy7drR3E3Sy3EJASC/YgffCxD2tlNKsJCI4E
	 fNMhrx5lVqWhNXRXt9VrJ+cNFTaIr31YhrPITqhEGBaV0shuByqQ5OQmrf6UJTtfBP
	 7N1aztRv/uVOotY4ed7hTqaUtr401AtyJnwBTob4H45W+DgFne3Dnw7Fzk+7eiszOq
	 vgGsvOv3Zpiwxtzr/dnKgttYGwKHdciSaFY+SurJNeqKfCGLupc7eCiBO52xFU0op/
	 GCsWIeJEWfzJw==
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr syscalls
Date: Mon,  7 Jul 2025 14:19:54 +0200
Message-ID: <20250707-anfangen-pinkfarben-3914040c54d2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=brauner@kernel.org; h=from:subject:message-id; bh=YBKnvsjqKJkgQxIJi5eKkQo8SmEOvYc5/hH8xPlHkgM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRk767VackvMBVov+oSVXSl8irnyojP7NkGzdcYDtxv+ 8Cr/kqxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJhJxkZjulu0yp7xGaz9XhE xwHjsCvPZ0tVhMwp6Wu3b73PkHdbnJFhf5HzdNGAd4evWt2v45yU/aj9paK1bOf98zdSyrfXxon zAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Jun 2025 18:20:10 +0200, Andrey Albershteyn wrote:
> This patchset introduced two new syscalls file_getattr() and
> file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> except they use *at() semantics. Therefore, there's no need to open the
> file to get a fd.
> 
> These syscalls allow userspace to set filesystem inode attributes on
> special files. One of the usage examples is XFS quota projects.
> 
> [...]

Applied to the vfs-6.17.fileattr branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.fileattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.fileattr

[1/6] fs: split fileattr related helpers into separate file
      https://git.kernel.org/vfs/vfs/c/2f952c9e8fe1
[2/6] lsm: introduce new hooks for setting/getting inode fsxattr
      https://git.kernel.org/vfs/vfs/c/defdd02d783c
[3/6] selinux: implement inode_file_[g|s]etattr hooks
      https://git.kernel.org/vfs/vfs/c/bd14e462bb52
[4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
      https://git.kernel.org/vfs/vfs/c/474b155adf39
[5/6] fs: prepare for extending file_get/setattr()
      https://git.kernel.org/vfs/vfs/c/276e136bff7e
[6/6] fs: introduce file_getattr and file_setattr syscalls
      https://git.kernel.org/vfs/vfs/c/be7efb2d20d6

