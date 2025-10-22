Return-Path: <linux-fsdevel+bounces-65111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73053BFC8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 616D44E3741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AD35BDDE;
	Wed, 22 Oct 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQh14o3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6393C35BDA4;
	Wed, 22 Oct 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143530; cv=none; b=F5pzU+FEdskky+LPhJTYzJm7H8qdXa04A7r4NfbRZe5IVjXceGWfG5qoPolYlUBRpl4HQ/k8TDGwIR+yM9/NABNB4HrtbI3iTsmyls49SfPDKqtUHoBQJYnxyyjZA+A5mxP3w3k6N5Gm1/lBuaUX/xqY3XLLv6OHAt5emnqip4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143530; c=relaxed/simple;
	bh=x9G0mG7ea3UehmY1Y0onyHrWYHOdLLGXSTM3zHg/+9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeHDg8SKfUmZg7giQyErhcwfLnZbThfAmWxJAZXhGNoPCngJHqhNlj6vEqAMqWjCIwm08Fqzi1mlPL1k8D13Vk6ZF3qq+UnU71n9CcceCLxup8+SoEE7ou5YXQN5HfFFbjVV9ljdwTh/fdst3gUCXz+CTD9DpHPqGMYtCd9fhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQh14o3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D68CC113D0;
	Wed, 22 Oct 2025 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143529;
	bh=x9G0mG7ea3UehmY1Y0onyHrWYHOdLLGXSTM3zHg/+9w=;
	h=From:To:Cc:Subject:Date:From;
	b=tQh14o3YKZXLlqdH0gPijjjLy6gQsBPbmcF/YN/DFHyx9Eha1LuTP4/HaA7SbemiH
	 DHRhNmqC/1Ltz4fFPrzn2kpwpOaBKllEmrKPetlhk23tO2g+6CqL4YGKe0fNqwRkTR
	 BBZ8F8JNhiQxCqC574aWbbG4VbMOqBT0rDEdY2qXnW4XVdtlsV70KkGPX/MQZPu4lW
	 VvBpwMIvMOuABehba2p45efgKs8z20UBXp+ycv36xfe1nzrUipXWtj/4TQqdvppBon
	 i8yJBU7ixb9FKqQf6baoJi0+M6P32hsJVYWTVs/Ui/Kv3XlvI/N1q3hGujBQf+VbBD
	 9YRFLjybgYjqA==
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
Subject: [PATCH v3 00/10] Binary Large Objects for Rust DebugFS
Date: Wed, 22 Oct 2025 16:30:34 +0200
Message-ID: <20251022143158.64475-1-dakr@kernel.org>
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

Changes in v3:
  - Add UserSliceReader::read_slice_file() and
    UserSliceWriter::write_slice_file() taking an &mut file::Offset to
    adjust it internally and make use of them.
  - Add a new type file::Offset, rather than a type alias.
  - Move affected delegate comments to previous patch.
  - Add a brief comment for BinaryReadFile, BinaryWriteFile and
    BinaryReadWriteFile.

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

Danilo Krummrich (10):
  rust: fs: add new type file::Offset
  rust: uaccess: add UserSliceReader::read_slice_partial()
  rust: uaccess: add UserSliceReader::read_slice_file()
  rust: uaccess: add UserSliceWriter::write_slice_partial()
  rust: uaccess: add UserSliceWriter::write_slice_file()
  rust: debugfs: support for binary large objects
  rust: debugfs: support blobs from smart pointers
  samples: rust: debugfs: add example for blobs
  rust: debugfs: support binary large objects for ScopedDir
  samples: rust: debugfs_scoped: add example for blobs

 rust/kernel/debugfs.rs              | 110 ++++++++++++-
 rust/kernel/debugfs/file_ops.rs     | 146 ++++++++++++++++-
 rust/kernel/debugfs/traits.rs       | 238 +++++++++++++++++++++++++++-
 rust/kernel/fs/file.rs              | 142 ++++++++++++++++-
 rust/kernel/uaccess.rs              |  81 ++++++++++
 samples/rust/rust_debugfs.rs        |  13 ++
 samples/rust/rust_debugfs_scoped.rs |  14 +-
 7 files changed, 732 insertions(+), 12 deletions(-)


base-commit: e6901808a3b28d8bdabfa98a618b2eab6f8798e8
-- 
2.51.0


