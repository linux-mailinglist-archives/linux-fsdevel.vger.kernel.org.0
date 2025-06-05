Return-Path: <linux-fsdevel+bounces-50767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A19ACF567
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8803AC4B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A427990B;
	Thu,  5 Jun 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUR5IlVH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA919D07E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144640; cv=none; b=jZHQ8V6C8EfKozE8p6N2VpHDz7rWnf6rmcxY3IAQo3PyD6HNAOQZmGqvIp6EZ85KTtSOElKVl1hcshtOxvsObGY/3+rs6UbDEr/eO4aYWkEex1AlGH0ogIzfEl6gmYdnabe7ol3t8M8x6kBwEgTDNJc4rkgep72rJns8dGXEliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144640; c=relaxed/simple;
	bh=MJcr0ObXfY8/tnTPh1nipBv647UmkjMTFIe8YHIhGDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkAgtQiDANL9lTY10WLWO0R8Gdy2067URlph9Jl7NSKZKMGJiy2QkARaIM83NfIZXn+77AS5KFwOGiwYzt0Pi8QxnVcTp4/OAa9CLVgKnTE0dmvxMnyMHRiLLakEU7aodQnD+33HC3WVYkmHJp2ZtwMwtME7kA2ZEo2WV7l4AKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUR5IlVH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LU2MyIQM1joNd8loBPHKESz8FUEB/OBONYYMnyKvWlg=;
	b=hUR5IlVHMxXNmMl7oB2iisHzBG9ppEMcAtdbbQTSKcVTM4nEZxabqFRlftL6FrqeEx5kdZ
	wVB0xKiybXumjhyc8zR9IXe+3IMaSLpkpR1WZTm66wY4KBMPr+l4i0Tq6e/JG7gI2kmtGr
	1igljhDwHWKYr2qFBNN26IzKJusDe1w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-4n6VysfBNlqu799EFqomWw-1; Thu,
 05 Jun 2025 13:30:34 -0400
X-MC-Unique: 4n6VysfBNlqu799EFqomWw-1
X-Mimecast-MFC-AGG-ID: 4n6VysfBNlqu799EFqomWw_1749144633
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A1F919560AA;
	Thu,  5 Jun 2025 17:30:33 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 878B830002C0;
	Thu,  5 Jun 2025 17:30:32 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] xfs: fill dirty folios on zero range of unwritten mappings
Date: Thu,  5 Jun 2025 13:33:55 -0400
Message-ID: <20250605173357.579720-6-bfoster@redhat.com>
In-Reply-To: <20250605173357.579720-1-bfoster@redhat.com>
References: <20250605173357.579720-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Use the iomap folio batch mechanism to select folios to zero on zero
range of unwritten mappings. Trim the resulting mapping if the batch
is filled (unlikely for current use cases) to distinguish between a
range to skip and one that requires another iteration due to a full
batch.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index b5cf5bc6308d..63054f7ead0e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1691,6 +1691,8 @@ xfs_buffered_write_iomap_begin(
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
+						     iomap);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1762,6 +1764,7 @@ xfs_buffered_write_iomap_begin(
 	 */
 	if (flags & IOMAP_ZERO) {
 		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+		u64 end;
 
 		if (isnullstartblock(imap.br_startblock) &&
 		    offset_fsb >= eof_fsb)
@@ -1769,6 +1772,26 @@ xfs_buffered_write_iomap_begin(
 		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
 			end_fsb = eof_fsb;
 
+		/*
+		 * Look up dirty folios for unwritten mappings within EOF.
+		 * Providing this bypasses the flush iomap uses to trigger
+		 * extent conversion when unwritten mappings have dirty
+		 * pagecache in need of zeroing.
+		 *
+		 * Trim the mapping to the end pos of the lookup, which in turn
+		 * was trimmed to the end of the batch if it became full before
+		 * the end of the mapping.
+		 */
+		if (imap.br_state == XFS_EXT_UNWRITTEN &&
+		    offset_fsb < eof_fsb) {
+			loff_t len = min(count,
+					 XFS_FSB_TO_B(mp, imap.br_blockcount));
+
+			end = iomap_fill_dirty_folios(iter, offset, len);
+			end_fsb = min_t(xfs_fileoff_t, end_fsb,
+					XFS_B_TO_FSB(mp, end));
+		}
+
 		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
 	}
 
-- 
2.49.0


