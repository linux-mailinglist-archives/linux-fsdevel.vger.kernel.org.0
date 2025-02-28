Return-Path: <linux-fsdevel+bounces-42843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C100A499AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D9A188FA3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68526B2DD;
	Fri, 28 Feb 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FseFj5NG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A426B2B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746661; cv=none; b=nEqD6fZ3DSgBFyCQUrSY3TTF1rivr9vaJvCv5pvVlKIWTJccKyPMQzGo5MfIqfnp3UadYFyCRE4pp/H7LwRg3H3xklwVhpPXyLPiOi9LVLS90274czyo163FJ+Ssa72oMPzgtwzjPDzbD25uKMaidkU7O+hTLSbqu5p1kTfbN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746661; c=relaxed/simple;
	bh=PiIBLCoq5FZemb3BQZK9kmPEWW5OpN78CSDK/ZgyRYo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uCSh+jy2A/InQGqmbhEWeYrJgpAihtk5lZ68a5/7GzBmirDTaOnWhIHVzhsgyEFs/7mPQbLjZgFg8Cdiz0gxSrWzBKgXf0PcmGMsy6KS67Ncz4uoo8DBdTXi4ynGAw6LR7VjndGxpN0ela2y7xeJD/F4VTveIidKEQu0pjf0EEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FseFj5NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D29C4CED6;
	Fri, 28 Feb 2025 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746660;
	bh=PiIBLCoq5FZemb3BQZK9kmPEWW5OpN78CSDK/ZgyRYo=;
	h=From:Subject:Date:To:Cc:From;
	b=FseFj5NGEsIXEGPIKG+gQBNG/Lm4eL4+16e2vq3/HABc+bxdcu8IqptNQ2FkA/acy
	 CTolX+HQwBWzHbwfat9wcSfH0wV9fe5l9i9meDnfcZsqCiig86BwlL6Xm5ncy9xmis
	 QMxd9qfiKMXWup03SxruI4Ns11sfXCXKnIumcMoSWR9Kah9NQGeV6Kl+Pkyjz6rN9M
	 etim3wfyFR5ZV16cJEWungsW5Xg68BOA5ezS0S9c5M5oXAEKmBEbnRCmPs+BAJn0P2
	 qA9W/BdSB+cqjxoAJC4sCBWkR4IPnOO9ALrfZaes/tc10Zaj/PgXukQG1bi11BiWbb
	 /tgXJiqqlGOow==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 00/10] pidfs: provide information after task has been
 reaped
Date: Fri, 28 Feb 2025 13:44:00 +0100
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCvwWcC/x3MywrCMBCF4VcpszalGa0Ft4IP4FYk5GqHhqQkU
 oXSd3fs8j8cvhWqL+QrXJoVil+oUk4c8tCAHXV6eUGOG7DDvkMcxCeXSczkQhUTxahyUlHXt7I
 xVy80Hp0LKJ05DcDGXHyg7+4/4H67wpNHo/lpik52/NMLU+dW9u2uwrb9AO7VeP2VAAAA
X-Change-ID: 20250227-work-pidfs-kill_on_last_close-a23ddf21db47
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PiIBLCoq5FZemb3BQZK9kmPEWW5OpN78CSDK/ZgyRYo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL+oJVV41uq7L47Y7jz+LimgMIrL+8EiV2MZuRe8D
 QsrU6/P6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIP12G/4UXE62Vcv+Xhd6+
 MXEFe7DwCn1XFq8/CgLln+zz3M4dn87I8L+7IHMX/++bXrJN9X9/v/95fKr/6ooZd+Zk/J/p/2a
 2MzMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Various tools need access to information about a process/task even after
it has already been reaped. For example, systemd's journal logs
and uses such information as the cgroup id and exit status to deal with
processes that have been sent via SCM_PIDFD or SCM_PEERPIDFD. By the
time the pidfd is received the process might've already exited or even
been reaped.

This series aims to provide information by extending the PIDFD_GET_INFO
ioctl to retrieve the exit code and cgroup id. There might be other
stuff that we would want in the future.

Note, this is and RFC and it has a bunch of TODOs/questions in comments.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (10):
      pidfs: switch to copy_struct_to_user()
      pidfd: rely on automatic cleanup in __pidfd_prepare()
      pidfs: move setting flags into pidfs_alloc_file()
      pidfs: add inode allocation
      pidfs: record exit code and cgroupid at exit
      pidfs: allow to retrieve exit information
      selftests/pidfd: fix header inclusion
      pidfs/selftests: ensure correct headers for ioctl handling
      selftests/pidfd: move more defines to common header
      selftests/pidfd: add PIDFD_INFO_EXIT tests

 fs/internal.h                                     |   1 +
 fs/libfs.c                                        |   4 +-
 fs/pidfs.c                                        | 170 ++++++++++++++++++--
 include/linux/pidfs.h                             |   1 +
 include/uapi/linux/pidfd.h                        |   3 +-
 kernel/exit.c                                     |   2 +
 kernel/fork.c                                     |  15 +-
 tools/testing/selftests/pidfd/.gitignore          |   1 +
 tools/testing/selftests/pidfd/Makefile            |   2 +-
 tools/testing/selftests/pidfd/pidfd.h             |  82 ++++++++++
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |   1 +
 tools/testing/selftests/pidfd/pidfd_info_test.c   | 185 ++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c   |  26 ---
 tools/testing/selftests/pidfd/pidfd_setns_test.c  |  45 ------
 14 files changed, 439 insertions(+), 99 deletions(-)
---
base-commit: b1e809e7f64ad47dd232ff072d8ef59c1fe414c5
change-id: 20250227-work-pidfs-kill_on_last_close-a23ddf21db47


