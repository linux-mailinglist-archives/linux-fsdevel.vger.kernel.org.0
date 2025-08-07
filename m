Return-Path: <linux-fsdevel+bounces-57002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF4B1DA3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F7E585CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62E265CC2;
	Thu,  7 Aug 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7LnCFie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F06269D18
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577818; cv=none; b=djLqxSpzqbZfQqv1u/M6+z+x+nyBgSYFS/9q//rRmTO/TiOyrRPt454yTzJNOyXvQa242fHoUqm3RgiwO4ToOGqOswYrSSNw4g4lIvRwBkJTCEHUbSoKmQ2wt9gNlqrF3aq3Nq35mZ7zXFzIyqx0Ds0XuoFmGFHoXFyv0rrcpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577818; c=relaxed/simple;
	bh=4AGxI/eAJdaOsfjaFvtc31Q3SKZlUsUAgQr/8vaIrkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPrktwIUh+rk0WgaCjoPkIlNoDPrYx0hQOhRzivgMtpeeNpBReU7jq/4BK8LIXWtMeQ8eqeRgWoBTddBnrmD4e7A+1kLZtPgVO1e6zhACdcqVJrG/ydjrPC8oCzxywjK0yTg+fovhnxQlP+mGvoJffeUcS/h98YSVWbCj/7a+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7LnCFie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754577815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSr9N5g89fySVkYw5oAvxYqJ4DTMR7Ste4RyO4OGSWY=;
	b=O7LnCFieJQWArH5EtzAZZZxjC5PYk+dDmHpE5fXIrnyi14xsqpe6taw6GZgtx1UVtXTIOp
	/O9kUrXk16IP/z6aEMy95SsE4hJqkxZGZzYjLarjcC36Fo9PcV0iPVVPgge55Qbp0BBazG
	Rk5NoYnf6sYY0O9X85eFOsWPC6dd21M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-jEaw4hmQMVetFCd1PlYCNA-1; Thu,
 07 Aug 2025 10:43:32 -0400
X-MC-Unique: jEaw4hmQMVetFCd1PlYCNA-1
X-Mimecast-MFC-AGG-ID: jEaw4hmQMVetFCd1PlYCNA_1754577811
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7F161956050;
	Thu,  7 Aug 2025 14:43:30 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E1461800293;
	Thu,  7 Aug 2025 14:43:29 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v4 5/7] xfs: fill dirty folios on zero range of unwritten mappings
Date: Thu,  7 Aug 2025 10:47:08 -0400
Message-ID: <20250807144711.564137-6-bfoster@redhat.com>
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

Use the iomap folio batch mechanism to select folios to zero on zero
range of unwritten mappings. Trim the resulting mapping if the batch
is filled (unlikely for current use cases) to distinguish between a
range to skip and one that requires another iteration due to a full
batch.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 25058004de91..521fef4d04c8 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1693,6 +1693,8 @@ xfs_buffered_write_iomap_begin(
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
+						     iomap);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1764,6 +1766,7 @@ xfs_buffered_write_iomap_begin(
 	 */
 	if (flags & IOMAP_ZERO) {
 		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+		u64 end;
 
 		if (isnullstartblock(imap.br_startblock) &&
 		    offset_fsb >= eof_fsb)
@@ -1771,6 +1774,26 @@ xfs_buffered_write_iomap_begin(
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
2.50.1


