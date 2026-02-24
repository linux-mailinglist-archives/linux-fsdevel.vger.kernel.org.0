Return-Path: <linux-fsdevel+bounces-78297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAMUGbb3nWlzSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:10:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B518BB37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B2A30D63B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A72ED866;
	Tue, 24 Feb 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7q1KkJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCF2EB10;
	Tue, 24 Feb 2026 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960004; cv=none; b=iWM2OQjtEBM5hJnCmkxQKZljoZegyApzd8rIRLAVLv2mJvrXIQp266gSUw4/1xC21AgmSgTQ63VVJAxHzZ96MfaPLxTTOVWROunqNxGgh20K5eUxR8PcIv6IGZDkMfSaakt3YYfxGcjm0iHccHQ2jrIwRfNorBfSidWKfHsk18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960004; c=relaxed/simple;
	bh=jPL0Oz8WvtKYQ8MUmItOvJNN4AFs6kAsTxdIYPhQS84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6o7H6ARwqD8Ohlu2HZiu+kgW2QmTVCrimaUcAdm5t6ig3mP0BHq3hJJLKCv/LrCd3Jg0TuIWN3cmkwksTNgnjlRXKCU527sm0SScj4eXjtXruugwZ9zbs9cq2NI31/FQ6bAjSOsvnSeEcZzbryHEH1S+NRAv1S5fxfhbzPiJyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7q1KkJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F17C116D0;
	Tue, 24 Feb 2026 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771960003;
	bh=jPL0Oz8WvtKYQ8MUmItOvJNN4AFs6kAsTxdIYPhQS84=;
	h=From:To:Cc:Subject:Date:From;
	b=i7q1KkJBwfpN7QYUbtFx8UbpOMs1aW19E9XKCmAAYmwUC0Ch1LpY7T42X/BMDma59
	 6YCwdkernIuLTdNqvXBzGl9xMHlhobNf28zAxe3+wVypmqt34wTwrwHZkEzpTqKxYv
	 hySwOGkXOQxQzGFEzV07r7Y5Ln0pnoZ6qg6EPpgHr4lwOcKu97RGnFRbUMnCTYEDAu
	 wWfOm0fQgNqnYfNyAThO+bqTLwAG/06p7KnwFi6e/nqjmpao2TXWPBmUbxI6DgbdDS
	 xhSqft/L0UZJfT0WOcQbKMtrZqkXK1Bb6Nkpd849Ij8NJim+pqSrottydpyoP+bMFA
	 3U/V7G9zHwJwA==
From: Sasha Levin <sashal@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	axboe@kernel.dk,
	changfengnan@bytedance.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] buffer: fix kmemleak false positive in submit_bh_wbc
Date: Tue, 24 Feb 2026 14:06:37 -0500
Message-ID: <20260224190637.3279019-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78297-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE2B518BB37
X-Rspamd-Action: no action

Bios allocated in submit_bh_wbc are properly freed via their end_io
handler. Since commit 48f22f80938d, bio_put() caches them in a per-CPU
bio cache for reuse rather than freeing them back to the mempool.
While cached bios are reachable by kmemleak via the per-CPU cache
pointers, once recycled for new I/O they are only referenced by block
layer internals that kmemleak does not scan, causing false positive
leak reports.

Mark the bio allocation with kmemleak_not_leak() to suppress the false
positive.

Fixes: 48f22f80938d ("block: enable per-cpu bio cache by default")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 22b43642ba574..c298df6c7f8c6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 #include <linux/fscrypt.h>
+#include <linux/kmemleak.h>
 #include <linux/fsverity.h>
 #include <linux/sched/isolation.h>
 
@@ -2799,6 +2800,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 		opf |= REQ_PRIO;
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
+	kmemleak_not_leak(bio);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
-- 
2.51.0


