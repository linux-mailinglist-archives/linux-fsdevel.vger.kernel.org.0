Return-Path: <linux-fsdevel+bounces-69407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB2C7B2B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB4E3A3A22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B7348465;
	Fri, 21 Nov 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjh2az6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54E33BBB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748071; cv=none; b=rrZBgPkDgTtzz0fmm52tziDw9mlthU9mA5E4BDuzBgwnESlBJOxQjuegstq4VEN2W8RpumZkyk6mraCYwNFAGCdcFmvw0uvPkhqoMIM6Pn/UYBTLS25FQymDQtxEZqcgv/mCqj3TelZKXFcH+O8ARf+xnSusmrB/6CBaJ0x/A7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748071; c=relaxed/simple;
	bh=SP9XVoETPeKKZg/Nj4v932y5rN1eLQFzPWswOsjea5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUJX3VCXvsTPNlCxUT7Sp2CX2HoPWXFnURFtZC5BB+fYICCGx/uaY9hMl7Sc7nHFkitHY/gip0vtFeyh+B0gQHXWodXP+sbbbgiMcgd3xuMNNnq1q44iG6Zn14TDRT2HzQO2cZZ0LmcmIr0MAAlyixJBwYsxrwb0QGAobXloEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjh2az6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EF7C116D0;
	Fri, 21 Nov 2025 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748070;
	bh=SP9XVoETPeKKZg/Nj4v932y5rN1eLQFzPWswOsjea5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vjh2az6PiKYTa5qccPV+F2nWpTE9l6rXRXp+qQ5sdfKd03OG/AHtjj7U8wkTooIo6
	 sF0ipwodOf1NSo+CmLa3PwigH89LXGO6EaVj8XlEg/tYPMrwcwiwwtJU4TFm2llAkI
	 08018LcOgIS2CSuB2lb5geHimyNmsoirabona12xfRWZVH8mWT4ANo3Yh6cp0FpXV5
	 cov6IGz0TjXStgbHXLzeyMQaAsi2BelvVEQN/P6xty7eR/e3IGBWArCMfiA2dTlvwz
	 JosVahJxg89gJp1ff7Oo9yCLUSOvXa+kx4hpcOoTb26y2i1719JBSOeYqU3i/fkxmX
	 SGMLDDRFXDA5A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:48 +0100
Subject: [PATCH RFC v3 09/47] nsfs: convert open_namespace() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-9-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SP9XVoETPeKKZg/Nj4v932y5rN1eLQFzPWswOsjea5o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDhvJHvd9YvG5f2HKwQXN2xQ3WsZFP3FtJabwZnDT
 6vH+2dpRwkLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQedjP8eN4wbVcvVxz/+3l9
 lh4SChUWdeVWOvKKxmYXX3vaXPnByND7QEHzxd3W7nIvk/8Vr3ZXPjllYVb4rTZ1f52RhKLoCR4 A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 79b026a36fb6..61102cc63e1d 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -108,7 +108,6 @@ int ns_get_path(struct path *path, struct task_struct *task,
 int open_namespace(struct ns_common *ns)
 {
 	struct path path __free(path_put) = {};
-	struct file *f;
 	int err;
 
 	/* call first to consume reference */
@@ -116,16 +115,11 @@ int open_namespace(struct ns_common *ns)
 	if (err < 0)
 		return err;
 
-	CLASS(get_unused_fd, fd)(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	f = dentry_open(&path, O_RDONLY, current_cred());
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-
-	fd_install(fd, f);
-	return take_fd(fd);
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (err)
+		return err;
+	return fd_publish(fdf);
 }
 
 int open_related_ns(struct ns_common *ns,

-- 
2.47.3


