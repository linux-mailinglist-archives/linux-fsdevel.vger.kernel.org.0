Return-Path: <linux-fsdevel+bounces-72007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C93CDAFB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 266E43005F09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4BA30DEC8;
	Wed, 24 Dec 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="dtOmROgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAFE30C62A
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536211; cv=none; b=iGHjiX39tLwiIK/bPslbksuql0OuPFTpAxf2NARhpbmF8rU3H9PLZTBYJaGRdGqLDbK/aFpGIYch5jZIej20c9mYOzdFQ2fpW+JkfwNCUM1F+mG0ANy0cdlZ+EvR+1nW/Y8b7kctEbQSLtN/UhoDlnBwgTmRD5tFxthbEfHuMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536211; c=relaxed/simple;
	bh=8Q4eclvqxnpfZCIz34VHWYhQ/Qm7L6sIbQyGw6++cdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HmJb82Mw/0n8B3+FH1fjR1pwqfBHSCWj4pxFOLqec8wThBGzEuGw1ZISoBfPPVw4zulO/vXYpeZhUy8kxP3nm8kCPHVstQgLx/jBsMLPr4P1YMy5tQ7mOX8zjAcpHHOf+vAkJwxH8brtFynA1Ipje6urMKe1/G9zMch3KIcr49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=dtOmROgR; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-6455a60c12bso5203397d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1766536209; x=1767141009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tvt7lImfx971sc5dBIyMWPCFjdNg/4vR3ol8PKv5vxI=;
        b=dtOmROgRE2/92lGKRomB0hcc7O7TTAKa3cdR2iExOLB1amFOHTk0ClLmXm6kNAshhC
         4RV9+PskaL5T2VIfN9LK/HaVcniDPSDs0ovPR0YzfhEWPbZjrIZbzUdf/GA3IVqmISpR
         1amArOoDevwuzu3c7pszUjnjMuF8NAtNz15UwvKt+jdvKIplq2uMezbqnbt534wd48Cn
         eFBX4eYc9zOdDrWETHM0e7POR1FXeWnogXoBZaufUmtZ1VYjwFXe60KomLO3qMVTQEll
         IJnQA+rjQjKOO/n+pT+ZAn3PZpPLnH7ljFVHkw0qtW61Etza6KDz76TvZXnM6dpE8VEC
         iFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536209; x=1767141009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvt7lImfx971sc5dBIyMWPCFjdNg/4vR3ol8PKv5vxI=;
        b=c7RoBHmZqUpvy2KXncS6aR1hX375kfNw/KiIqUZ56uAz4tomJ6i3/KN9JRm0fd8xxj
         JjexUIlyLN4j02+seiTpoYbQNlgLpPjIp+5QLig8iT1BTqSOEZrJkUKBUsMHExUZmImV
         XHkjUenD+u913Ng5+PTD+lkxdd+Sf0bkiF1X6lp4l1TZKHfPpZf7ml9EBv8XkkTjKFJ+
         saCUCoM+ul+BTww9TJp/d03bClcM33Wi3wjk5cewwZ3c+dPYOLEq5I/YVuABg1POe94+
         VkOEw6V/1nygorHihrs1g0vxknsn2uFgKgiOmavCbS5YNMKe3GqaeRLTmKFh3VQgnCyh
         QHHw==
X-Forwarded-Encrypted: i=1; AJvYcCWplZwk8MEmsKKFiEExzp912Jb0sjkBdhR2lLMNuv2zP1/GjiC2kptgRAjHifOe4Hv0LUdufTrmO4IUnMRR@vger.kernel.org
X-Gm-Message-State: AOJu0YyUG4kE44kydzz97sI/2iA3PO6DmrHbrCZZnclE2uySROzVth2X
	urCQsB7TMxf/iy6KEQdoX0bQ2+67cMLS7Qn10YTfD4lRIizpaixdBRsLLpHTGh13bI0=
X-Gm-Gg: AY/fxX5HV03tGGC8sMfhwMvPfYOgUNDY4huJFeOTOLRnIyqShE//ZVtMDsR2TqDN/t+
	Ua4uI6PIqC+YVjz7LYHzSlztG9w4ceYok2szYWR/Q1/SBvVuFyEW61F93DTjCpFJbam6QgQIlc8
	I5VuuWzrFOrvXv63MY7j/MfkeU7QysPtCcniXPfddUYsz4Vhm+Mq+Y7ix10D9ggWvRSRLbsrEza
	F88a6QD5URKRc6s8zDBVHsAJ8tysT8qQxFDiNYw7mXo/iV6sVZ7CXTZZajl4SdJIb+/stpuvwM4
	4rBwseeK4/8YBKlt2VRUKUjVG+av2l4oo8+LzUnPhKeXS/k0x4tra2jSpxZqirjaZf/he2EpSlo
	g1vXDlMlH0jOAN7WJx0F9JDpzwwuFtjRRuacGOjlJNJWmtmc04LEIPfl1MpsUYRg3LnoXj6aqAz
	vkg/c7bkmGPaKcfM8lWdqcDj16xCXkFpYbbi8XMvgouog+II1VVJUdwGQ3SUbVo33hV+C3+GGNK
	nkCbdLM4XqW
X-Google-Smtp-Source: AGHT+IHPNy0iURraOxC/YoxtpDgPNyQYFKR90KMfdDD+MzTFMNEn+3A7uMfxyokd8BcjsoJ9vk42hw==
X-Received: by 2002:a05:690e:144e:b0:640:d009:e998 with SMTP id 956f58d0204a3-6466a8a4d83mr14013621d50.12.1766536208917;
        Tue, 23 Dec 2025 16:30:08 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d3b4:b334:ddb5:458e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43c71b6sm59698197b3.22.2025.12.23.16.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:30:08 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] generic/020: limit xattr value by 3802 bytes
Date: Tue, 23 Dec 2025 16:29:58 -0800
Message-Id: <20251224002957.1137211-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS+ implementation supports only inline extended attributes.
The size of value for inline xattr is limited by 3802 bytes [1].

[1] https://elixir.bootlin.com/linux/v6.19-rc2/source/include/linux/hfs_common.h#L626

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 tests/generic/020 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/020 b/tests/generic/020
index 8b77d5ca..540f539b 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -168,6 +168,11 @@ _attr_get_maxval_size()
 		fi
 		max_attrval_size=$((65536 - $size - $selinux_size - $max_attrval_namelen))
 		;;
+	hfsplus)
+		# HFS+ implementation supports only inline extended attributes.
+		# The size of value for inline xattr is limited by 3802 bytes.
+		max_attrval_size=3802
+		;;
 	*)
 		# Assume max ~1 block of attrs
 		BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.43.0


