Return-Path: <linux-fsdevel+bounces-77230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LtuLt/mkGnudgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:19:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CA13D476
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75CF73031CFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49228641F;
	Sat, 14 Feb 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um1xgCah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB828134C;
	Sat, 14 Feb 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771103957; cv=none; b=cNOSuNyy+mbh8GPZpZZKwJp2W1ZcywkrwovrZriRRltZEMfzRKy1Kmrh/za2DKo/sRCrypH/WJFqZUMfXLk0CWuGhZmo3ShDztA4uWzO5Sr720S+tBOloF8acCjkNiOIrnuR5NaUZRcUJdoX0TjVTIXRx6epBulLVbh1vHbRfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771103957; c=relaxed/simple;
	bh=l4tyUf9SoYD1pZQH8FZhtNk80NNflOB68ZUcN5ikYDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaaVb5UgttvGTlct+Ov6Y47MEMdy2eB4K+uO9gDUUhhiV1Evwc77vIbR+XL5XXrirAmRl9lC0TNq9tz6yUdSMUptMWX7HQnvIf6NsKjRwCCdru5KgDh4QF1vi50f+PWZ1uAcYHNWuJbzwCd+zY7yqC+9kL1BZshZ5D3VNhcD7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um1xgCah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E93C19422;
	Sat, 14 Feb 2026 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771103957;
	bh=l4tyUf9SoYD1pZQH8FZhtNk80NNflOB68ZUcN5ikYDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=um1xgCahK2mQl1wJccCYYWfO4+eDF4HjkTN7eps3jFKzaxoU2PMU2LbL3QE405CTa
	 cIlxMxxIDL6Jn+12TIrCTz+vD56mri1y9hLXk/U2ld8R8pCW6/OIQ07bUewXatV/YH
	 1Xp+hpf/aNGg7FY/xeI+wcVOcc/SWa9QnW4EzR59DGYzH6/aCxwGvbY2IPmIYTMfsQ
	 1XmpVinih/tytBAG32cGGMzdDV9mTvp3znTynI1Iim6Lguvb80WnJ+MWdUKuBs0Dse
	 08c4tW6wZ7d/qN0henb5wMFqcCPeSCzuD97ZvtIrTUVvgOmJsQ3yYSev1meYPELA7j
	 AjDgR0BvA92nQ==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2 1/2] f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
Date: Sat, 14 Feb 2026 13:18:29 -0800
Message-ID: <20260214211830.15437-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214211830.15437-1-ebiggers@kernel.org>
References: <20260214211830.15437-1-ebiggers@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-77230-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 073CA13D476
X-Rspamd-Action: no action

Replace the only remaining caller of fsverity_verify_page() with a
direct call to fsverity_verify_blocks().  This will allow
fsverity_verify_page() to be removed.

Make it large-folio-aware by using the page's offset in the folio
instead of 0, though the rest of f2fs_verify_cluster() and f2fs
decompression as a whole still assumes small folios.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/compress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 006a80acd1de..11c4de515f98 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1811,15 +1811,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
 	for (i = 0; i < dic->cluster_size; i++) {
 		struct page *rpage = dic->rpages[i];
+		struct folio *rfolio;
+		size_t offset;
 
 		if (!rpage)
 			continue;
+		rfolio = page_folio(rpage);
+		offset = folio_page_idx(rfolio, rpage) * PAGE_SIZE;
 
-		if (fsverity_verify_page(dic->vi, rpage))
+		if (fsverity_verify_blocks(dic->vi, rfolio, PAGE_SIZE, offset))
 			SetPageUptodate(rpage);
 		else
 			ClearPageUptodate(rpage);
 		unlock_page(rpage);
 	}
-- 
2.53.0


