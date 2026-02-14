Return-Path: <linux-fsdevel+bounces-77225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAWgJBnckGm7dQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:33:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86E13D212
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11BBF300909A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828F2D780C;
	Sat, 14 Feb 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlSgUq2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734114F70;
	Sat, 14 Feb 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771101206; cv=none; b=szaTxtPv7jTyxGgaOyu2rM+PqR/33/9t60ClwthMPoF6NFjuCbTuet4APuQouY/iqD7e1tcY23w7Qg2xU/Qcrb5lO4k+lkggihHMSU91+juA+Vuqz5m7hpQAZelymt1EsBL2T7F6C+GDJjWVsFNt7Gn4PRXYJk0ahb+lqOKBShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771101206; c=relaxed/simple;
	bh=SqjZE7OWr1LYIbtS0mF/zGZQM1kfgP5bCqVDUaHH/3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDpmRVxqPfJDUWSSD2VzLEVHwJX+Tr53lMBzS5+ZordO55jqrLNPqWUUrDuTy6aq7NDCnyUIRxm5FArxXcHYCrp7GdjR42uOA+Km1FvBdb/YNoSnqaUxtf5B0ugbhG1GssLrF7OCIPPsUoa3ojMfFIcQ+fjJ2W0VBp9iE5ErrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlSgUq2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF3BC19422;
	Sat, 14 Feb 2026 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771101205;
	bh=SqjZE7OWr1LYIbtS0mF/zGZQM1kfgP5bCqVDUaHH/3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlSgUq2i0I1AM1xAu9ior2ocPVR26OI1VJE5y8JZ/f27QwP88DEaJjau1r/kJVlgs
	 VU/1zlwJ5GaFA+ga7V3Jf99TlRecUZ+5ePixRy14X4Qjt57e5TqRK0E2va7VdMc/+Q
	 92EMEDuGMj5W/GhDcneaugwXRhD+sEtmLQNouSEZKgQhkGu6nm+kP6zNETQESddgs/
	 4FwJn29/kd5Pv2QoK/siNWG/Gk9zelriYO1XpyuAG88WACX+xbecMEzeMHVY529SvQ
	 F/6RAnD/tj5sDbPvjr5GQ1/wgRSfETIxbCwElOf6S1+XMK//0WjzJCabt5Yt1roHxF
	 8sEzpoRk/JkHw==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 2/2] fsverity: remove fsverity_verify_page()
Date: Sat, 14 Feb 2026 12:33:11 -0800
Message-ID: <20260214203311.9759-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214203311.9759-1-ebiggers@kernel.org>
References: <20260214203311.9759-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77225-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email]
X-Rspamd-Queue-Id: 1D86E13D212
X-Rspamd-Action: no action

Now that fsverity_verify_page() has no callers, remove it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 31797f9b24d0..3e38749fbc82 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -431,12 +431,12 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  * verification, then bio->bi_status is set to an error status.
  *
  * This is a helper function for use by the ->readahead() method of filesystems
  * that issue bios to read data directly into the page cache.  Filesystems that
  * populate the page cache without issuing bios (e.g. non block-based
- * filesystems) must instead call fsverity_verify_page() directly on each page.
- * All filesystems must also call fsverity_verify_page() on holes.
+ * filesystems) must instead call fsverity_verify_blocks() directly.  All
+ * filesystems must also call fsverity_verify_blocks() on holes.
  */
 void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
 {
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index fed91023bea9..6de3ddf0b148 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -280,16 +280,10 @@ static inline bool fsverity_verify_folio(struct fsverity_info *vi,
 					 struct folio *folio)
 {
 	return fsverity_verify_blocks(vi, folio, folio_size(folio), 0);
 }
 
-static inline bool fsverity_verify_page(struct fsverity_info *vi,
-					struct page *page)
-{
-	return fsverity_verify_blocks(vi, page_folio(page), PAGE_SIZE, 0);
-}
-
 /**
  * fsverity_file_open() - prepare to open a verity file
  * @inode: the inode being opened
  * @filp: the struct file being set up
  *
-- 
2.53.0


