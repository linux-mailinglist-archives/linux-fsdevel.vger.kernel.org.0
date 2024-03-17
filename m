Return-Path: <linux-fsdevel+bounces-14585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA787DE5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223BA1F21ACB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3371CD13;
	Sun, 17 Mar 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrcYiPzK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F71CA96;
	Sun, 17 Mar 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692729; cv=none; b=C5BqTgtor5utUJgcA5KchhHRvNT+yxa8YW9uIf9jjHIdm6zjDQAtc5140DU6ToWMbjSVDjF1EQjnUXxIFwT7MKJurZhAeGRTeoT/yruDpnNXRypmt4pmqLWiFCrP6xxjuuBJs+rMrAeDgm+0DpUUSAE2C7sDDPSzf5GYhpmnZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692729; c=relaxed/simple;
	bh=Jga8LsAuSK0NzpEyTkqZak5vw6dw9HXNVyIkYjY6U3U=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQeFj0wEsFCaUw/8oX4U8lmEKfAUlTvIOv3dAvFzEkXsga5NopvcMNUl4cOvU/oADjhQVDZCrvNRq3+COaMI1JiKwDowDShqxGvmBp4ot0i2kGUUN0C23zwtdoWHjOAU+1nws12xdbCulYd/0JIltf+/j0TLi7cDVlrJnVeeiic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrcYiPzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AB5C433C7;
	Sun, 17 Mar 2024 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692729;
	bh=Jga8LsAuSK0NzpEyTkqZak5vw6dw9HXNVyIkYjY6U3U=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GrcYiPzKJJPjCgQ8Ax70h1yS1k9o+AQRwblgBWMUX75n1ol3d2I2Cl1Lfnn+UJNWf
	 joDSxSDrEJUdyQp4n+omFSMjWR+iXlP+uWrygzcWuaDU1mRcuH8qRtZJpztg0rYFf9
	 JQy9FGpeDvFmEHSr9AhQvzof0Hq3KXwz6z9eSWTDXop161Q0iabyJSojM5i8HjlHZf
	 xxGBvWI+Q0219EjIcoOOhxvLZoeAfXqrPNp8TtYnIDBIzDnBEKttecOq5yK48IMsLG
	 YRAfePD2YqSp2szB+3+Ld5xtgSqI8yNvNT7EHIJawMNYnU27yYZMUV8d9URJ7SMv0N
	 +foZzot8X1ECA==
Date: Sun, 17 Mar 2024 09:25:29 -0700
Subject: [PATCH 08/40] fsverity: add per-sb workqueue for post read processing
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246042.2684506.11798514410282707478.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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


