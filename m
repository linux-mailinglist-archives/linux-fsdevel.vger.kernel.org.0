Return-Path: <linux-fsdevel+bounces-41594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F43A327B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F03A57CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E21A20F08B;
	Wed, 12 Feb 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ac6axOuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758C20F06F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368502; cv=none; b=mfZUi2p9s/axBtDj+Slid6XBTBg+e96FyGRTc4DAgrWbmJ+QU6nbIv1XryoMiggzNsJQ8JlHV5IQAIPDkB5SL5EybtLdv1z3FzZlOQBQgweD0CUO//y2lmMQrzUIlV89TS+IBpo1u7HywMC92vbY7bLZdNImKaE/Uz/iRBAZCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368502; c=relaxed/simple;
	bh=1bqo8aL5cmXbJ+cNT7xS32edL3l3xUlEROVGEDdOHZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKg1aAxngprtEEtWQqT8sPZeLVyonU4Is3avdEKNabP9TxVSA/+wuuB99LymWpPppo7LggVQjZZhV8LV6ThVdp7UnJ7V390ssJIcUf2C1IauSfsH9Xh6Nn/msHP5kRZP181U/1M29gZX3uE8LqJO7DWlwmxTIebDDH/yCZ9vpLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ac6axOuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739368499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ/s400kJn2kZXU7M9iirbC3/L7fHpTfGFPL3jnfbvA=;
	b=ac6axOucs4NR6D1CzSzC5kZYtURbIQDV+tY0rJ83tHta6J0WQHO6aY/k7NEXv55oOtHce9
	267B8MrvfpMb3YPgT85ztVlpOpzfwQG2iawySrnBV2MxCN4m8iMpLOWFmXyKQ0p+N55YV+
	OQ+L8FiwRuq2kPl2Qq8FoFLq64fB+B8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-qqkGLfBHOzW96IGX2jfLPg-1; Wed,
 12 Feb 2025 08:54:56 -0500
X-MC-Unique: qqkGLfBHOzW96IGX2jfLPg-1
X-Mimecast-MFC-AGG-ID: qqkGLfBHOzW96IGX2jfLPg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AE291956094;
	Wed, 12 Feb 2025 13:54:55 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A6A73001D19;
	Wed, 12 Feb 2025 13:54:54 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 07/10] dax: advance the iomap_iter on dedupe range
Date: Wed, 12 Feb 2025 08:57:09 -0500
Message-ID: <20250212135712.506987-8-bfoster@redhat.com>
In-Reply-To: <20250212135712.506987-1-bfoster@redhat.com>
References: <20250212135712.506987-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Advance the iter on successful dedupe. Dedupe range uses two iters
and iterates so long as both have outstanding work, so
correspondingly this needs to advance both on each iteration. Since
dax_range_compare_iter() now returns status instead of a byte count,
update the variable name in the caller as well.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d0430ded4b83..3de9120edf32 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2006,12 +2006,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
 
-static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
+static int dax_range_compare_iter(struct iomap_iter *it_src,
 		struct iomap_iter *it_dest, u64 len, bool *same)
 {
 	const struct iomap *smap = &it_src->iomap;
 	const struct iomap *dmap = &it_dest->iomap;
 	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
+	u64 dest_len;
 	void *saddr, *daddr;
 	int id, ret;
 
@@ -2019,7 +2020,7 @@ static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
 
 	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
 		*same = true;
-		return len;
+		goto advance;
 	}
 
 	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
@@ -2042,7 +2043,13 @@ static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
 	if (!*same)
 		len = 0;
 	dax_read_unlock(id);
-	return len;
+
+advance:
+	dest_len = len;
+	ret = iomap_iter_advance(it_src, &len);
+	if (!ret)
+		ret = iomap_iter_advance(it_dest, &dest_len);
+	return ret;
 
 out_unlock:
 	dax_read_unlock(id);
@@ -2065,15 +2072,15 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		.len		= len,
 		.flags		= IOMAP_DAX,
 	};
-	int ret, compared = 0;
+	int ret, status;
 
 	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
 	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
-		compared = dax_range_compare_iter(&src_iter, &dst_iter,
+		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
-		if (compared < 0)
+		if (status < 0)
 			return ret;
-		src_iter.processed = dst_iter.processed = compared;
+		src_iter.processed = dst_iter.processed = status;
 	}
 	return ret;
 }
-- 
2.48.1


