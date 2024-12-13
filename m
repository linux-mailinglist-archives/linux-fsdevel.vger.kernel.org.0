Return-Path: <linux-fsdevel+bounces-37312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CFB9F0F47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B73164590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390711E25E7;
	Fri, 13 Dec 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObCIjUaB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C031E2009
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100473; cv=none; b=OJyrfwVfS4+wR4IFm9JiUOo4iT7cl3gK6k8bAOiHTdw4IfdFgB1XvohCSeWgGRQKLTLjyrUUalRJr2Uj/9D79q3vWfKXmpIzSSzpHMzh6LsMR1kLrGy2PASJ59TH8FA0m0L4C8KULEE5mTwv4prJ6x+/B7iAdC9qVae1TNwkrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100473; c=relaxed/simple;
	bh=OKAIQS7yoj53v6aPmr/2QbPOoplwTQWSySIf6C79NBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiTsFMfqhKWn0nOiyCxcQQ5y2fAypSYZCxiU6iWwepiwCAQMkP4ye08ifJBTdnH76XHdQtSMIcOqSvC9lz3/6VQpWBwYuQhPbHSAkMB21kaB9iYWDK255KiOQYPLMCWufbw/RqsKHzvic1bKyHS6KuS6Xpqg7LyXMrjXXUZgZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObCIjUaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pofMAyHFR1hGi6iQD9ByZ17lIz/vNbdpdYcS8TQbk7Q=;
	b=ObCIjUaB7eoHoZ7Szu08iqtHfDcggO8xA/Bg/EXYvwE2p9WlIGOQLTq4WK2E6niS8eGDii
	Kl/EJoHItDubNFWaV30q++G/w7zybQh3BJtBIP+HSa5JHEWQscvPxL76cEjPYipCBH7ip9
	prDx1D4UVVeVacbjYZTx6uuB51HsfLE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-nsQQE1qkM8u7SQBDncD88Q-1; Fri,
 13 Dec 2024 09:34:27 -0500
X-MC-Unique: nsQQE1qkM8u7SQBDncD88Q-1
X-Mimecast-MFC-AGG-ID: nsQQE1qkM8u7SQBDncD88Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E21651955F09;
	Fri, 13 Dec 2024 14:34:26 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48485195605A;
	Fri, 13 Dec 2024 14:34:26 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH 4/6] iomap: advance the iter directly on buffered writes
Date: Fri, 13 Dec 2024 09:36:08 -0500
Message-ID: <20241213143610.1002526-5-bfoster@redhat.com>
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
---
 fs/iomap/buffered-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 955f19e27e47..3ece0bee803d 100644
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
@@ -924,6 +922,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 		size_t written;		/* Bytes have been written */
+		loff_t pos = iter->pos;
+		loff_t length = iomap_length(iter);
 
 		bytes = iov_iter_count(i);
 retry:
@@ -1006,17 +1006,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 				goto retry;
 			}
 		} else {
-			pos += written;
 			total_written += written;
-			length -= written;
+			iomap_iter_advance(iter, written);
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
2.47.0


