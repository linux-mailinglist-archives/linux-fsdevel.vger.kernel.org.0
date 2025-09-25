Return-Path: <linux-fsdevel+bounces-62794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D0BA10A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430CF16C6AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD06B319870;
	Thu, 25 Sep 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXlqdPbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D71DE3DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825258; cv=none; b=Row287JLnIQrEM1eIgmBRkYvolFLPoQPcP0K5YnQsHzwp74CHV2EZzTozH8+KDyZu2Ocyn+sl3IQInhBVraHKjGTJPvuxCcSVAAfdGdGNLJN/UV+T6oYfT8M6royj31l65Q9N7VPhPABM8fRzMCQ6Yr2KwgRE4kSDkiKgjwaAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825258; c=relaxed/simple;
	bh=JGHZrqgsD5J4CJLVG5NDT/BTeuoYzKzKiot4EVjX9nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q95fJV0ibfMQKBllRnN3QU0qyIN9G0lvWzzzl8kjQfKJsWDwqJNLZpXn0Y1W+yxvr6tdBuvG7oyNm4a6rCd5xE5o66IZ2kYlrAhqxm5TkKe75jd4Oh74Dpt7JjFK/jJoqoTMlNE0LKDNzYNoXjXUmStgykGpBuPngCCr2EbbVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXlqdPbp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1469399b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825256; x=1759430056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIZgUWWK2/+OTsmqvPYHxQA3Q/mAgPoCO17vfpeF/XA=;
        b=cXlqdPbpWwxUbnW1U6TXemLga13l8lNcrijkCqxAH3SHmFuZbCa1PY4gg5nvgDdW2+
         u4lQy6Ab/P7SAhBDybF9r+9h1fX+L4VlBJU7ljt/1q91/qpfvah0I5zeAwUgA/Zm8Slz
         iquFdaYijZ9gaqsowUiQDHSkAfXdWPbZW86VX4AALRnWxr2DZxU58FIz/Mn/5C92nEel
         zO0M49y4MlBqVBt97OvtSKCa1DMLxb4PsC2+o1vL3KFpNT3JG49FGDWUpY7tMzFkLjPX
         Q1lYmZa1OlV0t+xBm/05RO1g4UyBxCUZtp8WV67niNiS0WFLLaZ/bmEvNI7b/8MMiy70
         45eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825256; x=1759430056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIZgUWWK2/+OTsmqvPYHxQA3Q/mAgPoCO17vfpeF/XA=;
        b=KLvQD0kZdE15gvLMHUsKH6wXj3+EzWXiwAJvTQ6ZqG9+SeTXVTS+kNxcUwSb59xckw
         xEWOhxsBHWTgi17TdUJTEsjX85FpokVoQSKxAxKaHyiKhkzpHgkpGtXyhVKsHulA6NJj
         x78rxUFMr3lfTG017KOUjF596dz1APsYLI7yLA60h/4hV21rSPDLH3QqN+GVD9uSQ83K
         Hw42hM6cn1bqPJ+81qYA7IG2edleyAu6/pJBqJTp5g4+eUzEJp6XCmCKl+4diIrOvgNQ
         EcYSh/QoAq2hlfKtHDTcMoOvwYRhwk017wn0SzNBvBFerhX0IsED0XVWtTw49m1iHyak
         q/xA==
X-Gm-Message-State: AOJu0Yx+qtECoxuNAReTkTkar37k3vBcmMBky3N2C1KkSf0VpJJQnVSJ
	tx3+qiz78ATy7vcmhaFpXZnvu8ZATKBaZqhZ7Xbav1f/N9bQlGUvatxd
X-Gm-Gg: ASbGncvAdYg++kIIeG9KMC3q4Wo5W1k04OVnox0Gzp+Ufi+ebLGwOCpJylS6Uj3ozxz
	1BrAa1yuzSlbMWqaxJy+LqfzJTM5FEvVmXnnvT9RDwvF4pBkxXHiGzceOa2ypmp4rxh8Xb3IIBL
	71XdqO10g1T767ImihfAU0eE5YjafQnFoVQqhPcJ4rGoE2HY1oxn5/AYawVgi+/M7hf4GuUCoVI
	DHHgFmYgoBQ9PL998he/Dl6tBH8qWP82bNiYNDnOcuEfgucQ41Hfn0kNAhp88J4zQcRmoOtb7MQ
	UKvpLv22X85YDydIteibhvO9qbdZy8L4fUyy2L2MXANMT34qejUI7jR2bmsMYCiinlK9fUoHT7G
	71MkkLafy3opMOv+v
X-Google-Smtp-Source: AGHT+IHHYSwSIeNgN2Z5FkEyASxN2mHA6/OjU1mDcQRCjwoBLNrGDE3PH+MTLcAMf7T/q1LbVb3PlQ==
X-Received: by 2002:a17:903:278e:b0:269:b2a5:8827 with SMTP id d9443c01a7336-27ed4a3ebf5mr38909075ad.16.1758825256102;
        Thu, 25 Sep 2025 11:34:16 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab67a9sm30798765ad.131.2025.09.25.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:34:15 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] exfat: fix unhandled utf8 flag while reconfigure
Date: Fri, 26 Sep 2025 03:33:52 +0900
Message-ID: <20250925183352.691557-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 fs/exfat/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e1cffa46eb73..0e3f33a26005 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -757,6 +757,11 @@ static int exfat_reconfigure(struct fs_context *fc)
 	if (new_opts->allow_utime == (unsigned short)-1)
 		new_opts->allow_utime = ~new_opts->fs_dmask & 0022;
 
+	if (!strcmp(new_opts->iocharset, "utf8"))
+		new_opts->utf8 = 1;
+	else
+		new_opts->utf8 = 0;
+
 	/*
 	 * Since the old settings of these mount options are cached in
 	 * inodes or dentries, they cannot be modified dynamically.
-- 
2.43.0


