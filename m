Return-Path: <linux-fsdevel+bounces-64130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB38BD9829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 349574FFC10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430373148B6;
	Tue, 14 Oct 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UolIS9Rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E0313540
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446939; cv=none; b=TVaPp8iyIS9qX/7QseW4nqNR6hOEg43NqJ6YdYHUD+7N7ZaenfBLtPgXu36xg9vEuZp1OmcpwWMLbtIu9TQGdG9UgfW+ZUMjBLdIyUHB9AQcm9qYZScQ7nAp63uW0BiNtmxQlo4PZDnZ1UYWnjWVjZxnP1WCnkM4rg27GbtDRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446939; c=relaxed/simple;
	bh=XGY7u+lqhb/sqJLYAZEut8PFrDzJJEOreAKW851JRMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uAZ/FbhdMpc/rTI8E/W/Ds2JLr2Hk9k3K1mQe4yGFaBa5JLjznwxfZANZ/9kImmAwgJ+5y2IHnARKyrUfOZzx5AVU33k+CZGuwLb6ClIuWbd4foKR+vtCKt46+fOKPI+YrWM7ddC7r44MbAFY7DhGOxXbMNRxfKJUGS/uqI0XEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UolIS9Rl; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7811a02316bso3712152b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760446937; x=1761051737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vUG8NnvzxTzuqf3xDOLZ/nhw7UAeONEASLUMUFNz60=;
        b=UolIS9RlZ/Uh0SCZ0OeXi4AqrVUxKgDRf5bzfBm7wVI9slyUihPbfYEvqHaZiBUX7b
         TVEx1HFvvgkmlEpCPnXzzaTfQ/2Yt3YOPBZSA3FPNhuls/5S09Aq3EH4JFIpadx9KpMG
         xtxcD4ZlK35cXn0nozTaOzDx5PEa4/Mawho54BoO6OjX0MAK3Q1bDiIfFFUbxezEGX2B
         gqj9/sdseiJLmL7GZ1aUzQxwKd8ZXUr/p8cBm6TgkjDWHfUGdbVM6Kr0JHB4qrhq3NoH
         8ZPdSeQzLVm4itHRlHrbSC+nJ1s41e9tZ9cXRZ0hH2blJBZcs0IqHEuwlcvOJtG6zBim
         0RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446937; x=1761051737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vUG8NnvzxTzuqf3xDOLZ/nhw7UAeONEASLUMUFNz60=;
        b=Yue19MllTNAvEW3bGlLTrfyj1GnyvZ4eQqUDIWqzMAyo3gDxf1Ukxp5R2vWxZ9YyMs
         rNw/ikIgn9pPgUEdv0RKC40aBxwnZwf2H7k8bgcste6PFigUXNIIBtpp4/YBsRuHoKgx
         mg8O2UWxF1sMhLjv51K5A2DTffZDE9lMIbGBjrETx7eFRdc/C4jM8r1hYqRFXcACQAgx
         zWGfZ74/7+RiUC+87AquGgo2w4z5SJcm66Zl8WZKTCKWhiWo6cr8w3licbBVCq/M6mlw
         JGU/y/mYYC+M5yIWTnfhPeHiyvZ+B5BN9jquqMlWt2kpOVn3r+Dz8MRcdMB2a8klQ2Hm
         B61g==
X-Gm-Message-State: AOJu0YzTPKSDpuFJQ1p1HPl2Qwi2h48ePoGMxVemHD1uR3EncYbXgGPZ
	sLsrFvwZByb+K75jiOVXU6+L9AXxnG03OVMzZTcFPRiVWb9AUobw24Dmbm4nDGAf
X-Gm-Gg: ASbGncs96J/n/Cp8BJGaAbQOUs29LTIsVr7gEf4o8qf+471uup1ezGbNrpQ9GhWe5E6
	ECoEC8gG+SSa+8VOxNiZN4TGAbzTMkMsV2/utd+HcXEtztLOtPOabYg38/WbWw745n6XFKDCfjN
	J63I/h5ZSARKJYMHRXbOkP8PDTO2veKdggZFZ+oo7C7g6/2JPKmeAC6LFw9n8aKIjEmU6uaMomv
	YdJd31XQ9awOldn3TsH+L/K2+TVCt33rlhL/JlahHVyQ+dRskuoigBJhcsg4TwD9KtA+F1ywtvF
	hsQ9HSet5DHHpuKGqedAP1R19jz5mElYcx0+vb2iLkVUBsWEoxRJIHDjEQate1twWbZa653te4p
	ke1Xlo/kXx0IE9CnfDYmGL3sx7kUSMKLYORUI
X-Google-Smtp-Source: AGHT+IF4gyFwIQTa6KYBIdWHVozU4jIMjBZx4vqsFvot1tX3tYw5PWnT47+yK/5qpppovCPchU7vng==
X-Received: by 2002:a05:6a00:1894:b0:776:130f:e1a1 with SMTP id d2e1a72fcca58-79385709579mr28317674b3a.5.1760446937136;
        Tue, 14 Oct 2025 06:02:17 -0700 (PDT)
Received: from OSVS.. ([183.101.168.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dc86a93sm15012439b3a.75.2025.10.14.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:02:15 -0700 (PDT)
From: Jaehun Gou <p22gone@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaehun Gou <p22gone@gmail.com>,
	Seunghun Han <kkamagui@gmail.com>,
	Jihoon Kwon <jimmyxyz010315@gmail.com>
Subject: [PATCH] fs: exfat: fix improper check of dentry.stream.valid_size
Date: Tue, 14 Oct 2025 22:01:46 +0900
Message-ID: <20251014130146.3948175-1-p22gone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We found an infinite loop bug in the exFAT file system that can lead to a
Denial-of-Service (DoS) condition. When a dentry in an exFAT filesystem is
malformed, the following system calls — SYS_openat, SYS_ftruncate, and
SYS_pwrite64 — can cause the kernel to hang.

Root cause analysis shows that the size validation code in exfat_find()
does not check whether dentry.stream.valid_size is negative. As a result,
the system calls mentioned above can succeed and eventually trigger the DoS
issue.

This patch adds a check for negative dentry.stream.valid_size to prevent
this vulnerability.

Co-developed-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Co-developed-by: Jihoon Kwon <jimmyxyz010315@gmail.com>
Signed-off-by: Jihoon Kwon <jimmyxyz010315@gmail.com>
Signed-off-by: Jaehun Gou <p22gone@gmail.com>
---
 fs/exfat/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 7eb9c67fd35f..2364b49f050a 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -642,10 +642,14 @@ static int exfat_find(struct inode *dir, const struct qstr *qname,
 
 	info->type = exfat_get_entry_type(ep);
 	info->attr = le16_to_cpu(ep->dentry.file.attr);
-	info->size = le64_to_cpu(ep2->dentry.stream.valid_size);
 	info->valid_size = le64_to_cpu(ep2->dentry.stream.valid_size);
 	info->size = le64_to_cpu(ep2->dentry.stream.size);
 
+	if (info->valid_size < 0) {
+		exfat_fs_error(sb, "data valid size is invalid(%lld)", info->valid_size);
+		return -EIO;
+	}
+
 	if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used_clusters)) {
 		exfat_fs_error(sb, "data size is invalid(%lld)", info->size);
 		return -EIO;
-- 
2.43.0


