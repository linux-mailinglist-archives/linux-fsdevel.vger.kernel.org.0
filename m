Return-Path: <linux-fsdevel+bounces-63690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B22BCB272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 00:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D08E19E7DE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E62253356;
	Thu,  9 Oct 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz6GH8bn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F90286D7D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050662; cv=none; b=KS1ZDTBTFGtEao13C8Ysshz3jVICbGYuv8zxIBIkMAeRp525JRm01RNG5ROYZiT1v6JzydFg0VWksvPUyvhloM16sUpQ33VI0iA8O5Wm7fTsEMGvRS3mP0bY02PigBr11Oc8se8thfKlqlUpOyTKfGWahLA3NxzJXxL6BeVo/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050662; c=relaxed/simple;
	bh=eIy1DWMoQQXukK+G4dwJiwyXh8fyrUFbN0RdMp8nLn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7U/fvgpMZwy5IVkVVhwtQ9swM0VWIVuCVDvvLswtWOXl66RdSNeQEFa0h5G6KX5uKFkoDEgUc0/K6PG2b7OYwBFM8Huk10Zj3DsmupZ0fviqb86nY6TTNgHAkecOL4kzhawcHyT79s9xDgGtI32yZ38k6CcHdCkXBwzJphZRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz6GH8bn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so980088a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760050660; x=1760655460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggeF6DaTgBa+ksqmPcUisHZBNeNiTmM4yS6l2u+jveU=;
        b=Nz6GH8bnHQkgiP8Cd1zKGGYs5kyTWkvTQCY05fdVfUU3c0id4cfljtGLWMEtvlTmI+
         aA7FhX3AkOaMQSMimtsm5EdrD9SSVE4yGAu95USOeFhrEQOIJy8BA++EBIbhuHSOLxhg
         QmWsNCRsSFzCHslfOaN4PVt5XWUjwCYJkPSOD9Rd+avrMW6s63HJPS6sYBWujVe5VzOJ
         js68xEkVLk+lgPBmb4PBlhsKfR1k05AJAJPjCitFVgtuCDdt2fqfK4h+vk9X6A4MG5Np
         VLA/CV6ixsmFLR9ESUPaL8wSxkXsUFnFLTZRxozeDuvQ8qVwT5DLHYLC14z7csxUHLLp
         xVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760050660; x=1760655460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggeF6DaTgBa+ksqmPcUisHZBNeNiTmM4yS6l2u+jveU=;
        b=h2lg1FUsT8O1UNuLef5ZimPPV1yeE6xD2m2NEDVNAqPO6mTrcSJvzwg5H/DGydIIX+
         nxYi3PYUHport+nZAhT97moHd3y+MTvZ7Ws+s0VN6WiHpBCCwf0baZX15xb0EDlZp3Tg
         KSHLIV062E+fO4yTggRz3uMreL7PMukiGnT2z4fsouEWwEWDknV0jaKuv1sV6lAZnIFP
         CiUBwdwjZA1m4bq/ksz2+7/IPlEgkC5cTjHM/OyXQp8olNT2K9nOVHA8OFuwgrSKcTjQ
         SSkpjzJLJkQtSYMitea6i4OSPguOxNfp1cVsPpuJkjnXd+YaZCMzfKkoBYX9MLROBQm+
         mClw==
X-Forwarded-Encrypted: i=1; AJvYcCWCUnFQaNKbIRQEfA5yQXPoVwkmzCtprPw++socmECVTLfnCiZ8ZlqW5SvmUnT+3AKHIaTDnGT6RtPHuj+j@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5EpxHyzk3scnx4XGpnvbQkrTCLFqL9jWnpL9vplU/tpQyOtk
	uCBE2RbvM3tZ4HZgM0Z/0DWaSvbgcBukLsVVUWzh+uWJmtwo80hfcjxrSsmDjg==
X-Gm-Gg: ASbGncv3mAiK/+we6JXkvXHb51c90F3+9m2eDQve0IMPXeBjrWgWIrrGvJNBmjHFgv8
	9qbv3xp4wk6KlNLTMJE2QCH2WuLvWGYFlULq11G+g/5QOnc6oG6LB71pIV/cIlrfnaZd1/lpIr8
	ufn2JXPn9Z1WKMjDxxOkhTR2velvHJzGcndkMY+tU53wqJ4ksmJ814HdQ5wfUfTAcvuudqXobD0
	sNZpFomI/wsg3I27sFs62z7tAM+fnvvySUv8mACP4mFcwJXEPv7KBAbEY9RnxvH88/Gia3vhcd7
	TVjrX7HXnZK8WVf3q9KXbikOmCdzHtRobeDKeTaPkitStKO3BQmv0J4SovaOEGvqK1EF4I/acJ8
	NPGgdSI9OSga02v0Az0JcQ9y3Hh/8K1hGuMJtMIZxl4f+qEZbjDsie+ioWu988katBWD+I7clWl
	44Gjdz+UB0
X-Google-Smtp-Source: AGHT+IEe9JZgxEk9jzkyGSmmx9jCncq+FHSO6zo4qvDV+l3SefS6+Y7Al/5wYtsxOQF7pzSIXPOEmg==
X-Received: by 2002:a17:903:2c0d:b0:24b:164d:4e61 with SMTP id d9443c01a7336-290272b27b2mr107127645ad.13.1760050660169;
        Thu, 09 Oct 2025 15:57:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a4f8bfsm2740469a91.10.2025.10.09.15.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 15:57:39 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v1 2/9] docs: document iomap writeback's iomap_finish_folio_write() requirement
Date: Thu,  9 Oct 2025 15:56:04 -0700
Message-ID: <20251009225611.3744728-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009225611.3744728-1-joannelkoong@gmail.com>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that iomap_finish_folio_write() must be called after writeback
on the range completes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 Documentation/filesystems/iomap/operations.rst | 3 +++
 include/linux/iomap.h                          | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index cef3c3e76e9e..018cfd13b9fa 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -361,6 +361,9 @@ The fields are as follows:
     delalloc reservations to avoid having delalloc reservations for
     clean pagecache.
     This function must be supplied by the filesystem.
+    If this succeeds, iomap_finish_folio_write() must be called once writeback
+    completes for the range, regardless of whether the writeback succeeded or
+    failed.
 
   - ``writeback_submit``: Submit the previous built writeback context.
     Block based file systems should use the iomap_ioend_writeback_submit
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6d864b446b6e..e6fa812229dc 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -431,6 +431,10 @@ struct iomap_writeback_ops {
 	 * An existing mapping from a previous call to this method can be reused
 	 * by the file system if it is still valid.
 	 *
+	 * If this succeeds, iomap_finish_folio_write() must be called once
+	 * writeback completes for the range, regardless of whether the
+	 * writeback succeeded or failed.
+	 *
 	 * Returns the number of bytes processed or a negative errno.
 	 */
 	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
-- 
2.47.3


