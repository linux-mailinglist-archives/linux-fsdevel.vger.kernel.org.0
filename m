Return-Path: <linux-fsdevel+bounces-35223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AC9D2A7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2982B36E39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741D1D1F5A;
	Tue, 19 Nov 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avrFsRYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A0D1D175F
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031133; cv=none; b=KWjNx0B6X/CD9qCMXlShZuZr8qqE7VFhPHZaZ7qZfksBsQcfGtvfAG50bJt9tb1M17PYBJ4no8mS8CddlFwkB582BoZGtCGX8EpGjfj55gOwTqymPe9Lt/P5nyyQGsxO0mOQYYZuSxXRGnKAeo70yHowJ834zyuGUv41s4Tfvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031133; c=relaxed/simple;
	bh=chq172AyjyM/iZFpfyYDd/V8b53y57CNzSUdA6qOcV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac7CLMcrUiCZ3/H/G/fH8y4iYBfA+2M5nI7DJZwBxxEzc590khp2W0/xkGQ/6Da6Rhvvl4/ylmLjsj3YGQ+YkkOk7cZ5SM7t1AuTUr+lhcUVcBhLUQ6XRxjSmr6mSYGN+OJt3yYMT+RBFmA1tBW5jPqF4z5kte8ScqEiMRLX3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avrFsRYz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732031129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHORF4G4Jsb1yaGbLK+HoWRyvTj4g/Fx1gHFlkLoziw=;
	b=avrFsRYzhgDEcTUQirF/gYC4Hs956/jyHuMW9omh3tbTqlmgKLo9BDvYBqNnzoriFtKmvG
	gioB8ralPUywefsdKqXxOSKgGITgoQ2P5RvxRZMuZvkZzn9ByCJkWb6dpje04bRztEPji5
	T8TJ9ZzWHhQdT9OxO1ehfF8mRUROed4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-ioXXfXXQPea8dp236fnqVQ-1; Tue,
 19 Nov 2024 10:45:26 -0500
X-MC-Unique: ioXXfXXQPea8dp236fnqVQ-1
X-Mimecast-MFC-AGG-ID: ioXXfXXQPea8dp236fnqVQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AE0219560B0;
	Tue, 19 Nov 2024 15:45:25 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.120])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 811021956054;
	Tue, 19 Nov 2024 15:45:24 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH RFC 3/4] xfs: always trim mapping to requested range for zero range
Date: Tue, 19 Nov 2024 10:46:55 -0500
Message-ID: <20241119154656.774395-4-bfoster@redhat.com>
In-Reply-To: <20241119154656.774395-1-bfoster@redhat.com>
References: <20241119154656.774395-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Refactor and tweak the IOMAP_ZERO logic in preparation to support
filling the folio batch for unwritten mappings. Drop the superfluous
imap offset check since the hole case has already been filtered out.
Split the the delalloc case handling into a sub-branch, and always
trim the imap to the requested offset/count so it can be more easily
used to bound the range to lookup in pagecache.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 86da16f54be9..ed42a28973bb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1029,17 +1029,16 @@ xfs_buffered_write_iomap_begin(
 	 * block.  If it starts beyond the EOF block, convert it to an
 	 * unwritten extent.
 	 */
-	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
-	    isnullstartblock(imap.br_startblock)) {
-		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
-
-		if (offset_fsb >= eof_fsb)
-			goto convert_delay;
-		if (end_fsb > eof_fsb) {
-			end_fsb = eof_fsb;
-			xfs_trim_extent(&imap, offset_fsb,
-					end_fsb - offset_fsb);
+	if (flags & IOMAP_ZERO) {
+		if (isnullstartblock(imap.br_startblock)) {
+			xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+
+			if (offset_fsb >= eof_fsb)
+				goto convert_delay;
+			if (end_fsb > eof_fsb)
+				end_fsb = eof_fsb;
 		}
+		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
 	}
 
 	/*
-- 
2.47.0


