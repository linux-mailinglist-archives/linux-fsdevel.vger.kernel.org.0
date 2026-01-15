Return-Path: <linux-fsdevel+bounces-73866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB0D22247
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4BC13015A49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066B260569;
	Thu, 15 Jan 2026 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cSKy71o1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E4258ED7;
	Thu, 15 Jan 2026 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444578; cv=none; b=q01nLnbEF1A/1tWtsYrr8if8RRvSSo8M2JLecKC0RwzIBf0BrfnK469f9mbHMk3UQ6WVsUncveAvjUWZYe6o6yxPwPY7JlVmexg1TCTGlgUi9xdZUgI6xbPt5Ps0UNHD9TCMfzAWSW4GLD+9bRi5XtxuU4Yw5uRiT/KY1njZdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444578; c=relaxed/simple;
	bh=KZpinX3RiivWcfdAw7wQOKcAUe67ijTBUBtKTqVy9K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FpfIIGHuHHVg2afRmTFx1kdQ0ocrGIDn40Mr0owJVdjPEn9uBKXFR2AJAjyfJrYLCHyR9LvH3WsFFjmCrSR/aY+lLahdDNJaabG0/rbNqywzG+CX32nDchqnwI2mwz0Nwl+k1Fs5a5WZCAkC4NWuhm8O1EqZOvWhMaY+VN2mKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cSKy71o1; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768444568; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IgRImgNWDmTVO+fH6eIxyTunq1UJJ6/Ba6iabchJk2c=;
	b=cSKy71o1oosR5lUAhuU7V531gZSbQdZPK/sAnk9Qk9q8BIo6CJMD2udcgrW2FHeQ4TbzKAbKwvQPWEBrOO2a+MzTMIAxzokgan7FLLZotWo3re33JBubPBtKcXnj7dsnXGLuk7JUShxG97VsTmFUaybJ7jClRNcGNfaSQsbJ1sQ=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx4vaSl_1768444567 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Jan 2026 10:36:08 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com
Cc: linux-kernel@vger.kernel.org,
	horst@birthelmer.de,
	joseph.qi@linux.alibaba.com
Subject: [PATCH v3] fuse: fix premature writetrhough request for large folio
Date: Thu, 15 Jan 2026 10:36:07 +0800
Message-Id: <20260115023607.77349-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When large folio is enabled and the initial folio offset exceeds
PAGE_SIZE, e.g. the position resides in the second page of a large
folio, after the folio copying the offset (in the page) won't be updated
to 0 even though the expected range is successfully copied until the end
of the folio.  In this case fuse_fill_write_pages() exits prematurelly
before the request has reached the max_write/max_pages limit.

Fix this by eliminating page offset entirely and use folio offset
instead.

Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since v2:
- drop stable CC tag; add Reviewed-by tag by Joanne

v1: https://lore.kernel.org/all/20260114055615.17903-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20260114124514.62998-1-jefflexu@linux.alibaba.com/
---
 fs/fuse/file.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 625d236b881b..6aafb32338b6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1272,7 +1272,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 {
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
-	unsigned offset = pos & (PAGE_SIZE - 1);
 	size_t count = 0;
 	unsigned int num;
 	int err = 0;
@@ -1299,7 +1298,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		folio_offset = offset_in_folio(folio, pos);
 		bytes = min(folio_size(folio) - folio_offset, num);
 
 		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
@@ -1329,9 +1328,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		count += tmp;
 		pos += tmp;
 		num -= tmp;
-		offset += tmp;
-		if (offset == folio_size(folio))
-			offset = 0;
 
 		/* If we copied full folio, mark it uptodate */
 		if (tmp == folio_size(folio))
@@ -1343,7 +1339,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			ia->write.folio_locked = true;
 			break;
 		}
-		if (!fc->big_writes || offset != 0)
+		if (!fc->big_writes)
+			break;
+		if (folio_offset + tmp != folio_size(folio))
 			break;
 	}
 
-- 
2.19.1.6.gb485710b


