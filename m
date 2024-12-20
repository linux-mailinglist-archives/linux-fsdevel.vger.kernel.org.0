Return-Path: <linux-fsdevel+bounces-37961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC559F95CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6111A7A01B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138C221D01D;
	Fri, 20 Dec 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FPp6vWfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC321CA06
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709729; cv=none; b=CrNjSgqf83YlUU+Z8J8JwLAlwahe+V9CiwkNMoV0jGClG5xHM0r6uWR+O1edRL+hIgVZuoNlSdlNm5yv6rCG17rPz+ajWhJ6s17ih5UJ/rw5+0kzZrVTde8Z2i57DzcyRhiwR+RThR5/a72WMcXnYrskb5xyzEfALtD5tT4xtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709729; c=relaxed/simple;
	bh=0z+Su/j7sFm3LNscSJlbortbXvVAgYiyFzcEVovFWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3Y7Xgd+0em+PwmXAPZlouYtUli0jnHcVpRWfxTXn/Af6HaDlOBy/mi0YBW0WZOkmNZ7zHToNe3iuqAXRIbK09MSCrWW8lWsoIpcn8lnipUHFwFT0D9uDMOYtmG3WcZ/R+5H5quM+AXd448xhYpn4dnfEL3LUsSjh0qPN2QqXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FPp6vWfm; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a78b39034dso6240995ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709727; x=1735314527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWUKIERhmBif0xELkyRs9dlqXC97dRJQR9fjviiscOo=;
        b=FPp6vWfmmwe9NAWIBJmCxLtVD/hNP3BfSRpL38o0SUhrItLpx26f4Yg2aryhVcVvoM
         oPpp3NOtj7OKWZxGCnfwcG9g9XNK06KVogtbQHCDg8aY2+KQWK+Gml3annJycylGeLWM
         VQ1kjdOYDuMMIT7W2aVyIxb1yTomtke8VSfksgOXvvkFxe9p1Wv/YGuGwkhvJgu9kDY3
         kxOwEwqwnebKAvLbCMZrqSUwIskcxGhWX71jrH+qY6XTE8r7WH7lFQhuo7xqJStur45R
         FdMuoeSXbu+PxhnUHTXiYz73dqknNbkjP1X3wZUw36JxSQNonJKRdhryqdAgT7BlbPd4
         hl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709727; x=1735314527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWUKIERhmBif0xELkyRs9dlqXC97dRJQR9fjviiscOo=;
        b=bGfdQ/n283u5KUME6WoG56xtvFVl3yQu0FKYIt6cFL0Y77jLqiSoGWHsj2yL8lcFVC
         O72x5Rcng6VieSMMI5tRqHnmpy/sd9lg2FHYoSMG9+5PHcoPvz447fHwi+rd/+68Z5f7
         64NmBYHNTFPbhVyu16kXyTfKO8ihoM2eqWv7OwSfUv6R9uhKr4xcZ+n8wdLm682f4KLi
         vQ4P6cJKzO8v11WVER2Ms/gvWFyXfWzjZglPBI2wZQKWvj0VFPpe7cPXq/NEaPN9WmW2
         WpJVdn+Ex2Blo2XoNOUZQAFW/8qY2dmC9iPp3zK8nxA81tMVH7S3V09d4+M7/+OuQ5kh
         lbNA==
X-Forwarded-Encrypted: i=1; AJvYcCXH7G46iPqo2hYYE3Ujj1qTXSDnwn4gw2Bfj+4ZqrVO9smLZZYNj+jttI37PB7yEN+Vl2oZ3EaXqhv4zwOd@vger.kernel.org
X-Gm-Message-State: AOJu0YywsDp08351DOXyKpfd+OVkpB+7h2BbCFOxps1bC7yG4sxbvFp8
	vdH5M6k+e9aiAoeX5AEMD1ciKLY+R/VLwP4fxPs9D9TlMViWpxnDKsvI7WPntH/HciKF3zrAnEq
	S
X-Gm-Gg: ASbGnctoJLm8kPkeo7Td90NNg28L5s9NA+jPJvNDKk2n6OBXc4Lf9G6FG7MJTq3JWEs
	/FyFDWxdn8XlJMxR9MNNP+2R5nsfnybehS9qKnEL8hlq9yuTveY9jrs5EeW/nMFhZZKYzhE64jj
	W+oi2b5zop/QEfKu5sRjLD7r/2IOBGaaAAVUUDvSy25KLPGiWZVOWh38OxeRF3nrf6bmHOK9oU6
	3Aqt3YGjhWHueauy5p1sdhGkFxKOx3REgM5DTXQPEojLJVJkKRvEpunaglu
X-Google-Smtp-Source: AGHT+IGjD+wBfW2QpC5lojTx62UJZa1o0QwQiIlqK6Hx/4wukTE9KhfBEOmSehD69MzvwKGp6r7FTw==
X-Received: by 2002:a05:6e02:522:b0:3a7:e0a5:aa98 with SMTP id e9e14a558f8ab-3c2d2d509b6mr25164805ab.13.1734709727201;
        Fri, 20 Dec 2024 07:48:47 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] mm/filemap: drop streaming/uncached pages when writeback completes
Date: Fri, 20 Dec 2024 08:47:47 -0700
Message-ID: <20241220154831.1086649-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio is marked as streaming, drop pages when writeback completes.
Intended to be used with RWF_DONTCACHE, to avoid needing sync writes for
uncached IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index dd563208d09d..aa0b3af6533d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1599,6 +1599,27 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * If folio was marked as dropbehind, then pages should be dropped when writeback
+ * completes. Do that now. If we fail, it's likely because of a big folio -
+ * just reset dropbehind for that case and latter completions should invalidate.
+ */
+static void folio_end_dropbehind_write(struct folio *folio)
+{
+	/*
+	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
+	 * but can happen if normal writeback just happens to find dirty folios
+	 * that were created as part of uncached writeback, and that writeback
+	 * would otherwise not need non-IRQ handling. Just skip the
+	 * invalidation in that case.
+	 */
+	if (in_task() && folio_trylock(folio)) {
+		if (folio->mapping)
+			folio_unmap_invalidate(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * folio_end_writeback - End writeback against a folio.
  * @folio: The folio.
@@ -1609,6 +1630,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  */
 void folio_end_writeback(struct folio *folio)
 {
+	bool folio_dropbehind = false;
+
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
 	/*
@@ -1630,9 +1653,14 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
+	if (!folio_test_dirty(folio))
+		folio_dropbehind = folio_test_clear_dropbehind(folio);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 	acct_reclaim_writeback(folio);
+
+	if (folio_dropbehind)
+		folio_end_dropbehind_write(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.45.2


