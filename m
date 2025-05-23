Return-Path: <linux-fsdevel+bounces-49793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1196DAC297B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2299D7BBF66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89E299A80;
	Fri, 23 May 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M57ifcYr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D229AAE7
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024300; cv=none; b=SLFmNDqGSn+GC9+EnCGEBrXoCHhNbOVDfncaW9Kmb4GTE/ArYkgajcGgTx58CVLS5c0AsIjCwCoB2VNQLtme59nIbLmXFrfEeYqZ8EEoviuT6dKvyo3GCFU2/lwDx5/XCoSepbRkwDmbPLY73pvQYjIu/y9nrVGJ/FKes2Y9uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024300; c=relaxed/simple;
	bh=uMFNxE58aMTfoS7YYxWG6gwR8jeZp4+tFEL+34TRwTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhe+bKJ0xwPgzC3P6es8H4Ww09p2SIv6WJ0ObtgpoqWa/LUxUvahdV6JFsJYMtoPYWIRlVaai9Ekkg8fcdqhC6G6Bk+46AIPl9+tgPbtM3TEIOMhjGZ09L32960tIR4N60Rzv6nMMgsoiyNfcANfz4smEjCqZeRQlu+nyECZTKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M57ifcYr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c7a52e97so263133b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748024298; x=1748629098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGb5ymhqcYl6hkBAYbpEEg6tyARgZrgPhBpmAohUXg0=;
        b=M57ifcYrLC6cewpv7BfwhN+FXwjtP+GotSbS1F6N/PevAq773R4XanjuAKrAdDjpms
         tYvIYQYSmsTYlOrnTzwSFEa2+/gf0xwbyjQAU8nDfbDERvsYmrg/x1F0bHNCe/trP46k
         b4kT6YhgVB9LSBnIL8pLzPiqhf6Z7MqtOc7VHThsnqZz7+gJAYdITRYCOa7XTLQ2KcF+
         h0eYDnMNhaJWqU4eTOiMDQENVKP/I1R42s8NYqQLZs6o2RaZgubCNaKNI4P9D5oriOBm
         cfEI9EDJHm5OFfl0H2vEhrYs42lmbr8Yi3pj0Zvntg6gku08xkDNMex43s2NQarxqMG8
         g/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024298; x=1748629098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGb5ymhqcYl6hkBAYbpEEg6tyARgZrgPhBpmAohUXg0=;
        b=BMJdqR/n8fMsMci3bLXTNrjeoSyOhGgD0XQywHhccs0/c+vVVUQcgQ5tZgAG+XuVzr
         sbhaVfHY6OMjjun6pDhQYDflowc78SuyAIe0oHxHqczGL1xrq+S/JienkIOYnfIFi6YK
         LxvFbVRFR6RB7vfhPWete7hRtcUrh9zVqcJymuh/48lkI6y56iX4KrGa8HUT+R3XaDcO
         tB3onY+YqJ6pc/t15ZjP1ORgJ8/DZQlZpQy2vRLekjtxa5vtiiYClGpn8idX1m66ZA5Q
         /J1M0iVktittqe1Vi/Lo6tTd3sNJqHflJENJrziH4BUgk9YwzIggEbEp4n5QbGnXhlaz
         sWMg==
X-Gm-Message-State: AOJu0YxaxXaS+O0O3FxNpJlhCF18vGd78o6rnzBYXxSswCPHVu2/Syj0
	c0bXZzXNj9LW9KKfUkWiLcly5zCGI0X0R5gGyOBvTSJyAT9F2kcgwX/I
X-Gm-Gg: ASbGncvrGRDY74D6FLw3+bElPPL7uezQ1kVui8+uMXXFAnO59dhZgiI9ASS3/lG4Szs
	mJnVO6GCNuH+ptEjcBJst0FHfQuhUSv9f4Hu+buNfQLYJ832CeDvYguXV/JszIczhwGQtVislCm
	s/7QIetDFfKXJoiW6E9/5bu15fBDkAYmbigbkQWBjnjb3LheXg19obK79T6qqfHLIZyat4lm6qj
	MaaFU5FBe+dgcQi9rDVGA+dkcW087qJtlnIMtkaYiGbv3rFjArm2wsaxn9WAeUTfUgaLSG4hehD
	T/660qN2Ue8vquzgP1yOV142hEzSMYZEV78IwTILj+2rS4k=
