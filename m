Return-Path: <linux-fsdevel+bounces-31007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2F990B8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E3F1C22642
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4831E0DA2;
	Fri,  4 Oct 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF22u5FS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2F1E04BA;
	Fri,  4 Oct 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066000; cv=none; b=OPtDVE3mei+dZxgIAJPyVlAgsvyMNMv3T3q4K8YqQ3ON6VRQoIxiPDL4JVexEYe9pjqd5IHtRwavtbege5t281NSzhssrq7cZRn9YKS1XIGS27ZJlUWO0tUbIk77hjVWOlVjkFNOD9VoF8A0h+pF6TDTu9QklBTeFN9PcW6Welk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066000; c=relaxed/simple;
	bh=YoqFwxCZRS6kKCe5T4DEAb+221PIKrG/75SqrvibgEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBbPfm+wJawpbmbioLA/vtbeCQwKlG4eNpeYma5slc9XzgjsK7rqbSUZksQgewZlMthKu+/PFYv4SQ0jjk4xAl4kl8LWmgMWDC/i1JBPm5ztu08sllgOCKeHZE2DP3wIuuo0LnUuntwI204576SbSdinlo1VsY17zZdAqQ06VPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF22u5FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8311C4CECD;
	Fri,  4 Oct 2024 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065999;
	bh=YoqFwxCZRS6kKCe5T4DEAb+221PIKrG/75SqrvibgEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MF22u5FSiyXFhkXCJdi3k+HzD7JYsXcso2p+kBq23AuFaGNXo5zwOAgyrXf1ekbH2
	 a41asqTiVh/7IE6wDDcQRm88MegmiERqYMD1wTbtZ1mmgKqX3T0vX5pr9v1PYaQQ0t
	 AJ5Qb+iLfGSfJJ7puJoSZPOkljlnMn+pYNy4zMKGqQMLC5fP2GDB1zPHzoM5ff/DwE
	 jpmz8oqYhKZZROA3oRG73XfeI93QEpIs0BLG95zH8Vvfw2NbxbiCb/qU7h3rTQa3aQ
	 oxaeOaWODAFVuZiMVCaC+gn+AFPhNKeyAQf5Ucy++fQS7T11/3LX3vFxoql/kKJaJQ
	 VeQQny9i/j+sA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 49/76] fuse: handle idmappings properly in ->write_iter()
Date: Fri,  4 Oct 2024 14:17:06 -0400
Message-ID: <20241004181828.3669209-49-sashal@kernel.org>
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


