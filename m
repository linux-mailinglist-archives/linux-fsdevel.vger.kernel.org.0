Return-Path: <linux-fsdevel+bounces-46671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE2A93778
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB471B66923
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 12:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C327603F;
	Fri, 18 Apr 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRu4tGgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E7275100;
	Fri, 18 Apr 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980614; cv=none; b=jUFIeTRNKzHqn+zow9hhHJhk5vu/I0ArqlwSk62R4ZXyt8S1JJ+AfJhLpkLdlGzNcCA1zrW8kKON5kU4w6T33NGePWgTd60VGwd9fovAl3Rbwg3Lt+iU6o+mAeB0YUb+AbWjfi8a88W9bgjM2xajTjAlSwlGsEitXybD5xIxgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980614; c=relaxed/simple;
	bh=qIe5VTYAgXMdVDSSpGXuaEDxmGWJGGpu3zQFFsXGwr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1qoYZyYyIp/cdMKTq+b+m2+R/a8V6p/K8MJxhBgzaG5uBHEP3v8BJN4WWtIMbuH+Yil6xqVxKbwLruxEV9AFi39FEUzMoOpSDMWRdfGL0om6oQ71MgqlZz/Je1FG/URQWzFjiujfKrbAs66SRKOPgT28h6qlUDKV2dP/Au+80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRu4tGgO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so2636117a12.2;
        Fri, 18 Apr 2025 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744980611; x=1745585411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiG/jQBcPMUGDEIyEhmKoU4AoPV4dkKviFsyVE3TVcY=;
        b=KRu4tGgOp116H29WD1xuybFQarb/VnwQh5rAEMTdxDiq612Jrqk4K5Rg0tPSb+tP+i
         Za81x970IjZMDHDEtbvzGrO4hpwov7IHgGENHYNIG6IWu4ZHOLktglGV+7LYMQTNNiqA
         1Cle9yE1YEZVFlinPooo2P6/d9NIscxJRCwpk6LnGc/nwJpxKJx//NSiIUM1QG03iQvi
         9GUbVf7+f7cThrC/hg++zUuTOHO+tMdhV5qHBhzHNJI61PQpRLUtiLGw2HSPQUD5ubdn
         7Lt+xLzogPdpf+CjmqaPCLt+o3mpLYMnPyq8hXkCKsjNB8Pw5CmPfAO8nT10FkHeXUz8
         SD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744980611; x=1745585411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiG/jQBcPMUGDEIyEhmKoU4AoPV4dkKviFsyVE3TVcY=;
        b=H3ZVhsgHUfj5ZPRfcsXqg8CVoshaBmiMxfIwwJaNqJHUJs3kbjbcZrM3oHrX69jvml
         A3JQFC0iTnzW5Erl7OFqAETKOpdwE3FLJ76ZtMsdT35TZx8aQxkrNjfMUVejcaKAo7M5
         u+LQO8w6M0pMSIG7CeDK62hJWNAJMxaCy/fgctW9NEil+6YrTiGlzYkQvlf+tkrQy5DA
         C1vzVSgZopB0A8UQ/DbGM+og6wBZi/z3q9a+zeJgrSia/MqGMu/LSF7Mx1zkDfynT4Q1
         +uKH/R8RQ0HWwpDwQiYh6ugqBeoU5IGaFkcwSPoBkWsYYvpxxtgbieJ2VjLJr4emvfoi
         ckQA==
X-Forwarded-Encrypted: i=1; AJvYcCUnbejxGt2d/i5BMkJ4IBlUA3Ntfu+6+OWW+a0vxs9LT/pwVEHTIe+JuXQuU1KC3/GzrUQdholIelwomgLH@vger.kernel.org, AJvYcCVolXa6Oe32so6DWM+gAkOQIcafHxz2+2/bKhsT321DVfKb+oPmB09ZRDjT/Kz6Ch6mUWRvqmN6it6qeTeh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KcTweEXCcWbdteqy4+fJEUHLWAgho9bIgqi1UYm85xUthRO6
	suANuTE9JxKCWjGGfwKwNH7YKiYCt+7BaiylNNUxIbP0+ZsRQNHb
X-Gm-Gg: ASbGncsErwl0IwaIEPJ/7ONufafMPUZVJfpCo1E84BL2iMljSl23Y+q+mo2hx90oCgd
	8utzxRihosCjJCJm4/FNeJs9PTB61C+VeKG7AkOYTMwKLuMBwyKsLDu8iGgOm9nChWtLPUiyb/3
	NSe7rntA7CIlSDMH/8ToopHysxD+oJqsaPOExhF0Y0c+RXiYCw5ja/Gb3F/TYpbg/8ZhpU7KN9R
	Y52BZxtZ045INuzVZGRBzmeFDUVJ3IAq6dxkpqe9AptU2vJvUKGvmE/yUyEuZeCIiLlbPOZhvTY
	dGpy0R+7s2Losx5RLa3Qbitn6J8vh8B48kFOMv7Api7mHyFNQe6/hOK3bWQ=
X-Google-Smtp-Source: AGHT+IEPL3Q5+UVSkZcl/fqItf8L7ROZ4xLCJwGtQWctIfqwZLJuQARHwtWzba4amfmd7oAvHVT1AA==
X-Received: by 2002:a05:6402:13ca:b0:5e8:bf18:587 with SMTP id 4fb4d7f45d1cf-5f62855c745mr1824756a12.16.1744980610653;
        Fri, 18 Apr 2025 05:50:10 -0700 (PDT)
Received: from f.. (cst-prg-69-142.cust.vodafone.cz. [46.135.69.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625549f34sm937589a12.4.2025.04.18.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 05:50:10 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] fs: fall back to file_ref_put() for non-last reference
Date: Fri, 18 Apr 2025 14:50:02 +0200
Message-ID: <20250418125002.59045-1-mjguzik@gmail.com>
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
index 7db62fbc0500..0f25ba769f48 100644
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
+		if (likely(!atomic_long_try_cmpxchg(&ref->refcnt, &old, FILE_REF_DEAD)))
+			return true;
+	}
+	return file_ref_put(ref);
 }
 
 /**
-- 
2.48.1


