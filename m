Return-Path: <linux-fsdevel+bounces-40921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FAA28D0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4D93A2AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C305158870;
	Wed,  5 Feb 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUSQ3nfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E007153800
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763773; cv=none; b=FFQqFmEzM9lixOIPa6TTfp3c+I2usiTy9cGoi0wpUoLU3hHH3g+aUEYguE3sBQBmr87n5weJRW/XED+v0JM+Ky5AHcP0pO65pYvUnbsQGwtPkGgSkmc3M7oLQH5iZuUzMvv2lR8wvZZzutWoq8Gtijv/DN8I+J854lG0UCdhDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763773; c=relaxed/simple;
	bh=UcAm6rsMIM9QBcPOs1SVXZ/L9UMYn03KefOeFm7wS7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxACNLJ4IX6I46iAEULuqAMd4YXe3e/sqsGt//oR63Jxd/PwVBnp7TEMIb2oodvQg/OD13aj9yCEFFdPNLmOQF0Y2TdIsFsEnQfX1zCtKPRQXKfTq9WSGXovgM+Uhtt3dOiigkA98WDwiTtS+sKnZJNYNdyH5XaEDzcKaPUviNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUSQ3nfA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738763771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIWtOvdoUkrnvvQSyevKEbxDCbg8LTPjKPz4J+KrnHk=;
	b=VUSQ3nfASC7Z651akFcyPNaTlK74kRjoaU5MvHW7tX1MCg6hYQdFy+Cq7pifMXKqtwRGo2
	Ma9M/tndl7/VR0U9YfOzTjiCe5Umt+Z6hvt7Ob+46ugYndxbPXe1LK2iKgrF4xvKAyyAwF
	sJ8FeVS6KaRu9GeRp5WR0SfrmDViTZI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-K8-yxXTFOeSpaqGdQZYdvQ-1; Wed,
 05 Feb 2025 08:56:07 -0500
X-MC-Unique: K8-yxXTFOeSpaqGdQZYdvQ-1
X-Mimecast-MFC-AGG-ID: K8-yxXTFOeSpaqGdQZYdvQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEAF01955DD0;
	Wed,  5 Feb 2025 13:56:06 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3071300018D;
	Wed,  5 Feb 2025 13:56:04 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v5 08/10] iomap: advance the iter directly on buffered writes
Date: Wed,  5 Feb 2025 08:58:19 -0500
Message-ID: <20250205135821.178256-9-bfoster@redhat.com>
In-Reply-To: <20250205135821.178256-1-bfoster@redhat.com>
References: <20250205135821.178256-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Modify the buffered write path to advance the iter directly. Replace
the local pos and length calculations with direct advances and loop
based on iter state instead.

Also remove the -EAGAIN return hack as it is no longer necessary now
that separate return channels exist for processing progress and error
returns. For example, the existing write handler must return either a
count of bytes written or error if the write is interrupted, but
presumably wants to return -EAGAIN directly in order to break the higher
level iomap_iter() loop.

Since the current iteration may have made some progress, it unwinds the
iter on the way out to return the error while ensuring that portion of
the write can be retried. If -EAGAIN occurs at any point beyond the
first iteration, iomap_file_buffered_write() will then observe progress
based on iter->pos to return a short write.

With incremental advances on the iomap_iter, iomap_write_iter() can
simply return the error. iomap_iter() completes whatever progress was
made based on iomap_iter position and still breaks out of the iter loop
based on the error code in iter.processed. The end result of the write
is similar in terms of being a short write if progress was made or error
return otherwise.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d303e6c8900c..678c189faa58 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -909,8 +909,6 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
-	loff_t length = iomap_length(iter);
-	loff_t pos = iter->pos;
 	ssize_t total_written = 0;
 	long status = 0;
 	struct address_space *mapping = iter->inode->i_mapping;
@@ -923,7 +921,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
-		size_t written;		/* Bytes have been written */
+		u64 written;		/* Bytes have been written */
+		loff_t pos = iter->pos;
 
 		bytes = iov_iter_count(i);
 retry:
@@ -934,8 +933,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (unlikely(status))
 			break;
 
-		if (bytes > length)
-			bytes = length;
+		if (bytes > iomap_length(iter))
+			bytes = iomap_length(iter);
 
 		/*
 		 * Bring in the user page that we'll copy from _first_.
@@ -1006,17 +1005,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 				goto retry;
 			}
 		} else {
-			pos += written;
 			total_written += written;
-			length -= written;
+			iomap_iter_advance(iter, &written);
 		}
-	} while (iov_iter_count(i) && length);
+	} while (iov_iter_count(i) && iomap_length(iter));
 
-	if (status == -EAGAIN) {
-		iov_iter_revert(i, total_written);
-		return -EAGAIN;
-	}
-	return total_written ? total_written : status;
+	return total_written ? 0 : status;
 }
 
 ssize_t
-- 
2.48.1


