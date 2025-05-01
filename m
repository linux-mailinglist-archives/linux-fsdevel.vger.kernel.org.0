Return-Path: <linux-fsdevel+bounces-47863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D96AA6431
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28073A9076
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CC22A1E6;
	Thu,  1 May 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="QWhfU2ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE221C19C
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128593; cv=none; b=pjeKSaIXcvI0QvVCySsRokmVbwIzceh83bSGhkJeG+pp9RPATTYQQzgpwXrEsW+aUd7SWjULefXaMpWNAnbak0OktBYVfazwMLY4lbQWl5q+xVUoBP0NxS0tpvQBmbKhH1W5ZVetnjale8c7KGPERsD9yODepzpwQuP4m+r1K/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128593; c=relaxed/simple;
	bh=IfY/4DT00hOkCqCiYI7CiwHK3YgJ3tnDAoUNImKI0Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKlw45WAZKPZiCwZ02Q3+fF+gBrOtLWZvkRVT9+fi519Q3ypjW0MwrOpxeQcythgMDSr8rW9bonudx46Anmjff3l2A5pus0Oaykxumfpdu7ywWSwdz622Xx2HdhlRg8Tpoxeqv2awpNyvVOezMXMYHKbjt+mcIIVhfiue5bJDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=QWhfU2ry; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c062b1f5so1521077b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 May 2025 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1746128591; x=1746733391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atROUtGhqobdX+KHv0+wro4lBZgRuHBR2HqsMcw4zz8=;
        b=QWhfU2ryvs/irxvG30vRBxpCRzQ8uivZVuOAkoQbIk9D31/ZMiR6IxwkSLFsBPd43B
         SppRlh+/fmDVox2SCpPF670ERwJ/HRqvWm6yMWj1T95P7vZTTcICbpiY7fo6mFsVEj1Z
         CKiay8EsvKwizl2PpyAgxEmhgUribDvi07D/LJ6kPQ16Qrq0vul+ae+8T16y4YKFtqeF
         QgFAMgtjFsRfj2R+kj1BfW1fbiDVsEb9UZzw3FCw+VqR8k/y+Af1zt0cVGChDR2oarZL
         hKTPwQC+/KnouJrWcFPkE/uV2oP5HSsafGvzd6HQhZ9ueYyzDNaI3mEedB+AurYYK3rA
         jV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746128591; x=1746733391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atROUtGhqobdX+KHv0+wro4lBZgRuHBR2HqsMcw4zz8=;
        b=bBJLjMGliJZk7+q+z8UeNeXP6oGLit3dSoA9UtTY5F4z1/mT4qxNYh1wHkr1vgyVMf
         JuCPL1mEQW/b340FMAP0nDBdEoKs+sYfcKr5QtCeOUXAA76IyacWK55egGYYpgAtMEgW
         sFqukybSXMSMqXK6DoqElqIb+XWp7N8EzFVqo5MSSgEF/HkyD9rSQmbB8AvNEx8aQR5D
         f1nG8xRGxsV6iPqTbtp/k1jAK9CRH0kChF7XbRim7L28GJz+If73VDi3v7hP+v0eJsJY
         KH/QhFgiqcwHUXFeSY8ch1N4UwDcsaU+dlSXu6exBIQby8toEludVYEX8zaHuBwZlIuC
         EIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa8rDm3R1KjcAaRkk9TpSzsOxdDfVHBH5MGIv0QNnKTtkLEyE7bMkRO/Y6BqCwYOCQUD5h2M7pPd1YkvQY@vger.kernel.org
X-Gm-Message-State: AOJu0YwRU5AKQKyNTrQ7cowVrAJFOyj9HV2rvEdXLbtmFDDghPYeM2qp
	WWRYrr+2oWia8kmjvaln+RtYLv9UEdx19wP3LUyuAEG7tBHAxGJVpMqsuZ8gQBI=
X-Gm-Gg: ASbGncuCWRx6W745qTtueNlrazHWJB1dd8OiIW8U+g+WWMpigifNDExaMdbQssfY8K9
	KfUF2Rh4Ri4zxZf1hc9I9Jo6thnyD4b3ci6Lk7Op3+oQ9qJn7qcQj97DjX+DT262Weo1URKoLtv
	Sq05BkbrryLdGpbJyo+D/QHc/BabUDuy39yIKMr49OwfBzdM1CqrIcPkSLzuMrlyI1DxrjIc1yy
	yxeCYAqfn8FA7hRY71ssQ4fY2/EfqhJUj4LWrlnvlQqL1bhHcbgEQoRyi8F7UcM2AE/z0y1/deW
	gw8f/kTZHOLqusbkkLtl4COYLkW6P3rA2C3bZ17uu8dNwGnW35jycBLDLA==
