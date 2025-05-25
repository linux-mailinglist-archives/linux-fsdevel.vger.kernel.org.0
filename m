Return-Path: <linux-fsdevel+bounces-49818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25DCAC33F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 12:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D81F18936A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DD1E5B62;
	Sun, 25 May 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaXK6UBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61667367;
	Sun, 25 May 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170059; cv=none; b=NY0J8QmIcY7tOH/OhzcASFlzbxZBjFXF8JIV5RuTbAoaPvhcKWiXW2Ve1Tp40iqwVg/rSGze2blxHPE69UjmSjRIu/xM3Z1wd3hoBPrJR7BUMOT2S+96fphamOvOYpzLhWUm4JCUwRcg+uoJIYaBrTgtelDbn8W5aqo3Bme3JJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170059; c=relaxed/simple;
	bh=tNTdWXJNGubCYaUJISiDd6RnWOzF2tjW4panFuT1mJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHfLuVYl/+gnz8DztUz9yQ2y8fFg4peDukECTtG3SnqSIc9coHEC0OG74zGNe2qzyVKTl89cG+6UlkxalL03mzvHBDi5s8NRobuJhVdk3G8X7bdEP7ZDnA6hPZbppmyACWgl7w0cNgAZ1Drm8g19rnh6fTZ3OVBWpEpj8tKB3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaXK6UBJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf257158fso11354655e9.2;
        Sun, 25 May 2025 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748170055; x=1748774855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9xm5gCRX+/1/reyUY/P+EsBK2IvaShiBj5uXUDjlWg=;
        b=IaXK6UBJwE6gZ8eT0yWNOTMWGn3snof06682BJG074XVSaldhxWeevWazpzxo6x3CR
         qej2AZmkZtFy+bcH594wkg/dF+bMGlivk+09MpHVdoWRStKrt/84N/Qrm12anGXp04sW
         21Tc4RsvBSKXQbnvgGzhbrj7QNGCKonBUnz0s9175R4S/a7rkZx0PgpYlYBRE9xzXCT2
         lGr8EBP8h4EoQ6pu1NSwXTXzFyIp8R7DLs70bnBDVrDlOFwWRkvvTwtZIXgRPCxZW8yE
         8dAkF1v2IGFk4sriXDIdGdsTrt+SLHEAa8dMsNk+4nyXDjRUZiE2MWhBGSYKxS2w72ae
         NNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748170055; x=1748774855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9xm5gCRX+/1/reyUY/P+EsBK2IvaShiBj5uXUDjlWg=;
        b=Lem80b3zvz2e+WqWjl/5QxDoeBEqrorqmUmbI2/B2mEK1WhNmz96Ee0uWptmpW7uIl
         h5PNpAqrawdyOwgPjLJtmziAEYbY1kY/XetAEVlnmkI5ZRqpGQy8Pn4CuLsPOIgpPjmB
         FZ12sekjQP/j336lYdxoUKD6GSeeXWtZC/swheKRLHKIgkmGeWEC1Rs7ruS9ecyMILK9
         nLv6fTSZZePN4Qw0t3u0mTYrvqpaMZ4P20c0JOfTgH7oEX/3vhdrxKnf36YgehYWqWJo
         +kuTLwRg05mkCfWVFni2UbYpyNkCMmsKH3Vc4RCfJXn8nQvqWyXJlTLdD1IfWAcx9i7c
         xgoA==
X-Forwarded-Encrypted: i=1; AJvYcCW6LfxYQd7xczEcks0NaQBIhIXeDcEg+XNNoKMKvBhqLnMwvV3Uxhw3z/BrvZn5uFjza/Tq/X+Y5cBr@vger.kernel.org, AJvYcCX/RYYAXDVV1lWD+Q60JEiMRqVs68inyN9iWpXwueux2WshNIWYVvHZ4GouVgBXxakx1/Pn2eQ5Mov9GOFz@vger.kernel.org
X-Gm-Message-State: AOJu0YwcE4k/WqTX8s6XRmgniYHbcMcLPoJJZdbYo6+7+kaILg6zDb7d
	Wy7uJdo0Fu1/kYLd40p3QEeyscxSLdAxfHWrkSNgmsR3DOGgNb565KOegK2x2PE8+vM=
X-Gm-Gg: ASbGncvawC7G5p24Gn7g83cWK2GzuNOz2N7FYBz5Q+fWTHByiSmRmtZ1Kne5V7VH5oJ
	TVahnJB5FMhH4sCTffrtmSE9HO3NhMc7y2yXEubDUXDSvpH0Bm8Sa3Xo4+oC0rFPjzBrTOhpfZ4
	S/Yj9oMvlQH8/e3SUjTJhrYN0UmKX1i3D2nXarxuRoHNUed0exIW7Z9k4J4oScUVImyvyR7A976
	7SawVCDMzwWSHg6esI/F4J/hLf9HUE9vEm+Lf9NWXXdKYBr7xRWpfVPGJLBBIwYwh1LrSO92Qmp
	Nfj7iBaWZAxsAaQCABjFEqLRHe+tROX6gPYiyNFhwqf0Z4FPHlfwOxUpj5nBE8yXAg7KPZ9O+Us
	VEpacX1Atgl6M1N5CzpjKe0jyKUvZbBIAYg7x87e1RjZ7kgXC
X-Google-Smtp-Source: AGHT+IGd71ak5cYNbp9e4syXVl5eaJJsCwaBXUm/PRMX6E9hYNpkwK8TBVejcv5UlxNZ5/nFeqOXDQ==
X-Received: by 2002:a05:6000:2082:b0:3a4:c8a5:424d with SMTP id ffacd0b85a97d-3a4cb443a40mr4971826f8f.26.1748170055318;
        Sun, 25 May 2025 03:47:35 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d0bb54e6sm3004958f8f.97.2025.05.25.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:47:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] exportfs: require ->fh_to_parent() to encode connectable file handles
Date: Sun, 25 May 2025 12:47:31 +0200
Message-Id: <20250525104731.1461704-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user requests a connectable file handle explicitly with the
AT_HANDLE_CONNECTABLE flag, fail the request if filesystem (e.g. nfs)
does not know how to decode a connected non-dir dentry.

Fixes: c374196b2b9f ("fs: name_to_handle_at() support for "explicit connectable" file handles")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/exportfs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

Christian,

This fixes fstest failures with nfs client (re-export)
reported by Zoro [1].

Thanks,
Amir.

[1] https://lore.kernel.org/fstests/20250525053604.k466kgfcumw2s2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fc93f0abf513..25c4a5afbd44 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -314,6 +314,9 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
+	if (!nop)
+		return false;
+
 	/*
 	 * If a non-decodeable file handle was requested, we only need to make
 	 * sure that filesystem did not opt-out of encoding fid.
@@ -321,6 +324,13 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 	if (fh_flags & EXPORT_FH_FID)
 		return exportfs_can_encode_fid(nop);
 
+	/*
+	 * If a connectable file handle was requested, we need to make sure that
+	 * filesystem can also decode connected file handles.
+	 */
+	if ((fh_flags & EXPORT_FH_CONNECTABLE) && !nop->fh_to_parent)
+		return false;
+
 	/*
 	 * If a decodeable file handle was requested, we need to make sure that
 	 * filesystem can also decode file handles.
-- 
2.34.1


