Return-Path: <linux-fsdevel+bounces-25127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE394952A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3B1F23A76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26AB80043;
	Tue,  6 Aug 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybamsc2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191F13A26F
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960160; cv=none; b=UhoxJ9xDqSU2vkRNw/twBt+09aqvU70w5/N0vt4TPXU7q92m5R0LkJFZRKQwRLnp4G9sl7Gv9VnqbmftFRHHhaby3MusHVR8tLlVyyua8TU6ZFrYr1j/cZO4R+b0a/xC0ARHOSEJo7hX5uZYQ9F0jyUbJr2scf29DHffrOP3OY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960160; c=relaxed/simple;
	bh=nX8jly5hivqhxcp7i0sBoUlkkwyN6k1tpHVLGLWWs90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOrixifEgfpDdruqb7JO5eCM9viflsQSWU/hKmeejihSkI1nKcQigwtHAmAoLfY587uK0GWy0YM4zV2c0lZzVcQ4X6Vnz6iNUUTXtV9PgYFrs9H+P3MXAMhjT8btCXGWdv/aEocOjYu7ZENoP9Tnx8kH5j5ZM+M8Co4Rg/LPVWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybamsc2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69133C4AF0E;
	Tue,  6 Aug 2024 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960159;
	bh=nX8jly5hivqhxcp7i0sBoUlkkwyN6k1tpHVLGLWWs90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ybamsc2nHcWycUxS3VfPP4bOVMMFJPGCSSNIVYHIUc9Byx74vnbhHbl7EP6EPL9rX
	 G5ry3P40LidLB58lwyLpwBW2iaYU5ptsz0dax7YBisred384xIRnHnriIQgO3KUb9R
	 UtQhKxa1svRxzgFPdDKuZoRG69v5Su2iK9N/fLgRjoQhP8CYrRUX5UPAQQfeh0nsKa
	 dhK3Asg+clsQJRVP+8bQkfaDu1SRmzEWwz2zEt6WaSf5S7u6tuPrSTXedK1B4wdk1h
	 QTB8Plp9zc86X6QD+hSsL/WfAcON8SJrbHnaP9CSOE0CwI/nIot5WlFtYhI8TKcW5P
	 fEOV0wI9bDEdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Aug 2024 18:02:27 +0200
Subject: [PATCH RFC 1/6] proc: proc_readfd() -> proc_fd_iterate_shared()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-work-procfs-v1-1-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nX8jly5hivqhxcp7i0sBoUlkkwyN6k1tpHVLGLWWs90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pRW2PF9+kP+IAWjv6fYLlTetimddqRs0U9ZNevw/
 vmKs/Z87yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI5BdGhu9F1h5yLVItmWGH
 qu7yMyxdtjW4TeFalqyP76vFcSxn+RgZHte8W702i6Wa13q/eb7FBFMOiSV7X1/qLtsiKuNqunE
 nFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Give the method to iterate through the fd directory a better name.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 586bbc84ca04..41bc75d5060c 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -312,14 +312,14 @@ static int proc_readfd_count(struct inode *inode, loff_t *count)
 	return 0;
 }
 
-static int proc_readfd(struct file *file, struct dir_context *ctx)
+static int proc_fd_iterate_shared(struct file *file, struct dir_context *ctx)
 {
 	return proc_readfd_common(file, ctx, proc_fd_instantiate);
 }
 
 const struct file_operations proc_fd_operations = {
 	.read		= generic_read_dir,
-	.iterate_shared	= proc_readfd,
+	.iterate_shared	= proc_fd_iterate_shared,
 	.llseek		= generic_file_llseek,
 };
 

-- 
2.43.0


