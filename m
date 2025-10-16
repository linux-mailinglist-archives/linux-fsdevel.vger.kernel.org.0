Return-Path: <linux-fsdevel+bounces-64389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FEBE523B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957FC585F80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 18:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3E72517AC;
	Thu, 16 Oct 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEyK5urk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FB23EAB5
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641133; cv=none; b=cQcpQarziMH1S5nbAwDG+g7umNEVE1S67wvfb0qK8CCsa71gX5G7Cl0Uje6i2+bk8gyEUqJNNV48VXjHqFsJWNNX2DD63XzDorqqCjZfe17uLiYCcOzHKzlp9BQtUQru+dHeKOAI+1RHH8wMOSXnKfpBbwJq6YcgOGE3zQDJGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641133; c=relaxed/simple;
	bh=bv3G61swq59/4cKzUlujzLcZhRmmoPykgaWJHDONX5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttCyGgEHs49qDRcmmSZTzNMjMva/mJ3R49zxoDbLXR09K6iq6y0Od68oRpFVcZh4ehpi0s4NxY7uFjeLsYS61gHWpApTEICr6ClkfJQ7nFZDUjEXIVoB2/3M9A7mjgWEA6oNbe6p66Im+ZVz7qjf1myUcCBGYAlHJahDOD19GsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEyK5urk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760641130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBNDmsakALoQQdPZN9gSTgtZ0zTkdliaC8dk9eucFfY=;
	b=JEyK5urkVTE7Q0Kr/ZoqP6tsF9eMjbYZhc3o6ZeKmvquRWuOLZrBxnRHMRTbKhGMEaEMvw
	+Bls9t9ge5do9tvUW7IWcJr/3d4bVJRIC4zyX9Ek0nDljZanFWYDfUEAptw5ZzGHFlyMvT
	n8brE5FaKF4T1tyLuu5XMYOkytBxhqs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-5R0EHAcmNGW_CdHVLc-yxw-1; Thu,
 16 Oct 2025 14:58:47 -0400
X-MC-Unique: 5R0EHAcmNGW_CdHVLc-yxw-1
X-Mimecast-MFC-AGG-ID: 5R0EHAcmNGW_CdHVLc-yxw_1760641126
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ACD0180060D;
	Thu, 16 Oct 2025 18:58:46 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B104E1956056;
	Thu, 16 Oct 2025 18:58:45 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 3/6] xfs: flush eof folio before insert range size update
Date: Thu, 16 Oct 2025 15:03:00 -0400
Message-ID: <20251016190303.53881-4-bfoster@redhat.com>
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

The flush in xfs_buffered_write_iomap_begin() for zero range over a
data fork hole fronted by COW fork prealloc is primarily designed to
provide correct zeroing behavior in particular pagecache conditions.
As it turns out, this also partially masks some odd behavior in
insert range (via zero range via setattr).

Insert range bumps i_size the length of the new range, flushes,
unmaps pagecache and cancels COW prealloc, and then right shifts
extents from the end of the file back to the target offset of the
insert. Since the i_size update occurs before the pagecache flush,
this creates a transient situation where writeback around EOF can
behave differently.

This appears to be corner case situation, but if happens to be
fronted by COW fork speculative preallocation and a large, dirty
folio that contains at least one full COW block beyond EOF, the
writeback after i_size is bumped may remap that COW fork block into
the data fork within EOF. The block is zeroed and then shifted back
out to post-eof, but this is unexpected in that it leads to a
written post-eof data fork block. This can cause a zero range
warning on a subsequent size extension, because we should never find
blocks that require physical zeroing beyond i_size.

To avoid this quirk, flush the EOF folio before the i_size update
during insert range. The entire range will be flushed, unmapped and
invalidated anyways, so this should be relatively unnoticeable.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_file.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b9864c8582e..cc3a9674ad40 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1226,6 +1226,23 @@ xfs_falloc_insert_range(
 	if (offset >= isize)
 		return -EINVAL;
 
+	/*
+	 * Let writeback clean up EOF folio state before we bump i_size. The
+	 * insert flushes before it starts shifting and under certain
+	 * circumstances we can write back blocks that should technically be
+	 * considered post-eof (and thus should not be submitted for writeback).
+	 *
+	 * For example, a large, dirty folio that spans EOF and is backed by
+	 * post-eof COW fork preallocation can cause block remap into the data
+	 * fork. This shifts back out beyond EOF, but creates an expectedly
+	 * written post-eof block. The insert is going to flush, unmap and
+	 * cancel prealloc across this whole range, so flush EOF now before we
+	 * bump i_size to provide consistent behavior.
+	 */
+	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
+	if (error)
+		return error;
+
 	error = xfs_falloc_setsize(file, isize + len);
 	if (error)
 		return error;
-- 
2.51.0


