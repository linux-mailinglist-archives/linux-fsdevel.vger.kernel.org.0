Return-Path: <linux-fsdevel+bounces-52496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644CCAE3943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BC27A953C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A8230996;
	Mon, 23 Jun 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGSXgiJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16F1DE4E6;
	Mon, 23 Jun 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669295; cv=none; b=UjWsuqLxGHg8jsmFfOE/PX89AjZ+mtdn+Yv1Gan9+yEb/8BjTiTw6mOrSV913dSFivcO0ztIL+7X5hD51AaYawSEvB/Bw1DH52hf7JNoV+fQns+dbLrt09mHSzWi0eHbtnfrrXe/9bCIja872y828OVJG8ZCnOIJEsQXt9kKZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669295; c=relaxed/simple;
	bh=DkIfK7g//DZEQuDBBY8aQNAlR8thGdiq6y5CQj5O6lo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X3VXMrAndHxYVuLv8GLw5J8qln14hXzr91DEX6yqnzx8I9TID5ZDJ4a83+m/mNYlHkI70PcI8zwnos+FIHJyoE92uZg2tUB+aqKEBJx8B8zrgK+u0DD3rD8uglc1ZI5dx4fPRSS7P1/UnQC1fZuxE6VceZDUMbHvjqPyiP4HUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGSXgiJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F397FC4CEEA;
	Mon, 23 Jun 2025 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669295;
	bh=DkIfK7g//DZEQuDBBY8aQNAlR8thGdiq6y5CQj5O6lo=;
	h=From:Subject:Date:To:Cc:From;
	b=ZGSXgiJprAV5eY4fVjdW7nXYU94d2WpPMKHBcA/s5pOlVDi3Sh0wEMOuibtiDrahz
	 nv1oxzyxltBwYaO1hu6L83PGuaZwKaEhB6KmfwpHYBhl903RXt9kE5AZv5ccgUp81O
	 S1CSRQvxV9mJvHXOj+cLk+T4bj4yVEolJ+dOgv6+smCPaEYxfsbfvdAukWARbbWxBM
	 lKCdIHcy+wZAgbLdmAJ9UqfBdMOyZ0BnuchiZzZzrwijP9J/IKCZq7VNXw0KOzRDhz
	 ntBn5gyGKYssKtnlNmyxDIbMx1w/AIeqn5CzmeHb35iPpDAfzFLOGVqseyMwYfTuY5
	 U/oUiUH1ByNog==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/9] fhandle, pidfs: allow open_by_handle_at() purely based
 on file handle
Date: Mon, 23 Jun 2025 11:01:22 +0200
Message-Id: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIXWWgC/x2MQQqDMBAAvyJ77oqJmmK/UnqIyW5dWqIkYAvi3
 109DszMBoWyUIFHtUGmVYrMScHcKgiTT29CicpgG9s3zgz4m/MHF4lckFWIX8LRtcxtH7rBdqD
 hkonlf02fL+XRF5WyT2E6V6umrjb3+rrAvh8lw5z3hQAAAA==
X-Change-ID: 20250619-work-pidfs-fhandle-b63ff35c4924
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DkIfK7g//DZEQuDBBY8aQNAlR8thGdiq6y5CQj5O6lo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir/2/X4vO8Hi4WSJnbd0a7ytv2soupfvu21rNXdlS
 it7vMCujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8s2Nk6Hv5L+Dr71Ov3axe
 i7gG/W3jT9qus70g5kFi4Xr9pStNJRj++6wvOqUq/y3Q+0TspFt25kb3+xy9fx7nFqgLmXPkZZI
 dCwA=
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
sentinal file descriptor. Userspace can trivially test for support by
trying to open the file handle with an invalid file descriptor.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (9):
      fhandle: raise FILEID_IS_DIR in handle_type
      fhandle: hoist copy_from_user() above get_path_from_fd()
      fhandle: rename to get_path_anchor()
      pidfs: add pidfs_root_path() helper
      fhandle: reflow get_path_anchor()
      exportfs: add FILEID_PIDFS
      fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
      fhandle, pidfs: support open_by_handle_at() purely based on file handle
      selftests/pidfd: decode pidfd file handles withou having to specify an fd

 fs/fhandle.c                                       | 79 +++++++++++++---------
 fs/internal.h                                      |  1 +
 fs/pidfs.c                                         | 16 ++++-
 include/linux/exportfs.h                           | 15 +++-
 tools/testing/selftests/pidfd/Makefile             |  2 +-
 .../selftests/pidfd/pidfd_file_handle_test.c       | 54 +++++++++++++++
 6 files changed, 133 insertions(+), 34 deletions(-)
---
base-commit: 1ff46043a6745d56b37acfc888d6e2b4f4d90663
change-id: 20250619-work-pidfs-fhandle-b63ff35c4924


