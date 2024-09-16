Return-Path: <linux-fsdevel+bounces-29507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A997A3C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637E81F24C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C0D15C12F;
	Mon, 16 Sep 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="l6a/8fFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C86156F3B;
	Mon, 16 Sep 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495498; cv=none; b=dAt2Qslvkc6ZJ7260c+86DUUB76UzErJm+bA6ho8VXLhAiyvbf+kv/o/i7o/OV1BPV6LLuk6tq+jm5Crfo+8FEHfPVdZASZRmwf0FnEVhlS3/4c9QW5/TlHLCaT0grCzm7d+7/2X1ptRrZShPLf/gek0rNEvjEYKDBmEciuH2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495498; c=relaxed/simple;
	bh=nQBeSGvWGge9BXDTZBsvwTapZiJYXMVkJWK7V8DFNy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJFnv82A0Rh6cKMnRn6AAXwktPHloBtNK8teMkT++xJW8Yfj+u52EGV4o2D39HXzo9Pq9u+a77b6prMAWAZrgKnnw1BhYIT7oTl+7QVJfeeZKJbHE+ENLHGcZRgRJ8kZLJdI7c07F5djC7GwWbTpBpMrjYbW4YlIN7BasyegWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=l6a/8fFj; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E19169799;
	Mon, 16 Sep 2024 09:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494958; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	b=l6a/8fFj2/PvQcWCumcQLWs2m5I0tlDX/65VILGQQKYi8aivsrOhhRmPbEhIWSwy4G5tc9
	FEy3khtCymynox7uYG5voXxoUprQ9XT7tjzBt19wsycB0oPtWGnommd0NpOIqgsrr9fQoH
	tgkj/JxaFTA7xoargGoa9vT5Yr7VVzi0VTpax2W1Se5vP17Rba41skQfXkMf2NL/YLRyQD
	hN4CfgqgiZt2NhT1PgsnAoocTELhDXiaNxresJdBEgPUrhA0qLA7Yx3afrCms3k/Kq+MKy
	965KUhba0fwMQUtEDzLWnhPxLAJIZ8cKGAO5lUOKx4Sk8ogSg5CXjXB8iLMdeQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 00/24] erofs: introduce Rust implementation
Date: Mon, 16 Sep 2024 21:55:17 +0800
Message-ID: <20240916135541.98096-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Greetings,

So here is a patchset to add Rust skeleton codes to the current EROFS
implementation. The implementation is deeply inspired by the current C 
implementation, and it's based on a generic erofs_sys crate[1] written
by me. The purpose is to potentially replace some of C codes to make
to make full use of Rust's safety features and better
optimization guarantees.

Many of the features (like compression inodes) still
fall back to C implementation because of my limited time and lack of
Rust counterparts. However, the Extended Attributes work purely in Rust.

Some changes are done to the original C code.
1) Some of superblock operations are modified slightly to make sure
memory allocation and deallocation are done correctly when interacting
with Rust.
2) A new rust_helpers.c file is introduced to help Rust to deal with
self-included EROFS API without exporting types that are not
interpreted in Rust.
3) A new rust_bindings.h is introduced to provide Rust functions
externs with the same function signature as Rust side so that
C-side code can use the bindings easily.
4) CONFIG_EROFS_FS_RUST is added in dir.c, inode.c, super.c, data.c,
and xattr.c to allow C code to be opt out and uses Rust implementation.
5) Some macros and function signatures are tweaked in internal.h
with the compilation options.

Note that, since currently there is no mature Rust VFS implementation
landed upstream, this patchset only uses C bindings internally and
each unsafe operation is examined. This implementation only offers
C-ABI-compatible functions impls and gets its exposed to original C
implementation as either hooks or function pointers.

Also note that, this patchset only uses already-present self-included
EROFS API and it uses as few C bindings generated from bindgen as
possible, only inode, dentry, file and dir_context related are used,
to be precise.

Since the EROFS community is pretty interested in giving Rust a try,
I think this patchset will be a good start for Rust EROFS.

This patchset is based on the latest EROFS development tree.
And the current codebase can also be found on my github repo[2].

[1]: https://github.com/ToolmanP/erofs-rs
[2]: https://github.com/ToolmanP/erofs-rs-linux

