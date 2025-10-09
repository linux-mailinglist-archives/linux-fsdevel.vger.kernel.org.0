Return-Path: <linux-fsdevel+bounces-63689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F324FBCB271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3F534E8F57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1B0287247;
	Thu,  9 Oct 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0kVAWkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C4285CBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050660; cv=none; b=to7HgiqthNMArQLRVQaDeH8mfBICpjrvdd+lG/JeZNio+F+HpzkgvyFmYPA6SGpECwtjX6v5Y7Ei2o3arPkSRg26AOyl2wpNxW/zLidHGtDsY4DFdFF8FvyGKDHiq+2XDbUvSsWn9Xd0eP3FtrbBq5EICCa+ViMm0YsLWmwFsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050660; c=relaxed/simple;
	bh=3POWIj8swlvqtIQHEa2SeYV4NIqcmCI08ScYpNGiB4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp8VZUfDd6qNtK9I/Q6DphRnrvPvMGMS1Zd7ohjtMO142Fut7lpggKiyRWWDGDpo+S6qcHqF+xlvjonKcT4WLs8xaL60PTqy18day8MnXNLwUX4nTye/K8Gh/K2fyTNYIvyWmRfzq9Jd2p5qlb38sbjDMVcgHJNPXqFZtE6EO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0kVAWkz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781251eec51so1286586b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050658; x=1760655458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eTno08BNvJLBn5cokDLzFZULJBhZn+XK7Z8+MwEHrI=;
        b=C0kVAWkzMsfx7Ea/RmyDLvk2sFO//gOnxOKPio63Lwb9Z55Rk1Tr8YDO1pXGkiIwRW
         4tSS2IJEk3ITxx+9TsgMpWAnJwhC//Ts1FJxQ+7uHrBtrweFB+MrWudJ7/ggWg3G61Qt
         V69of0qBlj1TMMTB+cyhAiAYJe3WGLNruAsT4uHa0fYjCXDjflqkpITVg1Lo6UuJbQRZ
         +ut6iMPzlvMcV7/1YT+GygRVF+FF/jnUpfWeS/wfx4UsirRTloWSo9M3kFuyBxpjUVqA
         VuaHgwkh6yk8c1TW7dXrfnuNRR8YbeYyiEVsSTXAWuEsoq3aPQ6kjgSQIJqYCDAC8Qu5
         Be7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050658; x=1760655458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eTno08BNvJLBn5cokDLzFZULJBhZn+XK7Z8+MwEHrI=;
        b=sswV11ex3UES7eF8387ldJurJ757gHb2Iv8G9U36iRT1bt8CBoJkzutPn575x8QzeS
         7TUjpQxGL0PwxIKVaG95PhUwRsWAuQx1c2V01njZIATVDrdS/fgetDLHZ82rA6VOldYZ
         dhmRZO3OJlXKWTpkjRA0qPO/vtfUr3lB/vuxbn5vK5W31UW563MX8z5ExJm7en1nFtZv
         Em5cqbwnmhneZyRnK3QhjlNfLhS8az0EB14mlojTdzx2CYUwd2lbiZt6CoDl/OVeAon0
         yXBPju4tG5xk2uOC7cl2PzkfIIqRcikHUqhmMnVadT6EuBYg8vy0ZZ7DMnKA66vEvXJc
         +rAg==
X-Forwarded-Encrypted: i=1; AJvYcCVtc5RxW9QT1+nDubBg/LxWk/EtXSRTvHhgEm8LS/cyyKmqTuEMsk2bll433OvSW1I6RPnIFibOlSSontp6@vger.kernel.org
X-Gm-Message-State: AOJu0YzHk+4qsmWPHzksPqkAmgZxN8pGW3PlTdCB+lvjRig13ycmjOkH
	zFOiHnr/4xuyovB9q1T01TSCVPfNQBmWhx/6eVB0A3LXAselQsEWPOWU
X-Gm-Gg: ASbGnct2iALn63mU5vgbpG3EgwysiqYwnQuV/fVbljroKhC/vf157oeMdXwTXMb3fbS
	KOF6I4ftddnyG13whvvCb2nPTMlL6RnEg7ia3iLI1G/ECOvaYAxzeLE4YaRLilmhhIEF+FwhrIe
	gGjw2g8ZiJXbCXCdBUH35cRxFVy926gfA5wi6HAc5T1NL23x1XkT11XtJNxa6ZbUC9k4OaX0j3D
	Jeumu2iczsSvWr6dcazMA0fDmVPx6knH+w8wSzNbiwknc0/ZjwI+GkST/EdAZvMfHfZfDg/+gmz
	r4ptTcNHNXbwY7O41JanuoiDw3R/Pg/vg7MFInKFpLXzS+mTjnm7Qy9LmIHx8MkV3pNJ7Hooz4/
	CN3c4Mmfd8bIPmVYafwByYHhrssUrqY4o+d9xy3i5ywvlTYT2NE3CbHT607C18aAEqpNRD2beIo
	lsrqyONgcsXoUXu06GIw==
X-Google-Smtp-Source: AGHT+IGZukFoVbvpRjLrd2iJC6lB9VfQgocqvC4NFARo7CXqgianY1qtUVrvSIUzgHUmvbxGD81o8w==
X-Received: by 2002:a05:6a00:847:b0:77f:4b9b:8c34 with SMTP id d2e1a72fcca58-79387ff6c26mr10716828b3a.31.1760050658328;
        Thu, 09 Oct 2025 15:57:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm815585b3a.54.2025.10.09.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 1/9] iomap: account for unaligned end offsets when truncating read range
Date: Thu,  9 Oct 2025 15:56:03 -0700
Message-ID: <20251009225611.3744728-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009225611.3744728-1-joannelkoong@gmail.com>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The end position to start truncating from may be at an offset into a
block, which under the current logic would result in overtruncation.

Adjust the calculation to account for unaligned end offsets.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f9ae72713f74..1c6575b7e583 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -218,6 +218,22 @@ static void ifs_free(struct folio *folio)
 	kfree(ifs);
 }
 
+/*
+ * Calculate how many bytes to truncate based off the number of blocks to
+ * truncate and the end position to start truncating from.
+ */
+static size_t iomap_bytes_to_truncate(loff_t end_pos, unsigned block_bits,
+		unsigned blocks_truncated)
+{
+	unsigned block_size = 1 << block_bits;
+	unsigned block_offset = end_pos & (block_size - 1);
+
+	if (!block_offset)
+		return blocks_truncated << block_bits;
+
+	return ((blocks_truncated - 1) << block_bits) + block_offset;
+}
+
 /*
  * Calculate the range inside the folio that we actually need to read.
  */
@@ -263,7 +279,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		/* truncate len if we find any trailing uptodate block(s) */
 		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
-				plen -= (last - i + 1) * block_size;
+				plen -= iomap_bytes_to_truncate(*pos + plen,
+						block_bits, last - i + 1);
 				last = i - 1;
 				break;
 			}
@@ -279,7 +296,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-			plen -= (last - end) * block_size;
+			plen -= iomap_bytes_to_truncate(*pos + plen, block_bits,
+					last - end);
 	}
 
 	*offp = poff;
-- 
2.47.3


