Return-Path: <linux-fsdevel+bounces-70120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5DC91576
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95D33AA03D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE822FF160;
	Fri, 28 Nov 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVrgSLAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58C2512F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320475; cv=none; b=KhDdwtDV0XRXmbILHhvdC2GnhBiMDNtxN46AiUpW0uddPW8FovAL2dcc8J9oG1ruYKh9ra6G+Sdn1uCSJDon9KtwQywaxnL104KcnGAxIyEuH3SQYE8nuJt7wXDxLRVclIrcaIEnRFT4JLcWePgyrLzuCiVpLqRDLZx0c9oUirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320475; c=relaxed/simple;
	bh=qPt3JhignA5uuB7v1FF0p8D3VNdVS/qWJzKiGy9+sk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cn0kAmux0j+S2r5dlxL9vizEUFSe4zG5ea5m24Jxk9p4EaWx0AokhCExiRKzIFoWZ/ZjONpgO1t2+Dr8sc6tYgSwbUz+4eF/Tm8fFiTb6dZKrQ3AJ6FN1uQNn6MJ7GTy6gEikis3X7fj34oZzXvP55sbxpKOKtL3DK1YvbY4a0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVrgSLAy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2953e415b27so18481315ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 01:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764320474; x=1764925274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fg0aB5riC4XIUxatKNUZFJeD2L29RPwxQrX9YqPg8Do=;
        b=ZVrgSLAyC0nAfbV5SnA2vlc9r7vRveEocrliIRHU6uvUg61JEKXvpaPWmIuWaRh/+y
         wysyHPI7ov5XwtmayW+pYrI1Tkcr+MVxgT2+08vTS4nnuEGfZS8oERpBw4v7++AVR0Tn
         7DLd7JZdIiLBO1pdoAfot50Q6rjmg0JKFd73VStkEUvnew5VeUNtcQpbjYd+XFJwkd+t
         uwybwh3ErR+Ic/eZJoleQnyQLo0qxOqYRZeO8m1gJeBFAXiIzh9lW30perlavjNwwhXe
         HDaz0PIRaCBNomY3/P3pxiXRtcu8+g8BabyfGMLjL4jJIkSOme9iekgobqTie1zq/lXO
         vktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320474; x=1764925274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg0aB5riC4XIUxatKNUZFJeD2L29RPwxQrX9YqPg8Do=;
        b=o0+wHCS1ikda5C4rhuopo+g38g6dERasT0uS9h7pSJrLGcuyVx0xPcqZ2sz9EurKwG
         CZ6KbH7qx/HTbMg2sS5rY+eDcTQDIht93qbJRTKXGPi763zjHVn59Pz3lzfqvpn87VPG
         ZwwzeKGunTrbQ54eLHrVgXqYDGdHClZ4rISLT7G4HEyWjvkd2LlYLxTs1fSku/0fLg+2
         E5AtU231wdHTAQ6VyX9oWljE76Hj+eVbcKVFBMQFVEN44nj1TrPfpF5B5hj9ahcbqdjH
         w0tk2E2NwrXcXyQmBnJLkbA4zJnL7EdWvqajvDKoc++GL5o3UavjcIg98O0DfUIWVlRc
         r2Jg==
X-Gm-Message-State: AOJu0Yw2O+hUyJGNFvHJUp+CuXHldKsIdmZbMp2xcZ3JuofMODEymyww
	HwD3VWWj9O4l7oJbJqIxNGoBgUOhbp9muihr1Gk1rwdKQmeZ92mGGVXa
X-Gm-Gg: ASbGnctGELzRFyQpIvbGGbX/Git78XDvjqbeYt0W295q9gQIQRSqx7O+/U+NhK5FQLF
	J7kNLDZg0GlFjr1PVU0/v4lU9ySm49zaHBnDo7J7nrB4fKGnC+ixqHyVZ+jEzBNoItnCpWwLExi
	TyurLh8nh2S+CyXGtAlAJ9fRAWkc9uzyHYtNGZP/HCxevkAHLrLK3VDk1hi+ZhPooiM7Rxm9Dp9
	klWTj6kDC+RuFnTp48CXUK3jbGS6E+yNpLCAKAXH6ysoL2Y1bBvXR7XTvKS1fwGFC8Oc4IYK5gT
	GBJOf/WZsp+Sexyivi3ZkhT3i65JwUvDxmeVwNCJmlfP+C7UTavo3HN3mrcYO8gXGI9/LEhyAgv
	4tyJNj+njfVq6HTERo7psX7UvSCw+zSkju3iY2Z1FDPPQq0ntIDFr4Toz3p4JfOj5PgdTlgeHCb
	3ULdbLs7CyHVrCrD6/7hVVlNLyOuJPqIWHyn9Zl0bz1A==
X-Google-Smtp-Source: AGHT+IFxWF2PEdV26ARDIpHKCRhHlG+atyCi1+Q7Cb+fsxxURJFv0QzlgLe7FEUK1Y5Tmc7pd0wGiA==
X-Received: by 2002:a17:903:1108:b0:295:8da5:c634 with SMTP id d9443c01a7336-29baae422b7mr126947005ad.9.1764320473661;
        Fri, 28 Nov 2025 01:01:13 -0800 (PST)
Received: from Dell-G15.SRMIST.EDU.IN ([104.28.225.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce4703a9sm38955265ad.42.2025.11.28.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 01:01:13 -0800 (PST)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] fs/efs: Remove redundant brelse() checks
Date: Fri, 28 Nov 2025 09:01:02 +0000
Message-ID: <20251128090102.37515-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brelse() already handles NULL arguments internally, so
the explicit if (bh) checks are redundant.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 fs/efs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 462619e59766..cfc9b0d0334e 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -263,7 +263,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 			/* should never happen */
 			pr_err("couldn't find direct extent for indirect extent %d (block %u)\n",
 			       cur, block);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}
 		
@@ -275,7 +275,7 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 			(EFS_BLOCKSIZE / sizeof(efs_extent));
 
 		if (first || lastblock != iblock) {
-			if (bh) brelse(bh);
+			brelse(bh);
 
 			bh = sb_bread(inode->i_sb, iblock);
 			if (!bh) {
@@ -296,17 +296,17 @@ efs_block_t efs_map_block(struct inode *inode, efs_block_t block) {
 		if (ext.cooked.ex_magic != 0) {
 			pr_err("extent %d has bad magic number in block %d\n",
 			       cur, iblock);
-			if (bh) brelse(bh);
+			brelse(bh);
 			return 0;
 		}
 
 		if ((result = efs_extent_check(&ext, block, sb))) {
-			if (bh) brelse(bh);
+			brelse(bh);
 			in->lastextent = cur;
 			return result;
 		}
 	}
-	if (bh) brelse(bh);
+	brelse(bh);
 	pr_err("%s() failed to map block %u (indir)\n", __func__, block);
 	return 0;
 }  
-- 
2.43.0


