Return-Path: <linux-fsdevel+bounces-31006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A24990B8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FA01F20B64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393271E04A4;
	Fri,  4 Oct 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD7zopPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910021E048D;
	Fri,  4 Oct 2024 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065998; cv=none; b=kqYlDlSdcuSMuL66vINCmJEHhfxBIrYkjuJaxU+PYWo7xeJue6h0sB/KRrlAHWS3APc7URjvFVYHZGorDRhy5NUJ9o6cgY/aYYmhRJMpmhDZ3yiDNzpSVxjss3zXP7CwJzL89xkHtvcpMNYNoGEEGw+XF+F4IYhs3Q1HzHzrsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065998; c=relaxed/simple;
	bh=OgZcPiJjXp28Hdtxv0Yvuh/VMCkLoVUraVFp1OhTY6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9Mj6nzVnaYNkTgOg5UELTZiTmmcfvjlU8OObKjnN7awU5geuzclOIVvkw+9K/A7/3xxH8yeOmhutaj2qdCsCVNqp7EUI4JxwfzyWO+Na78JCANUhgVRFtGCvzJGFhBCnKwnOTN/0coNhluLby8bIym3wEiVIMNf4Le2oI3yN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD7zopPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6671C4CECE;
	Fri,  4 Oct 2024 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065998;
	bh=OgZcPiJjXp28Hdtxv0Yvuh/VMCkLoVUraVFp1OhTY6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sD7zopPLsnGQBoXP//HZQRp7on4ajVv1lHujojE5axYAf1gkHCH0aMbHgU1pna7fD
	 RQ4WEPk5h1XllqPbryBPrX/3E4AJh4P31WeRpjWfy+xHlx3zarX3nFftHFf3l+YK/8
	 WFW6D5erNpJreu6GcFWN0B6ODc3B9oKdSjz57AnTOMwVl9q38W4webHlWkBilGDRto
	 RHxDLeFAPCJAzvqZyHsWaZUfpuJvIyfBl33PaBKp1i6ENcwgc+auS09+gzRrG15Twj
	 Sfg9EXtV+B+gDw55N8Pw9/rc5oG348uRarkbnKqVUf07BKZV0LxiV42sK/tCJiuOsM
	 ggetr+SjXZstw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 48/76] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
Date: Fri,  4 Oct 2024 14:17:05 -0400
Message-ID: <20241004181828.3669209-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit efad7153bf93db8565128f7567aab1d23e221098 ]

Only f_path is used from backing files registered with
FUSE_DEV_IOC_BACKING_OPEN, so it makes sense to allow O_PATH descriptors.

O_PATH files have an empty f_op, so don't check read_iter/write_iter.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/passthrough.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 9666d13884ce5..62aee8289d110 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -228,16 +228,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (map->flags || map->padding)
 		goto out;
 
-	file = fget(map->fd);
+	file = fget_raw(map->fd);
 	res = -EBADF;
 	if (!file)
 		goto out;
 
-	res = -EOPNOTSUPP;
-	if (!file->f_op->read_iter || !file->f_op->write_iter)
-		goto out_fput;
-
 	backing_sb = file_inode(file)->i_sb;
+	pr_info("%s: %x:%pD %i\n", __func__, backing_sb->s_dev, file, backing_sb->s_stack_depth);
 	res = -ELOOP;
 	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
 		goto out_fput;
-- 
2.43.0


