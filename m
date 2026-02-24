Return-Path: <linux-fsdevel+bounces-78249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBILGSOKnWnBQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:23:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0607186251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D45F13105B9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111937D117;
	Tue, 24 Feb 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDpqaaZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEA37BE83;
	Tue, 24 Feb 2026 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931990; cv=none; b=P5RoDRMoTv3DjTA/e5CaDwwHSol7MuvHZ8IuTafApLWu/wAPqLr9YhGC0ZgT9czsvHbhJngj4GiChMFCqu7uZyH4N9IgR7q6zHUCeuYsIKhbnL8W18nkXsKiFqd/fbuMGZrXZfuVUjQNiGWEUXF2/i31pzrqH1DX/GQrAgILNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931990; c=relaxed/simple;
	bh=ZXVxYHlu0zHczyQ9RV4gzKJTzAnDzspoUnWv3esNFwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4uwGX8PrsSagcSxu+BHaiCmyAlb8MKNMHpDn2PDFblxeTGogxhGpC0FvL9x3Bva9G9mvABwZa8aiZ97ZiRqID0bsyYxDywHrnBAp+nY9BRg/riJYp70KU9/V3l6wOsJJdFfyk4XL5q8MADu/Mb4BTiEdkZFSY3CkATlMmFrtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDpqaaZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FE0C116D0;
	Tue, 24 Feb 2026 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931989;
	bh=ZXVxYHlu0zHczyQ9RV4gzKJTzAnDzspoUnWv3esNFwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dDpqaaZjsrKAAuBigQMTjSHyxPwyewaJ+Kh431pzCvN3W/5M0RWV/9LsDjrc8NJAn
	 ji8U2nnjIczOlsmv9Cc8A8/xV2GqUP5ESuXy4HSP6AgQdIH6Q8oYe45W47lN8bPXWy
	 dYy9O/c+OBIQAmB31y7RS0nduullT7ZOft6gWwXrfyBcNTM1LXOndDBQcMGZdltFCt
	 kblbrFJuhKDqAQxsaH0YxOn7BGEr/kRvVDvQlDVo5VToqaNaIw5A9B4B2yN5sWcz62
	 jzbZSa9w5/3bCsNch90KohlPX2hcU2oWOPDfWIc7OQeB8SrVG8zCEdClApUuvgU7+4
	 MhoQkxKQ68UDg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 24 Feb 2026 12:18:04 +0100
Subject: [PATCH v16 09/10] rust: implement `ForeignOwnable` for `Owned`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-unique-ref-v16-9-c21afcb118d3@kernel.org>
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
In-Reply-To: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin.linux@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ZXVxYHlu0zHczyQ9RV4gzKJTzAnDzspoUnWv3esNFwE=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYj7ybE9TfHosMN/v3D3om/fVXrbbm9j9l/ed
 /oqHH++SfWJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I+wAKCRDhuBo+eShj
 dyh4D/4seiQJBYM348GadM5XGPLQ2AkZegX5kl5/dCXU3YauTHjS275rRpJntm2vV2eW/wX4Fz6
 I1vb5+83Hx2A47fK+9mEi/LG+DaNNVI0qsjDismLwy7V7Yf6z5qVr3Ds6gcMrdJ0hFGGOnMZXks
 j7xsnNXbvg1HgxnWNbz9QmWQyFXDdI/FPHe09R9WUkuszYtFJ6qlaZQdDQ+pvsCqN4xFC7UsKWu
 sQl1MmCT3Q+1hIHi3ZRrSJGt2CGuXKmrozMQmciIRuPtoMfLbKAz7lkc1alwqFtIaRuVnS68GS4
 dggi4hKlQl8QBTRR4CJQbohp5P/tZtnyBtAmFfLuCUJUBcZmoXKlflQTZiLJlrcdqOlWvIdx8y1
 gkz87chPU0yBGd4aT6TQJZDZzBWa0fGffmvzrdVSUyHT9YreCKsvCEke4GTJArXO7EuthJtMBbC
 Vs6Aysbti08nBgBd4lvF2FhwN5A8dMJprHs3joAecEV7pDVW2w4lEwJ+1prv8vz9B1E+2z8BGwC
 V+7yKZGJYnbUBKB47yqVr1MB1+6MqPRX/7WGPTuKF8MYcKTweCSf8OEgYbXPnA3yzm4VM9iQzGO
 PQXZTqVa3Oj1y5UELjmLwoh6RupeHLk7qDU84qKlFWCv66hFoQvwVTVJ1U8574/2NN/ArwwjTyv
 BK4RQHMK0lR4VdA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78249-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0607186251
X-Rspamd-Action: no action

Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
places such as the `XArray`.

Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
implement `ForeignOwnable`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/owned.rs | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index c81c2ea88124b..505ac2200d2d6 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -16,7 +16,10 @@
 };
 use kernel::{
     sync::aref::ARef,
-    types::RefCounted, //
+    types::{
+        ForeignOwnable, //
+        RefCounted,
+    }, //
 };
 
 /// Types that specify their own way of performing allocation and destruction. Typically, this trait
@@ -114,6 +117,7 @@ pub trait Ownable {
 ///
 /// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
 /// - The `T` value is pinned.
+#[repr(transparent)]
 pub struct Owned<T: Ownable> {
     ptr: NonNull<T>,
 }
@@ -186,6 +190,45 @@ fn drop(&mut self) {
     }
 }
 
+// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
+// pointer satisfy alignment requirements of `T`.
+unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<Owned<T>>();
+
+    type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = Pin<&'a mut T>;
+
+    fn into_foreign(self) -> *mut kernel::ffi::c_void {
+        let ptr = self.ptr.as_ptr().cast();
+        core::mem::forget(self);
+        ptr
+    }
+
+    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
+        Self {
+            // SAFETY: By function safety contract, `ptr` came from
+            // `into_foreign` and cannot be null.
+            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
+        }
+    }
+
+    unsafe fn borrow<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Borrowed<'a> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a
+        // reference for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::BorrowedMut<'a> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a
+        // unique reference for `'a`.
+        let inner = unsafe { &mut *ptr.cast() };
+
+        // SAFETY: We never move out of inner, and we do not hand out mutable
+        // references when `T: !Unpin`.
+        unsafe { Pin::new_unchecked(inner) }
+    }
+}
+
 /// A trait for objects that can be wrapped in either one of the reference types [`Owned`] and
 /// [`ARef`].
 ///

-- 
2.51.2



