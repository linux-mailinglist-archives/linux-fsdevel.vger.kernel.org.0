Return-Path: <linux-fsdevel+bounces-66038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC386C17AB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C71C82B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C42D6E52;
	Wed, 29 Oct 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekPVmDRI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A72773E5;
	Wed, 29 Oct 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699261; cv=none; b=IdD0w9QaGf+567f9K0NV/tZcPn4fJUvzqjQ6FPxLxmzI1gvWAKm6i/wXDUqdgozTorEcuryAM4hgPCFfsTMjl54X84s6wk3E8Rpr5Z9syWoBlQcGmmi8Go/FayxqXiY2aBC08R4r3llBu9kxZgBooxQdoQuGME6h0Dt0zNVkzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699261; c=relaxed/simple;
	bh=hZZ0Nqf3pc2crIGZaHibR4tu96NpNUTg1wVtR82zV8o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGa60TS4vfVwF/ed6nGJPpRklRyuEesF0pqmRAn833s9Qb9Bkvu0itzerwn7su+sfcbqdmWFa7guzUXpg4N9TK0ZQc8gekxYf8fZGSavuR9dKNt3NyF805wXhIAX8KhHAJO+pEHUi6v8E4LzM+T0Cra6DdQ4NtZuZgsbU+NiJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekPVmDRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB616C4CEE7;
	Wed, 29 Oct 2025 00:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699260;
	bh=hZZ0Nqf3pc2crIGZaHibR4tu96NpNUTg1wVtR82zV8o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ekPVmDRIJbhx6FpEK194VhKbPz8ZuBq6ZJY4cq6jXzwGyTacJprjR00yr/4LGUu7s
	 /WrqkFscl7ZJwK66CMvtO6Vf+OZEc3ql+QrgLlmAFhfw9epTC5SX1E1+SYL6VrMwOq
	 2AzHJcGTROr4jk8wGENxcn3MqDH1Oqq/PFx6/sjVlrnxK5WK8FpxsgxVp3qrA7jM7i
	 fzvOenARTkWuxN5Nt6xfuncnKeSzFc007UUyQ+AJoI/joHcTbnmFatX4JTdAFBbJGP
	 UqA8P0BvV6l13aj1UFpvccJxKbBN6Z/pqtcKAQb/QGqFfHcQq4yfvkJpZ85yH3dQqD
	 lLSc3rUpph1CA==
Date: Tue, 28 Oct 2025 17:54:20 -0700
Subject: [PATCH 2/9] fuse: force a ctime update after a fileattr_set call when
 in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811634.1426244.16405162731946583369.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
References: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the kernel is in charge of driving ctime updates to
the fuse server and ignores updates coming from the fuse server.
Therefore, when someone calls fileattr_set to change file attributes, we
must force a ctime update.

Found by generic/277.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/ioctl.c |   11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f7474..07529db21fb781 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -546,8 +546,13 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 	struct fuse_file *ff;
 	unsigned int flags = fa->flags;
 	struct fsxattr xfa;
+	struct file_kattr old_ma = { };
+	bool is_wb = (fuse_get_cache_mask(inode) & STATX_CTIME);
 	int err;
 
+	if (is_wb)
+		vfs_fileattr_get(dentry, &old_ma);
+
 	ff = fuse_priv_ioctl_prepare(inode);
 	if (IS_ERR(ff))
 		return PTR_ERR(ff);
@@ -571,6 +576,12 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
+	/*
+	 * If we cache ctime updates and the fileattr changed, then force a
+	 * ctime update.
+	 */
+	if (is_wb && memcmp(&old_ma, fa, sizeof(old_ma)))
+		fuse_update_ctime(inode);
 
 	return err;
 }


