Return-Path: <linux-fsdevel+bounces-42846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640EBA499AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD9C188E4DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261E26BDBD;
	Fri, 28 Feb 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLJxcLja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947FA26BD90
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746666; cv=none; b=FYhf6Q5XbwlNmW4vWoFXOipmkRLtfPmZQ92YzgopE5xxG4tdTVem3puRQoKe/n36rvSUXUoeGDTZSZqagQob8NcBeM6Kk4rFEUjD7ny+6upbwyGpzMkbHRArvhtyAnLgsiYF7UKvroHEvBxR0KspO/4QM95TJ+XqEtlpJQT6W3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746666; c=relaxed/simple;
	bh=7KUqPOYmOng7iui1b72coPgfSzMK+HLiiXRRUX6TTUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6BD0RXFKErkwjHX836ELeaE5QvI7xXkqg8kgebgbKgDrqg+HhrbrWdGrXWd5zvH4+Qo99BlcjM+k2wlN2XaLP/Ti7qmRO/JyF+CVAsCwX/BsdTWPRlSof0ExZ6IllZEm7Mh2xIMsnKRW2lA13H000P7nxqBQ2BzNtK3rMueSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLJxcLja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0801C4CED6;
	Fri, 28 Feb 2025 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746666;
	bh=7KUqPOYmOng7iui1b72coPgfSzMK+HLiiXRRUX6TTUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tLJxcLjayCEtOZ43mmd0n93aQ5Mz+vh58nFf9KjQ5eVFP9BguuAMZbtu27sirXdo1
	 eZFILNOF79AvGP9DF2oCQ/pjIEnpUIoDt0fgp4lfNDDXK2YzEooSbrWmna12ra9LrN
	 +wya69sif2It4Jjy2lcGk795T+LX///Tj140EAKQQ8hLPkSbWLFwAXvVdXt5tpIj6I
	 JPaocS5Z+BJggfs9GnN7jQW90RU03p2t7dgdHsn8So+363CyIfRGcVtK3X1RQVbVV2
	 oPDGbuPB3/1SFSBmykOPQdAHNp2BY+4yVf3c78hD5qtYqH+7fNkiSWvKepu1B84vZ7
	 rK0ZGRXC8yKNw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:03 +0100
Subject: [PATCH RFC 03/10] pidfs: move setting flags into
 pidfs_alloc_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-3-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7KUqPOYmOng7iui1b72coPgfSzMK+HLiiXRRUX6TTUA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/o3e9wvqUGgnWdobJZdw+/utV9NnvPJIWncZ8F4
 hnaP2vd6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI+VlGhrVtrVIHJVc9Pnx8
 r+LWB1GNC11lVMLehc2+YPD/nWz1H3FGhkvZ61LzKvy51abEqk04nzHx+IMHP5Zv+PhU+Zj4E/+
 7jXwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Instead od adding it into __pidfd_prepare() place it where the actual
file allocation happens and update the outdated comment.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c    | 4 ++++
 kernel/fork.c | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index aa8c8bda8c8f..61be98f7ad0b 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -696,6 +696,10 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 		return ERR_PTR(ret);
 
 	pidfd_file = dentry_open(&path, flags, current_cred());
+	/* Raise PIDFD_THREAD explicitly as dentry_open() strips it. */
+	if (!IS_ERR(pidfd_file))
+		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
+
 	path_put(&path);
 	return pidfd_file;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 6230f5256bc5..8eac9cd3385b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2042,11 +2042,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 	if (IS_ERR(pidfd_file))
 		return PTR_ERR(pidfd_file);
 
-	/*
-	 * anon_inode_getfile() ignores everything outside of the
-	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
-	 */
-	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
 	*ret = pidfd_file;
 	return take_fd(pidfd);
 }

-- 
2.47.2


