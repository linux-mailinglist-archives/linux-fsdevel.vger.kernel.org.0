Return-Path: <linux-fsdevel+bounces-48153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C515EAAB2B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D4816D45E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E742F841;
	Tue,  6 May 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rthgZiFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAF36BA45;
	Mon,  5 May 2025 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485808; cv=none; b=rS0+pxereMUe2AJ2xt0cjyxlwqxEmc8qk2jcFLhT2kpiC4y0sSwMjZ7wTc0pFRAHPNk9Fcf7Ez8lS9pPbzcyU5rL8/tuGdlqMjzWP0R8VE1AUspf60aRL3bz82z0n8D6FxhJHWCXSPS0WXqSZo9SVgS8UJcLTi513020+2AIixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485808; c=relaxed/simple;
	bh=jKbrhfN3cVBO9ZegR39O6gjyz0Xw+Su7GEF9S9yudCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Up5HYOJ8wlg9+r2ZtTzxUJl//JTpXuSCsYQeiApgavAj5pUPuKNvdGzwXiYF2Fficg0Kl4aZvFrEys+ehzX0sypFV4PJnTFl5sNN1klZYBLT0FDB4Uh4kWaubkkdPSTQ1wDWcxe5iA50qsWRwVbZ9tk6McxAm90DOIcCNJccBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rthgZiFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED196C4CEF1;
	Mon,  5 May 2025 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485807;
	bh=jKbrhfN3cVBO9ZegR39O6gjyz0Xw+Su7GEF9S9yudCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rthgZiFp90DKL/MTErtGP7+TX8Owh+ASvJOcuoCGi2ZTs9DlMCOTL+BAMEA1gsNPt
	 /Pj89LUqBuVPWZLu0lEtaWeDln72siAtlYWkKsB8GP2Lo2IlCOZT11QixxahDMDwH+
	 TRq7erOTZpvpEF+qYiZ2vHrVMN3T/V3aqAyDSGqWRBhdyl16LXtk/fYNouAxlEMLeP
	 e/RD1uM+syMvI1wniec1GpQT1/Js3O2/SqKi+fOVi2ls7pKaSQVOKt+2X8EE6Yki8y
	 3C0n7tf9hWZRoC5U6JaWOTnBDoGH9XU5IhA5qZa/cAK4mzSvrNaunojymsW+u0tTns
	 j7mIiUMBDZoZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 007/294] fuse: Return EPERM rather than ENOSYS from link()
Date: Mon,  5 May 2025 18:51:47 -0400
Message-Id: <20250505225634.2688578-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Matt Johnston <matt@codeconstruct.com.au>

[ Upstream commit 8344213571b2ac8caf013cfd3b37bc3467c3a893 ]

link() is documented to return EPERM when a filesystem doesn't support
the operation, return that instead.

Link: https://github.com/libfuse/libfuse/issues/925
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e4d6cc0d2332a..82951a535d2d4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1121,6 +1121,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
 
+	if (err == -ENOSYS)
+		err = -EPERM;
 	return err;
 }
 
-- 
2.39.5


