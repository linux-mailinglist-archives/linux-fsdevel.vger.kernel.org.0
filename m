Return-Path: <linux-fsdevel+bounces-77776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLCWGdoumGlaCQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:52:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11553166713
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53F33301287E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8A3346A7;
	Fri, 20 Feb 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXf1Qrrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F732D7F1;
	Fri, 20 Feb 2026 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581134; cv=none; b=LXdJc6mroYhPOexp3IouZujNpKNUb9qEmmRDvr74BnDvLBlGYzTZuswYfbim6UCzeulsRKBWYDLEFzvaU7v4YFPJICiwoKtvMeaxvN0n8br4iivnJmfr/MpIIq4gIS/7clHWG5WAJhg4Uojtn4EQXGnootN17yiprtiV3ItaizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581134; c=relaxed/simple;
	bh=PtI8dWeXLCFOQOrt2qgQQvMv1kCph8ZiB7DPs66Ug2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2aqGj7/GWhrmc55O5l88qkrTlsyZBjSWAEAgkAOKfm0QY7CB07kICvxgMMwN44e3J5IeMXeWUE5QJs0AJGwUq++be4UDkNYKHgc5E9PkWq1h5jhb7aL06wRCPfEC+21FHZdbTSKSZ3ulo5zL1GF10XAU9oXOL8XWJCKA/zI3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXf1Qrrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CE7C116D0;
	Fri, 20 Feb 2026 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581134;
	bh=PtI8dWeXLCFOQOrt2qgQQvMv1kCph8ZiB7DPs66Ug2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dXf1QrrrR70di7dbarSVglO5Fj69PyruSvuzBcvFbhIgzxWo02br6JPUlDXhjXmrf
	 f2scy0IQU1JRq7+r9QecQihcBPbcNzeRSvZ6jgaehMhs8Gbx6Z+S6H8KZUv2+xBnq4
	 JsH2OTUHS/7hhdnj41GxFJLGN5jwFe2t9y8LAuDRMaouj9svA8xL1j2RnxYikI5h2f
	 XHsusFjjM2ekUAXmqKbnHx8P8of1p6T43UBEdAzQBGEAtMe3ULzWcnOIxjlBD1IbSF
	 hl9elv7O1k0c6N97uk3jhqX1zXltTxyl0SvULg0R6tWDEr5umcPNpw4ijbCbIuauY5
	 U8dz0BwB7aBmw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Feb 2026 10:51:16 +0100
Subject: [PATCH v15 7/9] rust: page: convert to `Ownable`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-unique-ref-v15-7-893ed86b06cc@kernel.org>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
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
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Asahi Lina <lina+kernel@asahilina.net>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6+8Px7vkn1ot/UgoHpPh8rLqE5ThXe9Oldbg1lnNpkQ=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6k7RfPZnsjTWms0x9n3CTffEUPkBah98XHN
 US147G+SoWJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZgupAAKCRDhuBo+eShj
 dxYZEACJweMLFS/q9Dm1TgYuSREDX3pcc2WCm7GWxm9txjo/5gTIwW/zXsrX37z7tZ7o8YtyFuU
 XPbg69eje9pdUXHRDilmI6KlU04ShDeZo812lmJgMV+NJah9iv3QblmQzw7greeD5ArcP/t6vKo
 APQIUEo8OhYDi7+Uf6HTmglpJKqvQ37nXcRmvFcb4IpLEOAsnFpJ2teFebTrtY1ca/oOlB6arNy
 Vh+HOpyc3Li9e2JdhRQHGMkXi5AmQqLKQsnRE6H7Pmjxm/E1QYVN/FWyxoaYRHErjHQ4rO7QHTh
 LFS/qf5NBk6Q1EUaS2GDmls3B+57VJ2NEIUyMgh9cIb6lMN6+T3EVVEfzqeSGpC8z0+5S3VuJFI
 IPZTv68uPsljfOb8QNysrowdf6KzGXFH047Qk/Ge74gJg9+kgRzTqZI+JxmDn0LWubhvo4TmabC
 o/AvVXVxiKLL2sD0wxsRBXTFNfAh4inpSRigkmlQv+6HTpUJEBuqNeHBIRdwaqQu1+yv2+MG9kt
 0G6BaCyhb6YVQvgSbIjRp6zmRk7Bs4V0aPzqF392zR0XbO1NwkuiPa/HAtknhIqS6WhL8Yi+QrA
 NSRqhV9l6Ad5sxLvkIIEGANdFOBAcK6kzuMfnuOZH0MLB63dDTOtkdp6KERDBSi3aTNZ8lPLNAW
 28WxMmyqzFhJnMA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77776-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asahilina.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11553166713
