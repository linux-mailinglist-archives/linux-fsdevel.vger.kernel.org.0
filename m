Return-Path: <linux-fsdevel+bounces-79783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J+dID7QrmnEIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:50:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB623A0A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2E231C6E01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471CC27A462;
	Mon,  9 Mar 2026 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKJXq4ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C53C3BE5
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063918; cv=none; b=c23kT4odtdGX+KXokwCdvI2APXDBsy8UINpn3YCuPBtHB0EO1EiNLzvt6aUIziSX3BOVnaVPjgdlUP+BJEkNbcKI3Kt8ucrHGeXt4MvgFpolabbam6pjucLVFrdW4jpbIZ/OCFx5O/vOgHl2GlsBq7IR/aTv1NDvzwLfQpxy0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063918; c=relaxed/simple;
	bh=aTUUxz2YgVUwOiQqZ7tIlp6NO1cqBn8ZKI/Fd8HBqqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT0uaEf0l7iPIMFuvZTb3N8K0noIY+5PrqIg5CLhSNGkJRJ/Y2D4WhaTKH9dd6utF7lqR8ZbRjmmjjfl4pqHnk92lVQ3BKaFUg4ZKrUvYzyzTqUb4mDYlWU3FcyW3+Ox0Ev4jMyAiwarwc/VjOjw50JQpadHjg80I0HEA2GEYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKJXq4ek; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773063916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JMW1hNhJ1/0zYpQuiyMnmCroeibaC2slxlZYv8D1xc=;
	b=HKJXq4ek/R1H5J98uh65r8KCx6UVNfWMlMfAnBynvdsrLT9QP+K8ND7Mc6Geztca38fi1a
	VuGzoWQEh6VrKt25P1b5rXdtykh0XSrmvGX5rDGqBTEVMAD8u97MvjNekoj+TjsAgStzzq
	LLHW3KO+eqO2DVaKC1200mM4PYpz44g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-kDIDWbZXNS2oI5LvZMdt2g-1; Mon,
 09 Mar 2026 09:45:14 -0400
X-MC-Unique: kDIDWbZXNS2oI5LvZMdt2g-1
X-Mimecast-MFC-AGG-ID: kDIDWbZXNS2oI5LvZMdt2g_1773063914
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C28418005B2;
	Mon,  9 Mar 2026 13:45:14 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93B1B1800361;
	Mon,  9 Mar 2026 13:45:13 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v3 8/8] xfs: report cow mappings with dirty pagecache for iomap zero range
Date: Mon,  9 Mar 2026 09:45:06 -0400
Message-ID: <20260309134506.167663-9-bfoster@redhat.com>
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
X-Rspamd-Queue-Id: DBDB623A0A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79783-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

XFS has long supported the case where it is possible to have dirty
data in pagecache backed by COW fork blocks and a hole in the data
fork. This occurs for two reasons. On reflink enabled files, COW
fork blocks are allocated with preallocation to help avoid
fragmention. Second, if a mapping lookup for a write finds blocks in
the COW fork, it consumes those blocks unconditionally. This might
mean that COW fork blocks are backed by non-shared blocks or even a
hole in the data fork, both of which are perfectly fine.

This leaves an odd corner case for zero range, however, because it
needs to distinguish between ranges that are sparse and thus do not
require zeroing and those that are not. A range backed by COW fork
blocks and a data fork hole might either be a legitimate hole in the
file or a range with pending buffered writes that will be written
back (which will remap COW fork blocks into the data fork).

This "COW fork blocks over data fork hole" situation has
historically been reported as a hole to iomap, which then has grown
a flush hack as a workaround to ensure zeroing occurs correctly. Now
that this has been lifted into the filesystem and replaced by the
dirty folio lookup mechanism, we can do better and use the pagecache
state to decide how to report the mapping. If a COW fork range
exists with dirty folios in cache, then report a typical shared
mapping. If the range is clean in cache, then we can consider the
COW blocks preallocation and call it a hole.

This doesn't fundamentally change behavior, but makes mapping
reporting more accurate. Note that this does require splitting
across the EOF boundary (similar to normal zero range) to ensure we
don't spuriously perform post-eof zeroing. iomap will warn about
zeroing beyond EOF because folios beyond i_size may not be written
back.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_iomap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index df240931f07a..3bef5ea610bb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1786,6 +1786,7 @@ xfs_buffered_write_iomap_begin(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
 	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
+	xfs_fileoff_t		eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
 	struct xfs_bmbt_irec	imap, cmap;
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
@@ -1868,7 +1869,8 @@ xfs_buffered_write_iomap_begin(
 	 * cache and fill the iomap batch with folios that need zeroing.
 	 */
 	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
-		loff_t	start, end;
+		loff_t		start, end;
+		unsigned int	fbatch_count;
 
 		imap.br_blockcount = imap.br_startoff - offset_fsb;
 		imap.br_startoff = offset_fsb;
@@ -1883,15 +1885,32 @@ xfs_buffered_write_iomap_begin(
 			goto found_imap;
 		}
 
+		/* no zeroing beyond eof, so split at the boundary */
+		if (offset_fsb >= eof_fsb)
+			goto found_imap;
+		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
+			xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
+
 		/* COW fork blocks overlap the hole */
 		xfs_trim_extent(&imap, offset_fsb,
 			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
 		start = XFS_FSB_TO_B(mp, imap.br_startoff);
 		end = XFS_FSB_TO_B(mp, imap.br_startoff + imap.br_blockcount);
-		iomap_fill_dirty_folios(iter, &start, end, &iomap_flags);
+		fbatch_count = iomap_fill_dirty_folios(iter, &start, end,
+						       &iomap_flags);
 		xfs_trim_extent(&imap, offset_fsb,
 				XFS_B_TO_FSB(mp, start) - offset_fsb);
 
+		/*
+		 * Report the COW mapping if we have folios to zero. Otherwise
+		 * ignore the COW blocks as preallocation and report a hole.
+		 */
+		if (fbatch_count) {
+			xfs_trim_extent(&cmap, imap.br_startoff,
+					imap.br_blockcount);
+			imap.br_startoff = end_fsb;	/* fake hole */
+			goto found_cow;
+		}
 		goto found_imap;
 	}
 
@@ -1901,8 +1920,6 @@ xfs_buffered_write_iomap_begin(
 	 * unwritten extent.
 	 */
 	if (flags & IOMAP_ZERO) {
-		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
-
 		if (isnullstartblock(imap.br_startblock) &&
 		    offset_fsb >= eof_fsb)
 			goto convert_delay;
-- 
2.52.0


