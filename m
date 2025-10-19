Return-Path: <linux-fsdevel+bounces-64631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E21BEEDA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B75F4E8B04
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918E0239085;
	Sun, 19 Oct 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcBgCSzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCF1E25E3;
	Sun, 19 Oct 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909482; cv=none; b=BsPNEhxzX0DkfRjLa0v8PIOgjR30oAMWIXdHCrmrUiX/62uFJzrWPnn5qVi/WghfkI4nadyJ1pLTbOXW5LlmUK9Vm2hIMo7Kga/RtzqXfxhZ928gQgXhBO/270+Z0w/FedTAmc95rZLiW8mz4WeJOuwFr7Mu5TvJ03gLYpQz10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909482; c=relaxed/simple;
	bh=sApG3ZbJWTksJqIVkodaBxHNS4Hr0anMh4n685JAKh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A587zlBMqhjdJ5maAPOoGm4n53v/QP5aef7qHkL4g+ezYTMUBataeFOIik38jxs3CirawcNueCQzuIZJbTL6ba9zmShGu3N1oxPDhnl950a7QXCmKgX68kkERlXP6gJirExPNowi1h5FSwKMX7gfyX1+XaWwUDT2zNKNTnCg4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcBgCSzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC02AC4CEE7;
	Sun, 19 Oct 2025 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760909481;
	bh=sApG3ZbJWTksJqIVkodaBxHNS4Hr0anMh4n685JAKh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcBgCSzHByUTg0KSFE2YM1558TixTmxwF02MD0Ww3VADciu/Lgk9WrbXSXsGsOcaC
	 v6kMEo34mZA0JLdIPDM43OncXFjvRLZLRwVW7vZr7fMYiZgAndiThkdqHZg5bAjnpC
	 94jwtQi5u8uivbJ/4fvAOYbSXhEt/PxHcW8V6BdzK0MWoXpKbXOunAy3ffRXj7R1M6
	 dnsL/PYJUOmW7BfALr3gW9l/dimBr5iaveWEIDvnxLR0wsLf1XI3GeetXX1sqjLHb6
	 Bv5r/a7HIE0buC/WueXJh7mVyIA3XNlCEAZ9ktEMuAVTaUiKBm2F727HQEcgVsHa4Z
	 TYLOgNQsBVxGA==
From: Miguel Ojeda <ojeda@kernel.org>
To: tamird@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Liam.Howlett@oracle.com,
	a.hindborg@kernel.org,
	airlied@gmail.com,
	aliceryhl@google.com,
	arve@android.com,
	axboe@kernel.dk,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	broonie@kernel.org,
	cmllamas@google.com,
	dri-devel@lists.freedesktop.org,
	gary@garyguo.net,
	jack@suse.cz,
	joelagnelf@nvidia.com,
	justinstitt@google.com,
	kwilczynski@kernel.org,
	leitao@debian.org,
	lgirdwood@gmail.com,
	linux-block@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	llvm@lists.linux.dev,
	longman@redhat.com,
	lorenzo.stoakes@oracle.com,
	lossin@kernel.org,
	maco@android.com,
	mcgrof@kernel.org,
	mingo@redhat.com,
	mmaurer@google.com,
	morbo@google.com,
	mturquette@baylibre.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nm@ti.com,
	peterz@infradead.org,
	russ.weight@linux.dev,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	simona@ffwll.ch,
	surenb@google.com,
	tamird@gmail.com,
	tkjos@android.com,
	tmgross@umich.edu,
	urezki@gmail.com,
	vbabka@suse.cz,
	vireshk@kernel.org,
	viro@zeniv.linux.org.uk,
	will@kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] samples: rust: debugfs: use `core::ffi::CStr` method names
Date: Sun, 19 Oct 2025 23:30:49 +0200
Message-ID: <20251019213049.2060970-1-ojeda@kernel.org>
In-Reply-To: <20251018-cstr-core-v18-7-9378a54385f8@gmail.com>
References: <20251018-cstr-core-v18-7-9378a54385f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoiding methods that only exist on the latter.

This backslid in commit d4a5d397c7fb ("samples: rust: Add scoped debugfs
sample driver").

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 samples/rust/rust_debugfs_scoped.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/rust/rust_debugfs_scoped.rs b/samples/rust/rust_debugfs_scoped.rs
index b0c4e76b123e..eb870e9986b8 100644
--- a/samples/rust/rust_debugfs_scoped.rs
+++ b/samples/rust/rust_debugfs_scoped.rs
@@ -38,7 +38,7 @@ fn remove_file_write(
     mod_data
         .devices
         .lock()
-        .retain(|device| device.name.as_bytes() != to_remove.as_bytes());
+        .retain(|device| device.name.to_bytes() != to_remove.to_bytes());
     Ok(())
 }
 

base-commit: b214b442f2fa78aad04ebe1b5cad2c1d94120cb7
-- 
2.51.0


