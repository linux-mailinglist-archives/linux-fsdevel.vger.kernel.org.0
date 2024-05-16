Return-Path: <linux-fsdevel+bounces-19608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD78C7CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00F02846A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C315B0F1;
	Thu, 16 May 2024 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cJ/hODSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-3.cisco.com (aer-iport-3.cisco.com [173.38.203.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FA157E79;
	Thu, 16 May 2024 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886314; cv=none; b=Yfq39oPOdswgFZ/6L7ogBNVO0IAMhWuvXJizt6/7yIhduzx/QmDFJ+RM9J6ypA/mocmYb+vo23LGL1ioGjTS/9B0loiTOz4ykxtM0lrlSmFzAb8q2gLd2fXaEHsx/NpO6oqlUn41tCD1JCZa46qy/x6TWs15TdEvmBQpX+3bNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886314; c=relaxed/simple;
	bh=5/7SEzUqNOQzOz5OKVG5e+BFOae3lGhNr2rqkMCeXVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUwaD6GNt1PDsHEMN2Kavg6tiqvCUuPBeqm/WahtOxF37Ko2g8qasJKinAyp5fmLDr1Me/rAz8Kw4e+Y2oL4qg6/zNBs6DjgNZ2LGXrnexydjPDpgTUwN8cjpt+sPigYlVyBUrS22OZ5nTeo9PRovxlTNwVGAKTixrbuvpKpzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cJ/hODSv; arc=none smtp.client-ip=173.38.203.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=20796; q=dns/txt;
  s=iport; t=1715886311; x=1717095911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WwoWGQOt8e4ocz745ywVztH+TLbfTG8qj9hApEJcyfc=;
  b=cJ/hODSvYtgBP6zNFUnFLaW+z+nKccSuiGjzQM5AuVBYW/GIKfAkVC8J
   D3j7qSoCAndFjQhAh7z5OMLenD9DV8ZI5afeahyk65+I9MrxZTTa/xH6N
   b57hQT3gZRqeuobdxW76UG/egmARph03CkkomzcWKGDNzyfcBC9MM2XvM
   o=;
X-CSE-ConnectionGUID: XknJQn56Rz64WFzhBsEnoQ==
X-CSE-MsgGUID: kOUUzzI2TFiDIMkedgGElw==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12237922"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:00 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ3wvl030160
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:03:59 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 02/22] rust: hex: import crate
Date: Thu, 16 May 2024 22:03:25 +0300
Message-Id: <20240516190345.957477-3-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-1.cisco.com

This is a subset of the Rust `hex` crate,
version v0.4.3, licensed under "Apache-2.0 OR MIT", from:

https://github.com/KokaKiwi/rust-hex/tree/v0.4.3/src

The files are copied as-is, with no modifications whatsoever
(not even adding the SPDX identifiers).

For copyright details, please see:

https://github.com/KokaKiwi/rust-hex/blob/v0.4.3/README.md#license
https://github.com/KokaKiwi/rust-hex/blob/v0.4.3/LICENSE-APACHE
https://github.com/KokaKiwi/rust-hex/blob/v0.4.3/LICENSE-MIT

The next three patches modify these files as needed for use within
the kernel. This patch split allows reviewers to double-check
the import and to clearly see the differences introduced.

The following script may be used to verify the contents:

for path in $(cd rust/hex/ && find . -type f -name '*.rs'); do
    curl --silent --show-error --location \
        https://github.com/KokaKiwi/rust-hex/raw/v0.4.3/src/$path \
        | diff --unified rust/hex/$path - && echo $path: OK
done

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/hex/error.rs |  59 ++++++
 rust/hex/lib.rs   | 525 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/hex/serde.rs | 102 +++++++++
 3 files changed, 686 insertions(+)
 create mode 100644 rust/hex/error.rs
 create mode 100644 rust/hex/lib.rs
 create mode 100644 rust/hex/serde.rs

diff --git a/rust/hex/error.rs b/rust/hex/error.rs
new file mode 100644
index 000000000000..ff7a3b5c16bd
--- /dev/null
+++ b/rust/hex/error.rs
@@ -0,0 +1,59 @@
+use core::fmt;
+
+/// The error type for decoding a hex string into `Vec<u8>` or `[u8; N]`.
+#[derive(Debug, Clone, Copy, PartialEq)]
+pub enum FromHexError {
+    /// An invalid character was found. Valid ones are: `0...9`, `a...f`
+    /// or `A...F`.
+    InvalidHexCharacter { c: char, index: usize },
+
+    /// A hex string's length needs to be even, as two digits correspond to
+    /// one byte.
+    OddLength,
+
+    /// If the hex string is decoded into a fixed sized container, such as an
+    /// array, the hex string's length * 2 has to match the container's
+    /// length.
+    InvalidStringLength,
+}
+
+#[cfg(feature = "std")]
+impl std::error::Error for FromHexError {}
+
+impl fmt::Display for FromHexError {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        match *self {
+            FromHexError::InvalidHexCharacter { c, index } => {
+                write!(f, "Invalid character {:?} at position {}", c, index)
+            }
+            FromHexError::OddLength => write!(f, "Odd number of digits"),
+            FromHexError::InvalidStringLength => write!(f, "Invalid string length"),
+        }
+    }
+}
+
+#[cfg(test)]
+// this feature flag is here to suppress unused
+// warnings of `super::*` and `pretty_assertions::assert_eq`
+#[cfg(feature = "alloc")]
+mod tests {
+    use super::*;
+    #[cfg(feature = "alloc")]
+    use alloc::string::ToString;
+    use pretty_assertions::assert_eq;
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    fn test_display() {
+        assert_eq!(
+            FromHexError::InvalidHexCharacter { c: '\n', index: 5 }.to_string(),
+            "Invalid character '\\n' at position 5"
+        );
+
+        assert_eq!(FromHexError::OddLength.to_string(), "Odd number of digits");
+        assert_eq!(
+            FromHexError::InvalidStringLength.to_string(),
+            "Invalid string length"
+        );
+    }
+}
diff --git a/rust/hex/lib.rs b/rust/hex/lib.rs
new file mode 100644
index 000000000000..ec48961b9ffe
--- /dev/null
+++ b/rust/hex/lib.rs
@@ -0,0 +1,525 @@
+// Copyright (c) 2013-2014 The Rust Project Developers.
+// Copyright (c) 2015-2020 The rust-hex Developers.
+//
+// Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
+// http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
+// <LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
+// option. This file may not be copied, modified, or distributed
+// except according to those terms.
+//! Encoding and decoding hex strings.
+//!
+//! For most cases, you can simply use the [`decode`], [`encode`] and
+//! [`encode_upper`] functions. If you need a bit more control, use the traits
+//! [`ToHex`] and [`FromHex`] instead.
+//!
+//! # Example
+//!
+//! ```
+//! # #[cfg(not(feature = "alloc"))]
+//! # let mut output = [0; 0x18];
+//! #
+//! # #[cfg(not(feature = "alloc"))]
+//! # hex::encode_to_slice(b"Hello world!", &mut output).unwrap();
+//! #
+//! # #[cfg(not(feature = "alloc"))]
+//! # let hex_string = ::core::str::from_utf8(&output).unwrap();
+//! #
+//! # #[cfg(feature = "alloc")]
+//! let hex_string = hex::encode("Hello world!");
+//!
+//! println!("{}", hex_string); // Prints "48656c6c6f20776f726c6421"
+//!
+//! # assert_eq!(hex_string, "48656c6c6f20776f726c6421");
+//! ```
+
+#![doc(html_root_url = "https://docs.rs/hex/0.4.3")]
+#![cfg_attr(not(feature = "std"), no_std)]
+#![cfg_attr(docsrs, feature(doc_cfg))]
+#![allow(clippy::unreadable_literal)]
+
+#[cfg(feature = "alloc")]
+extern crate alloc;
+#[cfg(feature = "alloc")]
+use alloc::{string::String, vec::Vec};
+
+use core::iter;
+
+mod error;
+pub use crate::error::FromHexError;
+
+#[cfg(feature = "serde")]
+#[cfg_attr(docsrs, doc(cfg(feature = "serde")))]
+pub mod serde;
+#[cfg(feature = "serde")]
+pub use crate::serde::deserialize;
+#[cfg(all(feature = "alloc", feature = "serde"))]
+pub use crate::serde::{serialize, serialize_upper};
+
+/// Encoding values as hex string.
+///
+/// This trait is implemented for all `T` which implement `AsRef<[u8]>`. This
+/// includes `String`, `str`, `Vec<u8>` and `[u8]`.
+///
+/// # Example
+///
+/// ```
+/// use hex::ToHex;
+///
+/// println!("{}", "Hello world!".encode_hex::<String>());
+/// # assert_eq!("Hello world!".encode_hex::<String>(), "48656c6c6f20776f726c6421".to_string());
+/// ```
+///
+/// *Note*: instead of using this trait, you might want to use [`encode()`].
+pub trait ToHex {
+    /// Encode the hex strict representing `self` into the result. Lower case
+    /// letters are used (e.g. `f9b4ca`)
+    fn encode_hex<T: iter::FromIterator<char>>(&self) -> T;
+
+    /// Encode the hex strict representing `self` into the result. Upper case
+    /// letters are used (e.g. `F9B4CA`)
+    fn encode_hex_upper<T: iter::FromIterator<char>>(&self) -> T;
+}
+
+const HEX_CHARS_LOWER: &[u8; 16] = b"0123456789abcdef";
+const HEX_CHARS_UPPER: &[u8; 16] = b"0123456789ABCDEF";
+
+struct BytesToHexChars<'a> {
+    inner: ::core::slice::Iter<'a, u8>,
+    table: &'static [u8; 16],
+    next: Option<char>,
+}
+
+impl<'a> BytesToHexChars<'a> {
+    fn new(inner: &'a [u8], table: &'static [u8; 16]) -> BytesToHexChars<'a> {
+        BytesToHexChars {
+            inner: inner.iter(),
+            table,
+            next: None,
+        }
+    }
+}
+
+impl<'a> Iterator for BytesToHexChars<'a> {
+    type Item = char;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        match self.next.take() {
+            Some(current) => Some(current),
+            None => self.inner.next().map(|byte| {
+                let current = self.table[(byte >> 4) as usize] as char;
+                self.next = Some(self.table[(byte & 0x0F) as usize] as char);
+                current
+            }),
+        }
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        let length = self.len();
+        (length, Some(length))
+    }
+}
+
+impl<'a> iter::ExactSizeIterator for BytesToHexChars<'a> {
+    fn len(&self) -> usize {
+        let mut length = self.inner.len() * 2;
+        if self.next.is_some() {
+            length += 1;
+        }
+        length
+    }
+}
+
+#[inline]
+fn encode_to_iter<T: iter::FromIterator<char>>(table: &'static [u8; 16], source: &[u8]) -> T {
+    BytesToHexChars::new(source, table).collect()
+}
+
+impl<T: AsRef<[u8]>> ToHex for T {
+    fn encode_hex<U: iter::FromIterator<char>>(&self) -> U {
+        encode_to_iter(HEX_CHARS_LOWER, self.as_ref())
+    }
+
+    fn encode_hex_upper<U: iter::FromIterator<char>>(&self) -> U {
+        encode_to_iter(HEX_CHARS_UPPER, self.as_ref())
+    }
+}
+
+/// Types that can be decoded from a hex string.
+///
+/// This trait is implemented for `Vec<u8>` and small `u8`-arrays.
+///
+/// # Example
+///
+/// ```
+/// use core::str;
+/// use hex::FromHex;
+///
+/// let buffer = <[u8; 12]>::from_hex("48656c6c6f20776f726c6421")?;
+/// let string = str::from_utf8(&buffer).expect("invalid buffer length");
+///
+/// println!("{}", string); // prints "Hello world!"
+/// # assert_eq!("Hello world!", string);
+/// # Ok::<(), hex::FromHexError>(())
+/// ```
+pub trait FromHex: Sized {
+    type Error;
+
+    /// Creates an instance of type `Self` from the given hex string, or fails
+    /// with a custom error type.
+    ///
+    /// Both, upper and lower case characters are valid and can even be
+    /// mixed (e.g. `f9b4ca`, `F9B4CA` and `f9B4Ca` are all valid strings).
+    fn from_hex<T: AsRef<[u8]>>(hex: T) -> Result<Self, Self::Error>;
+}
+
+fn val(c: u8, idx: usize) -> Result<u8, FromHexError> {
+    match c {
+        b'A'..=b'F' => Ok(c - b'A' + 10),
+        b'a'..=b'f' => Ok(c - b'a' + 10),
+        b'0'..=b'9' => Ok(c - b'0'),
+        _ => Err(FromHexError::InvalidHexCharacter {
+            c: c as char,
+            index: idx,
+        }),
+    }
+}
+
+#[cfg(feature = "alloc")]
+impl FromHex for Vec<u8> {
+    type Error = FromHexError;
+
+    fn from_hex<T: AsRef<[u8]>>(hex: T) -> Result<Self, Self::Error> {
+        let hex = hex.as_ref();
+        if hex.len() % 2 != 0 {
+            return Err(FromHexError::OddLength);
+        }
+
+        hex.chunks(2)
+            .enumerate()
+            .map(|(i, pair)| Ok(val(pair[0], 2 * i)? << 4 | val(pair[1], 2 * i + 1)?))
+            .collect()
+    }
+}
+
+// Helper macro to implement the trait for a few fixed sized arrays. Once Rust
+// has type level integers, this should be removed.
+macro_rules! from_hex_array_impl {
+    ($($len:expr)+) => {$(
+        impl FromHex for [u8; $len] {
+            type Error = FromHexError;
+
+            fn from_hex<T: AsRef<[u8]>>(hex: T) -> Result<Self, Self::Error> {
+                let mut out = [0_u8; $len];
+                decode_to_slice(hex, &mut out as &mut [u8])?;
+                Ok(out)
+            }
+        }
+    )+}
+}
+
+from_hex_array_impl! {
+    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
+    17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
+    33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
+    49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
+    65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80
+    81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96
+    97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112
+    113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128
+    160 192 200 224 256 384 512 768 1024 2048 4096 8192 16384 32768
+}
+
+#[cfg(any(target_pointer_width = "32", target_pointer_width = "64"))]
+from_hex_array_impl! {
+    65536 131072 262144 524288 1048576 2097152 4194304 8388608
+    16777216 33554432 67108864 134217728 268435456 536870912
+    1073741824 2147483648
+}
+
+#[cfg(target_pointer_width = "64")]
+from_hex_array_impl! {
+    4294967296
+}
+
+/// Encodes `data` as hex string using lowercase characters.
+///
+/// Lowercase characters are used (e.g. `f9b4ca`). The resulting string's
+/// length is always even, each byte in `data` is always encoded using two hex
+/// digits. Thus, the resulting string contains exactly twice as many bytes as
+/// the input data.
+///
+/// # Example
+///
+/// ```
+/// assert_eq!(hex::encode("Hello world!"), "48656c6c6f20776f726c6421");
+/// assert_eq!(hex::encode(vec![1, 2, 3, 15, 16]), "0102030f10");
+/// ```
+#[must_use]
+#[cfg(feature = "alloc")]
+pub fn encode<T: AsRef<[u8]>>(data: T) -> String {
+    data.encode_hex()
+}
+
+/// Encodes `data` as hex string using uppercase characters.
+///
+/// Apart from the characters' casing, this works exactly like `encode()`.
+///
+/// # Example
+///
+/// ```
+/// assert_eq!(hex::encode_upper("Hello world!"), "48656C6C6F20776F726C6421");
+/// assert_eq!(hex::encode_upper(vec![1, 2, 3, 15, 16]), "0102030F10");
+/// ```
+#[must_use]
+#[cfg(feature = "alloc")]
+pub fn encode_upper<T: AsRef<[u8]>>(data: T) -> String {
+    data.encode_hex_upper()
+}
+
+/// Decodes a hex string into raw bytes.
+///
+/// Both, upper and lower case characters are valid in the input string and can
+/// even be mixed (e.g. `f9b4ca`, `F9B4CA` and `f9B4Ca` are all valid strings).
+///
+/// # Example
+///
+/// ```
+/// assert_eq!(
+///     hex::decode("48656c6c6f20776f726c6421"),
+///     Ok("Hello world!".to_owned().into_bytes())
+/// );
+///
+/// assert_eq!(hex::decode("123"), Err(hex::FromHexError::OddLength));
+/// assert!(hex::decode("foo").is_err());
+/// ```
+#[cfg(feature = "alloc")]
+pub fn decode<T: AsRef<[u8]>>(data: T) -> Result<Vec<u8>, FromHexError> {
+    FromHex::from_hex(data)
+}
+
+/// Decode a hex string into a mutable bytes slice.
+///
+/// Both, upper and lower case characters are valid in the input string and can
+/// even be mixed (e.g. `f9b4ca`, `F9B4CA` and `f9B4Ca` are all valid strings).
+///
+/// # Example
+///
+/// ```
+/// let mut bytes = [0u8; 4];
+/// assert_eq!(hex::decode_to_slice("6b697769", &mut bytes as &mut [u8]), Ok(()));
+/// assert_eq!(&bytes, b"kiwi");
+/// ```
+pub fn decode_to_slice<T: AsRef<[u8]>>(data: T, out: &mut [u8]) -> Result<(), FromHexError> {
+    let data = data.as_ref();
+
+    if data.len() % 2 != 0 {
+        return Err(FromHexError::OddLength);
+    }
+    if data.len() / 2 != out.len() {
+        return Err(FromHexError::InvalidStringLength);
+    }
+
+    for (i, byte) in out.iter_mut().enumerate() {
+        *byte = val(data[2 * i], 2 * i)? << 4 | val(data[2 * i + 1], 2 * i + 1)?;
+    }
+
+    Ok(())
+}
+
+// generates an iterator like this
+// (0, 1)
+// (2, 3)
+// (4, 5)
+// (6, 7)
+// ...
+#[inline]
+fn generate_iter(len: usize) -> impl Iterator<Item = (usize, usize)> {
+    (0..len).step_by(2).zip((0..len).skip(1).step_by(2))
+}
+
+// the inverse of `val`.
+#[inline]
+#[must_use]
+fn byte2hex(byte: u8, table: &[u8; 16]) -> (u8, u8) {
+    let high = table[((byte & 0xf0) >> 4) as usize];
+    let low = table[(byte & 0x0f) as usize];
+
+    (high, low)
+}
+
+/// Encodes some bytes into a mutable slice of bytes.
+///
+/// The output buffer, has to be able to hold at least `input.len() * 2` bytes,
+/// otherwise this function will return an error.
+///
+/// # Example
+///
+/// ```
+/// # use hex::FromHexError;
+/// # fn main() -> Result<(), FromHexError> {
+/// let mut bytes = [0u8; 4 * 2];
+///
+/// hex::encode_to_slice(b"kiwi", &mut bytes)?;
+/// assert_eq!(&bytes, b"6b697769");
+/// # Ok(())
+/// # }
+/// ```
+pub fn encode_to_slice<T: AsRef<[u8]>>(input: T, output: &mut [u8]) -> Result<(), FromHexError> {
+    if input.as_ref().len() * 2 != output.len() {
+        return Err(FromHexError::InvalidStringLength);
+    }
+
+    for (byte, (i, j)) in input
+        .as_ref()
+        .iter()
+        .zip(generate_iter(input.as_ref().len() * 2))
+    {
+        let (high, low) = byte2hex(*byte, HEX_CHARS_LOWER);
+        output[i] = high;
+        output[j] = low;
+    }
+
+    Ok(())
+}
+
+#[cfg(test)]
+mod test {
+    use super::*;
+    #[cfg(feature = "alloc")]
+    use alloc::string::ToString;
+    use pretty_assertions::assert_eq;
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    fn test_gen_iter() {
+        let result = vec![(0, 1), (2, 3)];
+
+        assert_eq!(generate_iter(5).collect::<Vec<_>>(), result);
+    }
+
+    #[test]
+    fn test_encode_to_slice() {
+        let mut output_1 = [0; 4 * 2];
+        encode_to_slice(b"kiwi", &mut output_1).unwrap();
+        assert_eq!(&output_1, b"6b697769");
+
+        let mut output_2 = [0; 5 * 2];
+        encode_to_slice(b"kiwis", &mut output_2).unwrap();
+        assert_eq!(&output_2, b"6b69776973");
+
+        let mut output_3 = [0; 100];
+
+        assert_eq!(
+            encode_to_slice(b"kiwis", &mut output_3),
+            Err(FromHexError::InvalidStringLength)
+        );
+    }
+
+    #[test]
+    fn test_decode_to_slice() {
+        let mut output_1 = [0; 4];
+        decode_to_slice(b"6b697769", &mut output_1).unwrap();
+        assert_eq!(&output_1, b"kiwi");
+
+        let mut output_2 = [0; 5];
+        decode_to_slice(b"6b69776973", &mut output_2).unwrap();
+        assert_eq!(&output_2, b"kiwis");
+
+        let mut output_3 = [0; 4];
+
+        assert_eq!(
+            decode_to_slice(b"6", &mut output_3),
+            Err(FromHexError::OddLength)
+        );
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    fn test_encode() {
+        assert_eq!(encode("foobar"), "666f6f626172");
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    fn test_decode() {
+        assert_eq!(
+            decode("666f6f626172"),
+            Ok(String::from("foobar").into_bytes())
+        );
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    pub fn test_from_hex_okay_str() {
+        assert_eq!(Vec::from_hex("666f6f626172").unwrap(), b"foobar");
+        assert_eq!(Vec::from_hex("666F6F626172").unwrap(), b"foobar");
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    pub fn test_from_hex_okay_bytes() {
+        assert_eq!(Vec::from_hex(b"666f6f626172").unwrap(), b"foobar");
+        assert_eq!(Vec::from_hex(b"666F6F626172").unwrap(), b"foobar");
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    pub fn test_invalid_length() {
+        assert_eq!(Vec::from_hex("1").unwrap_err(), FromHexError::OddLength);
+        assert_eq!(
+            Vec::from_hex("666f6f6261721").unwrap_err(),
+            FromHexError::OddLength
+        );
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    pub fn test_invalid_char() {
+        assert_eq!(
+            Vec::from_hex("66ag").unwrap_err(),
+            FromHexError::InvalidHexCharacter { c: 'g', index: 3 }
+        );
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    pub fn test_empty() {
+        assert_eq!(Vec::from_hex("").unwrap(), b"");
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    pub fn test_from_hex_whitespace() {
+        assert_eq!(
+            Vec::from_hex("666f 6f62617").unwrap_err(),
+            FromHexError::InvalidHexCharacter { c: ' ', index: 4 }
+        );
+    }
+
+    #[test]
+    pub fn test_from_hex_array() {
+        assert_eq!(
+            <[u8; 6] as FromHex>::from_hex("666f6f626172"),
+            Ok([0x66, 0x6f, 0x6f, 0x62, 0x61, 0x72])
+        );
+
+        assert_eq!(
+            <[u8; 5] as FromHex>::from_hex("666f6f626172"),
+            Err(FromHexError::InvalidStringLength)
+        );
+    }
+
+    #[test]
+    #[cfg(feature = "alloc")]
+    fn test_to_hex() {
+        assert_eq!(
+            [0x66, 0x6f, 0x6f, 0x62, 0x61, 0x72].encode_hex::<String>(),
+            "666f6f626172".to_string(),
+        );
+
+        assert_eq!(
+            [0x66, 0x6f, 0x6f, 0x62, 0x61, 0x72].encode_hex_upper::<String>(),
+            "666F6F626172".to_string(),
+        );
+    }
+}
diff --git a/rust/hex/serde.rs b/rust/hex/serde.rs
new file mode 100644
index 000000000000..335a15132a27
--- /dev/null
+++ b/rust/hex/serde.rs
@@ -0,0 +1,102 @@
+//! Hex encoding with `serde`.
+#[cfg_attr(
+    all(feature = "alloc", feature = "serde"),
+    doc = r##"
+# Example
+
+```
+use serde::{Serialize, Deserialize};
+
+#[derive(Serialize, Deserialize)]
+struct Foo {
+    #[serde(with = "hex")]
+    bar: Vec<u8>,
+}
+```
+"##
+)]
+use serde::de::{Error, Visitor};
+use serde::Deserializer;
+#[cfg(feature = "alloc")]
+use serde::Serializer;
+
+#[cfg(feature = "alloc")]
+use alloc::string::String;
+
+use core::fmt;
+use core::marker::PhantomData;
+
+use crate::FromHex;
+
+#[cfg(feature = "alloc")]
+use crate::ToHex;
+
+/// Serializes `data` as hex string using uppercase characters.
+///
+/// Apart from the characters' casing, this works exactly like `serialize()`.
+#[cfg(feature = "alloc")]
+pub fn serialize_upper<S, T>(data: T, serializer: S) -> Result<S::Ok, S::Error>
+where
+    S: Serializer,
+    T: ToHex,
+{
+    let s = data.encode_hex_upper::<String>();
+    serializer.serialize_str(&s)
+}
+
+/// Serializes `data` as hex string using lowercase characters.
+///
+/// Lowercase characters are used (e.g. `f9b4ca`). The resulting string's length
+/// is always even, each byte in data is always encoded using two hex digits.
+/// Thus, the resulting string contains exactly twice as many bytes as the input
+/// data.
+#[cfg(feature = "alloc")]
+pub fn serialize<S, T>(data: T, serializer: S) -> Result<S::Ok, S::Error>
+where
+    S: Serializer,
+    T: ToHex,
+{
+    let s = data.encode_hex::<String>();
+    serializer.serialize_str(&s)
+}
+
+/// Deserializes a hex string into raw bytes.
+///
+/// Both, upper and lower case characters are valid in the input string and can
+/// even be mixed (e.g. `f9b4ca`, `F9B4CA` and `f9B4Ca` are all valid strings).
+pub fn deserialize<'de, D, T>(deserializer: D) -> Result<T, D::Error>
+where
+    D: Deserializer<'de>,
+    T: FromHex,
+    <T as FromHex>::Error: fmt::Display,
+{
+    struct HexStrVisitor<T>(PhantomData<T>);
+
+    impl<'de, T> Visitor<'de> for HexStrVisitor<T>
+    where
+        T: FromHex,
+        <T as FromHex>::Error: fmt::Display,
+    {
+        type Value = T;
+
+        fn expecting(&self, f: &mut fmt::Formatter) -> fmt::Result {
+            write!(f, "a hex encoded string")
+        }
+
+        fn visit_str<E>(self, data: &str) -> Result<Self::Value, E>
+        where
+            E: Error,
+        {
+            FromHex::from_hex(data).map_err(Error::custom)
+        }
+
+        fn visit_borrowed_str<E>(self, data: &'de str) -> Result<Self::Value, E>
+        where
+            E: Error,
+        {
+            FromHex::from_hex(data).map_err(Error::custom)
+        }
+    }
+
+    deserializer.deserialize_str(HexStrVisitor(PhantomData))
+}
-- 
2.34.1


