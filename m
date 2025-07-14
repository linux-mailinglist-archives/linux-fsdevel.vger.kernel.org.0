Return-Path: <linux-fsdevel+bounces-54843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9CFB03F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E31A62800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F02550C7;
	Mon, 14 Jul 2025 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8p30fB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A4254AF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499051; cv=none; b=FQxx8W1+b1CiNdhj7sWbiB7SXJF0eaWeYLxkyG6e6/lctmTf6nuwSiGAR2SMAj++bwPh3QhR1ZQuKtEKO0ZLCxraZcPzlfQervFCJM+JEPv9wHuyhoW/eYiOijggErvYqkg6TCrbDlW5xKihpuvZJa3ohbV9k5omIb9OldSXtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499051; c=relaxed/simple;
	bh=27rVlgenuVIF5rXq8qWxWFfD6/7vnM3I3VJsL++OzCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2TcTi2X56Br7iogIo1f3vHC5EnoWVkbvr/sa6Os6A0m8XQNRwVkt03zihn+HV36UnkAFj+DvmGk+CGV9R/gFwBVBHhMtJN3/KmU6M11ctZxlGDTnjF0iQ2XzwVVRGtCkpbeX0HkB3OWi+bK1neLhPmmIMy5LSqhrMmQMGfrB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8p30fB+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uteaDe8EvXmtRIn0R0Xprl56k/DtY/7aoyuyVPzL80=;
	b=P8p30fB+RSKkjg7pHEiQlhyp/F+aYvihGzRr9Fda6XhHEd0cMoO1XRRScm9364JiP45Vym
	aadZvZu4ZMheod0XUMYion+ZWVU3LePSi5vmDfIH3YHAiS6vksGzTvVZ1Ohuwq/dan1Kc3
	IQvJR4Vc9v73Z5lFwJ30YZipD2XMYx0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-j42SyLOVPIOfnQBBtoAETQ-1; Mon,
 14 Jul 2025 09:17:25 -0400
X-MC-Unique: j42SyLOVPIOfnQBBtoAETQ-1
X-Mimecast-MFC-AGG-ID: j42SyLOVPIOfnQBBtoAETQ_1752499043
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C96A719560B6;
	Mon, 14 Jul 2025 13:17:23 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CD3818002B2;
	Mon, 14 Jul 2025 13:17:22 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v2 4/7] xfs: always trim mapping to requested range for zero range
Date: Mon, 14 Jul 2025 09:20:56 -0400
Message-ID: <20250714132059.288129-5-bfoster@redhat.com>
In-Reply-To: <20250714132059.288129-1-bfoster@redhat.com>
References: <20250714132059.288129-1-bfoster@redhat.com>
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
index ff05e6b1b0bb..b5cf5bc6308d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1756,21 +1756,20 @@ xfs_buffered_write_iomap_begin(
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
2.50.0


