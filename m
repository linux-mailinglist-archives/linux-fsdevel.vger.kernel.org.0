Return-Path: <linux-fsdevel+bounces-40412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C5A2327C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E35165048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD591EF09C;
	Thu, 30 Jan 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrCXvW32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AA1EEA3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256868; cv=none; b=g95MbTaUH+Xll+8/07YSn5F3Bz6juLxuxeR/RJoj6l6mJuc+FVd2ST7VpnIDihbBkIoRa624/2v+A69iljSO8ndczxKNzcfwsJ6lhA8yvaTERbc3t53vcbs/Yjlk7NxluNUyw0ok3cWud/53XbC3kOV3H7v/SBvDDDIO4SyNGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256868; c=relaxed/simple;
	bh=e6rnP4AjCde4+aV7NzXPvnqZKHGd6tRSha6UNJ2JVyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tujZUttSrUyoM0OwmhcWO5z68+oXTBnDhe9gOIhaOmjfPQUNO3bJkgvUfdbBIEEhNrP4Aen6QROdUE/SamI0rP8rIQWtqk4hZ8SfqQxgiCMNogn0uJu3uCk0QFJBRVy/+oP4saRJ1dmOSwbUXjKp4ACtt5hgClE7ulQ3uiAsiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrCXvW32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738256865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSBcWa4IOctTRcDERpjo76q3hw2TfdtYAnq8v9ZVCUw=;
	b=CrCXvW32cphu3zJ6b26oha49dGHOWPcfMB29qDTHwJOf7yxGStWDG6B9xd/qfWvp1qgMMS
	FZZG+eQjJeKCVEXOwYqV7vopsvYd2abDcUynJR48YCCZfo91xJ2cLscweecC4/K7/wI9eo
	OwPF4bocFYjKrbpBp0YjKwoPPnPQImY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-5FlLgzd6MTCahAbrrB4eQg-1; Thu,
 30 Jan 2025 12:07:42 -0500
X-MC-Unique: 5FlLgzd6MTCahAbrrB4eQg-1
X-Mimecast-MFC-AGG-ID: 5FlLgzd6MTCahAbrrB4eQg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A26801800366;
	Thu, 30 Jan 2025 17:07:39 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B221530001BE;
	Thu, 30 Jan 2025 17:07:38 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 3/7] iomap: refactor iter and advance continuation logic
Date: Thu, 30 Jan 2025 12:09:44 -0500
Message-ID: <20250130170949.916098-4-bfoster@redhat.com>
In-Reply-To: <20250130170949.916098-1-bfoster@redhat.com>
References: <20250130170949.916098-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In preparation for future changes and more generic use of
iomap_iter_advance(), lift the high level iter continuation logic
out of iomap_iter_advance() into the caller. Also add some comments
and rework iomap_iter() to jump straight to ->iomap_begin() on the
first iteration.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/iter.c       | 66 ++++++++++++++++++++++++-------------------
 include/linux/iomap.h |  1 +
 2 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 731ea7267f27..0a13d50e9ffd 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -15,31 +15,17 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
 }
 
 /*
- * Advance to the next range we need to map.
- *
- * If the iomap is marked IOMAP_F_STALE, it means the existing map was not fully
- * processed - it was aborted because the extent the iomap spanned may have been
- * changed during the operation. In this case, the iteration behaviour is to
- * remap the unprocessed range of the iter, and that means we may need to remap
- * even when we've made no progress (i.e. count = 0). Hence the "finished
- * iterating" case needs to distinguish between (count = 0) meaning we are done
- * and (count = 0 && stale) meaning we need to remap the entire remaining range.
+ * Advance the current iterator position and return the length remaining for the
+ * current mapping.
  */
-static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
+int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
 {
-	bool stale = iter->iomap.flags & IOMAP_F_STALE;
-	int ret = 1;
-
-	if (count < 0)
-		return count;
-	if (WARN_ON_ONCE(count > iomap_length(iter)))
+	if (WARN_ON_ONCE(*count > iomap_length(iter)))
 		return -EIO;
-	iter->pos += count;
-	iter->len -= count;
-	if (!iter->len || (!count && !stale))
-		ret = 0;
-
-	return ret;
+	iter->pos += *count;
+	iter->len -= *count;
+	*count = iomap_length(iter);
+	return 0;
 }
 
 static inline void iomap_iter_done(struct iomap_iter *iter)
@@ -71,9 +57,16 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
  */
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
+	bool stale = iter->iomap.flags & IOMAP_F_STALE;
+	s64 processed;
 	int ret;
 
-	if (iter->iomap.length && ops->iomap_end) {
+	trace_iomap_iter(iter, ops, _RET_IP_);
+
+	if (!iter->iomap.length)
+		goto begin;
+
+	if (ops->iomap_end) {
 		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
 				iter->processed > 0 ? iter->processed : 0,
 				iter->flags, &iter->iomap);
@@ -81,15 +74,30 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 			return ret;
 	}
 
-	/* advance and clear state from the previous iteration */
-	trace_iomap_iter(iter, ops, _RET_IP_);
-	if (iter->iomap.length) {
-		ret = iomap_iter_advance(iter, iter->processed);
+	processed = iter->processed;
+	if (processed < 0) {
 		iomap_iter_reset_iomap(iter);
-		if (ret <= 0)
-			return ret;
+		return processed;
 	}
 
+	/*
+	 * Advance the iter and clear state from the previous iteration. The
+	 * remaining length of the previous iteration should be zero by this
+	 * point, so use iter->len to determine whether to continue onto the
+	 * next mapping. Explicitly terminate in the case where the current iter
+	 * has not advanced at all (i.e. no work was done for some reason)
+	 * unless the mapping has been marked stale and needs to be reprocessed.
+	 */
+	ret = iomap_iter_advance(iter, &processed);
+	if (!ret && iter->len > 0)
+		ret = 1;
+	if (ret > 0 && !iter->processed && !stale)
+		ret = 0;
+	iomap_iter_reset_iomap(iter);
+	if (ret <= 0)
+		return ret;
+
+begin:
 	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
 			       &iter->iomap, &iter->srcmap);
 	if (ret < 0)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f5ca71ac2fa2..f304c602e5fe 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -229,6 +229,7 @@ struct iomap_iter {
 };
 
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
+int iomap_iter_advance(struct iomap_iter *iter, u64 *count);
 
 /**
  * iomap_length_trim - trimmed length of the current iomap iteration
-- 
2.47.1


