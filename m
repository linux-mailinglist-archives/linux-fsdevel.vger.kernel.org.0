Return-Path: <linux-fsdevel+bounces-77445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NQECyD4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC999151D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7F53063B60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8F2E2852;
	Tue, 17 Feb 2026 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8x97c7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F02F5A06;
	Tue, 17 Feb 2026 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370451; cv=none; b=GRuWVHTiecbqdH+LVaTR/+GJ+0lnPC+sYcOiW/1XGA3SwySWpAvkxosnNpUalNcmOGUNxxlJzzkgUeWV9G8UBby0w6GUqqGlXcOqezDgIbNdUU3ogcyQa4YtIKrL60g3201GmhDbGoG4+ZWjdxk6eonR4YEBrPhLLxKo4k7I79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370451; c=relaxed/simple;
	bh=r1HNQfqgHc1Lsv3nV2YtF9Z3QdU+3a/NuzMda4LX0Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEZnV5PGzuf18MRgb0SGAaGovrGP4pjtsGYZaB/dwfeBor00+GZvRbJgwIudx3gMXwpN0b26PfxsYanTbBZye2FsMIqLmdSxxUDGuo81i5oZF+OlAHskdFvKURhoeJF5bvKH9v426J2YBMHQ5xqrO2xqA0WH8LV6g+wEbaNXj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8x97c7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04645C19423;
	Tue, 17 Feb 2026 23:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370450;
	bh=r1HNQfqgHc1Lsv3nV2YtF9Z3QdU+3a/NuzMda4LX0Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8x97c7qcqQmWbp4e7JbRkay3Ri4o7ZplOsc9qua12zF9imZt9V/L9+kMOZYDi5w0
	 5rRDqgNbMG5qyE7tZaO1DWt4QdiXEIVZXp0l9MDRZ1855CQd4wv2nrSSOw+Kn5Qtyf
	 EKIfgv7Ngyb9QbNqGmH8X07DDA2lKc9bBQeggQUJz+LF5wg28r9BvUuLa/GQgM+iHi
	 rIzWu5pEza0xfW9M0m1bxlRPar/z2tvLB8/WUMxKINuLwbq6yZmFI04zBBOs+8yvG/
	 bZQUMwJB581cYGk4TqaGKSN4r2pqcbqN16HTihw4ile2Tpuudj08rU3t+r1HRqnofn
	 2jWooaMIuIV8Q==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 08/35] iomap: don't limit fsverity metadata by EOF in writeback
Date: Wed, 18 Feb 2026 00:19:08 +0100
Message-ID: <20260217231937.1183679-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260217231937.1183679-1-aalbersh@kernel.org>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77445-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC999151D80
X-Rspamd-Action: no action

fsverity metadata is stored at the next folio after largest folio
containing EOF.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4cf9d0991dc1..a95f87b4efe1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1817,7 +1817,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
+	if (!(wpc->iomap.flags & IOMAP_F_FSVERITY) &&
+	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
 	WARN_ON_ONCE(end_pos <= pos);
 
-- 
2.51.2


