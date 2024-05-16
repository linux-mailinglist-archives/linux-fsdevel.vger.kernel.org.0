Return-Path: <linux-fsdevel+bounces-19611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6C8C7CE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B101C2243F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6615B97D;
	Thu, 16 May 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Gl9srvSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F27E15ADA6;
	Thu, 16 May 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886317; cv=none; b=p7Q0pJ6emCfOIdE7NQhtqEHlAfax+GyqYmdfTg0mUm/01NhBoTzcbtoMAP1zmPv5jiEg/HjLdaABeb0PlfWPoXIyCFJBgurBPYYmIPjXx0tRlVQpJ3oUoRe7ZJd6AGgW9ReRNWtdkxXc45UyAWozZLotEmPnjrscS2XymKhNkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886317; c=relaxed/simple;
	bh=C0ihuL2jj8QfBcPXgxKcqRDlDBwSCbXEYWR2OmjZkwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ULd+DVRtz3GHpfi4WHKpvOJnC2ypfRxQykPxzrusejolyBD9CRc+LzxrL+fPPhzJp+3mGA04OMMQshJYXs1TTb3OelpcL+7qneaktXXJnug0W+oOmmvKUjYrKxh9zR00LXjnkyiaZRZxf9PLo4dvF5pShrtb/cE9Ytp53nBHqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Gl9srvSx; arc=none smtp.client-ip=173.38.203.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4299; q=dns/txt; s=iport;
  t=1715886315; x=1717095915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XmrkWfcmaLB4LqRKL0XJRG+hfTU9BH5HMiJRTIlB8AY=;
  b=Gl9srvSxVW0jkbRvkgSKPc4mXARCAYT5/MuxUjZGXwfPUH1uArzQdsgh
   Voyzqs3MgqjVAH2aWIAXWRqxLeboT4Bk/+ltKb359DbINvpc3+wvHZPHq
   GQ0yVjbtpw9/FoqZnOtu1v6ym/ub6PGOaaBetxU6Wfv0MAGzguSrp4o+l
   I=;
X-CSE-ConnectionGUID: 4EVdI9oZSiGwXuoPzTiTfQ==
X-CSE-MsgGUID: fSSpwu+cRWaQ6JdKcx1PCg==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12379869"
Received: from aer-iport-nat.cisco.com (HELO aer-core-8.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:04 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-8.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ43g0042440
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:03 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 05/22] rust: hex: add encode_hex_iter and encode_hex_upper_iter methods
Date: Thu, 16 May 2024 22:03:28 +0300
Message-Id: <20240516190345.957477-6-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-8.cisco.com

Add encode_hex_iter and encode_hex_upper_iter which return an iterator,
so it can be used in conjunction with the Vec::from_iter_fallible
function to (try to) create a hex string.

Replace BytesToHexChars with BytesToHexByteSequence because String is
not available. We need to collect the values in a Vec<u8>, append a NUL
character and the create a CStr on top of it.

Also remove the ToHex trait because it uses the FromIterator trait which
cannot be implemented in the kernel due to the prohibition of infallible
allocations.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/hex/lib.rs | 60 ++++++++++++-------------------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/rust/hex/lib.rs b/rust/hex/lib.rs
index a23def3f80db..3abf61ccbfc3 100644
--- a/rust/hex/lib.rs
+++ b/rust/hex/lib.rs
@@ -57,43 +57,18 @@
 #[cfg(all(feature = "alloc", feature = "serde"))]
 pub use crate::serde::{serialize, serialize_upper};
 
