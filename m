Return-Path: <linux-fsdevel+bounces-66455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B365EC1FA67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7D345718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA0354715;
	Thu, 30 Oct 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N852fcS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD8354AC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821571; cv=none; b=idz5zYw63wPzvYycTGb2FX11tHZI1I/lVOHI39ytrlEPI+C0XxnOnXPReAqmJQrhr5vE0hKMwA5J1ngetUuebIIqYRIhZtdcmwR8h7w11LkYAROTYI4DDay89RPd/TPhlzxLC0HClGrdIZoySyLdGvxT9+0vXkr8XsfOw3P2jNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821571; c=relaxed/simple;
	bh=Mos+bVHWWaIClE7j2ZiSkxnpxLMWWphG3MVvM2Pmiws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WCR5fe8D2AEhJTxeGrpx2mzNSCRmaB5Cocq7kG7cVkyg0G1aNxVh0y4jQVvR0F6lcJTGwgLD6WgLSHYy8EKlh+7H9lnLf7w7fMRyViWdieh65CxeFEPxXpMBtTkKC+mGv9OJN4qEAGI+PGMqxEaDzHhQhdA6zT175fNe4I+tMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N852fcS/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d855ca585so197945866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821568; x=1762426368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2fMs//ttuDkI1LP3R5XEdMm907B0irHXCx1o3kP9jo=;
        b=N852fcS/spNy4VGFx7HZcuVGDFi3qyXDnRg6uZAF69xD9sf5nBHBsjAwi6TFJL8xIH
         eZdRg/2GvsSdFBoMNl1zrgC5SWvQ7ufjK9ZnlTlbKnc/3VsWIfFQT98gmQWV/B25/Rn2
         R4UFZqGYWkRyken/34M6WpLQBBle8VZrxejeolbXAUWkbIaJAoZdJDbDCgd+0T7F29m9
         YwcKCb6zIptRye0/BSWtZ99XZCGsrlPTTiFvMVO3sK65Xwy3jBFjMdUNpOS23FgafTJV
         AtopWkwC6rmDkgjKs4R3BzzWHVW0NwajTUIG3hFjv5b/CKmpv5UqkF0nWGaaa89kW0LD
         X95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821568; x=1762426368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2fMs//ttuDkI1LP3R5XEdMm907B0irHXCx1o3kP9jo=;
        b=jTvxs6CvNRZ44JHcIwbNwufD0hYJvVz0qphs6PUdhOwbruJm6L7cUGk092cI8yqWD5
         LSHbRAHd/CLS1cJ5N63FU5DvTfuFtQTbrDIIIMU7OzvD3NLUq0d1SnTobwQOytDno6YE
         qk4cdNcXQcRQdIBVWVktnDVWj+ZsQtqWCV1fRnP0NZRbJwY6OKtBpUnUpWjWW5hDCFrG
         K+xSoy9E0fEqSuCxKHYrR6cuabvLiwzEHJdAt2HK9xnq7RXYg7MODUgdn9IAWiU8yrzp
         QHmnaY/lypUFy1bOQ1J1O2eY3K4ue4r2KGHeMKvvb6Jopoqn9eXnetQ86HXoml/opIsA
         eNjA==
X-Forwarded-Encrypted: i=1; AJvYcCW43r05Ass8PU+GLIPMMwKM4gWr4uTMrR4LyTV9Nh6enrQCE8JRVm82cqXQH30EXoz6ev/qZhErbHVbiaTY@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqEgIySUyC8T8Sg80fu3NE2JSMFkUtx0gzmS0UVlq2tMKyF2V
	QpNsqMB0irXxEdrxIO3fQAec/HhxTPp4hjDJva5nJpoAXR2R8+hLttHe
X-Gm-Gg: ASbGnct7O1ULDV1MRehZ/L6z4KLt/KCsZonmql2HdAxH4Rj9cMM+R4VE9aPe54P68Cv
	r77zrpvaytK5IBOOAUJkT07j83oY/n0y8ylVp3yXSlj0QViTaCnJkQlMmCArGsb2h9mzcS22Kpx
	2q07jYtcYKvoemiOHLuYxyfvzLUVyZmeq7FIWPRVxctmWYhds2PddiNi/w30NKra2I5PNKLLWHe
	/UpUSelxn0m4/PXy74ssQGj4vnhkFFGLF1S1CPh3DDs5Qtd4gY90VZnIX6nbx2MSp0cqqRqgU5Q
	gYoOGIZarQCdOx9njh5WQIEIz+JomUmQ03iSJ/6rdDlT9FfcqiwSep7+rQQhIVExfpGPPiEJwea
	Mi16g5nGBWdCLpuZOfGtQpM5Hu6r6nWDDxVlQTeUDO3SzQ8xRrKx/mUsy5i1lPfKtyB6mFjDEdY
	wwtXv3bSn9BVIBkpHvm5QGzFA3Y5Go6xbfFRmYVTOjD4UBcmsf
X-Google-Smtp-Source: AGHT+IFMTygC3+gqrtXUUzH1zNbg/OMlbiBBICFZ1UC/Za8Di5ViFt9D9cLL/GISuOPRk7evbrcVxQ==
X-Received: by 2002:a17:906:9fcc:b0:b4f:ee15:8ae8 with SMTP id a640c23a62f3a-b703d5cb622mr617942666b.58.1761821567542;
        Thu, 30 Oct 2025 03:52:47 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6da1e2226fsm1301118166b.20.2025.10.30.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:52:46 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Date: Thu, 30 Oct 2025 11:52:40 +0100
Message-ID: <20251030105242.801528-1-mjguzik@gmail.com>
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

v4:
- unbotch the diff below, apologies for the spam

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