X-Google-Smtp-Source: AGHT+IEmg1et2uTan58Wd6xgiW0ggM0aCNGedSn5LtPBPf9OMUOMENel0POdJ3sSMEnM+nEWuGBs9w==
X-Received: by 2002:a05:6a00:4482:b0:736:32d2:aa82 with SMTP id d2e1a72fcca58-74058b5afa8mr236273b3a.23.1746128590901;
        Thu, 01 May 2025 12:43:10 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:7a9:d9dd:47b7:3886])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dc45basm50882b3a.69.2025.05.01.12.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 12:43:10 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [RFC PATCH 1/2] ceph: introduce CEPH_INVALID_CACHE_IDX
Date: Thu,  1 May 2025 12:42:47 -0700
Message-ID: <20250501194248.660959-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501194248.660959-1-slava@dubeyko.com>
References: <20250501194248.660959-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

This patch introduces CEPH_INVALID_CACHE_IDX
instead of hardcoded value. The CEPH_INVALID_CACHE_IDX
constant is used for initialization and
checking that cache index is invalid.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/dir.c   | 12 ++++++------
 fs/ceph/file.c  |  2 +-
 fs/ceph/super.h |  8 ++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a321aa6d0ed2..acecc16f2b99 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -296,8 +296,8 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			err = ret;
 		dput(last);
 		/* last_name no longer match cache index */
-		if (dfi->readdir_cache_idx >= 0) {
-			dfi->readdir_cache_idx = -1;
+		if (!is_cache_idx_invalid(dfi->readdir_cache_idx)) {
+			dfi->readdir_cache_idx = CEPH_INVALID_CACHE_IDX;
 			dfi->dir_release_count = 0;
 		}
 	}
@@ -483,7 +483,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 		if (test_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags)) {
 			dfi->readdir_cache_idx = req->r_readdir_cache_idx;
-			if (dfi->readdir_cache_idx < 0) {
+			if (is_cache_idx_invalid(dfi->readdir_cache_idx)) {
 				/* preclude from marking dir ordered */
 				dfi->dir_ordered_count = 0;
 			} else if (ceph_frag_is_leftmost(frag) &&
@@ -497,7 +497,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			doutc(cl, "%p %llx.%llx !did_prepopulate\n", inode,
 			      ceph_vinop(inode));
 			/* disable readdir cache */
-			dfi->readdir_cache_idx = -1;
+			dfi->readdir_cache_idx = CEPH_INVALID_CACHE_IDX;
 			/* preclude from marking dir complete */
 			dfi->dir_release_count = 0;
 		}
@@ -643,7 +643,7 @@ static void reset_readdir(struct ceph_dir_file_info *dfi)
 	kfree(dfi->last_name);
 	dfi->last_name = NULL;
 	dfi->dir_release_count = 0;
-	dfi->readdir_cache_idx = -1;
+	dfi->readdir_cache_idx = CEPH_INVALID_CACHE_IDX;
 	dfi->next_offset = 2;  /* compensate for . and .. */
 	dfi->file_info.flags &= ~CEPH_F_ATEND;
 }
@@ -703,7 +703,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 			/* for hash offset, we don't know if a forward seek
 			 * is within same frag */
 			dfi->dir_release_count = 0;
-			dfi->readdir_cache_idx = -1;
+			dfi->readdir_cache_idx = CEPH_INVALID_CACHE_IDX;
 		}
 
 		if (offset != file->f_pos) {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 851d70200c6b..2097a23c0c31 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -220,7 +220,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 		file->private_data = dfi;
 		fi = &dfi->file_info;
 		dfi->next_offset = 2;
-		dfi->readdir_cache_idx = -1;
+		dfi->readdir_cache_idx = CEPH_INVALID_CACHE_IDX;
 	} else {
 		fi = kmem_cache_zalloc(ceph_file_cachep, GFP_KERNEL);
 		if (!fi)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index bb0db0cc8003..bcd1dda1ab81 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -840,6 +840,14 @@ struct ceph_file_info {
 	u32 filp_gen;
 };
 
+#define CEPH_INVALID_CACHE_IDX		(-1)
+
+static inline
+bool is_cache_idx_invalid(int cache_idx)
+{
+	return cache_idx <= CEPH_INVALID_CACHE_IDX;
+}
+
 struct ceph_dir_file_info {
 	struct ceph_file_info file_info;
 
-- 
2.48.0