X-Google-Smtp-Source: AGHT+IHmVWml0ynlCHKt+1NR5alEfxjCIyyyvf8JgsX1ScciEPk5Ko/J39D7pLnHFkZkqIkfjRdMew==
X-Received: by 2002:a05:6a00:ace:b0:740:6f69:8d94 with SMTP id d2e1a72fcca58-745fdac936dmr866717b3a.0.1748024297701;
        Fri, 23 May 2025 11:18:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm13024866b3a.118.2025.05.23.11.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:18:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	dan.carpenter@linaro.org
Subject: [PATCH 2/2] fuse: clean up null folio check in fuse_copy_folio()
Date: Fri, 23 May 2025 11:16:04 -0700
Message-ID: <20250523181604.3939656-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250523181604.3939656-1-joannelkoong@gmail.com>
References: <20250523181604.3939656-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fuse_copy_folio(), the folio in *foliop will never be null.
fuse_copy_folio() is called from two places, fuse_copy_folios() and
fuse_notify_store(). In fuse_copy_folios(), the folio will never be null
since ap->num_folios always reflects how many folios are stored in the
ap->folios[] array. In fuse_notify_store(), the folio will never be null
since there's already a check for filemap_grab_folio() returning a null
folio.

Add a WARN_ON for a null folio, which allows us to simplify the logic
inside fuse_copy_folio() that otherwise checks against a null folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..54f42a92733b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1100,14 +1100,18 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 	struct folio *folio = *foliop;
 	size_t size;
 
-	if (folio) {
-		size = folio_size(folio);
-		if (zeroing && count < size)
-			folio_zero_range(folio, 0, size);
-	}
+	if (WARN_ON(!folio))
+		return 0;
+
+	size = folio_size(folio);
+	if (zeroing && count < size)
+		folio_zero_range(folio, 0, size);
 
 	while (count) {
-		if (cs->write && cs->pipebufs && folio) {
+		void *mapaddr, *buf;
+		unsigned int copy, bytes_copied;
+
+		if (cs->write && cs->pipebufs) {
 			/*
 			 * Can't control lifetime of pipe buffers, so always
 			 * copy user pages.
@@ -1120,8 +1124,7 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 				return fuse_ref_folio(cs, folio, offset, count);
 			}
 		} else if (!cs->len) {
-			if (cs->move_folios && folio &&
-			    offset == 0 && count == size) {
+			if (cs->move_folios && offset == 0 && count == size) {
 				err = fuse_try_move_folio(cs, foliop);
 				if (err <= 0)
 					return err;
@@ -1131,23 +1134,20 @@ static int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
 					return err;
 			}
 		}
-		if (folio) {
-			void *mapaddr = kmap_local_folio(folio, offset);
-			void *buf = mapaddr;
-			unsigned int copy = count;
-			unsigned int bytes_copied;
-
-			if (folio_test_highmem(folio) && count > PAGE_SIZE - offset_in_page(offset))
-				copy = PAGE_SIZE - offset_in_page(offset);
-
-			bytes_copied = fuse_copy_do(cs, &buf, &copy);
-			kunmap_local(mapaddr);
-			offset += bytes_copied;
-			count -= bytes_copied;
-		} else
-			offset += fuse_copy_do(cs, NULL, &count);
-	}
-	if (folio && !cs->write)
+
+		mapaddr = kmap_local_folio(folio, offset);
+		buf = mapaddr;
+		copy = count;
+
+		if (folio_test_highmem(folio) && count > PAGE_SIZE - offset_in_page(offset))
+			copy = PAGE_SIZE - offset_in_page(offset);
+
+		bytes_copied = fuse_copy_do(cs, &buf, &copy);
+		kunmap_local(mapaddr);
+		offset += bytes_copied;
+		count -= bytes_copied;
+	}
+	if (!cs->write)
 		flush_dcache_folio(folio);
 	return 0;
 }
-- 
2.47.1


