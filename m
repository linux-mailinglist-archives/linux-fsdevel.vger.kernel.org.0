Return-Path: <linux-fsdevel+bounces-31009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459F990C84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FB41C2286C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F221F8EF3;
	Fri,  4 Oct 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIDOJ9EX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0521D2B5;
	Fri,  4 Oct 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066206; cv=none; b=Rn6Z7iXZU+jvPkhi8NmoyOn22K/h5Ga6fK6wt48XF+eKfV7w0D+CniGsSv1Un5qRVE/c4gscsMe3JayULgc0xsBV/2Qro4mwbuuenLctfb/KaCpm0w68XO/hFHd2ZqCiEezG/sQLSRZL18rPrNP/97x9mTpLKiZxdJGkWcpxS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066206; c=relaxed/simple;
	bh=OgZcPiJjXp28Hdtxv0Yvuh/VMCkLoVUraVFp1OhTY6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP2uGympdl8dkDldcQfcbEkk9Fm6K616i5ZF+0xki+5cKtSwrM0doZTXesGhAXD8jIiNpE3rSHkSC9pz3qoN6ofAyXHf7Wz6a+XBQ4pK0sUf25owMUcDkYN5VQ1fH0rMV3P5RGKUudhlfZxj2iTDvbSedm9wUpTXbU2Ximu8Puk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIDOJ9EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0613DC4CECE;
	Fri,  4 Oct 2024 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066205;
	bh=OgZcPiJjXp28Hdtxv0Yvuh/VMCkLoVUraVFp1OhTY6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIDOJ9EXQS2BA4eyA1iPY7TjWWynVWX0Ts87+JHABc048H0kFqVdzYuF09XJzMbqj
	 PVDuVErGak78gcJJsG2El8shhMjLppMSRI2HfavZTFsBq8/6GdqfcXFa13mtVCMD1O
	 ndpY4UQG20oGg9hcBSF3yD9vU4xDmk31uf4xQHyEYcRBu5cLderOBX7KY09Uk/cUNo
	 TBLTvo8lGKLS/qxxrABKbSQ9JW0fRDubIP50WWCEzYVZSzFZug2w5owP52OxlUPkv8
	 gmXpR68/QWfmLWmpvvVyeVAsGkLRHlYh5MyaTE98ZyQ4fHz03isGQT0mwlIj79exZN
	 adRF42D+XGNPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 44/70] fuse: allow O_PATH fd for FUSE_DEV_IOC_BACKING_OPEN
Date: Fri,  4 Oct 2024 14:20:42 -0400
Message-ID: <20241004182200.3670903-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


