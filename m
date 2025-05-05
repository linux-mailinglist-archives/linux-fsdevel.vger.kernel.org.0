Return-Path: <linux-fsdevel+bounces-48150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA9AAAF6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 05:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE003A4D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 03:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958F3B3BD8;
	Mon,  5 May 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8dP6+MD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1606396EDE;
	Mon,  5 May 2025 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486397; cv=none; b=rHp8v9lqoDQGut/l/a3XMiNao9e3ivT1Dgy690g77hnHcct6SHbqNWfrotELx8WpEjTHTpee7wGpoo0xGfAcd9LGq2XLeF7dJV7H7NpOC+rPi6S7b2g5R3ozPEHwQiW1W+zJL13gxgTVVhxZVKw7gPTNiQHn2x4G6GM95VifYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486397; c=relaxed/simple;
	bh=m2GFJbyIvE55mB9sL7la2Qs3ZSWL0oLBjNaV/X80mp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9luuiGJxwJW/HHBQRAZODIVUxsYoyDFHSBU3+u5OEdaiDoFrEDQOcwRrY9LYtDSmCd2Zy8hL7H8TJPmJIiK+iBOFuqy4906L6cLNzsl4bLRGyvI8oBDyjzlr2KDYpOT6JjV8JMuUO0dCrBCbEhWjXuOPdtCHC4wHaPzIbZPHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8dP6+MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F5C4CEF1;
	Mon,  5 May 2025 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486395;
	bh=m2GFJbyIvE55mB9sL7la2Qs3ZSWL0oLBjNaV/X80mp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8dP6+MDzZYcqJ+NfokNkVk+kyisLRLlQZn4GHZ4p1ss8aNzwyHYb3BFbCCCqXFfV
	 bKGq9yXQtBlv69Vbt6LYpXmhLWm36DyFRR5XWoot0NqP7z8JkpXJ/OnJGvvQHZu8wi
	 aHDVV8FDnEJIrLqGUtTiLZK17f77uDEM0lXF6DkSctdIc/G2+hAWY/9+9GpJrVq8Kp
	 avj68vOnaOOs2kDFFJMn3FfCOQL2M/VgUKGceoUvDuw9wKZb3DI7y1MHLVt743QTiD
	 QFPkrbB9/1mjGd59SRaW4R3O3JZSWwtnMn9vHOoo7/x96wwlcmGiVyZBzwqvhTGVH1
	 uuqotkUouEcfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 006/212] fuse: Return EPERM rather than ENOSYS from link()
Date: Mon,  5 May 2025 19:02:58 -0400
Message-Id: <20250505230624.2692522-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index c431abbf48e66..0dbacdd7bb0d8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1068,6 +1068,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
 
+	if (err == -ENOSYS)
+		err = -EPERM;
 	return err;
 }
 
-- 
2.39.5


