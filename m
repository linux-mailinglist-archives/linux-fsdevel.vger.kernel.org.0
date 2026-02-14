Return-Path: <linux-fsdevel+bounces-77224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEr7AhnckGm7dQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:33:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C049413D20C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439C53012CAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A159475;
	Sat, 14 Feb 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlREuZd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83828CF5F;
	Sat, 14 Feb 2026 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771101204; cv=none; b=ekEPxBh6KJ1t7wEmOpwF+itpaePYYAMUocQ3e+D/1KA7AgjYqlTRKinVpOLwYUr+iOIQ32/24E7qxrBOUKdyxCzmH4L5V/S1htnZBlEHBW7pTIya1JXb64EZLtVYrT/xZl98nZWtuLcJP4lrTRO4O9OlJbOUKtWYMAuPhqllib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771101204; c=relaxed/simple;
	bh=0PXEdYAt/sVuxM6vBLkl5PSVhtNsF+qniTEX01KwCCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPK7uxCrvO6jNW7Rfr45jBCuYj6fUjdoH9QksZPUWqaPKJDV49EDb7ZBP9MgRPSTG7D8rct1YxL9fKRTCXKRFHwq4IcWCIwvXIwesADhPaZ2wuztVc0+lUqnBhDIA6d+riOB0dG0Ouh20dQim78pvXSpxdQFUf0Cn8Umo3n3F88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlREuZd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD94BC4AF09;
	Sat, 14 Feb 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771101204;
	bh=0PXEdYAt/sVuxM6vBLkl5PSVhtNsF+qniTEX01KwCCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlREuZd6iwFT/KKhXENR0eEBVhJ7tKBSqpwsfcNfOsYbXnCQXVUMNj59nm8uKwkyH
	 O+6dzBuWc1jIfxrYvC6s05up+FDsiCA0+exggAOs2pNdrVYCg5N184zYdAtezgaTYi
	 XKiGDzg4C4nRrfKIzi8YklvO8jIB9uw1xB3znKia0q74rmZwBA7WaO2vZ1UwzWlVJT
	 KC26l3EWHa6Wp2h90QBM51E+uV7HabceuGfHUZ2MvCGPuTWOywcrOoUoxwOBaiqsP2
	 iAfT5L24BEQiB+FaD3XdYMMrgBFq6erW7oKiNA3euc1NaQtMOj1JZz6jr4PIT0j19f
	 NUjzxzsXI7HGA==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/2] f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
Date: Sat, 14 Feb 2026 12:33:10 -0800
Message-ID: <20260214203311.9759-2-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77224-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C049413D20C
X-Rspamd-Action: no action

Replace the only remaining caller of fsverity_verify_page() with the
equivalent direct call to fsverity_verify_blocks().  No functional
change.  This will allow fsverity_verify_page() to be removed.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 006a80acd1de..6d688835387d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1815,11 +1815,12 @@ static void f2fs_verify_cluster(struct work_struct *work)
 		struct page *rpage = dic->rpages[i];
 
 		if (!rpage)
 			continue;
 
-		if (fsverity_verify_page(dic->vi, rpage))
+		if (fsverity_verify_blocks(dic->vi, page_folio(rpage),
+					   PAGE_SIZE, 0))
 			SetPageUptodate(rpage);
 		else
 			ClearPageUptodate(rpage);
 		unlock_page(rpage);
 	}
-- 
2.53.0


