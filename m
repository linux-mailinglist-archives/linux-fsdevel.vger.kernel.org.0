Return-Path: <linux-fsdevel+bounces-74033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08373D29C85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8BC93031960
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC533554E;
	Fri, 16 Jan 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd7heYTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBC221F0C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768528534; cv=none; b=VrhEI+ST2GnZZB4uxMXKO7V0XKnBg3P9cWQ1Or2UpmArMxZC9rjNCM5SPQHHoWuAJ16ObpbZxtSdzgqBTCc+WbCCM9Lk8Zjdp0LDj2xVZJeKxn055ee5VI4hApsFn8bb51kK7V+6NtW4dX0xVidZLPlDc9+nc+Rr/NPV3TZeOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768528534; c=relaxed/simple;
	bh=ES3uFCyOjHvkS4MHqisI+gDozLFi02vaFfQm668b9dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8pYJatolaQ0p+yjS2+WjiVX4cskZfaxge1EFUEk7tidkSpvOEjGLnMxyokDNhmcutPeoNxXqQ4mMf/CgMSU7l3Pc543MAasJafbRyjN2yOs8jucUiaOiNRxD9JjHJtEvOFj0LQ1FKwn0XDSg4HMBDo/X08nJotZ9BAMIAWqX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd7heYTj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81dab89f286so722136b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768528530; x=1769133330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsKr6TWqJREUkLJqMcZZZuaMzeqMrvoPeY+bJw2oUXU=;
        b=cd7heYTjTZqSXBd/8ifOn3yqmTSq9p8qRsQsmSMPZovOASVRRGjIZ6b9g7wz9iEwbe
         +E43uZxJlFeIotidFYhP46LuE5LKlEqJ2qe/S6Qqf38cs1qUQhAItkwq2pT6UDzLZPRo
         czLFPbEZKIvXCYA4t85V+9rj8jHHlqG1g5QPs7kZuOkErQrw8GeoFFVkceuukWdcg3Mh
         1Kooh8339Np18zfhwmo52GDwMDn3woSgosufY3dklFPRgJha8Dr2iQnxzbRC13zu3o+d
         6xhWq07UyTJMnH3FhgLuuvnhM7NibrH89LwgdvQt2CSdUCGq85iQDQQHdldsvO9uMyql
         +Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768528530; x=1769133330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsKr6TWqJREUkLJqMcZZZuaMzeqMrvoPeY+bJw2oUXU=;
        b=nivo99Iz7qUtVDg5/0OVwCw7IgpvowYkSfUdtA1t/FGOeFeqTOhHLxHXsZVd2ZUohM
         m4skyN6e3JD8Qf/CXexcWI5oIt1IDEmeNHsaCYdURdOnTEp+C3rcqURQ4He2HWazCp/z
         fd/HxQ3XO7fwPkpTuPa2rRFl/1bHa8bl93N+7eKw5y4jF+zKlsGTcZCZJ/XPPoHeoc5e
         vJtYKnanAqzwYXmXU3dVXVUFj7XVQsUA0T5qHvi9k666FqQ9E3NTGGJyOudd1OBRm2Vv
         BP+99RfUhmgxrs+zo5gYy7Ukz4LUD+ViVK3bfaHIXSG1luBpDnGEmpOMNvirHj6n+5Q+
         RgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tEByC5WO8Oc/nQYKjMD/JkVbqWkHBAnXTDlGV+SSlLeSKTRGK4+ACfDNeZYvvvwRP2/P5TLlAF9Efa4h@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbT55YhP/knMxKu265ukInsObeHsIC0te7ts204w9C8sWLyC7
	rNrnc6ImZ8oCNgTCVtk1N463tVSiPWtVCfB7Ts1137dCZx7qj4b+3wkm
X-Gm-Gg: AY/fxX5XQfAB2HrYSPWPkyw8FWZwsBju7lYr/v5xQW7Td/fnfcXA9vkCc+P0NoNlpQx
	FzPHK63MyxMIhwE732HYvwv6A50bUp9d/JlZyD/FQkopTyDxSjCqZCKtijHVJqbujs4i/KexSyA
	xYSOFZfugTIBf9kx0POZW/wn4XAOcCmCfb7iKywQ9hySPoSxdu7M9f5AXTETco3AeGLKh2cQi27
	hwvezT3Kx43IsyVUyuokurFpzYQYE5Q2CfweZexuUb1fmoh13hmWUMwBcsFjQ3wW124iphq64vS
	0XeWNm37YjmMtC1uPK1B4Ed6I3ZfQTyMwl1XF2/FJIl6KLrrb38rrx9u8WXnEKnrK6+ckjZEKg8
	p5IFoYF6Gr9ef0WIkPR+3zK+t+Gd4XtRy10HMeF36rrpfx0mfvdIvmjD2owUBrMXlZOhlfVkeYO
	/JShIRtQ==
X-Received: by 2002:a05:6a00:6c9b:b0:7e8:4587:e8b5 with SMTP id d2e1a72fcca58-81fa01ebc00mr1219817b3a.40.1768528530443;
        Thu, 15 Jan 2026 17:55:30 -0800 (PST)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdafdsm566098b3a.15.2026.01.15.17.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:55:30 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
Date: Thu, 15 Jan 2026 17:54:52 -0800
Message-ID: <20260116015452.757719-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116015452.757719-1-joannelkoong@gmail.com>
References: <20260116015452.757719-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

readahead_folio() returns the next folio from the readahead control
(rac) but it also drops the refcount on the folio that had been held by
the rac. As such, there is only one refcount remaining on the folio
(which is held by the page cache) after this returns.

This is problematic because this opens a race where if the folio does
not have an iomap_folio_state struct attached to it and the folio gets
read in by the filesystem's IO helper, folio_end_read() may have already
been called on the folio (which will unlock the folio) which allows the
page cache to evict the folio (dropping the refcount and leading to the
folio being freed), which leads to use-after-free issues when
subsequent logic in iomap_readahead_iter() or iomap_read_end() accesses
that folio.

Fix this by invalidating ctx->cur_folio when a folio without
iomap_folio_state metadata attached to it has been handed to the
filesystem's IO helper.

Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6beb876658c0..2243399d70b5 100644
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
+				    return -EIO;
+			}
 		}
 
 		ret = iomap_iter_advance(iter, plen);
-- 
2.47.3


