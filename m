Return-Path: <linux-fsdevel+bounces-50766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A86ACF563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D71D3AC40A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05EC2797BA;
	Thu,  5 Jun 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjbEcCmS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E6219317
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144639; cv=none; b=NxWuk7pzTEjFoScamFYqoeNoRQVfE76aQDgopK4e4rXxb3lK3QqbfSCu8uuwrI36r3loTgZb15FhM3MV6YCykH5iVvWf4O5Fz+b31PRUHU//81ZhyH0iQJfC0JFFkzU/jgceFbwU7mKm9HE+3TNSJXFUjlzIPxvnXP5ZR7ah4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144639; c=relaxed/simple;
	bh=v6HsR7Cctg5G+t5SmQKplo09wih2HG1b445IQW+1k2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJNkX90ukKiLFAtjSMhK17ar2nNhlU/4tUU3Ya2+dvv+yq3XhdKE91qeVjoC3deEhdvNalnpCdopp20FgSAVCVcWMzbPx5LI8gwZChiHlzZJbTK6nBwqvFYMG7+ToGrj5K5DwphaljJXA2AKaQWFbJHJlNMZ0ALnjBrEupHcl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjbEcCmS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1X2OSHk59+93ubkPLy5LJPQ/+O7r13j0K4bt+a8Izc=;
	b=EjbEcCmSiJ9CjA0NvircePGlTad0/fNRL3YaQ+0nHj5xKN4F9p3kKGFknm8A69dX3P2O3N
	qQFztstKKQLIZDjCEHc/wSNxeUmyJvoBhaa+cSebNwQwDFHdu61BBQkR9I8y41d21i/NbV
	m3REWvRb2vkuV9es1+nC8ZYO/J+pmsc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-aPbX9zfLMtqgH4L7AM2ybA-1; Thu,
 05 Jun 2025 13:30:33 -0400
X-MC-Unique: aPbX9zfLMtqgH4L7AM2ybA-1
X-Mimecast-MFC-AGG-ID: aPbX9zfLMtqgH4L7AM2ybA_1749144632
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4981B1801BEE;
	Thu,  5 Jun 2025 17:30:32 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.123])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 726B330002C0;
	Thu,  5 Jun 2025 17:30:31 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] xfs: always trim mapping to requested range for zero range
Date: Thu,  5 Jun 2025 13:33:54 -0400
Message-ID: <20250605173357.579720-5-bfoster@redhat.com>
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

Refactor and tweak the IOMAP_ZERO logic in preparation to support
filling the folio batch for unwritten mappings. Drop the superfluous
imap offset check since the hole case has already been filtered out.
Split the the delalloc case handling into a sub-branch, and always
trim the imap to the requested offset/count so it can be more easily
used to bound the range to lookup in pagecache.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
2.49.0


