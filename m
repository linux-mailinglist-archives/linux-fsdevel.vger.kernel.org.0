Return-Path: <linux-fsdevel+bounces-69526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE0BC7E3A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95F3C4E0EC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF602D73A8;
	Sun, 23 Nov 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVjlSSU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E722D7B5
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915623; cv=none; b=SJNjA4Hdp7EvhBmex6kGZSbIb6E94Knj3x8vmlxcL/cs5MygEgeyjUuUGAZyeU86A/blp1KD2lM8Wzuge01oFjbn6sIaQEEGGCkbM7j7dImLLSpv+nNNV/et6fvcJcToGQtSMP884HNh8SpIBy5+MzOSZZhRddRimE7eI+Qotf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915623; c=relaxed/simple;
	bh=gQHVjn9RK3aUoDnODzTc7qs7VZ8RMDGgmnN0FqGsTwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkPRkRHnIdSZbokuQBE1q+gDvG0laX7S9gHJ1RuA7+HrNPIJyeueTgWxb8ojyYUtRCrkaK7EwPhp/Y1B6APzB7ZWoJYkYhmEmY4yxu35+VoBdqJ7Ehne56ZqbICEk8v/h9RRH0QkRQxh2e2RflyOBXwdQ7gO1zpFD6ehzR9l/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVjlSSU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9C4C19421;
	Sun, 23 Nov 2025 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915623;
	bh=gQHVjn9RK3aUoDnODzTc7qs7VZ8RMDGgmnN0FqGsTwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PVjlSSU2P6YZsIZ3zIstgP0RwTugxF0r1pccUYTMmg2CVODix52EnXOLbBVwB04oM
	 I6qyg0LEjy0rlvSM+UrUYviW5Q09v7wwVUOoVuS46yWr2YhEwYGeAzYbH3aXItxgmn
	 xPM7680Y2Ikuy/fCndWxnTFKvljr3NSQb+bKEqn98s4dhHOaAElQ8TYaOOSXT0cIBz
	 CrN6tFuZbJt3mpd6oQXqSwbErc1ouQRLEjWVTmxzQZ/6nrlMQQyGCBNvYeBM0+TU93
	 11CYZ+Tu6dPHiI8Poxxch/ofnnqqKqHXXgfGLRpqTt6X6Bb5KobrAke001oMVG6DhA
	 v5Z+ouhtFfH1g==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:22 +0100
Subject: [PATCH v4 04/47] fhandle: convert do_handle_open() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-4-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gQHVjn9RK3aUoDnODzTc7qs7VZ8RMDGgmnN0FqGsTwU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0dYcPa4t/b/WaCxviM0f8OyfVt2nJpZxnWM222Pn
 dNsoxuvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSeoLhf0pBldTkJo/ou6f+
 iF7OOMiU+7RnT2XKkWIFkeg5OZ9m3WP4Z1/TK/1iep7skhl+VzgW8RufM//+XGj2pG9ZGy66sa8
 q5wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 052f9c9368fb..3de1547ec9d4 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -404,32 +404,28 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	return retval;
 }
 
+static struct file *file_open_handle(struct path *path, int open_flag)
+{
+	const struct export_operations *eops;
+
+	eops = path->mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		return eops->open(path, open_flag);
+
+	return file_open_root(path, "", open_flag, 0);
+}
+
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
-	long retval = 0;
+	long retval;
 	struct path path __free(path_put) = {};
-	struct file *file;
-	const struct export_operations *eops;
 
 	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
 		return retval;
 
-	CLASS(get_unused_fd, fd)(open_flag);
-	if (fd < 0)
-		return fd;
-
-	eops = path.mnt->mnt_sb->s_export_op;
-	if (eops->open)
-		file = eops->open(&path, open_flag);
-	else
-		file = file_open_root(&path, "", open_flag, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	fd_install(fd, file);
-	return take_fd(fd);
+	return FD_ADD(open_flag, file_open_handle(&path, open_flag));
 }
 
 /**

-- 
2.47.3


