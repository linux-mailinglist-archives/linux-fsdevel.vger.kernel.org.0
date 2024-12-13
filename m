Return-Path: <linux-fsdevel+bounces-37313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9FA9F0F49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C791880311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790331E25EC;
	Fri, 13 Dec 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwYRSq5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12E1E22E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100473; cv=none; b=Y/37Xv5cWI61PAZM3UCz+qYBZHODRKgOhabCUdumriUlJD620nVKfg5WnLmfO++xaY3HyeorvgNkPUev3J5K8dtBlz+FjBqCjThkSLQq5PfdQYUdkQK7+Fi6JYCe6lD2priL0F1oxTXnmtOjFmHlLLxqb9GbOdYlNArOXmQHMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100473; c=relaxed/simple;
	bh=peow5fQTuWi8AJxKriqerb0wfKWZpsGa0STw8wGnGNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJxoURxGaW97CZYJTGwF5aV1NsenfujXE7CfDaMVzj9EecZMLCp1X+Lo+ggorlnoM/aDZTX0ljoSSml3lLltU0tFptPQc9M0aY3i9s4SJd5OYG895h0xbTSlPPzwyes78p7sPp71r8an5ukZnxTQXtwj209hZMRcJd1siYyOF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwYRSq5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2VEA2dRQqqSc04MHk0RHgROz3bcefB7YZh9xI6D7Dc=;
	b=FwYRSq5rNVjM/bUwYlJEd4aQzlECBvVk84NKD1/J4KqFe71Dgvl2SfVU6hwadN6A3GPDPb
	e6CsR0CPPr+5rhXsFWG8uuOXQYKa8PLMZDNMTvMwUWX/1zpl1XERB0AWesJtbSewmDcY8I
	wOUSFWuSG/kKgvlDbTC/sXiSwLDVSf8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-6o--Zv1yN12de_I3ZUKIgQ-1; Fri,
 13 Dec 2024 09:34:29 -0500
X-MC-Unique: 6o--Zv1yN12de_I3ZUKIgQ-1
X-Mimecast-MFC-AGG-ID: 6o--Zv1yN12de_I3ZUKIgQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC13B1955BF4;
	Fri, 13 Dec 2024 14:34:28 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 127F91955F3C;
	Fri, 13 Dec 2024 14:34:27 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 6/6] iomap: advance the iter directly on zero range
Date: Fri, 13 Dec 2024 09:36:10 -0500
Message-ID: <20241213143610.1002526-7-bfoster@redhat.com>
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

Modify zero range to advance the iter directly. Replace the local pos
and length calculations with direct advances and loop based on iter
state instead.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5e33e52eff15..e0ae46b11413 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1343,15 +1343,12 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
-
 	do {
 		struct folio *folio;
 		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, length);
+		size_t bytes = min_t(u64, SIZE_MAX, iomap_length(iter));
+		loff_t pos = iter->pos;
 		bool ret;
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
@@ -1374,14 +1371,12 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-		pos += bytes;
-		length -= bytes;
-		written += bytes;
-	} while (length > 0);
+		iomap_iter_advance(iter, bytes);
+	} while (iomap_length(iter) > 0);
 
 	if (did_zero)
 		*did_zero = true;
-	return written;
+	return 0;
 }
 
 int
-- 
2.47.0


