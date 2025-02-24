Return-Path: <linux-fsdevel+bounces-42430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF109A42451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9491119C080E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4625484B;
	Mon, 24 Feb 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM7qqdA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4624EF95
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408340; cv=none; b=WF3InFUN/Ee9bgscayaJiZEvN7zaDdDuoABQZh2omM66DafXBcpP+XRcEooOO4XJsRBDJmIXiAiI1LGsa/1hAI/5CzKZRzv847VyFERlmBSava+yYkAzENA9iXc9+fz/2iRKUpbviJcqDj8AzMDhqvTrcm/MbrmpdAapmQBpKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408340; c=relaxed/simple;
	bh=oEl6sOYmYYtsfpfOhwvSI1nYdJgsETe+NZtEXTR5zcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcpAWr0N/btEM3Ng1JcdomBEnYFPGF5kurcZRjraT7hmGG/2K+YetQVb8oqRWDJxHBarVb5GR4GlWYbctbCS5NDnXkexpsMz+RcxZE9hwWA3mN5sHO+Jo7uzdtVP4uXIV2ob8gbFnSPpK+9gp5kzpWZDr3mH696e8kDBj9OBqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MM7qqdA9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01vJRIc2QxI+hXPd3GQR31ZDdzBcaXRF2DCfD89SXLo=;
	b=MM7qqdA9TQ4rwtrac5AsFlt29QzDsp6lo3vGzS9kkZTBdeB792RrkvPwqJCLwQ1bYH7kNg
	8hE2UllGpS7ldcwPpbPs87rTYUzskuQwBKEsJdgFQm/rsSFtg5FhKxg2shsPRaz4dG69n2
	PoOQ+wGE4eqQq5btwwnW5ZXEQujOijs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-V8FJBMDaM46cnhjP0O-tGw-1; Mon,
 24 Feb 2025 09:45:33 -0500
X-MC-Unique: V8FJBMDaM46cnhjP0O-tGw-1
X-Mimecast-MFC-AGG-ID: V8FJBMDaM46cnhjP0O-tGw_1740408332
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A2D21801A15;
	Mon, 24 Feb 2025 14:45:32 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 922E119560AA;
	Mon, 24 Feb 2025 14:45:31 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 10/12] iomap: remove unnecessary advance from iomap_iter()
Date: Mon, 24 Feb 2025 09:47:55 -0500
Message-ID: <20250224144757.237706-11-bfoster@redhat.com>
In-Reply-To: <20250224144757.237706-1-bfoster@redhat.com>
References: <20250224144757.237706-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

At this point, all iomap operations have been updated to advance the
iomap_iter directly before returning to iomap_iter(). Therefore, the
complexity of handling both the old and new semantics is no longer
required and can be removed from iomap_iter().

Update iomap_iter() to expect success or failure status in
iter.processed. As a precaution and developer hint to prevent
inadvertent use of old semantics, warn on a positive return code and
fail the operation. Remove the unnecessary advance and simplify the
termination logic.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/iter.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 0ebcabc7df52..e4dfe64029cc 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -60,9 +60,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
 int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 {
 	bool stale = iter->iomap.flags & IOMAP_F_STALE;
-	ssize_t advanced = iter->processed > 0 ? iter->processed : 0;
-	u64 olen = iter->len;
-	s64 processed;
+	ssize_t advanced;
+	u64 olen;
 	int ret;
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
@@ -71,14 +70,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 		goto begin;
 
 	/*
-	 * If iter.processed is zero, the op may still have advanced the iter
-	 * itself. Calculate the advanced and original length bytes based on how
-	 * far pos has advanced for ->iomap_end().
+	 * Calculate how far the iter was advanced and the original length bytes
+	 * for ->iomap_end().
 	 */
-	if (!advanced) {
-		advanced = iter->pos - iter->iter_start_pos;
-		olen += advanced;
-	}
+	advanced = iter->pos - iter->iter_start_pos;
+	olen = iter->len + advanced;
 
 	if (ops->iomap_end) {
 		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
@@ -89,27 +85,22 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 			return ret;
 	}
 
-	processed = iter->processed;
-	if (processed < 0) {
-		iomap_iter_reset_iomap(iter);
-		return processed;
-	}
+	/* detect old return semantics where this would advance */
+	if (WARN_ON_ONCE(iter->processed > 0))
+		iter->processed = -EIO;
 
 	/*
-	 * Advance the iter and clear state from the previous iteration. This
-	 * passes iter->processed because that reflects the bytes processed but
-	 * not yet advanced by the iter handler.
-	 *
 	 * Use iter->len to determine whether to continue onto the next mapping.
-	 * Explicitly terminate in the case where the current iter has not
+	 * Explicitly terminate on error status or if the current iter has not
 	 * advanced at all (i.e. no work was done for some reason) unless the
 	 * mapping has been marked stale and needs to be reprocessed.
 	 */
-	ret = iomap_iter_advance(iter, &processed);
-	if (!ret && iter->len > 0)
-		ret = 1;
-	if (ret > 0 && !advanced && !stale)
+	if (iter->processed < 0)
+		ret = iter->processed;
+	else if (iter->len == 0 || (!advanced && !stale))
 		ret = 0;
+	else
+		ret = 1;
 	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
 		return ret;
-- 
2.48.1


