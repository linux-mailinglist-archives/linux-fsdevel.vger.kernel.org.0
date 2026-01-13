Return-Path: <linux-fsdevel+bounces-73425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03ED18EA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6350C3103737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B038F941;
	Tue, 13 Jan 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppz3sDaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3792BEFF1;
	Tue, 13 Jan 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308000; cv=none; b=ZBk5zj6fBp9CwCAPpRQX0YX8out4OahN/8BFvZ1f5d+zEsLqVBbFOybYrN1NTWF7nV8p7VWzJb0sfmOCRUuTfunr5oxkipPLvekYNoC2qVG9/YS3MWAINJOY5yXS1eNwgkQvE7Ah583JpZanw9p/JOCtSL6JXFnypytVCIbPXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308000; c=relaxed/simple;
	bh=xWoBSdW0O5D/CecARft63tZx73gkTbnOeqBAQ0roan0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0BJOvR8dPZMKplRrmHWj9jJz7tEuNiLtVeeNV9eUJITs5OryFn7MacxQuaTmsyzzzxAiR2c/YQjKbQkjg1IhSj2AbV0lk7PEDAX+s+P3Eik3QLqFJwGfzOfIWu9LQ+bnudiQC0+bp+jt212T+tE+QH6FvRewDhm8+Q3i+O9H0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppz3sDaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E0C16AAE;
	Tue, 13 Jan 2026 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768308000;
	bh=xWoBSdW0O5D/CecARft63tZx73gkTbnOeqBAQ0roan0=;
	h=From:To:Cc:Subject:Date:From;
	b=ppz3sDaXyPKnP0f7cdKZv3E1dYy2Er3m7Ijpj10RQDcY7U5dGudKdG8djW1g4IFuK
	 j/7yxJ3ClqLkhM4jbGwd67fDVmWlJ8zjogA748KFrh7tX8Ngu+QFmriTisvH3yL5Vs
	 6GL+OOEq6Sw3A/tmuvlDp4500BXjtYblJsUQfNrQftx6Pk3z0Cd+HLWCtRtoD7oOjj
	 NrAsGfEQ0xLPPHnly+isCVOCUDUeJgMQjtfUsRm6YjMtnuf4sQwUlp17nJOoRKUjuG
	 PoLuQXLdtBHSwvMLLTX0w3NIBwUY4K8yFNjGEVflRkqVyUeoAXJpIBwnUOXQPUbbjd
	 Ph4IKGhUVIHxQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	dsterba@suse.com,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 0/4] btrfs: stop duplicating VFS code for subvolume/snapshot dentry
Date: Tue, 13 Jan 2026 12:39:49 +0000
Message-ID: <cover.1768307858.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs has copies of two unexported functions from fs/namei.c
used in the snapshot/subvolume creation and deletion. This patchset
exports those functions and makes btrfs use them, to avoid duplication
and the burden of keeping the copies up to date.

V2: Updated changelog of patch 4/4 to mention the btrfs copy misses a
    call to audit_inode_child().

Link to V1: https://lore.kernel.org/linux-btrfs/cover.1767801889.git.fdmanana@suse.com/

Filipe Manana (4):
  fs: export may_delete() as may_delete_dentry()
  fs: export may_create() as may_create_dentry()
  btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
  btrfs: use may_create_dentry() in btrfs_mksubvol()

 fs/btrfs/ioctl.c   | 73 ++--------------------------------------------
 fs/namei.c         | 36 ++++++++++++-----------
 include/linux/fs.h |  5 ++++
 3 files changed, 26 insertions(+), 88 deletions(-)

-- 
2.47.2


