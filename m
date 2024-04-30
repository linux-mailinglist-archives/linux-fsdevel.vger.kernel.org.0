Return-Path: <linux-fsdevel+bounces-18217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A91448B6858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A70B20AEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A8C101C4;
	Tue, 30 Apr 2024 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtR9j247"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE790DF58;
	Tue, 30 Apr 2024 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447259; cv=none; b=G2TtMnNraNmxfeJ06KCgvVWOcEA4APQB5sMoP8qMAkeYqRy7GICUE8VAyFAtCHB1HB2HLAtnFRa4DFtpLLNDULYll43qbXK95XC2faEk34gsd8aHIuprXs/0Yv+0h/soyqEajMKhBDviK9irCJ8wa0xFZSTvoBdbE2zodIlk8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447259; c=relaxed/simple;
	bh=+P0Whr2nyF/P5h+yK3C2i+EtxX7Ru2cmK3dIEIeY/hs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pntBVfQzNr58g9nEL/ipEJslGaLOxAE21hU5Aa2qMNcXbZzdfKNkY37ifzEPXzwFsKy5ICKWp6VuirvRa/mgsaU2gysY/VCNdNLTtJWHEZ6MbeF3wytoYfPiDt8efAlOYvZ0z0eas0mJDW2k1i5OGjvXbPz5OBpZIibChdN9CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtR9j247; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41105C116B1;
	Tue, 30 Apr 2024 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447259;
	bh=+P0Whr2nyF/P5h+yK3C2i+EtxX7Ru2cmK3dIEIeY/hs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DtR9j247x32KeBYKYVEr+4wYLqat1jF6nHhqLykBE9btvMf7oqhZHDNUQvTXdZcfm
	 aSJPK7Ju91KKPyZn+o+U7pEYGfq+uN/EThLzm6MMMJwjQ8PpbTk+KdKwooK1H9hgik
	 Zc57qSja2vKKfMGULmVpokyuWf4pRQlV1WzyHqmhdhrhI/b4gDJ7kptYZ0e/2dSQIK
	 2k9wC6U5K52lCI7YL3o4laM4PhzAyky7rUwLhk0nU/SjzDiD5YYJhrljcU2+yamdrO
	 m0bEC/LOq/KBwTEr8m6W1jcYPRWXZgjRGnzwRLSTrQUuzcQIGJON0FIk9i4PiPA3bM
	 IICXX2oYu2C+w==
Date: Mon, 29 Apr 2024 20:20:58 -0700
Subject: [PATCH 06/18] fsverity: add per-sb workqueue for post read processing
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679691.955480.16813206393998620840.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
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
 fs/super.c               |    3 +++
 fs/verity/verify.c       |   14 ++++++++++++++
 include/linux/fs.h       |    2 ++
 include/linux/fsverity.h |   18 ++++++++++++++++++
 4 files changed, 37 insertions(+)


diff --git a/fs/super.c b/fs/super.c
index 69ce6c6009684..7758188039554 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who);
@@ -637,6 +638,8 @@ void generic_shutdown_super(struct super_block *sb)
 			sb->s_dio_done_wq = NULL;
 		}
 
+		fsverity_destroy_wq(sb);
+
 		if (sop->put_super)
 			sop->put_super(sb);
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index daf2057dbe839..cd0973c88cdba 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -339,6 +339,20 @@ void fsverity_verify_bio(struct bio *bio)
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
 
+int fsverity_init_wq(struct super_block *sb, unsigned int wq_flags,
+		     int max_active)
+{
+	WARN_ON_ONCE(sb->s_verity_wq != NULL);
+
+	sb->s_verity_wq = alloc_workqueue("fsverity/%s", wq_flags, max_active,
+					  sb->s_id);
+	if (!sb->s_verity_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_init_wq);
+
 /**
  * fsverity_enqueue_verify_work() - enqueue work on the fs-verity workqueue
  * @work: the work to enqueue
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 95ef7228fd7ba..d2f51fdc62e44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1232,6 +1232,8 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+	/* Completion queue for post read verification */
+	struct workqueue_struct *s_verity_wq;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct unicode_map *s_encoding;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 15bf33be99d79..c3f04bc0166d3 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -262,6 +262,17 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
+int fsverity_init_wq(struct super_block *sb, unsigned int wq_flags,
+		       int max_active);
+
+static inline void fsverity_destroy_wq(struct super_block *sb)
+{
+	if (sb->s_verity_wq) {
+		destroy_workqueue(sb->s_verity_wq);
+		sb->s_verity_wq = NULL;
+	}
+}
+
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -339,6 +350,13 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_init_wq(struct super_block *sb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fsverity_destroy_wq(struct super_block *sb) { }
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)


