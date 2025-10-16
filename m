Return-Path: <linux-fsdevel+bounces-64390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A10BE523C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2499619A7EBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D023E325;
	Thu, 16 Oct 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9/xMuOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB224676C
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641133; cv=none; b=QvCVMyTMM19UTXuWiRlKZoAspBmiqrepS+yr6QN/E+RonSPMJw7vyS4mDbMPoBs7okECiXa0dJCxDNfPHKxmeGZwgz6DRQhDxaR4gaUMSBu09PPiCfTUiCQJi2yM7/Fuxked2opW+S9PCWccmpzxFU9EgV0uIDX5U3nQL8X3JoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641133; c=relaxed/simple;
	bh=6+2425XlnwWT1+skiFwPkWsJYLznVMiybNQRRWI+mY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hj+8I0zQY4+23IpXdDwEg9/FPj39ANUnFz/KdY/w8PIDs8QAN90UNXsMq9/59DJX1WpNGStNPVaen8hcczvkVz93+kF1DCIbZykxlG+/z0F8rp9Xlb6VPG6EbOBTy4NXKCJkXHrz8FO389mutCFj3MIrMsX+oHMqSsfUnJlb0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9/xMuOy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760641130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YzcGwrS7YjNh6T0agZVkp95RLqbuq79lbjG1FqDfNM4=;
	b=f9/xMuOy5G57D8/dvVF+sWkob3GRjO/IaJ8YTtGaPrwwMj+/3rvYYkL0TewkIMKoyln+fZ
	e4IO2VNyQ7hr5Wxl47wsraqpg9ZQvP0CjryIClvZ3Tx5eEjwH9pdfvYrEfkaOonOTWoVIs
	pWLLXd7skKmht0ECuaQL2u0Dhwg6Jr4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-hEzaJeprNgu1cBT5X5WUgw-1; Thu,
 16 Oct 2025 14:58:47 -0400
X-MC-Unique: hEzaJeprNgu1cBT5X5WUgw-1
X-Mimecast-MFC-AGG-ID: hEzaJeprNgu1cBT5X5WUgw_1760641127
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1B7B180065F;
	Thu, 16 Oct 2025 18:58:46 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 717801956056;
	Thu, 16 Oct 2025 18:58:46 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 4/6] xfs: look up cow fork extent earlier for buffered iomap_begin
Date: Thu, 16 Oct 2025 15:03:01 -0400
Message-ID: <20251016190303.53881-5-bfoster@redhat.com>
In-Reply-To: <20251016190303.53881-1-bfoster@redhat.com>
References: <20251016190303.53881-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

To further isolate the need for flushing for zero range, we need to
know whether a hole in the data fork is fronted by blocks in the COW
fork or not. COW fork lookup currently occurs further down in the
function, after the zero range case is handled.

As a preparation step, lift the COW fork extent lookup to earlier in
the function, at the same time as the data fork lookup. Only the
lookup logic is lifted. The COW fork branch/reporting logic remains
as is to avoid any observable behavior change from an iomap
reporting perspective.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index b84c94558cc9..ba5697d8b8fd 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1753,14 +1753,29 @@ xfs_buffered_write_iomap_begin(
 		goto out_unlock;
 
 	/*
-	 * Search the data fork first to look up our source mapping.  We
-	 * always need the data fork map, as we have to return it to the
-	 * iomap code so that the higher level write code can read data in to
-	 * perform read-modify-write cycles for unaligned writes.
+	 * Search the data fork first to look up our source mapping. We always
+	 * need the data fork map, as we have to return it to the iomap code so
+	 * that the higher level write code can read data in to perform
+	 * read-modify-write cycles for unaligned writes.
+	 *
+	 * Then search the COW fork extent list even if we did not find a data
+	 * fork extent. This serves two purposes: first this implements the
+	 * speculative preallocation using cowextsize, so that we also unshare
+	 * block adjacent to shared blocks instead of just the shared blocks
+	 * themselves. Second the lookup in the extent list is generally faster
+	 * than going out to the shared extent tree.
 	 */
 	eof = !xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap);
 	if (eof)
 		imap.br_startoff = end_fsb; /* fake hole until the end */
+	if (xfs_is_cow_inode(ip)) {
+		if (!ip->i_cowfp) {
+			ASSERT(!xfs_is_reflink_inode(ip));
+			xfs_ifork_init_cow(ip);
+		}
+		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
+				&ccur, &cmap);
+	}
 
 	/* We never need to allocate blocks for unsharing a hole. */
 	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
@@ -1827,24 +1842,13 @@ xfs_buffered_write_iomap_begin(
 	}
 
 	/*
-	 * Search the COW fork extent list even if we did not find a data fork
-	 * extent.  This serves two purposes: first this implements the
-	 * speculative preallocation using cowextsize, so that we also unshare
-	 * block adjacent to shared blocks instead of just the shared blocks
-	 * themselves.  Second the lookup in the extent list is generally faster
-	 * than going out to the shared extent tree.
+	 * Now that we've handled any operation specific special cases, at this
+	 * point we can report a COW mapping if found.
 	 */
-	if (xfs_is_cow_inode(ip)) {
-		if (!ip->i_cowfp) {
-			ASSERT(!xfs_is_reflink_inode(ip));
-			xfs_ifork_init_cow(ip);
-		}
-		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
-				&ccur, &cmap);
-		if (!cow_eof && cmap.br_startoff <= offset_fsb) {
-			trace_xfs_reflink_cow_found(ip, &cmap);
-			goto found_cow;
-		}
+	if (xfs_is_cow_inode(ip) &&
+	    !cow_eof && cmap.br_startoff <= offset_fsb) {
+		trace_xfs_reflink_cow_found(ip, &cmap);
+		goto found_cow;
 	}
 
 	if (imap.br_startoff <= offset_fsb) {
-- 
2.51.0


