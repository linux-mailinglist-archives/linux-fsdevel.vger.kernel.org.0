Return-Path: <linux-fsdevel+bounces-31010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D919990C88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E461281250
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E5A1F8F12;
	Fri,  4 Oct 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poVf2spD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310411F8EFB;
	Fri,  4 Oct 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066207; cv=none; b=thf4lIM9shFHhCVEBXtpbKWmQbgi7BufQxKYcmpO2Zau+akTi5w8mFtRPCwHg0HnojJBGNUBbTn8ZwBPyEOzQQyBxvzRm6y0UoSMVstHV7uCqlSEtNpVi+JWCeRY0KXXxw0ROW8yBh21qKhshMGNggUThR5bxruOM1gyAMY1/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066207; c=relaxed/simple;
	bh=YoqFwxCZRS6kKCe5T4DEAb+221PIKrG/75SqrvibgEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXA9kEgy5XE3cP7J80fyN3TBMpJzbyH/nFi5nBmBcLXhaOH/3Z53ROoFLZ6/EAqiUZGJp9FbDeh4+yhPMIipcwNAKkM+Y3Eks+SpkUDfUDzdk5NbArU6T98ME3AmFMej7woC1jeU/NJ2nLZ44cs+5eK/mJ9IMYvDLtDl42soPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poVf2spD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47815C4CECC;
	Fri,  4 Oct 2024 18:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066207;
	bh=YoqFwxCZRS6kKCe5T4DEAb+221PIKrG/75SqrvibgEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poVf2spDZd/TZJCR2MGxT0SOqExXMN6ZyakLwRWJpIcMzfzObOnUfGZEk2W5ierkS
	 R2d4GM3/bgWIbnI1knfLCF1HEfqenqOsPuOpSoSJIiyo6x/ZfTmyu1hftp1BcNATlo
	 bwNxizzx77HdNo21Yoj9PsA4QjkuMui8WVo8KqIGdS7et7B36xwR9b48I136mFlTYc
	 LIrIi4lOfX/fzmrL/Q1BlPFRNLbTItdxnXhGxoHyTgbNwWXyQDLycsBw/IUdcnGNry
	 NAOsSV+nCWk+bgp5YZE3D/QRi9lQjflQgBQBWbBz/jzzS/Pl64BwpysKSSsOXubRew
	 GkRX979kFNqCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 45/70] fuse: handle idmappings properly in ->write_iter()
Date: Fri,  4 Oct 2024 14:20:43 -0400
Message-ID: <20241004182200.3670903-45-sashal@kernel.org>
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

[ Upstream commit 5b8ca5a54cb89ab07b0389f50e038e533cdfdd86 ]

This is needed to properly clear suid/sgid.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ed76121f73f2e..536194d41b0b7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1398,6 +1398,7 @@ static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct address_space *mapping = file->f_mapping;
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
@@ -1412,7 +1413,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    setattr_should_drop_suidgid(&nop_mnt_idmap,
+		    setattr_should_drop_suidgid(idmap,
 						file_inode(file))) {
 			goto writethrough;
 		}
-- 
2.43.0


