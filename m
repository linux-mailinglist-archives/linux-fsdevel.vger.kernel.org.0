Return-Path: <linux-fsdevel+bounces-79777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCbEHOzOrmnEIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:45:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612B239EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4704B301E9B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EB3B3BE2;
	Mon,  9 Mar 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3k12vBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F1D1C5F11
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063913; cv=none; b=tx0YaTEbCWRMO00Y2VdDgnbRHpTzajj2zJJmbDzJL6czhBxb4Z5ztvX/xTtRWZNizNUaImOwb3UdEVsklkc+nD2GC9WmvxM9HQ7ZHYWdAtF1oVOI8M7z06HfpDeM0TPL1jNggvQsZbD4fveOt8yzS1vvM0lSEMNloh+/wS4nASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063913; c=relaxed/simple;
	bh=/EVcC+DRH9x072XELSOFT+oprtKn3auPvCTFcr+S+Y8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyNlnT8TW4IP/Svo6yNYQ6EKnaVhr0RQrsSQSHtz7E4TeWPlZmT88R0YdVuIj2INnemMTqNu4KWndZ71aD10ambXxECD2sfHGXiu3QWAXoJPnASc5msZmDVpfndHAYRzsGG/9qafc8kKNbQfz+CqarIxaKQMMBZjuqs67qyxGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3k12vBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773063911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxZWJgni4OV+MDNm9+Oha51+OTI4WnlF1Kzm1F34qBw=;
	b=g3k12vBf5LD/r2Mg7Pja5/6kwUpngzTnYHyKQrgoN3UDbBYSaGA8hVSO58F1mpIrv+sUL8
	X0p0MdADelUbr2giXgQeFzx5Ryy/IGr3cTzVMPbXLETMDFbuLorMOVP2hjJci4sI/y1y/I
	U85mz24Dhf0++SMEaPlbDkQ9BBL04Hk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-V1qMdLXmN4uakwx7pmjXTg-1; Mon,
 09 Mar 2026 09:45:10 -0400
X-MC-Unique: V1qMdLXmN4uakwx7pmjXTg-1
X-Mimecast-MFC-AGG-ID: V1qMdLXmN4uakwx7pmjXTg_1773063909
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9DB19560A3;
	Mon,  9 Mar 2026 13:45:08 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CA6E180035F;
	Mon,  9 Mar 2026 13:45:08 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v3 1/8] xfs: fix iomap hole map reporting for zoned zero range
Date: Mon,  9 Mar 2026 09:44:59 -0400
Message-ID: <20260309134506.167663-2-bfoster@redhat.com>
In-Reply-To: <20260309134506.167663-1-bfoster@redhat.com>
References: <20260309134506.167663-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 3612B239EEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79777-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The hole mapping logic for zero range in zoned mode is not quite
correct. It currently reports a hole whenever one exists in the data
fork. If the first write to a sparse range has completed and not yet
written back, the blocks exist in the COW fork as delalloc until
writeback completes, at which point they are allocated and mapped
into the data fork. If a zero range occurs on a range that has not
yet populated the data fork, we will incorrectly report it as a
hole.

Note that this currently functions correctly because we are bailed
out by the pagecache flush in iomap_zero_range(). If a hole or
unwritten mapping is reported with dirty pagecache, it assumes there
is pending data, flushes to induce any pending block
allocations/remaps, and retries the lookup. We want to remove this
hack from iomap, however, so update iomap_begin() to only report a
hole for zeroing when one exists in both forks.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index be86d43044df..8c3469d2c73e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1651,14 +1651,6 @@ xfs_zoned_buffered_write_iomap_begin(
 				&smap))
 			smap.br_startoff = end_fsb; /* fake hole until EOF */
 		if (smap.br_startoff > offset_fsb) {
-			/*
-			 * We never need to allocate blocks for zeroing a hole.
-			 */
-			if (flags & IOMAP_ZERO) {
-				xfs_hole_to_iomap(ip, iomap, offset_fsb,
-						smap.br_startoff);
-				goto out_unlock;
-			}
 			end_fsb = min(end_fsb, smap.br_startoff);
 		} else {
 			end_fsb = min(end_fsb,
@@ -1690,6 +1682,16 @@ xfs_zoned_buffered_write_iomap_begin(
 	count_fsb = min3(end_fsb - offset_fsb, XFS_MAX_BMBT_EXTLEN,
 			 XFS_B_TO_FSB(mp, 1024 * PAGE_SIZE));
 
+	/*
+	 * When zeroing, don't allocate blocks for holes as they are already
+	 * zeroes, but we need to ensure that no extents exist in both the data
+	 * and COW fork to ensure this really is a hole.
+	 */
+	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
+		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
+		goto out_unlock;
+	}
+
 	/*
 	 * The block reservation is supposed to cover all blocks that the
 	 * operation could possible write, but there is a nasty corner case
-- 
2.52.0


