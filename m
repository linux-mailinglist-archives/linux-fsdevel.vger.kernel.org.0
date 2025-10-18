Return-Path: <linux-fsdevel+bounces-64592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FABED924
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E0F3BF461
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D42EBB86;
	Sat, 18 Oct 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAF8qiyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB39258EE9;
	Sat, 18 Oct 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815011; cv=none; b=i/x4VDDAtevEUtVQ1b6TPFu/9JltPz5obga30k2g1AsSqGMMN13o22dwZwklG4R5O8oa8Ake4v6LnUkNK8khQZGzfnu4WzsCNhV6uXLGLcm+nCvgd+P8uNSdctJ7Ly7zHix6EmDYbcmcJ9UrDnh16pMa4LoNruAJK5HHR5sxSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815011; c=relaxed/simple;
	bh=xy9KhFtMrJL0pHddpVZl1kgvFuS3w9PeKpCdtFzbvlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YU+0TigW+Ltk6PaKV7yeeOIJ44sHGEX5J6nZeoDdMA47Y1DEaWwOfuPIis/KcA5k0dMZCslBPndkPl36vIHQ///XMu3kaseE/ymGIE3+YXfPAqr04ZK06hqWAxdp49PBdc8JEugTVV76qdT5N3Hsq9lBSpXxd4uXWcYFG6V+fxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAF8qiyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671B4C116D0;
	Sat, 18 Oct 2025 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815010;
	bh=xy9KhFtMrJL0pHddpVZl1kgvFuS3w9PeKpCdtFzbvlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MAF8qiyvOOp7PaCVz62rkatdSUnjmtTaDht+rVIZp2nz5f0I1J/X8j6DGXD3JhuS3
	 8AAk/nSnc4GsqBPr47HRzNSbV/BIlNHuPhf9MmU88ZXNsLQ8nBHmlm9s1cTA6Kf8uI
	 UxCy6hNAl1N7Mu2VVSXPr+xi8630AbPCNWZxlhgk/2gAtjdLdLVFoTRalGCapra/5J
	 ueb6fgodvNKonlI49tTjO/yeODdb3hiu0IDFRWnn5wgjrgkqlTYgBOLBOaaCbkkHe5
	 AADCB3HZgyuBOXnLstEgqamC+2A9z2BpqUom57Jqu2GKYzk98rap0R31ouFburJ1WS
	 RCEZ+5jvUzQVg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Sat, 18 Oct 2025 15:16:24 -0400
Subject: [RESEND PATCH v18 03/16] rust_binder: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-3-9378a54385f8@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1760814988; l=1195;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=872/2/9eITdb9tB+ajd4McXNzNIKi7XLnXFm8ifjokI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QENfku/AC1lpGBbf8FzC/fbLAnFquJtwb8rlTAkzyEbW5sDKgV8/QSES2q+QdvmRTiEG8sP7vEu
 nLaNzwzcjngo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit eafedbc7c050 ("rust_binder: add Rust Binder
driver").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/android/binder/error.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
index 9921827267d0..b24497cfa292 100644
--- a/drivers/android/binder/error.rs
+++ b/drivers/android/binder/error.rs
@@ -2,6 +2,7 @@
 
 // Copyright (C) 2025 Google LLC.
 
+use kernel::fmt;
 use kernel::prelude::*;
 
 use crate::defs::*;
@@ -76,8 +77,8 @@ fn from(_: kernel::alloc::AllocError) -> Self {
     }
 }
 
-impl core::fmt::Debug for BinderError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BinderError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.reply {
             BR_FAILED_REPLY => match self.source.as_ref() {
                 Some(source) => f

-- 
2.51.1


