Return-Path: <linux-fsdevel+bounces-41219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0AA2C565
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36C11889C2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D42451D2;
	Fri,  7 Feb 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjKpD23F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA723F287
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938646; cv=none; b=FaOiuTVmEr9tjAJ1wG7bYYYEFLNCXnDqp0BVnc1WMwa3+icPDXIxUeGBsLhrW+wcULchk5aNXSDlrd2Po5SGcdqVYw675T37S1N4pe6K0umRGNA3uaWdtwwVNCxaFzea7MxdYeQuFsEIL4eq8SBykT2bLr1fcU7ZnQB+6KxyHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938646; c=relaxed/simple;
	bh=FFcgmenx/0RdTR7maZQRTg4bw6Gic5CEQrlWUOJm5mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5GZoz15lGR3oGvz0MgOkA/YloK86BFAPEpIqUxFn/0lJFDCs+56fbrW1mn6c/cjme1km6mGDFHbD2ksIU7D64Co6ATm/x+mgyIGQ8FWMtJ1aGXTgCsNiRIZQYJfcbj2D8ykA6dYCKgRZH+eaKyQPMhovBTzmaxpGa3qP5L4/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjKpD23F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iEBdn1OtEuG9frfz25/qabWbSAG8C/EGWDbx5jQedg=;
	b=CjKpD23FrpE1tHV5eUuxihbiUClnmbM8huI9DhwdS/5OqWo8eAeH8wSaJHZBe8/ySPX1QG
	CAyYM6hd+2/586PmE730bHW3oyQeoNn4nG/psytOcAlqEyYKgEoRW6fUYJfForg8tM7slT
	rx1z7TjU+8sxmXKjjCVbSjrtt17nXm0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-YD-73CR7OrmZijgIK-OLPw-1; Fri,
 07 Feb 2025 09:30:38 -0500
X-MC-Unique: YD-73CR7OrmZijgIK-OLPw-1
X-Mimecast-MFC-AGG-ID: YD-73CR7OrmZijgIK-OLPw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE8B1956096;
	Fri,  7 Feb 2025 14:30:37 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 752BB180087B;
	Fri,  7 Feb 2025 14:30:36 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v6 08/10] iomap: advance the iter directly on buffered writes
Date: Fri,  7 Feb 2025 09:32:51 -0500
Message-ID: <20250207143253.314068-9-bfoster@redhat.com>
In-Reply-To: <20250207143253.314068-1-bfoster@redhat.com>
References: <20250207143253.314068-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


