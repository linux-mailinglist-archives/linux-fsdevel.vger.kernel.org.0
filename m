Return-Path: <linux-fsdevel+bounces-47496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0916A9EB2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69567189C324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741125EF8A;
	Mon, 28 Apr 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+eWZCic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399C1FF603;
	Mon, 28 Apr 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830423; cv=none; b=YIaQZOGhkkhv/DZ+8yIx0REpA5MXlPyMPQPZFIkC6eSETmBB2qMHkXeLaRnQyFWYfJUGfDGUSAQP6W3DfCrtUXOj0JO02BH8EuQ5+8BU5eu3zOhSIqAQaQ339X/JLHbz07/h/XPpc0EdyhbefYPmX+OvS0bSbazi1Y33A+27hzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830423; c=relaxed/simple;
	bh=QwVhdKsroLTp3FXZMREUKf/LpAJC0pz0HM4iDFUkBQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBs0sbxZ0zOcnRf2GkIO3Ixj2NAplg9v6mguct008MK3Pr3M12ycYRZKekJNMYG/0ssrsIKEgsSNVaQHORzr9cRwITgLKiNFCVjVoIgLbEwzTPho0jxb0o6Y+aPr9xVfq4UOKwZBRqzwh96lK3T096WInsczBBn7n7eYPL2ttok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+eWZCic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D10C4CEE4;
	Mon, 28 Apr 2025 08:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830422;
	bh=QwVhdKsroLTp3FXZMREUKf/LpAJC0pz0HM4iDFUkBQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+eWZCicC0F8jF170nW3k/LltqhThvrzCacDuQAaI9RbyXViJBAN3A3/eYFSk2mqb
	 E+E36JuRb3gEmplT2s9If1GIQ3aK4eCJvvO8jwE5jssRMKXHWi93WTytnsYDIcSURS
	 +kqgiyw7fBHeNFqRxEoKZdyag3JMqMcfN4JiD7ltJjQM/A1HeRRIM3KY2V8ZSZkOrd
	 Hjib4ufXzVN8pu85TsaECDZWJEUGO+yEyz89aGIZGJbv7+7jpsdJr2qDoHu8oXkDOy
	 3SDNU8eYQfF8M4ZUtXMLjO0W0vZPSUoNGlIqDrLz9JK/fB1GAm5tN447qbyZ+JmvS4
	 QZV52S5CZIT5Q==
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	paul@paul-moore.com,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include security.* xattrs
Date: Mon, 28 Apr 2025 10:53:33 +0200
Message-ID: <20250428-vermummen-klumpen-2131561ba55f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=brauner@kernel.org; h=from:subject:message-id; bh=QwVhdKsroLTp3FXZMREUKf/LpAJC0pz0HM4iDFUkBQI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTwOwnYdxvzmkzVmuz7/Za/jt/BV6+qf/1u8tOQ+vshm befryS3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIr5RgZPpbv94k5lDpvWW3j /rPHA0r31m7amD9vYdL1yLmv93gx5DAyrGb/0nn+2UaJwGtdVvfS/KbW7DWa7LO5Re3MRoWrdfW NbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 24 Apr 2025 11:28:20 -0400, Stephen Smalley wrote:
> The vfs has long had a fallback to obtain the security.* xattrs from the
> LSM when the filesystem does not implement its own listxattr, but
> shmem/tmpfs and kernfs later gained their own xattr handlers to support
> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> filesystems like sysfs no longer return the synthetic security.* xattr
> names via listxattr unless they are explicitly set by userspace or
> initially set upon inode creation after policy load. coreutils has
> recently switched from unconditionally invoking getxattr for security.*
> for ls -Z via libselinux to only doing so if listxattr returns the xattr
> name, breaking ls -Z of such inodes.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/xattr.c: fix simple_xattr_list to always include security.* xattrs
      https://git.kernel.org/vfs/vfs/c/8b0ba61df5a1

