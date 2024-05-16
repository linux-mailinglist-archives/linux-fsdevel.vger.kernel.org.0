Return-Path: <linux-fsdevel+bounces-19621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786528C7CFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D52287DEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77E158D77;
	Thu, 16 May 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Lqi5I+J7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-8.cisco.com (aer-iport-8.cisco.com [173.38.203.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FD15820F;
	Thu, 16 May 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886464; cv=none; b=T/WqDmcfb4dDl3kYEzWlLM44M7Q/E4TGJ6uhq7nkLxy0ThEGfI7GLGknN2dkwsCxKhClyiK9qUV/H9nAOiuVbFeAzRRSw75CRiBsgIIWVJRMjfrPxJsdX50zp5PxbrCiFux9lUJ8qypugiSj6QLYkCpRZ27NOL5WacAVmXnMuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886464; c=relaxed/simple;
	bh=MqQvAYPJnEbPgiMJ/KAsv+WELCKQHh977LECrhqpreU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEgqz3MAsa8DW0thNqCsuVfyfroRMahZay7GBiLnZCGeaKbU0PpymPOtkLuk3m71Us0HxAA0lC5HWm/Sc17UYS59nG8HtAVHa6OIaXzWEE+WZ+zN72eDmIWVq0nU5O1rgQT02Z0FfUvu2ofKaZR6dAttqrklNwAz7etEXEaTVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Lqi5I+J7; arc=none smtp.client-ip=173.38.203.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2431; q=dns/txt; s=iport;
  t=1715886463; x=1717096063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IsRVprSkTcedn+zbjClnxOQsSEIZcaVQUIwJQMEacFU=;
  b=Lqi5I+J7p5BD3bJajeuIzqedcy7H3K15Zrb85zx96f4dTmh+tDeoi8qI
   sJe2nXF1oH5jTqMz3Xji5Jj0S/FmJ5aQJlymHNNVAD/rc4eWCF9Nt7EzD
   3/FZq5R/EV2nomvYvdbOMBr/3JM8ubZZtrueXo9enk05zrbaybczSNTNJ
   Q=;
X-CSE-ConnectionGUID: 3vlKbWuhRUSRVklW0FF6rQ==
X-CSE-MsgGUID: e4J0BcmTTdyIH+jEv28DOg==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="9784124"
Received: from aer-iport-nat.cisco.com (HELO aer-core-6.cisco.com) ([173.38.203.22])
  by aer-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:24 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4OOw006188
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:24 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 19/22] Add borrow_mut implementation to a ForeignOwnable CString
Date: Thu, 16 May 2024 22:03:42 +0300
Message-Id: <20240516190345.957477-20-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-6.cisco.com

Since the `borrow_mut` function was added to the ForeignOwnable trait,
we need to implement it for each type that implements it.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/kernel/str.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index c45612900fe2..b0a35d71bd49 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -197,6 +197,25 @@ pub unsafe fn from_char_ptr<'a>(ptr: *const core::ffi::c_char) -> &'a Self {
         unsafe { Self::from_bytes_with_nul_unchecked(bytes) }
     }
 
+    /// Like from_char_ptr, but returns a mutable reference
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `NUL`-terminated C string, and it must
+    /// last at least `'a`. When `CStr` is alive, the memory pointed by `ptr`
+    /// must not be mutated.
+    #[inline]
+    pub unsafe fn from_char_ptr_mut<'a>(ptr: *const core::ffi::c_char) -> &'a mut Self {
+        // SAFETY: The safety precondition guarantees `ptr` is a valid pointer
+        // to a `NUL`-terminated C string.
+        let len = unsafe { bindings::strlen(ptr) } + 1;
+        // SAFETY: Lifetime guaranteed by the safety precondition.
+        let bytes = unsafe { core::slice::from_raw_parts_mut(ptr as _, len as _) };
+        // SAFETY: As `len` is returned by `strlen`, `bytes` does not contain interior `NUL`.
+        // As we have added 1 to `len`, the last byte is known to be `NUL`.
+        unsafe { Self::from_bytes_with_nul_unchecked_mut(bytes) }
+    }
+
     /// Creates a [`CStr`] from a `[u8]`.
     ///
     /// The provided slice must be `NUL`-terminated, does not contain any
@@ -901,6 +920,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 
 impl ForeignOwnable for CString {
     type Borrowed<'a> = &'a CStr;
+    type BorrowedMut<'a> = &'a mut CStr;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         Box::into_raw(self.buf) as _
@@ -910,6 +930,10 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a> {
         unsafe { CStr::from_char_ptr(ptr.cast::<core::ffi::c_char>()) }
     }
 
+    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> Self::BorrowedMut<'a> {
+        unsafe { CStr::from_char_ptr_mut(ptr.cast::<core::ffi::c_char>()) }
+    }
+
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function satisfy those of `Self::borrow`.
         let str = unsafe { Self::borrow(ptr) };
-- 
2.34.1


