Return-Path: <linux-fsdevel+bounces-46645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD4A92D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C0C3BE89F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1321A458;
	Thu, 17 Apr 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="gIu+oA2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B587F20FAA4
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Apr 2025 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929390; cv=none; b=hsqJScEy8A0UUE3QtvDvwVfeuVm4ZJv7sehv4oTxldU1jpA/hQzdgW15PUc0hZ0zUGb2HE/g4NvClLPooMyba6SSk/gdr1BmN+Qpj1UtBSwtP7O6tT9C7maTM+w5caoKJiXg+hcNdjDrmGTyLyTUCNuSepsERlDoKUC+bKju0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929390; c=relaxed/simple;
	bh=VpwrkXiAZX4MKlWOQYsQwdNbtcHHKMCeVfeOKaPRVzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eyrJls9ho2aSu0KhDpvamravgSXIF+kAlXxd+feWD4UfBDkP0BvA/zEegoyE69+eE00RtySX8ZQ5VMBDM7JavDnNbjRKz5feJUKgoeg8Ca1AQa8TRcanEL+4LQ8e3ZpocaI88ijZ0N1Muh7pDJOtfeGV6LsM0P9wdueAlS7vqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=gIu+oA2I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2295d78b45cso22604775ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Apr 2025 15:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1744929387; x=1745534187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gATUdrY0YUPgHBAdvSA39vTeHox2hGlpCUFV0ZghK1w=;
        b=gIu+oA2I8e4KidoLNUeWI6rJKW0FRYp/hDsBnuEwXZ9Ksip3ELYWcFJS+ql+tDIvPd
         7BiPaxGc5IwpTiA0k5JkpqhVYVS0ElsV6vDHWjomvA3LGGMfQabGnP7oZZaGvUyonHPr
         jvHfikKKwT7YgpaUTmLuQBWehZRURlyZgwSigZWmoBSKnPsJqdCBg97gwDROFBW1zkrH
         Ap+II/6A0LCkeVskc8Q4RW8syxdfeCzn3xHK2wiI3bCJJpTwtwTmsVf699bBlOFSwK+m
         UFTPdOKEKBW5QOKD+ENEykR//vtFfn09QpJMzKo9MJKnvqwFZ2pn8UairlKIOz7jlSp7
         kEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744929387; x=1745534187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gATUdrY0YUPgHBAdvSA39vTeHox2hGlpCUFV0ZghK1w=;
        b=mwt+c5IP7Ksm74kRby7rF8UK2oDauXVGZpzAayuhOvBvHrVZgbMOJCEomrvcobkRX3
         E0F4Vb5fkLe89xpZA1EO/3yqqV3b4hRWJu/e8Vvx6GcaCiQBUom5j5oumhRdAT1m401b
         MQHtURYRd3b0CCCSIUO70L7Y9m4P1W0ExAiMeT1ApCCqdMs5GbsL/lEI08XPFoD5DlrR
         08oIDHmhlskJ9L2lQItMp1ytYDAgGw2dr6cHWZgpLNmpqGHLWEheFt0U5QBiNeEWElGA
         R8iKgd0xjOuvQEMdWjzE5zyIt/GENfrDikr1Tp9KQ1Ytv9qGVh8pLwoUVeGkLBUC5hRp
         it2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxzJxETkz43cBr/25Xyze/Sb+Kz8aetod68DKVQ3YH5rPraJnrFNr5B/3R9Y6BgIYsp4eI3K041ZM3j91P@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOsPtwb6taurGGgq/J39Y8AxUIaBAa4xVVpx2keHcI9g/AoxF
	XhaKmMpdJHs9YCRmgvDHZCFvCm3QL/AlKtoCeN8zcQ2fd6mFWoOStNfPjAyWbKY=
X-Gm-Gg: ASbGnctDhm4cIn1WaEeL71OHu3ta1KVVXeR9tElCtRkVjVBWzVLFA6kcLqhpLe/2uTp
	94sm5Di55lLvtlMMwwbYbyUm3PUn0XWDtMmEzVWgYqJ41Viha4mLRB0deQW28n8pu7v87K7NTbZ
	2HFsXFf36aK1xq9ppHJtRhlk5deXi+nZ2+lrTQ8JodPwDCTkN3kzjVLirFPlZmNM8FsuQZdLe7f
	6VPbv9qnZ/LH3oE+x1OoM3j/QhJ2rlSMgjb/RfDc1Rqhj9JWDy/QrKmNOYuzEzmmTe02Vq8vbSN
	xXYq/ZX1kjOTAFPJrDdcLCce9d/TyTjfu5qmlu3PKH0fgeJspLqC
X-Google-Smtp-Source: AGHT+IGC46B0miyvCSa2FdgnvgXQX7iY+ZVnijj3FQnGNTE6kX953PJYm8Ohx0W9IXTyjdPT31Rpow==
X-Received: by 2002:a17:902:e747:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-22c5361bd3fmr8266105ad.49.1744929386746;
        Thu, 17 Apr 2025 15:36:26 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:b516:590e:a54b:461a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4622sm5265265ad.108.2025.04.17.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:36:25 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	brauner@kernel.org,
	dsterba@suse.cz,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	jack@suse.com,
	viro@zeniv.linux.org.uk,
	josef@toxicpanda.com,
	sandeen@redhat.com,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH] MAINTAINERS: add HFS/HFS+ maintainers
Date: Thu, 17 Apr 2025 15:35:07 -0700
Message-Id: <20250417223507.1097186-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the hfs and hfsplus filesystem have been orphaned since at least
2014, i.e., over 10 years. However, HFS/HFS+ driver needs to stay
for Debian Ports as otherwise we won't be able to boot PowerMacs
using GRUB because GRUB won't be usable anymore on PowerMacs with
HFS/HFS+ being removed from the kernel.

This patch proposes to add Viacheslav Dubeyko and
John Paul Adrian Glaubitz as maintainers of HFS/HFS+ driver.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 MAINTAINERS | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7d796131a8..1f63cf0175a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10456,14 +10456,18 @@ S:	Supported
 F:	drivers/infiniband/hw/hfi1
 
 HFS FILESYSTEM
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
+M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-fsdevel@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/filesystems/hfs.rst
 F:	fs/hfs/
 
 HFSPLUS FILESYSTEM
+M:	Viacheslav Dubeyko <slava@dubeyko.com>
+M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 L:	linux-fsdevel@vger.kernel.org
-S:	Orphan
+S:	Maintained
 F:	Documentation/filesystems/hfsplus.rst
 F:	fs/hfsplus/
 
-- 
2.34.1


