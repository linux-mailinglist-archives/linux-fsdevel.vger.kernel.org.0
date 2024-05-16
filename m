Return-Path: <linux-fsdevel+bounces-19603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623E8C7CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAD51F21FB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF58158D80;
	Thu, 16 May 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dUPwJ5TY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F7158A3F;
	Thu, 16 May 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886270; cv=none; b=kv7b1ntAi6VHK/Q9junrNo9Y/1Y11HLd6xx65ljgizvY4ZilOa02XtK+UpYdpogOKRrcNKXd7z9siYOaclweQ6r3zBNk0CbjBSwrL1UElqFctJiFgCfVxIkFy7jLcm/g/ODWYUXuGqd64UmWHvAEeUFWSO81//iXtD+nOcWIaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886270; c=relaxed/simple;
	bh=gaUlXe3wl+xDisP3R5K2Iyajwf5YxKCnqADsnqyc3AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjGki1yXGFN48nX41A9DkRdXotiYW/1dm5FIxHAHeCVYZuVlJmEuAEpUdk9TOBhE1M1IQNtbw8sdAL9OlR+/nWRBEJORvRo+n4W7Y1KSOtDwLQQFEV9tGfsgXDaRWfSNIKya/bedVwDNCzLuRu4v4FpXNdWy+ihf5qINi6DeiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=dUPwJ5TY; arc=none smtp.client-ip=173.38.203.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3172; q=dns/txt; s=iport;
  t=1715886268; x=1717095868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IARrAtPjZ/35pawnxYHHtgxzlwcbQQF1QO5K+2KrZxI=;
  b=dUPwJ5TYSyd3zrKRdVr/TyawxPyId7HaqccKDALdMnwLH0SWmXvHfOk0
   cAlWOt8KL5C2aQelfp5e5IJzH4R5hw0GXQJMkRPOF3ok4QBBOpMC77nTj
   mVKfBYeD3mQBnoFe0tKoY/g8NPBHCab9qXIKHdnhNqWz7xfRv00ZSuHMi
   I=;
X-CSE-ConnectionGUID: qsVxvoxXTpyKGT09HZsAmA==
X-CSE-MsgGUID: KUvDbz8ZSTyJr2NeFTsIAQ==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12416992"
Received: from aer-iport-nat.cisco.com (HELO aer-core-9.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:27 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4QU3032847
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:27 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 21/22] fs: puzzlefs: add oci_root_dir and image_manifest mount parameters
Date: Thu, 16 May 2024 22:03:44 +0300
Message-Id: <20240516190345.957477-22-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-9.cisco.com

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
 fs/puzzlefs/puzzlefs.rs | 49 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/fs/puzzlefs/puzzlefs.rs b/fs/puzzlefs/puzzlefs.rs
index f4e94568c9cc..932f31917992 100644
--- a/fs/puzzlefs/puzzlefs.rs
+++ b/fs/puzzlefs/puzzlefs.rs
@@ -36,6 +36,32 @@ fn mode_to_fs_type(inode: &Inode) -> Result<DirEntryType> {
     })
 }
 
+#[derive(Default)]
+struct PuzzleFsParams {
+    oci_root_dir: Option<CString>,
+    image_manifest: Option<CString>,
+}
+
+#[vtable]
+impl fs::Context<Self> for PuzzleFsModule {
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
+    }
+
+    fn try_new() -> Result<Self::Data> {
+        Ok(Box::new(PuzzleFsParams::default(), GFP_KERNEL)?)
+    }
+}
+
 const DIR_FOPS: file::Ops<PuzzleFsModule> = file::Ops::new::<PuzzleFsModule>();
 const DIR_IOPS: inode::Ops<PuzzleFsModule> = inode::Ops::new::<PuzzleFsModule>();
 const FILE_AOPS: address_space::Ops<PuzzleFsModule> = address_space::Ops::new::<PuzzleFsModule>();
@@ -98,24 +124,37 @@ fn iget(sb: &sb::SuperBlock<Self>, ino: u64) -> Result<ARef<INode<Self>>> {
 }
 
 impl fs::FileSystem for PuzzleFsModule {
+    type Context = Self;
     type Data = Box<PuzzleFS>;
     type INodeData = Inode;
     const NAME: &'static CStr = c_str!("puzzlefs");
 
     fn fill_super(
-        _data: (),
+        data: Box<PuzzleFsParams>,
         sb: &mut sb::SuperBlock<Self, sb::New>,
         _: Option<inode::Mapper>,
     ) -> Result<Box<PuzzleFS>> {
-        let puzzlefs = PuzzleFS::open(
-            c_str!("/home/puzzlefs_xattr"),
-            c_str!("ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953c8ab"),
-        );
+        let Some(oci_root_dir) = data.oci_root_dir else {
+            pr_err!("missing oci_root_dir parameter!\n");
+            return Err(ENOTSUPP);
+        };
 
+        let Some(image_manifest) = data.image_manifest else {
+            pr_err!("missing image_manifest parameter!\n");
+            return Err(ENOTSUPP);
+        };
+
+        let puzzlefs = PuzzleFS::open(&oci_root_dir, &image_manifest);
         if let Err(ref e) = puzzlefs {
             pr_info!("error opening puzzlefs {e}\n");
         }
 
+        pr_info!(
+            "opened puzzlefs [{}]:[{}]\n",
+            &*oci_root_dir,
+            &*image_manifest
+        );
+
         let puzzlefs = puzzlefs?;
         sb.set_magic(0x7a7a7570);
         Ok(Box::new(puzzlefs, GFP_KERNEL)?)
-- 
2.34.1


