Return-Path: <linux-fsdevel+bounces-27538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7959624A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929441C24387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CA16B735;
	Wed, 28 Aug 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="HVmx42q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72B158DCD;
	Wed, 28 Aug 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840418; cv=none; b=lQ+I5FIWSNJfQEcM5nWKCfSKxAIAY/AusZsdS8WN2LsalCtXk7z20+Gx5Di6KVuUoOTIvy9jPnv8UHhcDL1Qck/rQEhkyqqmjFd4cn8/tKEudiSDPB4sDZCirI3hHxFD8Nzv67hGNhDa5+WzDXtDLT1M7i/KchlFsPeXMgd4J4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840418; c=relaxed/simple;
	bh=59C1j5eCmqZob8jEIShtx6eoNd5luED/6NCiA7rxG+U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ulnHC68ayMrgB9HkuMxhK8+HVkLErV7CstwDLA1KA0wHMPCEYPB0+q3pdBIenvWXJV5wwqAAMSxaRvK/g0++CTqKeS/V6GUA8FWWQW+XVQH9ILtF9bPM7yyZgEkaeJBoRUM0Dd+9HKqpWx5MRs6DnVJca0ElXW7I5beiHGTI+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=HVmx42q7; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wv0ln3Jsfz9sm9;
	Wed, 28 Aug 2024 12:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1724840405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAXYyraN7ZXI7ooTWwWvHdZefjdmGcmzLAz3G34pbEg=;
	b=HVmx42q7LKdSUqNjcYJckrDgSJg/vx4YHLXt/MyMJDnWK1lrauhvMKWsTVwfHIirTFsZ+G
	oYALAAWMGq+0EINNslOHWu9jFLK+xq5iwNyp7mzDrI3xF8tqP/rK6dmabAk4FzGm+ZLqTQ
	t/rEnlKpBBCg5LSg7S9+GUPDZC4Lhj3tvFjVm8QOzRkFtl4nVi9P2D80qBBTbaaHIOm9Xh
	s+rAEEcUevtnEk6jl/F1HPGfRArblLbjl8Ho5QB4FxY9DtQ/JaaBw8U99yk5U7/9E1otqR
	SFYS6urnNvWaIYcBTZPElQJ2jFk6rtZiamOXcRzcYNIkrzP8P23uH6FyEx2uhg==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH RESEND v3 0/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Date: Wed, 28 Aug 2024 20:19:41 +1000
Message-Id: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL35zmYC/3XNsU7DMBAG4FepPHPIZ+dK3KlDuzLQETHEzpl4a
 BzZadSqyrvXhAEQyvjf/ffdXWROgbPYbe4i8RRyiH0J+mkjXNf0nwyhLVkoqSpJSMDXIabRZ7h
 sKzjHSz+WBhi2lhzVlrQT5XZI7MN1cd/F2/F0fD2IjzLvQh5jui3vJly237KSK/KEgOCJfGsUk
 q15725D16RnF88LOanfjF5j1BdjvCHj8YUt/mP0D1NLXGM0SLBM7VbVGquq+cPM8/wA7MPBIVE
 BAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=59C1j5eCmqZob8jEIShtx6eoNd5luED/6NCiA7rxG+U=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSd+3l8x1UdNqsKTZbNB3u0nFKzLPpXRGT+uHr4aOp35
 dVxKlFPOkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBE3MUYGTYveS5THVbU//Ll
 T/m17IKKMwO57rBe05Gx39TwwsQxJY/hn6LHwbNVES7HFrfuCm47db1F9Vb0P/6XcxWPR74wfel
 yjAEA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Now that we provide a unique 64-bit mount ID interface in statx(2), we
can now provide a race-free way for name_to_handle_at(2) to provide a
file handle and corresponding mount without needing to worry about
racing with /proc/mountinfo parsing or having to open a file just to do
statx(2).

While this is not necessary if you are using AT_EMPTY_PATH and don't
care about an extra statx(2) call, users that pass full paths into
name_to_handle_at(2) need to know which mount the file handle comes from
(to make sure they don't try to open_by_handle_at a file handle from a
different filesystem) and switching to AT_EMPTY_PATH would require
allocating a file for every name_to_handle_at(2) call, turning

  err = name_to_handle_at(-EBADF, "/foo/bar/baz", &handle, &mntid,
                          AT_HANDLE_MNT_ID_UNIQUE);

into

  int fd = openat(-EBADF, "/foo/bar/baz", O_PATH | O_CLOEXEC);
  err1 = name_to_handle_at(fd, "", &handle, &unused_mntid, AT_EMPTY_PATH);
  err2 = statx(fd, "", AT_EMPTY_PATH, STATX_MNT_ID_UNIQUE, &statxbuf);
  mntid = statxbuf.stx_mnt_id;
  close(fd);

Also, this series adds a patch to clarify how AT_* flag allocation
should work going forwards.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Resend:
- v3: <https://lore.kernel.org/r/20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
Changes in v3:
- Added a patch describing how AT_* flags should be allocated in the
  future, based on Amir's suggestions.
- Included AT_* aliases for RENAME_* flags to further indicate that
  renameat2(2) is an *at(2) syscall and to indicate that those flags
  have been allocated already in the per-syscall range.
- Switched AT_HANDLE_MNT_ID_UNIQUE to use 0x01 (to reuse
  (AT_)RENAME_NOREPLACE).
- v2: <https://lore.kernel.org/r/20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
Changes in v2:
- Fixed a few minor compiler warnings and a buggy copy_to_user() check.
- Rename AT_HANDLE_UNIQUE_MOUNT_ID -> AT_HANDLE_MNT_ID_UNIQUE to match statx.
- Switched to using an AT_* bit from 0xFF and defining that range as
  being "per-syscall" for future usage.
- Sync tools/ copy of <linux/fcntl.h> to include changes.
- v1: <https://lore.kernel.org/r/20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>

---
Aleksa Sarai (2):
      uapi: explain how per-syscall AT_* flags should be allocated
      fhandle: expose u64 mount id to name_to_handle_at(2)

 fs/fhandle.c                                       | 29 ++++++--
 include/linux/syscalls.h                           |  2 +-
 include/uapi/linux/fcntl.h                         | 81 ++++++++++++++-------
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 84 +++++++++++++++-------
 4 files changed, 140 insertions(+), 56 deletions(-)
---
base-commit: 766508e7e2c5075eb744cb29b8cef6fa835b0344
change-id: 20240515-exportfs-u64-mount-id-9ebb5c58b53c

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


