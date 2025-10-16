Return-Path: <linux-fsdevel+bounces-64387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBFBE522C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D24586084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C9241695;
	Thu, 16 Oct 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foqbVkYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077E23F421
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641131; cv=none; b=DxNVcZFizeqZ7QPzipPN+kwi3JJcYmUwC/uRvTwh1yfIPlh1t9I56USBaRlkmMX/X7TwSzsRjjbwrHskvOgIhUvi617Ba23XEdmD/Aopc+J7ZaBo3oPb9phAdFXi/atCDo6XagF0NzesEPycF7s7TLTvxgPtfSD60FP9TFPHITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641131; c=relaxed/simple;
	bh=uq0H3o+AC/8XVE7Fcxjqo2TVpXinyPxCAaNsJGr53aw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZniTr46tU8AV1CpCxEdhbtNYFUkxK83mkyIxkmLeKYMQl4vlncxuPSit/FTWnERYh4Id2MXRjcxQKp00nvOc1r/NzxqtpGwEoGaxz7dTwILUEY3MNvi5p8XTS3V2nOEelRyJBn5pv0l3tg7U+x5IL9C/vc73U2v9dfDzeM1hxIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foqbVkYO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760641128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CJkA8HFOi/1vNjFTuTPnttPB7NDmGN7oRbCuAPDjTM=;
	b=foqbVkYOYys1jwRimGbbFsWiH8LZN/JShSh7DzwnUkXDt0N/I8jAXYbgKx93pPIMeRjarO
	AEv2ISCwtaBssFm+ykP9ti6++attsBK9ixGqkLkssFt08RTb9k+w+sHHFEW+dZdPTuvYlD
	iZc2I9ESSOnvXqBqV1GsmiilGd3MHWM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-cbZ5ysUCN76QFM8hvJeXRg-1; Thu,
 16 Oct 2025 14:58:46 -0400
X-MC-Unique: cbZ5ysUCN76QFM8hvJeXRg-1
X-Mimecast-MFC-AGG-ID: cbZ5ysUCN76QFM8hvJeXRg_1760641125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B068195608A;
	Thu, 16 Oct 2025 18:58:45 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.65.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9ACF1956056;
	Thu, 16 Oct 2025 18:58:44 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into xfs
Date: Thu, 16 Oct 2025 15:02:59 -0400
Message-ID: <20251016190303.53881-3-bfoster@redhat.com>
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

iomap zero range has a wart in that it also flushes dirty pagecache
over hole mappings (rather than only unwritten mappings). This was
included to accommodate a quirk in XFS where COW fork preallocation
can exist over a hole in the data fork, and the associated range is
reported as a hole. This is because the range actually is a hole,
but XFS also has an optimization where if COW fork blocks exist for
a range being written to, those blocks are used regardless of
whether the data fork blocks are shared or not. For zeroing, COW
fork blocks over a data fork hole are only relevant if the range is
dirty in pagecache, otherwise the range is already considered
zeroed.

The easiest way to deal with this corner case is to flush the
pagecache to trigger COW remapping into the data fork, and then
operate on the updated on-disk state. The problem is that ext4
cannot accommodate a flush from this context due to being a
transaction deadlock vector.

Outside of the hole quirk, ext4 can avoid the flush for zero range
by using the recently introduced folio batch lookup mechanism for
unwritten mappings. Therefore, take the next logical step and lift
the hole handling logic into the XFS iomap_begin handler. iomap will
still flush on unwritten mappings without a folio batch, and XFS
will flush and retry mapping lookups in the case where it would
otherwise report a hole with dirty pagecache during a zero range.

Note that this is intended to be a fairly straightforward lift and
otherwise not change behavior. Now that the flush exists within XFS,
follow on patches can further optimize it.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c |  2 +-
 fs/xfs/xfs_iomap.c     | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 05ff82c5432e..d6de689374c3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1543,7 +1543,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		     srcmap->type == IOMAP_UNWRITTEN)) {
 			s64 status;
 
-			if (range_dirty) {
+			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
 				range_dirty = false;
 				status = iomap_zero_iter_flush_and_stale(&iter);
 			} else {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 01833aca37ac..b84c94558cc9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1734,6 +1734,7 @@ xfs_buffered_write_iomap_begin(
 	if (error)
 		return error;
 
+restart:
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -1761,9 +1762,27 @@ xfs_buffered_write_iomap_begin(
 	if (eof)
 		imap.br_startoff = end_fsb; /* fake hole until the end */
 
-	/* We never need to allocate blocks for zeroing or unsharing a hole. */
-	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
-	    imap.br_startoff > offset_fsb) {
+	/* We never need to allocate blocks for unsharing a hole. */
+	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
+		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
+		goto out_unlock;
+	}
+
+	/*
+	 * We may need to zero over a hole in the data fork if it's fronted by
+	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
+	 * writeback to remap pending blocks and restart the lookup.
+	 */
+	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
+		if (filemap_range_needs_writeback(inode->i_mapping, offset,
+						  offset + count - 1)) {
+			xfs_iunlock(ip, lockmode);
+			error = filemap_write_and_wait_range(inode->i_mapping,
+						offset, offset + count - 1);
+			if (error)
+				return error;
+			goto restart;
+		}
 		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
 		goto out_unlock;
 	}
-- 
2.51.0