-/// Encoding values as hex string.
-///
-/// This trait is implemented for all `T` which implement `AsRef<[u8]>`. This
-/// includes `String`, `str`, `Vec<u8>` and `[u8]`.
-///
-/// # Example
-///
-/// ```
-/// use hex::ToHex;
-///
-/// println!("{}", "Hello world!".encode_hex::<String>());
-/// # assert_eq!("Hello world!".encode_hex::<String>(), "48656c6c6f20776f726c6421".to_string());
-/// ```
-///
-/// *Note*: instead of using this trait, you might want to use [`encode()`].
-pub trait ToHex {
-    /// Encode the hex strict representing `self` into the result. Lower case
-    /// letters are used (e.g. `f9b4ca`)
-    fn encode_hex<T: iter::FromIterator<char>>(&self) -> T;
-
-    /// Encode the hex strict representing `self` into the result. Upper case
-    /// letters are used (e.g. `F9B4CA`)
-    fn encode_hex_upper<T: iter::FromIterator<char>>(&self) -> T;
-}
-
 const HEX_CHARS_LOWER: &[u8; 16] = b"0123456789abcdef";
 const HEX_CHARS_UPPER: &[u8; 16] = b"0123456789ABCDEF";
 
-struct BytesToHexChars<'a> {
+struct BytesToHexByteSequence<'a> {
     inner: ::core::slice::Iter<'a, u8>,
     table: &'static [u8; 16],
-    next: Option<char>,
+    next: Option<u8>,
 }
 
-impl<'a> BytesToHexChars<'a> {
-    fn new(inner: &'a [u8], table: &'static [u8; 16]) -> BytesToHexChars<'a> {
-        BytesToHexChars {
+impl<'a> BytesToHexByteSequence<'a> {
+    fn new(inner: &'a [u8], table: &'static [u8; 16]) -> BytesToHexByteSequence<'a> {
+        BytesToHexByteSequence {
             inner: inner.iter(),
             table,
             next: None,
@@ -101,15 +76,15 @@ impl<'a> BytesToHexChars<'a> {
     }
 }
 
-impl<'a> Iterator for BytesToHexChars<'a> {
-    type Item = char;
+impl<'a> Iterator for BytesToHexByteSequence<'a> {
+    type Item = u8;
 
     fn next(&mut self) -> Option<Self::Item> {
         match self.next.take() {
             Some(current) => Some(current),
             None => self.inner.next().map(|byte| {
-                let current = self.table[(byte >> 4) as usize] as char;
-                self.next = Some(self.table[(byte & 0x0F) as usize] as char);
+                let current = self.table[(byte >> 4) as usize];
+                self.next = Some(self.table[(byte & 0x0F) as usize]);
                 current
             }),
         }
@@ -121,7 +96,7 @@ fn size_hint(&self) -> (usize, Option<usize>) {
     }
 }
 
-impl<'a> iter::ExactSizeIterator for BytesToHexChars<'a> {
+impl<'a> iter::ExactSizeIterator for BytesToHexByteSequence<'a> {
     fn len(&self) -> usize {
         let mut length = self.inner.len() * 2;
         if self.next.is_some() {
@@ -131,19 +106,12 @@ fn len(&self) -> usize {
     }
 }
 
-#[inline]
-fn encode_to_iter<T: iter::FromIterator<char>>(table: &'static [u8; 16], source: &[u8]) -> T {
-    BytesToHexChars::new(source, table).collect()
+pub fn encode_hex_iter<'a>(source: &'a [u8]) -> impl iter::Iterator<Item = u8> + 'a {
+    BytesToHexByteSequence::new(source, HEX_CHARS_LOWER).into_iter()
 }
 
-impl<T: AsRef<[u8]>> ToHex for T {
-    fn encode_hex<U: iter::FromIterator<char>>(&self) -> U {
-        encode_to_iter(HEX_CHARS_LOWER, self.as_ref())
-    }
-
-    fn encode_hex_upper<U: iter::FromIterator<char>>(&self) -> U {
-        encode_to_iter(HEX_CHARS_UPPER, self.as_ref())
-    }
+pub fn encode_hex_upper_iter<'a>(source: &'a [u8]) -> impl iter::Iterator<Item = u8> + 'a {
+    BytesToHexByteSequence::new(source, HEX_CHARS_UPPER).into_iter()
 }
 
 /// Types that can be decoded from a hex string.
-- 
2.34.1


