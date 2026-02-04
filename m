Return-Path: <linux-fsdevel+bounces-76307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA+OM0U0g2kwjAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 12:57:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E90E563B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 12:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A225830067A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE93ECBED;
	Wed,  4 Feb 2026 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itkw+GCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41629ACDB;
	Wed,  4 Feb 2026 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206267; cv=none; b=kH2dBWXSgY6fML41WECkwvcugzulq/KyxGmrfg+vcpD02kflNGLglUlj3MliKMAJjzKbBZqqERYDkqF0q4VMdM/DjzaeBeM/15O7WhbtlcVH0Fa3F4pcZPPhtUQTZgKO7ybb6pSCs5X0qMWQT8sm79cBT7y35MrkLHyjtwiuHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206267; c=relaxed/simple;
	bh=xYW/EeCkC7WedEcSi5MqPHN0tL67nyGJDfMj502jbkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkyWjP2g/8eA77NK3so4fH5yZ+6qMrzdcoH+sYYCKlEeCIqAg30AJqi8edpET47KuySHhzRauVM80uPM4e9IBmPu3S+M5eLzYXllU4sF9edhIGswnF6Ok/WIsZRWYFnB7xKe+so06wbm+hZHvJhrXnBNAVPcFy5dvemQRpD+h0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itkw+GCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E66C4AF0E;
	Wed,  4 Feb 2026 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206267;
	bh=xYW/EeCkC7WedEcSi5MqPHN0tL67nyGJDfMj502jbkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Itkw+GCNuRyDWXobTgUJcS0pi6d1d1IBIwP+ooRlXy0f3+lPDetjhnmjZeS9VJgHt
	 r0yLrn7GditsJD2Tm1N1gbCQN9s+9IUvKv+et91wsaWYk3qwciisdi/+iCDbxHrROQ
	 wiNXxV37ZbzioI73sfI7hl2MbwGmKU+oxHIVm/pl4lah4z2qmWPuRA0KZ1Lp1sqJnr
	 E4BMpjqZqXsjZHvQiO/iq/7sEudkcmLBqaFL2tsdS7WyAEjlPz/Uw9ze+TegewBRRe
	 RhJYceIJMBvayhDJ6sZrJ2AzSrWAH0c5De27h1++JVNt20VygfPsTBEoN6/Uz5WkaD
	 lqBWsvmAuVsKw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 04 Feb 2026 12:56:52 +0100
Subject: [PATCH v14 8/9] rust: implement `ForeignOwnable` for `Owned`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-unique-ref-v14-8-17cb29ebacbb@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2835; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=xYW/EeCkC7WedEcSi5MqPHN0tL67nyGJDfMj502jbkc=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzQFB4UxUyi+TEbDKWq5K/ySzEfM5XJVGiPel
 DNbl61aM+mJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYM0BQAKCRDhuBo+eShj
 d8QnEAC7f+kfpFQ8VLvycQ5Uf37pSzh9CYSYLkEq9ijS1CiF4hKH9X3nU3Jh81xadjC2JLKPzWO
 XhZrVS7p05z3yuXExsxLGrfdzQMdGZfmg9tz4wSK3Kqp7zkSV842fbhhHF+1Sv282MFdRUkypLM
 TtXX4NRi3xI334xjlcthZgupM0rUmr16rmKrB9ftOZ8apraAqlOLUTmq80/rC9P2cIYbZufq6Ue
 WnVWMmbo4mZaPLhlxtSg5zW7+1NveUwbbhfbUt8iWEZN3xH5F+ZAo7xV5LSyw2T2kim3dUDy07I
 Mdvgncb8HdJ35ird6WIQTOCi0uWHGsB+377g0ILl4Q2Cwd/rg5R3BhB+ssit3WwMN0wAVlqpBs2
 pkmVCrdCTGZG66fHJhioyeIl0jWzpBYEmBhwjnDwCjjiJRkqRGCUx/xm61UB/CSRV4Pj1omlZ8d
 qq4cmZhByK/hOGcEnn9GSxNaNFE4GOIrpueIw/DrBR0i3MEFbhsvzIISSq+IvHqzYgTBHNZx+IV
 dIyYk9FkYSmd/xopL6yAlO+RCfDEfdd9RIehEPoNy67J+egJGn82xW2nTOba4kLHA4p13PQeiPc
 hJm/5hN4Jk/emxqkuTYm7z0c3EHsegKGgDQz7+X5xcwk1sHkRLP3YmaH/E/6xsWw/HkG6HVV/M+
 eaj7ey+B3OL2jXw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76307-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79E90E563B
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
index 85251c57f86c6..0b22de4aaf584 100644
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
@@ -120,6 +123,7 @@ pub unsafe trait Ownable {
 ///
 /// - The [`Owned<T>`] has exclusive access to the instance of `T`.
 /// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
+#[repr(transparent)]
 pub struct Owned<T: Ownable> {
     ptr: NonNull<T>,
 }
@@ -201,6 +205,45 @@ fn drop(&mut self) {
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



