Return-Path: <linux-fsdevel+bounces-69281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C17C76807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BD1212F188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648BF302158;
	Thu, 20 Nov 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIrHHyiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A033002BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677941; cv=none; b=Q5AGnEBue0+DOTQ+XeOJSq7s24lV1cffH6MZuhosulZFn7pcDJ5OvNJwv960+0lDLQyuDU2YibkLOqxZGu6svjJXNIOgrMHZq6ipYxUyq62n6Tu1VIzATm0gF+Ap0ji41RuyyycaeTL9v4cP8ZbYAQv6hqQ2W1KkpOyPjiNSLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677941; c=relaxed/simple;
	bh=f+4c24sWoj0osC+y6W62SdC60rYkMIQgML7zdQskssA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=en452yCWVGGXK8T4mGGS7vxqDKbqE5fr9OCljQlByTX5uz779QdoVh4mGVbPTaO8fbvDgem4o/0axpIu18DnLvvUKQiYwR/TTN8wn/TROdD2gPiU203mltXkUd6gDCHo5YIxrCV5hb1Xg3/rVHtgdOCtqCs28QMKGiCz6/VXO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIrHHyiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A062C113D0;
	Thu, 20 Nov 2025 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677941;
	bh=f+4c24sWoj0osC+y6W62SdC60rYkMIQgML7zdQskssA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SIrHHyiN+6Zhua/EZ8YHMjkrdP6f50LU9mrXqmfdSpsYWhCg+D7EnWwSTbV0K3sZl
	 BBXXYTort+3BJtl5tcI6Ofvj/kSbluSCQ3bkE8+fJrfMoq8reBXCyD6S5dY464TXSE
	 8ElNZVVrc7XEmN+t3HrKq7LV5aBUSgaJSUJuuYJ+E25kDqKgNpFZ6JLzZ5Bv7grX3a
	 hQVPdN8wWGrroGzT4Giwz+5T44GrixQOv1h9AMXS5oaE0BOeEAzkQHcDJ4V9SPRAEC
	 jqDvWPVcQM/UR6xsuq7t/jV2ohmGcVsqlpozCMgubGFKexkghmt9/no0NixMcdsusw
	 3A4c1E7oAF08g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:31:59 +0100
Subject: [PATCH RFC v2 02/48] anon_inodes: convert __anon_inode_getfd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-2-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f+4c24sWoj0osC+y6W62SdC60rYkMIQgML7zdQskssA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3sTJGBhsvbrQ/Omm6nO71vdnq20mHG79U8Yx5f4/
 QEJjUfyO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSyc3wv66ZadLL2Yn9HLWy
 0u17LhlF77nZ2eG6nj1lcoz6gUkZTYwM/1mMNj18eebo5PQkHt3bLOx8JWv/fJwSsXPNrUbDWJN
 bnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 180a458fc4f7..e02ce29098c5 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -280,27 +280,13 @@ static int __anon_inode_getfd(const char *name,
 			      const struct inode *context_inode,
 			      bool make_inode)
 {
-	int error, fd;
-	struct file *file;
-
-	error = get_unused_fd_flags(flags);
-	if (error < 0)
-		return error;
-	fd = error;
+	FD_PREPARE(fdf, flags, __anon_inode_getfile(name, fops, priv, flags,
+						    context_inode, make_inode)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	file = __anon_inode_getfile(name, fops, priv, flags, context_inode,
-				    make_inode);
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto err_put_unused_fd;
+		return fd_publish(fdf);
 	}
-	fd_install(fd, file);
-
-	return fd;
-
-err_put_unused_fd:
-	put_unused_fd(fd);
-	return error;
 }
 
 /**

-- 
2.47.3


