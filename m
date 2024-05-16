Return-Path: <linux-fsdevel+bounces-19602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B64338C7CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450F91F2200D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB02158A33;
	Thu, 16 May 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YCUgijMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-5.cisco.com (aer-iport-5.cisco.com [173.38.203.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A401581E6;
	Thu, 16 May 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886266; cv=none; b=MzpdQkD54KrVq7YOuo+EzawfPvAZvewIezSrVUhUIlkCe6FAlLSsWIvr5PHU1Wm/4nohxfwIKwPYbn9pRIXygoeM/AEDwvkl2WYH5YLR2EB2C8HoRDnZ97V67kyU3aglp0ZXkJset0LymjrpCyAj1PqmKBnK42hIyRsnYqSi4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886266; c=relaxed/simple;
	bh=14cppHrxJNO2k5SkDzm3ABrvDJviaSVFS2X9pDuyXsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gx8x1PTg6zHCCk1DrOgZe6T3/RNTOOnLnfHA/Nj53tiYv2vBI+MWTxSwFEi2TgYFxK3IZ/3jaDReTHtXzw0HSA9sbxy+xNkDJk0yEjwijscj+mYa98/RDMZo0NkTi2R4JTB9T0Xd6dnbRMoqzkhTLT7rWk4gK0ZVERVG5gGKA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=YCUgijMb; arc=none smtp.client-ip=173.38.203.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5421; q=dns/txt; s=iport;
  t=1715886265; x=1717095865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2VScZVKYmKMf1+GFQpbDD6K0vkZQjVRPPErj0F66jK0=;
  b=YCUgijMbi7LkTk/ljMIQwSGDmTcJDydJT5NnlR2sSuBOgbiWEVWct9Ce
   8qcvSnjwwAIP6XOrBQU9dBFkzDURJZFeJ4lUxX1XfGBGKe/izJR7wiNdA
   mqg4/q653Uz1r5p9W2gWHIsHlm4oquUzUYyX10rwhbtRC9+24FkGn4npV
   s=;
X-CSE-ConnectionGUID: PVvKQ4oGQgiG0wFAL2j9fA==
X-CSE-MsgGUID: iJUPC6w/SzyZrLVpmc525w==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="9839853"
Received: from aer-iport-nat.cisco.com (HELO aer-core-2.cisco.com) ([173.38.203.22])
  by aer-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:22 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-2.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4L0j007823
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:22 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 17/22] fs: puzzlefs: add extended attributes support
Date: Thu, 16 May 2024 22:03:40 +0300
Message-Id: <20240516190345.957477-18-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-2.cisco.com

Implement the listxattr callback in the filesystem abstractions.
Implement both read_xattr and listxattr for PuzzleFS.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 fs/puzzlefs/puzzlefs.rs | 50 +++++++++++++++++++++++++++++--
 rust/kernel/fs/inode.rs | 66 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/fs/puzzlefs/puzzlefs.rs b/fs/puzzlefs/puzzlefs.rs
index a062bf0249f6..9622ea71eda0 100644
--- a/fs/puzzlefs/puzzlefs.rs
+++ b/fs/puzzlefs/puzzlefs.rs
@@ -107,8 +107,8 @@ fn fill_super(
         _: Option<inode::Mapper>,
     ) -> Result<Box<PuzzleFS>> {
         let puzzlefs = PuzzleFS::open(
-            c_str!("/home/puzzlefs_oci"),
-            c_str!("83aa96c40a20671edc4490cfefadbb487b2ab23dfc0570049b56f0cc49b56eaf"),
+            c_str!("/home/puzzlefs_xattr"),
+            c_str!("ed63ace21eccceabab08d89afb75e94dae47973f82a17a172396a19ea953c8ab"),
         );
 
         if let Err(ref e) = puzzlefs {
@@ -124,6 +124,36 @@ fn init_root(sb: &sb::SuperBlock<Self>) -> Result<dentry::Root<Self>> {
         let inode = Self::iget(sb, 1)?;
         dentry::Root::try_new(inode)
     }
+
+    fn read_xattr(
+        _dentry: &DEntry<Self>,
+        inode: &INode<Self>,
+        name: &CStr,
+        outbuf: &mut [u8],
+    ) -> Result<usize> {
+        let inode = inode.data();
+        let readonly = outbuf.len() == 0;
+        // pr_info!("outbuf len {}\n", outbuf.len());
+
+        if let Some(add) = &inode.additional {
+            let xattr = add
+                .xattrs
+                .iter()
+                .find(|elem| elem.key == name.as_bytes())
+                .ok_or(ENODATA)?;
+            if readonly {
+                return Ok(xattr.val.len());
+            }
+
+            if xattr.val.len() > outbuf.len() {
+                return Err(ERANGE);
+            }
+
+            outbuf[0..xattr.val.len()].copy_from_slice(xattr.val.as_slice());
+            return Ok(xattr.val.len());
+        }
+        Err(ENODATA)
+    }
 }
 
 #[vtable]
@@ -143,6 +173,22 @@ fn lookup(
         }
     }
 
+    fn listxattr(
+        inode: &INode<Self>,
+        mut add_entry: impl FnMut(&[i8]) -> Result<()>,
+    ) -> Result<()> {
+        let inode = inode.data();
+
+        if let Some(add) = &inode.additional {
+            for xattr in &add.xattrs {
+                // convert a u8 slice into an i8 slice
+                let i8slice = unsafe { &*(xattr.key.as_slice() as *const _ as *const [i8]) };
+                add_entry(i8slice)?;
+            }
+        }
+        Ok(())
+    }
+
     fn get_link<'a>(
         dentry: Option<&DEntry<PuzzleFsModule>>,
         inode: &'a INode<PuzzleFsModule>,
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index b2b7d000080e..a092ee150d43 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -10,7 +10,7 @@
     address_space, dentry, dentry::DEntry, file, mode, sb::SuperBlock, FileSystem, Offset,
     PageOffset, UnspecifiedFS,
 };
