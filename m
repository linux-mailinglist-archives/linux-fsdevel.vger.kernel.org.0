Return-Path: <linux-fsdevel+bounces-41596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA31A327B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48B63A428E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273F20F06B;
	Wed, 12 Feb 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ed94YXJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D620F08E
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368504; cv=none; b=PsL6EGKJurVuUBLsvnLytu39pdyASCJd+JmCeHxDrSmHhfzNHI0tQbQxQeGlJkQjMuXYLWUNmr142KoAxVqUifWyecVvvnFs8LXynRQy1YhOYCSgc8MO5XOonod2UdzMfPKbt6qind7mIWKDw/qtwaKKgMEG0FV/89ONSsO0cbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368504; c=relaxed/simple;
	bh=wZocs5mOUOJ+TlTcBxDM69hLj9fXjrxceDAHj/K5GIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCy0HEiyZP/lYopWEbBElrCtltNOoXbUIySPOGkwJ7sYNOU2lgtj6u+P7zrRz+2nWS3ZyiuwtMdzseB+1KCHq018LncGaD+ziCxLoTRY9zoYzzuLhuzYc2tUscHSO/3HHrsg4LFMGtvP8Au0GIw6AQmgGxfdevN5SOeq0Kjms9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ed94YXJx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739368502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muK/bdU+k1VahRDlOLNbg1jEYHDNB8xWcVNTZs/j96M=;
	b=ed94YXJxgcrYxvGOHkmAa56YJ/Usmq4bl6sdWrOKd+H4MpuVrWqwZ9rw48genP4xbo+/xK
	4q3wGzYSpW32F9dmc5rP5tUUZnSN/cQEWYYkePl25JwOAKss7eNBuKysIRp09cheJiWfxP
	2xNykQ+ibmYtYGRvabVzNd/YApXfZ8w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-msijBRnCPpyl8NnfBctznQ-1; Wed,
 12 Feb 2025 08:54:58 -0500
X-MC-Unique: msijBRnCPpyl8NnfBctznQ-1
X-Mimecast-MFC-AGG-ID: msijBRnCPpyl8NnfBctznQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C80C1955D82;
	Wed, 12 Feb 2025 13:54:57 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A90AA3001D10;
	Wed, 12 Feb 2025 13:54:56 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 09/10] iomap: remove unnecessary advance from iomap_iter()
Date: Wed, 12 Feb 2025 08:57:11 -0500
Message-ID: <20250212135712.506987-10-bfoster@redhat.com>
In-Reply-To: <20250212135712.506987-1-bfoster@redhat.com>
References: <20250212135712.506987-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
---
 fs/iomap/iter.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 0ebcabc7df52..1e2e5c834582 100644
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
@@ -89,26 +85,20 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
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
+	ret = (iter->len > 0) ? 1 : 0;
+	if (iter->processed < 0)
+		ret = iter->processed;
+	else if (!advanced && !stale)
 		ret = 0;
 	iomap_iter_reset_iomap(iter);
 	if (ret <= 0)
-- 
2.48.1


