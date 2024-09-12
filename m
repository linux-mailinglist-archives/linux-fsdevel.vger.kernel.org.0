Return-Path: <linux-fsdevel+bounces-29135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D142E975F9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 05:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C2B21EEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27D126C10;
	Thu, 12 Sep 2024 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km2ykTB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F778B4E;
	Thu, 12 Sep 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111195; cv=none; b=XoEINN0gJmyOxVw6crAIYmf0zDQfih+9kG1+uDYVMcCC3uHT19o8IO2Iu16x/D384iIYak76mMbls9j6cm558Pcuq5vRVXI07+Rgz2Evsi+DfeS1a4iwAw35lFKkW+XLpAN/QbdL4C9bJTf1VNJ6rvmG+yBHPngJh3BJfV4o7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111195; c=relaxed/simple;
	bh=m1tF+gKTZRjuiSnTit29MiFVqLs4XZKIONA1IqSW+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHjrYWnMfJ4zVlftO93+jh+5yFYIwehNIq2LLbyH5+Wh5lYI9K+vcr9Hfne762guqLQYwhu7ju9E22mVz4g8AwTJ5McN9+HzuODqYZZ444KcEPBPtFZibI7tNTXAFimAySdI0J7+D4dHovy5bxAQxvAO6bXaIg1jbFwWwiDCJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km2ykTB5; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2055f630934so4676605ad.1;
        Wed, 11 Sep 2024 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726111194; x=1726715994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jExuf7MBjL5cBNgpXoufZ+6Zl4Ua731iGH3m+MrI57I=;
        b=Km2ykTB57pbH1+mRfe6sDWvqVgcOyhMbEO83EhOrrQYIWIS+pSdCMNiNr9jsQ2pM94
         jXpavD9S0YKkWlYRXWIt5Tyg7sxnxWhuqbWs1A1kRm7AS3RcfwHYQfjFe6/hOD27Mzjt
         CvfNbc0ZSUiR2jB969d2fxpJGysUd78OmWAfayENS22s15c5Oyy7bZzlWtl4XGhmYJ9w
         KRlgZfWduU0TVRSoLEF0SCEwvKfpbYjypIXN54JiLqkjrFK7mbhm52uzJskRMHlLkGSZ
         6tKeSJzUmqcAqz/jJ4xfZseUq6u4Du6ZFqNPEDzghxls3uPSLa4ddJ/o0HJPILypU5pW
         PIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726111194; x=1726715994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jExuf7MBjL5cBNgpXoufZ+6Zl4Ua731iGH3m+MrI57I=;
        b=g95L4R1UwYRIpJ9kxs1G4Lsbmk4uhG4ML45rb8klrhwgU8zkRmOnfok0/VKw52XdJ/
         li6OMXm3kFOG5cG91kSuczu7hWh5kMIieeYMC6iP1DyMsH3YqWcz9fg0NsFGVQhslI+R
         462IKPeyA5+xbwoAaWG7CbTQ9aFZtfHY4HTmzAksswHE2xoxWR8cHyAWF6UlWDkTx0hR
         3aHPx1NQUYgvr5EjpAIrOtB6E6FLL5WMbcr2dhERtk07f2rdQoVgCr6yjctSKRZCisAk
         BmHwPEPXziwQJeQiFjRo33VzG99jUVjhjH3S0qxPrWOSPnxxyjOJjjm1FnJEdaZlmpgV
         cvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH384euOI4MEe2TDGiskn0eB6mLCyITWWMUeaBNUz5Sn/VKG3G190keW7e0ptGkdii+b03EkIyHacEEG76@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuvj0khpdFaKrmml3kHodTXi2EtKv2x2071nLI4SDrR6f37bqe
	5OnvIjiHOJYdCNnn1V0MDjw0l0VrIXgBkYAeAn9C6qhxLjw7Z63I
X-Google-Smtp-Source: AGHT+IFI2ez/o8QsMdhFPqxV1iT8xAGv0kPgnK46jopv6jur5JzDB6QHYmBsyREjb+kIcMopm7ZdnQ==
X-Received: by 2002:a17:902:f550:b0:205:4e4a:72d9 with SMTP id d9443c01a7336-2076e30651fmr26981865ad.7.1726111193776;
        Wed, 11 Sep 2024 20:19:53 -0700 (PDT)
Received: from localhost.localdomain ([115.156.142.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a0adsm5949255ad.270.2024.09.11.20.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 20:19:53 -0700 (PDT)
From: ganjie <ganjie182@gmail.com>
To: krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	guoxuenan@huawei.com,
	guoxuenan@huaweicloud.com,
	ganjie182@gmail.com
Subject: [PATCH v2] unicode: change the reference of database file
Date: Thu, 12 Sep 2024 11:19:32 +0800
Message-ID: <20240912031932.1161-1-ganjie182@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gan Jie <ganjie182@gmail.com>

Commit 2b3d04787012 ("unicode: Add utf8-data module") changed
the database file from 'utf8data.h' to 'utf8data.c' to build
separate module, but it seems forgot to update README.utf8data
, which may causes confusion. Update the README.utf8data and
the default 'UTF8_NAME' in 'mkutf8data.c'.

Signed-off-by: Gan Jie <ganjie182@gmail.com>
---
 fs/unicode/README.utf8data | 8 ++++----
 fs/unicode/mkutf8data.c    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/unicode/README.utf8data b/fs/unicode/README.utf8data
index c73786807d3b..f75567e28138 100644
--- a/fs/unicode/README.utf8data
+++ b/fs/unicode/README.utf8data
@@ -1,4 +1,4 @@
-The utf8data.h file in this directory is generated from the Unicode
+The utf8data.c file in this directory is generated from the Unicode
 Character Database for version 12.1.0 of the Unicode standard.
 
 The full set of files can be found here:
@@ -45,13 +45,13 @@ Then, build under fs/unicode/ with REGENERATE_UTF8DATA=1:
 
 	make REGENERATE_UTF8DATA=1 fs/unicode/
 
-After sanity checking the newly generated utf8data.h file (the
+After sanity checking the newly generated utf8data.c file (the
 version generated from the 12.1.0 UCD should be 4,109 lines long, and
 have a total size of 324k) and/or comparing it with the older version
-of utf8data.h_shipped, rename it to utf8data.h_shipped.
+of utf8data.c_shipped, rename it to utf8data.c_shipped.
 
 If you are a kernel developer updating to a newer version of the
 Unicode Character Database, please update this README.utf8data file
 with the version of the UCD that was used, the md5sum and sha1sums of
-the *.txt files, before checking in the new versions of the utf8data.h
+the *.txt files, before checking in the new versions of the utf8data.c
 and README.utf8data files.
diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index 57e0e290ce6f..401f5d3aeb0c 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -36,7 +36,7 @@
 #define FOLD_NAME	"CaseFolding.txt"
 #define NORM_NAME	"NormalizationCorrections.txt"
 #define TEST_NAME	"NormalizationTest.txt"
-#define UTF8_NAME	"utf8data.h"
+#define UTF8_NAME	"utf8data.c"
 
 const char	*age_name  = AGE_NAME;
 const char	*ccc_name  = CCC_NAME;
-- 
2.34.1


