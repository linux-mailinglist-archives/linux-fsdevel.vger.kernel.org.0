Return-Path: <linux-fsdevel+bounces-66454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C690AC1FA4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ECAA4E9138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD71A34DB57;
	Thu, 30 Oct 2025 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsLfCX6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787831691B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821459; cv=none; b=ozPgvgtgAqM8cpCQMT+akpoCggKK0YlJr1DO+kOU+qwWoOEBULPSwSWPN7/pLjnX4F9LpaonG5oZU085un2utaE0LtztHhAxNM7IiubF2C0SpC46RGkwbeo6De29co+5M1lZ3cXeCTBTCaJXtN9GBvWFkUfpv+uw1wiDoCp+LEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821459; c=relaxed/simple;
	bh=Z65r92Iy2Q3CoYFPJWy7LQqKUZs3WILjXTH/na653E8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntibJHvsn23uV1LnIavPoIZ6GPXsNhimX40rRUyFtEUVHyVcnw0EUUYxY5MSxJTrtrzJcJD4SFXf7LYvUcBIWW/yS5ZwawFFlzQLehbMJsydUgfbQ+dqWWZpTBT6UO+GCWIqr2K2+T66MDE+fXXOJzWynArqq71wZtJTw8t9sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsLfCX6W; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so1709539a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821456; x=1762426256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Htru6j8PSSiIR1VQ1fEimOHGXjE7Hw+9EJBZAr9lACM=;
        b=bsLfCX6WFDWoEhgmDxgKUjd9MnX8pT+XuMyA/N9LC824zh36H+nMPPOBtSTSu3WDdf
         /jYMZcK8YHQpa1XY6kf69wAwA+i1GSLnKhBWv4BaA43/ozsiJCDVl8eViurasw3jH7sk
         opbI1FDCJ+V0scR2kNZH4/7EMyohf+rrZpaClJupYApdJezUHyqb/4zAYRrBqCV64/Dh
         skY5t/76NoAcNQGwpB4Fr4xB4t7MtS6hZha2kY+xLqqgZwRBTORoeSr3jvQhLeYNoVgT
         z2u9wTFIOsp5lyejizPdOfyrsmyXC2wyE9F2mxkxRfpqKFGb8H2DyfeEjKan90KSO5D7
         yGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821456; x=1762426256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Htru6j8PSSiIR1VQ1fEimOHGXjE7Hw+9EJBZAr9lACM=;
        b=hFf07Zi1AygNILemDSWNgUymAlctzqh5b2uJRD0nsOL30yy8PzwesCEUcEI4soYIWQ
         2arV7a8/vNnq9ZbW8C90cL8qiS1MZ5jNzhrY0qh/gKneMaEQq7SZNJSvMeIE9E6cw2AF
         5f3AcUpM4twcmYeO17m3pjGmZAwaq/o4f945gBefRKJgWA4byyt5DFInOR2HGYgzzSsy
         Mb/yYAzo9vbIGZj92+byQuWYZS8bEbpBdYAueLESwNPTpLT0HGEXtIqN2eVlaegciIvD
         K2BPS3BGHnUeXAmw0HvQ8+FIqjQOsrmxNNTb7LOoq9A1hMq61U4nVg2q1LGb5M+mWHvK
         FLDw==
X-Forwarded-Encrypted: i=1; AJvYcCW4vD+bK8CQoOubPWEJ+3mo8CJH9pN2wTQwH8T1AQsmjf4J4Ch15JUaRRdMcNH9buh59y/6yItQPCG2Gj9l@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dxsMuoaaacpCwCMzA3FKafBL+2qlhHXmxGh1HX2AbqadYw9Q
	Z8ZNL/W6LRv42bmu+Rrzwq1T/f3VfIE1HskcgzL7hTtyShKwyV8L70C3
X-Gm-Gg: ASbGnctoBN0rkSrfepYlTjtV4deaMAmZNru1Kn+LT5vg+ciNYMhRPL3A7QQIq51cRhy
	+U8stFfahet5131VlV7LbpVH7n6wiAOc+vl4ELr31F/9uB0344WkosoQMh4AhGGdyXVPhFMQP3Z
	BmXBhTisjj94pssyQ3wmtLvCzuDNIRSdz8g2KQXvvEQ3klhzOh8WzETMtj652j2W98v8xWtJoZ3
	pNwJEdUTFk7TlTpBxBL9trMVmMVYY0rVvgHj0zgSWDjUP+t02rvNbRCWtQPWoT1E1VwBc9Ut8UK
	otyemlBmANI0u2P4vc6h5MuuXdTA4IGS17wkp9rMiqMhl52rTX9fsNbsBIzScXpLA4B8A2Gpvsp
	A2M+vdiMTJ9Ixb4SYjvAlsOaebfxB6pPMVkIWAN/OEPPzxcKWdPg1JpvBAJ0uJxtkIRjOsmDSoD
	8w/QKZcGB04Iz2O+3vYTU878XDLC2+Xgw4WrYDArLPaFI4MZRaocKS8014nE45vh+f2AQwLQ==
