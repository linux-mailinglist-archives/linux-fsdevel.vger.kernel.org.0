Return-Path: <linux-fsdevel+bounces-77457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFbCEgv4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1F151D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13B0A305CD23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948F2F5A06;
	Tue, 17 Feb 2026 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li8fvEtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FA29D297;
	Tue, 17 Feb 2026 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370476; cv=none; b=pXijokakwcAQDgMre+UXXRUt5Tq6OjiWtZbIZ10YSxZrKfu07iWZLKsgUlMrYCLlojPLX0D9W+ZvYrhcc4NB+0aYKPu1QFk0ywhMSHqt9+uhQhKBAm/E0xhsdajJzHr4kJYA+yPluJrefTxCDOy3D/FFi/iD8FvjT3uwNSxrnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370476; c=relaxed/simple;
	bh=eP/VgEXq2cUyW0lHHZf1k7Cilb1XU3SDXQR+jioVuT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1BRcSVTxNE4qUSn8qd9Ah9D3KoQEcGrNOSJlMjQ7VBOez5qa+bfo/Vnb5WqSaBpdD1xfY3dnW1e+opMKW+Og6HuPrAjgDqDVUcm84DT1dC6TAY03vLiUxOdPOm6Rl7HNjJraLsnhMuJaYoZUdzxnlkUspnoFKQm6jtiPB6sjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li8fvEtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70950C4CEF7;
	Tue, 17 Feb 2026 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370476;
	bh=eP/VgEXq2cUyW0lHHZf1k7Cilb1XU3SDXQR+jioVuT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Li8fvEtC7PmQnBMjFLOujU/y2Ied6LnrA5VYB44BuQdW7EutoaMT0zOmG/46nQqsM
	 sD+W469YzTiqaXvqIGN0isr2uL0V/70ClG88VkVk3nH+fQdKaMa38IDYCGDBLEfLR9
	 e0uoUv3tB3BdieXktNqfp99xYAyymcQo1Eu5YQVnqkSBBRXv3ltnVwPLpGNuqgezsc
	 50zFjc9B2ima83oacVTExop3eOFz2RWnI/nJ1Kw02wZYpdV4pPyD9CNYLi2YnEbNfR
	 eEEdCcg+mC+ViFHsLyScld9tPcl7O1dMR9sX3NkKJG0n3yZcZ3otq1coKGRbGskhAp
	 cEDbK9X4uYVzQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 20/35] xfs: introduce XFS_FSVERITY_REGION_START constant
Date: Wed, 18 Feb 2026 00:19:20 +0100
Message-ID: <20260217231937.1183679-21-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77457-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAD1F151D30
X-Rspamd-Action: no action

This is location of fsverity metadata in the file. This offset is used
to store data on disk. When metadata is read into pagecache they are
shifted to the offset returned by fsverity_metadata_offset().

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 12463ba766da..e9c92bc0e64b 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1106,4 +1106,28 @@ enum xfs_device {
 #define BBTOB(bbs)	((bbs) << BBSHIFT)
 #endif
 
+/*
+ * Merkle tree and fsverity descriptor location on disk, in bytes. While this
+ * offset is huge, when data is read into pagecache iomap uses offset returned
+ * by fsverity_metadata_offset(), which is just beyound EOF.
+ *
+ * At maximum of 8 levels with 128 hashes per block (32 bytes SHA-256) maximum
+ * tree size is ((128^8 − 1)/(128 − 1)) = 567*10^12 blocks. This should fit in 53
+ * bits address space.
+ *
+ * At this Merkle tree size we can cover 295EB large file. This is much larger
+ * than the currently supported file size.
+ *
+ * For sha512 the largest file we can cover ends at 1 << 50 offset, this is also
+ * good.
+ *
+ * The metadata is placed as follows:
+ *
+ *	[merkle tree...][descriptor.............desc_size]
+ *	^ (1 << 53)     ^ (block border)                 ^ (end of the block)
+ *	                ^--------------------------------^
+ *	                Can be FS_VERITY_MAX_DESCRIPTOR_SIZE
+ */
+#define XFS_FSVERITY_REGION_START ((loff_t)1ULL << 53)
+
 #endif	/* __XFS_FS_H__ */
-- 
2.51.2


