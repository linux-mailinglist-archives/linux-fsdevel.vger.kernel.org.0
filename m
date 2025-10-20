Return-Path: <linux-fsdevel+bounces-64781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A26EBBF3E54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 266FF4EEE9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BA2F360A;
	Mon, 20 Oct 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj2R57ZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3102E0417;
	Mon, 20 Oct 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999271; cv=none; b=EKK3JdsYHzExQD9QTlwkZeFMdtUtS5t4UaE3HpXomzRataip/NTigukV5zasD/0DKv7ZvrJq6Ze1w/59AHnI+HtY6jVBcXT8bNN5JF41KXVyCPmjmjRZtWnnjCzy3TykKfrJM5xucHRfCCo8HrQuf+DPzRtvE89RVU+gfG3etxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999271; c=relaxed/simple;
	bh=/uHVdlzul1bTFFzVETy8ha9fQzrUajmzag8UgtqAoeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft415UpaR/a5GFS8EAM3G6X8vM6VdcsW0dRvNfIKgqeW3qjIHHHbs+sLJDxY5O4aexjrJaWBoPu60ZoFp7lVse0wXpeQbqT/HBpZgyuJnQBDXrMZaOgY9N2SacakIP580wssR6ay2s3uZC0Xd4mLDAa9O8I4kP7u+fqTZWh9yAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kj2R57ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB1EC4CEFB;
	Mon, 20 Oct 2025 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999268;
	bh=/uHVdlzul1bTFFzVETy8ha9fQzrUajmzag8UgtqAoeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kj2R57ZLCpoX9fV5YnC3iNYoNKWjF2EFCisRF5szXkvdysfreznp9I4l6YaoJTt/B
	 sVWSLgwE746n9+P/n4pTECbPobqZJl6N6I27g/THyGqk8Ga/xTZ+c70hLUIJaBMfQ2
	 u1OlpWWECZQxBEd8uZKZklgEZ5cU8e3eM34wvI91GfJgBxji7/Gxs1RpIZ/tgyysWx
	 5HwVG4p/5PDEI4ImSt8rzn3pv6tdBe/NOmt+LgEyILFzhKDae/Gqp++R0wK10EUiUK
	 GBrE4mWbIxX75jyReTLFrZidpNph0B9mKeptuoopWvB+CUuMg0HveCY+KQnsaAMVZc
	 Y32V5sAIVh4BA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/8] rust: fs: add file::Offset type alias
Date: Tue, 21 Oct 2025 00:26:13 +0200
Message-ID: <20251020222722.240473-2-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222722.240473-1-dakr@kernel.org>
References: <20251020222722.240473-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
avoid using raw bindings types, this seems to be the better alternative
compared to just using i64.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Al, Christian: If you are okay with the patch, kindly provide an ACK, so I can
take it through the driver-core tree.
---
 rust/kernel/fs/file.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index cf06e73a6da0..021a6800b46c 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -17,6 +17,11 @@
 };
 use core::ptr;
 
+/// Primitive type representing the offset within a [`File`].
+///
+/// Type alias for `bindings::loff_t`.
+pub type Offset = bindings::loff_t;
+
 /// Flags associated with a [`File`].
 pub mod flags {
     /// File is opened in append mode.
-- 
2.51.0


