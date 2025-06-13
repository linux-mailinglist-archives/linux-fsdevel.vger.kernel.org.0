Return-Path: <linux-fsdevel+bounces-51632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB2AD97BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405A97B135A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E828ECD8;
	Fri, 13 Jun 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxTriyRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2A28EA65;
	Fri, 13 Jun 2025 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851468; cv=none; b=EywcZDb1ziAu5xt+rOpB0fPGqGvuJJsBFCTsKF2CeqJn2Oi4A7tT5H/lEf3vFBhI7XwCnFAQ/NsHyRbPC4VFtWwBo49dnY/nUompaM15k/Z6UeO1Htbd+X7m8vyJ4KHlpb3bEmFZQLRSgi445O6yKTwtlbWmWgYS6zPkpJ58wa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851468; c=relaxed/simple;
	bh=jImIQEmiVFartpPcLPr/fbaZ/YPyKxPQwTFmR0O5DEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp0sCcauVIFe7rXLB/cXPHhsK9M+o2xjROhPp53YYstHbT6wmhE+kb4gsbAwq44sDKYVjnuvuItq6nQFAwNsuYvfkq7tvkK7mCH/aMZV0v8SLxVGquzpyWvab2k28eLR8SiAJSzNvl9E9nrpdfpa5Sg5kIrnKIkG2T2Fv3VRgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxTriyRY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1684345a12.2;
        Fri, 13 Jun 2025 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851466; x=1750456266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PVy/ZlHmTIl1yws0A6OAirnuG5LOflmbyfmEheYy7w=;
        b=SxTriyRYmQxF/+mEH3oxWnT05YhezpZMVKlmrfSgS75Bh9EZC+KwWr+bwbVcGkeI5i
         ahnGEcOoDjnsRkIztajU6L2Dam0C+u6RFrexFPHEUWQhYbPLvqx15HIIuM8MTqT2ux3Z
         Ch0/xqer6K9SEdr9gJJ94r6kFVnrYg0L0zPxFsbm5ufufbjPLmLMkS6okDHUQgZvxM5c
         oYzI+OprbtGLdGTOC04or9pu0zGSEpp5Nn+rRTraFOobc/ebJRn5IothYjsunXtOwmP1
         Ejd+WaUquSHbIyfEbUNWTXQwwt3+8gnpqAiij22wLsslrX8XiSOtUq2Naz+oRhhGiVDX
         hMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851466; x=1750456266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PVy/ZlHmTIl1yws0A6OAirnuG5LOflmbyfmEheYy7w=;
        b=DY7ABJA7ixIe2kg3H+0Q13lobXzlVYKGodGk7qICe0iBEc4lPRlhAmJfaRmcp3837o
         SeAik3xRGVtcwurDV0pS0uL9R4QTCSRFmuWplg+DY+PG/4vihrVBPzUtMh868sHNzi1o
         pZPS2Ame11ZJ++fQHVwKO0xJYVf2dajoV6a1naF73L9DCARhGw3cA4boeeIxHTgVUpk6
         5Iy+2n2XnIbYXFbycsrNNIjKX2GV7Km/EGoXo5/CNXAW0k73M6Wxj/jumn7nVWt+0kW+
         6xTe/FS7LmWDz7tHCm1I4J2PMq69kWX5+5RA3Dv4wy3gpQkB7oXDXNKd5G/Ae7bMJZNH
         tuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCzCWDoYi9wS6aSNEvRIXgGVjThEP50xRdG0Qf7Gy/qv+qDu5oAB+SP5eKgOx3pfQaiEhayigfovw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZVabWGPoUfX/z7wc7EnPXkMlNLbIjLPaxIR6f7RcwLgOLO4h
	AtapTKrnZdYA8UEjVQbZ0shxfFfPS31pakHnmJqte6emWVJe8RGBKCJFBKqi/A==
X-Gm-Gg: ASbGnct44o4iW7Hkqrh+1gYSyiM5mDLOLhIu9TTDJKezZc3RpJsKcaD6txXaG1r0VkT
	Kx8jiJYrC9XQ01QsY1lJZ9o9TS8L90KM29CR+Myx7xsif0z6HUFI9dZQ8FjPfV3+iNtfQ/2+m38
	fvhRehEQk3dPvhFHIsU0DQGomVq6JgjdQxeKLp4FA18hsW8n1SuLEQxCQV0x6ARY8F7UGk9SLSB
	rMMoRhDn5o/3HcTQfEuChYbQhpOwv+uHQU7ZF0vqzMzwlFHfDqXnk05XcPx8oLLS0xZb8D6arAW
	FoWLxMmXixdz86VPM2t/kuaw0lO4uzB8J36vQLwso7rqcSiRSzDghIJ0fw==
X-Google-Smtp-Source: AGHT+IGN2y6knmmBn+gZouB8/sJUmKL3CR5nSZ02hpLBMXAYurSXWCsbewqiidvhFBwe1v+1aqvb7A==
X-Received: by 2002:a05:6a20:d705:b0:1f5:8220:7452 with SMTP id adf61e73a8af0-21fbd683f2dmr1399084637.24.1749851466222;
        Fri, 13 Jun 2025 14:51:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b3740sm2139809b3a.115.2025.06.13.14.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:51:05 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 12/16] iomap: support more customized writeback handling
Date: Fri, 13 Jun 2025 14:46:37 -0700
Message-ID: <20250613214642.2903225-13-joannelkoong@gmail.com>
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

Add convenience helpers for more customized writeback handling.
For example, the caller may wish to use iomap_start_folio_write() and
iomap_finish_folio_write() for tracking when writeback state needs to be
ended on the folio.

Add a void *private field as well that callers can pass into the
->writeback_folio() handler.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io-bio.c | 12 ------------
 fs/iomap/buffered-io.c     | 24 ++++++++++++++++++++++++
 include/linux/iomap.h      |  6 ++++++
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io-bio.c b/fs/iomap/buffered-io-bio.c
index e9f26a938c8d..2463e3b39f98 100644
--- a/fs/iomap/buffered-io-bio.c
+++ b/fs/iomap/buffered-io-bio.c
@@ -99,18 +99,6 @@ int iomap_bio_read_folio_sync(loff_t block_start, struct folio *folio,
 	return submit_bio_wait(&bio);
 }
 
-static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-		size_t len)
-{
-	struct iomap_folio_state *ifs = folio->private;
-
-	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
-	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
-
-	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
-		folio_end_writeback(folio);
-}
-
 /*
  * We're now finished for good with this ioend structure.  Update the page
  * state, release holds on bios, and finally free up memory.  Do not use the
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bdf917ae56dc..25ae1d53eccb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1638,3 +1638,27 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 	return iomap_writeback_complete(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
+
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
+}
+EXPORT_SYMBOL_GPL(iomap_start_folio_write);
+
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
+
+	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
+		folio_end_writeback(folio);
+}
+EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f4350e59fe7e..3115b00ff410 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -454,6 +454,7 @@ struct iomap_writepage_ctx {
 	struct iomap_ioend	*ioend;
 	const struct iomap_writeback_ops *ops;
 	u32			nr_folios;	/* folios added to the ioend */
+	void			*private;
 };
 
 struct iomap_writeback_folio_range {
@@ -575,4 +576,9 @@ int iomap_bio_writeback_complete(struct iomap_writepage_ctx *wpc, int error,
 #define iomap_bio_writeback_complete(...)	(-ENOSYS)
 #endif /* CONFIG_BLOCK */
 
+void iomap_start_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
+		size_t len);
+
 #endif /* LINUX_IOMAP_H */
-- 
2.47.1


