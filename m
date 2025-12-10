Return-Path: <linux-fsdevel+bounces-71055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B04CB30E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2576305E355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144631A808;
	Wed, 10 Dec 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW5/1ldB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616A1E89C
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374194; cv=none; b=tOWanWz7Wq2DTorad+9bsgy4CbiBiu2IXPOuWQD4+QxkhyXSsNNdULE+WRn0O3qaUowD75ca9GHK+Meye+YYjO6W3Sjq74CYR2wnA1Gaekrpb5V9ooEIWoqnQyUk1xG2KYo+tTe6xLJTo3fulvAUJvgpF0r+EKR8mE2GajyIECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374194; c=relaxed/simple;
	bh=WBVzNZSkFrPdrq1t3LhLwQejTw9l6uxpCc63//V3HxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjKkjFNzAg9KX4diC7JcNVJLEYPTK5E+p/+SSaQ1zHzuWRTE1yxGzO2VMY4GiGjbV1RgYNDKkQ23b+H+B7kciTnqAgGc7+WSKVZVWbfAynSH7KE80NOlKhEjKJ7/VnKcr1lRgaXN6TYaDDAH6XkmETALYpen/irTUmsZLmSGomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW5/1ldB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79ea617f55so73799766b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765374191; x=1765978991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CB3h2UzBEn/Z99lfjG1z98T32qhuvflmEMn49O36gNk=;
        b=BW5/1ldBE2tUUSGXXqQGWYIEonHULjUC5ZQzV2hsZqn9FQRLyDd4SHVJfOpKanjTGT
         rpBhsPjYAweaQB12IyA0ROEHiiLHkIoMMwj0hoxEP+l9isg/Iotq6D3J1bPDzOA9MiAJ
         DybORhgo59W2yAz/sWhqXus69Tj3QCmkM5QuRyRNbxw2c3peI4Ieykp1DW1yaWCSFnH8
         4nbVCnRM8EX+C+Qa3a5wGTry6NGY9tS6sp6s90mbdWIEwrYxiwenh+ZB75c+RjxtXdPi
         xtdssnzUZwsiYNZ5M7nQWxQSz6W0wBMRt1Qu34JIuSPy0o/u52tsiiZGjNmRdFfJmir+
         SUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765374191; x=1765978991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB3h2UzBEn/Z99lfjG1z98T32qhuvflmEMn49O36gNk=;
        b=YbXgQKu1SGlU2Tg87f2jozVtCw9i3LD+CNWkfA4p2FCf/wVdZdlZG/stxPanS6Jfpc
         8eO00890oWbd2Eso9DHGM2IOE/sqIHFI+OmFOI+hb14JzxzdY3vi+6C5zJDSyt21aFAJ
         z2ds/4YFr8oGzSdKKlrCHgUSdkuIMf1YJiPp6H4hd43rtB4WKTs1LAaky205GaYrJxyV
         OwcC38itrjHH1V8WzSnot75KBFsTO2i9PvC5xc8yu0GRYN3ac8H0YEyJrTzLgYRsRhaR
         o29U+vrBvdJ9NT4WdXcE/+KYZF2fJtZas4HFUC07LpYDCsg7lfMvlL4wcUMBd4EkZhBE
         jziw==
X-Forwarded-Encrypted: i=1; AJvYcCXPhwhHdAyOUXoaxRtlL7QIfiJIh6Bk2hhcUfubR5t2B0sc+vtIh5ApF8JO/URRuU09tJwCoMCgBfTQaCZ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0+54pxBnW1DKMHGr7LEJyqYItwCkxLNvs7E0+VQQD0BWfPyX9
	K2I9h0AJjJYDMJwEiT2fIOETLFYoMP9l9ZEsg5+/t1KMfJMkMRQwpfQz
X-Gm-Gg: ASbGncuuB4lFMx+5FDBtSSFIKWg2VnGyTyEx6T0kuGioHc+nLzuITlbtq5uRBQ3M7uo
	dobV1BTZDW3LbR5XiQJpBtCOdjdL1QHyd17JGTzw89cNtfFMPx4c209syD58OpiqfU4vXheqP1C
	A1GpWZQk7pMePcolPksknT1uXc7PFeBflz/8k6fF459wiazq1PXCdukSP7H9BzdZhyHUBBfp/sI
	SG7kbZUtgSjBGGIu0UWTExL6VQg8TldQIy1Zp82KqOPloc9/ViyW+p4yI38IIutCYVrLmjLsdAj
	MuOGBaquO9qEEq+3r/oW+G+2knEbJxGsrIsXiMA+zmPDJB8sbRdOojmILEO5qXrIhh1Jrx4RZUS
	M2Po9p0qpQkalZ67BD0UYrd0NyOZnUUoBuKsSeSUGt1MBatIY525IeL25QbiU22fZiRFqXFB/aY
	mW8w6tgbKVXTEGzvkNqQgEh6qLGToM1xRZ4T0E1qZWSyFrGOwCLfdWVspsn2IQMg==
X-Google-Smtp-Source: AGHT+IGfLIZNIl91wGIMZKM69+1B9Op2jeoSk5aDS49uNUvvdJZUvvRKus3RTW+FHawmFa7F40c+mQ==
X-Received: by 2002:a17:907:3f99:b0:b73:8f33:eee2 with SMTP id a640c23a62f3a-b7ce84c5127mr282123166b.48.1765374190319;
        Wed, 10 Dec 2025 05:43:10 -0800 (PST)
Received: from f.. (cst-prg-23-145.cust.vodafone.cz. [46.135.23.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f449992csm1695493866b.18.2025.12.10.05.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:43:09 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: warn on dirty inode in writeback paired with I_WILL_FREE
Date: Wed, 10 Dec 2025 14:43:03 +0100
Message-ID: <20251210134303.1310039-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in preparation for removing the flag down the road.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..633537003b88 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1866,6 +1866,8 @@ static int writeback_single_inode(struct inode *inode,
 	 * as it can be finally deleted at this moment.
 	 */
 	if (!(inode_state_read(inode) & I_FREEING)) {
+		if (inode_state_read(inode) & I_WILL_FREE)
+			WARN_ON_ONCE(inode_state_read(inode) & I_DIRTY_ALL);
 		/*
 		 * If the inode is now fully clean, then it can be safely
 		 * removed from its writeback list (if any). Otherwise the
-- 
2.48.1


