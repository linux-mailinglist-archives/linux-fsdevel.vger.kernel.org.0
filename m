Return-Path: <linux-fsdevel+bounces-51623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A77FAD97AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F341BC22ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C128D8D1;
	Fri, 13 Jun 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsDW0q0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1430266562;
	Fri, 13 Jun 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851447; cv=none; b=YRz0uEY4tDYxUBIH56+zWbdgyZV5nhNZnc/4+BvvXPXkvAG0CFkSdINO+6N3cSpMBejsZM56ZzxhfEznjBXpmYDkTj9tfcXOdT8MhiYLakWmcQEObAHxrPI5Rpi058L4wRH/4TOScUBJnJX0OnSc4xiViVjj80+KurOyWBAbISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851447; c=relaxed/simple;
	bh=oieHOybJHj50pifek8tOjKiU6JSliykhDivemldi+II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uk+JSlxAEUr99PGCLBBDjaqk0eTul7fb5lWnW9+SUYQYkf5E91Pvsm6OAfs9NdpO3nH+UARgfnPL39GSIL6NFImX9iwzx6Rb4SEtMG73EHhCGil7juFc0p22NvYkJdtz5hs0/sTHZnE2ntsns5pShkSBiOBujd4madZThHW1EMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsDW0q0x; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2246698b3a.3;
        Fri, 13 Jun 2025 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851445; x=1750456245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj4keZIiwsAa0nHAlQ5l2+dTLB7//f0i2W+smHgSLEU=;
        b=UsDW0q0x7cR+3y079f/djYmDyrVyaxq9jDXYHLCtMxro7yWxmDYjVmn2fv7m4OvOsb
         tPaoRPKSszR51DLlx2H39d3R1QhW8rm9Vs16GQRmU4XqrR/r0v0QQrnyt/YdoKrj7d8X
         v2WN315fpXwcDkfq2j2vtXSWlp5iHIHJLNAJmIVBYI3dZrYRzuH3/0sp+Dn/7Ad2rbPv
         LuV3QkBIydE+XNqEXzXXGRFL0bMb8lXDAqHq9nqcjDu8cI7nDXmojXhUSSm10nlPEq+8
         x7QAZSGn7HmLRE92OFb+3GVbWMgvAobZexjkssE26uLN7pxTw5YoYaKlzuahYBEbTGaz
         tf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851445; x=1750456245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj4keZIiwsAa0nHAlQ5l2+dTLB7//f0i2W+smHgSLEU=;
        b=bExSgqOGFf6fu74UKidTQ6HY+dR3lPslhXfqE63MHy4mSyzcVp43nFw1IGc6NsZDSx
         H0NmT83WpHzwr/96a+RoiW+xlFB6365xQI5/DPgzOogHTUuT0jEMP5X4ixaamHXD9lNb
         tCKx6IpapWUhM0Rb3jsIvDsjeyVxmYwNUVv2l5s+E34eaK4jvIRCr8zHfEi2frDGXZvN
         ri7OolQlKofYUYVO1jwBf4w5SsDbX6lRj6HPt3dNc1fMvJfZeaCUzeE6qhjMTtIE5n8z
         ikx8qSac0x9xMo0ILVYrlRXY5NyJFEfyL9QaDM4VKNGmez8amX5wrahsLUFSK3C1OVb2
         MyWg==
X-Forwarded-Encrypted: i=1; AJvYcCVXW6f+OsfXUIvTZ0wdenS2D5A9YwlKF/UfqyFuIbCjnmJD9VCFi2dOzF8MlDWM1BXlEuH2cSbm8TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYRTa4yQX4RTgaxkvfq1bu03gxqFrpUQ64NSR5xlmgLrBqWVU
	Qn4nLtqMwiLnix6rNW4Cz9DD0SMqD+Pgc2SdqsClDeAKMNByFXqQ34BDQKWtXg==
X-Gm-Gg: ASbGnctojN/4YJxpZYgd6nVC+Q+5jttmqRqcKuXf9tI2nWjhBDq9cwbOPk+6RXVr1r5
	CD7wLrzTXK039ztS1LNTiE5vMFVb2Y5qxbJIiI8F3dCuu7wQLcG40dQ0Ea4+DXxZs9lZUvGHIud
	4u69qwbzKnbonhssN3UVCR//737o5d5XUw1SZubDTTom1dq96S5qhQmvP/GJVQCZ2ZDibhRU539
	ORAg1FBNwJ/wQEsRT3BqNKQlu9m4ZHXsV++1j3MYFJmoNv8Aw6JpRPBW5CT0p5PyrX8yiUA/4ZL
	/bWeONJP1zCmOjwzVao6ins8XmqFI3MDenI4Yt7zkE/jJk7duxOUw3CwXVG/lqo8Wo8=
X-Google-Smtp-Source: AGHT+IFLWWkLFWxhxIVkL2ZjWLDpn7kpNCcSsooYeuOeWefqcQCjusIVeiVxlxEauOTsbLavhlTmqw==
X-Received: by 2002:a05:6a00:2183:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-7489ce3cf0fmr1066323b3a.6.1749851444881;
        Fri, 13 Jun 2025 14:50:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d1d28sm2122509b3a.158.2025.06.13.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:44 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 03/16] iomap: iomap_add_to_ioend() -> iomap_bio_add_to_ioend()
Date: Fri, 13 Jun 2025 14:46:28 -0700
Message-ID: <20250613214642.2903225-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250613214642.2903225-1-joannelkoong@gmail.com>
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename from iomap_add_to_ioend() to iomap_bio_add_to_ioend() to indicate
the dependency on the block io layer and add a CONFIG_BLOCK check to
have iomap_bio_add_to_ioend() return -ENOSYS if the caller calls this in
environments where CONFIG_BLOCK is not set.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 2 +-
 fs/iomap/buffered-io.c     | 4 ++--
 fs/iomap/internal.h        | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index c1132ff4a502..798cb59dbbf4 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -126,7 +126,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
  * At the end of a writeback pass, there will be a cached ioend remaining on the
  * writepage context that the caller will need to submit.
  */
-int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
+int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct folio *folio,
 		struct inode *inode, loff_t pos, loff_t end_pos,
 		unsigned len)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 227cbd9a3e9e..b7b7222a1700 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1571,8 +1571,8 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		case IOMAP_HOLE:
 			break;
 		default:
-			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
-					end_pos, map_len);
+			error = iomap_bio_add_to_ioend(wpc, wbc, folio, inode,
+					pos, end_pos, map_len);
 			if (!error)
 				(*count)++;
 			break;
diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
index 9efdbf82795e..7fa3114c5d16 100644
--- a/fs/iomap/internal.h
+++ b/fs/iomap/internal.h
@@ -26,15 +26,16 @@ u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
 bool ifs_set_range_uptodate(struct folio *folio, struct iomap_folio_state *ifs,
 		size_t off, size_t len);
 int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error);
-int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio,
-		struct inode *inode, loff_t pos, loff_t end_pos, unsigned len);
 
 #ifdef CONFIG_BLOCK
 int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 		size_t poff, size_t plen, const struct iomap *iomap);
+int iomap_bio_add_to_ioend(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio,
+		struct inode *inode, loff_t pos, loff_t end_pos, unsigned len);
 #else
 #define iomap_bio_read_folio_sync(...)		(-ENOSYS)
+#define iomap_bio_add_to_ioend(...)		(-ENOSYS)
 #endif /* CONFIG_BLOCK */
 
 #endif /* _IOMAP_INTERNAL_H */
-- 
2.47.1


