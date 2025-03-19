Return-Path: <linux-fsdevel+bounces-44461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF7A69532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F716DDB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628601E25ED;
	Wed, 19 Mar 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLVkmXo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9921E1E01;
	Wed, 19 Mar 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402317; cv=none; b=oPiOe/F3EXMT3BGEda2UBzH01kvaI4/TMB5pjSkpcxfXb6VddacPvoQblpCid3vcviJMzkyD/3MHCpA6kR+VDhuUkg2xtOIgb0sRv66pR5foYiOsZyntCeF1rspeM1QNdPGmdJuCLiDzHGkn8EChs4rgHWX9AWozl7hLzkjD18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402317; c=relaxed/simple;
	bh=8r7IJUzP3v8M64lNogaGdhK88wI2uELe20Y/bI5aE/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQO6zJocJue/ce69/6707S8+8JbXO4BkD+KYR/m4QbZPtrhsScWPfEVX3/XO2E7++mDVma8k1fNUM/YPwro9T/r+HUGsUw7kfg4NbR6xTedW2FvNddS3br0VshMDYA2KRE/7+DWdz6kVCj8HFVRHtM8e8HUWtFLJJ8InZ9RK1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLVkmXo7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso22702655e9.3;
        Wed, 19 Mar 2025 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402314; x=1743007114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Djbo8fuouyauVAeLDsn7IIUNSDZKc0p0zGGq1OIp7Iw=;
        b=kLVkmXo78TufBge4YuXcxQpliC2InCtwEosq/M/2cJHjIOI/vi8d25f5o/npMnPOVU
         8CTlzkh1TYbePXyPqsdSSris2UfWsax0PuelBVmuo1/BCMIbOaqlhE8BUN7lJfXAH1jg
         Doy0Gy84/0PwseifLqHvhi185vYfb+KbgvV9L0nzIq5NSpr6RHa3KUeVSHMU/XHHf2xc
         FD01+szUgyz8qpwqq+VN709lv4pvWYU4cOzTxp78e1+5jRN0W1TGm6O/SU4sCgFNaVfU
         CYN35AsfIxQCi6l44gOEUhS+JFHQwa9pbhZz6S3lv5AcELx40g8ZIPrT7cai/3EGQcqq
         VN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402314; x=1743007114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Djbo8fuouyauVAeLDsn7IIUNSDZKc0p0zGGq1OIp7Iw=;
        b=bGQZjyIugE28okCn7a5kavB9hmkqdp9wuMVkqCQ6duhkAYHhL9LFXf+qG0h9UrK3Nk
         dPCYzUl4BsNOHt2HknyAYHSn3VnysU6Fqnn6h/BtgSC2ozS5PMmMDcSLoKx9VRiO8pEa
         kIkghsm1WdIP6EW/I1wAaxGBffs44uO00CuA5FNc07kOz+Xn6ETyUY0zBQr99aKdaszB
         q8Ve5lT8kfcA9C/BAdk9VZDea3HLKKmL+t+zG3GhMfdU4GMrp3LmrRYwMWhtuz0L3XPD
         8VgFU9no6Km9nIer9ZsiDd15Qt2C8uFxEf/5rgifqwX/EeAKvjiqIKq2qMvIDZOwXvSw
         9C+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQgnld+LASU8S1fEdO9BaxnAVv6q+bY/fIyfsIf0Q2NvzEJFONwFk91s5zMHL6zI6h4IxTpSyDxix8wrd9@vger.kernel.org, AJvYcCWWLbc/hgB0Xhl77JQHMp+6YejogVuhP+kKnk7ocSRGqtdtP7TV/G3mR7Jn/mstK8qIxfHlG6GnK5Pzx7Kk@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9Ih8FtoriwUgTxOye9BlSIj4JD7OQJHby6zNJTjFvZKZo+xK
	sUc3oVTFnY3LHjnRxKgarvYvGl519nc/cGttegGgsQ5MhvNI/o3s
X-Gm-Gg: ASbGncvv2n4FcRnp4TIh3E4PNplvs5ddAKqnJvc1pufSFMYVcZNNzyw0lSrP5A1KllN
	WpI1BuiHIttvueP82EMiZ4u2Yc0mrYqX8ihdeJ+1XowmoY3MSgDOlwmt4BV+Q3lQRzT+CdY6McU
	wvG3KPx1tbWARGmGPxCDr2/RGO8Enn8ScgHx3CVWTexzNk8NZG4dgZL0G4dHdyamcXUCXLAXTkx
	aKwTalfpr+fDxYX/MS0ofLmlyk67NdFPxzYve7AA8Hx4sTt8uQKBidcXpLRkytHE+Esz9T0uTXZ
	Ziki03vZIu+eP1LRswIbqMSPCDqU8r/jjeJcJBN/vkzFkBXc0RkrNtRXc6EBDm8=
X-Google-Smtp-Source: AGHT+IFf3t34q24iVR2asvqI8ehFplt60wmlleLYVKyxEx4NNgIGBud+SHklIldadPZ/0YPk3GTGNg==
X-Received: by 2002:a05:600c:3556:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43d437c2dc4mr30611865e9.18.1742402313958;
        Wed, 19 Mar 2025 09:38:33 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47c97sm23327415e9.14.2025.03.19.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:38:33 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: reduce work in fdget_pos()
Date: Wed, 19 Mar 2025 17:38:25 +0100
Message-ID: <20250319163825.1847621-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. predict the file was found
2. explicitly compare the ref to "one", ignoring the dead zone

The latter arguably improves the behavior to begin with. Suppose the
count turned bad -- the previously used ref routine is going to check
for it and return 0, indicating the count does not necessitate taking
->f_pos_lock. But there very well may be several users.

i.e. not paying for special-casing the dead zone improves semantics.

Sizes are as follows (in bytes; gcc 13, x86-64):
stock:		316
likely(): 	296
likely()+ref:	278

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file.c                |  5 +++--
 include/linux/file_ref.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index ddefb5c80398..190463e61934 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1193,7 +1193,8 @@ struct fd fdget_raw(unsigned int fd)
 static inline bool file_needs_f_pos_lock(struct file *file)
 {
 	return (file->f_mode & FMODE_ATOMIC_POS) &&
-		(file_count(file) > 1 || file->f_op->iterate_shared);
+		(__file_ref_read_raw(&file->f_ref) != FILE_REF_ONEREF ||
+		file->f_op->iterate_shared);
 }
 
 bool file_seek_cur_needs_f_lock(struct file *file)
@@ -1211,7 +1212,7 @@ struct fd fdget_pos(unsigned int fd)
 	struct fd f = fdget(fd);
 	struct file *file = fd_file(f);
 
-	if (file && file_needs_f_pos_lock(file)) {
+	if (likely(file) && file_needs_f_pos_lock(file)) {
 		f.word |= FDPUT_POS_UNLOCK;
 		mutex_lock(&file->f_pos_lock);
 	}
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 6ef92d765a66..7db62fbc0500 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -208,4 +208,18 @@ static inline unsigned long file_ref_read(file_ref_t *ref)
 	return c >= FILE_REF_RELEASED ? 0 : c + 1;
 }
 
+/*
+ * __file_ref_read_raw - Return the value stored in ref->refcnt
+ * @ref: Pointer to the reference count
+ *
+ * Return: The raw value found in the counter
+ *
+ * A hack for file_needs_f_pos_lock(), you probably want to use
+ * file_ref_read() instead.
+ */
+static inline unsigned long __file_ref_read_raw(file_ref_t *ref)
+{
+	return atomic_long_read(&ref->refcnt);
+}
+
 #endif
-- 
2.43.0


