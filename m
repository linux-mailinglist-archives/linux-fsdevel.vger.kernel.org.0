Return-Path: <linux-fsdevel+bounces-47749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFEFAA5456
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714C91C03170
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7825E2DC791;
	Wed, 30 Apr 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qce18rns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5232641FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039502; cv=none; b=rl5a0wGCVuyPaq47DB4iCpYZ4VRQXUzT4KN/9B2xXvz6M5EcjNvoDp+8QblLQWQZJOoriUa/b7bRnwsewscg8HTGZtWOUIujxMycxm+ohxu5tNsZqiATUIlPLxTQGhevT/KebI8kqC81CTwEc98kWnStbxUmXg5sEeaqQytU/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039502; c=relaxed/simple;
	bh=H16izfbU3rUWjNofuEd4kJGOgWbS35wPWyAHHedhgY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjE6ImlQRp5EjN1Jh8IsVCG+y5ifwbMDnAbWBeJMKmABXRHxhBgXZpU3cKAbaehkorV58k9DiHs4ev+AvLXhX79zFGfV5eTifqquBUxEXyboGFd/EVUcitMjbzkmIdcugkbAlHUeIMkyfeb+4v+2dgxYibHshTNL7VGa/ASgknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qce18rns; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746039500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+KpeER9MCNi82ppVXGhwY3GQAKjwljSMvNmXkRrh6o=;
	b=Qce18rns0id6ByRz0/hh9K6CSoKVT8NVSb+4kDAiQ5V8LN88K6PlxnJ8zTw9QKKsIOUIg+
	fvI8xntvgHHSnzkMOIy2bA5eAqytd9S3d5dXqfIRYSpDfyYsW79SSwi5jO+XXy3AwlxiUm
	lU0XkqYlJHlvha/7H13KOc8ETH/wshs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-HuS3ENiOO6y0bj3T7YusWg-1; Wed,
 30 Apr 2025 14:58:03 -0400
X-MC-Unique: HuS3ENiOO6y0bj3T7YusWg-1
X-Mimecast-MFC-AGG-ID: HuS3ENiOO6y0bj3T7YusWg_1746039483
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07A351800368;
	Wed, 30 Apr 2025 18:58:03 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DEE719560A3;
	Wed, 30 Apr 2025 18:58:02 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 4/6] iomap: helper to trim pos/bytes to within folio
Date: Wed, 30 Apr 2025 15:01:10 -0400
Message-ID: <20250430190112.690800-5-bfoster@redhat.com>
In-Reply-To: <20250430190112.690800-1-bfoster@redhat.com>
References: <20250430190112.690800-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Several buffered write based iteration callbacks duplicate logic to
trim the current pos and length to within the current folio. Factor
this into a helper to make it easier to relocate closer to folio
lookup.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5c08b2916bc7..5ed3332e69dd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -766,6 +766,21 @@ static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
 	}
 }
 
+/* trim pos and bytes to within a given folio */
+static loff_t iomap_trim_folio_range(struct iomap_iter *iter,
+		struct folio *folio, size_t *offset, u64 *bytes)
+{
+	loff_t pos = iter->pos;
+	size_t fsize = folio_size(folio);
+
+	WARN_ON_ONCE(pos < folio_pos(folio) || pos >= folio_pos(folio) + fsize);
+
+	*offset = offset_in_folio(folio, pos);
+	if (*bytes > fsize - *offset)
+		*bytes = fsize - *offset;
+	return pos;
+}
+
 static int iomap_write_begin_inline(const struct iomap_iter *iter,
 		struct folio *folio)
 {
@@ -920,7 +935,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		struct folio *folio;
 		loff_t old_size;
 		size_t offset;		/* Offset into folio */
-		size_t bytes;		/* Bytes to write to folio */
+		u64 bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 		u64 written;		/* Bytes have been written */
 		loff_t pos;
@@ -959,11 +974,8 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
-		pos = iter->pos;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
+		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
 
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
@@ -1280,7 +1292,6 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 	do {
 		struct folio *folio;
 		size_t offset;
-		loff_t pos;
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
@@ -1289,11 +1300,8 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 			return status;
 		if (iomap->flags & IOMAP_F_STALE)
 			break;
-		pos = iter->pos;
 
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
+		iomap_trim_folio_range(iter, folio, &offset, &bytes);
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
 		__iomap_put_folio(iter, bytes, folio);
@@ -1356,7 +1364,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	do {
 		struct folio *folio;
 		size_t offset;
-		loff_t pos;
 		bool ret;
 
 		bytes = min_t(u64, SIZE_MAX, bytes);
@@ -1365,14 +1372,11 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 			return status;
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
-		pos = iter->pos;
 
 		/* warn about zeroing folios beyond eof that won't write back */
 		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
-		offset = offset_in_folio(folio, pos);
-		if (bytes > folio_size(folio) - offset)
-			bytes = folio_size(folio) - offset;
 
+		iomap_trim_folio_range(iter, folio, &offset, &bytes);
 		folio_zero_range(folio, offset, bytes);
 		folio_mark_accessed(folio);
 
-- 
2.49.0


