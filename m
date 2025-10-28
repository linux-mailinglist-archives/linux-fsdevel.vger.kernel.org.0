Return-Path: <linux-fsdevel+bounces-65880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B00C1396F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93BB44E6EBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAD629B799;
	Tue, 28 Oct 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/qcBQQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE51B424F;
	Tue, 28 Oct 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641162; cv=none; b=A8z8GIqfytHEEt2SOLrEIkJsyhp0jZHQYoy9zrHaLfe8QggiJDatcbulgNZto929h2ra6rgTJApMYsuPO1a4WA/YnY0vY5SB90/1+Bb2bN/hasqLd+nKBGMFG/PVosYw7QHZ1FypkLIviW+d8HzKIyLIqBuZWpPqyy1gLkZrJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641162; c=relaxed/simple;
	bh=XQbnDcr46K2fy3mznM/CwImDsFRUfpiY6hAXCfU9v00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z33gjLgFRUu5ejse2Gj1UdboQip8/ihG+TpgnTrOwubcW3n4GJVBmCn+/E21YMt530VJO1oCg2fOGY13pS1K92fNHixbZzF5Ge6JExaT/dv0w0qN4B+6zwuVpkl3bTkKfW0d514ebQWtbZXCTHha5iXV6w96HxQIpT0DVwF1HiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/qcBQQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346B2C4CEE7;
	Tue, 28 Oct 2025 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641159;
	bh=XQbnDcr46K2fy3mznM/CwImDsFRUfpiY6hAXCfU9v00=;
	h=From:Subject:Date:To:Cc:From;
	b=J/qcBQQO5JiU4oE1J7t1K/yGg67TcdHk5J5QqVeNX0Y3uGZ/a8r8qt8lQsXyukL/+
	 j4+KqUMJZ+zFRVq4Mq++XgIb5E+Ev2noRdpuFzmvLqr4eb1xyiwGexyqd81gjhuLXX
	 XJXS6vKZDtsGhj5FXQsVDa5+XgvV5ghEydaNKXAdt0nzs2xWBh5vWeeXvOKLwx1OR9
	 IPPrHbFnYPWAbnlpaBaug6ywp7/PraZEPFQ050+Frtcb5Wm1ZIsu82ey9D9OqWJj2O
	 pcxUeUOdgv9kEgYA+OvnrKmW3p90Pz87H4+HkkdwhnYOzg+pmXNd0vFv4Bm8GypDYl
	 9IeJ2NPeXr85g==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/22] coredump: cleanups & pidfd extension
Date: Tue, 28 Oct 2025 09:45:45 +0100
Message-Id: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALmCAGkC/x3MTQ7CIBBA4as0sxZDR4XgVYyLgRlaoqUN+Jc0v
 bvo8lu8t0KVkqTCuVuhyCvVNOeGftdBGCkPohI3A2o89RqNes/lpsJchJ/TomoaMt0VWUR9CBy
 NeGjpUiSmz397uTZ7qqJ8oRzG32yi+pCyJ2udoI14JPHGOmccM/eR2UbYti+9VgP9nAAAAA==
X-Change-ID: 20251026-work-coredump-signal-a72203cdf6eb
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XQbnDcr46K2fy3mznM/CwImDsFRUfpiY6hAXCfU9v00=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB20YWY8wuOl+mnmjRI/96OfZ3n0Xvmy4lTohfOm8
 9nUJrozdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykoYyR4fh7x4bQTVGK9vUx
 OinHn1inrbm22MicKXPyvb25vZdsJRj+Cvauujlhot3cna7pIhWX/iStM4hu2xy/RUtX9p3chX3
 pDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

The recent changes to rework coredump handling to rely on unix sockets
are in the process of being used in systemd. Yu reported on shortcoming
nameling that the signal causing the coredump was available before the
crashing process was reaped.

The previous systemd coredump container interface requires the coredump
file descriptor, and basic information including the signal number to be
sent to the container. This means we need to have the signal number
available before sending the coredump to the container.

In general, the extension makes sense and fits with the rest of the
coredump information.

In addition to this extension this fixes a bunch of the tests that were
failing and reworks the publication mechanism for exit and coredump info
retrievable via the pidfd ioctl.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (22):
      pidfs: use guard() for task_lock
      pidfs: fix PIDFD_INFO_COREDUMP handling
      pidfs: add missing PIDFD_INFO_SIZE_VER1
      pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
      pidfd: add a new supported_mask field
      pidfs: prepare to drop exit_info pointer
      pidfs: drop struct pidfs_exit_info
      pidfs: expose coredump signal
      selftests/pidfd: update pidfd header
      selftests/pidfd: add first supported_mask test
      selftests/pidfd: add second supported_mask test
      selftests/coredump: split out common helpers
      selftests/coredump: split out coredump socket tests
      selftests/coredump: fix userspace client detection
      selftests/coredump: fix userspace coredump client detection
      selftests/coredump: handle edge-triggered epoll correctly
      selftests/coredump: add debug logging to test helpers
      selftests/coredump: add debug logging to coredump socket tests
      selftests/coredump: add debug logging to coredump socket protocol tests
      selftests/coredump: ignore ENOSPC errors
      selftests/coredump: add first PIDFD_INFO_COREDUMP_SIGNAL test
      selftests/coredump: add second PIDFD_INFO_COREDUMP_SIGNAL test

 fs/pidfs.c                                         |   89 +-
 include/uapi/linux/pidfd.h                         |   11 +-
 tools/testing/selftests/coredump/.gitignore        |    4 +
 tools/testing/selftests/coredump/Makefile          |    8 +-
 .../coredump/coredump_socket_protocol_test.c       | 1568 ++++++++++++++++++
 .../selftests/coredump/coredump_socket_test.c      |  742 +++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   59 +
 .../selftests/coredump/coredump_test_helpers.c     |  383 +++++
 tools/testing/selftests/coredump/stackdump_test.c  | 1662 +-------------------
 tools/testing/selftests/pidfd/pidfd.h              |   15 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c    |   73 +
 11 files changed, 2914 insertions(+), 1700 deletions(-)
---
base-commit: a779e27f24aeb679969ddd1fdd7f636e22ddbc1e
change-id: 20251026-work-coredump-signal-a72203cdf6eb


