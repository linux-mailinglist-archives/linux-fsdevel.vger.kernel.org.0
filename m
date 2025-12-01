Return-Path: <linux-fsdevel+bounces-70299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DACC962BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2D23A1C6F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A82D77EA;
	Mon,  1 Dec 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFjKoQ82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63225290DBB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764577957; cv=none; b=upUhYBaqI7B9JCzQqUhrUq7tIXPhavuIlx8rv+7BqqGVgNDimmdMqIH2iaZs5hxKRzUV+8rhy430Ni0UuklHmfbhzo/0ccoRhh/8mYW8SfnU7tWlgY0bPx2pbbW7IYexHOWCaWG/PNA+bv8MT406TGpvonh9xy828iy2c4cjghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764577957; c=relaxed/simple;
	bh=WouL/gXxoaw+fgKLIDXK8/ULsHp1Pa0MmL1z6JvimiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGryjf8fR9hLPPsMQZ9tQ9Wn3T2nrkDAwqU6ZWu7d7NhXT0tDeBywbzwqWLxPkS2VHviUbsmOAKtQkNrgz8fjVpOPO/LJr821p8OJsVowDN+mFm3Z0enpX3g0AY6crN47lmOAi7vCA2l/bU7n69ifv8qqYWhn+htNeGIbVd/80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFjKoQ82; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so179167a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 00:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764577954; x=1765182754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agur13uatpBfTbiWy9CXQ832nKs/hmYFvcnvXcVIbzE=;
        b=hFjKoQ82PBlRP7uARebQtTKyzrr4gIcwZhUY6riLp+1o3ZKvh3MS03G1e8FRY5Ijbb
         q9WHhVp+ftCC+jZ97RLvcftOw1J5ckd86VZPbH2z+XHs0umjzsvwB2qFQc55AInqAHim
         3TjnVMw9XOJeUy0KPBZuwexjPqeFcdyOTWbtlP332p02EjsjWCVlUNM/XiOXxF0Jfpii
         QePVZDjwf7pmSOaRpVZ5HZZ/B+OcM3gfiw/hiZnAm3jaMAfV75Lye/jlDwcIXRMjzwOe
         aRJfK5tpQpIKSyfB6X/kYX1B5I9MwiuGdWbMxA9mQmIWQAkRcl/42ccoF3PqxS4p/w+m
         SA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764577954; x=1765182754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agur13uatpBfTbiWy9CXQ832nKs/hmYFvcnvXcVIbzE=;
        b=QrbSu3K7xTnoDXidDZfNzZ/Y/UYoRpyNeMnYnzb/bE008M147ERU8PwcV2kfOrpJhj
         IyKnc2Thsbm7PPR4AprYRHnO57eZcpYU+fQi40WS/W7bC6aRIsywRiE+xxi6GLOVE/Ae
         zV1NesAIY8A8VsJXY10kdKxnDkfzIGZEUrINH2ypY6wIj66KMHeCJF/cWXwrlEkGAlj7
         W8RaQjJUExmd7gvo/ZcFOUI22Pxh1pGyrIpPMNeqrnjjv8qAxrOEiCiktAumiAHaktMK
         cZcUlQTrRJZX0atOW/OCUWeEJJQ5J6qfVfpCHUak3W92agbb5mfJ4XIAhAaDSqpY8Jee
         i/yg==
X-Forwarded-Encrypted: i=1; AJvYcCUpXveAi4a1b5nCJDblYk0NWP7wh1WJZbHEGLR59gl+gDDhKsmZdOthAnMR2emuY5AwE/k1hvGd7MQi59Pp@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgDzaMp9CoCUV1IVDPfY56YVdXO947XfuENzlOiylRxS82tNq
	yHie+WMnIiwvPvrCUck02nG8lV5ngAM4GuLeJKFROJkbSWTKxREdUIc0
