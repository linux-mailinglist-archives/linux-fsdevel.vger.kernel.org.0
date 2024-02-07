Return-Path: <linux-fsdevel+bounces-10562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DDF84C48D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 06:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CD5B20E44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F80A1CD13;
	Wed,  7 Feb 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/vAR3l3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703F1CD1F;
	Wed,  7 Feb 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285543; cv=none; b=g/nlXoBRu2JsiwjiLUtO/UqZDWzazhYNX0PuB/I8gRuOj7ex37meYdN84k7XIzfxuRIOmYevyhFi2Ni3e2dvKHt+Zv3MOi+7BHNhbR2dJ7ujxDHS9nR0KIIj/MsYVSkMehItMo04+MCia3zQVN8jQQQffLLXOPaA16s96jvGBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285543; c=relaxed/simple;
	bh=/A2CuqUaviVLc8uxe4U+4x+W/vxua+zfrfUWkP8fdMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFkSr9KlTm+fM8Ixznue0Umt8dUIJTJnGc6UPCHOkVWU9CFOJ6ojHwtilyDV6hGMRXpuOqYQo7IcKOJf6eRMvnSHFmqeuT5s1I6my0FVnzEfNVt1uTFT98HtEX/jSpoovcooiRY0BPj4oANKzN8M4vA8SWxwhEWD51cz+74o6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/vAR3l3; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so102467241.2;
        Tue, 06 Feb 2024 21:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707285540; x=1707890340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+4UD2Jypdak0SBU5rEy7o1e/eSN2ARp9yL+M+702JQ=;
        b=c/vAR3l3vy37weURzJeLHswVWql2mxmSOqaZY59CUMQDXJjEa02xCVYii8dfw9LLrg
         lbFLwvL5v9ZznbAVGLbckXBYDiW7ZoKWQ7xwlMkZDYfVyZtXGQHlp2MzOx6pqa5eQscn
         JYX2Zirmv7CKWDs3PQjrIzdviZCUQGoIoW3/rveQHfUCwFIEtQpcD2atP0n3UtcX4qZm
         gUhpxdFnSbL6ljzbPmq7gSszvFvlwlNe9BVUF34SXRpzirjFWRkXa69tbT0bzMySsifQ
         1xnqefkv7ZtdDVrQ0o5YmuYW6W8eAmDHwa/+qdqCBiwguid2bUh1gSCmR+WBXKM/kDVY
         7r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707285540; x=1707890340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+4UD2Jypdak0SBU5rEy7o1e/eSN2ARp9yL+M+702JQ=;
        b=e5QzwI6adAn5iwkOTIl7FU6Q7iS5NRtJxWnoOm0jIWEfOAsbs7YTe3h5Yvja1xqEuj
         Ssd8a1xlwpGwx56syBd37fg+K+PWuqFkxXtif+Rtwq+lILNoE9w7nJH4QtUIUZxABHMg
         GMY9tqwkFL0sNqOMnneKMXrDDXrSNCLLOcJDmkJboh3pNluYZjTEAuXAJM7KRE5ZSC5S
         M/NKXgDy4UrOaAbfrSp6fN5O9OsP3osbVzgTmZiUtukmJyDmfnTbzhT2Vzck6w7C61B3
         0itu5j/BSzkPTxdA5N5R7XEcxIy3ayKXbPd4K8alyrZ/PWLrnSdJhN1QaOocigiXYPR8
         FXBg==
X-Gm-Message-State: AOJu0YwE4DNh7yFuHGBVxXzSmQX7RbrRDaHUGqGC1xP5KhS7Fhg45ev9
	aNBKCef3XBpPYTpMFftnioDKVuaQpOoirA+8KdHswrD4BxSqMYO5JoYxTaEKDwU=
X-Google-Smtp-Source: AGHT+IFYpdfbwEmVRWMhgDtfEsKiCbo4I/ZHiW1sauDuBncos5+15k+tfHddjjJBDSxloGb1eTEIgQ==
X-Received: by 2002:a05:6122:1b09:b0:4c0:1e9f:6576 with SMTP id er9-20020a0561221b0900b004c01e9f6576mr1934399vkb.10.1707285540113;
        Tue, 06 Feb 2024 21:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIiR17ALAynCUofpgFob5XnhENxVj09T/OUmLZnqpm4TCTxm8GMYLJERawVjTY/VoOxXdYT4wNypVp/uPH32km6uVSScOlWmHEDKUJPlSn9Iiwbb+r8dQY1SMhF/En4ieGaBlh/Yb77m5RYdqz1PCfh6CJfskC+Qv0Sn+2ti13A6Xz8br3wgtgJKtipovTrqrDRaO83TQo9E194nMOAh399AqqaO9Dv1IAhgnUBg/8Vk1e4TbW6aBTeOCtvWSKI3SXwpfxyPBpOAOF+TvgAJEAb1BCLpYgnRnB
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id ep25-20020a0566384e1900b0047125710091sm114810jab.20.2024.02.06.21.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:58:59 -0800 (PST)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kent.overstreet@linux.dev,
	bfoster@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH RFC 3/3] bcachefs: introduce Rust module implementation
