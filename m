Return-Path: <linux-fsdevel+bounces-37314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D39F0F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5994C164700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EFE1E25F7;
	Fri, 13 Dec 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL0KiBKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBE1E2307
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100474; cv=none; b=g5h2qNHG7TM2yYSq0iRtQLct3jweXC02I0FLv5gTYiE9NzojypGc2bsbQgWibsUmKqZR9WHukoFtu3KkpWXI9UvPznsVTgwNlOHRQGMhTbK3k62QtEAycm7qdV8sTzssgXmYxUGIb7sCP5+YhiYeBtB+Pj4RNYSu/kjou0oPC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100474; c=relaxed/simple;
	bh=VpcK74VQzHYA+NX8kvw5noZ7DBJzXn4eXuf/FfV4zJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9UEN3zptjeF9QlUbJHpw0kFPwe8pzZQXh/JFMnT2jo+PziVnqIKi+qidhOJItzkILnxO9OOetQDZLZxVVaFKEdcPFUKT8feC+DWZp3YcyMJp885DRXsslfRvbsbFRW3h+ykmqTVep5s2/emo4pfw4Mb+kVH3DO7Rs/TgWIwaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL0KiBKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYhRuj26be0LS/4XAkGR4xpbIjWtWXYTpjNftN6/7K0=;
	b=gL0KiBKu2+pwN3wbaykLRvYDv1HXu6HD+x+pVBF3PxR58jIdq5CS7cjC+x5LsTuoW1hU7Q
	ExbTFNVKY9d1hg9IJnDV/szRgzVsFOLPoOjrIfV4l/8YMO69yT0vywQpsZPKNEzb91jNwq
	UDrySNj+3m5jUgbcH6qzWvqcLjuU3VA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-nNyB6c4iNe2IvCPYuIqexQ-1; Fri,
 13 Dec 2024 09:34:28 -0500
X-MC-Unique: nNyB6c4iNe2IvCPYuIqexQ-1
X-Mimecast-MFC-AGG-ID: nNyB6c4iNe2IvCPYuIqexQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C55BA1956054;
	Fri, 13 Dec 2024 14:34:27 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DE99195605A;
	Fri, 13 Dec 2024 14:34:27 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 5/6] iomap: advance the iter directly on unshare range
Date: Fri, 13 Dec 2024 09:36:09 -0500
Message-ID: <20241213143610.1002526-6-bfoster@redhat.com>
In-Reply-To: <20241213143610.1002526-1-bfoster@redhat.com>
References: <20241213143610.1002526-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Modify unshare range to advance the iter directly. Replace the local
pos and length calculations with direct advances and loop based on
iter state instead.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3ece0bee803d..5e33e52eff15 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1268,18 +1268,16 @@ EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
 
 	if (!iomap_want_unshare_iter(iter))
-		return length;
+		return iomap_length(iter);
 
 	do {
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, length);
+		size_t bytes = min_t(u64, SIZE_MAX, iomap_length(iter));
+		loff_t pos = iter->pos;
 		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
@@ -1299,14 +1297,12 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 
 		cond_resched();
 
-		pos += bytes;
-		written += bytes;
-		length -= bytes;
+		iomap_iter_advance(iter, bytes);
 
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
-	} while (length > 0);
+	} while (iomap_length(iter) > 0);
 
-	return written;
+	return 0;
 }
 
 int
-- 
2.47.0


