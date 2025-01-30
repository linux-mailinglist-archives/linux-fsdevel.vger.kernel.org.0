Return-Path: <linux-fsdevel+bounces-40413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D60A23279
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B327A21DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B3B1F03D3;
	Thu, 30 Jan 2025 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgjNEAPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2A1EF082
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256870; cv=none; b=u3WL6XrSzaVtK+yFA2V5rjvg3Q81AVFlFMntYocX3lwa+nGPrv/3JNY4XjyVduNLyKiT0rFgLhLqpkRzi+CippCqIA2guLOVSqbhF5LhGj4eqfV4yXFqsuy2qlf6QO/LUnBzBoUKvN4w53ngUqA9dOV3TYeOcizWVdW1SOWvm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256870; c=relaxed/simple;
	bh=L2mmDyh9vSnF5kPYcuSSCXwYdATDMPPUCAXCq1dipV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di/YO+MC5I5yYCYNlEBDo95oQ76f/L705igPYMUVOLzvxWes3Zhs9a0YhhM016bx/a+cZDoEifLLYertnZ5OBhCgsZ5da8gBFSS3Uaw/sliQ2quljrnYjObTOJjXXaNXw/ADXlfRXjg8dolytW6MrhhscmO6BObCc2EA0jQd+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgjNEAPY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738256866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJEIx2LIRNUN4l5wUAEOnQB79yzRujfzjRc/PncFlt4=;
	b=FgjNEAPYYsgWv8Fm5e8QbbRhi8mwSDj0SBN3k4zvzjfPIwN/LTy8maI47Q98hubtzapG5l
	oD5sXgS23Z5d8QkTdVhfQxiS1mdYE7xaKX7Key20WRxX3bDhDvExOfNVt2RU8uhSA94pqR
	4AR7hOQQQyjcGOTN3eiCQ3jZUJFjQtg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-6ACNbWsoNhuFF1WDXtdw7A-1; Thu,
 30 Jan 2025 12:07:44 -0500
X-MC-Unique: 6ACNbWsoNhuFF1WDXtdw7A-1
X-Mimecast-MFC-AGG-ID: 6ACNbWsoNhuFF1WDXtdw7A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7E921956087;
	Thu, 30 Jan 2025 17:07:43 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 278163003FD1;
	Thu, 30 Jan 2025 17:07:43 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 7/7] iomap: advance the iter directly on zero range
Date: Thu, 30 Jan 2025 12:09:48 -0500
Message-ID: <20250130170949.916098-8-bfoster@redhat.com>
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

Modify zero range to advance the iter directly. Replace the local pos
and length calculations with direct advances and loop based on iter
state instead.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f953bf66beb1..ec227b45f3aa 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1345,17 +1345,16 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
+	u64 bytes = iomap_length(iter);
+	int status;
 
 	do {
 		struct folio *folio;
-		int status;
 		size_t offset;
-		size_t bytes = min_t(u64, SIZE_MAX, length);
+		loff_t pos = iter->pos;
 		bool ret;
 
+		bytes = min_t(u64, SIZE_MAX, bytes);
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (status)
 			return status;
@@ -1376,14 +1375,14 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-		pos += bytes;
-		length -= bytes;
-		written += bytes;
-	} while (length > 0);
+		status = iomap_iter_advance(iter, &bytes);
+		if (status)
+			break;
+	} while (bytes > 0);
 
 	if (did_zero)
 		*did_zero = true;
-	return written;
+	return status;
 }
 
 int
@@ -1436,11 +1435,14 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 
 		if (srcmap->type == IOMAP_HOLE ||
 		    srcmap->type == IOMAP_UNWRITTEN) {
-			loff_t proc = iomap_length(&iter);
+			s64 proc;
 
 			if (range_dirty) {
 				range_dirty = false;
 				proc = iomap_zero_iter_flush_and_stale(&iter);
+			} else {
+				u64 length = iomap_length(&iter);
+				proc = iomap_iter_advance(&iter, &length);
 			}
 			iter.processed = proc;
 			continue;
-- 
2.47.1


