Return-Path: <linux-fsdevel+bounces-42428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AEA42457
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A7C424912
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C56724EF7A;
	Mon, 24 Feb 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEKaadz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3151192B96
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408335; cv=none; b=PByfl3ky4ilpyDsUdSYXsL50fFP1Grx41KfmagobL9XXtNsOXNdk6yZKSctpYnn+zDnF7aDjFeqKQZO/sBVqGmoMEZWey0uP9E+ettXW9hA8KpGQ+h8t1br4MMoDK5ORs3FBhATpnK9fd+psN4NUPADbqugPcRVVtR5zUws84OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408335; c=relaxed/simple;
	bh=nsQXt/RqrWwcsktLas3zwKcscZIeV30liDsygqfWyAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCfY2uLzrWMigxdZYG42nvj5hBipoO6iV8ibrGvIxbz+FCRENOwghwf+qKfxsLecwEiar9OZJA2API6bls37Mm98zlpvYk9iZ11dfz0ZbdU3XF6V8LmzJj3iE3LQyOSRHNZkGaOv9FhfNexxJeKRCNsqQvA3OwGZVMRa1AZ0Ub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEKaadz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mH3KqqR73R9pon3Bs56rIU8sRyTbKp/l5G8gr8ZCWA=;
	b=gEKaadz30xk594bJnmMPbyZbqjoTHVCXF00XB6Inaw35OZ6g8M0ewNv+XMC5t9fft3D9WK
	Yr1DjmzH1+z1Q+r49I72znr3JHQ+JLYllImKpFc4RrFgu//iU826/kp94zIClIbuzdk2/c
	7s/5NYR7jWhyQ+DBf1AND2D+9OZeslE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-oYUKXahZO264tIlOUoJE_g-1; Mon,
 24 Feb 2025 09:45:29 -0500
X-MC-Unique: oYUKXahZO264tIlOUoJE_g-1
X-Mimecast-MFC-AGG-ID: oYUKXahZO264tIlOUoJE_g_1740408327
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A99771809C8D;
	Mon, 24 Feb 2025 14:45:22 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24B201955DCE;
	Mon, 24 Feb 2025 14:45:20 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 02/12] iomap: advance the iter on direct I/O
Date: Mon, 24 Feb 2025 09:47:47 -0500
Message-ID: <20250224144757.237706-3-bfoster@redhat.com>
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

Update iomap direct I/O to advance the iter directly rather than via
iter.processed. Update each mapping type helper to advance based on
the amount of data processed and return success or failure.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 138d246ec29d..8ebd5b3019a7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -335,8 +335,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 	return opflags;
 }
 
-static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
-		struct iomap_dio *dio)
+static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
@@ -349,7 +348,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	bool need_zeroout = false;
 	bool use_fua = false;
 	int nr_pages, ret = 0;
-	size_t copied = 0;
+	u64 copied = 0;
 	size_t orig_count;
 
 	if (atomic && length != fs_block_size)
@@ -513,30 +512,28 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	/* Undo iter limitation to current extent */
 	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
 	if (copied)
-		return copied;
+		return iomap_iter_advance(iter, &copied);
 	return ret;
 }
 
-static loff_t iomap_dio_hole_iter(const struct iomap_iter *iter,
-		struct iomap_dio *dio)
+static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
 	loff_t length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
 
 	dio->size += length;
 	if (!length)
 		return -EFAULT;
-	return length;
+	return iomap_iter_advance(iter, &length);
 }
 
-static loff_t iomap_dio_inline_iter(const struct iomap_iter *iomi,
-		struct iomap_dio *dio)
+static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 {
 	const struct iomap *iomap = &iomi->iomap;
 	struct iov_iter *iter = dio->submit.iter;
 	void *inline_data = iomap_inline_data(iomap, iomi->pos);
 	loff_t length = iomap_length(iomi);
 	loff_t pos = iomi->pos;
-	size_t copied;
+	u64 copied;
 
 	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
 		return -EIO;
@@ -558,11 +555,10 @@ static loff_t iomap_dio_inline_iter(const struct iomap_iter *iomi,
 	dio->size += copied;
 	if (!copied)
 		return -EFAULT;
-	return copied;
+	return iomap_iter_advance(iomi, &copied);
 }
 
-static loff_t iomap_dio_iter(const struct iomap_iter *iter,
-		struct iomap_dio *dio)
+static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
 	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
-- 
2.48.1


