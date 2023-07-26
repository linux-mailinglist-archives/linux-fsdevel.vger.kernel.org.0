Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F4763CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjGZQrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGZQrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:39 -0400
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBE12712
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4965; q=dns/txt; s=iport;
  t=1690390032; x=1691599632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/lTVDEDYHsEdChSzawXjVr0aEd2CSBfkYp/e9QDjEg=;
  b=mUQ/xUq4eVO3OvopZC66mU5sZHKkxUHRKKjv5JlWWQ9H6L6KkngM/uog
   0t1eDl1B4WOZL2vwlHWYZiI5zfoAF5jqqL6cKdiox5WBdhSFSJNlk1JBE
   QBwV0REeVyoSm3EP8C+li6OnZg00hVNpQH8bllawuACDte3GgfPzvmqcZ
   w=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="5874456"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:04 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTr022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:04 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 01/10] samples: puzzlefs: add initial puzzlefs sample, copied from rust_fs.rs
Date:   Wed, 26 Jul 2023 19:45:25 +0300
Message-ID: <20230726164535.230515-2-amiculas@cisco.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726164535.230515-1-amiculas@cisco.com>
References: <20230726164535.230515-1-amiculas@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas
X-Outbound-SMTP-Client: 10.61.98.211, dhcp-10-61-98-211.cisco.com
X-Outbound-Node: aer-core-7.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 samples/rust/Kconfig     |  10 ++++
 samples/rust/Makefile    |   1 +
 samples/rust/puzzlefs.rs | 105 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 samples/rust/puzzlefs.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 2bd736f99189..05ca21fbba06 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -40,6 +40,16 @@ config SAMPLE_RUST_FS
 
 	  If unsure, say N.
 
+config SAMPLE_PUZZLEFS
+	tristate "Puzzlefs file system"
+	help
+	  This option builds the Rust puzzlefs file system sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called puzzlefs.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index e5941037e673..364a38dbf90b 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_FS)			+= rust_fs.o
+obj-$(CONFIG_SAMPLE_PUZZLEFS)			+= puzzlefs.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
new file mode 100644
index 000000000000..0cf42762e81a
--- /dev/null
+++ b/samples/rust/puzzlefs.rs
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust file system sample.
+
+use kernel::module_fs;
+use kernel::prelude::*;
+use kernel::{c_str, file, fs, io_buffer::IoBufferWriter};
+
+module_fs! {
+    type: PuzzleFsModule,
+    name: "puzzlefs",
+    author: "Ariel Miculas",
+    license: "GPL",
+}
+
+struct PuzzleFsModule;
+
+#[vtable]
+impl fs::Context<Self> for PuzzleFsModule {
+    type Data = ();
+
+    kernel::define_fs_params! {(),
+        {flag, "flag", |_, v| { pr_info!("flag passed-in: {v}\n"); Ok(()) } },
+        {flag_no, "flagno", |_, v| { pr_info!("flagno passed-in: {v}\n"); Ok(()) } },
+        {bool, "bool", |_, v| { pr_info!("bool passed-in: {v}\n"); Ok(()) } },
+        {u32, "u32", |_, v| { pr_info!("u32 passed-in: {v}\n"); Ok(()) } },
+        {u32oct, "u32oct", |_, v| { pr_info!("u32oct passed-in: {v}\n"); Ok(()) } },
+        {u32hex, "u32hex", |_, v| { pr_info!("u32hex passed-in: {v}\n"); Ok(()) } },
+        {s32, "s32", |_, v| { pr_info!("s32 passed-in: {v}\n"); Ok(()) } },
+        {u64, "u64", |_, v| { pr_info!("u64 passed-in: {v}\n"); Ok(()) } },
+        {string, "string", |_, v| { pr_info!("string passed-in: {v}\n"); Ok(()) } },
+        {enum, "enum", [("first", 10), ("second", 20)], |_, v| {
+            pr_info!("enum passed-in: {v}\n"); Ok(()) }
+        },
+    }
+
+    fn try_new() -> Result {
+        Ok(())
+    }
+}
+
+impl fs::Type for PuzzleFsModule {
+    type Context = Self;
+    type INodeData = &'static [u8];
+    const SUPER_TYPE: fs::Super = fs::Super::Independent;
+    const NAME: &'static CStr = c_str!("puzzlefs");
+    const FLAGS: i32 = fs::flags::USERNS_MOUNT;
+    const DCACHE_BASED: bool = true;
+
+    fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBlock<Self>> {
+        let sb = sb.init(
+            (),
+            &fs::SuperParams {
+                magic: 0x72757374,
+                ..fs::SuperParams::DEFAULT
+            },
+        )?;
+        let root = sb.try_new_populated_root_dentry(
+            &[],
+            kernel::fs_entries![
+                file("test1", 0o600, "abc\n".as_bytes(), FsFile),
+                file("test2", 0o600, "def\n".as_bytes(), FsFile),
+                char("test3", 0o600, [].as_slice(), (10, 125)),
+                sock("test4", 0o755, [].as_slice()),
+                fifo("test5", 0o755, [].as_slice()),
+                block("test6", 0o755, [].as_slice(), (1, 1)),
+                dir(
+                    "dir1",
+                    0o755,
+                    [].as_slice(),
+                    [
+                        file("test1", 0o600, "abc\n".as_bytes(), FsFile),
+                        file("test2", 0o600, "def\n".as_bytes(), FsFile),
+                    ]
+                ),
+            ],
+        )?;
+        let sb = sb.init_root(root)?;
+        Ok(sb)
+    }
+}
+
+struct FsFile;
+
+#[vtable]
+impl file::Operations for FsFile {
+    type OpenData = &'static [u8];
+
+    fn open(_context: &Self::OpenData, _file: &file::File) -> Result<Self::Data> {
+        Ok(())
+    }
+
+    fn read(
+        _data: (),
+        file: &file::File,
+        writer: &mut impl IoBufferWriter,
+        offset: u64,
+    ) -> Result<usize> {
+        file::read_from_slice(
+            file.inode::<PuzzleFsModule>().ok_or(EINVAL)?.fs_data(),
+            writer,
+            offset,
+        )
+    }
+}
-- 
2.41.0