Date: Tue,  6 Feb 2024 22:58:45 -0700
Message-ID: <20240207055845.611710-1-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch uses the bcachefs bindgen framework to introduce a Rust
implementation of the module entry and exit functions. With this change,
bcachefs is now a Rust kernel module (that calls C functions to do most
of its work).

This is only if CONFIG_BCACHEFS_RUST is defined; the C implementation of
the module init and exit code is left around so that bcachefs remains
usable in kernels compiled without Rust support.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/bcachefs/Makefile                   |  3 ++
 fs/bcachefs/bcachefs.h                 |  5 ++
 fs/bcachefs/bcachefs_module.rs         | 66 ++++++++++++++++++++++++++
 fs/bcachefs/bindgen_parameters         | 13 ++++-
 fs/bcachefs/bindings/bindings_helper.h |  4 ++
 fs/bcachefs/bindings/mod.rs            |  2 +
 fs/bcachefs/super.c                    | 31 ++++++++++--
 7 files changed, 120 insertions(+), 4 deletions(-)
 create mode 100644 fs/bcachefs/bcachefs_module.rs

diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
index 3f209511149c..252810a4d9a0 100644
--- a/fs/bcachefs/Makefile
+++ b/fs/bcachefs/Makefile
@@ -89,8 +89,11 @@ bcachefs-y		:=	\
 	varint.o		\
 	xattr.o
 
+bcachefs-$(CONFIG_BCACHEFS_RUST)	+= bcachefs_module.o
 always-$(CONFIG_BCACHEFS_RUST)		+= bindings/bcachefs_generated.rs
 
+$(obj)/bcachefs_module.o: $(src)/bindings/bcachefs_generated.rs
+
 $(obj)/bindings/bcachefs_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
 
diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index b80c6c9efd8c..3a777592bff4 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -1252,4 +1252,9 @@ static inline struct stdio_redirect *bch2_fs_stdio_redirect(struct bch_fs *c)
 #define BKEY_PADDED_ONSTACK(key, pad)				\
 	struct { struct bkey_i key; __u64 key ## _pad[pad]; }
 
+#ifdef CONFIG_BCACHEFS_RUST
+int bch2_kset_init(void);
+void bch2_kset_exit(void);
+#endif
+
 #endif /* _BCACHEFS_H */
diff --git a/fs/bcachefs/bcachefs_module.rs b/fs/bcachefs/bcachefs_module.rs
new file mode 100644
index 000000000000..8db2de8139bc
--- /dev/null
+++ b/fs/bcachefs/bcachefs_module.rs
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! bcachefs
+//!
+//! Rust kernel module for bcachefs.
+
+pub mod bindings;
+
+use kernel::prelude::*;
+
+use crate::bindings::*;
+
+module! {
+    type: Bcachefs,
+    name: "bcachefs",
+    author: "Kent Overstreet <kent.overstreet@gmail.com>",
+    description: "bcachefs filesystem",
+    license: "GPL",
+}
+
+struct Bcachefs;
+
+impl kernel::Module for Bcachefs {
+    #[link_section = ".init.text"]
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        // SAFETY: this block registers the bcachefs services with the kernel. After succesful
+        // registration, all such services are guaranteed by the kernel to exist as long as the
+        // driver is loaded. In the event of any failure in the registration, all registered
+        // services are unregistered.
+        unsafe {
+            bch2_bkey_pack_test();
+
+            if bch2_kset_init() != 0
+                || bch2_btree_key_cache_init() != 0
+                || bch2_chardev_init() != 0
+                || bch2_vfs_init() != 0
+                || bch2_debug_init() != 0
+            {
+                __drop();
+                return Err(ENOMEM);
+            }
+        }
+
+        Ok(Bcachefs)
+    }
+}
+
+fn __drop() {
+    // SAFETY: The kernel does not allow cleanup_module() (which results in
+    // drop()) to be called unless there are no users of the filesystem.
+    // The *_exit() functions only free data that they confirm is allocated, so
+    // this is safe to call even if the module's init() function did not finish.
+    unsafe {
+        bch2_debug_exit();
+        bch2_vfs_exit();
+        bch2_chardev_exit();
+        bch2_btree_key_cache_exit();
+        bch2_kset_exit();
+    }
+}
+
+impl Drop for Bcachefs {
+    fn drop(&mut self) {
+        __drop();
+    }
+}
diff --git a/fs/bcachefs/bindgen_parameters b/fs/bcachefs/bindgen_parameters
index 547212bebd6e..96a63e3a2cc3 100644
--- a/fs/bcachefs/bindgen_parameters
+++ b/fs/bcachefs/bindgen_parameters
@@ -1,5 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
---allowlist-function ''
+--allowlist-function bch2_bkey_pack_test
+--allowlist-function bch2_kset_init
+--allowlist-function bch2_btree_key_cache_init
+--allowlist-function bch2_chardev_init
+--allowlist-function bch2_vfs_init
+--allowlist-function bch2_debug_init
+--allowlist-function bch2_debug_exit
+--allowlist-function bch2_vfs_exit
+--allowlist-function bch2_chardev_exit
+--allowlist-function bch2_btree_key_cache_exit
+--allowlist-function bch2_kset_exit
+
 --allowlist-type ''
 --allowlist-var ''
