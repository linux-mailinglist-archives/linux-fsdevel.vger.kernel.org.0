Return-Path: <linux-fsdevel+bounces-76309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIxuGHg0g2kwjAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 12:58:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FBE56BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 12:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18E1430074AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE103ED129;
	Wed,  4 Feb 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWgJ7vqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637183D4132;
	Wed,  4 Feb 2026 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206285; cv=none; b=P9QHlIi8EHu8qxTYykjc9TlXWmE7QGRABpFXdmloA4BJM6QHOd2KSfnE9EySxfd980GcYniy+u4X19zNAmEHlGrenwsQBTgGhhK6U9/d9fjtZvV7NO+8SwcU42tYAM3bmXfVdWYYG3RAsMAIXHRW6uJrATxSsxLlXyzyyKUM1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206285; c=relaxed/simple;
	bh=c2p54y/pAhnBEdMSbuIx3iZj3XWho61Cf1y9xR2YDhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5IDsJ4rrkw+fwRLJPcp5hqeFCctkGhWfudEJQSop5HjQWLtvS8LxqXknOruI+CbO2b3MejHO5f+j3DzKMIGobysLA4i2YCEuhibmRQs21T9nQhkH0mBA4rC2ItjA5gHNyp1brZtzRDCJorTnrlS5WX8CaGakwfdNVzojmx2khY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWgJ7vqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0BCC4CEF7;
	Wed,  4 Feb 2026 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206285;
	bh=c2p54y/pAhnBEdMSbuIx3iZj3XWho61Cf1y9xR2YDhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pWgJ7vqNJD8qw9H62F41a+IyFWjd51pc+AHkRbmLJuxmCSc4sZOUMvjcri+R6nekk
	 XY/gZrjgCGaOI9A8tVQsKCS1RNjnQcAfRGuDLXvKA281qgwBo126KEMXpK6grvmVZw
	 Bw8ByJxEZ+PZ0f0GpeDewSgVQ91hK5150Ls76Bo8cm2S2PlC+5JNUcri0yc++EIQl+
	 kNfwrMU/0yG4VQt9vY2sOEdrXibri84JnGLDgDOfUqpuxFyBJKi7YdcAtralLSqLfV
	 yduxBbniHcTFDcClY5YKR1ODZuDOLaA6CQJH0Den9kJWI1c68FgJMXZph8PTEh0gHP
	 6U4R0xV8UPZKg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 04 Feb 2026 12:56:51 +0100
Subject: [PATCH v14 7/9] rust: page: convert to `Ownable`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-unique-ref-v14-7-17cb29ebacbb@kernel.org>
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
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Asahi Lina <lina+kernel@asahilina.net>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4220; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=FvgSRVnZWbKwiBgsZbTbds4VyUjBG0VqS2LEVRR8T4M=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzQF3kN9mHdfQUXkp64epI5aSl8D87Au9J4JZ
 BI3oEDLgDeJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYM0BQAKCRDhuBo+eShj
 d2ywEAC8FyaOp71E081s63SKilLPbpt7rb1EA7gDcRJwDI58JBuU7jJKM6yOk3RjZKzUIPPMobB
 hd0UD25zrRDuhGWxP7k1YmEBBEMggWw6ns+CGJcab1yS3ckrPdrrtXq9c/iL02VE7VgV11Wrl+G
 SWUO2BuZbFK2apxYAbl21RMf3MAQ8j1My4Dmulq1xjb0oh6SekC8BPCR/PU0sGNaX3HBcOFVaKi
 WWq8YfG5J6M7mk0RTA9LCq0qp03TfGiDv6FhGp2vVqBRj2HzH6A8SJ17zMyVHAziyQi3ll7I5/7
 Imw2djBsHJxwwbDYkFG4kYNzWG83iTXw8C5XRO5AHQzDtrO9I9HcUUn1WGvzb1YngNXrwcKs7/h
 6vIPOGYTsj7sme89ANt8DLQhEpWPXGHntpUjhgfwCWN+Y+mJlM9Zl0mev2GUlpUcTIula7EA2DA
 lg6iFabhl48WFVLZT2PBo+wvckSqcirMcacSliac3mYkKGh/f2OibUcRho4idWDOjMmIItNdPbA
 EEx2NPX8c239fzWWo4sG2MS8YKjiH70VXEAEemFDKdPOKeyBvhQz0LaFzmMMVwKyC9AQNYWYSWU
 lbAwIYkUsVBFT/oXjGsQNrUWaX/mKjFJHa1gUS9Ts3frcSXpOa9pPb0ORpCZYOAf51nACen/nor
 YuBBF93SjC6LvMQ==
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
	TAGGED_FROM(0.00)[bounces-76309-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asahilina.net:email]
X-Rspamd-Queue-Id: 096FBE56BD
X-Rspamd-Action: no action

From: Asahi Lina <lina+kernel@asahilina.net>

This allows Page references to be returned as borrowed references,
without necessarily owning the struct page.

Original patch by Asahi Lina <lina@asahilina.net> [1].

Link: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-2-e3170d7fe55e@asahilina.net/ [1]
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



