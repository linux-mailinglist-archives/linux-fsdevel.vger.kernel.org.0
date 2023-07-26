Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2499763CE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGZQsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGZQrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:55 -0400
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2026BB
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4334; q=dns/txt; s=iport;
  t=1690390052; x=1691599652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7RIRVvP4MKCFvgB/74OSuv2zzERdm/ln1FIu9qAS8CY=;
  b=RKNTTHqgLg26sp1ZBoXYiFP6KGuPGD83EWixev3hTMZWg6gcTqhNRnIE
   zpyuQrlFQJE89/wjMKqMBz2u0V2o95of5t18w9asKHzVA0u/EGfBX+cto
   xUiAZGVWPsTOH9UlKWOhS1KfFD9srk7ifNybgfYpno9u3VDJICvMuorU4
   c=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="8452952"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:27 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqU2022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:27 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 10/10] rust: puzzlefs: add oci_root_dir and image_manifest filesystem parameters
Date:   Wed, 26 Jul 2023 19:45:34 +0300
Message-ID: <20230726164535.230515-11-amiculas@cisco.com>
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
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These parameters are passed when mounting puzzlefs using '-o' option of
mount:
-o oci_root_dir="/path/to/oci/dir"
-o image_manifest="root_hash_of_image_manifest"

For a particular manifest in the manifests array in index.json (located
in the oci_root_dir), the root hash of the image manifest is found in
the digest field.

It would be nicer if we could pass the tag, but we don't support json
deserialization.

Example of mount:
mount -t puzzlefs -o oci_root_dir="/home/puzzlefs_oci" -o \
image_manifest="2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b" \
none /mnt

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 samples/rust/puzzlefs.rs | 63 ++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/samples/rust/puzzlefs.rs b/samples/rust/puzzlefs.rs
index dad7ecc76eca..4e9a8aedf0c1 100644
--- a/samples/rust/puzzlefs.rs
+++ b/samples/rust/puzzlefs.rs
@@ -7,6 +7,7 @@
 use kernel::{
     c_str, file, fs,
     io_buffer::IoBufferWriter,
+    str::CString,
     sync::{Arc, ArcBorrow},
 };
 
@@ -31,27 +32,29 @@ struct PuzzlefsInfo {
     puzzlefs: Arc<PuzzleFS>,
 }
 
+#[derive(Default)]
+struct PuzzleFsParams {
+    oci_root_dir: Option<CString>,
+    image_manifest: Option<CString>,
+}
+
 #[vtable]
 impl fs::Context<Self> for PuzzleFsModule {
-    type Data = ();
-
-    kernel::define_fs_params! {(),
-        {flag, "flag", |_, v| { pr_info!("flag passed-in: {v}\n"); Ok(()) } },
-        {flag_no, "flagno", |_, v| { pr_info!("flagno passed-in: {v}\n"); Ok(()) } },
-        {bool, "bool", |_, v| { pr_info!("bool passed-in: {v}\n"); Ok(()) } },
-        {u32, "u32", |_, v| { pr_info!("u32 passed-in: {v}\n"); Ok(()) } },
-        {u32oct, "u32oct", |_, v| { pr_info!("u32oct passed-in: {v}\n"); Ok(()) } },
-        {u32hex, "u32hex", |_, v| { pr_info!("u32hex passed-in: {v}\n"); Ok(()) } },
-        {s32, "s32", |_, v| { pr_info!("s32 passed-in: {v}\n"); Ok(()) } },
-        {u64, "u64", |_, v| { pr_info!("u64 passed-in: {v}\n"); Ok(()) } },
-        {string, "string", |_, v| { pr_info!("string passed-in: {v}\n"); Ok(()) } },
-        {enum, "enum", [("first", 10), ("second", 20)], |_, v| {
-            pr_info!("enum passed-in: {v}\n"); Ok(()) }
-        },
+    type Data = Box<PuzzleFsParams>;
+
+    kernel::define_fs_params! {Box<PuzzleFsParams>,
+        {string, "oci_root_dir", |s, v| {
+                                      s.oci_root_dir = Some(CString::try_from_fmt(format_args!("{v}"))?);
+                                      Ok(())
+                                  }},
+        {string, "image_manifest", |s, v| {
+                                      s.image_manifest = Some(CString::try_from_fmt(format_args!("{v}"))?);
+                                      Ok(())
+                                  }},
     }
 
-    fn try_new() -> Result {
-        Ok(())
+    fn try_new() -> Result<Self::Data> {
+        Ok(Box::try_new(PuzzleFsParams::default())?)
     }
 }
 
@@ -136,11 +139,27 @@ impl fs::Type for PuzzleFsModule {
     const FLAGS: i32 = fs::flags::USERNS_MOUNT;
     const DCACHE_BASED: bool = true;
 
-    fn fill_super(_data: (), sb: fs::NewSuperBlock<'_, Self>) -> Result<&fs::SuperBlock<Self>> {
-        let puzzlefs = PuzzleFS::open(
-            c_str!("/home/puzzlefs_oci"),
-            c_str!("2d6602d678140540dc7e96de652a76a8b16e8aca190bae141297bcffdcae901b"),
-        );
+    fn fill_super(
+        data: Box<PuzzleFsParams>,
+        sb: fs::NewSuperBlock<'_, Self>,
+    ) -> Result<&fs::SuperBlock<Self>> {
+        let oci_root_dir = match data.oci_root_dir {
+            Some(val) => val,
+            None => {
+                pr_err!("missing oci_root_dir parameter!\n");
+                return Err(ENOTSUPP);
+            }
+        };
+
+        let image_manifest = match data.image_manifest {
+            Some(val) => val,
+            None => {
+                pr_err!("missing image_manifest parameter!\n");
+                return Err(ENOTSUPP);
+            }
+        };
+
+        let puzzlefs = PuzzleFS::open(&oci_root_dir, &image_manifest);
 
         if let Err(ref e) = puzzlefs {
             pr_info!("error opening puzzlefs {e}\n");
-- 
2.41.0

