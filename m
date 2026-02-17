Return-Path: <linux-fsdevel+bounces-77450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CHDMmj4lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:23:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553F151E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4688E307E0B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C7221FCF;
	Tue, 17 Feb 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbaT5PB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61B2EC553;
	Tue, 17 Feb 2026 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370461; cv=none; b=MSRzUjWZVRf5j05Wcr/jG4IUKMom9O05SsG53+492TOLJm8vU9fqFvOmnEOneGNgyHgpjv4MRoh33EEmRHj/mt7ixQM+DBgW0xROdVPb045tm+Ji3mZZV38RvScnyDWtd6XBjo4+Q26ez8r5o1RUGo4/r6pJNSDaEw8n0ZLNOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370461; c=relaxed/simple;
	bh=NCDsnHDKq6Cdko3p3l7SLVp7DPEb2pb1GTkcsMnsOrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbeeaivWFIigfzkVyiierPuonrsLAHoDsExr2Ti+Nsh8iFy6nSrjypmdUzHQWtJ3nT7LcB1U1nYdGZEO88ALOI4URC/NYsFWWdZT+w5yavF4BZlK/SCKJk5aaQrd7b1N7tle5W2NXC79ZTHg+1HUTJTSOsZ78CHTYJ3SE/FA/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbaT5PB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C69AC4CEF7;
	Tue, 17 Feb 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370461;
	bh=NCDsnHDKq6Cdko3p3l7SLVp7DPEb2pb1GTkcsMnsOrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbaT5PB/3v1lyXtjvymCnjfRp2Rt8KS62PYbC5wSIAIOdhG8xkC9hJvILTW9MuucZ
	 xSsgCLu7hOjo/+TDfn6Hv36kPfmwpt875CEALJ4/wI28uDp8j5P4N79oyEFiKk1f22
	 dwGYG8cGrQcNVmF/KiolxYfRKZU9TcNQLm/rBTHp+El7vFR8YnHGi1MgT2PiYlvDFO
	 qi8FNJR9l8DUEQO7yWowykdsrgxQFNRBCeC+GCm87m3b/Bem4Q5+5visBVpWV72sq3
	 KHbJkBu/rGEGxL+JJtaPaNxX5dzDe1mEZH8jslKI8o2PKtAufrGbQmMH+TKn5Pdip+
	 wkKmSGV2PnzJQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 13/35] xfs: use folio host instead of file struct
Date: Wed, 18 Feb 2026 00:19:13 +0100
Message-ID: <20260217231937.1183679-14-aalbersh@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77450-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6553F151E1C
X-Rspamd-Action: no action

fsverity will not have file struct in ioend context
(fsverity_verify_bio() path). This will cause null pointer dereference
here.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index bf985b5e73a0..36c4b2b4b07a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -779,7 +779,7 @@ xfs_vm_read_folio(
 {
 	struct iomap_read_folio_ctx	ctx = {
 		.cur_folio	= folio,
-		.ops		= xfs_bio_read_ops(XFS_I(file->f_mapping->host)),
+		.ops		= xfs_bio_read_ops(XFS_I(folio->mapping->host)),
 	};
 
 	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
-- 
2.51.2


