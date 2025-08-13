Return-Path: <linux-fsdevel+bounces-57744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E1B24DFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680793B2CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A52882C7;
	Wed, 13 Aug 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6fbZ9B+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA427C150;
	Wed, 13 Aug 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099614; cv=none; b=E0syqDC6NfQpmtKg/7PNwHmqg2Gxc1NYcfmdBzgziR6EAA6IhVsfLOn3wbt+t9nkoIBD7kpwgroJoLuXPbJ1nVgcM3XBCeB94cAPh5tvj7FgxCUFX9QUcsAd/2cIAUAX/WV1fGkIra0szh3kYlGSPHO0J3jZPnpaze0huJIOoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099614; c=relaxed/simple;
	bh=crPkoR00cXYcPvikGdstY+SXedz+0EWwi2X94sQLRp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYG1fQujCtbceRXKCevVBI91e2dRe3Q9aUsaudp7mvM26OoujGoV01CPMAAIod+uz3O93UKxOa63hCvSQnKKUiV96NDzqYEASIoztvI09+sS03sXm/3rtfByYeEHAVUWI271OeVD13gwUrP3h8UncYzNhjgn/o066X4ORPE1iCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6fbZ9B+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e86faa158fso2381885a.1;
        Wed, 13 Aug 2025 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099612; x=1755704412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izK/WiAPZAaZKlIcAkFE0rrz+1wIUxFG7qzyjlv/jF0=;
        b=A6fbZ9B+mWkTKfhgQ52jktCmGH4KGjJvnbB4e/kqpbEI9jytizRDioO5NIW26PRDkO
         0z3jyQTLfU0K/ho1pRASwLJcUrefOnv3Ilg5kiCyJw1n4D9x1hBsbnUjekYB1bPO8Wlk
         vb23pEdMN98uFbaucwlYYcJwMyK3qFeWYklcaCPdFQx6Cz6hbqNFK7Q9nbEPKQBCCtYk
         A1IweCB4apnzkYaIlFvAynvTCSB/vO9j1wpXcT+gIKDouVyRygoTXaKNxSl4gprCmlcs
         OWYVkl+TG52qSBxp1O4WSt4Q7d1tt8CcJ1ADZXKpt0b/uIujo/8WAcYSPAW40GX+eG58
         fAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099612; x=1755704412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izK/WiAPZAaZKlIcAkFE0rrz+1wIUxFG7qzyjlv/jF0=;
        b=odWbzkIQC8cWfRhlsMx3Rnt1lVE1XVH1egfrl+i7eZ3pnn4De8fyoXMh9lwH7lShXw
         1i4oRilxPIQ20xsyT8Fa/BOyi+zuVD0RR3GCPvPgYXVVUhkIDps0c1qZcJObCA05Ozba
         HODaOzY1iVI+4Qv/+jq1pAUx7O5BW6sAC/ufKLNTa5JXDQC2Cd/7Gaw2OWZPulkz/GfJ
         jd0ZQcNcpMde9++7XyKVnB7vZBG05ycOU3NB26RGj5f+VS579p+hsKZQdy2Og6vmjQze
         Ii24qV5UB6Y4zqMTYw2ySdaoFFy+Tdh4kOI0QOJWZVHSfcmZxU7+860lSIsMwfsioVpQ
         CK9g==
X-Forwarded-Encrypted: i=1; AJvYcCUa7olgqubRcAsxUTWvN8JebfnoORBL5VkOj/yx7dOZgD8ydZG6IN0WH7v9VvwrZIONhyGW7pi0p0rrKjvvrA==@vger.kernel.org, AJvYcCVvr4zF0Sj+qYeAg22TpOTFW/kQcnvYd1gC8aoBQ1CK57hahnHaQjcdxtrAG7I/Oe+znX89REc21fVqMOtpTqlV@vger.kernel.org, AJvYcCWje9a7Nj9pKb8TubUzc6x3eiE40SBTRuWNy7sRfCysZ0v5hP1e/nArRZkltxVRDT7OZIxAcXlvpoF60CBZ@vger.kernel.org, AJvYcCXPsWjASYUzPxqlTP/qfrWFBMRemf1eG9iP7ML925Ew3EMN34pK2uzSIMIfYDmiJAchbPzHoxfBXZsduA==@vger.kernel.org, AJvYcCXUsRgk2sy+jI4QYCf4UmiA98ktUjFT8zIc8bZbHOjJI+2rs+HtPRZuQSsgOdhQCkxjy5TGmZteVO4Qhk2yznU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmlOD3geTVsl487zUWceArx8epQijR/ebbatt817w/T0w/LIq
	GMCVO8r5RqI6Kh2b4mxWtGAtBJMticyqLgUOPeOOvM1rr/O9uREeXyfl