X-Google-Smtp-Source: AGHT+IFbURpoPAGpRiSRMFRlNznYmuKDxQh8Pl5N/zDoikMkUdg3+md8B44MHCxo/RRseAvJFoFKhg==
X-Received: by 2002:a05:6402:4311:b0:63e:1e85:6e71 with SMTP id 4fb4d7f45d1cf-64044197c7dmr5303481a12.6.1761821455320;
        Thu, 30 Oct 2025 03:50:55 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm14567185a12.37.2025.10.30.03.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:50:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] fs: hide names_cachep behind runtime access machinery
Date: Thu, 30 Oct 2025 11:50:47 +0100
Message-ID: <20251030105048.801379-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The var is used twice for every path lookup, while the cache is
initialized early and stays valid for the duration.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

ACHTUNG WARNING POZOR UWAGA Блять: the namei cache can be used by
modules while the runtime machinery does not work with them. I did some
testing and ifdef MODULE seems to work around the probnlem, but perhaps
someone with build-fu could chime in? I verified with a hello world
module that this works fine, but maybe I missed a case.

v3:
- fix compilation failure on longarch as reported by kernel test robot,
  used their repro script to confirm

v2:
- ifdef on module usage -- the runtime thing does *not* work with modules
- patch up the section warn, thanks to Pedro for spotting what's up with
  the problem

Linus cc'ed as he added the runtime thing + dcache usage in the first place.

Per the above the machinery does not support kernel modules and I have
no interest in spending time to extend it.

I tried to add a compilation time warn should someone compile a module
with it, but there is no shared header so I decided to drop the matter.

Should someone(tm) make this work for modules I'm not going to protest.

Vast majority of actual usage is coming from core kernel, which *is*
getting the new treatment and I don't think the ifdef is particularly
nasty.

 fs/dcache.c                       |  1 +
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 13 +++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 035cccbc9276..786d09798313 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3265,6 +3265,7 @@ void __init vfs_caches_init(void)
 {
 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
+	runtime_const_init(ptr, names_cachep);
 
 	dcache_init();
 	inode_init();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dcdbd962abd6..c7d85c80111c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -939,7 +939,8 @@
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)
+		RUNTIME_CONST(ptr, dentry_hashtable)			\
+		RUNTIME_CONST(ptr, names_cachep)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..1095aff77a89 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2960,8 +2960,17 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+/*
+ * XXX The runtime_const machinery does not support modules at the moment.
+ */
+#ifdef MODULE
+#define __names_cachep		names_cachep
+#else
+#define __names_cachep		runtime_const_ptr(names_cachep)
+#endif
+
+#define __getname()		kmem_cache_alloc(__names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__names_cachep, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


 fs/dcache.c                       |  3 +--
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 035cccbc9276..ef83323276f0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -35,8 +35,6 @@
 #include "internal.h"
 #include "mount.h"
 
-#include <asm/runtime-const.h>
-
 /*
  * Usage:
  * dcache->d_inode->i_lock protects:
@@ -3265,6 +3263,7 @@ void __init vfs_caches_init(void)
 {
 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
+	runtime_const_init(ptr, names_cachep);
 
 	dcache_init();
 	inode_init();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dcdbd962abd6..c7d85c80111c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -939,7 +939,8 @@
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)
+		RUNTIME_CONST(ptr, dentry_hashtable)			\
+		RUNTIME_CONST(ptr, names_cachep)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..cfaabd4824f2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -50,6 +50,8 @@
 #include <linux/unicode.h>
 
 #include <asm/byteorder.h>
+#include <asm/runtime-const.h>
+
 #include <uapi/linux/fs.h>
 
 struct backing_dev_info;
@@ -2960,8 +2962,17 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+/*
+ * XXX The runtime_const machinery does not support modules at the moment.
+ */
+#ifdef MODULE
+#define __names_cachep		names_cachep
+#else
+#define __names_cachep		runtime_const_ptr(names_cachep)
+#endif
+
+#define __getname()		kmem_cache_alloc(__names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__names_cachep, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


