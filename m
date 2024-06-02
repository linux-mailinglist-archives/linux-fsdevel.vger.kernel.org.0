Return-Path: <linux-fsdevel+bounces-20716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087138D72F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 02:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C3D281D23
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 00:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35439EBE;
	Sun,  2 Jun 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kkTBybNl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BDD7FB
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717289333; cv=none; b=TjNkTLc8rQcFdrxv0Nu1MEtl15hoViL2CrXlItOka3+UgPOJvBwDME/QMXC+PEqBqf/n6jLIox+gpg8g/pSCx7grdCbH/0r6r2Iw/r6066VUX/ZPF/fb4VW58Xsag2lX2jG+Gxl6XCtP+utlVGcVPhgfgRGs1R4cmd1LaR4dNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717289333; c=relaxed/simple;
	bh=skOTCWiBMUfrNgI6qG58lDhMbfiUCYWh4Bm0Ml6LB0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tE9HtcyYdKAnMpwv15b2xF4rw7t2jELz21LiNBY7LYjHWrlihVbPC/zIRWA/K/3YUF0TknpkeB0Vj5nSf6YPmbDb1j+13AikByT2BwqbrZsqijLP8/BPcrQKIyTEohmR4uj+QtT7SZyjsi+kPcniTBnYaLcrvjQDDAe/2olwCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kkTBybNl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4213485697fso9009725e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jun 2024 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717289330; x=1717894130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pfkDORkKu6jOLuT/dVRcuRsTdgtIlnoR0tgHKA6YVY=;
        b=kkTBybNlS2F+EP/77m/rfdWPv3+Wn5a0s9vv8aQ6Wejf9zUsSxmWnndXhkaMvEteUt
         EQBfTBxOCDQ8daT0OJrRi+Nj8aJwRL7GJweT4LvKj6jMl0xv4o2i8aXXlNtrBd2HjxM2
         DmSLkWRqY0uW9XMceL7FMAbamt0eQPzb1HIYQJXD7r07UNPZcomyR0OvI1WjyZmPQb7K
         WgrX9Sp5MRs0c2E+dOoERk7GypierK0Zn68HFdXrO9Z0OYXGQSAE9zMTldoctQZ5sXtt
         UWtaNx0xnZ4I/W1gUujEcrn0s9M9A4+4CTcubCKdmfLqg65CSiFgiJ4INVzJbrAQE0nO
         KhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717289330; x=1717894130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pfkDORkKu6jOLuT/dVRcuRsTdgtIlnoR0tgHKA6YVY=;
        b=d50Ry4gCnq2jvUZjpbiJdnbkTX0I3Y2rZPaKbiQYfo1r4obnJIhCdcaJfmaW6skobU
         wa/y+xTV/vOukvCNppVr/vA0ftzJc8sBGflFi9oN17SyLstU3Rb+UMxvlZyz93A3AgOe
         2PaaqsKCENOhASIlxbyYg6JqVxbUgIa3yGIQhBuq6O08WsSMFhaWbiQrqYs+/iCNHuyx
         wwOBtO54inSQmKtRPFI9xANbeDOepOfKzkMhQqw9sUS6HHlU9Q6Et5LAlwUGGCp9Hg0g
         INOFNxyzYRZ0HQRvQUoogT5tXP6sgREBz1mu3ah3TfKpot6T9muk7/8FuBqwH1nRW9p2
         JrDg==
X-Gm-Message-State: AOJu0Yw5Cf9OOFRqHVVYKMzlVjKJ2Jl//HA+pjtnMVEO7zkO/1nNXKh1
	pC2xWlSVYfs27SG5AsEAHKkZBacGnmalRl+fqTZCoBYYUt/FeMwc9DAEttTr1Ys=
X-Google-Smtp-Source: AGHT+IG79CWnJbldIODO5br9IMw9VNhoYy/YZNA0SJFYF5/X35KGpMHC0WV8Yb69QFDB+3kmZ7T6UA==
X-Received: by 2002:a05:600c:34d2:b0:420:177f:c2a6 with SMTP id 5b1f17b1804b1-4212e049938mr52672555e9.10.1717289330220;
        Sat, 01 Jun 2024 17:48:50 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-96.dynamic.mnet-online.de. [82.135.80.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e56669a23sm67304f8f.83.2024.06.01.17.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 17:48:49 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] readdir: Add missing quote in macro comment
Date: Sun,  2 Jun 2024 02:47:30 +0200
Message-ID: <20240602004729.229634-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing double quote in the unsafe_copy_dirent_name() macro
comment.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/readdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 278bc0254732..5045e32f1cb6 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -72,7 +72,7 @@ int wrap_directory_iterator(struct file *file,
 EXPORT_SYMBOL(wrap_directory_iterator);
 
 /*
- * Note the "unsafe_put_user() semantics: we goto a
+ * Note the "unsafe_put_user()" semantics: we goto a
  * label for errors.
  */
 #define unsafe_copy_dirent_name(_dst, _src, _len, label) do {	\
-- 
2.45.1


