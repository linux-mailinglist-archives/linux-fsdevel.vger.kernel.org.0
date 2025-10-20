Return-Path: <linux-fsdevel+bounces-64780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94144BF3E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3DFF3505BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893802F260A;
	Mon, 20 Oct 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/dMo5kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E713A3F7;
	Mon, 20 Oct 2025 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999265; cv=none; b=JpIq6CVYRcH3FyLO4aUeB7fIjJVE0XVZAiWDcP1yF3dcjVhywNTMR7nGxHRXCBWTpf4NMEENyVno1VXCEW85sNLa5qrODCIbegDE4Z2mq+X+LjdPCG+OWPDEJfyDHJIUi7nvgKlqSs6rZBrmYBqQrAkajR5c6gFz4f6Gu/gDjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999265; c=relaxed/simple;
	bh=1bFiqy/nwHmTPKhXtsHzab5hLO5D0v2lwrDJ+91V/JM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSyCbBiw6i/JUOBMpToCMD86CuvhdqMf++5ZnVkgXDO8NSoUTD7B88EnTpswO1jkgKGgaGWdg3nz9WbnfBhOCzrUWh57fO/JL3J5ajjfm3pHqYYtV4qf7lubbvV/FXftPxxfNtOyf02fdkBw41r54GaEa7SzrASONsLN2UTqU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/dMo5kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3656EC113D0;
	Mon, 20 Oct 2025 22:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999264;
	bh=1bFiqy/nwHmTPKhXtsHzab5hLO5D0v2lwrDJ+91V/JM=;
	h=From:To:Cc:Subject:Date:From;
	b=U/dMo5klXVVjOKQP9iqrPpy4K6ciNJ2l8Z7C0VQjgA40dfkAYZZs1RqY3iZ9UT3Wt
	 KKbIJetFlNhVUzKOCrFwNW6PyaCqheaHVuFAQvZqWUDOz61HqgZIwjBg4TzbzQ3uNt
	 VNI3LiSW2qg564rAGFiWIjeuDchnoQo9IZ7upBOdO2J81cEj9yp9Rp3GOSfa/+mSjk
	 JaHudqYHusX9AoX7GMvn5/N5dSnXEUkB4HPmwRH/vEOXwywMI5fTjSib2mt1t43Pj2
	 l9npjje80J0PpsW8wOMHx5+lbhiOZblP4ws+xkGy6XenNSeHGa5InfCfGGOqtJAjkq
	 7qFdGw2rlBzgA==
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/8] Binary Large Objects for Rust DebugFS
Date: Tue, 21 Oct 2025 00:26:12 +0200
Message-ID: <20251020222722.240473-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for exposing binary large objects via Rust debugfs.

The first two patches extend UserSliceReader and UserSliceWriter with partial
read/write helpers.

The series further introduces read_binary_file(), write_binary_file() and
read_write_binary_file() methods for the Dir and ScopedDir types.

It also introduces the BinaryWriter and BinaryReader traits, which are used to
read/write the implementing type's binary representation with the help of the
backing file operations from/to debugfs.

Additional to some more generic blanked implementations for the BinaryWriter and
BinaryReader traits it also provides implementations for common smart pointer
types.

Both samples (file-based and scoped) are updated with corresponding examples.

A branch containing the patches can be found in [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=debugfs_blobs

Changes in v2:
  - Add file::Offset type alias.
  - uaccess:
    - Saturate at buffer length on offset overflow.
    - Use file::Offset instead of usize.
  - debugfs:
    - Use file::Offset instead of usize.
    - Handle potential overflow when updating ppos.
    - Use &T::FILE_OPS directly if possible.
    - Fix safety comment in BinaryReaderMut::read_from_slice_mut().

Danilo Krummrich (8):
  rust: fs: add file::Offset type alias
  rust: uaccess: add UserSliceReader::read_slice_partial()
  rust: uaccess: add UserSliceWriter::write_slice_partial()
  rust: debugfs: support for binary large objects
  rust: debugfs: support blobs from smart pointers
  samples: rust: debugfs: add example for blobs
  rust: debugfs: support binary large objects for ScopedDir
  samples: rust: debugfs_scoped: add example for blobs

 rust/kernel/debugfs.rs              | 110 +++++++++++++++-
 rust/kernel/debugfs/file_ops.rs     | 145 ++++++++++++++++++++-
 rust/kernel/debugfs/traits.rs       | 190 +++++++++++++++++++++++++++-
 rust/kernel/fs/file.rs              |   5 +
 rust/kernel/uaccess.rs              |  49 +++++++
 samples/rust/rust_debugfs.rs        |  13 ++
 samples/rust/rust_debugfs_scoped.rs |  14 +-
 7 files changed, 515 insertions(+), 11 deletions(-)


base-commit: 340ccc973544a6e7e331729bc4944603085cafab
-- 
2.51.0


