Return-Path: <linux-fsdevel+bounces-14329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91F87B08D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5F51F24203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D9B6FE36;
	Wed, 13 Mar 2024 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa+si+qD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC816FE2C;
	Wed, 13 Mar 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352481; cv=none; b=HeIfqlaV3A5bJgw4Y8XqZl2WILX6Em4seRwrWWGuHiE4LhHddHUdLpwc/9l86C2qomJPQ/390GqDlrzsFTUZQHfzuC4k2kjZyxExpL4uqhH6rv1qHGzlL2QqBxPqgkpwb1MTnw+VX/1tLvusx1f+JUAObfVKJPf4Lavx9iU5wqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352481; c=relaxed/simple;
	bh=Jga8LsAuSK0NzpEyTkqZak5vw6dw9HXNVyIkYjY6U3U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi1hxee1bJZN8yxeOVH7RgSVYeEeVdAHTQoGFOHn9F9Prhpf3d41+AbDBM+QWSZ/3AL+To2zjpz4loTNqhkbWjQS5baqZXOqUoKl0VPS8iH7NWBiHsCUOsvF8U/Kki4GS4DP6Q1B5Btmb6O9wQm5z1v3g1iV4C4YVufr+zSdSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa+si+qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E03C433F1;
	Wed, 13 Mar 2024 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352480;
	bh=Jga8LsAuSK0NzpEyTkqZak5vw6dw9HXNVyIkYjY6U3U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Pa+si+qDPR56IJIDMtHS+aMO+O9xYOWkGl5LtAeO/LmaBxrwDtXh7gn/k+vj+ma4z
	 GsZ2AF08HSCtvhFXMYMkhyakiKiGBIubh1meDmaaIRkE8KUuWvmxsmsm09StY8PIHH
	 FgfIp+YPZjYs2mfd2TxR1VgbKikfr+KrpwDMAMVa1HYJTvuuGGk1JhHe8IXlJK/cf/
	 tReiWahStW+NGw/Iz5hrYUtIHotTPhtMxKMEKIq2vQsI5G2YFyIA/jHUURY9JhdFR+
	 dT6PRQj9q/561JpIP7HPfxDLEfdtTSF4QF82teciBRHJQmfsidgp//m2IOHZWC6ISv
	 igacJoQ81Md7g==
Date: Wed, 13 Mar 2024 10:54:39 -0700
Subject: [PATCH 08/29] fsverity: add per-sb workqueue for post read processing
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223488.2613863.7583467519759571221.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

For XFS, fsverity's global workqueue is not really suitable due to:

1. High priority workqueues are used within XFS to ensure that data
   IO completion cannot stall processing of journal IO completions.
   Hence using a WQ_HIGHPRI workqueue directly in the user data IO
   path is a potential filesystem livelock/deadlock vector.

2. The fsverity workqueue is global - it creates a cross-filesystem
   contention point.

This patch adds per-filesystem, per-cpu workqueue for fsverity
work. This allows iomap to add verification work in the read path on
BIO completion.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c               |    7 +++++++
 include/linux/fs.h       |    2 ++
 include/linux/fsverity.h |   22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)


diff --git a/fs/super.c b/fs/super.c
index d35e85295489..338d86864200 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -642,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
 			sb->s_dio_done_wq = NULL;
 		}
 
+#ifdef CONFIG_FS_VERITY
+		if (sb->s_read_done_wq) {
+			destroy_workqueue(sb->s_read_done_wq);
+			sb->s_read_done_wq = NULL;
+		}
+#endif
+
 		if (sop->put_super)
 			sop->put_super(sb);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..9db24a825d94 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1221,6 +1221,8 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+	/* Completion queue for post read verification */
+	struct workqueue_struct *s_read_done_wq;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *s_encoding;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 0973b521ac5a..45b7c613148a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
 void fsverity_invalidate_block(struct inode *inode,
 		struct fsverity_blockbuf *block);
 
+static inline int fsverity_set_ops(struct super_block *sb,
+				   const struct fsverity_operations *ops)
+{
+	sb->s_vop = ops;
+
+	/* Create per-sb workqueue for post read bio verification */
+	struct workqueue_struct *wq = alloc_workqueue(
+		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
+	if (!wq)
+		return -ENOMEM;
+
+	sb->s_read_done_wq = wq;
+
+	return 0;
+}
+
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -318,6 +334,12 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_set_ops(struct super_block *sb,
+				   const struct fsverity_operations *ops)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)