diff --git a/fs/bcachefs/bindings/bindings_helper.h b/fs/bcachefs/bindings/bindings_helper.h
index f8bef3676f71..8cf3c35e8ca1 100644
--- a/fs/bcachefs/bindings/bindings_helper.h
+++ b/fs/bcachefs/bindings/bindings_helper.h
@@ -1,3 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include "../bcachefs.h"
+#include "../btree_key_cache.h"
+#include "../chardev.h"
+#include "../fs.h"
+#include "../debug.h"
diff --git a/fs/bcachefs/bindings/mod.rs b/fs/bcachefs/bindings/mod.rs
index 19a3ae3c63c6..d1c3bbbd7b5a 100644
--- a/fs/bcachefs/bindings/mod.rs
+++ b/fs/bcachefs/bindings/mod.rs
@@ -1,3 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#![allow(missing_docs)]
+
 include!("bcachefs_generated.rs");
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index da8697c79a97..343c4bc6e81c 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -69,9 +69,12 @@
 #include <linux/sysfs.h>
 #include <crypto/hash.h>
 
+#ifndef CONFIG_BCACHEFS_RUST
+/* when enabled, the Rust module exports these modinfo attributes */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kent Overstreet <kent.overstreet@gmail.com>");
 MODULE_DESCRIPTION("bcachefs filesystem");
+#endif
 MODULE_SOFTDEP("pre: crc32c");
 MODULE_SOFTDEP("pre: crc64");
 MODULE_SOFTDEP("pre: sha256");
@@ -2082,6 +2085,7 @@ struct bch_fs *bch2_fs_open(char * const *devices, unsigned nr_devices,
 
 /* Global interfaces/init */
 
+#ifndef CONFIG_BCACHEFS_RUST
 static void bcachefs_exit(void)
 {
 	bch2_debug_exit();
@@ -2109,6 +2113,30 @@ static int __init bcachefs_init(void)
 	return -ENOMEM;
 }
 
+module_exit(bcachefs_exit);
+module_init(bcachefs_init);
+
+#else /* CONFIG_BCACHEFS_RUST */
+/*
+ * bch2_kset_init() and bch2_kset_exit() are wrappers around the kset functions
+ * to be called from the Rust module init and exit because there is not
+ * currently a Rust API for ksets. If/when a Rust API is provided, these
+ * wrappers can be removed and the Rust kernel module can use that directly.
+ */
+int __init bch2_kset_init(void)
+{
+	bcachefs_kset = kset_create_and_add("bcachefs", NULL, fs_kobj);
+
+	return !bcachefs_kset;
+}
+
+void bch2_kset_exit(void)
+{
+	if (bcachefs_kset)
+		kset_unregister(bcachefs_kset);
+}
+#endif
+
 #define BCH_DEBUG_PARAM(name, description)			\
 	bool bch2_##name;					\
 	module_param_named(name, bch2_##name, bool, 0644);	\
@@ -2119,6 +2147,3 @@ BCH_DEBUG_PARAMS()
 __maybe_unused
 static unsigned bch2_metadata_version = bcachefs_metadata_version_current;
 module_param_named(version, bch2_metadata_version, uint, 0400);
-
-module_exit(bcachefs_exit);
-module_init(bcachefs_init);
-- 
2.43.0


