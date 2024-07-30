Return-Path: <linux-fsdevel+bounces-24546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE4C94070D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4671C226ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2F194120;
	Tue, 30 Jul 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYjXX46u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C3192B84;
	Tue, 30 Jul 2024 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316500; cv=none; b=V5UxSNMSY52TXgQgqv7F00KlpBeUP74HeBPuy+VaU+v431iW0XljWJJzKryRNEt/QAOLuUrPXOcJLu8jQI56T3GatAve93+TLZjDP/I5RMNHhH0wb4wPoFBCUWh9ETyIohzrJyuzSQqO4RI7jRDliWkeTC25lbBMgXbTmeeRg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316500; c=relaxed/simple;
	bh=C9s9vnA2CIrtnqUqtVhZbKJzmmtvZ7h6xpVpdKEJ0R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTGqC/KDw//aVo4eqb6ry6DUNHb9Gb07dyGPpFn033UBof4EJ+qtmDS+2zA1Bj4j25mu2memcE1u2nBxTfOc4wR0vNbGTuELLB81Eq1ErZIGQsYSHsu/A06IjRYE8Bv80WzdhywUBAOM2g0KMWvwpQ+efUzaOvWqk68rwR5pmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYjXX46u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C447C4AF0C;
	Tue, 30 Jul 2024 05:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316499;
	bh=C9s9vnA2CIrtnqUqtVhZbKJzmmtvZ7h6xpVpdKEJ0R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYjXX46uOlNJPUdpGAVnBWnNyaZCDPD1/RcypTor+XkBu8tpShfWatCWO/WIkjHcI
	 46RMOnZQYYV+NVBiadNJ9C5d/12EeBviaYHuV4UMCeY/3jd6QxGre4CpEI/CVqeWM5
	 5aGbt15b1Ji2Ev3PPGQjspSTnz6+JtBukRSmDNTyn30eLaBfSEW09/9inwR7FJnW+C
	 ZbYXqvzDYRTjs4MrwhOOHZ9LLHD5hGU0nj/ly18aZMUL8GegI29DCq6+ig3lWemL22
	 PY1ucDS3Y/wUcFI+OF5ChLkGUslXVlpd61iLbyx0ooDVPfIyAxQLhV0EOilHovpcA3
	 xcC3ZNEe4TWmA==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 14/39] simplify xfs_find_handle() a bit
Date: Tue, 30 Jul 2024 01:16:00 -0400
Message-Id: <20240730051625.14349-14-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

XFS_IOC_FD_TO_HANDLE can grab a reference to copied ->f_path and
let the file go; results in simpler control flow - cleanup is
the same for both "by descriptor" and "by pathname" cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/xfs/xfs_handle.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index 49e5e5f04e60..f19fce557354 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -85,22 +85,23 @@ xfs_find_handle(
 	int			hsize;
 	xfs_handle_t		handle;
 	struct inode		*inode;
-	struct fd		f = EMPTY_FD;
 	struct path		path;
 	int			error;
 	struct xfs_inode	*ip;
 
 	if (cmd == XFS_IOC_FD_TO_HANDLE) {
-		f = fdget(hreq->fd);
-		if (!fd_file(f))
+		CLASS(fd, f)(hreq->fd);
+
+		if (fd_empty(f))
 			return -EBADF;
-		inode = file_inode(fd_file(f));
+		path = fd_file(f)->f_path;
+		path_get(&path);
 	} else {
 		error = user_path_at(AT_FDCWD, hreq->path, 0, &path);
 		if (error)
 			return error;
-		inode = d_inode(path.dentry);
 	}
+	inode = d_inode(path.dentry);
 	ip = XFS_I(inode);
 
 	/*
@@ -134,10 +135,7 @@ xfs_find_handle(
 	error = 0;
 
  out_put:
-	if (cmd == XFS_IOC_FD_TO_HANDLE)
-		fdput(f);
-	else
-		path_put(&path);
+	path_put(&path);
 	return error;
 }
 
-- 
2.39.2


