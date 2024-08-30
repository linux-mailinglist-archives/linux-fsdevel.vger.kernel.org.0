Return-Path: <linux-fsdevel+bounces-28022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F65966285
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A87C1C23CCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024101AD5F6;
	Fri, 30 Aug 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL8Vnn1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596291ACDFD
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023136; cv=none; b=gQmBYeb3GvsWYUapgCLgjscHPVGJPqPwOY8BRPhakJ6ZmsCDpCwBfRNRzF4auFHZ3W3QRmsYn5KHcDzGcAAMAu6ZA4I+QwqzU5/wKJd08zOCUIvRbBIVOqld8Lu/m/8w9jW2X0m6ochklIzSVNd1aSgE+c8MfoXiZM2tNcpnB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023136; c=relaxed/simple;
	bh=O0oQfQ4HYplz9vik8bYFYpbFWs/i2vnXx0lZJIbCDCo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qWmIpDf7iTXNqUbm1SPumiQuawmij39esns5YILzJ0COH/g1gAHly8EAnZm+mTm8ZUXKd3u8CioMUe2pJxKcCKVajyRMnRUptzyooyNTGlt2oh+DF2VY4O+P7ag7XSxp7tgNmHETRMVDowV1dnzVhWCLI3R/HhDPCAQAWJCOAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL8Vnn1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BEEC4CEC7;
	Fri, 30 Aug 2024 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023136;
	bh=O0oQfQ4HYplz9vik8bYFYpbFWs/i2vnXx0lZJIbCDCo=;
	h=From:Subject:Date:To:Cc:From;
	b=FL8Vnn1DODeP6BCPHyEUjp6yLbfZSmBccmcfzMywAwxYPaSpJwDxXhkPlSjbRDFc8
	 8hLHRd5kcl/4txWvZG7HyGp8NAD+k2bjWWRtJsvQYwrXVU7nkQ9c6RNt9dTMgB7+So
	 BK3Pz2bhrMlaBP6iJgYYoT5g9se/FRvOZGA5FqYd8zhvCJZKBavK3CLoFUa2XZK0+I
	 N3aaV6nRU9oS3a6mc33rI4kxoqwWM9dFhOK5zj7jxOs/Si+skJLrDgDgdJ4JR0zJUd
	 +I91slRAlL589Z6Rki1VERD49XirYcgcdwZOAKbUywQmPfnM07l0wTEJlEGc7fcNTm
	 XLK+YVFlwNpWA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 00/20] file: remove f_version
Date: Fri, 30 Aug 2024 15:04:41 +0200
Message-Id: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnD0WYC/x3MwQrCQAwE0F8pORtpt1LUq+AHeBWR3TaxAdlKA
 otQ+u9mPc4w81YwUiGDc7OCUhGTJXvodg2Mc8wvQpk8Q2jDoT2GExY2ZHkT8rOQ1jkOQx866qf
 IlMCPHyWW7x+9w+16gYeXKRph0pjHuXrO7CsD2/YD0Q6zhIQAAAA=
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; i=brauner@kernel.org;
 h=from:subject:message-id; bh=O0oQfQ4HYplz9vik8bYFYpbFWs/i2vnXx0lZJIbCDCo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdPDyb7evhg0Yn1OsE1gmc6A9Z3MUbPKnn0zmXyfOmb
 8wrMY7T7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIlAzDP61lMpzix1T/fn24
 oybg6kZRs4/vPt0WWTxL4lyOtL/G2fWMDH8ULdMcMna/kLvV7D6N4akKY0tKRgjfL9UCqbWhnG6
 hjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Probably not for this merge window anymore but let me get it out now:

The f_version member in struct file isn't particularly well-defined. It
is mainly used as a cookie to detect concurrent seeks when iterating
directories. But it is also abused by some subsystems for completely
unrelated things.

It is mostly a directory specific thing that doesn't really need to live
in struct file and with its wonky semantics it really lacks a specific
function.

For pipes, f_version is (ab)used to defer poll notifications until a
write has happened. And struct pipe_inode_info is used by multiple
struct files in their ->private_data so there's no chance of pushing
that down into file->private_data without introducing another pointer
indirection.

But this should be a solvable problem. Only regular files with
FMODE_ATOMIC_POS and directories require f_pos_lock. Pipes and other
files don't. So this adds a union into struct file encompassing
f_pos_lock and a pipe specific f_pipe member that pipes can use. This
union of course can be extended to other file types and is similar to
what we do in struct inode already.

I hope I got the details right. It at least holds up in xfstests and LTP
and my hand-rolled getdents-seek stressor.
  

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (20):
      file: remove pointless comment
      adi: remove unused f_version
      ceph: remove unused f_version
      s390: remove unused f_version
      fs: add vfs_setpos_cookie()
      fs: add must_set_pos()
      fs: use must_set_pos()
      fs: add generic_llseek_cookie()
      affs: store cookie in private data
      ext2: store cookie in private data
      ext4: store cookie in private data
      input: remove f_version abuse
      ocfs2: store cookie in private data
      proc: store cookie in private data
      udf: store cookie in private data
      ufs: store cookie in private data
      ubifs: store cookie in private data
      fs: add f_pipe
      pipe: use f_pipe
      fs: remove f_version

 drivers/char/adi.c             |   1 -
 drivers/input/input.c          |   8 +-
 drivers/s390/char/hmcdrv_dev.c |   3 -
 fs/affs/dir.c                  |  44 +++++++++--
 fs/ceph/dir.c                  |   1 -
 fs/ext2/dir.c                  |  28 ++++++-
 fs/ext4/dir.c                  |  50 ++++++------
 fs/ext4/ext4.h                 |   2 +
 fs/ext4/inline.c               |   7 +-
 fs/file_table.c                |   1 -
 fs/ocfs2/dir.c                 |   3 +-
 fs/ocfs2/file.c                |  11 ++-
 fs/ocfs2/file.h                |   1 +
 fs/pipe.c                      |   6 +-
 fs/proc/base.c                 |  18 +++--
 fs/read_write.c                | 169 +++++++++++++++++++++++++++++++----------
 fs/ubifs/dir.c                 |  65 +++++++++++-----
 fs/udf/dir.c                   |  28 ++++++-
 fs/ufs/dir.c                   |  28 ++++++-
 include/linux/fs.h             |  14 +++-
 20 files changed, 366 insertions(+), 122 deletions(-)
---
base-commit: 79868ff5ce9156228f9aef351d8bf76fb8540230
change-id: 20240829-vfs-file-f_version-66321e3dafeb


