Return-Path: <linux-fsdevel+bounces-25588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82A094DB20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36C21C20A96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0814A4F1;
	Sat, 10 Aug 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOh1NUBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD191BC2F;
	Sat, 10 Aug 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723272489; cv=none; b=HJ742PmjzimuP26kRQAgG0Nm1YJRv0lcHq8kh0gRbgxF6KRioA1msnP7niJz1Y3IDc5+WQZZduWuffV7k0dNpAxUI490M5lML2sC/svOadzuDrRJe20TYmSEMU8R/IgdTLt+ouTPR4TOBy7P3BnD0Coej5W/cOpNzpJYC3gLWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723272489; c=relaxed/simple;
	bh=2aBKsvw/7eAmcVMx4np8T+QpRUtZjEaVBMKXT90GpqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlFtT//KJY34GzQqhHOtkKiQah/Sc2Bx18uIm54W2qgyijkuXyxvJPluIT+1gFEOqK6zIH/b7V85U/vwiMPbdJZ3Bg6PSwppnZtypiU0A8yxLGXmedjpa5bDaMEQZsG5NWQ3SCSo43S5xlcwg/7GI2Y8OCEwL1zE4jZDL9IdjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOh1NUBr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so3474487e87.2;
        Fri, 09 Aug 2024 23:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723272485; x=1723877285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YGVwGkYoOW2hmbgHFaX2pCkcnciPQPU19yUSzm3vxW0=;
        b=QOh1NUBroyCKWUy7QB6e4R5jWFRBqgjf3lw1ifWUPtX2wX/w66JmONUd5IGvVjS50/
         fGpF8kVnYJMAwgwCFH/6TfhmhUTB/7NqKPU8lwo8XuljgfBPbwSJRyJHGPh6mI/O0jX5
         htOh5agIjaDVd9AL31gXREZ4f6//vBjhP+wKSi+3I4sHl81/rzXS1V2ugejSuznI4Dnc
         cCTT31Zc8PSNoh6Uckq3hvxTopXTUcJAsAe9WAMVKWzE5jPndMmPH3iiITasy01C+PZA
         +zPc2MyAx5xcSJd1apcxC7AGIt/mI/7EIz6e7aSdHtQXGB8NWyj1OGJmoQUALROfHmMt
         5cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723272485; x=1723877285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGVwGkYoOW2hmbgHFaX2pCkcnciPQPU19yUSzm3vxW0=;
        b=jtJkZEFcIXLhR1s/ASVWE4bNLHHl4m5xtIRXxaQNgtZOczuZF0RgsO4aDYHmB3U+bF
         sSG+cFn43/VOq17rReFyReaAiHIIDv6JvkuEwQfpWdmhDmdZ3gIc9PqKzcClPiCPyTGc
         6eWh/LUkXXRVFuoBOQHCfAKRuEVLTLlcca0CM4mpr7LV3VcsfZmnOhkHlN9VGMmkcryA
         /IW2b+aIJS7Jf6EzIe31EvReaEuWEQkTku7Jjsas6LtYMwBOHwkIrfuECXSDyHR8Xnd/
         VU7qJDC89j/cl7MbQ4szjT1ChyF+oy+TKAHfJb9Xe+DMv0jAcxI20k4YJckRg6xyFefZ
         21bw==
X-Forwarded-Encrypted: i=1; AJvYcCX5/aaCi/FlvR3AWlifHWXswbmrWbxLbyWNEBm0CSGMR5YwwGceqBF85EjvAiZ6jnZJx96gBcAfHu7zTdqR0H0u7qZlSEUAekjZHhU5tKcnlopqi0VKL44MYtmq8E6YzJPMownM3DKsAzDUPw==
X-Gm-Message-State: AOJu0YwZSiW1LmHXok0L8jaVQGVzgZj7l4o/xZ8XkGuej1wQPhh9yq6g
	VCtMhfSVuP+PQi5QEEKb1ExsbjyDX0Ol940apsYZX8nF2qhXDMc3
X-Google-Smtp-Source: AGHT+IFhi/0+AjXCkvuFQ3UeKIULxACot3KpIrraSIu/4sbNCJJripap19DqStSqeLQq8SyBgPFLpg==
X-Received: by 2002:a05:6512:318c:b0:52c:8a12:3d3b with SMTP id 2adb3069b0e04-530eea064b6mr2381380e87.56.1723272485007;
        Fri, 09 Aug 2024 23:48:05 -0700 (PDT)
Received: from f.. (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd191a1ffesm374776a12.38.2024.08.09.23.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 23:48:04 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] vfs: only read fops once in fops_get/put
Date: Sat, 10 Aug 2024 08:47:53 +0200
Message-ID: <20240810064753.1211441-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_dentry_open() the usage is:
	f->f_op = fops_get(inode->i_fop);

In generated asm the compiler emits 2 reads from inode->i_fop instead of
just one.

This popped up due to false-sharing where loads from that offset end up
bouncing a cacheline during parallel open. While this is going to be fixed,
the spurious load does not need to be there.

This makes do_dentry_open() go down from 1177 to 1154 bytes.

fops_put() is patched to maintain some consistency.

No functional changes.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is the same as v1 except for the commit message, which on second
look might have failed to convey what's up.

That said please replace the patch, thanks and sorry for the churn :)

 include/linux/fs.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ef5ada9d5e33..87d191798454 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2565,10 +2565,17 @@ struct super_block *sget(struct file_system_type *type,
 struct super_block *sget_dev(struct fs_context *fc, dev_t dev);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
-#define fops_get(fops) \
-	(((fops) && try_module_get((fops)->owner) ? (fops) : NULL))
-#define fops_put(fops) \
-	do { if (fops) module_put((fops)->owner); } while(0)
+#define fops_get(fops) ({						\
+	const struct file_operations *_fops = (fops);			\
+	(((_fops) && try_module_get((_fops)->owner) ? (_fops) : NULL));	\
+})
+
+#define fops_put(fops) ({						\
+	const struct file_operations *_fops = (fops);			\
+	if (_fops)							\
+		module_put((_fops)->owner);				\
+})
+
 /*
  * This one is to be used *ONLY* from ->open() instances.
  * fops must be non-NULL, pinned down *and* module dependencies
-- 
2.43.0


