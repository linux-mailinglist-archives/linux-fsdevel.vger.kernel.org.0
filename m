Return-Path: <linux-fsdevel+bounces-69325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FCC768A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1151A35E5EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA931B10F;
	Thu, 20 Nov 2025 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDNKqcwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB43019CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678031; cv=none; b=HPGBw/f8HbfzVKE1y1bl/DnYljCuj1INwwt/ENCLr80GNr5DG5Gn9Q/Yy3wVkYdkXqiPZrxdydo+t5kqCIJ3d2iobu1CoC9wLJDTUX++z89IwCjFmtdWM12L2ePCff7GsHiuMgTin0LBDXRcZPKh0+J8yewti3vXN66W0WEI3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678031; c=relaxed/simple;
	bh=eRkouEaCs8zooU6qnbFKlNF/33I2hKY2W7xiAJwFP68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VXgT9Vwj8pr7NyHM/eq0r0IfJPCD5e5+dDr8dBsBByqj0WczAx+uIg0uxfkrCiaTs71RwvzUs/JX8J1yj9Shl4b1Vq62JZP9K/Bm/BrX91PDpu4QiTu8t0v4jXnhFJ6PwvlDqJAdlAdWYq8/yBh9EW2FfaQEq45ugb8CcM89To0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDNKqcwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F86DC4CEF1;
	Thu, 20 Nov 2025 22:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678030;
	bh=eRkouEaCs8zooU6qnbFKlNF/33I2hKY2W7xiAJwFP68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PDNKqcwjUIZAr+shIXHlJG7P0xzKnDihx7FZPZC8O5vIGAwFsa9WGztZTlD566Dge
	 m4ZtXZnSR0EyjHipfkKBlUNu+g75++UzHGzOAlEdqR1PBmXdJTo6RDzsN4T8/llkXm
	 DSGMJao/FJ1aHgh5HllMaPT5Rj5hGYuTlDU8/8u4iF+g4cfOexb80BirxCL3RGZwFd
	 37Iqro94T4632a5kDy/pmlH48shsp63RtFDO5Foj5aJeaBOImiILU8Rm+BxpxE8ttr
	 BudM3s0F2MlRCR4m1ZK7m9zh7IflaFB5htrvxAFSmKWk0R73lGVcyZNno/HG59YoT8
	 uxFvUnMfULTqA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:42 +0100
Subject: [PATCH RFC v2 45/48] file: convert replace_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-45-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eRkouEaCs8zooU6qnbFKlNF/33I2hKY2W7xiAJwFP68=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3svc9TU6EhaMGeTrvD1HXPf8cs3mSsxBjDPTLwYk
 ahW8lG+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCInhRkZ1gVO7xQ7ZcW2VPdg
 VfybrelWE2W8J3a+eWdz7uQ+wQW3PzP80z2ZeVr0v3m3z76tF4/x33C7NmXLba3J9rs1ZxiJ3qm
 5wA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..6c1af2d87eca 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1357,28 +1357,26 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  */
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
-	int new_fd;
 	int error;
 
 	error = security_file_receive(file);
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	FD_PREPARE(fdf, o_flags, file) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
+		get_file(file);
 
-	if (ufd) {
-		error = put_user(new_fd, ufd);
-		if (error) {
-			put_unused_fd(new_fd);
-			return error;
+		if (ufd) {
+			error = put_user(fd_prepare_fd(fdf), ufd);
+			if (error)
+				return error;
 		}
-	}
 
-	fd_install(new_fd, get_file(file));
-	__receive_sock(file);
-	return new_fd;
+		__receive_sock(fd_prepare_file(fdf));
+		return fd_publish(fdf);
+	}
 }
 EXPORT_SYMBOL_GPL(receive_fd);
 

-- 
2.47.3


