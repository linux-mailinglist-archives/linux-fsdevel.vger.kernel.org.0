Return-Path: <linux-fsdevel+bounces-46673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166ABA93786
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5604646A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A74276038;
	Fri, 18 Apr 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLfHIj8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F08274FFD;
	Fri, 18 Apr 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744981088; cv=none; b=Mft5/BLQqxFjge1E+QI7mkc84sP3MiX9xfKuVTab35q9JDLP7O7APYhClwXlHXHTV5/d1zVS574WMxyuxwzkysep6GsIf7xI3RYfsEXfYSN1haYvIxQjWv+gAVPsQaPcaFnB800fBp7LLUW97sC59ry28lMF6WKKu94/LUTMJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744981088; c=relaxed/simple;
	bh=RMr4/qc9ZC4vHI96fVk2zVl6UzkjUHlIjncACCdOGYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8nC9LBIXkywKbvDigZkk/4SieqN6wrGYQMuJSdpMj1bYvarGvYfFqbCc0uXjo8XH+ysh32oYLCaMHpzGVlM9YxZBA+rOuNP413+BaGaiE8jmqVCfJ0kxkUquVfQO5Qo9tppvDtEo70LBWcyA+BX9J8M8xK02Ulme4EqT0eBri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLfHIj8a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3b12e8518so345797166b.0;
        Fri, 18 Apr 2025 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744981085; x=1745585885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTb4MLq6+pa8qb6DAMK0iOj4FeXvmY3R1z3r2UP1bBs=;
        b=GLfHIj8a4RTWTisCBBShWGOhmHp/8mIHOAmWyOuH56wx2Ac2tTR+h387AQtF0X+pGG
         IokNclxfggFQmRUPUfoFympW4x1mDdjblEDFPh9tqfpaqKJ1o3Wbc1NRUe66ofOp5JBE
         Z5SGA0gOt2j4zV/rmAeJFH8Ja+91eYCri3XfjrtmaVnQTAEWuYigH8uC0Al5Dms4JObY
         QFNv2YwjyhX0zwNUULaoOXkMMkenCpuiUwOG349plqMdBRdr1IAEvQvT0ynVPw9lAbRu
         PJtrVwob7Pxvn6fja28pgqlQ5uEn8pHBcH8mRX1HXzq1A4EZaNz1bJHjX2Xxn+XgHz5s
         OLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744981085; x=1745585885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTb4MLq6+pa8qb6DAMK0iOj4FeXvmY3R1z3r2UP1bBs=;
        b=rdLMdRyDodo7uqOVwRNymOE5AAfi8G2OepF+MAsgKb9G2kFjrGrRHIYW1pu0zlMp/6
         uaiuW1RaWiN5LHyOX6D3IUxcOS/mjLSIuYeQ2rUiC7JD9+EqZmYEbPpryGnTgYtgMog1
         7L+hax29cbqHrwAmHNzAttU36xjxuOUK5mHsbk3uKgCS+YhhLQ31fEwNBxMoc3T8UlVR
         PCnSxb5YHJj27oerDOGJ2IvWk4ms62SeC+ogmQjzwyfWqtWDc9/MasAYsLd8lmXOOMjr
         9qvI/jWtMk8hOf2YZRx77VIdqhwx5ximzlPCt1iP6Evd0RDTgei9OrzdcCEJUis6oaV3
         3BCw==
X-Forwarded-Encrypted: i=1; AJvYcCUtm77TgvxVm3Vkgva8VAnje/vgq20INJ0WMi9EOLfBfcbSV+hK4McZoCgMNBri1As4Zoq5ajby1tsDYnnl@vger.kernel.org, AJvYcCVDKFJIEUR1TMTjgFE1QRUwaVzxQ064soJ9+Uwqg+qlS0aMIOOEdtCNZynMXxYIIOqtaFn108kWP8XQzQeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/eyeX+8cURpeMClyrSN2NUpW7jf/hEBLtQsIF4Rgm1umlW2e
	RDB/pDQIzHXStIU7zhsN6zD9rnada4bFxpfAkE6vtGsXNoKgl0Dc
X-Gm-Gg: ASbGncsHW7sYEKYQ+I4El5vIj+rtLrRx+HRjZcv8Kpt3UrD+0oH8uYzlheY/XmwYh+u
	xxcf0mq0ZUl8r6Nhc9Cb8rHQ9M+BTk+oqfbobxXZi0CSJ4THoOrwhnOPMmBSmE26rOft4M9tNlN
	I6E/Ax46X6fiPbO9XGuf9fdYc/uCfGpBsYse+myLP9Fr1Kt8wcBsBNscxEFN4tM3SB8hnXz4tvV
	KeIbFsUYSIHgRG30qJvhjsger/iUjV5YK+3nRsqFwqxYixdVsqeiHZv4pqcOE53aVFrHt9b/gYH
	oX2cxwApgw2KpYElkb/Ja2sxpNoOrVHZnvDL/cQ4QQx6T2S2FtCbyypLots=
X-Google-Smtp-Source: AGHT+IHzmymjmKFjk5NExrhzRwKzydlaLRI3tQshEKDEtZOjVCYCMdJEuLoxCGdDqFd7uIfpUhwEgQ==
X-Received: by 2002:a17:907:1c1d:b0:ac8:1efc:bf61 with SMTP id a640c23a62f3a-acb74765f86mr302902866b.0.1744981084720;
        Fri, 18 Apr 2025 05:58:04 -0700 (PDT)
Received: from f.. (cst-prg-69-142.cust.vodafone.cz. [46.135.69.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6efadd16sm117764166b.172.2025.04.18.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 05:58:03 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2] fs: fall back to file_ref_put() for non-last reference
Date: Fri, 18 Apr 2025 14:57:56 +0200
Message-ID: <20250418125756.59677-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the slowdown in face of multiple callers issuing close on
what turns out to not be the last reference.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202504171513.6d6f8a16-lkp@intel.com
---

v2:
- fix a copy pasto with bad conditional

 fs/file.c                |  2 +-
 include/linux/file_ref.h | 19 ++++++-------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index dc3f7e120e3e..3a3146664cf3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -26,7 +26,7 @@
 
 #include "internal.h"
 
-bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
+static noinline bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt)
 {
 	/*
 	 * If the reference count was already in the dead zone, then this
diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 7db62fbc0500..31551e4cb8f3 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -61,7 +61,6 @@ static inline void file_ref_init(file_ref_t *ref, unsigned long cnt)
 	atomic_long_set(&ref->refcnt, cnt - 1);
 }
 
-bool __file_ref_put_badval(file_ref_t *ref, unsigned long cnt);
 bool __file_ref_put(file_ref_t *ref, unsigned long cnt);
 
 /**
@@ -178,20 +177,14 @@ static __always_inline __must_check bool file_ref_put(file_ref_t *ref)
  */
 static __always_inline __must_check bool file_ref_put_close(file_ref_t *ref)
 {
-	long old, new;
+	long old;
 
 	old = atomic_long_read(&ref->refcnt);
-	do {
-		if (unlikely(old < 0))
-			return __file_ref_put_badval(ref, old);
-
-		if (old == FILE_REF_ONEREF)
-			new = FILE_REF_DEAD;
-		else
-			new = old - 1;
-	} while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
-
-	return new == FILE_REF_DEAD;
+	if (likely(old == FILE_REF_ONEREF)) {
+		if (likely(atomic_long_try_cmpxchg(&ref->refcnt, &old, FILE_REF_DEAD)))
+			return true;
+	}
+	return file_ref_put(ref);
 }
 
 /**
-- 
2.48.1


