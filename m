Return-Path: <linux-fsdevel+bounces-69292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83416C76825
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC95734E741
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04C30FF27;
	Thu, 20 Nov 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxvckP0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B7302164
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677964; cv=none; b=UAlkUi7UzCQhHUkAl4fq/ttnsQshyHqrFiErV+h6tB4b6+rXAKped0iJi+vX2VtB5PA1oCOh3bkPE/kSSMPD4UUQ/GM2JnryMNOY8KTSre5CWjtgT2oiI/7B0oUCQ0bqUSIsb9h2Ht3NxbOoY1L2+WAe+kLqnmApu8rE+YYAsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677964; c=relaxed/simple;
	bh=UKHIDj8vnP672Jagdd0jRuhQcKlGg6TpyPftvv6skp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZV8F8HCbstz4vGpsBblNju/9MqLVjx3yun/O+vbZlKpkmEYigpKpU8Ja7RtaYZfzufNjg8RRAkU1TfculdswyfXXK6qQpzF4Vb1vTf4luSY5aQANGR2+UtjeOAdv0L/xIHZ4jJnlVUfE93iTQf5nR0B/vQJnCCvNLAVENTWBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxvckP0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900BBC116B1;
	Thu, 20 Nov 2025 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677964;
	bh=UKHIDj8vnP672Jagdd0jRuhQcKlGg6TpyPftvv6skp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QxvckP0C5NqUBk2hIhu15KaHI7HK6wFT5eobuZRcJB7AvuysR9BioaUKhFYvXxUle
	 Gl2DtX53Y3Ggv4pNf7eQAPBlrGgGbFYFa1ThWFUgXRNWfe1goA5+bC7GUzPgDnbz5B
	 2gVuwed9u6dEt6i7NLfB0Ma7/eDsr1dvlrMJKvJ62RJzfFNr88ZHVwGPezrDQk0CY5
	 qd8xnIjDrls5fNMcR9mGqcLDq3Hjr62O77rxF1vlx2j+Ffb4OHRMOZtsDVJ5yDC4TB
	 RDg49MQiLRIff1Q/8ZFbeXvTNAq8o3RdOWBzkr8c+j6oCTkWUv/uaiqnxCxScH4iWs
	 c7mSIipLHJXVA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:10 +0100
Subject: [PATCH RFC v2 13/48] open: convert do_sys_openat2() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-13-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UKHIDj8vnP672Jagdd0jRuhQcKlGg6TpyPftvv6skp0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vjE+iW6rhoY0Bl5ob7azml9ilKPnnNv+qvqsLNx
 6u/KFzI6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIYy7D/0z+nSJSNXmBKhnr
 2cz/iKuzzpg/r0Z38eFk/SZT4Ti31Qy/2Sy7lpadbC7MtfO5w2fw72q5XLwCw8mKlyFrUhIXljE
 zAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..867a40f1d86a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1421,8 +1421,8 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 			  struct open_how *how)
 {
 	struct open_flags op;
-	struct filename *tmp;
-	int err, fd;
+	struct filename *tmp __free(putname);
+	int err;
 
 	err = build_open_flags(how, &op);
 	if (unlikely(err))
@@ -1432,18 +1432,12 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	fd = get_unused_fd_flags(how->flags);
-	if (likely(fd >= 0)) {
-		struct file *f = do_filp_open(dfd, tmp, &op);
-		if (IS_ERR(f)) {
-			put_unused_fd(fd);
-			fd = PTR_ERR(f);
-		} else {
-			fd_install(fd, f);
-		}
+	FD_PREPARE(fdf, how->flags, do_filp_open(dfd, tmp, &op)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
+
+		return fd_publish(fdf);
 	}
-	putname(tmp);
-	return fd;
 }
 
 int do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)

-- 
2.47.3


