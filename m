Return-Path: <linux-fsdevel+bounces-42434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE04A42448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF4E3AA28E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4E25487F;
	Mon, 24 Feb 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGAu95vL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E525485D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408343; cv=none; b=RXjrL+VuCKHCPQmdluKpuEenKF9WA13IfKvvcxdVxPjTeQYVwaIDo1GARF2JMoo5Tmg1Fjnsrq91YqTP+QCpknbBphk65pahqnzs1jSPzdwCDvivGI+6k3hGVcR3o6yARUR3XcpiyAjdTeA4eDzjqpvjviHdjB9jPd8DAdyzncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408343; c=relaxed/simple;
	bh=qd+DPPrjfEZSipkx7wnFQXd8mlILrgwyRrIAcj39orc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiZBVJCUFamL2ai4x9xsrJaXIKgQBGz+P+bEBbRjlBec1Z3OL9YzQBFAaFI9WFmVallsB7nBaDXbqg3tdSrDZZHwLSE59HBq8SWtOJklcogrDjtUhXIwUYhYDgDKyg1ZduZV86Zca62b5+5x40SWw/lyiEdvu0ZmDiD2xvgKWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGAu95vL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgQ3VIkGdE45NDXBDEcgeqmVeOLGbGPsVjfG1DJKHBE=;
	b=bGAu95vLA0RJNBiL+qMSwQdzS/WbPumxXFoHEqvDOsKp17G8OPp15KoBzW80XBDhikN1Ii
	q3gl+/v/Xwvz97qXo+N+V5ahSdxSi4oYc2Q/aIHmNjAG1kuz09AeZ9PQ6EioEoJLLj7Jw+
	J+70HVIXuTUxCSg5oJC+HW2yKHrWTZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-u3QjCZaAMUiASlnewcNiKg-1; Mon,
 24 Feb 2025 09:45:32 -0500
X-MC-Unique: u3QjCZaAMUiASlnewcNiKg-1
X-Mimecast-MFC-AGG-ID: u3QjCZaAMUiASlnewcNiKg_1740408329
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A984218009B5;
	Mon, 24 Feb 2025 14:45:27 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAE2B19560AA;
	Mon, 24 Feb 2025 14:45:26 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 06/12] dax: advance the iomap_iter on zero range
Date: Mon, 24 Feb 2025 09:47:51 -0500
Message-ID: <20250224144757.237706-7-bfoster@redhat.com>
In-Reply-To: <20250224144757.237706-1-bfoster@redhat.com>
References: <20250224144757.237706-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Update the DAX zero range iomap iter handler to advance the iter
directly. Advance by the full length in the hole/unwritten case, or
otherwise advance incrementally in the zeroing loop. In either case,
return 0 or an error code for success or failure.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/dax.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 139e299e53e6..f4d8c8c10086 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1358,13 +1358,12 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
 	u64 length = iomap_length(iter);
-	s64 written = 0;
+	s64 ret;
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
-		return length;
+		return iomap_iter_advance(iter, &length);
 
 	/*
 	 * invalidate the pages whose sharing state is to be changed
@@ -1372,33 +1371,35 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	 */
 	if (iomap->flags & IOMAP_F_SHARED)
 		invalidate_inode_pages2_range(iter->inode->i_mapping,
-					      pos >> PAGE_SHIFT,
-					      (pos + length - 1) >> PAGE_SHIFT);
+				iter->pos >> PAGE_SHIFT,
+				(iter->pos + length - 1) >> PAGE_SHIFT);
 
 	do {
+		loff_t pos = iter->pos;
 		unsigned offset = offset_in_page(pos);
-		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
-		long rc;
 		int id;
 
+		length = min_t(u64, PAGE_SIZE - offset, length);
+
 		id = dax_read_lock();
-		if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
-			rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
+		if (IS_ALIGNED(pos, PAGE_SIZE) && length == PAGE_SIZE)
+			ret = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 		else
-			rc = dax_memzero(iter, pos, size);
+			ret = dax_memzero(iter, pos, length);
 		dax_read_unlock(id);
 
-		if (rc < 0)
-			return rc;
-		pos += size;
-		length -= size;
-		written += size;
+		if (ret < 0)
+			return ret;
+
+		ret = iomap_iter_advance(iter, &length);
+		if (ret)
+			return ret;
 	} while (length > 0);
 
 	if (did_zero)
 		*did_zero = true;
-	return written;
+	return ret;
 }
 
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-- 
2.48.1


