Return-Path: <linux-fsdevel+bounces-57000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F795B1DA39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326CA1AA5350
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE10269CE8;
	Thu,  7 Aug 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2XTdS2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A126981C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577816; cv=none; b=XRym6uHW0qkiW2wvsDKafRffha9Ms3SlqPlUJMBZL8Ks5lnOx+nD8kM72cfAXwu8fRd9rAiSKIYtzEH2MblbA+m5j4U3KfPQ9R7XnyJTkvzy/B+Qln/Q4Sq+STfTqv1ih6ClY32hHdngUXv3Zn2dP1+vBahYVRzAVMggnsLa2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577816; c=relaxed/simple;
	bh=Wxu6FrwxKjc8v5CmwztU8sh+kuJc7X1oTTtP3ROreXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJV+zJc27IAnvX0YQ2vpaGuhv2HWjp85S58lRxcAYlK4/2oBPVq2aOCcP6rwK809tebFOak/6mD76l4ZYzvxk3AkIHlu7mj/bYeaqZBnfq5rWGcYH8PPOzOysFyRJyP8nzLQcisqYCTzU/Ump3J3mAm/QKumij74aUUAs1Tn69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2XTdS2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5071NuG2BrmI3mAFOA+wKHQ0oJZoTKExAqwlt/m4okE=;
	b=D2XTdS2Se1lsSG1el2hCf36V9zbR2HVaAlFG5nIogGKb0jITMy5LZ7i983dHT9w++I3Xfs
	8erZ96S5wZyXWkqUeBXQh8sFv80huZKERjpFqMPrPvWfn/uRi408Qvb3txIaazk6OSh8If
	Fc1Psh8CtsT3lpuki8B6/brkjmcegJE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-Cly95HXiNuu3v78G0SRJYg-1; Thu,
 07 Aug 2025 10:43:30 -0400
X-MC-Unique: Cly95HXiNuu3v78G0SRJYg-1
X-Mimecast-MFC-AGG-ID: Cly95HXiNuu3v78G0SRJYg_1754577809
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DFC71800EF2;
	Thu,  7 Aug 2025 14:43:29 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BEC61800292;
	Thu,  7 Aug 2025 14:43:27 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v4 4/7] xfs: always trim mapping to requested range for zero range
Date: Thu,  7 Aug 2025 10:47:07 -0400
Message-ID: <20250807144711.564137-5-bfoster@redhat.com>
In-Reply-To: <20250807144711.564137-1-bfoster@redhat.com>
References: <20250807144711.564137-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Refactor and tweak the IOMAP_ZERO logic in preparation to support
filling the folio batch for unwritten mappings. Drop the superfluous
imap offset check since the hole case has already been filtered out.
Split the the delalloc case handling into a sub-branch, and always
trim the imap to the requested offset/count so it can be more easily
used to bound the range to lookup in pagecache.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2a74f2957341..25058004de91 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1758,21 +1758,20 @@ xfs_buffered_write_iomap_begin(
 	}
 
 	/*
-	 * For zeroing, trim a delalloc extent that extends beyond the EOF
-	 * block.  If it starts beyond the EOF block, convert it to an
+	 * For zeroing, trim extents that extend beyond the EOF block. If a
+	 * delalloc extent starts beyond the EOF block, convert it to an
 	 * unwritten extent.
 	 */
-	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
-	    isnullstartblock(imap.br_startblock)) {
+	if (flags & IOMAP_ZERO) {
 		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
 
-		if (offset_fsb >= eof_fsb)
+		if (isnullstartblock(imap.br_startblock) &&
+		    offset_fsb >= eof_fsb)
 			goto convert_delay;
-		if (end_fsb > eof_fsb) {
+		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
 			end_fsb = eof_fsb;
-			xfs_trim_extent(&imap, offset_fsb,
-					end_fsb - offset_fsb);
-		}
+
+		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
 	}
 
 	/*
-- 
2.50.1


