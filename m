Return-Path: <linux-fsdevel+bounces-79784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOgnNkbQrmnEIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:51:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2323A0AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 198AE31D06D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156C3BE14A;
	Mon,  9 Mar 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz9Yl2EX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376333C6A43
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063919; cv=none; b=m5Y+P1eB+/Tf5Uge7/fJbvwU2Vn7h6OJGMnNHC1JldNLsvPLLuti/Tc45gnHkAeTY1Cj41ueqO6Kv2VWyLMa/A0WnNxAxEh673myiK9s+l1Kf6pEkslNWnNLnEDLRGBoXFPEct9Y5AJUtDInSF5W3ZKfvLBUMlLtdbfLASCnyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063919; c=relaxed/simple;
	bh=ia5t6bkAC2hlw8BRoBOBjDmssVZXI35KjSwLRrSR+MU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjLbFYSYgNyyrOxTCp1q4B27dYx8zVRYEVrPi08b+HGxgaUwloxEdMWQmb8WtB2aW4Y2Q70Ryf98LPwIBEgbSWlgCCjD7t+GnUuIfANAXBJ3c2ZYsUAVhLG+HOACUfBqYk30fbVZ02wHYB1lo2bPavy/m8gdCmFI0zqgzaRDF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cz9Yl2EX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773063917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDi5ESx3ObW7CfD/QyaeaZusmZj7k1+ywq7qGZwBJ/o=;
	b=Cz9Yl2EXS51uo6M+gtGnj5KetcLspvZOOxe928IqXy1iSOsXUJq7xzfqKQ4xMh+RWHafy+
	hdi8p7ap3ruYjK3IIApwNidG9IfQbUbLbY8YpEd28BA97Abom4QpeJlJQwddtpgvHjlDyf
	k3Sk18nnEOl4KtGjNd+Z2hkIZxi5Ub8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-qwV08D3-MIiaMlbLFEB3rw-1; Mon,
 09 Mar 2026 09:45:14 -0400
X-MC-Unique: qwV08D3-MIiaMlbLFEB3rw-1
X-Mimecast-MFC-AGG-ID: qwV08D3-MIiaMlbLFEB3rw_1773063913
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DDCA1800611;
	Mon,  9 Mar 2026 13:45:13 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D104A180035F;
	Mon,  9 Mar 2026 13:45:12 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v3 7/8] xfs: replace zero range flush with folio batch
Date: Mon,  9 Mar 2026 09:45:05 -0400
Message-ID: <20260309134506.167663-8-bfoster@redhat.com>
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
X-Rspamd-Queue-Id: 6CF2323A0AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79784-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Action: no action

Now that the zero range pagecache flush is purely isolated to
providing zeroing correctness in this case, we can remove it and
replace it with the folio batch mechanism that is used for handling
unwritten extents.

This is still slightly odd in that XFS reports a hole vs. a mapping
that reflects the COW fork extents, but that has always been the
case in this situation and so a separate issue. We drop the iomap
warning that assumes the folio batch is always associated with
unwritten mappings, but this is mainly a development assertion as
otherwise the core iomap fbatch code doesn't care much about the
mapping type if it's handed the set of folios to process.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c |  4 ----
 fs/xfs/xfs_iomap.c     | 20 ++++++--------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0999aca6e5cc..4422a6d477d7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1633,10 +1633,6 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
 
-		if (WARN_ON_ONCE((iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
-				 srcmap->type != IOMAP_UNWRITTEN))
-			return -EIO;
-
 		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
 		    (srcmap->type == IOMAP_HOLE ||
 		     srcmap->type == IOMAP_UNWRITTEN)) {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ce342b9ce2f0..df240931f07a 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1781,7 +1781,6 @@ xfs_buffered_write_iomap_begin(
 {
 	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
 						     iomap);
-	struct address_space	*mapping = inode->i_mapping;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1813,7 +1812,6 @@ xfs_buffered_write_iomap_begin(
 	if (error)
 		return error;
 
-restart:
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -1866,8 +1864,8 @@ xfs_buffered_write_iomap_begin(
 
 	/*
 	 * We may need to zero over a hole in the data fork if it's fronted by
-	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
-	 * writeback to remap pending blocks and restart the lookup.
+	 * COW blocks and dirty pagecache. Scan such file ranges for dirty
+	 * cache and fill the iomap batch with folios that need zeroing.
 	 */
 	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
 		loff_t	start, end;
@@ -1889,16 +1887,10 @@ xfs_buffered_write_iomap_begin(
 		xfs_trim_extent(&imap, offset_fsb,
 			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
 		start = XFS_FSB_TO_B(mp, imap.br_startoff);
-		end = XFS_FSB_TO_B(mp,
-				   imap.br_startoff + imap.br_blockcount) - 1;
-		if (filemap_range_needs_writeback(mapping, start, end)) {
-			xfs_iunlock(ip, lockmode);
-			error = filemap_write_and_wait_range(mapping, start,
-							     end);
-			if (error)
-				return error;
-			goto restart;
-		}
+		end = XFS_FSB_TO_B(mp, imap.br_startoff + imap.br_blockcount);
+		iomap_fill_dirty_folios(iter, &start, end, &iomap_flags);
+		xfs_trim_extent(&imap, offset_fsb,
+				XFS_B_TO_FSB(mp, start) - offset_fsb);
 
 		goto found_imap;
 	}
-- 
2.52.0


