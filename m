Return-Path: <linux-fsdevel+bounces-11031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CA85000D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 23:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C08283938
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81F38DD7;
	Fri,  9 Feb 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WoV5P1sJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD99374C1;
	Fri,  9 Feb 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517977; cv=none; b=I54YVp5Bvmv+Jfj9KDhNbTJb8rjakM88l6zR8jCL42mh5JKz6/7cIGvuYR+CEb8x5lMdBDQdkw+2Ce/bnbsEuqPPP1VYbI93dCVApgb2EH6svMM+H3ZXRjx4v/MmTchCoqUePrS1zJQRwM9yaSSXuJNORF1KEg0tKa/L16KTjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517977; c=relaxed/simple;
	bh=hcENHHEng3Hm7OXyhGn4jm0nSp+Rk/iMcy/ak9YXL1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyzxIwWl0wsry/9YCtE228CzU4g25If28JvyGAWdR2WFZzIcnA1y5KPTbCQRR29lqpLGGEuHVe4Sbp5IkialthGMBqwWuKL+fPn54RrVjKjIsjCvX0FBe27UQPeF+HEJ0YY0GoMiwUAiebZT1AHb7k/AbJ8Poqo68eScZ/HGqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WoV5P1sJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ovq8KunKuhUSs3mIHmNCNoa8hYMbeinaxEKjKC6M448=; b=WoV5P1sJEt+nsD4g0A3LwLc8Z/
	uN2rj57L6pNGz1u+UOjNua1vAucaYSnZB0aKLXHkOV4NW59mFpCLt4C+OSs58ECQ4OaT0cFQNWInR
	5pLo3ljYwCbzD4pq98EZeTCI77zigqyU/Q5ojFhUY+BMhRUuz66qk5qLPZZks9EzjhxcUiStjmYpV
	uhXl/SLTTwhtxDGYoWvGHEJOfj74/OCjLuAgOq5bYuPwDwzNQSZPfhSrLytDGY98qbAx6gJFi3s2H
	wOGcbO4MJSP2L3j3mffr7LU7GjgazRmJeE52S10Mza7JSrBBLQSWi0PKW56pZE7J+mpnRWEMJXcrp
	5jYBkARg==;
Received: from [179.234.233.159] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rYZQF-00FjSP-2q; Fri, 09 Feb 2024 23:32:39 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Asahi Lina <lina@asahilina.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v7 1/2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
Date: Fri,  9 Feb 2024 19:31:07 -0300
Message-ID: <20240209223201.2145570-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209223201.2145570-2-mcanal@igalia.com>
References: <20240209223201.2145570-2-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are cases where we need to check the alignment of the pointers
returned by `into_foreign`. Currently, this is not possible to be done
at build time. Therefore, add a property to the trait ForeignOwnable,
which specifies the alignment of the pointers returned by
`into_foreign`.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 rust/kernel/sync/arc.rs | 2 ++
 rust/kernel/types.rs    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 77cdbcf7bd2e..df2230f0f19b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -276,6 +276,8 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
 }
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<ArcInner<T>>();
+
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..5833cf04bd4c 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -20,6 +20,9 @@
 /// This trait is meant to be used in cases when Rust objects are stored in C objects and
 /// eventually "freed" back to Rust.
 pub trait ForeignOwnable: Sized {
+    /// The alignment of pointers returned by `into_foreign`.
+    const FOREIGN_ALIGN: usize;
+
     /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
     /// [`ForeignOwnable::from_foreign`].
     type Borrowed<'a>;
@@ -49,6 +52,8 @@ pub trait ForeignOwnable: Sized {
 }
 
 impl<T: 'static> ForeignOwnable for Box<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+
     type Borrowed<'a> = &'a T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
@@ -71,6 +76,8 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
 }
 
 impl ForeignOwnable for () {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<()>();
+
     type Borrowed<'a> = ();
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-- 
2.43.0


