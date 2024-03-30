Return-Path: <linux-fsdevel+bounces-15706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A64892827
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B7B1F222BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5278F28F0;
	Sat, 30 Mar 2024 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6dAMLvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9C1FA5;
	Sat, 30 Mar 2024 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758823; cv=none; b=rh86Cpw5vqETI+Ei6lf1/5R62QV46lrA64wJcISr4r5tgyFKx88Sfa0YBg3pH+3WMZeKynVSTMhkK1V+EUlIdg0PtMMhwkVmbxCNSXggTZsevLWbXloATmh5TLdUGNgZxN1RCMWMYeJpHEfzizLivadcP7I9nljbjx3gc0gR2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758823; c=relaxed/simple;
	bh=7y/TBH2WEk8Fj7ho/TkeUus7HMzFwaPsnJQh/oM9+pI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfBRKUB0ZrLjGHC2kzfbQTEkUtlLwASHhE/gC2cNVYNG7OD47FgvbVDaT33AYVe0k/XfT291l98mpC6HdbbI4ATu2GkQUT6yMPqrw8j07HcEVpT2vdXp/FHx3ivqy38q90mLd4aYwAmtOiqITUX3/W3bqoPbts0MTR0Ub46MwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6dAMLvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8450FC433F1;
	Sat, 30 Mar 2024 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758823;
	bh=7y/TBH2WEk8Fj7ho/TkeUus7HMzFwaPsnJQh/oM9+pI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=K6dAMLvoJzkQVcBdNp7o5nCgF/T2p8Sw9REUnlh76Efqob0X1+b9kNkSnEvhHBomK
	 58A3jRo4VWblrl+cenWZ3sAZUgRrbvxT6dqqur4hFeBqaM/OUbxLQ8L1hfXF02844f
	 GRxYioIsLiizXbnuTBKEBkRidxz499cQGISeYqRMh0SHQbhS3I/wM6x3HT8y1RjlQr
	 IGc+0Al7uaulQR8a24rWngqP4v6tIRYX9PiCataVMEkgTC23A2hrnp+wmCjB85LQME
	 rtbz1I3nkxWXEJ3+XBjyTFoMJGpmQBtv7qi/dwW8AtEEZZWJA6Rd5Xq6Ju9u0nOB5f
	 xvBC+xFVj1lBg==
Date: Fri, 29 Mar 2024 17:33:43 -0700
Subject: [PATCH 04/13] fsverity: add per-sb workqueue for post read processing
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867930.1987804.1200988399612926993.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
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
[djwong: make it clearer that this workqueue is for verity]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/super.c               |    7 +++++++
 fs/verity/verify.c       |   20 ++++++++++++++++++++
 include/linux/fs.h       |    2 ++
 include/linux/fsverity.h |   13 +++++++++++++
 4 files changed, 42 insertions(+)


diff --git a/fs/super.c b/fs/super.c
index 71d9779c42b10..aaa75131f6795 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -637,6 +637,13 @@ void generic_shutdown_super(struct super_block *sb)
 			sb->s_dio_done_wq = NULL;
 		}
 
+#ifdef CONFIG_FS_VERITY
+		if (sb->s_verify_wq) {
+			destroy_workqueue(sb->s_verify_wq);
+			sb->s_verify_wq = NULL;
+		}
+#endif
+
 		if (sop->put_super)
 			sop->put_super(sb);
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 0b5e11073e883..0417862d5bd4a 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -342,6 +342,26 @@ void fsverity_verify_bio(struct bio *bio)
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
 
+int __fsverity_init_verify_wq(struct super_block *sb)
+{
+	struct workqueue_struct *wq, *old;
+
+	wq = alloc_workqueue("fsverity/%s", WQ_MEM_RECLAIM | WQ_FREEZABLE, 0,
+			sb->s_id);
+	if (!wq)
+		return -ENOMEM;
+
+	/*
+	 * This has to be atomic as readaheads can race to create the
+	 * workqueue.  If someone created workqueue before us, we drop ours.
+	 */
+	old = cmpxchg(&sb->s_verify_wq, NULL, wq);
+	if (old)
+		destroy_workqueue(wq);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__fsverity_init_verify_wq);
+
 /**
  * fsverity_enqueue_verify_work() - enqueue work on the fs-verity workqueue
  * @work: the work to enqueue
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5d1c33573767f..2fc3c2d218ff8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1230,6 +1230,8 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+	/* Completion queue for post read verification */
+	struct workqueue_struct *s_verify_wq;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *s_encoding;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index c3478efd67d62..495708fb1f26a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -252,6 +252,14 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
+int __fsverity_init_verify_wq(struct super_block *sb);
+static inline int fsverity_init_verify_wq(struct super_block *sb)
+{
+	if (sb->s_verify_wq)
+		return 0;
+	return __fsverity_init_verify_wq(sb);
+}
+
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -329,6 +337,11 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_init_verify_wq(struct super_block *sb)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)


