Return-Path: <linux-fsdevel+bounces-40189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A61A202E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 02:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA1161AB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2B136352;
	Tue, 28 Jan 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="w4ykXNSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAF38FB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026643; cv=none; b=IyZA0dHu1Gh3F0FBIXp3H0nHqenoJaJRwxKKdEuGIw9Qg9QyYZs5YYueZYZJIrUDFyIYAgDJ2+6Dy1h47xDwiQU49VoXiYIVJKDtd93CkhSnX17IkB7m16QsfCxP5reFrQznM2hFsDM/cHCT6P2JRsHx3H+7370aP3ZYg/GokR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026643; c=relaxed/simple;
	bh=idoWM8EkAkPekIxfJWfU90+4BQccVkcX3Cz8OZha4rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRXjZb8UfSnXQALa/J/e8tLumTgsPVW/CcX6ZH8J3gtq7O8OyH67L3rT3p3vJYNdOyL7dzpQ++GWIK+eCWoM4isohxa45mRaHEpFWS2tkQ2+K6OxPIuRgK1WestfnWUJxcCVsrzD1u/QVp2lV07banjhMvsLFsNHlqKwKo0wtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=w4ykXNSY; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-21636268e43so111947285ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 17:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1738026640; x=1738631440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aW1EosRXYDRl1YDPbjGpE1cgwqJRDI2u+FOfmgEW9c=;
        b=w4ykXNSY9SfS6yyMyCqrkouAFYgAQ037wQgy+y4bZilneK579qODJcKZUCawkTMqjY
         q7kPIC4TcgADEcaZTX7isH4G7bcubymmrTE3Pqe6W6mYparQl+99jydlY6VbeIdMSbJO
         BLPfgKjNJIQJ/FuvyptodPRUlKHdTbG7ZkWwcHa9SCYJeJduk3KfVwTkRhyLWYZJ0IIl
         V3EUDCJxUix9BnuMcN8f8fA/AaZwZaRTnjel2dQOcGHj2adnOfuglLPFK6wSIHuxOY7q
         jSdjnP/XhGcQJUeMEBCK80Tw8Oe9oiDa7Dy4urK7G1T6vX0qB11An9CtrqxNieHPzlGP
         MVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738026640; x=1738631440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aW1EosRXYDRl1YDPbjGpE1cgwqJRDI2u+FOfmgEW9c=;
        b=WMjv2YHnAcUo8xOzfE1X36LFuE9P0ecItxItOIIq3kFzLmPiSE34X17m/ZLhf3fVzL
         7z9X9fEJU6S574JOSbNJ5UGLHFe7CrJE19Z+5kIVY5LrQqA9Wh1rR0VFbVrm2Y/XiItQ
         se4pE9j1E92QxEd8AzR+IASJQAxpWAZ+2Np0KgDazzYmYaXblqcEctXE4UcadR4JQQSL
         Y3uMWNIwhq7+HwWuDE4qcnSyQv11bTglyfzfanYKBJ/HV2taUXW/3hxuwMcpxagPw/3k
         8CgQkK/9bGzRWPX8Pii3CKccr2mRIbiohvi7Ws2O4XFIm77XKc54siUfh26PTEhKIo/A
         vWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqlARiccFz/fH2xyJQmfJrIiO7IyeZ6QLWScjK2FR2kHyerVsImyIil8/+1uCXGCqk6igE/hj3VnOgoDm5@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrCnUPBjD+XhCUi6KXApKjP7YLFAzMKnXuxMm56TTjAVcHyfZ
	H8OzSyms4aoBbqzVhgFYLZv+yeFKYAn3bUtSfMFhA5BMZ8jj1nWptMhwxt8u+Hs=
X-Gm-Gg: ASbGncsJaDyeBMmO6jujU4yNt7MZ60KokS/RJk+wDa2sVoLH9wCPtdqhiTx2hsP0LzN
	wMlfrD1AtDUlCu/3cHaMjSDLiBmsU+hCr7z6saarr+D843OfQ5YGB2H+lClR/VCRow9UcuhYc2J
	jCI78i/DqvYKVmKswTDoJF06XXtVW2x09XcEcvClUCRLLXWF9c7nFqRzExVMx8wN4CFaLS5kHBB
	KZwP+xupA3sb/fGS8oFSt4VYSPNet2HJS0RWtyPAm/ZaW/N7QpZSMqRSTgYoLmDuUbxbIeLOxIV
	jeb5DGrcUT0Cgc7NlonyGS0=
X-Google-Smtp-Source: AGHT+IG2DbeQ9tm5aIbKtVDA1Dig3K5nSBz2CgNabcBO5SVG1W/sVFCbwrxpG/Bo7uYNbhrWbPdlXw==
X-Received: by 2002:a17:902:ea10:b0:216:4e9f:4ec9 with SMTP id d9443c01a7336-21c355c2906mr698721305ad.38.1738026640036;
        Mon, 27 Jan 2025 17:10:40 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:c976:3cdd:dcf6:6f29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424dabdsm69745735ad.253.2025.01.27.17.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 17:10:39 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: is_root_ceph_dentry() cleanup
Date: Mon, 27 Jan 2025 17:10:23 -0800
Message-ID: <20250128011023.55012-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patch introduces CEPH_HIDDEN_DIR_NAME. It
declares name of the hidden directory .ceph in
the include/linux/ceph/ceph_fs.h instead of hiding
it in dir.c file. Also hardcoded length of the name
is changed on strlen(CEPH_HIDDEN_DIR_NAME).

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/dir.c                | 10 ++++++++--
 include/linux/ceph/ceph_fs.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0bf388e07a02..5151c614b5cb 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -782,10 +782,16 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 	return dentry;
 }
 
+static inline
+bool is_hidden_ceph_dir(struct dentry *dentry)
+{
+	size_t len = strlen(CEPH_HIDDEN_DIR_NAME);
+	return strncmp(dentry->d_name.name, CEPH_HIDDEN_DIR_NAME, len) == 0;
+}
+
 static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 {
-	return ceph_ino(inode) == CEPH_INO_ROOT &&
-		strncmp(dentry->d_name.name, ".ceph", 5) == 0;
+	return ceph_ino(inode) == CEPH_INO_ROOT && is_hidden_ceph_dir(dentry);
 }
 
 /*
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 2d7d86f0290d..84a1391aab29 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -31,6 +31,8 @@
 #define CEPH_INO_CEPH   2            /* hidden .ceph dir */
 #define CEPH_INO_GLOBAL_SNAPREALM  3 /* global dummy snaprealm */
 
+#define CEPH_HIDDEN_DIR_NAME	".ceph"
+
 /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
 #define CEPH_MAX_MON   31
 
-- 
2.48.0


