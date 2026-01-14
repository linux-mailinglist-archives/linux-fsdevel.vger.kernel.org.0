Return-Path: <linux-fsdevel+bounces-73628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D531D1CE92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE041301C368
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3A37A4B7;
	Wed, 14 Jan 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJZ7gLMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9536379998;
	Wed, 14 Jan 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376548; cv=none; b=TLuy0LYAGNikMytnURTmu5S8fgPHSwI6cXJxPLWNsIj3lIv0b97gfPe6gRdqt6QKHaMj5O1hRsJ1W+3Xc+lSxL/t+It303hIf8B3ChaLcpUrjqWVuuupqy/tKU5Tz7g+ljQacqDRwdEg79yFCNt4gq0Rb15cbOXdJ5IRokNzZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376548; c=relaxed/simple;
	bh=WXFBGVuEKVa5Y5rTs2q/RWbCU6VknnF6z7KfzDebgBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOoVkbKZGZCuPA8X/WSfkSG5tVDT4iRB563yEh30g4louE2VpZgQeubIiy4PFDurURYKmtp5OZw72cXW2VabBffbEoVV4FudMQAjdI4nkoSDBdUqVnYHhb+oMzWGt7P059M9qGlAjNIZwVGCxJikI8nyn7YAcH1yB3DvKAQwazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nJZ7gLMW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=a8amlpbObIV9Cpkvjr+9KF2qPfwfnnWFE4iZJB+y1rQ=; b=nJZ7gLMWZbxfz0iexTZiCe9H8o
	IKHD1Isdu8yr1aMDh10GPiEUjtrPduWYPQKyp0/MWRtAhvHBCVKnrElrRGtjWi91zym/V8HnsDn1j
	9FFVKCWX5D7vQzYJY6BN8QCONPieI8eoxdv6kcm8fVIn9p13gxRxBri7ictwS8llTFC7VDxtsa4j8
	2BdiALSXlKSvfpTb2IyqrfD2dUXGr8KkD1roB7KClHjbGGKdh/gR6DJHPOm/bD/VDme2UAMEBhcsN
	vt6mg6gllmcWCUfn4lmgzUE9yfPCmmoN09Ik2zupzA5bYAVjJ4sOiDsQVroSWE6Iqn9tYuhIS0Mmi
	B+EOgb0Q==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWJ-00000008Dsw-1z3y;
	Wed, 14 Jan 2026 07:42:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/14] iomap: fix submission side handling of completion side errors
Date: Wed, 14 Jan 2026 08:41:04 +0100
Message-ID: <20260114074145.3396036-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The "if (dio->error)" in iomap_dio_bio_iter exists to stop submitting
more bios when a completion already return an error.  Commit cfe057f7db1f
("iomap_dio_actor(): fix iov_iter bugs") made it revert the iov by
"copied", which is very wrong given that we've already consumed that
range and submitted a bio for it.

Fixes: cfe057f7db1f ("iomap_dio_actor(): fix iov_iter bugs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8e273408453a..6ec4940e019c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -442,9 +442,13 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
-		if (dio->error) {
-			iov_iter_revert(dio->submit.iter, copied);
-			copied = ret = 0;
+
+		/*
+		 * If completions already occurred and reported errors, give up now and
+		 * don't bother submitting more bios.
+		 */
+		if (unlikely(data_race(dio->error))) {
+			ret = 0;
 			goto out;
 		}
 
-- 
2.47.3


