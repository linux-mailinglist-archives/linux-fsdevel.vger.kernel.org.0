Return-Path: <linux-fsdevel+bounces-32718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5A9AE0B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6165C1F24662
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28791CFEB1;
	Thu, 24 Oct 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGJ4+A3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA71CBEA6;
	Thu, 24 Oct 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761999; cv=none; b=IhjC86FHEP4B9LpAYLsOnaDBkC4xnWpceitFYMyocuRhZmAMVFTixGS7vtOKBiMFewc3Z+pp+sSoxQMtUsH2BPsGmoDfhXANdhgIAbqQM9P3r9l5nobsXNlnRfwDf363/m6BRxnwuMEtfdUGOUNxu8ajkZYur6uqacd4cAbou/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761999; c=relaxed/simple;
	bh=iqLZMe0dYkUhRF/FOyCNKd9pUIGhJjxvLcvo8+B/lHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaeJHZRo/lVNdeSADk6LixE+pWvaXxcs+fUmecos8TM6kupLOl0aZFzv+4A6mb6eOF4JdSalrP0fGAEKS6Yn2CCbfHZbdFgwfl0uNi2xOhEyfHQzwX+6TqRP5RgAxu2AFqMwWpysCTZ88pi6Hs6iuIsrQ9dGGn96YuVoEC9dV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGJ4+A3t; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so461854a12.0;
        Thu, 24 Oct 2024 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761996; x=1730366796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbLFzgd79wLmsOWzFDrD0P/iHQtZq8xD1Eu63hITF5I=;
        b=CGJ4+A3t8b+LJuYRIVz4XVqiumx8jOpSoYNQsrEvYV+3zDqDbrpG6GTh7yl56ppjqt
         /fD44IfNhAai3sBnJAnS1RAfFcb3wsrqG6Qri9yYZK+4L/BN86LIfjlT5SVsGQCHeYqN
         EoRZyOfDBE+aX0cduDsACipwwOxDheKHH2uMB9Na6GMqjYY+hu6i2T40tEiq7L4CSSTT
         kEqe/nt6rCJq9H1vHd0FT3GyQ8kAZkwsC6PhR3Cl1uECkKV5TroS3tmdLvlcO6owBPw4
         RmWfP7wYwKZRlP4yf2ureAHU4SYhtemy62hzxz4Wvfz/2Jpa2aa+2UgeLFUgp0VeC5Gl
         c+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761996; x=1730366796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbLFzgd79wLmsOWzFDrD0P/iHQtZq8xD1Eu63hITF5I=;
        b=CeNcktCLXwkoDRfPw8dx4zahKXmi1TIF4z4/xeYdN1dz4fwOLxvR+RM3//BnGb7Ih7
         pYC8PRV2ehMT1VUM6MkI/qaKYX+e0yUUMPjfiG7rFoC/MZWqzF8dBP6IYaPqlZ5h+oDI
         xC7ghzhdLO/7QSkOYdP/06dmRqOzgHtRo6qZ/Z0DSX+40kfNXJ/TvNi5ayG2zX4IccHR
         zODVYEtY19Eb3qtot2D2P/gTI/lHrobgBHhUespdEvpXsJlb+J9mrSoaVvv0Eu6NXh6S
         gnCubIJ6CNE1iJDGBGHk04M0OEZGvVdlu8lVn+3cBpYv+7VSyiu5RH4SSEF82BE/Pu28
         KAgg==
X-Forwarded-Encrypted: i=1; AJvYcCXETJsGP6doBfI0tLIiEafer93dMD3u1eepfqHY5oINdEzqenN/ecbHlAMUy4+1XJx0bRKK3PwvVRxZKs0=@vger.kernel.org, AJvYcCXOatWZTMeseyQpILKlzzUoeipuw4HyfcyYQjtGuCiBVoQtHhzkaeeJ0tzLdUcWgQCt2uO/8rTZZMRJCURi@vger.kernel.org, AJvYcCXqPLw0PHL2bZX/1LjV8vo0fN7SME2mlhrGr+U5gZYBlV6b+o2ZAQOaZmYDdFLoVcqjovoWVbccO2Zn5ku0@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUOwX37r25CKj0vyDwcRJo7NQS8rtSge78AQ2C73C8dR8wxDi
	2sl1DI7dSw118tL0/0/4uvmCFaPMHK46/6mAmeX20ewL6iCny5dS/zECdg==
X-Google-Smtp-Source: AGHT+IG9WDMVc5A+ppB9wz7eToYUHfrWnIYbecQ+buyieTbsZGooXmbDfQaX18EnNHR/Lh6wIq96hA==
X-Received: by 2002:a05:6a20:d491:b0:1d2:bb49:63ac with SMTP id adf61e73a8af0-1d978b98fd9mr6293914637.40.1729761996595;
        Thu, 24 Oct 2024 02:26:36 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:35 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] nilfs2: Convert metadata aops from writepage to writepages
Date: Thu, 24 Oct 2024 18:25:46 +0900
Message-ID: <20241024092602.13395-13-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
References: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By implementing ->writepages instead of ->writepage, we remove a
layer of indirect function calls from the writeback path and the
last use of struct page in nilfs2.

[ konishi.ryusuke: fixed panic by using buffer_migrate_folio_norefs ]
Link: https://lkml.kernel.org/r/20241002150036.1339475-5-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index a4c1e00aaaac..432181cfb0b5 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -399,10 +399,9 @@ int nilfs_mdt_fetch_dirty(struct inode *inode)
 	return test_bit(NILFS_I_DIRTY, &ii->i_state);
 }
 
-static int
-nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
+static int nilfs_mdt_write_folio(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
 	struct inode *inode = folio->mapping->host;
 	struct super_block *sb;
 	int err = 0;
@@ -435,11 +434,23 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
+static int nilfs_mdt_writeback(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct folio *folio = NULL;
+	int error;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
+		error = nilfs_mdt_write_folio(folio, wbc);
+
+	return error;
+}
 
 static const struct address_space_operations def_mdt_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.invalidate_folio	= block_invalidate_folio,
-	.writepage		= nilfs_mdt_write_page,
+	.writepages		= nilfs_mdt_writeback,
+	.migrate_folio		= buffer_migrate_folio_norefs,
 };
 
 static const struct inode_operations def_mdt_iops;
-- 
2.43.0


