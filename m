Return-Path: <linux-fsdevel+bounces-46598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD7A90E82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE1445057
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684F2376E2;
	Wed, 16 Apr 2025 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZxCGv7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427122F155;
	Wed, 16 Apr 2025 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841808; cv=none; b=mGhvWtbcp1rxNX+5cCYkbnhIqiTGqGZRGQT+mNYWmB7AjSfj4AEmYr8h9ZLd/1cfAJdpkrSQgyM4MB71NSDYDh6n7uJ5EIPLELUk5XQHEMgNXMdcBSMNhvf83SURN5K2EA6k8+jJQ/doDLX0/GgV2LoWx0YCPOR7nlyGnDMBqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841808; c=relaxed/simple;
	bh=FwTNfiHfbC0HDRHheElNAKV8Nx2RW5/zWcdr9BsdPOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Og42KM1pzGERn4ECbP23tEqdzI3WGhX7XLMk5PG/tNkEX/yPZw11xl0vvJZxBUL08QE6ovfa4I/6iQSxcN08CM+irT0FUgkc11ei+O3lM006TNylHL26DyyPfX5Sig+Elyo6YsUri5pG0Kqk6Qlf+DPjcfp9imAUtSKMstOp/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZxCGv7z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2aeada833so37404566b.0;
        Wed, 16 Apr 2025 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744841804; x=1745446604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLh1QFCNqwVf3EiNnVoF4ICoDFZXITHIKSThtmpBrk0=;
        b=gZxCGv7zwTKjIBCm9/24Q/+YWegGmsVcnO+wwe6H0/WYewnHEefdGE9PilYa8olfBt
         0PhO+WGBT64DGPljVBvZlgy4LMTDulxKQaED6iRD+CzdCyIhz9PWDhlBjb1XbTD+JJ6b
         TbaXQePOYtPbnSi9DJurQCOzmBF/iwHkPYAJoi8DoJPNhkQP5emwxqX5xQ/nKqLXovlW
         MhwQljLjH4K27WAKSR4b4c22aAdagWd+mJbVmS5aDook6ixnRs5yvGNZ6xAe/Ae8CwXb
         /ATB3zFGflZ//88gaGPfdnKzsLWEC0mtcXIpPUEjVQ48wRgRq6c6FKP0YqQ2nRsaDkFr
         pnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841804; x=1745446604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLh1QFCNqwVf3EiNnVoF4ICoDFZXITHIKSThtmpBrk0=;
        b=xPUWfYlFpp2Fy/vEcDyc5MxPGnxV7xzHQD7aUo+CyH59XdnXvmBKz1fxngYPujmd8y
         BqbSRSu3/OEiX22C+NPfyTWXEuC8eSt5Bzeda90ByuokUiACNfFU950Z1jO4WtTfuv7S
         Ypyp3rA7YiWYXBPb8pqRrDwwfvX8Hzr1pivcyP+fuuGGHxq1HADs/wjWm1LQrU8/erxw
         2TlntccdoE4lOksXpUXaqt6tA4CTcm3mgKsEwOkJELsiKTI/KXqSno2NXjUHkxtqjJlL
         Y5taLYeijnjJ5j4p05bBwsz8rcohmpsiSt3GKeIBZVpuRNnGW46YU0sMNbKyZ9J6gvnK
         axxw==
X-Forwarded-Encrypted: i=1; AJvYcCVZakOAGnQ7wLhRrINxXHXVZ5ZBkR22envclPAHA0tUANS5s5N+OqgDmY66SEhDLSvjlBx8ZP7KeUSBqtK5@vger.kernel.org, AJvYcCXi36ic3HUU4jA4iMVicklRmDoKe24bSxgz62Pbz8LTT+eNwK3TSj3VH6EIoqmQhFNGwCgLKnAFc1mvibNR@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhBscLeLdZ+/JdPUpusL94UAY/BwzlTnGgsTcTTgZEt1g8jHb
	iw3l5GQLkQ6II3AHC5YllINs2QsbuktjWIqE6k0+a9B/f6ScEHDY
X-Gm-Gg: ASbGncu4fAphy0ihFjpl8t+Sp5NNfjzPJVAH80kVsZYVII6kzAZbvr1aSEbR1WtGLcL
	U0ZwfBvIDyD20Ei5ENrDvz+RCcPweKnpcOUFq0Iq/G3AywyHkdz6i1TQbqG8y/1+RHb+h8RXjw6
	Q43fvOw58oTMSBFg86oRC3ukgkjuK1NtICvyPpolDLmTRgTl/0BW5NYDQDcfMSpcnkDpZo1tvn5
	lowep53WdMebpYJjsTJsGOEi6mrVdaM0UT0/zlQRop18FaE/YBNm2IObKrCsDmE5qA6/4shQEbQ
	sxDF+dce3uWSJAbV4ZRlL8uvi2MLWzWU1W34xhGQS7K+3DIjLDrqmiN4SGo=
X-Google-Smtp-Source: AGHT+IGp5Y0TA+wbDYpWlyUIGWyykJW/C67dTsFEMK8J4FVpnrAZa3NAGUAnXz0hsiwufnM2anl4Ng==
X-Received: by 2002:a17:907:7da0:b0:ac1:ecb0:ca98 with SMTP id a640c23a62f3a-acb5a6d17d2mr36543666b.26.1744841804312;
        Wed, 16 Apr 2025 15:16:44 -0700 (PDT)
Received: from f.. (cst-prg-69-142.cust.vodafone.cz. [46.135.69.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128c9esm194762866b.108.2025.04.16.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:16:43 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] device_cgroup: avoid access to ->i_rdev in the common case in devcgroup_inode_permission()
Date: Thu, 17 Apr 2025 00:16:26 +0200
Message-ID: <20250416221626.2710239-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416221626.2710239-1-mjguzik@gmail.com>
References: <20250416221626.2710239-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine gets called for every path component during lookup.
->i_mode is going to be cached on account of permission checks, while
->i_rdev is an area which is most likely cache-cold.

gcc 14.2 is kind enough to emit one branch:
	movzwl (%rbx),%eax
	mov    %eax,%edx
	and    $0xb000,%dx
	cmp    $0x2000,%dx
	je     11bc <inode_permission+0xec>

This patch is lazy in that I don't know if the ->i_rdev branch makes
any sense with the newly added mode check upfront. I am not changing any
semantics here though.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/device_cgroup.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index d02f32b7514e..0864773a57e8 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -18,15 +18,16 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 {
 	short type, access = 0;
 
+	if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
+		return 0;
+
 	if (likely(!inode->i_rdev))
 		return 0;
 
 	if (S_ISBLK(inode->i_mode))
 		type = DEVCG_DEV_BLOCK;
-	else if (S_ISCHR(inode->i_mode))
+	else /* S_ISCHR by the test above */
 		type = DEVCG_DEV_CHAR;
-	else
-		return 0;
 
 	if (mask & MAY_WRITE)
 		access |= DEVCG_ACC_WRITE;
-- 
2.48.1


