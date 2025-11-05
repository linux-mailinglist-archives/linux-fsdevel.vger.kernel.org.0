Return-Path: <linux-fsdevel+bounces-67015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D925C33779
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040E54256E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1F236A73;
	Wed,  5 Nov 2025 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVg8cIsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847CEEAB;
	Wed,  5 Nov 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302235; cv=none; b=XMd0+9zPZFtYnwLBAWI7hVZpmbSQYTiVwVKNfOBJq7Mz8JJEE+M7To9Su+3/9btEJ5acUr8aGxoqJ7LzsRUpHazA+Rl+56HamW6vBPKe/Ag3mc7/oF/Xds20lEYVtO2NjRvPKiiB/rdYXO95a4woEZmIAm+YnxmP5SIHIPx/P08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302235; c=relaxed/simple;
	bh=x0DUEde66C9G43K+MMw5hkct3NqVabtjNSKqXrtXato=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zk8i08kMXWxIPqz9JR9oW5A8lo+sI3K2FUeU5kcAomiSCwyyWB5IBh5sO6m/rZjKoZkr0/uvo9//rlejSwc22xP/W/g20GY1KHX2Ls+SSMGUx7sJ/XaX23JW9/JZB0ZESvPcTkWxPXl3KBfnXio2AYWu9NFnbVKyloScqdYVDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVg8cIsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CDDC116B1;
	Wed,  5 Nov 2025 00:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302234;
	bh=x0DUEde66C9G43K+MMw5hkct3NqVabtjNSKqXrtXato=;
	h=From:To:Cc:Subject:Date:From;
	b=YVg8cIslGHbMAhcsC1RdtzkoXQKS6xtOm7snfwUG6aG5n1AIdy0jXtG1h+zncndp1
	 hQNlS2y8la/iDJ5IUnYFzlM4ifT8QM6L5813DOxWvKayTtc3U9HtDajX8cRFlXjr9q
	 SFVqeZhT+7K6bRshGO5hllk51pkMlJGeLnl+GGSQFF4tmMmc53utpaLVpymtiTtQ/B
	 7HkTn51GfMX6mo9I/lMKVKykcJSRJX7a2Vay53L32A5YB4wWjuKnePgkGlfB0Fp3fF
	 XTavLT0Ow3n4dUyolUrutjF92Zc4OfQaIO43OUP8jAddnCo0zRwih9o5NJ3ULMOewA
	 JNRrDWWyApmqQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 1/3] rust: fs: add a new type for file::Offset
Date: Wed,  5 Nov 2025 01:22:48 +0100
Message-ID: <20251105002346.53119-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the existing file::Offset type alias with a new type.

