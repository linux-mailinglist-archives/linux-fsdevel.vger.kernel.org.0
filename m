Return-Path: <linux-fsdevel+bounces-78254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM5JAE2LnWn5QQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:28:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5335218644C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A727B3291288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5937F739;
	Tue, 24 Feb 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnD6iV9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95E2D6E6F;
	Tue, 24 Feb 2026 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932043; cv=none; b=Ct1P7UQa6ZPqeRNb0r6QYxcS4MWU2f9RodNsE/+Ku9+YIWM0vNuRcZb21BrLVwmgsiR+8DjUUAtnQ9xK3Le6q0C6y5AqdShfZscxFURMGXU4t2rS6Kj+AqTNT3A0nH75AH2PdIJ7zXGml0mxNfJyWNjRwTK+Xwwxtk7KUE1Ocd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932043; c=relaxed/simple;
	bh=jLcwJmCU6NuD58W2dvDRqr7xKpNKXDGKLW9pDqZ3mBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COfBpdq5jhItWAO4F7BjY6RXEVp4L7Vs+AZnCEs4gA3PlKMgl+cllL2ZFwWicMGnj7oURi2DvI3aTunEE5D4hW5HTbd5WJPAUYGFDqBIGQYTrhg67HCtpYNJZo0/WtlRiKGFMBEG2TynKbj+v0es2tcKGhvQjLVwLCRoe2marg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnD6iV9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8595C2BC86;
	Tue, 24 Feb 2026 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771932043;
	bh=jLcwJmCU6NuD58W2dvDRqr7xKpNKXDGKLW9pDqZ3mBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FnD6iV9K9NZ7mJJSAL00XOjIPTg6UsieDGlm3jaXgSc4Rc9rMU8mCbbe0Ub0QU04s
	 j+XA7mBrzuVEuqRfQI92KsNlua/cpKJgCXIE8vr6AZo0jhnoNhVLUoWlWaAfplH4CX
	 T5sAiTOh3WoLzwRvaEg5Hlr+AzFOgVnxNtBg8DyOwJeF38TDShZKCUIt4HUXRybDpW
	 R/l7zwbU3DLkv6fDnzGUcBYSBRH3Eu5wt2beNLcG/kisJ4dWaJfnvuLRpJeRdFTgfv
	 ylStit7gCo0yNJCiejtjQZi34htmpdrmCKcOiapJ3ywb88WPPGD50uHtZIJnTb+Acb
	 HTH87pF60sZqQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 24 Feb 2026 12:17:56 +0100
Subject: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=jLcwJmCU6NuD58W2dvDRqr7xKpNKXDGKLW9pDqZ3mBg=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYj0TV4DAv2lVFJSr3recsWpK7mpdMvf0fOO4
 GsqOYqcl7SJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I9AAKCRDhuBo+eShj
 dxXvD/4uTFSqjCY3iWHRTIEAh2NylxI+XqsaQVjNHfa55ZJJLgTNfYUvcse4RyQozv7pvyVWd9X
 RTV+xLwmBnbBtZhV/uwmF8F2kvjU113KJpO3sMatO2yNc358Ve7JZhap3nzmvf689b+moR9KW8U
 8ifp9shwqd9GxSnUqYmJQww4ytW7n6vmrS9fdCG0VpncaoHbclEqKrb8kHlDpPWubp6c+Qu+ywV
 ZSm0AOEF5voLr6yFpDRkglqwU7L54LiXgfITkIb6UbNJrDRXOO57QGjUnybgV9oIPGKKkwQwRZQ
 uZX42y2zKXJNwE7e0PtSQh/G9iJSeO6OlIl3XlsH9/nwxhmAe99bikE2XWCyvXsybp6xdn8BHKc
 r54RW+VeOtJ8HA3/xoWs07B2k0WCCDEs5APzVEAOAAzVtB0PabBsu+U6ama860OueMRxHOILlcZ
 +Xf+pOsN30kSX9dsaxnpoC6hcm2hPWPJL/HaytSlHURknmIo6ZknstZlgrOJ6sPfuOgZPJ9KatI
 nzNP0Z3U5LkY0BatvObNNaHXd8Ke66SruMP3igQJaaJm0DeDpUNWuOdkv9+3giycXGQXpdPIHCt
 lQVZzP3lDsyullj2okwbZRVi01SEBePzKduMTuRLyTs6JjpW7tCsxzzCAC0M5H7le096T5lOwCQ
 cYxZVgcHcuck6nQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78254-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5335218644C
X-Rspamd-Action: no action

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 622b3529edfcb..e6efdd572aeea 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -213,6 +213,14 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
         // which points to an initialized instance of `T`.
         unsafe { &mut *Box::into_raw(b) }
     }
+
+    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
+    ///
+    /// Like [`Self::into_raw`], but returns a `NonNull`.
+    pub fn into_nonnull(b: Self) -> NonNull<T> {
+        // SAFETY: `KBox::into_raw` returns a valid pointer.
+        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
+    }
 }
 
 impl<T, A> Box<MaybeUninit<T>, A>

-- 
2.51.2



