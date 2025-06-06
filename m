Return-Path: <linux-fsdevel+bounces-50883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D1BAD0A67
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 01:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDD17A99CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C523F417;
	Fri,  6 Jun 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPeb3Ply"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7823ED6F;
	Fri,  6 Jun 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749253377; cv=none; b=g2asD8xFb2Vm0KMO0nLbEXFXbmmsMTKKmax/klQt7W7sZDdc5RMbMxbqa4Pb6NwBs0y+Ggxf7hOPCjeRip9Awc+e6fgQ1BBE/a5I152wlYeOV6knJ1ER/Fl/UixyAOkS4SXXzallNPYqD/fcEHM4/E+1F6KavQGLpR+G++E0eOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749253377; c=relaxed/simple;
	bh=cCXGbrzes15ktZcmkvPH0DXml/R9J83cVm2YLfdVscU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvYU6U9L00Jhms8AZg+P+VBj0nl68xgIh5WDmIUR/2lPy9hGcTCmkSJtKwIrUNVS13oCnNMZnd1zb/jxYOLNsfK45N0XIEwTDHnZDqEgGXqBo7jEbgT32YFAAmK06A8APfPx/Md4qQWW96vMMNXA4oHPxztY0rIaR9m6JobpgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPeb3Ply; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so2732048b3a.1;
        Fri, 06 Jun 2025 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749253375; x=1749858175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em62AD/sC51kTNAuWB60jCefbc3W3b6XWPIHkrhNm8k=;
        b=OPeb3PlyYC+Sy6Vk0jSncJZhAx9lRx1e3c99JHXWHLvdYs4R/CFGRM748oSSZZx6eW
         nFpPocffDXhIBkF2jlyqDabAW7vgvVB6YSSZ70uhhOogbclyPm9GWDF5AITxesHRikJA
         npsYzQ2CPQQS4f/FwitFQQuQsAkqy83UsWuT8tYIbfTyORCAMKIX4yoMYePv66T8ibkA
         sXgCECddfczmoNeA2hCogFZnzzM1fzHwueZZXqkgvV1bCXGJU7S9tBb4GKtdtZ+8xdei
         53dacaBzkuQpYBt+lzPdTLOhUEUftpheJXBk8JQ7foA0p4T1VwCGqDZxQ6yGRO4A6Bkx
         ldow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749253375; x=1749858175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em62AD/sC51kTNAuWB60jCefbc3W3b6XWPIHkrhNm8k=;
        b=Rw4zBImr5TjPUAhtOuaxTV91q4u+BqGwHmsxKBQ0VRDTvDrJSFPHl5iWepoyUkgFzG
         Gu3OeD9BN3vfS7yO1DQKABoI9iKEfAV76ycZyKUJt9/kAdLdzrDPmzvypEhZTgZx3I2r
         xEoGXWwxV53HTCS50T6y78Wg9hGJYRPG5PJhIxWEO/hG8yiQFSYTFvoc8AusMFPuH2Zw
         47dlcPTwoDmOF1ymA2Fu3+/jY+3tiNZCmoVNObvz2BtlaDhXnmhvDJK8vYUv3ftp5WGx
         rAcYZMbiTKb0f4tGxdgMEnSVnik/6mCXintLaK5fB8DKyhbdfw2C32ge+5AYSl5UvSYS
         d6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVUoH1c9YkldmddTBHcodC3IY9do8fx/1/3QRFBPHUyOW9CghVXKMtpG2406KPjCDx1OivQIE+CImV3@vger.kernel.org, AJvYcCXUPA1cAbQw92U6H060P+hrHj/fsTCYpxh3Q/a0mPH6diKW+O4CUS7ltHFsH8EngH1fF1F6bk3sbTw6mc0L@vger.kernel.org
X-Gm-Message-State: AOJu0Ywluno4eha2CjjTVwMH5s1YdLWj00mfMuOZYkdtmOFVeNduWJSx
	NUZC3ZsuQ9gMfiYsshsHJS8tTGGGtMsx5fqjbLLvscTjnEt10j66paHo
X-Gm-Gg: ASbGncv1rbJXMXTrhoVP6Uee0tM5pbXUTE6n/I/SVfDOSIVzng8eKyTplfo4IRttiqK
	q1tzM1QVnyqc0w4TF+N0EG4M+8oGeBiga9N/BzrdKJu9pReqB/m5D+fp6doL0PY6o5/S4QBwMjF
	kGqt5gZerOdZEr00xNCS5+w89WMFdB9tXhbc4+31/12uwWWVLQfGuT4sIGnlehRQA3hC7dGk0kU
	ieSzvVIf5S/Jo9642/k+AC0B0JnU84wDkpjmVV9OeOyoj06sYnDYf2fdF/Q0jV4bO1D7wbKSoJF
	+I34vGTPzkXXsmVgXdnkAPFgf/IkmBHTxVJ1a0H+2PEzZQcjMJ01Bbx5
X-Google-Smtp-Source: AGHT+IEkiQMjmgr/Uuw1eZWwSUmLVz1izCcjiGLcALCdYgHnubBgcUiGcSFxv9xjKqAr1uJDoMSWew==
X-Received: by 2002:a05:6a00:1885:b0:746:3040:4da2 with SMTP id d2e1a72fcca58-74827e7f75bmr8001986b3a.8.1749253374953;
        Fri, 06 Jun 2025 16:42:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b084cb4sm1880117b3a.91.2025.06.06.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 16:42:54 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: djwong@kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Date: Fri,  6 Jun 2025 16:38:00 -0700
Message-ID: <20250606233803.1421259-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iomap_writeback_dirty_folio() for writing back a dirty folio.
One use case of this is for folio laundering.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 23 +++++++++++++++++++----
 include/linux/iomap.h  |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 92f08b316d47..766a6673f79f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1592,7 +1592,8 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
 }
 
 static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct folio *folio)
+		struct writeback_control *wbc, struct folio *folio,
+		bool unlock_folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
@@ -1610,7 +1611,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
 	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+		if (unlock_folio)
+			folio_unlock(folio);
 		return 0;
 	}
 	WARN_ON_ONCE(end_pos <= pos);
@@ -1675,7 +1677,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	folio_unlock(folio);
+	if (unlock_folio)
+		folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1709,11 +1712,23 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 
 	wpc->ops = ops;
 	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
-		error = iomap_writepage_map(wpc, wbc, folio);
+		error = iomap_writepage_map(wpc, wbc, folio, true);
 	return iomap_submit_ioend(wpc, error);
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
+int iomap_writeback_dirty_folio(struct folio *folio, struct writeback_control *wbc,
+				struct iomap_writepage_ctx *wpc,
+				const struct iomap_writeback_ops *ops)
+{
+	int error;
+
+	wpc->ops = ops;
+	error = iomap_writepage_map(wpc, wbc, folio, false);
+	return iomap_submit_ioend(wpc, error);
+}
+EXPORT_SYMBOL_GPL(iomap_writeback_dirty_folio);
+
 void iomap_start_folio_write(struct inode *inode, struct folio *folio, size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4b5e083fa802..a2b50b5489da 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -483,6 +483,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
 int iomap_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops);
+int iomap_writeback_dirty_folio(struct folio *folio, struct writeback_control *wbc,
+				struct iomap_writepage_ctx *wpc,
+				const struct iomap_writeback_ops *ops);
 
 /*
  * Flags for direct I/O ->end_io:
-- 
2.47.1


