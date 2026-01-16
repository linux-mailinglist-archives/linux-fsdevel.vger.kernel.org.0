Return-Path: <linux-fsdevel+bounces-74239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27823D3866E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 858B9300B364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12034CFA8;
	Fri, 16 Jan 2026 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUGZMm83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26543054D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593878; cv=none; b=ghlxh/0ziFo9KywAl9zrwImnCp625Ud0lnRuUXLAn6/sFE3eirWdQ595vXx4co9LfXjOwnWStoZvKs4pKLq6ZF+usJ+S5lv15mwxJ9NphmBKMyq9/NEQwEnXnuqIR6H1TQgl9R1vtGDLea+r4Msu8SSd9xhfyxu9yKuSwpB17rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593878; c=relaxed/simple;
	bh=lRABjBJY1G+fjxVUbvsBJI+kd1sGNVdWUaUBcVczCZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdJOibJiOLwFl+AFDfAqeMcYI7xVeUKLLh/td/hOeVTJ+/8U3tFMwD2Et8/tvw+zM7i9IhSfWUWT8SPpADNorqJFO0q8ynfBJK44U9WatFNhvV+Z+1Vu+MDM6Fz/L7lCGMOjyhRoPjnGEH3PcReHz8ivilvExaGGJNuse6561Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUGZMm83; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0d52768ccso16062775ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768593877; x=1769198677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNG6VYuIITMmDUHrrpy2Jk3InAnzXRaooxMISG5vDc0=;
        b=LUGZMm83s3ElaG7TDqJ9tzvdsvzUUrwAehkKl08f1z9u3P/JHSlTqdrB8hAwjKSGPC
         1CQhBndfQgBJM5W1ujNBmVXATjGkAC+XhOGN0og2+knJiRXvYmORjFm1056XbW4DfdMB
         Ga/b081V9WSckQn7gTKFFIfIA01SyJzcRRKA8rDp1DjcPD8CtCVq0APvLQZ3O9Q5PBhn
         HEzaNixPpW76NqnJAOO+T29ZJRCLF6FypdwpVVFW3Uo2nt6e6U5zl9hbwkW5rxsM8hlX
         1ZKduYSdOrYWU3PnIOhNzFB0PXl5Gx04kTSKDgdCTEEaTawJ++4j2noIv8jQre/mwSEU
         1mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768593877; x=1769198677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNG6VYuIITMmDUHrrpy2Jk3InAnzXRaooxMISG5vDc0=;
        b=E+B92Gxid+GswfpQlHFRlmYGt/02AdVpVbPmQnyt3nuJrgOrgby7TvSHS4pjdvyogO
         c5uHvhG4ylrpIEvf1LhdqfZPgNWd5Oc4QEdl2yrrwl1+XOQZn3yuTwRtNz66haWtmXV/
         RQEOZaDtaTjIslTKbeTlD1fqzJTXzkU0L2Y4qqSv+hFoSI5S+eqF5AuPHXekWwBcst8x
         xjmOc+ms6ZM/KBzOLGd2TXOq3IJAQiFZ1SsdaEDKy/ELmLgj66YLVcbo0g1LOth9p+UE
         I1b6eAghTS80xNaOkxjE7CSXqJFIJEgFRFW+0ORzmBXwUh8iWPheuhlLjewfNRCTrmTa
         ZA5g==
X-Forwarded-Encrypted: i=1; AJvYcCWeHiJ5PVcgYeQJ25wPT4r6RX6PT5Tjyis8TG/Qo8zrtO5+Yl7b62YksZa/hZ4SnIbLQAI6QnfOZt6Wi4US@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BrbZ4Xct9ouPEEyKDZDTJqspGtTyJS2kqYtYpogf6IQfe5y3
	k90QhLVLQ/ihPuab0XDIpUwVr+eacfjn3yrzOONw1SI44CAp80qjkQvH7DxSvQ==
X-Gm-Gg: AY/fxX4dIiYXb0DVLzGGGeKEipedPjsfNcrUjMBOc/85tXxX40/BcZAHSCX69bgE+dH
	NRoNJq9qG6YRoFCMOrlQbypCK1lJCKTgrBltWGfRFHP2Euyjvv9yvotqfIv6CmSOjL+B2USeO1+
	KChNCvqNObXsM0+sK0IU3bPC5RX/BtTtHBAHk+MhMaAWDTmfbFRCFs/zwbDIBRvT1x62B525oEj
	Wylo3mcNiDEckuaWiuWFnpzd2cBfy2BEnHIcUUTzh4vTGJ3JfHHk80Akiy0xwhijgunommciaKg
	eWUW48Kh8SmPnV6IkV8mmknLWNQYztRfAgARckOwyKcm606Oe/nwBWdndTytrz7ZMuvXM4doWmU
	+bmc1zHcDTEmBA3X2yIIMbLUHlMJXc6ijfDz0hNTKBNc2xJnkLgjuJ9I6GknR1uGV9njRbAFtq0
	ZUeNkLVA==
X-Received: by 2002:a17:903:1ae6:b0:2a2:f0cd:4351 with SMTP id d9443c01a7336-2a7175c3241mr39546935ad.37.1768593876980;
        Fri, 16 Jan 2026 12:04:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ca058sm24267775ad.33.2026.01.16.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:04:36 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/1] iomap: fix readahead folio access after folio_end_read()
Date: Fri, 16 Jan 2026 12:04:27 -0800
Message-ID: <20260116200427.1016177-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116200427.1016177-1-joannelkoong@gmail.com>
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the folio does not have an iomap_folio_state struct attached to it
and the folio gets read in by the filesystem's IO helper,
folio_end_read() may have already been called on the folio.

Fix this by invalidating ctx->cur_folio when a folio without
iomap_folio_state metadata attached to it has been handed to the
filesystem's IO helper.

Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6beb876658c0..8b7fb33d7212 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -502,6 +502,8 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
 	struct folio *folio = ctx->cur_folio;
+	size_t folio_len = folio_size(folio);
+	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	loff_t pos_diff;
 	int ret;
@@ -513,10 +515,10 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		return iomap_iter_advance(iter, length);
 	}
 
-	ifs_alloc(iter->inode, folio, iter->flags);
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
 
 	length = min_t(loff_t, length,
-			folio_size(folio) - offset_in_folio(folio, pos));
+			folio_len - offset_in_folio(folio, pos));
 	while (length) {
 		iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff,
 				&plen);
@@ -542,7 +544,24 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 			ret = ctx->ops->read_folio_range(iter, ctx, plen);
 			if (ret)
 				return ret;
+
 			*bytes_submitted += plen;
+			/*
+			 * If the folio does not have ifs metadata attached,
+			 * then after ->read_folio_range(), the folio might have
+			 * gotten freed (eg iomap_finish_folio_read() ->
+			 * folio_end_read() followed by page cache eviction,
+			 * which for readahead folios drops the last refcount).
+			 * Invalidate ctx->cur_folio here.
+			 *
+			 * For folios without ifs metadata attached, the read
+			 * should be on the entire folio.
+			 */
+			if (!ifs) {
+				ctx->cur_folio = NULL;
+				if (unlikely(plen != folio_len))
+					return -EIO;
+			}
 		}
 
 		ret = iomap_iter_advance(iter, plen);
-- 
2.47.3


