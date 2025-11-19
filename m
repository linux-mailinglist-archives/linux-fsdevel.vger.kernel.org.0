Return-Path: <linux-fsdevel+bounces-69079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F071C6DF2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C01084EF1F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29034A78C;
	Wed, 19 Nov 2025 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyaRjLLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5414280A5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547350; cv=none; b=ah4Zph7RuiiXcXfg17QhK5CZZ2y5NvM1E9zM4G5asZ3Da8sv8mEINzoQ+uKwO3cS+7+2mJsmpVGH97XksYAfzKpXnSOvuVYXOZqJsev55lNxeb+ZD0lw601JwP3LKKAy3YqEEInwMo5IBxUqGXzN0Plst13jgNm6d/xV4O6uJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547350; c=relaxed/simple;
	bh=NMoYGq1b5aH/K5Pc/pjAfQA579owKWyWVuLmcyqLrGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXURCsx7g4VecpTNbPwC6YPWHFA06XAoUT1ayzFoXFU8YyQuXVHxMZj6/HfWE/wQZHMN8iyJ/Rha8FxLESsvqcnZsKl73a+XryeH/xZPgWAfdnHD7nuwVqcE+B3UWuz0LjjgWmzMGfF4oY1nBSPgGP5U9fr4BgtvEwq+xLt6o2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyaRjLLu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297dd95ffe4so59091365ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763547347; x=1764152147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdyT6/rKB2qN03Hq5c8aipzbp7XNcNbuAc/SKRTozQc=;
        b=KyaRjLLuHjhIXj48WlDvEWQkMquX/2m2SD/QujlYer7yAbnh2ifUvbUbzAXkoZ8Zo6
         V/p6vU85h/8/j5Y1DssM+ny8OhUK/T91I7zDfjiVDqvJVn3F7ImppwZdPRoXKRLLDo5D
         TV3JVxnBxd/Ol17QpFyGg7OlpPTMA5ZroHyKCyskzZl4emsbGDN2gR+EiJtj7DiiKUPo
         H/dTJb2LKBmi5ctOWeUGqpvuek2EfTWswrESd821KyvPi90nFOYj2RmkoD2C6Hx6i6LV
         wWnS7pxGYywitOEMtfFJ/eq86bzhW+iRvwRifqBTZsuEl9tRVTnKtuDVrtd59Op4fhny
         /RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763547347; x=1764152147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdyT6/rKB2qN03Hq5c8aipzbp7XNcNbuAc/SKRTozQc=;
        b=Ofbh4r0nb7Gi6UceZ2zja3e+y25WjKxYFugf3q+tWlDpxHElsW6OV1KNHQ3MItIcTJ
         TmqY6DTFv9utW7H+TiRomXEA6cplvjemQyE8j0PIOwbkaTxvLLj972BxVkA4Lw/0B4MY
         5w7zspI/KcbCXxr9QusTXzx8HYKGWMEh/sIDH4vzOFpYLdLkM2lcPPpLbFOBoNGOB6+8
         cYfTsN+J2U1k9QpBIDX/CcLoaL0VdpLk+X+IITr0Gg1KdFewXtc9d/9Bt5Tj9CoRIPNt
         ZEOH6xmk0XQy+Q0fQDGmLaX9VNWowOxTYtwu+Q06NGTml/QQaXBmBCsmsPIJi8IfAaSf
         KcKA==
X-Gm-Message-State: AOJu0YxhrMcuNkAJ5xC9r9fBH8TDHDm7fLk6abT3vQtfaW4Z+dO9eA+O
	NzO7JcvuunNyTJquYVSfHPqHwCNPJnuHDENBFcuHoMUt6kPdeg/ELYvecliOOeAeqqg=
X-Gm-Gg: ASbGncve0AM/bsKSFvtykczHIOqN3d2HD6C2uBmdkQJN8dlad9ijiSyzfjJQCJ6/M0V
	U72D9eJ1HGlQER9jOFMW0REtkx52xX+81rphKOuziIYYXNMHq07CuxLYQ4z14gRz0Q87HwMyDr4
	miSTBJMsUtZ3R0e+p6VngOJ7RODvICxfhcxvodbzW+j6vtWWPiX10VrJNr/o6S5hfely9YysCAq
	Q+YuBdhvLJQO0/ASCEn5fAZnHJ07Au/yZ0nvaS6LoNGN7yl6qyW+oiAg+aFJk/scdRCJq2TEqjY
	w5lRSQrdX2vc6FajqrMR1aOnZjfgfgzDd5xctCqVJiw7Fhuh4T5KmRqpVb0a9ljFNiFNKsL3XaC
	8l0i6bhh6S4+3Z8tPqCzm/lMu9xeFR5ujw5KDZXvcfg+nqnJlTXXn0/j8KwTvf9/crez3/Q6fm6
	iQODFiCnYIbly3Ro4fh0HX2CFmY0pZSUjJ74rG44bhxF6icsVsvj+yO3YQKOCCeQ==
X-Google-Smtp-Source: AGHT+IHneH5yKNCIry8NMGup+JTksCsAmE9O2nHYCl6rNwgc+1aYwdv0MZCYSzfxh6oOvuG4JJAN4g==
X-Received: by 2002:a17:903:987:b0:268:cc5:5e4e with SMTP id d9443c01a7336-2986a6b5571mr257787345ad.1.1763547347143;
        Wed, 19 Nov 2025 02:15:47 -0800 (PST)
Received: from gmail.com (ec2-13-52-8-11.us-west-1.compute.amazonaws.com. [13.52.8.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm201815475ad.32.2025.11.19.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 02:15:46 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Wenkai Lin <linwenkai6@hisilicon.com>,
	Chenghai Huang <huangchenghai2@huawei.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] chardev: fix consistent error handling in cdev_device_add
Date: Wed, 19 Nov 2025 10:15:40 +0000
Message-Id: <20251119101540.106441-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently cdev_device_add has inconsistent error handling:

- If device_add fails, it calls cdev_del(cdev)
- If cdev_add fails, it only returns error without cleanup

This creates a problem because cdev_set_parent(cdev, &dev->kobj)
establishes a parent-child relationship.
When callers use cdev_del(cdev) to clean up after cdev_add failure,
it also decrements the dev's refcount due to the parent relationship,
causing refcount mismatch.

To unify error handling:
- Set cdev->kobj.parent = NULL first to break the parent relationship
- Then call cdev_del(cdev) for cleanup

This ensures that in both error paths,
the dev's refcount remains consistent and callers don't need
special handling for different failure scenarios.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 fs/char_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c9..fef6ee1aba66 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -549,8 +549,11 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
 		cdev_set_parent(cdev, &dev->kobj);
 
 		rc = cdev_add(cdev, dev->devt, 1);
-		if (rc)
+		if (rc) {
+			cdev->kobj.parent = NULL;
+			cdev_del(cdev);
 			return rc;
+		}
 	}
 
 	rc = device_add(dev);
-- 
2.25.1