X-Gm-Gg: ASbGncvUbbPpWbzhSfWLR8C6x6XDiqWifsnuEUngKKUYmyFatS6/S8fJyWzo0jt0zh3
	VU2JMO17L/OWKo0J6GX6YpCRpM1O5j2zLbrngE6l5RKVAEB8ugEIOyKUGUgfKzVW0c3UmYQl/P+
	FMZpCo5DcjZPdyj9Xxq56rM8QfHFKpozmCX3Nujk1jEWmf57SqS0cX6pgfDekqjFLruGG3/LDDL
	noqraXkcFngGj7gtZXEATa1i/g4Dnt19ZvEOWNUPvVMqIPmJL/2aln4q85Sk3PWXcOBQ5QFxF4b
	pLXNI16uWjGWKX8Ae1kzA9LJ9ttzLASkPVB0CH42M9wN7AfmM8hY6LbPV5t3ijewzgxPQsl+17E
	8pDMEqnh0chIGvs2xxOlM2e0ZuywNw3E6Werz5A+vqPBIntdgRwjq6QiSOtiRAUDEimsk6QwFe9
	K2fEimGH2MTIYe+i/fa37pYqTERQ4nOsUyWw==
X-Google-Smtp-Source: AGHT+IHZn/g5szhfMfFQFGXYl+pBHg/EpdCIVARFA50+xJj+KXURmnbR4Sb92/OTyxkaNK5Lvur9xQ==
X-Received: by 2002:a05:620a:4505:b0:7e6:8b21:fe8b with SMTP id af79cd13be357-7e86fa5af32mr11093685a.0.1755099611401;
        Wed, 13 Aug 2025 08:40:11 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f728a6asm1976119385a.64.2025.08.13.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:40:10 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:39:54 -0400
Subject: [PATCH v3 9/9] rust: device: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-9-a15eca059c51@gmail.com>
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099591; l=3475;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=crPkoR00cXYcPvikGdstY+SXedz+0EWwi2X94sQLRp0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKPx7imLLl1IyTUMbn/UU9jRwKiWRs/5JaaYbOw7kxpIJQbxaN+IToLgk64d7J03HxECB5q+Z4M
 nXv5TSbO1yAs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/device/property.rs | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 49ee12a906db..3a332a8c53a9 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -11,6 +11,7 @@
     alloc::KVec,
     bindings,
     error::{to_result, Result},
+    fmt,
     prelude::*,
     str::{CStr, CString},
     types::{ARef, Opaque},
@@ -68,16 +69,16 @@ pub fn is_of_node(&self) -> bool {
         unsafe { bindings::is_of_node(self.as_raw()) }
     }
 
-    /// Returns an object that implements [`Display`](core::fmt::Display) for
+    /// Returns an object that implements [`Display`](fmt::Display) for
     /// printing the name of a node.
     ///
     /// This is an alternative to the default `Display` implementation, which
     /// prints the full path.
-    pub fn display_name(&self) -> impl core::fmt::Display + '_ {
+    pub fn display_name(&self) -> impl fmt::Display + '_ {
         struct FwNodeDisplayName<'a>(&'a FwNode);
 
-        impl core::fmt::Display for FwNodeDisplayName<'_> {
-            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        impl fmt::Display for FwNodeDisplayName<'_> {
+            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // SAFETY: `self` is valid by its type invariant.
                 let name = unsafe { bindings::fwnode_get_name(self.0.as_raw()) };
                 if name.is_null() {
@@ -87,7 +88,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
                 // - `fwnode_get_name` returns null or a valid C string.
                 // - `name` was checked to be non-null.
                 let name = unsafe { CStr::from_char_ptr(name) };
-                write!(f, "{name}")
+                fmt::Display::fmt(name, f)
             }
         }
 
@@ -351,8 +352,8 @@ pub fn is_empty(&self) -> bool {
     }
 }
 
-impl core::fmt::Debug for FwNodeReferenceArgs {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for FwNodeReferenceArgs {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "{:?}", self.as_slice())
     }
 }
@@ -377,8 +378,8 @@ enum Node<'a> {
     Owned(ARef<FwNode>),
 }
 
-impl core::fmt::Display for FwNode {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Display for FwNode {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         // The logic here is the same as the one in lib/vsprintf.c
         // (fwnode_full_name_string).
 
@@ -413,9 +414,9 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
                 // SAFETY: `fwnode_get_name_prefix` returns null or a
                 // valid C string.
                 let prefix = unsafe { CStr::from_char_ptr(prefix) };
-                write!(f, "{prefix}")?;
+                fmt::Display::fmt(prefix, f)?;
             }
-            write!(f, "{}", fwnode.display_name())?;
+            fmt::Display::fmt(&fwnode.display_name(), f)?;
         }
 
         Ok(())

-- 
2.50.1


