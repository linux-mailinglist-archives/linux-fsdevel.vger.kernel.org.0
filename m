Return-Path: <linux-fsdevel+bounces-42433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE13CA42444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6206217ADAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6A25486D;
	Mon, 24 Feb 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+wf0VCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619425484C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408343; cv=none; b=KDAMg0vAqeVXvcdj9WQwxrdvj6Gy50UZhCHgYVmq/En7vHLAJmI5TJ0aBS1KW9FfkBlUZB2IKjkU/I0jNVyXx8w1vSRqrvucMZCvjWEILSk3t1s5PS2MWOPOI3Dv1BID5elMM+7OE17y1yMiUMcdPbJ/Em1Z0Rc3pnuSWJs268U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408343; c=relaxed/simple;
	bh=L73mRpWHqMSyB9GEczD7CvzvTfezi+RcmahwCU1s3MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctsnVoiw2sOjT6Rll0RQQukc/kUxD7uQsyHBM1/nvIDac9/vWZT1cIMzCaswYtJMqbPeVw7IKT6vDBnYBasfIk3Y+04aW8+TSftDgesfA1t1BE5zjFZ+h8k3LOGVBNkqzLnN2TTk4J0Y39lS/dhm5DqmbJMD1aiCUtc61gABLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+wf0VCQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y6/xarkGOoBrKOmHvORNPFjWX6n9qs5bfEQTc6yOzvs=;
	b=H+wf0VCQ/kMyYY5Ec0i/553P9FuBSuY86XxRd54wIqlyHqY3mMCRFZgibQ8RPt9g/60P9l
	QbeNMPIGsAXCGt3S/qByvIyPJQk+0bdVyh9hmxXK0Rcm+LgOgByt9aXE4cUcXkxm9pjCPD
	cSlf0tpR/uShPI8hNdMG4Bw8dB6YD0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-lkNVqxKrM7OKnAJ5TUnVtQ-1; Mon,
 24 Feb 2025 09:45:36 -0500
X-MC-Unique: lkNVqxKrM7OKnAJ5TUnVtQ-1
X-Mimecast-MFC-AGG-ID: lkNVqxKrM7OKnAJ5TUnVtQ_1740408334
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4A31180087B;
	Mon, 24 Feb 2025 14:45:34 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC0E419560AB;
	Mon, 24 Feb 2025 14:45:33 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 12/12] iomap: introduce a full map advance helper
Date: Mon, 24 Feb 2025 09:47:57 -0500
Message-ID: <20250224144757.237706-13-bfoster@redhat.com>
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

Various iomap_iter_advance() calls advance by the full mapping
length and thus have no need for the current length input or
post-advance remaining length output from the standard advance
function. Add an iomap_iter_advance_full() helper to clean up these
cases.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/dax.c               | 10 ++++------
 fs/iomap/buffered-io.c |  3 +--
 fs/iomap/fiemap.c      |  3 +--
 fs/iomap/swapfile.c    |  4 +---
 include/linux/iomap.h  | 10 ++++++++++
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index cab3c5abe5cb..7fd4cd9a51f2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1266,11 +1266,11 @@ static int dax_unshare_iter(struct iomap_iter *iter)
 	u64 copy_len = iomap_length(iter);
 	u32 mod;
 	int id = 0;
-	s64 ret = iomap_length(iter);
+	s64 ret;
 	void *daddr = NULL, *saddr = NULL;
 
 	if (!iomap_want_unshare_iter(iter))
-		return iomap_iter_advance(iter, &ret);
+		return iomap_iter_advance_full(iter);
 
 	/*
 	 * Extend the file range to be aligned to fsblock/pagesize, because
@@ -1300,16 +1300,14 @@ static int dax_unshare_iter(struct iomap_iter *iter)
 	if (ret < 0)
 		goto out_unlock;
 
-	if (copy_mc_to_kernel(daddr, saddr, copy_len) == 0)
-		ret = iomap_length(iter);
-	else
+	if (copy_mc_to_kernel(daddr, saddr, copy_len) != 0)
 		ret = -EIO;
 
 out_unlock:
 	dax_read_unlock(id);
 	if (ret < 0)
 		return dax_mem2blk_err(ret);
-	return iomap_iter_advance(iter, &ret);
+	return iomap_iter_advance_full(iter);
 }
 
 int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cdb0fedcf3d2..ea5e32d810d5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1433,8 +1433,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 				range_dirty = false;
 				status = iomap_zero_iter_flush_and_stale(&iter);
 			} else {
-				u64 length = iomap_length(&iter);
-				status = iomap_iter_advance(&iter, &length);
+				status = iomap_iter_advance_full(&iter);
 			}
 			iter.status = status;
 			continue;
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 6776b800bde7..80675c42e94e 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -42,7 +42,6 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 static int iomap_fiemap_iter(struct iomap_iter *iter,
 		struct fiemap_extent_info *fi, struct iomap *prev)
 {
-	u64 length = iomap_length(iter);
 	int ret;
 
 	if (iter->iomap.type == IOMAP_HOLE)
@@ -56,7 +55,7 @@ static int iomap_fiemap_iter(struct iomap_iter *iter,
 		return 0;
 
 advance:
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance_full(iter);
 }
 
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 9ea185e58ca7..c1a762c10ce4 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -97,8 +97,6 @@ static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
 static int iomap_swapfile_iter(struct iomap_iter *iter,
 		struct iomap *iomap, struct iomap_swapfile_info *isi)
 {
-	u64 length = iomap_length(iter);
-
 	switch (iomap->type) {
 	case IOMAP_MAPPED:
 	case IOMAP_UNWRITTEN:
@@ -135,7 +133,7 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
 		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
 	}
 
-	return iomap_iter_advance(iter, &length);
+	return iomap_iter_advance_full(iter);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index af9e51fba5f0..1fd66bc29cc1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -271,6 +271,16 @@ static inline u64 iomap_length(const struct iomap_iter *iter)
 	return iomap_length_trim(iter, iter->pos, iter->len);
 }
 
+/**
+ * iomap_iter_advance_full - advance by the full length of current map
+ */
+static inline int iomap_iter_advance_full(struct iomap_iter *iter)
+{
+	u64 length = iomap_length(iter);
+
+	return iomap_iter_advance(iter, &length);
+}
+
 /**
  * iomap_iter_srcmap - return the source map for the current iomap iteration
  * @i: iteration structure
-- 
2.48.1


