Return-Path: <linux-fsdevel+bounces-37322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8456F9F102B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B541283746
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521C1E2848;
	Fri, 13 Dec 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+xggxrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F371E22FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102229; cv=none; b=tajU39v5y/oquEgeI7AV+OYfJWJ84kNjNSoyMjzgzZCoUGeGsU65z+KHoB6lp3E1wIrV0P08fWAjbydJdvzRhiCiDaOP5jVE4G6dxjB2PmJAZxqYilvWwhjh8h5Ekscyl4K/J4iSwoeljYiJEtMPleZTQMZCMw56uTUi203PLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102229; c=relaxed/simple;
	bh=xRGmHdpsTiIU+Z1zrdTOxwCPBqCUeP8NWJzQZCO7uBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XE86+Nz4gBkZzDQhW8P1b7XV6A4z97s7IdQMUMsiMYN+XMKgctKGR9W3/GkBOgpzyw+EAADCTiYunI9/5eBMPfRIqnUASz2uc2nY6bzcRU1e61HEkTMoPobqeL7nAnhlOS6LV9GUsFdhrWdQ+hZOLwZ2VHBujQubr5PQH6/MOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+xggxrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734102226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYSD/z+zYJavLMYA5D03SkykgbMAFv2ge+5Q5GT8i74=;
	b=N+xggxrvYWkyGLUT9ONPTLE+TYoEUnz/zEi6UlfSFb756XZuZ8hMk/hiGNXipwpdTO9SPo
	opAvtPGS1Y391TV33Gqh2swksHNo8LhY3OYDEj5rtzUeCcCRmnO7pRL2+cxGtN7OpuQf4R
	kvD9ZZF51HLcoZMbENbbibejqDg/D3o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-vgXCyxLXNoa0esIZ_wDVBw-1; Fri,
 13 Dec 2024 10:03:45 -0500
X-MC-Unique: vgXCyxLXNoa0esIZ_wDVBw-1
X-Mimecast-MFC-AGG-ID: vgXCyxLXNoa0esIZ_wDVBw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BD77195609F;
	Fri, 13 Dec 2024 15:03:44 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.90.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA4E6195394B;
	Fri, 13 Dec 2024 15:03:43 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH RFCv2 3/4] xfs: always trim mapping to requested range for zero range
Date: Fri, 13 Dec 2024 10:05:27 -0500
Message-ID: <20241213150528.1003662-4-bfoster@redhat.com>
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

Refactor and tweak the IOMAP_ZERO logic in preparation to support
filling the folio batch for unwritten mappings. Drop the superfluous
imap offset check since the hole case has already been filtered out.
Split the the delalloc case handling into a sub-branch, and always
trim the imap to the requested offset/count so it can be more easily
used to bound the range to lookup in pagecache.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 50fa3ef89f6c..97fa860a6401 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1059,21 +1059,20 @@ xfs_buffered_write_iomap_begin(
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
2.47.0


