Return-Path: <linux-fsdevel+bounces-24730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903894420B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0267F1F22EDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDA13E03E;
	Thu,  1 Aug 2024 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ivL4X512"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4242413958F;
	Thu,  1 Aug 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484384; cv=none; b=POihT62L3ckRNSkTgQ5bwClkZfWf9DVwTl3tA1AoUgv3y+LjSdZtLQeR2fSxYiie/TWQWjYphEGDmXvkURRfQq4Ayr1FrR1jIw1Tgch9BxZV5fOfsUTjpoeM1KKRbcz6A01FAY6eZvSUE5DO6eXUhZhigA69LgrzVzF9Vf0p9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484384; c=relaxed/simple;
	bh=SZh3XCDSFmyPqUeH2ujcUUsjOZ0MyaFTjhvx5nanywQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PW7OH/g3bV7d+QrmbI8mbwlJw/U2gCisRWDpd3Ax3r0b9kDSDbzm0HrN6Gnndxl7BUooY3Ggo2UjmxdwkUKfweRvEZpC1Fz5xOSwqi/x+O5MR+8f/ykHBBduZA+K1sAD/Ujwvv9mboAGjhK/Nzjy4LIxrejLBfJG4uilTgqdp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ivL4X512; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WZFRX6l72z9skj;
	Thu,  1 Aug 2024 05:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722484377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o8hmGv4rMCoc1oB9Naj26I2ZF5t/5CBQ9CJf/mNy8IM=;
	b=ivL4X5127HkvMXRFkM+qZ53mAZaz5PnfrZCUQkyumyNPbBI6YC4cutP4Mi+YvtXtTUyw2O
	CC2CxZfWFc8uwfqxXU5UApky4pPMpxf/Q4wV7Ved4KbOyKnY+cvTjI0ueDGNOxpiAoDei/
	jif0Mf3WWCI+0rBp4PGlpf5fjO5BiKSVxASgf8J++rx3bf5wBtmXwn3X/tZCEBnza6HWtq
	eKQX+DCyQz+coJ7cFEV03Is54gw6wn/ofRd8p11l39EMzpnaHFSFYvizVQV2cOTxlZQ++m
	qUV+rYx4VH2kVDHUart8WdjJckC+w5TruDVjAd5684fcTeMgiblNjEMzJgufeg==
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH RFC v3 0/2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Date: Thu, 01 Aug 2024 13:52:39 +1000
Message-Id: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIcGq2YC/3XNsQ6CMBAG4Fcxna2hhVPqZGLiA7gaB1qu0gFKW
 mgghHe31kUHxv/uv+8W4tEZ9OS8W4jDYLyxXQz5fkdUU3UvpKaOmfCMFxkwoDj11g3a0/FY0Na
 O3RAbVKCUoKCUkCsSb3uH2kzJfZD77UqecdgYP1g3p1+BpdWX5dkGGxhlVAPoWnAGssSLmvumc
 gdl20QG/svkWwz/MEILEJqdULI/Zl3XN49rihAHAQAA
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
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=SZh3XCDSFmyPqUeH2ujcUUsjOZ0MyaFTjhvx5nanywQ=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaStZus5xb3xoeZKsfOVITXPWrMM+JXjJyuyzDlWryjZH
 crwdJZXRykLgxgXg6yYIss2P8/QTfMXX0n+tJINZg4rE8gQBi5OAZiIRQrDP/uzYVsuG+yckpBY
 LqA4J/Yg20n7mq7syXqvCze1hr5Ve8HI8O9DvOjdHy9Xf5F6orL02/yNiTq37jimxqptmv3HYYn
 WCg4A
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
base-commit: c7b9563b58a77423d4c6e026ff831a69612b02fc
change-id: 20240515-exportfs-u64-mount-id-9ebb5c58b53c

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


