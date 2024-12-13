Return-Path: <linux-fsdevel+bounces-37324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CBB9F104D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417B918847BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292651E231D;
	Fri, 13 Dec 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTMb4BZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C811E231F
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102230; cv=none; b=OQ/nOjzfkdDcOEJG/eIvQhzlY5CLyZOJePwoPSEMnQ/NRrHEKF+Wk3If9JUTYgEkyyxizJjmw5mdE2zTdROKGPhjgvjOu+G0jgWwAbadkCAvberSW+lAQw1MAtKalu2CXdc7N26rG68Pg1B1UUN+q4MznDlQ8zerJe2WKfpjDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102230; c=relaxed/simple;
	bh=YRJkWpVrsK5tWAkj3h7O0KKz9hSJzbc1riBkCq6zkRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT4EbJ6ZExweyRxkvPGL6I0qVHYFfDvfnzk7qOoftX/BQpvnrY2unKcXIv9SNOi9xsb9xOdRhQs+zrvNvi1a+MWLkEomJ3DGhA2KsjuRLUi18GQuK4zdRoZooL9PMCxPY4RbonpHHEnr0pix8YpqvEEJs1DkkYWkpsHAyOm1R3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTMb4BZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtlfk7brtiOHWfKLJSeT8G4FA2trYaZJpMkIqijZqRc=;
	b=GTMb4BZO3ALfxnI3WM3qVrbgU+8/V36xKmkcPhfBF2nZripcMgZ572CxFef69BB2IsxYor
	6p3BSI0hevrZdRMZnALCCYK0ExCI9/Zxy3q94yerYsoRiDFnBhr+6jIl/F4Le7wFtHEtYv
	2gZ4KBzD2GUZmGKn39AKCXES1lSaxt8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-RbX2NjB4MFWGeghGE-D9EA-1; Fri,
 13 Dec 2024 10:03:46 -0500
X-MC-Unique: RbX2NjB4MFWGeghGE-D9EA-1
X-Mimecast-MFC-AGG-ID: RbX2NjB4MFWGeghGE-D9EA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F95919560A3;
	Fri, 13 Dec 2024 15:03:45 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADEA9195394B;
	Fri, 13 Dec 2024 15:03:44 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH RFCv2 4/4] xfs: fill dirty folios on zero range of unwritten mappings
Date: Fri, 13 Dec 2024 10:05:28 -0500
Message-ID: <20241213150528.1003662-5-bfoster@redhat.com>
In-Reply-To: <20241213150528.1003662-1-bfoster@redhat.com>
References: <20241213150528.1003662-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use the iomap folio batch mechanism to identify which folios to zero
on zero range of unwritten mappings. Trim the resulting mapping if
the batch is filled (unlikely) and set the HAS_FOLIOS flag to inform
iomap that pagecache has been checked for dirty folios.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 97fa860a6401..b7dbd34fc02f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -998,6 +998,7 @@ xfs_buffered_write_iomap_begin(
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter, iomap);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1065,12 +1066,21 @@ xfs_buffered_write_iomap_begin(
 	 */
 	if (flags & IOMAP_ZERO) {
 		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+		u64 end;
 
 		if (isnullstartblock(imap.br_startblock) &&
 		    offset_fsb >= eof_fsb)
 			goto convert_delay;
 		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
 			end_fsb = eof_fsb;
+		if (imap.br_state == XFS_EXT_UNWRITTEN &&
+		    offset_fsb < eof_fsb) {
+			xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
+			end = iomap_fill_dirty_folios(iter,
+					XFS_FSB_TO_B(mp, imap.br_startoff),
+					XFS_FSB_TO_B(mp, imap.br_blockcount));
+			end_fsb = min_t(xfs_fileoff_t, end_fsb, XFS_B_TO_FSB(mp, end));
+		}
 
 		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
 	}
-- 
2.47.0


