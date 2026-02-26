Return-Path: <linux-fsdevel+bounces-78661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LtTJ5bYoGl0nQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:34:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA821B0F11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F06E230498C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25D133067D;
	Thu, 26 Feb 2026 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGG4KyyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402053161B1;
	Thu, 26 Feb 2026 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772148883; cv=none; b=PnyO+qC3quOcWnRghh6xei/queWASLVXEXW9sZ5TxYiDkjVXLzCY+2GUk5R/fY4FtvXBcRJj/KBtorDpJGtVVxiQWxuZVivCxXP3djAWaBGxEmWVsBVTFxdQsBSkDP4aM+7iKUO6nR1/n8Vt4AMlxoVjiTmVCKsaVCxmUWpgufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772148883; c=relaxed/simple;
	bh=G2Z7NtCHIUHHKGxjUBF3fdUwmVbb9a6Zf/tXL6GG43M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j3UwGsytndIPs4EEdeDu/3Kgq2uTtGTd6bEku+qBZ+2Hb6HW58gWvr+ziS2+ybewkkczBaFIHDZbHV0txQy9TQs1x0h8w/Ww6g1sL1Su4TDEDqjR3obCPc7ZN/MqjkGXaZeyJjvKxep3Qz0/6UVil6iIqEd8oFETbrrY2TW3BH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGG4KyyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DC2C116C6;
	Thu, 26 Feb 2026 23:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772148883;
	bh=G2Z7NtCHIUHHKGxjUBF3fdUwmVbb9a6Zf/tXL6GG43M=;
	h=Date:From:To:Cc:Subject:From;
	b=GGG4KyyWtsu8Nma3uN6kDBbJrN7Hfq8ui26uIuQppUcvjLVQJXOphL7uhL22O/Lzk
	 ThQlv3RbmQa2+gITC31CICayHyigruVymgwZEf1MxHzwm0w7XDjNkgk916LhxkVGT6
	 d6LapOWKN3+XkHRry3himAiRfX5EHIiwJNa9GhkpIcZcjvxXpfu0WQt8tyf6877KKL
	 Crm2CvVXpKySLxHwcSu2jT3BMBuDJOwKpM56e6g1sVlKiBJjXG2OFJ8bUd7bNztE2j
	 vKQicSUNr9jWY8/N1IqTzGwOHgds6kunka/VRiEg801vZP5ocslBo9/U0JvmnFcWmy
	 CKzSGjmJkxBxA==
Date: Thu, 26 Feb 2026 15:34:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: [PATCH v2] iomap: reject delalloc mappings during writeback
Message-ID: <20260226233442.GH13853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-78661-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EA821B0F11
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Filesystems should never provide a delayed allocation mapping to
writeback; they're supposed to allocate the space before replying.
This can lead to weird IO errors and crashes in the block layer if the
filesystem is being malicious, or if it hadn't set iomap->dev because
it's a delalloc mapping.

Fix this by failing writeback on delalloc mappings.  Currently no
filesystems actually misbehave in this manner, but we ought to be
stricter about things like that.

Cc: <stable@vger.kernel.org> # v5.5
Fixes: 598ecfbaa742ac ("iomap: lift the xfs writeback code to iomap")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
v2: futureproof new iomap types
---
 fs/iomap/ioend.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 4d1ef8a2cee90b..60546fa14dfe4d 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -215,17 +215,18 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
 
 	switch (wpc->iomap.type) {
-	case IOMAP_INLINE:
-		WARN_ON_ONCE(1);
-		return -EIO;
+	case IOMAP_UNWRITTEN:
+		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+		break;
+	case IOMAP_MAPPED:
+		break;
 	case IOMAP_HOLE:
 		return map_len;
 	default:
-		break;
+		WARN_ON_ONCE(1);
+		return -EIO;
 	}
 
-	if (wpc->iomap.type == IOMAP_UNWRITTEN)
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
 	if (folio_test_dropbehind(folio))

