Return-Path: <linux-fsdevel+bounces-65112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84DBFCB06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3C36E39FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D693321A8;
	Wed, 22 Oct 2025 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcAnLlQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBB35BDA4;
	Wed, 22 Oct 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143534; cv=none; b=W2FMaDO97dFuRJF0u7tJFHYEUDf6kW3zYmA45RFf9j6N4N7brHfwPrE13DAUaQI5A5FyJAkXeIJLxVgnGG33y1FyJcYmzwTzkUTNFPHTvXDXb96wJed6vt9kpknUiE5qJVk0vUxE699LjSZahjTLzuZUW0yGGgJngjGlWQYxKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143534; c=relaxed/simple;
	bh=27ryChYo+Hq0vUwOaFCWI2RYntF/9XJSjkdEkCcmwPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqW2DZa52TSHLtLuxGiNVCsyDzutayiJL1S8OMv/Z9R671Ehpw8lrlTt4yhcpVKld3f6tcX4rfDa0zcjXDEsVvY4pm5rdrghs5BfqAZDNkpIuWMSbWYVI3mnEvyIPOuahY2+7+3VRNCA85OLnfKveQ2IdTKKQxQHAerB7B9D12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcAnLlQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32947C4CEF7;
	Wed, 22 Oct 2025 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143533;
	bh=27ryChYo+Hq0vUwOaFCWI2RYntF/9XJSjkdEkCcmwPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcAnLlQjOB6D6ZoUYfg8eVVnb7d4il4gt2vo9HE4PMwkM303ydazqa1WjCdUGAhKa
	 Neua5TTA/cGKHnSfsO4UDkO4ExsqjLxko9DQcfwFskVMDKjk5+9NFR41kMFFWv90vE
	 omQppcd1fGeFr6RNTwgQGuyIlqwi7V0IqTPDmAtsO1EbJDYHn2TAdiKxEWCcFWtyys
	 SIsmyUM0E11gXYMpTcuqrhrKXYEiZ7V8nG7CamDGik1fN66v2JdL5vaTH83BGPj+wR
	 RGs0O2U2WeiKAj/jUUOzN6HD/YDzPldFHc3/orGFaHbn50XdiqgEmbIbySVueI0gpU
	 vao5wmZLj2cGQ==
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
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 01/10] rust: fs: add new type file::Offset
Date: Wed, 22 Oct 2025 16:30:35 +0200
Message-ID: <20251022143158.64475-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022143158.64475-1-dakr@kernel.org>
References: <20251022143158.64475-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new type for file offsets, i.e. bindings::loff_t. Trying to avoid
using raw bindings types, this seems to be the better alternative
compared to just using i64.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/fs/file.rs | 142 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index cf06e73a6da0..681b8a9e5d52 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -15,7 +15,147 @@
     sync::aref::{ARef, AlwaysRefCounted},
     types::{NotThreadSafe, Opaque},
 };
-use core::ptr;
+use core::{num::TryFromIntError, ptr};
+
+/// Representation of an offset within a [`File`].
+///
+/// Transparent wrapper around `bindings::loff_t`.
+#[repr(transparent)]
+#[derive(Copy, Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Default)]
+pub struct Offset(bindings::loff_t);
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
-- 
2.51.0


