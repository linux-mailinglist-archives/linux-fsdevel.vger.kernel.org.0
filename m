Return-Path: <linux-fsdevel+bounces-48249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC1AAC6AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546EA167B17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471662820A1;
	Tue,  6 May 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Glyk7sDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAC281374
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538695; cv=none; b=JkDS0is/ZlOiuRVPkTKb2NtXUR/9+fkmfjZb0cTi9NC6Kc+NX639fOSj+U5BdD08ATtKlllnnjx0cS9jI8P7UaTv5flsPk2aBhyzN+fqZOaiJmqXLJI5z3BUX5aSmmX1xU6vs5Ho/BUap+dSyzAdh66BUu3Y0s+mD8evoytN33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538695; c=relaxed/simple;
	bh=MMVviPSlP/vPbMGSGiYe2a+T1n//0zqABZ2BKh6r5gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJWNOIBSJdjyrspH0Pu3zd+2H5XxaKzmUzwZq37w0Ol7JoFENvVdSBV51qQ0Ee+YhwigPcz6rPLHSg7Cjy+D22uwx89CjIwdaMYCPubMCSbihFzlnS0ucB00Z8a91WwUlD5R6lrBodqHRCHzy0kc2gMbpczU80MC+1pyWBrS9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Glyk7sDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746538692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czXXYz/vQMki+x26lIMj8SNqKLsMEA0Brv2HdqygA14=;
	b=Glyk7sDgj14yFSRJKQUHskQyquk243r/vohKKh9n04ZI96UglHJCqOAh2De4L75ChQB20L
	WonI6kbWydN41nHp6Ad05jAYP3qfKRQCpK8mgaaK3vr9j0eZHos+rDQZkVrHCYl2xzSrAU
	kaJI7b+dBeau6GdH1xBSuV/j+1yzspI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-AB_jXUYmOq-MoFIP0KqMUA-1; Tue,
 06 May 2025 09:38:11 -0400
X-MC-Unique: AB_jXUYmOq-MoFIP0KqMUA-1
X-Mimecast-MFC-AGG-ID: AB_jXUYmOq-MoFIP0KqMUA_1746538690
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72F2E1955DC0;
	Tue,  6 May 2025 13:38:10 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 834D619560A3;
	Tue,  6 May 2025 13:38:09 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH v2 3/6] iomap: drop pos param from __iomap_[get|put]_folio()
Date: Tue,  6 May 2025 09:41:15 -0400
Message-ID: <20250506134118.911396-4-bfoster@redhat.com>
In-Reply-To: <20250506134118.911396-1-bfoster@redhat.com>
References: <20250506134118.911396-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Both helpers take the iter and pos as parameters. All callers
effectively pass iter->pos, so drop the unnecessary pos parameter.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d1a50300a5dc..5c08b2916bc7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -741,10 +741,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	return 0;
 }
 
-static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
-		size_t len)
+static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	loff_t pos = iter->pos;
 
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
@@ -752,10 +752,11 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
 		return iomap_get_folio(iter, pos, len);
 }
 
-static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
+static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
 		struct folio *folio)
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
+	loff_t pos = iter->pos;
 
 	if (folio_ops && folio_ops->put_folio) {
 		folio_ops->put_folio(iter->inode, pos, ret, folio);
@@ -793,7 +794,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	folio = __iomap_get_folio(iter, pos, len);
+	folio = __iomap_get_folio(iter, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
@@ -834,7 +835,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
 	return 0;
 
 out_unlock:
-	__iomap_put_folio(iter, pos, 0, folio);
+	__iomap_put_folio(iter, 0, folio);
 
 	return status;
 }
@@ -983,7 +984,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			i_size_write(iter->inode, pos + written);
 			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 		}
-		__iomap_put_folio(iter, pos, written, folio);
+		__iomap_put_folio(iter, written, folio);
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
@@ -1295,7 +1296,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
 			bytes = folio_size(folio) - offset;
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
+		__iomap_put_folio(iter, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
@@ -1376,7 +1377,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		folio_mark_accessed(folio);
 
 		ret = iomap_write_end(iter, bytes, bytes, folio);
-		__iomap_put_folio(iter, pos, bytes, folio);
+		__iomap_put_folio(iter, bytes, folio);
 		if (WARN_ON_ONCE(!ret))
 			return -EIO;
 
-- 
2.49.0


