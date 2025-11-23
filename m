Return-Path: <linux-fsdevel+bounces-69532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F3C7E3B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28B424E2E2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECFD2D8774;
	Sun, 23 Nov 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ188e+t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215529B778
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915637; cv=none; b=RlxmyuLP09+F8PO3GtnYI46yRzqEVjQ3o1Atup2Jr+s9Nmck0C9IVla4sl7JOXmlgJPQ8GCGgKNQx+9xPeov21nAi+LP7jTGavO4cs3aQH5BmXpTTX5tR834+7FJYOAYRHPhoSTt8yycAy/5TyAYJquXXm3u7CHTbxlD0TI16Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915637; c=relaxed/simple;
	bh=17Wb3C0n4q2WTj7Lky94o65x3rLNuufvROwh76uA088=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uv+M+t4oShl9//iEwK1iaqpgV0rG4+vwEV2nOIw6f1sd7wFINQVJJ/nJ6GOr6dBtgg8PZWAqVWyo8xu340DNYQ7NRw1UCnBxQo7XwYSV3Q/JOAlz9yy8rF+olQFJrex2W1ZJr8wxrfK6yk36v8RqjUZGn9ehHCW6FXWTExeIilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ188e+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89262C16AAE;
	Sun, 23 Nov 2025 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915636;
	bh=17Wb3C0n4q2WTj7Lky94o65x3rLNuufvROwh76uA088=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CQ188e+trT8sml9Ck796CqmNZtRJPbme3N0jCnDZCvCxTbmF5lWF+mGIRoZLCtotZ
	 ZLkZUzfA0BmaIn/JmDE+G36NTKCSWrOQje4SBHXv+Rmuei3IN0pmw+Z5f0BwyYo2QW
	 Kkd7LPQJoSYk4QwpQ9IIuwB2l0UP+L/gkbfc6QIJQQ+dOeE/OywCqF/6fWEjRw7Xm6
	 kqFwp1xCiJf3hip6ji0mVT6fRVwuLCY+YHorOQSLE129Z62I7bq6hrYmVgMmKOEvAv
	 MjOXMbqgVUYVG8BpneardiUt3cxPUCjCfSvCW6jzQxRuwUjmT/wQcadkDYxi/Po2VZ
	 KwWnED8WSak5A==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:28 +0100
Subject: [PATCH v4 10/47] nsfs: convert ns_ioctl() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-10-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=brauner@kernel.org;
 h=from:subject:message-id; bh=17Wb3C0n4q2WTj7Lky94o65x3rLNuufvROwh76uA088=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0e+f/sm5EqE1a97Rt/T/y378KS//f+iZWcru2XV7
 vbY3QhR7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI9weG/8HyeSeWGlvPVn5Q
 vv6e2iOleeeUsqWPlHd5qAt02etkCzH8Znl1XPLKrBVpyg9sgk98zTU4nm3mrTNd6e0zrpNylhs
 c2QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 7b26cb49a62c..1cf20cc8f6ed 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -320,28 +320,18 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		if (ret)
 			return ret;
 
-		CLASS(get_unused_fd, fd)(O_CLOEXEC);
-		if (fd < 0)
-			return fd;
-
-		f = dentry_open(&path, O_RDONLY, current_cred());
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-
-		if (uinfo) {
-			/*
-			 * If @uinfo is passed return all information about the
-			 * mount namespace as well.
-			 */
-			ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
-			if (ret)
-				return ret;
-		}
-
-		/* Transfer reference of @f to caller's fdtable. */
-		fd_install(fd, no_free_ptr(f));
-		/* File descriptor is live so hand it off to the caller. */
-		return take_fd(fd);
+		FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
+		if (fdf.err)
+			return fdf.err;
+		/*
+		 * If @uinfo is passed return all information about the
+		 * mount namespace as well.
+		 */
+		ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
+		if (ret)
+			return ret;
+		ret = fd_publish(fdf);
+		break;
 	}
 	default:
 		ret = -ENOTTY;

-- 
2.47.3