X-Gm-Gg: ASbGncvtCVhJ2yWNB1NMbXF0gPnWvoJtadSdvPAqzFtfpPQsusz7zsOvL0u7byCaKjZ
	6OgQBZ4rPOUqHR+DB01D6i8Dc45RvrGLLGpZHZCebkkfkcQdbffp9DaKp1vLkwb2emfC7Gl1hrI
	VP7JoK+lWQOlipj5dVlEu4j9kpMfB3tD8khfJpHNsKSN2OKd1aANG0O7vgW9RRbFYyygk66qLjz
	aBRLNhdb+ZcRNYyRWhKO+/VAD02bs0D2SAnwVkEpU0TJ9ok6gZ1X6zk/jYAEAIOXWqz308tJ/+5
	e20hTNvoY/gsKKQVj3C+rZjw2QacEifDy0Rr9IabEW+gPHpHhmNTcUTWEuvb9+L6SPfOkPMZE7v
	Td0a9pyiMvnVhmWk4TW8hRdo5kKrOJCcTxePSTr4n8Awl6VrO17joE+accc5wQQ+HHJi1c+tagV
	aXhaAH1uWJObzHYkCSAS8Kt5pykqxgEXswCssxSgnnwU4hhGK3Nx9OUZNxVH0=
X-Google-Smtp-Source: AGHT+IFkO0hcC2MDPwV3l3Gu5TfNfGl5BIcxQ6u4IdLB8tg7tP4Nx4BvTYET2NVBhKoWf3cisrJZQQ==
X-Received: by 2002:a05:6402:3594:b0:63c:3c63:75ed with SMTP id 4fb4d7f45d1cf-645eb2a83b2mr22977341a12.22.1764577953520;
        Mon, 01 Dec 2025 00:32:33 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90d14sm11947696a12.10.2025.12.01.00.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 00:32:32 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: hide names_cache behind runtime const machinery
Date: Mon,  1 Dec 2025 09:32:26 +0100
Message-ID: <20251201083226.268846-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/names_cachep/names_cache/ for consistency with dentry cache.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- rebased on top of work.filename-refcnt

ACHTUNG: there is a change queued for 6.19 merge window which treats
dentry cache the same way:
commit 21b561dab1406e63740ebe240c7b69f19e1bcf58
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed Nov 5 16:36:22 2025 +0100

    fs: hide dentry_cache behind runtime const machinery

which would result in a merge conflict in vmlinux.lds.h. thus I
cherry-picked before generating the diff to avoid the issue for later.

 fs/namei.c                        | 16 ++++++++++------
 include/asm-generic/vmlinux.lds.h |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d6eac90084e1..eff4cbffe241 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -41,6 +41,8 @@
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
 
+#include <asm/runtime-const.h>
+
 #include "internal.h"
 #include "mount.h"
 
@@ -124,23 +126,25 @@
  */
 
 /* SLAB cache for struct filename instances */
-static struct kmem_cache *names_cachep __ro_after_init;
+static struct kmem_cache *__names_cache __ro_after_init;
+#define names_cache	runtime_const_ptr(__names_cache)
 
 void __init filename_init(void)
 {
-	names_cachep = kmem_cache_create_usercopy("names_cache", sizeof(struct filename), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct filename, iname),
-						EMBEDDED_NAME_MAX, NULL);
+	__names_cache = kmem_cache_create_usercopy("names_cache", sizeof(struct filename), 0,
+			 SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct filename, iname),
+			 EMBEDDED_NAME_MAX, NULL);
+	runtime_const_init(ptr, __names_cache);
 }
 
 static inline struct filename *alloc_filename(void)
 {
-	return kmem_cache_alloc(names_cachep, GFP_KERNEL);
+	return kmem_cache_alloc(names_cache, GFP_KERNEL);
 }
 
 static inline void free_filename(struct filename *p)
 {
-	kmem_cache_free(names_cachep, p);
+	kmem_cache_free(names_cache, p);
 }
 
 static inline void initname(struct filename *name)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 20939d2445e7..3abd76ac723a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -956,7 +956,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
 		RUNTIME_CONST(ptr, dentry_hashtable)			\
-		RUNTIME_CONST(ptr, __dentry_cache)
+		RUNTIME_CONST(ptr, __dentry_cache)			\
+		RUNTIME_CONST(ptr, __names_cache)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.48.1


