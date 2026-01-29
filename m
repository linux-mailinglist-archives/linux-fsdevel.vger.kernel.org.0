Return-Path: <linux-fsdevel+bounces-75874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD9mIeCBe2mvFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:50:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E8B1A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94DAE300AB30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A062F7449;
	Thu, 29 Jan 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmV7jZgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB63335083
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701837; cv=none; b=E7dzg1B00EkC1vUg8VfWaCMqBFzN6iIVNzk8LjEyHhM0UqtXXTbcOWLm0o8udAcNp2YIgmgwvmdYxmUZmPrA9OBsI83MAqp8IOxVDBRAiZkZ+gKUm7Kms/RkZGmhKbQkA4+QTv1RBKS3l9sjWFPgr4dtLja+VvjPOZGjbh8p/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701837; c=relaxed/simple;
	bh=+VifD1QK5yL+8mLzOxDVjXW4dmZy9fRCszez1JHXc1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvdRn6MIp7FaifR8CCvIGxUGRVRkots+tQUjdU6aaj00mOk84XqOBazkWn5kzrZVKhvsWVw44+YbM9CeTU6PWxAYipIVlyvQi/cgRlkwF8591LGwoQahxnWBFTVpTmRJv42JSimCP0+6GRmB2ENm6qz3YLh0Sg9nM5iOT/8KofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmV7jZgf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769701834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtsV9gOBfhNZN81tiT2rVAHlD0W9eXJmwljbhGJpR5M=;
	b=BmV7jZgfPuu/4U0c+q54ViJvr/pMvt8WxlzlFkkVxRFOPg4z9gSDIBCsxtaeo7c9uhyTU0
	iCnGlSKTF4JENCYek4p//dF+TxgDbEydJkmGUdf9nq+6g6vi9spo0ZQptyw7WpWbV6E/8k
	GSS7C+q3mx8kbZnc+6L9yyHqWxJP5KY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-gI2cxzd9PmqzwODqnreKCQ-1; Thu,
 29 Jan 2026 10:50:33 -0500
X-MC-Unique: gI2cxzd9PmqzwODqnreKCQ-1
X-Mimecast-MFC-AGG-ID: gI2cxzd9PmqzwODqnreKCQ_1769701832
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 345F718005B0;
	Thu, 29 Jan 2026 15:50:32 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.81.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD8501800870;
	Thu, 29 Jan 2026 15:50:31 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2 4/5] xfs: only flush when COW fork blocks overlap data fork holes
Date: Thu, 29 Jan 2026 10:50:27 -0500
Message-ID: <20260129155028.141110-5-bfoster@redhat.com>
In-Reply-To: <20260129155028.141110-1-bfoster@redhat.com>
References: <20260129155028.141110-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-75874-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 292E8B1A3A
X-Rspamd-Action: no action

The zero range hole mapping flush case has been lifted from iomap
into XFS. Now that we have more mapping context available from the
->iomap_begin() handler, we can isolate the flush further to when we
know a hole is fronted by COW blocks.

Rather than purely rely on pagecache dirty state, explicitly check
for the case where a range is a hole in both forks. Otherwise trim
to the range where there does happen to be overlap and use that for
the pagecache writeback check. This might prevent some spurious
zeroing, but more importantly makes it easier to remove the flush
entirely.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 0edab7af4a10..0e82b4ec8264 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1760,10 +1760,12 @@ xfs_buffered_write_iomap_begin(
 {
 	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
 						     iomap);
+	struct address_space	*mapping = inode->i_mapping;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
+	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
 	struct xfs_bmbt_irec	imap, cmap;
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
@@ -1831,6 +1833,8 @@ xfs_buffered_write_iomap_begin(
 		}
 		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
 				&ccur, &cmap);
+		if (!cow_eof)
+			cow_fsb = cmap.br_startoff;
 	}
 
 	/* We never need to allocate blocks for unsharing a hole. */
@@ -1845,17 +1849,37 @@ xfs_buffered_write_iomap_begin(
 	 * writeback to remap pending blocks and restart the lookup.
 	 */
 	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
-		if (filemap_range_needs_writeback(inode->i_mapping, offset,
-						  offset + count - 1)) {
+		loff_t start, end;
+
+		imap.br_blockcount = imap.br_startoff - offset_fsb;
+		imap.br_startoff = offset_fsb;
+		imap.br_startblock = HOLESTARTBLOCK;
+		imap.br_state = XFS_EXT_NORM;
+
+		if (cow_fsb == NULLFILEOFF) {
+			goto found_imap;
+		} else if (cow_fsb > offset_fsb) {
+			xfs_trim_extent(&imap, offset_fsb,
+					cow_fsb - offset_fsb);
+			goto found_imap;
+		}
+
+		/* COW fork blocks overlap the hole */
+		xfs_trim_extent(&imap, offset_fsb,
+			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
+		start = XFS_FSB_TO_B(mp, imap.br_startoff);
+		end = XFS_FSB_TO_B(mp,
+				   imap.br_startoff + imap.br_blockcount) - 1;
+		if (filemap_range_needs_writeback(mapping, start, end)) {
 			xfs_iunlock(ip, lockmode);
-			error = filemap_write_and_wait_range(inode->i_mapping,
-						offset, offset + count - 1);
+			error = filemap_write_and_wait_range(mapping, start,
+							     end);
 			if (error)
 				return error;
 			goto restart;
 		}
-		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
-		goto out_unlock;
+
+		goto found_imap;
 	}
 
 	/*
-- 
2.52.0


