Return-Path: <linux-fsdevel+bounces-74396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E33CFD3A063
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 959E2302C844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72684338597;
	Mon, 19 Jan 2026 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXIgQixn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDA3382CD;
	Mon, 19 Jan 2026 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808722; cv=none; b=B3MRNkLIjl2LiiLD+eXlQPrtsNX0bBX0VdEX9xNqcL0yocTJRxEEXV7VDWJoZdYGBwVe1c79865gtEZQMkQ29w9biuzsufLCZ99xIHxfJ9wE+k33ZzvjU7n7i92T74yWWXIdXpTUYsOjTRxDh6SRFgDH+a/ZMPmxE0nNdnz+Lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808722; c=relaxed/simple;
	bh=FNUv1CYsNEnEhtwOJEnRHVJYDxMA9FVo7XjiHb+aPVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy6MgC4vdumSojTwCiuTUBneDbXyql7Yljr1sPuD7WIZX/M+hXMADvFQaOU1Ag+M745OV4T/31S2Q27DRSYhfEKclE2JR2f7IztWFCIhVl3/vftuhn+6NqvItXVZ9zQlKT3LYE7hqgBpJw5cjfcKL5LEsqLyEiwbZI6NHoub1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DXIgQixn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+qI3pKjNl/z77yOqmbRNbRVV0KWFN6Jkw/4ll+YcX7c=; b=DXIgQixnrS7KI9TTyOl7+jZCKi
	aR0QaK/MQmld+hXvU5uPDrBioCSKkShI7aerOzWiVXvM/31w83TJcZP6aoJHDivtE5xQvlIXXOwHZ
	PRaJvnQE8du2xO8yM0la7ytGe8jn9X+hTs/hU96V+dH0eJGkKm1x8WN30b3F3VG/Msgywg03eJxER
	mAtSQlsSqRyuDyxnyHRM0SYwxG3fGhIV2/OTenOh8pYlgj792hYsMKNyYRcLygAG1md59s2/lgMsD
	ao9pndGOAlUpnSOXjQyYXL7+BqPobi2iL0rnZzqlQH+8SBw8GjvoA4yaDF3+XMHIaPoH1GlyUn2p2
	yHaXZfhg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwu-00000001WFs-1PMh;
	Mon, 19 Jan 2026 07:45:20 +0000
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
Subject: [PATCH 11/14] iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
Date: Mon, 19 Jan 2026 08:44:18 +0100
Message-ID: <20260119074425.4005867-12-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Match the more descriptive iov_iter terminology instead of encoding
what we do with them for reads only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d4d52775ce25..eca7adda595a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -22,7 +22,7 @@
 #define IOMAP_DIO_WRITE_THROUGH	(1U << 28)
 #define IOMAP_DIO_NEED_SYNC	(1U << 29)
 #define IOMAP_DIO_WRITE		(1U << 30)
-#define IOMAP_DIO_DIRTY		(1U << 31)
+#define IOMAP_DIO_USER_BACKED	(1U << 31)
 
 struct iomap_dio {
 	struct kiocb		*iocb;
@@ -215,7 +215,7 @@ static void __iomap_dio_bio_end_io(struct bio *bio, bool inline_completion)
 {
 	struct iomap_dio *dio = bio->bi_private;
 
-	if (dio->flags & IOMAP_DIO_DIRTY) {
+	if (dio->flags & IOMAP_DIO_USER_BACKED) {
 		bio_check_pages_dirty(bio);
 	} else {
 		bio_release_pages(bio, false);
@@ -333,7 +333,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 
 	if (dio->flags & IOMAP_DIO_WRITE)
 		task_io_account_write(ret);
-	else if (dio->flags & IOMAP_DIO_DIRTY)
+	else if (dio->flags & IOMAP_DIO_USER_BACKED)
 		bio_set_pages_dirty(bio);
 
 	/*
@@ -679,7 +679,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_dio;
 
 		if (user_backed_iter(iter))
-			dio->flags |= IOMAP_DIO_DIRTY;
+			dio->flags |= IOMAP_DIO_USER_BACKED;
 
 		ret = kiocb_write_and_wait(iocb, iomi.len);
 		if (ret)
-- 
2.47.3


