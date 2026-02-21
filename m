Return-Path: <linux-fsdevel+bounces-77864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCzoOaQZmml2YgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 21:46:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4816DD5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 21:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74013302FE9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 20:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A106368299;
	Sat, 21 Feb 2026 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYFXhts0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5A1E7660;
	Sat, 21 Feb 2026 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771706770; cv=none; b=d+cNKn6F1gyaRhj5KFOHlyf3wJnxzd2f0oQz1UeJpHkvqiiqDhg0BBT9MZHKQV174oFyxPtbO0BpPy5dpby/bkoMTgBvs+TNbOItLU55CFcXraVkNwkeSE2Rnm3Ax8fd7rXsikrRoRT5D7F1JKJPJuLkMGKgSJfBrMxGP5NZkwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771706770; c=relaxed/simple;
	bh=1X5cYAl9kNylIb5ptLXnhArizU/ge+q4nUoOS+5gYfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0kVBr+P8pqYA7oz2xkvqeiqO4COsdiMQ2d6bENQOj29TInzL5iVvOG2MvaVwvOdyPzWIzFMUjgEdW/n57NyhAKy4W/tRLk6lQhJwqEMdB6efj7Dkt675hz/OIc3KaKbdxOJP29tokJUEDi7RqXtBzlzUlRDcTm4OTeMC4fhjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYFXhts0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C82C4CEF7;
	Sat, 21 Feb 2026 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771706770;
	bh=1X5cYAl9kNylIb5ptLXnhArizU/ge+q4nUoOS+5gYfI=;
	h=From:To:Cc:Subject:Date:From;
	b=mYFXhts07Y6/tToRzsac/gkp6Zir8RyBtx4TqE5IoqETTlUoSwHevQQS4bILvnwuE
	 jjAWS/bAQkPf5XCwtyCHg6YxNmhJzFK30m/s/0OWY934eZvzQItzQeTvgDXR1OQJB2
	 OnuM/ecYnnK3TRrJerpGd0UOId7RvhaXW9sSE+kLnEyDBxiFDXdvcl6i6qI7jveDzK
	 2E8X0w8oUzaUmWEf1VOYL8C40nh+X7FaFY4bV2ZdGv/BKaDn18DwKVtqUrWiVG+50X
	 HxE7HWyd4A44W79VyRgUy3an9i/vx/d83GI/z89t1uIyV4NZR2w51zJ3/Ko2QDstSW
	 Cz4i+EICcV0HA==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] fsverity: add dependency on 64K or smaller pages
Date: Sat, 21 Feb 2026 12:45:25 -0800
Message-ID: <20260221204525.30426-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77864-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64E4816DD5C
X-Rspamd-Action: no action

Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
cache the Merkle tree in the pagecache at a 64K aligned offset after the
end of the file data.  This offset needs to be a multiple of the page
size, which is guaranteed only when the page size is 64K or smaller.

64K was chosen to be the "largest reasonable page size".  But it isn't
the largest *possible* page size: the hexagon and powerpc ports of Linux
support 256K pages, though that configuration is rarely used.

For now, just disable support for FS_VERITY in these odd configurations
to ensure it isn't used in cases where it would have incorrect behavior.

Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
Reported-by: Christoph Hellwig <hch@lst.de>
Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
index 76d1c5971b82..b20882963ffb 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
 config FS_VERITY
 	bool "FS Verity (read-only file-based authenticity protection)"
+	# Filesystems cache the Merkle tree at a 64K aligned offset in the
+	# pagecache.  That approach assumes the page size is at most 64K.
+	depends on PAGE_SHIFT <= 16
 	select CRYPTO_HASH_INFO
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
 	help
 	  This option enables fs-verity.  fs-verity is the dm-verity

base-commit: 8934827db5403eae57d4537114a9ff88b0a8460f
-- 
2.53.0


