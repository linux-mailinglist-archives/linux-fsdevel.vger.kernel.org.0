Return-Path: <linux-fsdevel+bounces-62421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922FEB92887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 20:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853751905814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8883128D3;
	Mon, 22 Sep 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq1SucGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577F2E9731
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564131; cv=none; b=kCJG0OA6ufEs4HIrJi4QUu/QRGw5OZcoiq4XsiTlTKHmcRFm4z7H8CQKD7jqi5NhcHflouGndROwwVpSBh4t5Z+PSw4i0t++rGzl+HHCAdxpUCBl/g4zSAQ1J88/xTul4nLdqYf0ScsuospTkXtJlCrbftdiugKO3Tok1Tko7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564131; c=relaxed/simple;
	bh=F1E/F32pkh8zKekUT9NeTJxi9zSoSJwLQjKjPTSiihA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8f+kwHgqGk3Fn9984yry1hh0hfb2dNznD29jFK/71oqk8MxK3ZF4XFKtbVXDsvABj1IJn/Wt3UTNC/XledA1jb02HDokW85aVNAIEIExaeovT4CqhUeHKwmlvq5XIZF5hmS0puESH3Qyl4UTwa2DwBj9axTAkgB1k96pdlWWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq1SucGT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so50418565ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758564129; x=1759168929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSZum0kl/yGKTPgeahrkVYO5w2Dpd2TgmgHE35EMSZI=;
        b=Xq1SucGTlDxXkouwEB1FAk/B03pHMPjKCAABPI3ahdftgPY1hXEgxJ7v9F9wXfvDT/
         dsaPcclh9EMMDbpHyDmpw+H1n7FSte0ITjtj3uUjCH2fWtlz8SE2OkWlGNufRYexx75j
         0ld+W7/o8wge/cayjlhBBcVICdZ9rYTAkNN+ueBTELYG3G0CKeKY1s0HhLa5rZ19rKjh
         bSFUXV8fDKFG1ovrP4QCe9rQ+Humt1nj7cIrcLRnN+UFyY7L+ZFa1rG0nzxSLYiWl5em
         VoFWfK3TFCCnGiaNywTAXGDYZOelKPDOm2Lg1Po9yTBlbC1m/0RsNofe88JDXGXaYk6H
         q5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564129; x=1759168929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSZum0kl/yGKTPgeahrkVYO5w2Dpd2TgmgHE35EMSZI=;
        b=K4Tf26itqQuH4WCEewpB19UW3V92KVKmHXW7yf4naEeiJkvrcI7eqQBRnl6MdhjF1X
         4kyU48QlsE6fHbLwZ5nKq3YYYXG7cnN3n55NZQIvoYLd/Dk1pYxcSLsSpSnBhVhPL48m
         2fpt+60ofgwdkfFskvBLae8VgxDS7rXMGxBwT5ffy5+bL7BoA/EbmyGqX4KUaVEW+b1l
         TpcuWuAodpiifiwivpNtc6UBNUFdK96Pe9no4CIgOgGOhbFoKFX4A3yXuig3vZsI42Qi
         stU84IjMIiS1jlULGsZMxSQqWjgl1N0PX89ToCHjC9Or0pX7oDULZRvQGcFx3saexYHY
         sNug==
X-Forwarded-Encrypted: i=1; AJvYcCVU7xY3H/25dgpg689mo9+a5MZ0IpN3iaXaNEyayMOxS+laCbUOkjYOH/4zoKUfCvaDegn7IPuSUcYg+Vl/@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFhCVMqsrCZ71THXp/dPd61YehEHPjsTL/dueaD4k5BYLtBNF
	tDf+pJhQCQ+Kbb+bzMBeQmnTxecYsRTD4L5reWynvfy5Ee3+RftFGBSN
X-Gm-Gg: ASbGnctZZ5PSh4sAA0D5wuvC9CGEGGAhQ13NOCJwNEFGuLf/F9RFzxxmjBmZ1kfEE/k
	Jn+kS3xKBOBCGghc4423gPW3MQ9U0rAyFEZJ3lo8TU6/r/EjODSFNsSlE0ISQCH+auEza4azosw
	eVVeHW8+m19ZG1e34sjNGz1DAWX64g7mOtFvIYnkSuQmJPFVv5A4QjlKEEGjkC3lc7GiJJI8t37
	6lRuRXTpz35xFZjV+RJr6YTidFVVCppXhyiLjmenCJI0X9pPnjaXhqMOHbQ3XTSxUscDrEZTvOv
	licOAggg3jasRXAP/FRUpurr7sZU55IRSxWv6yf9jE38MNqyCxCchZ9YT3facq8Nz9deW7VrH2T
	slYElHKqjUOs+NAlpOVDwRq61Z0yuI/CCy/qbSvQ2Qtw+VzZS
X-Google-Smtp-Source: AGHT+IGcsuXdGPax9MG6CTe3X37K6r88CvfaIMyZhKg0cOEoXk5XSlm71gAiCfXdaI9HrxlKetC0fw==
X-Received: by 2002:a17:902:ccd2:b0:246:d769:2fe7 with SMTP id d9443c01a7336-269ba5086ccmr173223885ad.28.1758564128958;
        Mon, 22 Sep 2025 11:02:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053db2sm139807695ad.2.2025.09.22.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 11:02:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH] iomap: adjust read range correctly for non-block-aligned positions
Date: Mon, 22 Sep 2025 11:00:42 -0700
Message-ID: <20250922180042.1775241-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_adjust_read_range() assumes that the position and length passed in
are block-aligned. This is not always the case however, as shown in the
syzbot generated case for erofs. This causes too many bytes to be
skipped for uptodate blocks, which results in returning the incorrect
position and length to read in. If all the blocks are uptodate, this
underflows length and returns a position beyond the folio.

Fix the calculation to also take into account the block offset when
calculating how many bytes can be skipped for uptodate blocks.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Tested-by: syzbot@syzkaller.appspotmail.com
---
 fs/iomap/buffered-io.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b847a1e27f1..1c95a0a7b302 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -240,17 +240,24 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * to avoid reading in already uptodate ranges.
 	 */
 	if (ifs) {
-		unsigned int i;
+		unsigned int i, blocks_skipped;
 
 		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++) {
+		for (i = first; i <= last; i++)
 			if (!ifs_block_is_uptodate(ifs, i))
 				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
-			first++;
+
+		blocks_skipped = i - first;
+		if (blocks_skipped) {
+			unsigned long block_offset = *pos & (block_size - 1);
+			unsigned bytes_skipped =
+				(blocks_skipped << block_bits) - block_offset;
+
+			*pos += bytes_skipped;
+			poff += bytes_skipped;
+			plen -= bytes_skipped;
 		}
+		first = i;
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		while (++i <= last) {
-- 
2.47.3


