Return-Path: <linux-fsdevel+bounces-64599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B0BED98A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAC4EC129
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB54307ACE;
	Sat, 18 Oct 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKx+V4mv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7A280325;
	Sat, 18 Oct 2025 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815047; cv=none; b=ALttmaa40gPEQJ2EJ6dvDMRpMOrwP464ZBhSS4EMu5L6IAXOIWIBdxHrOoC+0zj9hvsygks7f2xZW+KnsK6jmYRHdxtGpeKeaznrznAzjAP13QdHuTbxEm3ehwsMmLd6MynkjxWcdSUD0xE5hFiMC85wlHdwjo1Q3GHquYwYggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815047; c=relaxed/simple;
	bh=pXxOJ/NLtDaH83zqjND6FIXR4v5/73dcrcdTYNg4j1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AgWg0EVC4patOnUUgNMxWEEWq+MzKdliCOfUOzrIK/EVz2OVpvCbGJDRYu7UeKcQUhacOep5Z0hCFjN0m4JnC9plQ7Lef73IKcP5pGLXvtwRaZMompyXs+j4KorMMVn8t4LFdJIoWJsMQugiXbh77/GSlFjNdrF4y7G9udQiVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKx+V4mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1540BC113D0;
	Sat, 18 Oct 2025 19:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815047;
	bh=pXxOJ/NLtDaH83zqjND6FIXR4v5/73dcrcdTYNg4j1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qKx+V4mv9A2FXm2lcL0ZwJREuJkNpo5CrrE5zYCtt8J59hof8FvxjFiBPiISRXkb8
	 qMcRcDAq2hn7fn8dkS9czsTsfSh45A8jdDA4hpUBuntJ3i3Jstul/b5hsQry3+NfGf
	 nizE6lz3lUlmxgH8WeAnfQc73fqqZbWdW1Nkats2rSAwGMLZg6/QoTDM+IJJ3SLBJY
	 ZnLty0z+wRwO11TIFOC0J+pKnTpGZlw9o2MLX02Rjjuiq7uEcE6JqrXK2pGJpQDyET
	 jIuMJYTexD5od0WpD2vEnnzVNRRnwdPImG/Gp8LGq2Vkt/Cm0wrf/JilJblg6q0BLw
	 iqZAkiAJFP1SQ==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 18 Oct 2025 15:16:31 -0400
Subject: [RESEND PATCH v18 10/16] rust: opp: use `CStr::as_char_ptr`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-10-9378a54385f8@gmail.com>
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760814988; l=1431;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=W0kd+lIKrES9E6f3i/NvYS4ZToF7HAzoNGFG8gcpmao=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEaKoEKQMRH8v0Qk2meRSTqql6NHJPYZKph+ocMbSdhqrmQbq3JnhhyFgPsXl5Vy80wy+DRjezA
 6ZmzYy/GqBgI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

Replace the use of `as_ptr` which works through `<CStr as
Deref<Target=&[u8]>::deref()` in preparation for replacing
`kernel::str::CStr` with `core::ffi::CStr` as the latter does not
implement `Deref<Target=&[u8]>`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/opp.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 2c763fa9276d..9d6c58178a6f 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -13,7 +13,7 @@
     cpumask::{Cpumask, CpumaskVar},
     device::Device,
     error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
-    ffi::c_ulong,
+    ffi::{c_char, c_ulong},
     prelude::*,
     str::CString,
     sync::aref::{ARef, AlwaysRefCounted},
@@ -88,12 +88,12 @@ fn drop(&mut self) {
 use macros::vtable;
 
 /// Creates a null-terminated slice of pointers to [`Cstring`]s.
-fn to_c_str_array(names: &[CString]) -> Result<KVec<*const u8>> {
+fn to_c_str_array(names: &[CString]) -> Result<KVec<*const c_char>> {
     // Allocated a null-terminated vector of pointers.
     let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
 
     for name in names.iter() {
-        list.push(name.as_ptr().cast(), GFP_KERNEL)?;
+        list.push(name.as_char_ptr(), GFP_KERNEL)?;
     }
 
     list.push(ptr::null(), GFP_KERNEL)?;

-- 
2.51.1