-use crate::error::{code::*, from_err_ptr, Result};
+use crate::error::{code::*, from_err_ptr, from_result, Result};
 use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Lockable, Locked, Opaque};
 use crate::{
     bindings, block, build_error, container_of, folio, folio::Folio, mem_cache::MemCache,
@@ -48,6 +48,14 @@ fn lookup(
     ) -> Result<Option<ARef<DEntry<Self::FileSystem>>>> {
         Err(ENOTSUPP)
     }
+
+    /// Get extended attributes list
+    fn listxattr<'a>(
+        _inode: &'a INode<Self::FileSystem>,
+        mut _add_entry: impl FnMut(&[i8]) -> Result<()>,
+    ) -> Result<()> {
+        Err(ENOSYS)
+    }
 }
 
 /// A node (inode) in the file index.
@@ -615,7 +623,7 @@ impl<T: Operations + ?Sized> Table<T> {
                 rename: None,
                 setattr: None,
                 getattr: None,
-                listxattr: None,
+                listxattr: Some(Self::listxattr_callback),
                 fiemap: None,
                 update_time: None,
                 atomic_open: None,
@@ -688,6 +696,60 @@ extern "C" fn drop_cstring(ptr: *mut core::ffi::c_void) {
                     }
                 }
             }
+
+            extern "C" fn listxattr_callback(
+                dentry: *mut bindings::dentry,
+                buffer: *mut core::ffi::c_char,
+                buffer_size: usize,
+            ) -> isize {
+                from_result(|| {
+                    // SAFETY: The C API guarantees that `dentry` is valid for read.
+                    let inode = unsafe { bindings::d_inode(dentry) };
+                    // SAFETY: The C API guarantees that `d_inode` inside `dentry` is valid for read.
+                    let inode = unsafe { INode::from_raw(inode) };
+
+                    // `buffer_size` should be 0 when `buffer` is NULL, but we enforce it
+                    let (mut buffer_ptr, buffer_size) = match ptr::NonNull::new(buffer) {
+                        Some(buf) => (buf, buffer_size),
+                        None => (ptr::NonNull::dangling(), 0),
+                    };
+
+                    // SAFETY: The C API guarantees that `buffer` is at least `buffer_size` bytes in
+                    // length. Also, when `buffer_size` is 0, `buffer_ptr` is NonNull::dangling, as
+                    // suggested by `from_raw_parts_mut` documentation
+                    let outbuf = unsafe {
+                        core::slice::from_raw_parts_mut(buffer_ptr.as_mut(), buffer_size)
+                    };
+
+                    let mut offset = 0;
+                    let mut total_len = 0;
+
+                    //  The extended attributes keys must be placed into the output buffer sequentially,
+                    //  separated by the NUL character. We do this in the callback because it simplifies
+                    //  the implementation of the `listxattr` abstraction: the user just calls the
+                    //  add_entry function for each extended attribute key, passing a slice.
+                    T::listxattr(inode, |xattr_key| {
+                        let len = xattr_key.len();
+                        total_len += isize::try_from(len)? + 1;
+
+                        if buffer_size == 0 {
+                            return Ok(());
+                        }
+
+                        let max = offset + len + 1;
+                        if max > buffer_size {
+                            return Err(ERANGE);
+                        }
+
+                        outbuf[offset..max - 1].copy_from_slice(xattr_key);
+                        outbuf[max - 1] = 0;
+                        offset = max;
+                        Ok(())
+                    })?;
+
+                    Ok(total_len)
+                })
+            }
         }
         Self(&Table::<U>::TABLE, PhantomData)
     }
-- 
2.34.1


