Return-Path: <linux-fsdevel+bounces-72175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD885CE6CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0828F305844B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671131A7FF;
	Mon, 29 Dec 2025 12:49:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0931A7E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767012580; cv=none; b=PQcZOa8oyVL3X5x8gDa7L4GOWJZdHY/2IoeQ7PmlKwG6SJxf6+zZVmpfy4YPWDbnN/C63VQFI9Q5E8JeYsvUNr3QgYozLJk/vMUqzYA2npZgrI1EEfoIFxAgDEVa51jT3T8Wtm9ro9wK08UiJU1A0Dubc0v9Fuvgb+zpImf5imc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767012580; c=relaxed/simple;
	bh=WbFJrbRBoJyHWpytKp1fUuTXgxtIE+WhTHXCWj6uSeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbxukcCIaC33U6Z5jHl6bVlNHQPZYDVc7qF+rOXE6mmnXuzY08Xizt/PSTeEA0CzlOKw+vJdIpULRnvoG5KwkdlGoNZbOoPNuY6pEdPV5JFXasBckm1mC4+S3ccrR//bCsXsoehsCAxVqWKCJwajCG+yzxX7Pj+W9SQPglXnM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso7591796137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 04:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767012577; x=1767617377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSDzJ1on7IXtc7FdawhZo2ycnH6jAqif4XQVPGYGWjc=;
        b=ie0+biAty5GIU8loHGFKcss0ypU/X+9qQCbYwyqplS+zpokF8GWpPhFHPJFqo+270s
         RC3MGsmUVKlouiC6PPdLUSX9V/TmtsEDvdw104qj5ZUfkZvg8ODH4HDvmoXlt5uwQ4aY
         lzEQHBjLlcmytzrzzQFwAXZedozhvycYhS5fj+PMsehSxbPeB3jwGfOHS+5HqtBDsbyo
         rXnh4Qz7m7twSdcLg/vsioIwg9f/+hmVcbJhUXLA5K/x42JLC5IG7QCeNOykDUvyRAV/
         RKh5bfXCQRtztHmtvsP+fpzQP4NH6MDICLbAnwD0+j0BAJFfAIK/2o8j10H3uREGAD/2
         RaBw==
X-Gm-Message-State: AOJu0YxCWRwxXI5sbjhxoHVZ3RkgY0AcbhPyVkUJn9TXbO5Pf5IGwOTI
	7tv43yZ6Ea+NrUt+hG1mHYvWRQFxbBQ6V45TgP89KhzCDfmGL9SnKdaB8Q9YLg==
X-Gm-Gg: AY/fxX4MecX+8X9KBxLEn4W5AmfW+gbFsbyvWSKEmhuunP3xRHI68Lsyeu2xacBavcv
	2nzQGSXTOI2e92pIBAIqHAkSeeaoIujZztLmJQ800DOKeGNz5jcdB5aL1Kq3CQPWl9e7/5rBRt0
	pWGy5imGzcMcvJq2rpUw1u/Dl1W2pIpe+2Za2j0AoYLn5wI0BPkKRivbOxOVhqBitSLNyW/fl6z
	xZPV7xxludf1lCbLketzrhlbmc4tlQM/eFOx8h6ugvk0nsvCR1SFJ4Xb1XwyUmhdvtI7Z+C0SwI
	QoAi875TMw+Y1d8I7QL/GTzXERyCqAcMbuJfAYuwEhn8lMaNJecwriN+JuJHds2ReXux6hfEpVW
	n6m2gSuXmzZ9tVPLaQJAphPZ1QRy5l2GIeOIy1ZoYEuFj9KMxmCeHOOXZLpI4qPYO9i0lfV0PH7
	+ELvR+O/W0fjktFS9eBEFlyx64m0Z9RVJuk1iJ
X-Google-Smtp-Source: AGHT+IENkaCb89iPxhBJhkzILAPVU17Ix2Ayev/PDjoYSbb92W7ZQtUh9+Nheqau6rV91KNshDtH4g==
X-Received: by 2002:a05:6a00:409b:b0:7e8:3fcb:bc4e with SMTP id d2e1a72fcca58-7ff553cbbf2mr29698598b3a.35.1767006150575;
        Mon, 29 Dec 2025 03:02:30 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm29320722b3a.11.2025.12.29.03.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:02:29 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v3 14/14] MAINTAINERS: add ntfs filesystem
Date: Mon, 29 Dec 2025 19:59:32 +0900
Message-Id: <20251229105932.11360-15-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229105932.11360-1-linkinjeon@kernel.org>
References: <20251229105932.11360-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself and Hyunchul Lee as ntfs maintainer.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f49de7fe03..adf80c8207f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18646,6 +18646,15 @@ W:	https://github.com/davejiang/linux/wiki
 T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
+NTFS FILESYSTEM
+M:	Namjae Jeon <linkinjeon@kernel.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
+F:	Documentation/filesystems/ntfs.rst
+F:	fs/ntfs/
+
 NTFS3 FILESYSTEM
 M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
 L:	ntfs3@lists.linux.dev
-- 
2.25.1