Yiyang Wu (24):
  erofs: lift up erofs_fill_inode to global
  erofs: add superblock data structure in Rust
  erofs: add Errno in Rust
  erofs: add xattrs data structure in Rust
  erofs: add inode data structure in Rust
  erofs: add alloc_helper in Rust
  erofs: add data abstraction in Rust
  erofs: add device data structure in Rust
  erofs: add continuous iterators in Rust
  erofs: add device_infos implementation in Rust
  erofs: add map data structure in Rust
  erofs: add directory entry data structure in Rust
  erofs: add runtime filesystem and inode in Rust
  erofs: add block mapping capability in Rust
  erofs: add iter methods in filesystem in Rust
  erofs: implement dir and inode operations in Rust
  erofs: introduce Rust SBI to C
  erofs: introduce iget alternative to C
  erofs: introduce namei alternative to C
  erofs: introduce readdir alternative to C
  erofs: introduce erofs_map_blocks alternative to C
  erofs: add skippable iters in Rust
  erofs: implement xattrs operations in Rust
  erofs: introduce xattrs replacement to C

 fs/erofs/Kconfig                              |  10 +
 fs/erofs/Makefile                             |   4 +
 fs/erofs/data.c                               |   5 +
 fs/erofs/data_rs.rs                           |  63 +++
 fs/erofs/dir.c                                |   2 +
 fs/erofs/dir_rs.rs                            |  57 ++
 fs/erofs/inode.c                              |  10 +-
 fs/erofs/inode_rs.rs                          |  64 +++
 fs/erofs/internal.h                           |  47 ++
 fs/erofs/namei.c                              |   2 +
 fs/erofs/namei_rs.rs                          |  56 ++
 fs/erofs/rust/erofs_sys.rs                    |  47 ++
 fs/erofs/rust/erofs_sys/alloc_helper.rs       |  35 ++
 fs/erofs/rust/erofs_sys/data.rs               |  70 +++
 fs/erofs/rust/erofs_sys/data/backends.rs      |   4 +
 .../erofs_sys/data/backends/uncompressed.rs   |  39 ++
 fs/erofs/rust/erofs_sys/data/raw_iters.rs     | 127 +++++
 .../rust/erofs_sys/data/raw_iters/ref_iter.rs | 131 +++++
 .../rust/erofs_sys/data/raw_iters/traits.rs   |  17 +
 fs/erofs/rust/erofs_sys/devices.rs            |  75 +++
 fs/erofs/rust/erofs_sys/dir.rs                |  98 ++++
 fs/erofs/rust/erofs_sys/errnos.rs             | 191 +++++++
 fs/erofs/rust/erofs_sys/inode.rs              | 398 ++++++++++++++
 fs/erofs/rust/erofs_sys/map.rs                |  99 ++++
 fs/erofs/rust/erofs_sys/operations.rs         |  62 +++
 fs/erofs/rust/erofs_sys/superblock.rs         | 514 ++++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs     |  94 ++++
 fs/erofs/rust/erofs_sys/xattrs.rs             | 272 +++++++++
 fs/erofs/rust/kinode.rs                       |  76 +++
 fs/erofs/rust/ksources.rs                     |  66 +++
 fs/erofs/rust/ksuperblock.rs                  |  30 +
 fs/erofs/rust/mod.rs                          |   7 +
 fs/erofs/rust_bindings.h                      |  39 ++
 fs/erofs/rust_helpers.c                       |  86 +++
 fs/erofs/rust_helpers.h                       |  23 +
 fs/erofs/super.c                              |  51 +-
 fs/erofs/super_rs.rs                          |  59 ++
 fs/erofs/xattr.c                              |  31 +-
 fs/erofs/xattr.h                              |   7 +
 fs/erofs/xattr_rs.rs                          | 106 ++++
 40 files changed, 3153 insertions(+), 21 deletions(-)
 create mode 100644 fs/erofs/data_rs.rs
 create mode 100644 fs/erofs/dir_rs.rs
 create mode 100644 fs/erofs/inode_rs.rs
 create mode 100644 fs/erofs/namei_rs.rs
 create mode 100644 fs/erofs/rust/erofs_sys.rs
 create mode 100644 fs/erofs/rust/erofs_sys/alloc_helper.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
 create mode 100644 fs/erofs/rust/erofs_sys/devices.rs
 create mode 100644 fs/erofs/rust/erofs_sys/dir.rs
 create mode 100644 fs/erofs/rust/erofs_sys/errnos.rs
 create mode 100644 fs/erofs/rust/erofs_sys/inode.rs
 create mode 100644 fs/erofs/rust/erofs_sys/map.rs
 create mode 100644 fs/erofs/rust/erofs_sys/operations.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/mem.rs
 create mode 100644 fs/erofs/rust/erofs_sys/xattrs.rs
 create mode 100644 fs/erofs/rust/kinode.rs
 create mode 100644 fs/erofs/rust/ksources.rs
 create mode 100644 fs/erofs/rust/ksuperblock.rs
 create mode 100644 fs/erofs/rust/mod.rs
 create mode 100644 fs/erofs/rust_bindings.h
 create mode 100644 fs/erofs/rust_helpers.c
 create mode 100644 fs/erofs/rust_helpers.h
 create mode 100644 fs/erofs/super_rs.rs
 create mode 100644 fs/erofs/xattr_rs.rs

-- 
2.46.0


