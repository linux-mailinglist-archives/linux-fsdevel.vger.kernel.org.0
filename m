Return-Path: <linux-fsdevel+bounces-79851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI/wH/oer2khOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:26:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2423FE0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C57CF301CC6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FF40757E;
	Mon,  9 Mar 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVfcmB8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B02D978C;
	Mon,  9 Mar 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084286; cv=none; b=j8g05TrbkWNhD/SRTpPhDVEbtTgtrPOrj1eLecj2yTtHD1tbnkv1r/S64sRGu07fjF5Wd/P6PjNKbpmTJeVcQ6/LgKSQMPn9K0GsZeWTwyJzCVryPsYx7zAzS6r7YhXHtJG/AzNESL+yC5wMsxO8BOcogVB+rGSk9MRZNMrbC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084286; c=relaxed/simple;
	bh=ai0l+TjPij5MwNDs/3gUtyGkQTl29Bi0u94+mnmMY3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9uaQCMRQTPtW7SvuOSVuUzXOHQp8/xN3nbn1s/PlptAxwO2texIthzZTqo/Xxt2ny0EUf/YWvjlcdZNaZ++ggCKOUQXxdJ2lpKG9LznJbCTbNNIc/IK2Z8fIEGhNnx3128cXZpcRUfuCPK2DUIIYsKqYiEzB7HpU0ekwYf6vGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVfcmB8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A61C2BCAF;
	Mon,  9 Mar 2026 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084286;
	bh=ai0l+TjPij5MwNDs/3gUtyGkQTl29Bi0u94+mnmMY3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVfcmB8bizDQ3c49TCk6ij6J6Q5Amea6RWV3k4d6ypgplF4Uchsh5hCgrDdWXTY1B
	 WO0ZzSpDVC2YlZvRgt7eUu17Wbe35pSDxNeC1UcS/PhVRk4b0wLLfv7Lk+PLl6d9S+
	 9bM6cv4FdJMAXgLhra4k2Gj4sRbWdmvu86nlmV1seZtZeDov40knQ1dI9iaUjwRwuO
	 toMfgF6b3d0FUbEHSy8w9QnBxWEMWaNpbsmsy2KodjKj2uWzb46qWrdRNcjWrH6/nt
	 gw+f1tSEx7N0bmeXAHG+Y/+RKdhNMggr/Q/kYPoAD6d3z5c2vc+y4JqXg6paPE8j10
	 Ce6uTHOepVibg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	djwong@kernel.org
Subject: [PATCH v4 10/25] iomap: teach iomap to handle fsverity holes and verify data holes
Date: Mon,  9 Mar 2026 20:23:25 +0100
Message-ID: <20260309192355.176980-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260309192355.176980-1-aalbersh@kernel.org>
References: <20260309192355.176980-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAE2423FE0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79851-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

fsverity metadata has two kinds of holes - ones in merkle tree and one
after fsverity descriptor.

Merkle tree holes are blocks full of hashes of zeroed data blocks. These
are not stored on the disk but synthesized on the fly. This saves a bit
of space for sparse files. Due to this iomap also need to lookup
fsverity_info for folios with fsverity metadata. ->vi has a hash of the
zeroed data block which will be used to fill the merkle tree block. This
patch extends lookup of fsverity_info from just for file data but also
for merkle tree holes.

The hole past descriptor is interpreted as end of metadata region. As we
don't have EOF here we use this hole as an indication that rest of the
folio is empty. This patch marks rest of the folio beyond fsverity
descriptor as uptodate.

For file data, fsverity needs to verify consistency of the whole file
against the root hash, hashes of holes are included in the merkle tree.
Verify them too.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1d9481f00b41..31e39ab93a2e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -542,9 +542,33 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		if (plen == 0)
 			return 0;
 
-		/* zero post-eof blocks as the page may be mapped */
-		if (iomap_block_needs_zeroing(iter, pos)) {
+		/*
+		 * Handling of fsverity "holes". We hit this for two case:
+		 *   1. No need to go further, the hole after fsverity
+		 *	descriptor is the end of the fsverity metadata.
+		 *
+		 *   2. This folio contains merkle tree blocks which need to be
+		 *	synthesized. If we already have fsverity info (ctx->vi)
+		 *	synthesize these blocks.
+		 */
+		if ((iomap->flags & IOMAP_F_FSVERITY) &&
+		    iomap->type == IOMAP_HOLE) {
+			/*
+			 * Don't cause lookup if we already have fsverity
+			 * context from the previous tree hole
+			 */
+			if (!ctx->vi)
+				ctx->vi = fsverity_get_info(iter->inode);
+			if (ctx->vi)
+				fsverity_folio_zero_hash(folio, poff, plen,
+							 ctx->vi);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else if (iomap_block_needs_zeroing(iter, pos)) {
+			/* zero post-eof blocks as the page may be mapped */
 			folio_zero_range(folio, poff, plen);
+			if (ctx->vi &&
+			    !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
+				return -EIO;
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			if (!*bytes_submitted)
-- 
2.51.2