X-Rspamd-Action: no action

From: Asahi Lina <lina+kernel@asahilina.net>

This allows Page references to be returned as borrowed references,
without necessarily owning the struct page.

Signed-off-by: Asahi Lina <lina@asahilina.net>
[ Andreas: Fix formatting and add a safety comment. ]
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/page.rs | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index bf3bed7e2d3fe..4591b7b01c3d2 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -10,6 +10,11 @@
     bindings,
     error::code::*,
     error::Result,
+    types::{
+        Opaque,
+        Ownable,
+        Owned, //
+    },
     uaccess::UserSliceReader, //
 };
 use core::{
@@ -83,7 +88,7 @@ pub const fn page_align(addr: usize) -> usize {
 ///
 /// [`VBox`]: kernel::alloc::VBox
 /// [`Vmalloc`]: kernel::alloc::allocator::Vmalloc
-pub struct BorrowedPage<'a>(ManuallyDrop<Page>, PhantomData<&'a Page>);
+pub struct BorrowedPage<'a>(ManuallyDrop<Owned<Page>>, PhantomData<&'a Owned<Page>>);
 
 impl<'a> BorrowedPage<'a> {
     /// Constructs a [`BorrowedPage`] from a raw pointer to a `struct page`.
@@ -93,7 +98,9 @@ impl<'a> BorrowedPage<'a> {
     /// - `ptr` must point to a valid `bindings::page`.
     /// - `ptr` must remain valid for the entire lifetime `'a`.
     pub unsafe fn from_raw(ptr: NonNull<bindings::page>) -> Self {
-        let page = Page { page: ptr };
+        let page: Owned<Page> =
+            // SAFETY: By function safety requirements `ptr` is non null and valid for 'a.
+            unsafe { Owned::from_raw(NonNull::new_unchecked(ptr.as_ptr().cast())) };
 
         // INVARIANT: The safety requirements guarantee that `ptr` is valid for the entire lifetime
         // `'a`.
@@ -126,8 +133,9 @@ pub trait AsPageIter {
 /// # Invariants
 ///
 /// The pointer is valid, and has ownership over the page.
+#[repr(transparent)]
 pub struct Page {
-    page: NonNull<bindings::page>,
+    page: Opaque<bindings::page>,
 }
 
 // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
@@ -161,19 +169,20 @@ impl Page {
     /// # Ok::<(), kernel::alloc::AllocError>(())
     /// ```
     #[inline]
-    pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
+    pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
         // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
         // is always safe to call this method.
         let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
         let page = NonNull::new(page).ok_or(AllocError)?;
-        // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
-        // allocated page. We transfer that ownership to the new `Page` object.
-        Ok(Self { page })
+        // SAFETY: We just successfully allocated a page, so we now have ownership of the newly
+        // allocated page. We transfer that ownership to the new `Owned<Page>` object.
+        // Since `Page` is transparent, we can cast the pointer directly.
+        Ok(unsafe { Owned::from_raw(page.cast()) })
     }
 
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
-        self.page.as_ptr()
+        Opaque::cast_into(&self.page)
     }
 
     /// Get the node id containing this page.
@@ -348,10 +357,13 @@ pub unsafe fn copy_from_user_slice_raw(
     }
 }
 
-impl Drop for Page {
+// SAFETY: `Owned<Page>` objects returned by Page::alloc_page() follow the requirements of
+// the Ownable abstraction.
+unsafe impl Ownable for Page {
     #[inline]
-    fn drop(&mut self) {
+    unsafe fn release(this: NonNull<Self>) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
-        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+        // Since Page is transparent, we can cast the raw pointer directly.
+        unsafe { bindings::__free_pages(this.cast().as_ptr(), 0) };
     }
 }

-- 
2.51.2



