Return-Path: <linux-fsdevel+bounces-52695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9654AE5F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AC53B9F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA571259CB3;
	Tue, 24 Jun 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNMUdxc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207B257AC6;
	Tue, 24 Jun 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753771; cv=none; b=ZaabhkmqcUdBqhxypbINpb0Mj6ikASdrkBr9ffsdZ2J9pP+gDgLthnRB/LZ6YyCBn8BK5FeGrE/J7TSJDWwo412PQb1eWRDityWe3d8Y7YApnPREyHE72ZtDNreyA6NEEZLIR7sYIf+naZk/r861aHgFfzQf2CrY2b9bA0wZpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753771; c=relaxed/simple;
	bh=n0A2bZUtEji06DGJ5Fsxfovhrsm7nT4gA6pI5f51Wio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e86gXgQdJp4j/fqg/J0IxTJLO6ovPB7sffZr3884lA02edViPLDeTcFlNFt/HxaX0kZ0THy4P3Ri4cxQg6VLmXEsO2Qhxbp65MrgQ2igKWD4ElWo0j08Bf/WRfgj5JX9UEY64VmmBg3FC4ZAP7M7ts71ZeE+BGCsmMqy6aIlNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNMUdxc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E963BC4CEE3;
	Tue, 24 Jun 2025 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753770;
	bh=n0A2bZUtEji06DGJ5Fsxfovhrsm7nT4gA6pI5f51Wio=;
	h=From:Subject:Date:To:Cc:From;
	b=PNMUdxc3FI8nys29mHIRHV32bYAHkIJBjwPI/W/HGSLJi1RpbaqzlBJ+jRAXxLn8X
	 irKlfBRkSNLbbfmBJrxsJIKDSQtzRF8c2VpwvVgNxTmZxhPiT++77msIWxoJHAzTmx
	 thSpaoGzfDe+LmJYQKTTUBbUqYuB93l34+2oYtyCwGulEo4W0QZ3vQ+q4XONqXtJQq
	 8m61nrTlCAao/+FiA1+OuNx1gVBzSVzRSFRdoGbxwxMWVw1W0OPXAQgHDhrCsqH81c
	 mwCMXrS6oIG0dVuTxJz9gRhtC1kDfZ69wTtUUsiTddod/jua1GHuIEZ2hcXEUzwqA0
	 FrGY1Y/nSQgCw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/11] fhandle, pidfs: allow open_by_handle_at() purely
 based on file handle
Date: Tue, 24 Jun 2025 10:29:03 +0200
Message-Id: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM9hWmgC/22OQQ6DIBREr2JYFyMoWLrqPRoXKh8lGjCfhrYx3
 r1guuxyknlvZicB0EIgt2InCNEG610K/FKQce7dBNTqlAmvuKgkU/TlcaGb1SZQkwp6BTrI2ph
 ajI3iDUnghmDs+5Q+upSHPqQS9m6csyomVJasLU9LBmYbnh4/54nIMvbb4/W/vchoRVtxVUrLV
 ghh7gugg7X0OJHuOI4vLY6nk9YAAAA=
X-Change-ID: 20250619-work-pidfs-fhandle-b63ff35c4924
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n0A2bZUtEji06DGJ5Fsxfovhrsm7nT4gA6pI5f51Wio=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJT7/am0xT8Bze375xOWflae91gq5sc74W9Ab+QhpA
 fPNKzIedZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkRgojQ4vyCrFZ2VOjqpgL
 rsRPmRA70c64oOS/Y3iJEpd2RPQBTob/meqrMxL0QpLWWIsp51ZYFr2JTjlyfKfuzX8Xdnzq+FD
 DDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Various filesystems such as pidfs and drm support opening file handles
without having to require a file descriptor to identify the filesystem.
The filesystem are global single instances and can be trivially
identified solely on the information encoded in the file handle.

This makes it possible to not have to keep or acquire a sentinal file
descriptor just to pass it to open_by_handle_at() to identify the
filesystem. That's especially useful when such sentinel file descriptor
cannot or should not be acquired.

For pidfs this means a file handle can function as full replacement for
storing a pid in a file. Instead a file handle can be stored and
reopened purely based on the file handle.

Such autonomous file handles can be opened with or without specifying a
a file descriptor. If no proper file descriptor is used the FD_INVALID
sentinel must be passed. This allows us to define further special
negative fd sentinels in the future.

Userspace can trivially test for support by trying to open the file
handle with an invalid file descriptor.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Simplify the FILEID_PIDFS enum.
- Introduce FD_INVALID.
- Require FD_INVALID for autonomous file handles.
- Link to v1: https://lore.kernel.org/20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org

---
Christian Brauner (11):
      fhandle: raise FILEID_IS_DIR in handle_type
      fhandle: hoist copy_from_user() above get_path_from_fd()
      fhandle: rename to get_path_anchor()
      pidfs: add pidfs_root_path() helper
      fhandle: reflow get_path_anchor()
      uapi/fcntl: mark range as reserved
      uapi/fcntl: add FD_INVALID
      exportfs: add FILEID_PIDFS
      fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
      fhandle, pidfs: support open_by_handle_at() purely based on file handle
      selftests/pidfd: decode pidfd file handles withou having to specify an fd

 fs/fhandle.c                                       | 82 ++++++++++++++--------
 fs/internal.h                                      |  1 +
 fs/pidfs.c                                         | 16 ++++-
 include/linux/exportfs.h                           |  9 ++-
 include/uapi/linux/fcntl.h                         | 17 +++++
 include/uapi/linux/pidfd.h                         | 15 ----
 tools/testing/selftests/pidfd/Makefile             |  2 +-
 tools/testing/selftests/pidfd/pidfd.h              |  6 +-
 .../selftests/pidfd/pidfd_file_handle_test.c       | 60 ++++++++++++++++
 9 files changed, 158 insertions(+), 50 deletions(-)
---
base-commit: 4e3d1e6e1b2d9df9650be14380c534b3c5081ddd
change-id: 20250619-work-pidfs-fhandle-b63ff35c4924