Compared to a type alias, a new type allows for more fine grained
control over the operations that (semantically) make sense for a
specific type.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1198
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs/file_ops.rs |   4 +-
 rust/kernel/fs/file.rs          | 159 +++++++++++++++++++++++++++++++-
 rust/kernel/uaccess.rs          |   4 +-
 3 files changed, 159 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 6c8928902a0b..8e45c15d3c90 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -261,7 +261,7 @@ extern "C" fn blob_read<T: BinaryWriter>(
     // SAFETY:
     // - `ppos` is a valid `file::Offset` pointer.
     // - We have exclusive access to `ppos`.
-    let pos: &mut file::Offset = unsafe { &mut *ppos };
+    let pos = unsafe { file::Offset::from_raw(ppos) };
 
     let mut writer = UserSlice::new(UserPtr::from_ptr(buf.cast()), count).writer();
 
@@ -316,7 +316,7 @@ extern "C" fn blob_write<T: BinaryReader>(
     // SAFETY:
     // - `ppos` is a valid `file::Offset` pointer.
     // - We have exclusive access to `ppos`.
-    let pos: &mut file::Offset = unsafe { &mut *ppos };
+    let pos = unsafe { file::Offset::from_raw(ppos) };
 
     let mut reader = UserSlice::new(UserPtr::from_ptr(buf.cast_mut().cast()), count).reader();
 
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd240..655019f336d9 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -15,12 +15,163 @@
     sync::aref::{ARef, AlwaysRefCounted},
     types::{NotThreadSafe, Opaque},
 };
-use core::ptr;
+use core::{num::TryFromIntError, ptr};
 
-/// Primitive type representing the offset within a [`File`].
+/// Representation of an offset within a [`File`].
 ///
-/// Type alias for `bindings::loff_t`.
-pub type Offset = bindings::loff_t;
+/// Transparent wrapper around `bindings::loff_t`.
+#[repr(transparent)]
+#[derive(Copy, Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Default)]
+pub struct Offset(pub bindings::loff_t);
+
+impl Offset {
+    /// The largest value that can be represented by this type.
+    pub const MAX: Self = Self(bindings::loff_t::MAX);
+
+    /// The smallest value that can be represented by this type.
+    pub const MIN: Self = Self(bindings::loff_t::MIN);
+
+    /// Create a mutable [`Offset`] reference from the raw `*mut bindings::loff_t`.
+    ///
+    /// # Safety
+    ///
+    /// - `offset` must be a valid pointer to a `bindings::loff_t`.
+    /// - The caller must guarantee exclusive access to `offset`.
+    #[inline]
+    pub const unsafe fn from_raw<'a>(offset: *mut bindings::loff_t) -> &'a mut Self {
+        // SAFETY: By the safety requirements of this function
+        // - `offset` is a valid pointer to a `bindings::loff_t`,
+        // - we have exclusive access to `offset`.
+        unsafe { &mut *offset.cast() }
+    }
+
+    /// Returns `true` if the [`Offset`] is negative.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::fs::file::Offset;
+    ///
+    /// let offset = Offset::from(1);
+    /// assert!(!offset.is_negative());
+    ///
+    /// let offset = Offset::from(-1);
+    /// assert!(offset.is_negative());
+    /// ```
+    #[inline]
+    pub const fn is_negative(self) -> bool {
+        self.0.is_negative()
+    }
+
+    /// Saturating addition with another [`Offset`].
+    #[inline]
+    pub fn saturating_add(self, rhs: Offset) -> Offset {
+        Self(self.0.saturating_add(rhs.0))
+    }
+
+    /// Saturating addition with a [`usize`].
+    ///
+    /// If the [`usize`] fits in `bindings::loff_t` it is converted and added; otherwise the result
+    /// saturates to [`Offset::MAX`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::fs::file::Offset;
+    ///
+    /// let offset = Offset::from(40);
+    ///
+    /// let offset = offset.saturating_add_usize(2);
+    /// assert_eq!(offset, Offset::from(42));
+    ///
+    /// let offset = Offset::MAX.saturating_sub_usize(1);
+    /// let offset = offset.saturating_add_usize(usize::MAX);
+    /// assert_eq!(offset, Offset::MAX);
+    /// ```
+    pub fn saturating_add_usize(self, rhs: usize) -> Offset {
+        match bindings::loff_t::try_from(rhs) {
+            Ok(rhs_loff) => Self(self.0.saturating_add(rhs_loff)),
+            Err(_) => Self::MAX,
+        }
+    }
+
+    /// Saturating subtraction with another [`Offset`].
+    #[inline]
+    pub fn saturating_sub(self, rhs: Offset) -> Offset {
+        Offset(self.0.saturating_sub(rhs.0))
+    }
+
+    /// Saturating subtraction with a [`usize`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::fs::file::Offset;
+    ///
+    /// let offset = Offset::from(100);
+    /// let offset = offset.saturating_sub_usize(58);
+    /// assert_eq!(offset, Offset::from(42));
+    ///
+    /// let offset = Offset::MIN.saturating_add_usize(1);
+    /// let offset = offset.saturating_sub_usize(usize::MAX);
+    /// assert_eq!(offset, Offset::MIN);
+    /// ```
+    #[inline]
+    pub fn saturating_sub_usize(self, rhs: usize) -> Offset {
+        match bindings::loff_t::try_from(rhs) {
+            Ok(rhs_loff) => Offset(self.0.saturating_sub(rhs_loff)),
+            Err(_) => Self::MIN,
+        }
+    }
+}
+
+impl core::ops::Add<isize> for Offset {
+    type Output = Offset;
+
+    #[inline]
+    fn add(self, rhs: isize) -> Offset {
+        Offset(self.0 + rhs as bindings::loff_t)
+    }
+}
+
+impl core::ops::AddAssign<isize> for Offset {
+    #[inline]
+    fn add_assign(&mut self, rhs: isize) {
+        self.0 += rhs as bindings::loff_t;
+    }
+}
+
+impl From<bindings::loff_t> for Offset {
+    #[inline]
+    fn from(v: bindings::loff_t) -> Self {
+        Self(v)
+    }
+}
+
+impl From<Offset> for bindings::loff_t {
+    #[inline]
+    fn from(offset: Offset) -> Self {
+        offset.0
+    }
+}
+
+impl TryFrom<usize> for Offset {
+    type Error = TryFromIntError;
+
+    #[inline]
+    fn try_from(u: usize) -> Result<Self, Self::Error> {
+        Ok(Self(bindings::loff_t::try_from(u)?))
+    }
+}
+
+impl TryFrom<Offset> for usize {
+    type Error = TryFromIntError;
+
+    #[inline]
+    fn try_from(offset: Offset) -> Result<Self, Self::Error> {
+        usize::try_from(offset.0)
+    }
+}
 
 /// Flags associated with a [`File`].
 pub mod flags {
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index f989539a31b4..7bfc212e78d1 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -325,7 +325,7 @@ pub fn read_slice_file(&mut self, out: &mut [u8], offset: &mut file::Offset) ->
         let read = self.read_slice_partial(out, offset_index)?;
 
         // OVERFLOW: `offset + read <= data.len() <= isize::MAX <= Offset::MAX`
-        *offset += read as i64;
+        *offset += read as isize;
 
         Ok(read)
     }
@@ -518,7 +518,7 @@ pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file::Offset) -> Re
         let written = self.write_slice_partial(data, offset_index)?;
 
         // OVERFLOW: `offset + written <= data.len() <= isize::MAX <= Offset::MAX`
-        *offset += written as i64;
+        *offset += written as isize;
 
         Ok(written)
     }

base-commit: f656279afde16afee3ac163b90584ddceacb4e61
-- 
2.51.2


