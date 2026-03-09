Return-Path: <linux-fsdevel+bounces-79845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGW8OU0gr2neOAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:32:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003224009E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00C23120436
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15F3F23BB;
	Mon,  9 Mar 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID2p+Eo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695F3EDAC1;
	Mon,  9 Mar 2026 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084270; cv=none; b=WpUEsLOl5F8STdaPH8vtQmOGXBuRN7MxBk8cmc6DamXNZSYQJZ+XydfmOujHE6oLR42VXpGs81agb9NKTPXpvFGuSzCiNSuxWlhKliNTgSj8hy3J+CvDvbBUqk94i3TH7GoRo/udWFpp66fe1bU32+TS4HefAtweUameWaMrbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084270; c=relaxed/simple;
	bh=wQRuJnCf1bULDEahMxnM6u0R5pEwhxszCldFWiYsTqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMVuhJOCw+piQLxoeL/Gju5eG7DFRslNocPT9d+miGav4cBd8dog3e728/uVmvI0gwwdL9d9d4qlJAw74UjYxmafJm0wVgDIz/QsEZwtLJ+hyvALmWd3OOaRXCjwpHZtoHuu5/hX61f3OZNRG2tya02hnOMmwEztrpTkhsQnGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID2p+Eo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E2DC4CEF7;
	Mon,  9 Mar 2026 19:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084270;
	bh=wQRuJnCf1bULDEahMxnM6u0R5pEwhxszCldFWiYsTqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID2p+Eo+e08ZZOZC57sSvuvTBJtizCjXJ4fzzhYNy8Fwql+R/vEWBetzWP+yBvjV0
	 bLK2/950zqMciWaKwUevSKUWjRmAJhkHXFPFpfhe5C53tijfJKQq5UG8KBigncNWWK
	 fDqcZl3Hu3/Vnql36DdugEsKPOp0nN4XVPJhsp1SobyyUL3zvMzK11AVg885E3pm6b
	 N4ZTEDIOYwoiMXPSWgIz9dgknfvGp94fEhsiMwG9i1HA+xmBA+VibQilM0aZ24stK5
	 Y+5XTW0j/0k8PmphYpugwN4bxQMHgNEsAKkOv58236nwDji3EyWtll8dqgiM5nVrjK
	 vve0zIMh02X/A==
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
Subject: [PATCH v4 04/25] fsverity: introduce fsverity_folio_zero_hash()
Date: Mon,  9 Mar 2026 20:23:19 +0100
Message-ID: <20260309192355.176980-5-aalbersh@kernel.org>
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
X-Rspamd-Queue-Id: 7003224009E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79845-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Helper to pre-fill folio with hashes of empty blocks. This will be used
by iomap to synthesize blocks full of zero hashes on the fly.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/pagecache.c    | 22 ++++++++++++++++++++++
 include/linux/fsverity.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 1819314ecaa3..1d94bf73f38c 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -2,6 +2,7 @@
 /*
  * Copyright 2019 Google LLC
  */
+#include "fsverity_private.h"
 
 #include <linux/export.h>
 #include <linux/fsverity.h>
@@ -56,3 +57,24 @@ void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 		folio_put(folio);
 }
 EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
+
+/**
+ * fsverity_folio_zero_hash() - fill folio with hashes of zero data block
+ * @folio:	folio to fill
+ * @poff:	offset in the folio to start
+ * @plen:	length of the range to fill with hashes
+ * @vi:		fsverity info
+ */
+void fsverity_folio_zero_hash(struct folio *folio, size_t poff, size_t plen,
+			      struct fsverity_info *vi)
+{
+	size_t offset = poff;
+
+	WARN_ON_ONCE(!IS_ALIGNED(poff, vi->tree_params.digest_size));
+	WARN_ON_ONCE(!IS_ALIGNED(plen, vi->tree_params.digest_size));
+
+	for (; offset < (poff + plen); offset += vi->tree_params.digest_size)
+		memcpy_to_folio(folio, offset, vi->tree_params.zero_digest,
+				vi->tree_params.digest_size);
+}
+EXPORT_SYMBOL_GPL(fsverity_folio_zero_hash);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 8ba7806b225e..b490b2c8a393 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -321,5 +321,7 @@ void fsverity_cleanup_inode(struct inode *inode);
 struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index);
 void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 				   unsigned long nr_pages);
+void fsverity_folio_zero_hash(struct folio *folio, size_t poff, size_t plen,
+			      struct fsverity_info *vi);
 
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.51.2


