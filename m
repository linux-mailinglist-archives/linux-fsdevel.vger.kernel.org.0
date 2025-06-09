Return-Path: <linux-fsdevel+bounces-50969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839BBAD1843
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5573A8244
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A427FB2B;
	Mon,  9 Jun 2025 05:20:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892E126BF1
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446446; cv=none; b=cpUDYNOP0K4JdjaaOx/Yo/cktd5QXXWoK2z9ccDXP2zcmQEKLHYeCdVlKm2jR/saoF+eb+1NW84Z+W59CT7893oGzm996EauRnef3n4i+7WglBIfkNC8wuq8ZKAWteOU9IVM0Hg9Xzmlb2U3KUR9yZ7PFteBBICJfVO/UGiMifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446446; c=relaxed/simple;
	bh=1S40FcnY8mua5zV7YHqbq5YamHJy5jy+SY2iWXa1RoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh9Qb7yVZWRlS3z1VJegN/LjvP7vthwJc9xtKkDEuYJ/z8+0a4Ds3dJYNn2h9bJw1sB/IWFoSD3f7nY+NeTRuw0RUvAmRiAzjqSzi+VdRFNvFmmCqwcK8MHlYBs1tn5ZNEz56ghMdUMnOjlo0TOk15iX+A22A2JgeEIxDcCWEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uOUw4-006ApA-8a;
	Mon, 09 Jun 2025 05:20:40 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5 RFC] VFS: introduce new APIs to be used for directory locking
Date: Mon,  9 Jun 2025 15:01:12 +1000
Message-ID: <20250609051419.106580-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following 5 patches, which may depend on some of the earlier patches
I have sent, introduce new interfaces for requesting name-based
operations on directories (create, remove, rename).  They generally
combine the lookup and the lock operations and return a dentry which is
"locked".

Currently a dentry is always locked by locking the parent directory.
Once all clients are converted to use these interfaces we will be free to
change the details of the locking.  My proposal is to lock just the
relevant dentrys in a manner somewhat similar to the way that
d_in_lookup() dentrys are currently locked.

After the intended operation is completed (or aborted) the dentry is
unlocked with dentry_unlock().  This currently unlocks the parent
directory and dputs the dentry.  It is because the unlock is given just
the dentry, that one of my earlier patches changed vfs_mkdir() to drop
the lock when it consumes the dentry without replacing it (i.e.  in case
of error).  In that case there is nothing to pass to dentry_unlock().

I have a follow-on set of patches which change various parts of the
kernel to use these APIs instead of directly locking the parent.
They cover smb/server, nfsd, cachefiles, debugfs, binderfs, binfmt_misc,
kernel/bpf, devpts, fuse, infiniband.../qib_fs, ipc/mqueue, fs/proc,
s390/hypfs, security, sunrpc/rpc_pipe, xfs, tracefs.  overlayfs needs
some rearrangement of locking before it can be converted - that is on my
short-list of tasks.  I don't plan on a full submission of these APIs
until that is completed, in case I find a need for changes.


Thanks,
NeilBrown


 [PATCH 1/5] VFS: introduce lookup_and_lock() and friends
 [PATCH 2/5] VFS/btrfs: add lookup_and_lock_killable()
 [PATCH 3/5] VFS: change old_dir and new_dir in struct renamedata to
 [PATCH 4/5] VFS: add lookup_and_lock_rename()
 [PATCH 5/5] VFS: introduce lock_and_check_dentry()

