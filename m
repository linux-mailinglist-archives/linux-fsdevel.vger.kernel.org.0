Return-Path: <linux-fsdevel+bounces-77447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOxxM9z3lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D65F151C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15063048074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780382E2852;
	Tue, 17 Feb 2026 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npxuw6PN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07003221FCF;
	Tue, 17 Feb 2026 23:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370455; cv=none; b=qJVDebJ+hQtSALPziRbXrSWeqA9xyi1OvzUF/HPibh9OqZfE/NA50w1tX1yx/PsAjC9whhyigyHGgEPAaBek8OUJG1NeBkG/BtL3c17E7P2pfkwk6BVlgHq9S185iEk257Z0zDdXhtshn8gpqKLhXacJCsK9ukO68Y1vRNswhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370455; c=relaxed/simple;
	bh=6tc+JA4sk6Y4Lf3d99eMzGIQ3UpFh1RjotdPAIOmhQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYqT8LylJhrIPpKWWzvrXusQtEAyLM0qsZ3NFGBx2jxOcXTKmSuH2pqaCSsvbE7E0g/vpCwci60XXROmwoSTNp1rUreudkk213M3gQnyyhnny+WA+Ge45UJjy2qx6yInUF6/tyqyYHEKzII2QdmCxJDjo0M8E+s82wIHRV1ip2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npxuw6PN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413DCC4CEF7;
	Tue, 17 Feb 2026 23:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370454;
	bh=6tc+JA4sk6Y4Lf3d99eMzGIQ3UpFh1RjotdPAIOmhQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npxuw6PNS64pZniKtEX8ceCpTpPCwbduip2dvqvYoIEUECS0c0VkcU6AUX0ti80g2
	 1OtdMuFDojHaqrWkf9VHif4B9Ef+Yhhc5n++DZkBPvT459LlsOpDjRxq7b09hYjnGf
	 XzSPDjtN6Y2hdkigAUBg1FMD1e6Ve643up9xm+Yzn9jBmn9G6oo9amM0r3TwWZU99r
	 dz5xweVXfDaotGFTdB3TyGDkIG6R7/TZxbb0eC1h2BLcbvcmvEyuXvwKZcBE1Is7qS
	 AtNdBdf7FKDG2yMOKlWczaSgYcGBdnDj/P9WDArxkGdObawELGT9i84A54KmtV+T/4
	 X4KZjElhPAehQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 10/35] iomap: issue readahead for fsverity merkle tree
Date: Wed, 18 Feb 2026 00:19:10 +0100
Message-ID: <20260217231937.1183679-11-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77447-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D65F151C8C
X-Rspamd-Action: no action

Issue reading of fsverity merkle tree on the fsverity inodes. This way
metadata will be available at I/O completion time.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cd74a15411cf..bd3ab4e6b2bf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -570,8 +570,12 @@ void iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
-	if (fsverity_active(iter.inode))
+	if (fsverity_active(iter.inode)) {
 		ctx->vi = fsverity_get_info(iter.inode);
+		if (iter.pos < fsverity_metadata_offset(iter.inode))
+			fsverity_readahead(ctx->vi, folio->index,
+					   folio_nr_pages(folio));
+	}
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, ctx,
-- 
2.51.2


