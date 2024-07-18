Return-Path: <linux-fsdevel+bounces-23916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC3934DA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19543B23549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D313C8E5;
	Thu, 18 Jul 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEnF0k49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED01DFC7
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307695; cv=none; b=giPH3I7wgIdbEl9ptcFRsqtaRhvcF3W4xw3Fx6y99zaBwf1NbzKw+c4Gdzv/6x++22FFMp7rwlQp9sH0Gq0wymBTaIXCdPTBGmTEOnf4IW2BQn0VfMbni6kYXPe7ut6eIMe3poj/ZDqaNFSf2I2QdkUBc7DA5w9tWvFoYoFz6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307695; c=relaxed/simple;
	bh=tN33hKIpRs5sWw9AsupKYf+uzWW0a95CugBsXTfqRqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G49O+A1oxUk4GTRWWW0laoM6adfE2ydofCib9ogSLDITw+zk5mZ1NrjcnlZ/LyaYAjpmdalUBE8cH6e5ZpZ/1Rle/iB6caynIRxLXAE/t1tAU/AZ5/YCa92ppgIFxTLFWwg7Ctq2NH/12rG99wvvbnG4g5kmsDZ7Ryo1ExC1cZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEnF0k49; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721307692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ma4I3Wz0WluGWqW9yq9eTuWH2xOM0InZUvlarO3itoQ=;
	b=AEnF0k49AjKEizIb1VP+7oVJLSlQ2LsGgXQF6LVKPKsdVHZNzw5gTPeDjfXjztw2Vz4svG
	B29JAuS4WLx0jFXO0XxCl1JCGlDveng9VaDmtgCARhhIoS5/PXjT9q9FDo30S50ImmJj6W
	OuxxtjZFxhAvEEISpw/LRcPdyIdsYA4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-b6B1lnHEPlmv1tDiQhi6rA-1; Thu,
 18 Jul 2024 09:01:30 -0400
X-MC-Unique: b6B1lnHEPlmv1tDiQhi6rA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A25B11956088;
	Thu, 18 Jul 2024 13:01:29 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98CB61956046;
	Thu, 18 Jul 2024 13:01:28 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] iomap: refactor an iomap_revalidate() helper
Date: Thu, 18 Jul 2024 09:02:10 -0400
Message-ID: <20240718130212.23905-3-bfoster@redhat.com>
In-Reply-To: <20240718130212.23905-1-bfoster@redhat.com>
References: <20240718130212.23905-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The buffered write path revalidates the mapping on each folio lock
cycle. If the mapping has changed since the last lookup, the mapping
is marked stale and the operation must break back out into the
lookup path to update the mapping.

The zero range path will need to do something similar for correct
handling of dirty folios over unwritten ranges. Factor out the
validation callback into a new helper that marks the mapping stale
on failure.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d46558990279..a9425170df72 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -756,6 +756,22 @@ static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
 	}
 }
 
+/*
+ * Check whether the current mapping of the iter is still valid. If not, mark
+ * the mapping stale.
+ */
+static inline bool iomap_revalidate(struct iomap_iter *iter)
+{
+	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	bool iomap_valid = true;
+
+	if (folio_ops && folio_ops->iomap_valid)
+		iomap_valid = folio_ops->iomap_valid(iter->inode, &iter->iomap);
+	if (!iomap_valid)
+		iter->iomap.flags |= IOMAP_F_STALE;
+	return iomap_valid;
+}
+
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct folio *folio)
 {
@@ -768,7 +784,6 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
 static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio **foliop)
 {
-	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	struct folio *folio;
 	int status = 0;
@@ -797,15 +812,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	 * could do the wrong thing here (zero a page range incorrectly or fail
 	 * to zero) and corrupt data.
 	 */
-	if (folio_ops && folio_ops->iomap_valid) {
-		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
-							 &iter->iomap);
-		if (!iomap_valid) {
-			iter->iomap.flags |= IOMAP_F_STALE;
-			status = 0;
-			goto out_unlock;
-		}
-	}
+	if (!iomap_revalidate(iter))
+		goto out_unlock;
 
 	if (pos + len > folio_pos(folio) + folio_size(folio))
 		len = folio_pos(folio) + folio_size(folio) - pos;
-- 
2.45.0


